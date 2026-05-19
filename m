Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DD8CD4F5E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLih-0008CB-VT; Tue, 19 May 2026 10:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLiN-0007u3-SY
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:46:36 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLiK-0007mL-9k
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:46:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so54855425e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779201990; x=1779806790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NIGEOt2zUGFv3m4O6PBpXuGj8ui5ErAdHnNsmYMfOI=;
 b=FyeThAMAO0QO348D058sU1hzv5MirVqA/B9WAP4JIgactDP8CmzgnmuwDsZ7x6BiAB
 TzMCl0LfCGYbYan5RbUKWPQuRy/MNE72naKEXw8QSMemTJ5iVlzkuegzxzvS/cKgIPRr
 qmtsDpUxCUYKeaXA1EKsjgdj5yC378e06Ih4W2R4WG1+NuLF3279EMiHTXUWP9hW8xfv
 tvrNdK1RhELGGkCTvlnn08byUGpr7A71I73eep0kVTJ/7bccCsJkp4VsnF8XBFCWejmz
 BLh/v+fOu2upJkqsq6GvCAG8SF0yNM5noHO95vCgChtadMNgy/9UeAfMwfEaK7ONll6f
 JzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201990; x=1779806790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5NIGEOt2zUGFv3m4O6PBpXuGj8ui5ErAdHnNsmYMfOI=;
 b=ZkpSGdVMSo8SRQjQ2mbId/hXjw5KS9pTTD1uWrlSs5lshezY2Qfdc9E5+epQJ89Sx5
 U9u3/CkiIkngUxZmo1ll6h2sGKSIvtQdRaUH9RDPB2l3RyP1EPe5B76X6uFfnz0XaX2r
 odwMTHfxUK3c/s3pu4+f3+GF8M96l90UQwdAZhdjoh0kfNqtmqy1ZWMU6k30OcH678Wz
 z3G+LJBmn/9Bu8czAlLCvud0sP1f0Fu7Rr3mQfm8/q9CPWrqRyY3Py+alac+0ezpi6ae
 //O5ljWGBnX/8RS+u2AhE3iUUaiIcJX38hd4eQ6fBvU6zLMmnuB64yxNDr7zzJncWHxa
 nw9A==
X-Gm-Message-State: AOJu0YynHIuL923iEZxwWG1l7PLKKrzQcu8kL17UKjtwaA/X3mZO6Uli
 tvsYUjNC9Y/o0gY3XivkIEnnPS3l/rHLE5Oa61qaPgkIiDKvCOvF1IHDX1mBUCbBysWe29Yp4aX
 EUu7w3Q8=
X-Gm-Gg: Acq92OGJT9I36vEnwhpxEMtpymY7GF6qE6Dn7nkEs/Au6Rv505eUqpyKlslJ5vPCFz3
 wQtP8J311PTvXyyj9np9lf6EAFQPbkqDdiaD61MJNG7xtnGsRTbKfrBrVhA7qzcmLenIm/EWjFb
 DUMhSeD2Fy30zxdrmlY/zYOySjY+0Pyacy5+16KzrDG9VRyl4uQ1WDVbiKcPHHI3UXWph3yiJk+
 MbhzJykzmMYCxzDC3c2di+kg4tlnVJgLLDYOsw2w/VT7gYRrwvyqttXcvy2n+NtatTPQFRXZwtp
 +EeX2g0SO6UQg7odaqBPp6B31MDunT20rySsCL7pO+aZiY1ksoebMM76H+mneWX5ouvVCL9VrJZ
 vzWh8QEF/SrxBjlyzm/6aH9GlBG51CC3JafVEblZL0ReeHqBV6dIunTaw3Lr1E5XS2A/iu5A49p
 mTfxTznBmpV5atncFGTFh7wWynPjmDbMnLnNrFm9z30AGZ1JB40aY0+1oaZACrQcWa8XseYQbI
X-Received: by 2002:a05:600c:528c:b0:48f:d612:3c6e with SMTP id
 5b1f17b1804b1-48fe60de745mr303191525e9.2.1779201989726; 
 Tue, 19 May 2026 07:46:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c8d39esm336102715e9.7.2026.05.19.07.46.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 07:46:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 05/18] hw/arm/aspeed: Build objects once
Date: Tue, 19 May 2026 16:45:40 +0200
Message-ID: <20260519144553.91483-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519144553.91483-1-philmd@linaro.org>
References: <20260519144553.91483-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Commit 064f1ce95fe ("hw/arm/aspeed: Split AST2700 EVB
machine into a separate source file for maintainability")
remove the last TARGET_AARCH64 use.

Now than Aspeed machines can be filtered when running a
qemu-system-arm or qemu-system-aarch64 binary, we can
compile the aspeed.c file once, moving it from arm_ss[]
source set to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 144e4827660..7c3d66f4378 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -43,7 +43,7 @@ arm_common_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'x
 arm_common_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
-arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
@@ -66,8 +66,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_gb200nvl.c',
   'aspeed_ast2600_rainier.c',
   'aspeed_ast10x0.c',
-  'aspeed_ast10x0_evb.c'))
-arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
+  'aspeed_ast10x0_evb.c',
   'aspeed_ast1700.c',
   'aspeed_ast27x0.c',
   'aspeed_ast27x0_evb.c',
-- 
2.53.0


