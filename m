Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035CBC021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnul-0005qn-8D; Sun, 16 Feb 2025 18:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntP-0002yt-Ro
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:44 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntN-00065m-TT
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:43 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso56394135ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747860; x=1740352660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UoYZlm7zVSvFmsayL1ZEjyim5bfv044BhHGM/lCIFRY=;
 b=yIWdBZgUg+Lq5Xav5/dDbrvkhT3wt5+/H+V8t5GOq76wSai7xe2SAFZKANsfLKe8Nb
 o/PwOtTmSpbJ8j68VjysovhlQqE+n576xZnNGDUSON7gparJ5MBqFTDQEa24+IOOetKG
 fzfkok+oYVl0Qt45LFRuxzDhaEtKKgG7HY2omS+IEFEb5PlL+7si7Y7BPL1EPf1pwO2u
 Y8ya/FTCDmaFwONa5Aoognsjz+vv7a7wjFoA6cgO11j0MO79KFgQfP/bF7ldEgDjoKgU
 +bxfyelpIH6NmLTWeQLHNjJqwpOpAWQWUvr1RJfw0N64tY2aMTy7f1TeUDPw2nbztEKs
 7Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747860; x=1740352660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UoYZlm7zVSvFmsayL1ZEjyim5bfv044BhHGM/lCIFRY=;
 b=J/H8/XtXsJoY5RJbnS8WZEzkxwnPj/+hu/LLgx1F9WbngU4Mikd6qmdlM61lFVQOCU
 YCFwluMNQ5gd51WoJC26FfivpAgFevJfuK25ISdAEfV9Tf8xMJ+VYniordd69AzoyxJn
 iaY4/mWon8l6Elhqc6pWoX3quywRCR3pMD5BfaFo0mucjPr7qjIWc+MbmVut4rSAjeJf
 aOOD6FoTJ40zb7PLnZ4rbWtEulHJRIrbdDbhWmKhDARWxWPyEszB/yE3nPby+ZkGHbsO
 LX3CGGmHOE0+gb8sZvKgcEVaCEfjV3g0UEqlc5agTtVAeEK36Wwkib0BIzO6zYTdxWys
 xdqA==
X-Gm-Message-State: AOJu0YzNRkzxxp9IR9mTcfoAG7n4yiWPFW+r+KIdavx4TUOa57fgs9a3
 GyUyE9d6ZAlRiL4l+ikhrvvHjv2qv7HM4MyOGmcFEmry+GVOtYf4Xtz+KbQkHBuG2EAA9o0DYTv
 w
X-Gm-Gg: ASbGncujcgihUdthtxE2OM998pyypFDLbogEItruZAVEJ9TsfhYfgVPYj/6fmNbBXrL
 czPolekKway23631nDTgDVRKSVQby5UKj5oJOODzx3+mk7o9gn7ljv/tVxPmgDgp4hEbXCG83ee
 H+zgohywYroROqsOcagapU+eMht/LGFFMrVTcb2QvVkc6UUfwfaHgWxYZzzNwnqFyFy1h9Yj4cN
 xjzL/mCX7U9vJVd6qVn1T+oE2cizOX0G+QNTdqjanz10YesQFY5u0OYOQkKloHlvOaZmZ0nN/nd
 ZflFSBrCnQkRK1LVSrKDnpWijeERedBdndkdZ5VK3m6fWbA=
X-Google-Smtp-Source: AGHT+IGgwDg1UR793FNCib3bchKTDY0shOcQWChaoBYBmLPVuMUOKJisF55XOGQgEniZH6iG6AlGiQ==
X-Received: by 2002:a17:902:f64f:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-2210460c80dmr103518895ad.20.1739747860436; 
 Sun, 16 Feb 2025 15:17:40 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 115/162] tcg/optimize: With two const operands,
 prefer 0 in arg1
Date: Sun, 16 Feb 2025 15:09:24 -0800
Message-ID: <20250216231012.2808572-116-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

For most binary operands, two const operands fold.
However, the add/sub carry opcodes have a third input.
Prefer "reg, zero, const" since many risc hosts have a
zero register that can fit a "reg, reg, const" insn format.
---
 tcg/optimize.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1b3d0b5b5d..442f5b75e6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -725,12 +725,18 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
 
 #define NO_DEST  temp_arg(NULL)
 
+static int pref_commutative(TempOptInfo *ti)
+{
+    /* Slight preference for non-zero constants second. */
+    return !ti_is_const(ti) ? 0 : ti_const_val(ti) ? 3 : 2;
+}
+
 static bool swap_commutative(TCGArg dest, TCGArg *p1, TCGArg *p2)
 {
     TCGArg a1 = *p1, a2 = *p2;
     int sum = 0;
-    sum += arg_is_const(a1);
-    sum -= arg_is_const(a2);
+    sum += pref_commutative(arg_info(a1));
+    sum -= pref_commutative(arg_info(a2));
 
     /* Prefer the constant in second argument, and then the form
        op a, a, b, which is better handled on non-RISC hosts. */
@@ -745,10 +751,10 @@ static bool swap_commutative(TCGArg dest, TCGArg *p1, TCGArg *p2)
 static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
 {
     int sum = 0;
-    sum += arg_is_const(p1[0]);
-    sum += arg_is_const(p1[1]);
-    sum -= arg_is_const(p2[0]);
-    sum -= arg_is_const(p2[1]);
+    sum += pref_commutative(arg_info(p1[0]));
+    sum += pref_commutative(arg_info(p1[1]));
+    sum -= pref_commutative(arg_info(p2[0]));
+    sum -= pref_commutative(arg_info(p2[1]));
     if (sum > 0) {
         TCGArg t;
         t = p1[0], p1[0] = p2[0], p2[0] = t;
-- 
2.43.0


