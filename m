Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D47C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 12:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stRb3-0003RT-NR; Wed, 25 Sep 2024 08:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1stRb1-0003Kz-V3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 08:58:19 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1stRb0-0008Aq-G3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 08:58:19 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d60e23b33so886239166b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269097; x=1727873897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rQjNcZEiTcKHYlVkJr41nBOjX/ScGLdvVwUCY2Idmg=;
 b=ftUs9N5qJh2Hlxj6vFafiMLcng3DFayqC4UR83rW8NJIFFAUmqMCPNtkdc5eRPkUqt
 kBZ1eAuncnSVz5XEPcXrGztwNpmGtHAXbgHctp4TqejvnInLjbTxGbMk9IEmUfRlAloA
 9SrXW5WprzRwI/SatUuzU0Ub9YG/hl5/R1P4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269097; x=1727873897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rQjNcZEiTcKHYlVkJr41nBOjX/ScGLdvVwUCY2Idmg=;
 b=Qm1grvtHC9rlChC6ktaaN2FtQhBlAGPgz+U3ozx1mvbscz6aSekx1OWXW9Wom048Tl
 9Mf7FH63QcvFjDJNeVda5u3zReOV0VQPpC2hF4l/0g+sLbvwOHB/G1/5EKFtjGuG3ITc
 uuG+MRgt4xrwISNsKDm+G2o0MiVGdRHaPN04w2qM3Pf8YiGO7Joj0gQ31Z9PD6EnrNEu
 Rm8rybDVir0mqI1ofKL25YHwxTX03SQgL9bkZJWTHquCEyNw5iZYafrzzUP++8z7CUrF
 God3tqkWwkXKTsdn8x7cONUC9NxH7bWlNBJm3f+gxEdfW3MBTNLN87ZmneuT073S61DU
 Ni/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMCxLSkOVn4TPanbfkuC/sbqfwUgNHbTEJdEhfz/+FNkGX8FXWg3uNL4Oc9f4xlz5gDI9i4iIE1BIy@nongnu.org
X-Gm-Message-State: AOJu0YxdchKoHI53O8vewP/jCnbag/d0G9KTwgYWAyg7fVUIVWlvw1I8
 w6N/mkrMmlXSX6qETI78lx6hqJNyLadA8b0a2stoZAalLbgXlhFoK2v3+ZhGvg==
X-Google-Smtp-Source: AGHT+IHBItOPKu6vdOYVmZ5ot5QEKY7pZeUzVrEJ4tNLZYsR6UVMsev7+W0x/1YsEm5NyWuW2d0tWA==
X-Received: by 2002:a17:907:3f0e:b0:a8a:7062:23ef with SMTP id
 a640c23a62f3a-a93a03c6dd4mr253839666b.32.1727269096615; 
 Wed, 25 Sep 2024 05:58:16 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 15/19] arm: qemu: Allow SPL and TPL
Date: Wed, 25 Sep 2024 14:55:41 +0200
Message-ID: <20240925125622.197915-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=sjg@chromium.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Indicate that these boards can be supported, so a new 'TPL' board can be
added.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 656f588a97c..dfc735237aa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1043,6 +1043,8 @@ config ARCH_QEMU
 	select DM_SERIAL
 	select OF_CONTROL
 	select PL01X_SERIAL
+	select SUPPORT_SPL
+	select SUPPORT_TPL
 	imply CMD_DM
 	imply DM_RNG
 	imply DM_RTC
-- 
2.43.0


