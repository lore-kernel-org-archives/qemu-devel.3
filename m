Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FCECA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5CX-0002xq-0w; Thu, 04 Sep 2025 04:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu5BE-0001Ld-Uh
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:18:54 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu5B2-0008E3-Fv
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:18:52 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-61d7b2ec241so850090a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973917; x=1757578717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAGwXDyF/1AKLx4R1JOMrgUV4/JTqtegj/R8YLcIDOA=;
 b=SDjFisJa8gObiWwulJG/bCdjBmJ8iZ7eR6EVQ1tOtCVyaSH8b2u2S8TbcDUD898Fny
 ioLhs7YGh1nKeTV9Sz0eeYO9Ea1Ww7arLvHmHa4V5q9cI0Q4WiHI3YlWE6TIR44aYabh
 2C+QuoHMCooZiz8j0q2pNr2txnNC3g7TjlydTyO4IJpf8tXArkYwBAxDKC1BC7JjAaSY
 BtL5+tvciM8ze0gtYy3iFthrbr2g1amXeIZlmsCVLCCbW1fCaW0HE1cR63a8OgnR1eZY
 R/BMKp4B/24Y26rkP9NOJPlhLxoxPN6Pvg8tRMNA5Y7GZOJ3GR4h/rhAkzmEEkIYCA0l
 zrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973917; x=1757578717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KAGwXDyF/1AKLx4R1JOMrgUV4/JTqtegj/R8YLcIDOA=;
 b=fhVSq9epHziHF2gCX3/HtjmOwaT9dFCbw4Sc6jETex5u6AY6gBsJMmXHBlIzQQqaIY
 ELCg4w1mvU8MhL6IPaP4EAV2Hv83hXZyYAMyhzppqh7YnfnglQFyPY3meKUVpANT9wRl
 TsM7tAlyj4/IAFLaIjKWvd0sxfE1NzjBse7ruYaXc6xmp7vslcuMsBABvoDX7tCJKtfL
 5BU5CJRxs2eSrL4OZFhhbyDZwP9bepDHTb6Pi9SgMjg6P5ziE0MWCyDjNuqb5raLFxi0
 vygzpssI/SZ0rYpsLWphXsZuaq1k93bdnCEoY4gmuMtwJX9xuuJdjFp6CEHn9KB+BhD8
 rjhw==
X-Gm-Message-State: AOJu0YxQNCrohRBZxpnAh3ajEs5XAihfTBePONPyngQNzWHkP0cvPXVl
 MesigGsOZbqbA9iVhnAIwcDtjW75m//szU5meIlUBFQR6Qzr84vLSTJgTMvBhyVsL8kmeA6ku+G
 pvjbolpvHWA==
X-Gm-Gg: ASbGnctw7gvz3thxpBbVvtZL0/RXDF2bXVfJVnAwlPbD54+vzIhRD/lH9MAJWo84fQX
 QeRaOPSbrbvclLjTKYAezFPNHboeCLZ477tB61/BDPmgjuuABNmSatgkcCogHRSFhV4X4+GOInm
 u1AOP0S8h2MYuRGQ/B1qVlkVGEhZqIT2jz/mPqFnBazUzRBhP0sG0Enw1a42KjDLkQo7R7YPeAe
 ybBFE6MJy3It7IjVG8JsoL4dYqdgB+busMwoc512WtFgqcy2OUy8tHeaa6fcHPLpKuPZIW4MTI1
 jW199nZTIVJ9Ye1b+lUD3X2HDbIQKFh2pwEaTCLFdHR8zxAkC2GyrY42Md6mgZt5I2XxyIkdTdf
 OnBPiQQMYC9ju2TaAbeQpIcIg9gtc6YfVRg==
X-Google-Smtp-Source: AGHT+IHQyUWubqPeLJ0M9z9vTQ+5D+O2ikTNYs3CHPwgi9fA0khEhQI3cpk36+oHIaMoZR69w7S6OA==
X-Received: by 2002:a05:6402:1e90:b0:61e:c5d4:1435 with SMTP id
 4fb4d7f45d1cf-61ec5d41547mr7877369a12.19.1756973917191; 
 Thu, 04 Sep 2025 01:18:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc575b94sm13125903a12.53.2025.09.04.01.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:18:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5AE7A60AE4;
 Thu, 04 Sep 2025 09:12:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 1/4] hw/arm: use g_autofree for filename in arm_load_dtb
Date: Thu,  4 Sep 2025 09:12:16 +0100
Message-ID: <20250904081220.1944461-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081220.1944461-1-alex.bennee@linaro.org>
References: <20250904081220.1944461-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The function has quite a number of exit cases so lets try and clean
things up with g_autofree. As the fdt hasn't be allocated yet we can
return directly from the fail point.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/arm/boot.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1e57c4ab9ee..5d708255df6 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -553,20 +553,18 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     Error *err = NULL;
 
     if (binfo->dtb_filename) {
-        char *filename;
-        filename = qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filename);
+        g_autofree char *filename = qemu_find_file(QEMU_FILE_TYPE_DTB,
+                                                   binfo->dtb_filename);
         if (!filename) {
             fprintf(stderr, "Couldn't open dtb file %s\n", binfo->dtb_filename);
-            goto fail;
+            return -1;
         }
 
         fdt = load_device_tree(filename, &size);
         if (!fdt) {
             fprintf(stderr, "Couldn't open dtb file %s\n", filename);
-            g_free(filename);
             goto fail;
         }
-        g_free(filename);
     } else {
         fdt = binfo->get_dtb(binfo, &size);
         if (!fdt) {
-- 
2.47.2


