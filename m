Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B10C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdUF-0001v5-Kg; Tue, 04 Mar 2025 20:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTv-0000vv-1D
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:31 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTt-00075s-8U
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:30 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bcc85ba13so10403895e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137807; x=1741742607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zYIkt9GKGIYdkcKWEhjNfLJXtEaeim06qAhvggPTOw=;
 b=MEBVe2ZV2f2gZbAVC+RZBjJGmSh/7ixmfUkjzrECeHDDwxXhYeJRsrrhIwOWGAdvId
 imi58FtR7XUvujqMVb9YVIVoSSwdNIZ+OAePqsdF+q3spENY8Lef64qIrKH/tQY6BKtU
 ECb4Xfv8oc7sYY41pAllzeEgpwPfAL/XVZgeoIYx/pXBTyN5Mq2kV5FvFYNi1qZWxMOu
 j6jaQHqAIuz6bhjjY7hLNwnvXXDX+tI2DIqBKguDeOurvYPZuSIfS/UOb5mJ/zZtJ4MN
 H4USQTU/VfTgdrOzhtmiRs7gT418Gj9dAAZfYOA+gDdzQU7f38E58Uj3nACC1z1HT1mS
 MReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137807; x=1741742607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zYIkt9GKGIYdkcKWEhjNfLJXtEaeim06qAhvggPTOw=;
 b=wm0qoOV8sbXyz7PKSuaDyUj5LC/hMay+N67/pTCvM03vszrtmrxA8UL8Yc3zyIEaaV
 1sFiUB3b1mXgjyJq0/2TIiFmDHqwRtH3h2OVfi6vX1qARY9anmr65sBzdRFy1tOf7pyG
 WouxLUiWJQ7t0arQkWTXrWvr+LSJIN3JWrf6vWSyKIaPWG6wcSupovti9Ug/qYS6ouyt
 S1mAwNagDhvFJHRgdPiSoqVw4k9td0mxCfAMl+zQDDkgVfg52ioPcQrxuieI08hYnvo8
 9EAATRpavAe3Lpz6EV9scgYvfQCLZdgucA/4U8YdbOhTJ2ZvZjnXR1jO1pG9mRHiaKlq
 Gctg==
X-Gm-Message-State: AOJu0YweN1f18PMjKAg6kDchU90Xlvs4A+gl8UeRv4uQv4zbjfxCwpwM
 yFLSCPxHVeA/TA4OW3igkr8zqxNhQBMVB1o4lJNF6xEEWH/MG+ircxEuTq5ombgvdUu6OIPO8Oy
 SaGY=
X-Gm-Gg: ASbGnct6Jea7lTRIR98MwIj0N+BsIjNl/CC6Igd1ukHXlzxDIQ/dOzwW14SVH/XJs7E
 Jo69vt1BbSi1WiH8hoGJrFq7selytDVi8/CNnWRmGaaRM/k9zotnDVREBKBw4JnZxaPmD9o53Xw
 ze9p/khDg8nhTAV6SfCmBIjlwPm6yTSs/bJNfa3OCJf4S+4430NynibUW6NSpexHSyzmd0EwOBc
 NYTioLRLTlWH8LxHqp+GYqks2bqYYVt24zUlXlwz5FVyjo/rYAkGYp+2aBquBElt4X7ZuBavx4j
 asFwrI3/bCd1KyDMg8UlhebROhj+Y+rEp5oHDVA/kirEHBr7PqqMqcg0WkWrgUfIg2KSB1NjCfi
 RoSnOYHPm5KGm8qr7cYM=
X-Google-Smtp-Source: AGHT+IHtA/bag7Tdz6sdGvjgZ7CrhAe1pi8OSdo8brr0CZx2FAnemKS7xQOTu2zUSNdl6rekkLaacw==
X-Received: by 2002:a05:600c:4ece:b0:43b:c94d:e1e2 with SMTP id
 5b1f17b1804b1-43bd2ae54bcmr5223275e9.25.1741137807422; 
 Tue, 04 Mar 2025 17:23:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426c01bsm2058145e9.2.2025.03.04.17.23.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:23:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/41] hw/net/fsl_etsec: Set eTSEC device description and
 category
Date: Wed,  5 Mar 2025 02:21:33 +0100
Message-ID: <20250305012157.96463-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add description and set category for eTSEC device so it shows up
better in -device help.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20250218155407.838774E600E@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/fsl_etsec/etsec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 3ce4fa2662d..adde6448926 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -423,8 +423,10 @@ static void etsec_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = etsec_realize;
+    dc->desc = "Freescale Enhanced Three-Speed Ethernet Controller";
     device_class_set_legacy_reset(dc, etsec_reset);
     device_class_set_props(dc, etsec_properties);
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
 
 static const TypeInfo etsec_types[] = {
-- 
2.47.1


