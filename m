Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41B1C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7tP-0005Q0-Ax; Wed, 12 Aug 2026 08:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tG-0005DE-4B
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tD-00009L-Rc
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so7937625e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537018; x=1787141818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OJwnVGJOp5YThs7oLPg16ZMm61BA/rQ26EmJaeQg1HU=;
 b=cCmFB2mpYDQCZneg19ekSZqzR+Ao0lqvpJTBGdVRFduCKf/fiEYAChFEHk5/bSt38I
 t90jxLDGwtN5R2+tgh7+LYTfRsfpD+ZnyBECFUXx0gJiq5AnPLUylHAanze9DQ3NKIjM
 aFvl3zHSzS0pAMmBlNj2qtHM6zaCxS3EA3oOEYhrZF/8/0Ya0eQuKXwtbpp1lhgaE5z0
 8EJw0n0Hatr+fE+IAWLARzCWBczUMnN9RTKtSVuOu0T6ceuAHOlFW6PEPsUqEI8j2mIL
 7TUzwfJ1Sk8Lv6LbfsQRL4b+W5l3NJbR9dG8gLLnDCrQYR8mKnVzRJB3Od24GhXAjZDi
 Y4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537018; x=1787141818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OJwnVGJOp5YThs7oLPg16ZMm61BA/rQ26EmJaeQg1HU=;
 b=bDWQXqnEL1J+0cox5hxDbZ/Hc3hSUANOi6CzzAWPoDhj+Vut+9UiFRKXrTSRsPCtfu
 vZk0YrOHTeXbBOSVsnUlIjB4+INfQZTcqvSAghAQ1AQbFT37TCDYxVq4ghNxooE7Ebx3
 2PKBX1YmGniClouql4pInPWtpQ48FL8/yg/qD/TtEu5Bes5nOKrdhzxWcabLHiUlIdsC
 YQzUQTqwbJ2iwI3ywGsC9wScb8FlMZQ5wNTEzjAxziHl+3ASMUAqmlfglZgy3nrMgJSy
 5ZZnTNL7o9XwZUN0wxvx68qJfeVlpAIUlM1+O0fmjlN+r5xFLZ70RGjW3StfzjV+5kZu
 sCcg==
X-Gm-Message-State: AOJu0YxhR9ns22J4ZQ/k6eT5gkWzR9fLZg4rAQhULAw4NplO58wMX4wm
 VJzE3UUkzUMjd6piiFfN0g8qPTvVgHvzHO6w5ch7dCc1Q2RTCw44IUx7fgZDM2A8sPPRBv1/+dm
 OsIiM
X-Gm-Gg: AR+sD12Yc0h5vo/O21MZniwxnFNdoa/IgiDOSzTdBMOcLgMcUFqeeQ5ACsCO0KKpT8q
 D1CgbxbnlIGQ8RGm3S/FGDbX0MfYZXyqLXjzPg/srb5+oGu6dm+xgEAko29uH+Demw1Vpg9qwIR
 DJvyVMSQnikBJ1ynclP495gDJzY9oFbvrypg853AzwEdve7skkMACHXF2sgPdh5s/b/OU01Iv+c
 U8cZ5zbPSeqnZLGBOLccF1lJxB1o421Gz8bX0NwBfHqsrbDuPMIbIO8rNdo2ZyL+Heb2ySNcTzo
 EgdKEUUzonZCfsRTQS30CDMaO6XkuiFcUexuoDakMjbjc+A0vajk073gBwYTPawP8CH6Pskwvu+
 jHEygybft11z/pqhojbd+zZl90+2aHysopkY8Zax1tc9Yqb96Rg96Jlb8IOOxSjn+Haz9/03sIW
 orMWHgE0iR6ujaVZc1kC2DyfB+EFJciGPANCRoihxD4LRA73nVk6Ud6zSuwZVllnpBf7NzgiUo7
 xy/YUX+GMQmYn02JBsJvnUDg3kBK8D5Wwa5XjUXVSLqwRIvu1IIUL4vmSK0+86voJ2hpA==
X-Received: by 2002:a05:600c:4585:b0:498:ee7:e40a with SMTP id
 5b1f17b1804b1-4997c153b58mr59418915e9.16.1786537018381; 
 Wed, 12 Aug 2026 05:16:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/26] hw/arm/armsse.c: fix SSE-300 PPU addresses
Date: Wed, 12 Aug 2026 13:16:16 +0100
Message-ID: <20260812121622.649730-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Simon Xu <simonxhy0404@gmail.com>

The SSE-300 CPU0_PPU, MGMT_PPU, DEBUG_PPU had the wrong addresses
that were the same as the SSE-200 addresses.
Page 146 of the SSE-300 TRM defines the addresses of the PPUs.

SSE-300 TRM: https://support.arm.com/documentation/101773/latest/

Fixes: 8901bb414a24 ("hw/arm/armsse: Add SSE-300 support")
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Message-id: 20260805191257.11303-3-simonxhy0404@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/armsse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index e99b491bd9..55fbc2c290 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -452,7 +452,7 @@ static const ARMSSEDeviceInfo sse300_devices[] = {
         .name = "CPU0CORE_PPU",
         .type = TYPE_UNIMPLEMENTED_DEVICE,
         .index = 2,
-        .addr = 0x50023000,
+        .addr = 0x58023000,
         .size = 0x1000,
         .ppc = NO_PPC,
         .irq = NO_IRQ,
@@ -461,7 +461,7 @@ static const ARMSSEDeviceInfo sse300_devices[] = {
         .name = "MGMT_PPU",
         .type = TYPE_UNIMPLEMENTED_DEVICE,
         .index = 3,
-        .addr = 0x50028000,
+        .addr = 0x58028000,
         .size = 0x1000,
         .ppc = NO_PPC,
         .irq = NO_IRQ,
@@ -470,7 +470,7 @@ static const ARMSSEDeviceInfo sse300_devices[] = {
         .name = "DEBUG_PPU",
         .type = TYPE_UNIMPLEMENTED_DEVICE,
         .index = 4,
-        .addr = 0x50029000,
+        .addr = 0x58029000,
         .size = 0x1000,
         .ppc = NO_PPC,
         .irq = NO_IRQ,
-- 
2.43.0


