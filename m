Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748B6CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpv-0006gu-2d; Fri, 10 Oct 2025 09:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpq-0006V9-LR
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cp9-0003wg-Ty
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:01 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so1729070f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101574; x=1760706374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+8jceCDiRONn0TjKUE44ua6cHHKQ5femih0Xr9aWkgk=;
 b=RVvw+MUEDznlWaRVJHiq9jpia8PIGCpk/LR+PiU1TbFqJKtokEEAZNCqMB6KeJ23yk
 9wgl1Cfucdewv7NNeLnYLe/3cIUlsKZ9AdA0M0UM3c44Bj7ksIfcP6W8OfgxQq89d9TP
 w3qJ1dwwQ0daxURrps07uqfWD8aJBXgLHPhRxBqRtpXwWOZYrX5P8C+lWhMi1ckLjAe+
 UDwe6w/f6amMDs5SxY85eZIdq5K+b8v4qs9K4Iku9SuFoUgwu6+igr2iTbNgvivTaIhC
 KL11drkTMs+GQUTT1euT757iMFapt5Ud2LhM++8LkDYLSqlGgVjzGlKv/4vjOsqCoNSX
 C0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101574; x=1760706374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8jceCDiRONn0TjKUE44ua6cHHKQ5femih0Xr9aWkgk=;
 b=lZp/AfWB3QZM7BmSXcSfS3qbkv4zFnpKLzv9WpdZrcLPzZJ7kiN7cTHOLItMhssnt9
 bYuALyvB5sSmuFgl72yQyHUb34p5e3XZf/yXh/grPf2FXohhIiQfDq+YOTbgt4fYYWP9
 /xHYpX7R+RxrQipCdf/JQtPfVO/s0DjK7nRwder2qj7N2nSSgA+LVZ/h75xCLgOYD7Z3
 VLbRj4QU/gEMj0/2rMbndhSy21xKuumub6XpZoj1K/hDSF/SVk5vJNRc53ADX0V0+ZS2
 F8H825akpOMzFY4kQBEmbRF8smvXPjitqCls8pKQW2BjsjY/gJRGGPwwpkldmPZ/ybdr
 XeHQ==
X-Gm-Message-State: AOJu0YyLOFDJCY8Fx56PRxm/EH62JZUGSUDfBLeJtNT5LvJAF3Q79kRJ
 LkRfggraLKXRwpHnl0rcikX4CHnpPhomf00sW9imMkXUveuYXiWOxF6kyQ2vYnc/VczMXOTIJ+z
 AUNsf
X-Gm-Gg: ASbGncsswOi9K8yyMALZqZVOA4sJ+u+YwxQxyfkOzqVfLvHAU27U14H4l7bmDeQw8UP
 YcE2Yw/7nMizXKN1taRL0Ll7M3qj02jSSG4C8nlK7lm5ysq/HmzAAV3D3gjCn500MtnF/bhLsXX
 Qr0hUCsvsSXjFCvHR8ceYwA0m6r/m5E5Ar3rAEl12yy8qMGUvOTTfqA8Z/KOKIO2zLwEUdfCneU
 +ip6WeOgZQMZpICsxQ1TD02mMOGytvGcaj+MNlKzxdkvsexghD2HX5ZoqXDd9W7Xb5HpbbLdvJA
 jQ3YIyiCvKFsxz1jTmtogccPI5BNiJua5f31UIT+oOA7YL589+1GzdW7WMYuDGax+GRNcebyaZl
 lXcUva/FrzubzF4zrTb2lNPXwB5+VdGd8scWTX/DQOEE5igJqLwdI6o+gUV2dsQ==
X-Google-Smtp-Source: AGHT+IGxZ+WS9BfrhqvxH3/RvtgowMEhSuGSv7RYfCRlnYmlIfcif9bfEjvhTa6BcYJXZxJcErbjSg==
X-Received: by 2002:a5d:5f48:0:b0:3ea:dd2b:5ef with SMTP id
 ffacd0b85a97d-42667363e68mr6119464f8f.18.1760101573916; 
 Fri, 10 Oct 2025 06:06:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/76] target/arm: Use arm_hcr_el2_nvx_eff in access_nv1
Date: Fri, 10 Oct 2025 14:04:50 +0100
Message-ID: <20251010130527.3921602-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251008215613.300150-40-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e397fe75bd1..2875f0ddd2e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3427,7 +3427,7 @@ static CPAccessResult access_nv1(CPUARMState *env, const ARMCPRegInfo *ri,
                                  bool isread)
 {
     if (arm_current_el(env) == 1) {
-        uint64_t hcr_nv = arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1 | HCR_NV2);
+        uint64_t hcr_nv = arm_hcr_el2_nvx_eff(env);
 
         if (hcr_nv == (HCR_NV | HCR_NV1)) {
             return CP_ACCESS_TRAP_EL2;
-- 
2.43.0


