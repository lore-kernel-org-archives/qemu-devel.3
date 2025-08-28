Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9349CC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau4-0003M2-UX; Thu, 28 Aug 2025 07:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau0-0003IO-S3
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uraty-0005iW-U2
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45b7d485173so1537055e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380884; x=1756985684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Iow63uqXZAY75W+e/Yf2GGnz7y0LeqIPIqHaXt7y/f8=;
 b=sMB1RiOAGgjsQhKq8S0HhANljkxiikxpjk9Pj/26RkHYY9k1Fs7cYDcspwgDb2eR+/
 D1conL0geG5OEeOaQ+vnBJpkRIrQs1Wdve9TdXdxcC+iEL1HEcTwF5SrLqc6713oHPvv
 8vEKxu+8/HBYVHLVfe888HDg5zT8a25UJsi2xEuV+RpjBBuzC9xdKOjgdzrNZo1SzUXC
 uG9R2HtneV7+D7OVc4m4a0sF+rVSZsMQMy7mUczikGKRthH5OC7CKCTr46MyibWqe+XE
 3YWd4LQUjHuG1u4mc23JztGpHmRnAayPifYn2mHRzFv91yygbvrn9/WSfqIILewAvcv2
 jQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380884; x=1756985684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iow63uqXZAY75W+e/Yf2GGnz7y0LeqIPIqHaXt7y/f8=;
 b=LoPw0F+boOvyoPixQtLG7yyQ7A0OVgCA6OGglarqnoCbHUUWkk+4WC3LhmIPBhEL6+
 LbiVpy7LcL0F/tNMRcuCntr51Dze1De3O/YCBWaT/WBkz3Z8Ve42rFKxSebCyH3W9O6L
 86bC6jDYSdZlMunScn0ejVc/i7vxnYMGWUx1NOH+MU4wBI8cdSw9Ymz9CgZM4jOO/Lmk
 n04SAsC6iH9I7ZNUeK8G4pqzrj7aVYzhZuiaWxNq9Hd1be4VDON5fSu6r/XZKGpp3WuH
 v+CSUWkhkKS7GVRil5De3OUA6Bycad6mMSkapTqq4qMIO5Dpr2n42ena3P1pXPmNxutQ
 hwNg==
X-Gm-Message-State: AOJu0Yz/J7X5Y4RVWmivcOr3YvNxkItTiOq9YGKycGeeo1X21DU3gdS/
 JHbfjISzx+wn0nDPmWKVGWTX9Goedtc1GeHD38cx1X+q/3bBaRxcPoatcgt5khRyI5pQUm9Sf5G
 euQeb
X-Gm-Gg: ASbGncsd2ghG2rBEg6MyVkextTH6UUIfaumjuUGEnk8GZD8vplsl3PwUl/lImElLGij
 z7TGIQOUFARrGHtwMvrYsHEk6vmriD79BVmWjIF/bJ3j5iYuOsdob7L2aHbK3irZVNk7+n5UUFq
 jwDeD730VFzJf+Z2s7gGPJQmtQPEyeQlS61ZWcx2LaX8HjjczfjgZleUbBVk5DJods2vnCUfyqr
 qV0mv6aWM+7z7UYOnJrFLGl6Uw78jsmVD5rlru8vQlQ4+gxXDU8R/TgVtvDedvnlnvWpl4NNDBN
 P2j9AFGZmTB6jX0s72W5JU9ZvUmQlTUpn3b594IRey08BWRju199ClpenHDLGwxyJ+l9cFdKpG/
 mMsuKJRGzksBVdsIV9DmMDRDkl4lBFJEUl7WgRnQ=
X-Google-Smtp-Source: AGHT+IHPmfUm5QObhjtEbEQZoX9DiEHCdcRvsO9DP43+ZIbCRpvLW+BGLX70APma+P1sP1fAwiWJWQ==
X-Received: by 2002:a05:600c:4695:b0:456:26a1:a0c1 with SMTP id
 5b1f17b1804b1-45b517cb8e5mr240528395e9.17.1756380884176; 
 Thu, 28 Aug 2025 04:34:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/32] target/arm: Implement MIN/MAX (register)
Date: Thu, 28 Aug 2025 12:34:07 +0100
Message-ID: <20250828113430.3214314-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250803014019.416797-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  5 +++++
 target/arm/tcg/translate-a64.c | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c1811b02747..a886b3ba4c7 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -708,6 +708,11 @@ GMI             1 00 11010110 ..... 000101 ..... .....  @rrr
 
 PACGA           1 00 11010110 ..... 001100 ..... .....  @rrr
 
+SMAX            . 00 11010110 ..... 011000 ..... .....  @rrr_sf
+SMIN            . 00 11010110 ..... 011010 ..... .....  @rrr_sf
+UMAX            . 00 11010110 ..... 011001 ..... .....  @rrr_sf
+UMIN            . 00 11010110 ..... 011011 ..... .....  @rrr_sf
+
 # Data Processing (1-source)
 
 @rr             . .......... ..... ...... rn:5 rd:5     &rr
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b70ae5befd2..bb92bdc296a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8201,6 +8201,28 @@ static bool trans_PACGA(DisasContext *s, arg_rrr *a)
     return false;
 }
 
+static bool gen_rrr(DisasContext *s, arg_rrr_sf *a, ArithTwoOp fn)
+{
+    TCGv_i64 tcg_rm = cpu_reg(s, a->rm);
+    TCGv_i64 tcg_rn = cpu_reg(s, a->rn);
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+
+    fn(tcg_rd, tcg_rn, tcg_rm);
+    if (!a->sf) {
+        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
+    }
+    return true;
+}
+
+TRANS_FEAT(SMAX, aa64_cssc, gen_rrr, a,
+           a->sf ? tcg_gen_smax_i64 : gen_smax32_i64)
+TRANS_FEAT(SMIN, aa64_cssc, gen_rrr, a,
+           a->sf ? tcg_gen_smin_i64 : gen_smin32_i64)
+TRANS_FEAT(UMAX, aa64_cssc, gen_rrr, a,
+           a->sf ? tcg_gen_umax_i64 : gen_umax32_i64)
+TRANS_FEAT(UMIN, aa64_cssc, gen_rrr, a,
+           a->sf ? tcg_gen_umin_i64 : gen_umin32_i64)
+
 typedef void ArithOneOp(TCGv_i64, TCGv_i64);
 
 static bool gen_rr(DisasContext *s, int rd, int rn, ArithOneOp fn)
-- 
2.43.0


