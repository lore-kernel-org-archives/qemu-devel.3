Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3284DC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpUZn-0005hW-Rh; Wed, 27 Mar 2024 10:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpUZi-0005gb-LD
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:48:23 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpUZg-0007Ci-AH
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:48:21 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-515b3077d09so2493250e87.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711550895; x=1712155695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPFWloXvgUVrfOUQsGsillp8qgj3+ANZPZjro9EyK/0=;
 b=Q1X6fWnBQd8oOJOnogpCBDaBXqqjgTonS/8dJQ6/+N7RTNqf6YUZwEdlWtZCF4BV+B
 YQQlHdXlVtMfE3D++qBo//MJ/4Qae6zhO4YoDMGG60VkOfPEAzDPtB5opE2EvPthPXPP
 2HGMHT/7ozgw8hfPENWJKONnXTweJsEMTVid3x0QTD1jNR5qcK1EIPVL9wwdlCWvYWQ3
 u+GeeK4WNM3ThwDPU+baw8PBzzfRGXFqt4WN/OlKODnOJxY7TSXeyhUTuA+A1yVsDQMs
 uoZMRSHQemg/pO1I248BHNk05mEf6PfSh8/DeWjLWNEc5wD9ojAChzVWjRfm3mfrESCy
 bQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711550896; x=1712155696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPFWloXvgUVrfOUQsGsillp8qgj3+ANZPZjro9EyK/0=;
 b=pQPhmIESSp1W3Pj026XfBxrLVhfZJmWUBYWVcKLiiuIId6qbw550bct9g6hOnHqFyY
 xli6oyJOtbLscZhVZ5zpx9++ew8SH1Ccq4ERQxCft3Wpzy4AkNILrrsMz7qJETOOlcKh
 +mtDBXWrv25TSjRiNoEvwN6iJSEyKrUUhA6NMhnNSMjXft7VwxRl5ZSXS79xGrCPnRb1
 F4f1XbA7rblQwkAlyGJYW8HfJPjH7ajpfsnSsrapnbccuIMp6UniG8ccaPZxHnL3j/8e
 zuGIZaGpZXZN2FZmgMLZvBu+umUQdeWlsHmz09v2e0PqadbNu1yoXcWUl0a57zGh7yXP
 5P8Q==
X-Gm-Message-State: AOJu0YwiflHShSOpLXBercIM45si6A1epI3DHiDUUFunCgUcrfDCT38l
 XSzGBRdwAtUV6YRqDME9ioulnwbbj0LRKMYZPjX4EEUMOoujoPKvprCbpsxGezFuE0syIcNucZQ
 1
X-Google-Smtp-Source: AGHT+IHHnoDsU7neBHbSpLdnWblXQzyhkyUCh8tUANmkG5JewpnOCGcp0BgeVtJkMSoMLxZbXoVW7Q==
X-Received: by 2002:a19:4359:0:b0:513:c9a6:46ce with SMTP id
 m25-20020a194359000000b00513c9a646cemr1204910lfj.9.1711550895637; 
 Wed, 27 Mar 2024 07:48:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 bq15-20020a056402214f00b00562d908daf4sm5406653edb.84.2024.03.27.07.48.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 07:48:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Marek Vasut <marex@denx.de>, Laurent Vivier <laurent@vivier.eu>,
 Chris Wulff <crwulff@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH-for-9.0? v2 1/3] fpu/softfloat: Remove mention of TILE-Gx
 target
Date: Wed, 27 Mar 2024 15:48:04 +0100
Message-ID: <20240327144806.11319-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327144806.11319-1-philmd@linaro.org>
References: <20240327144806.11319-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

TILE-Gx has been removed during the v6.0 release (see
commit 2cc1a90166 "Remove deprecated target tilegx"),
no need to mention it in the list of "supported targets".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 fpu/softfloat-specialize.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 1610472cfc..1c85c48a73 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -152,7 +152,7 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     /*
      * This case is true for Alpha, ARM, MIPS, OpenRISC, PPC, RISC-V,
      * S390, SH4, TriCore, and Xtensa.  Our other supported targets,
-     * CRIS, Nios2, and Tile, do not have floating-point.
+     * CRIS and Nios2, do not have floating-point.
      */
     if (snan_bit_is_one(status)) {
         /* set all bits other than msb */
-- 
2.41.0


