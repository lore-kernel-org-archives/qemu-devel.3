Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4160C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBw-0007GD-U3; Fri, 25 Apr 2025 18:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAm-0003VL-GI
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAk-0001pY-I4
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:28 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736c277331eso3830442b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618725; x=1746223525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDH0nf6WSvHdlEkKWwf/ZZXGBDalWIx6GCGa0BtjPlA=;
 b=jf7Hff3n1jKC9q3mP6cpSSsKSnXeG+J7lKmxQDJlr4gL/FMHizdH3bhzJczNuD3J/d
 D+p14PsTwNQsL5/hEw/MvbIk9OuIjJTmV86HaHM77Zz01tRmCeS+I8LfUjONViRvDgJs
 UFll/TfA5mmGeaAhubJsf6XTvXNZ66hLt27qCWA1pAAFkfbOKisCKeM4FUv8EdB29Wn7
 FsYPuERDgGY4Hkz3Raoa+6sM9B0kPI/rQUyG7xvwBa0jkI7XHAN3/nllE+zt9V9L8t1Z
 NTbBJuMuSZLFmrRSe75zfqgp+OckxxGWUQeo91ZZLRXr1cNG0o61cJkEZbxLBUjFJTeb
 Wn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618725; x=1746223525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDH0nf6WSvHdlEkKWwf/ZZXGBDalWIx6GCGa0BtjPlA=;
 b=o7vk2oTstPLvcgFeWrHZk1/TDAGo8Fsg2f378OKZfV6zy+iibn6i/U288hbPkdHo2b
 Q+PSoU/MOsjtDDx4cznrV1jdAlWqUXsEKKEkeFd4PVZ4XZZjHO6eknBcT7YGdBOFejVL
 Jc9Ha9jdUZcqH7qE/ln99Wt2/4qW9DgO2QKUpmsEoK92EuqXxfuvYivyKBKkhxtthGOe
 XyHs8oSDG6UU9Rft/F7yRbiyYS9nsYpxgrpoWhLBfTlQ5pPDqDc4A1cTZbJCuXEoqZua
 Cwd/XSHh7OiJib7KrvtF2ck7YiKlNyG+eHYYxumNgdUoZZnL2sDDTiNR/HrpMDbGTBFT
 o7cQ==
X-Gm-Message-State: AOJu0Yx/XvwaJz0mh/o/Vq3B1YL10OZkjl9dlGTThaL4cBYe8VQ6eNoR
 XZmRPafqeqSYP3xlydPHl5UtVp/3SFIkQOLQ7dEhsKohHr90w7sITuSAGERxlf/zGPqUM3xuazF
 W
X-Gm-Gg: ASbGncu/wnJOYrS7Nw2+kxA+tt7YpJ9kTNeuIjJVLLc2/BIzu1VXyhsjMOxYjJ3OZmz
 EdIEh58Ln1AYjGXOlb9xu1NrpiWLqyqJ2HXJnqTOQ2utIPxjQopoEa+rqSnptFL/dis1uS5lBvP
 64xgJ7tO+OzPHdZHcq7SH1zMfzP2i5TEyUrfQN5zgODSxtekKFCuiFPwo2QJi9o9I+nd4ZgyTWh
 4xGsIJLTC1FcGRRHBEdZIR6o4Y/qyB4DJ/uNEwI/Ev++ZqdEya3CDWUlQOd1w9LSJr3+dQ++aGp
 LVWt2NoroPMbwbbbNoibutG1it+0wVxpE4FsratiOR3vHb/81xtyZe/8ysV/z8jvvya2RAklFj8
 =
X-Google-Smtp-Source: AGHT+IF00z3/odcHEHqSiRESIM2Z2Cx+ByeKP0Kc5lfXfQDbTl+kcRmOiAhD3JPtd54dsmLr+zLATg==
X-Received: by 2002:a05:6a20:d04e:b0:1fe:8f7c:c8e with SMTP id
 adf61e73a8af0-2045b5ab4b4mr5274912637.15.1745618724842; 
 Fri, 25 Apr 2025 15:05:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 120/159] tcg/optimize: With two const operands, prefer 0 in arg1
Date: Fri, 25 Apr 2025 14:54:14 -0700
Message-ID: <20250425215454.886111-121-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index cfcd0ab7f9..95ec3b426d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -737,12 +737,18 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
 
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
@@ -757,10 +763,10 @@ static bool swap_commutative(TCGArg dest, TCGArg *p1, TCGArg *p2)
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


