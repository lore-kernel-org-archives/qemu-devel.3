Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0404C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGY5-0006Dj-SG; Sat, 01 Feb 2025 11:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY0-00067k-4i
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:44 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXy-00017l-0c
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:43 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso18602125e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428041; x=1739032841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=35KilCEDt9XH18K2iWCALum8L0elSy85QkfdnjiRH7s=;
 b=CUy9JNu92ZhdOv2DoyjLQPxPCPOpcG0K4YiFQs69nOQ9UZLqbjZBVTdxFmqPLxNhe/
 DqY1IIpyJujwD/wDncq7WDV0CrymJ+AFtCfTif+1TH6WEv4PxHeJTpVqHlI5bFPzMrp6
 HJqgUXyK2a+LLheRi+6/gHCKRjAwWU40nbXc9WDWa3p2GTB8UgaJmn17/PTqaWMXKBPl
 13ikINI74ViXedBh3yzmf9mWJ0NqTiuuwHXcKxZSJ9JmCXreMzY9tv5WfLGS3JxpZuFa
 KQ1MDWY+jEhD/e/eutyRWcCO4GubnDZAARGG6FVJ6Zg4RBWSzUl4jcLYNuBAv3zIl8FE
 uP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428041; x=1739032841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=35KilCEDt9XH18K2iWCALum8L0elSy85QkfdnjiRH7s=;
 b=MSN7dsxce52ajmfwx9cZjaMIRQWdceFL5ktLNdncY883+s8+qBJN1kDXZ5JDONVhu0
 OdWbWxL58T9ACg7aIiUJV91yOU1xUO7mqNf9u9hLAYd0kHnxmWIB7liLcuGnnqgNxoLU
 4xGd4SkFt0847SUq846wyS0Rq/Rkjl34BomL03n84/Vn0kIOFJa89fTLSeK34aWvwJHj
 h+WuTjTopZW6M1LPaDmR6GYmpwcgJSvM15kTvDEDgdpiN/AEbhXFpOydFdTPaWAjKiNC
 S4QIP2UKERg2ZeOovoDaXEm5T4QxOZTPlqH3BVksBga11KAuYNGg8uis2el2YCxfj4up
 SupA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW35f9KiCKwD6+lasv39zwIGRdBmtTVtPCoDxOp9ieQN8W65NpeZhXIFdb/jQWWiAm8dPpO3qiRce7e@nongnu.org
X-Gm-Message-State: AOJu0YwwzYtPAB/7350I+T6YbrllTfH8exfXOihJ5o2gt1N/h+AYWAsy
 LHgemUaIDYu1fJgjJZ1cFNGeZIA6bKe//jXy4QV/eWUbjumO4Ef2ya3z88mC0w4=
X-Gm-Gg: ASbGnctN8CwUybJfE0cYwWS4DjWKtWpwRFJjpGf1wygVgFy4CqKxXRvQg70k/QjWamh
 2v3GC109NQddyEwEyYMkbdlY3b4tqbfk4fnUFHQcHHQ3DLdab0Yp/3j62wliUsCEvcCQU8QdfgV
 9IgFHZoJo3SuoNWzQi3qdBFW/f/F43OEY4zAZxMDxRBKOrOuIfVxSLsAQjlzDByFyu91nTPjdS6
 Pa1brF5W+S+ympDc26dd5OvfitZMRFspSwOtMHKCZbiZOot75MONWtxnE7+Du1hcuFVD75vNztr
 9W+42x1mKpITQd8yw4sU
X-Google-Smtp-Source: AGHT+IH7RbFfqoZKj4wAptOYh56u24eMfTUdpArz9RreCWng381MJJhAG/9CnM05/O0IStBlCMI0NA==
X-Received: by 2002:a05:600c:1daa:b0:435:edb0:5d27 with SMTP id
 5b1f17b1804b1-438e6ed8f0amr62343825e9.9.1738428040645; 
 Sat, 01 Feb 2025 08:40:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 18/69] target/arm: Handle FPCR.NEP for BFCVT scalar
Date: Sat,  1 Feb 2025 16:39:21 +0000
Message-Id: <20250201164012.1660228-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently we implement BFCVT scalar via do_fp1_scalar().  This works
even though BFCVT is a narrowing operation from 32 to 16 bits,
because we can use write_fp_sreg() for float16. However, FPCR.NEP
support requires that we use write_fp_hreg_merging() for float16
outputs, so we can't continue to borrow the non-narrowing
do_fp1_scalar() function for this. Split out trans_BFCVT_s()
into its own implementation that honours FPCR.NEP.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 96696c342a9..030c5d99d78 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8582,10 +8582,27 @@ static const FPScalar1 f_scalar_frintx = {
 };
 TRANS(FRINTX_s, do_fp1_scalar, a, &f_scalar_frintx, -1)
 
-static const FPScalar1 f_scalar_bfcvt = {
-    .gen_s = gen_helper_bfcvt,
-};
-TRANS_FEAT(BFCVT_s, aa64_bf16, do_fp1_scalar_ah, a, &f_scalar_bfcvt, -1)
+static bool trans_BFCVT_s(DisasContext *s, arg_rr_e *a)
+{
+    ARMFPStatusFlavour fpsttype = s->fpcr_ah ? FPST_AH : FPST_A64;
+    TCGv_i32 t32;
+    int check;
+
+    if (!dc_isar_feature(aa64_bf16, s)) {
+        return false;
+    }
+
+    check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    t32 = read_fp_sreg(s, a->rn);
+    gen_helper_bfcvt(t32, t32, fpstatus_ptr(fpsttype));
+    write_fp_hreg_merging(s, a->rd, a->rd, t32);
+    return true;
+}
 
 static const FPScalar1 f_scalar_frint32 = {
     NULL,
-- 
2.34.1


