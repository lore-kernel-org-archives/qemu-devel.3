Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB86EE57C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYo-0003Ku-99; Wed, 11 Sep 2024 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYd-0002hJ-QU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:09 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYb-0003h0-JO
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:07 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7db19de6346so54437a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073464; x=1726678264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4uFa1EewNZVM8eb9T0XGX/kCpjVJLtWV1XZpTNAvas=;
 b=QdGBNTQnAezKjfSfr/ApFHdNcyHyjKNX0YlCMNL6WeTQsR48n3pFAPIu2/9sbepw6Z
 P0RotgXBqtB+S+rbEQz/XiVbiBaGlW/bnXEWQSGgQAd6Eguko/TNHYZQqcGEx8Tteg7d
 HWYZm3n+8aQePZiNi4Fx1WbF57z0BcKn6G3zhY1DstSpcORV6gGH3uvUa+Js5/9TdV28
 R4bl39PXAJi1S33q5seJzVVzej9myICzBprSpNFFkCtkEbad4LjQ+VG/8Dg01IjRKWbW
 A8vUN7os+iUqBnwBiNZ2kLaSi8cU0rBTNgWiSwoD2HhOW6sGlWOjRU0gbA5ra7BlYA4G
 CF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073464; x=1726678264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r4uFa1EewNZVM8eb9T0XGX/kCpjVJLtWV1XZpTNAvas=;
 b=QTmMr1QVPfKkhapriSqbXofydBMJJL6SziTwaqV8KkWfqzne2jGcMVkn9LDyeisDg2
 QVxtxzUWJA9Pip8gPcLS3EeOFWcfC+wDMIhol6PPbIiIITTav43bzcQCqTqFYHqwNLTH
 kH3LXCa2hVUTgo+NCP3goYk/TzgrEIGhqi04sGgwzXEq4LsZSJYNaIsV4rPEKtIDO4t6
 +wCH6c2Y70OAZlfCSYBnwqWbGoENxojwKr9CiwZIMQGUPwSpjCKKM9AkL5FxFB+Dz8WC
 QbuL2bmt+XWpWqi83SIM3BpMIz1JqrXKs8MJ2cA5VMxIo9JpFAoXCI874JrHbSsnQflW
 z8Jg==
X-Gm-Message-State: AOJu0Yxcl1CpplapGK2H3xHZJLsjI0Xo5IZV82VRXSGIg7ioOTBHtkec
 Txdw7W0BSUZDRIUKQkwTXj51N9DOvB2cZlrqvbALCXC5WI/AAfYuzf46eEJzr1N7sKFtY+CuDT3
 E
X-Google-Smtp-Source: AGHT+IF7gXFmjuuN+NHTysq0ASm6dtsiywMSCg5hW/S37U0mgcwmqlONYH48C53btduETInqf5/UiQ==
X-Received: by 2002:a05:6a20:85a6:b0:1cf:6d68:4a0 with SMTP id
 adf61e73a8af0-1cf6d68118amr1871707637.22.1726073464058; 
 Wed, 11 Sep 2024 09:51:04 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:51:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 16/18] tcg/ppc: Optimize cmpsel with constant 0/-1 arguments
Date: Wed, 11 Sep 2024 09:50:45 -0700
Message-ID: <20240911165047.1035764-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

These can be simplified to and/or/andc/orc,
avoiding the load of the constantinto a register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |  2 +-
 tcg/ppc/tcg-target.c.inc     | 43 +++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index e7ba00c248..453abde6c1 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -33,7 +33,7 @@ C_O1_I2(r, r, rU)
 C_O1_I2(r, r, rZW)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
-C_O1_I4(v, v, v, v, v)
+C_O1_I4(v, v, v, vZM, v)
 C_O1_I4(r, r, rC, rZ, rZ)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, r)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 9d07b4d8e6..3f413ce3c1 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3725,6 +3725,11 @@ static void tcg_out_or_vec(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
     tcg_out32(s, VOR | VRT(a0) | VRA(a1) | VRB(a2));
 }
 
+static void tcg_out_orc_vec(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, VORC | VRT(a0) | VRA(a1) | VRB(a2));
+}
+
 static void tcg_out_and_vec(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out32(s, VAND | VRT(a0) | VRA(a1) | VRB(a2));
@@ -3827,15 +3832,30 @@ static void tcg_out_cmp_vec(TCGContext *s, unsigned vece, TCGReg a0,
 }
 
 static void tcg_out_cmpsel_vec(TCGContext *s, unsigned vece, TCGReg a0,
-                               TCGReg c1, TCGReg c2, TCGReg v3, TCGReg v4,
-                               TCGCond cond)
+                               TCGReg c1, TCGReg c2, TCGArg v3, int const_v3,
+                               TCGReg v4, TCGCond cond)
 {
-    if (tcg_out_cmp_vec_noinv(s, vece, TCG_VEC_TMP1, c1, c2, cond)) {
-        TCGReg swap = v3;
-        v3 = v4;
-        v4 = swap;
+    bool inv = tcg_out_cmp_vec_noinv(s, vece, TCG_VEC_TMP1, c1, c2, cond);
+
+    if (!const_v3) {
+        if (inv) {
+            tcg_out_bitsel_vec(s, a0, TCG_VEC_TMP1, v4, v3);
+        } else {
+            tcg_out_bitsel_vec(s, a0, TCG_VEC_TMP1, v3, v4);
+        }
+    } else if (v3) {
+        if (inv) {
+            tcg_out_orc_vec(s, a0, v4, TCG_VEC_TMP1);
+        } else {
+            tcg_out_or_vec(s, a0, v4, TCG_VEC_TMP1);
+        }
+    } else {
+        if (inv) {
+            tcg_out_and_vec(s, a0, v4, TCG_VEC_TMP1);
+        } else {
+            tcg_out_andc_vec(s, a0, v4, TCG_VEC_TMP1);
+        }
     }
-    tcg_out_bitsel_vec(s, a0, TCG_VEC_TMP1, v3, v4);
 }
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
@@ -3944,8 +3964,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_not_vec(s, a0, a1);
         return;
     case INDEX_op_orc_vec:
-        insn = VORC;
-        break;
+        tcg_out_orc_vec(s, a0, a1, a2);
+        return;
     case INDEX_op_nand_vec:
         insn = VNAND;
         break;
@@ -3960,7 +3980,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_cmp_vec(s, vece, a0, a1, a2, args[3]);
         return;
     case INDEX_op_cmpsel_vec:
-        tcg_out_cmpsel_vec(s, vece, a0, a1, a2, args[3], args[4], args[5]);
+        tcg_out_cmpsel_vec(s, vece, a0, a1, a2,
+                           args[3], const_args[3], args[4], args[5]);
         return;
     case INDEX_op_bitsel_vec:
         tcg_out_bitsel_vec(s, a0, a1, a2, args[3]);
@@ -4330,7 +4351,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ppc_msum_vec:
         return C_O1_I3(v, v, v, v);
     case INDEX_op_cmpsel_vec:
-        return C_O1_I4(v, v, v, v, v);
+        return C_O1_I4(v, v, v, vZM, v);
 
     default:
         g_assert_not_reached();
-- 
2.43.0


