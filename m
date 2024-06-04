Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24982C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQuU-0005Y4-VH; Tue, 04 Jun 2024 05:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuT-0005XQ-7Y
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuR-00025q-Nv
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4214f52b810so5715635e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495010; x=1718099810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hob+P2Sg+ihzbfNnyrqDcUFLAYWTTSYARygSNcUTJO4=;
 b=j9tCm+Wm51aG9HL1/qRQTo31h1jQ53Nux/3nFAMQu71FfcrEd6GpIraFRpazo7rgOu
 9qpBVnLeIezJX20H3kiHyPgWh6rEh3Vohh0p7EKJvKVlhH89XkDot3RTj77thqM9cxsW
 ukmLH3dmDEd9AW4VRgT/9hmSJir9FAmx1j1KkyM2+xeP/R3Q6d65/TXehu0+U68LQ/Gk
 YNNiKWYGt0KIYK/6rJFkGK8JQGvJz/cnfPP8Er0qk043a7/gTSRAxfAtELWiTCb5gSx0
 zNdGwGplzSMiZAAAcgw9m5+sPAOo3ZTcPhAisDmwhVttjPGdCGZoz27jSrhciBrA6Eu1
 hBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495010; x=1718099810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hob+P2Sg+ihzbfNnyrqDcUFLAYWTTSYARygSNcUTJO4=;
 b=sqbFQFTOdr/ycHd54V8WSoHasFeR1IUGTn7G0tyF+n0+DIE4dz3CMRBxfP8ObR9FxD
 rNmT3bfayveB1rHy8ab3ozl3mPrhDwS95eUXMop5mkF6S4dTAT2p9KfTHw7pEXO6/iKG
 FVLJB+LYZe26QWkHlLwz0i9XKVAaoyR+e7yvwkFStoFU6djxAmOvRIO3NgG5EdxCBbCO
 l3tAAGHCn1hQ9O1CLLVC/OsOwTIF+kb7iP6zJZJerfOX7nWJ3n1neLeThDCQEjxfyL0q
 r0NAwViSZejQG7JX3rMf/WQcO4oxmOs0pGWnPsvELflt50omUTrpa+jmSnBss861qHpP
 iTug==
X-Gm-Message-State: AOJu0YyEkxhzq/HY3CDVFis5IiePyMjznOzDZF5mmcV3yYF194nLiDgD
 q/o9e5VWpMoFv469onGI0k4WkUf9akMBbfZPYGhLgRwgz79ee7oVqQ7xAW1wcxF6b6DyW1gv2JJ
 O
X-Google-Smtp-Source: AGHT+IFk7VVvgi/EwuzktBTb/DDMNLfi9oY40NMURF6XYYaKnXP/ZL4PBlcB6PrOt12Vrf5S6PznQg==
X-Received: by 2002:a05:600c:a03:b0:421:499c:7039 with SMTP id
 5b1f17b1804b1-421499c71acmr20096295e9.29.1717495009779; 
 Tue, 04 Jun 2024 02:56:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212c0fb7c2sm145029725e9.26.2024.06.04.02.56.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:56:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/32] disas/m68k: Replace sprintf() by snprintf()
Date: Tue,  4 Jun 2024 11:55:43 +0200
Message-ID: <20240604095609.12285-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240411104340.6617-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/m68k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/m68k.c b/disas/m68k.c
index 1f16e295ab..800b4145ac 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -1000,7 +1000,7 @@ print_indexed (int basereg,
 
   /* Generate the text for the index register.
      Where this will be output is not yet determined.  */
-  sprintf (buf, "%s:%c%s",
+  snprintf(buf, sizeof(buf), "%s:%c%s",
 	   reg_names[(word >> 12) & 0xf],
 	   (word & 0x800) ? 'l' : 'w',
 	   scales[(word >> 9) & 3]);
-- 
2.41.0


