Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48CCEE57C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYy-0003xP-DO; Wed, 11 Sep 2024 12:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYc-0002ai-9u
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:06 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYa-0003gs-Gg
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:06 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-718d962ad64so60b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073463; x=1726678263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUOSVdnU/ITJXIqpoZvSdwJoVXsC/VkcYgnTu23PytA=;
 b=nVWhoTUQcQ2+L3XkUBM5XrqWTcGIjV8eK5hnAzr4+TZ6sOh2HW2mxLBDDpeOu726sZ
 UnvuXpmze86Y9IZAt8U53ecwnhvzAmqaE43zvCtXfHFekwTcyPokf3+7PVsOBD+z1Ko8
 vD2QT83UxV1dRreFL4L9v/4/EDdzTlX3abjN5onqR2X0fjmvnaK3gV/+CF2bGS1RrxVR
 eVgGHLgmBLvVifpGiO94Oj/DcdM+C5od7YTK6NULED5q3X8BLT4KQReqdJTbK6D8HOzE
 WZqH5f0cLW1vF3zEZIspKOifElGgN5tluXPGyKav4Ftcq7hm3r3Ya3uznxXoxUN6sMo7
 DnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073463; x=1726678263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUOSVdnU/ITJXIqpoZvSdwJoVXsC/VkcYgnTu23PytA=;
 b=F1FMrowESBQjSCKThJdeRzkPxpcCzscANYR/DOsAt+JiHXWobTO3MHRWwsCKMFUfu1
 Q+C9IOkm0U3nyb4wkYlQVdT/1FruxiKDphyM1dwM2VPp7LxQT63j+ZCOKwrTNpbTAXDD
 fsUgSRH5UDdY1RAv7oTy6QOSsRYRT5o7ap1Xjf9DmRGAvh3MTOAHvpbzh2+5JhsFg2GX
 xjntHp8WtLaFq5gTJU3mNAh9HBV4hgN1lbKflq1vfeMWpOONz2eh7kZJ/pv5RqpfYXvX
 r4Hyj6RQMMfIHcd9EY7GEqK9tRLgVwCV9B9EwkKYhgOQLsZj7h9/agB/O+vnm/4s2euG
 9TbA==
X-Gm-Message-State: AOJu0YyaY69vtBD/Pcx5QPKmFcWMyJ+4G2ByrxDUyUpo1eKJ/pzZaZO5
 MlDCiVAvY1uci3zBPHw2ubdXeiq9KN4Kn0ehJ8BYrwsA3JW1ir0/tYI3Tv3If5uD3MQZ6F2sdbH
 3
X-Google-Smtp-Source: AGHT+IF6glNca4E21LHopu8YEkpGOdyetBtzS/U9d9G+wwpf4Kkr64hN/fyd3+RD5+KPcMd6R3d8bg==
X-Received: by 2002:a05:6a00:148a:b0:70d:2e24:af75 with SMTP id
 d2e1a72fcca58-718d5f06932mr29329988b3a.24.1726073463142; 
 Wed, 11 Sep 2024 09:51:03 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:51:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 15/18] tcg/ppc: Implement cmpsel_vec
Date: Wed, 11 Sep 2024 09:50:44 -0700
Message-ID: <20240911165047.1035764-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Do not allow cmpsel_vec to be expanded early, so that we can
make the correct decision wrt the sense of the comparison.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |  1 +
 tcg/ppc/tcg-target.h         |  2 +-
 tcg/ppc/tcg-target.c.inc     | 60 +++++++++++++++++++++++++++++++-----
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index 9f99bde505..e7ba00c248 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -33,6 +33,7 @@ C_O1_I2(r, r, rU)
 C_O1_I2(r, r, rZW)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
+C_O1_I4(v, v, v, v, v)
 C_O1_I4(r, r, rC, rZ, rZ)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, r)
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index e154fb14df..0b2171d38c 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -172,7 +172,7 @@ typedef enum {
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       have_vsx
-#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       1
 #define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_DEFAULT_MO (0)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 497e130581..9d07b4d8e6 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3573,6 +3573,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_rotli_vec:
         return vece <= MO_32 || have_isa_2_07 ? -1 : 0;
     case INDEX_op_cmp_vec:
+    case INDEX_op_cmpsel_vec:
         return vece <= MO_32 || have_isa_2_07 ? 1 : 0;
     case INDEX_op_neg_vec:
         return vece >= MO_32 && have_isa_3_00;
@@ -3719,6 +3720,33 @@ static void tcg_out_not_vec(TCGContext *s, TCGReg a0, TCGReg a1)
     tcg_out32(s, VNOR | VRT(a0) | VRA(a1) | VRB(a1));
 }
 
+static void tcg_out_or_vec(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, VOR | VRT(a0) | VRA(a1) | VRB(a2));
+}
+
+static void tcg_out_and_vec(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, VAND | VRT(a0) | VRA(a1) | VRB(a2));
+}
+
+static void tcg_out_andc_vec(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, VANDC | VRT(a0) | VRA(a1) | VRB(a2));
+}
+
+static void tcg_out_bitsel_vec(TCGContext *s, TCGReg d,
+                               TCGReg c, TCGReg t, TCGReg f)
+{
+    if (TCG_TARGET_HAS_bitsel_vec) {
+        tcg_out32(s, XXSEL | VRT(d) | VRC(c) | VRB(t) | VRA(f));
+    } else {
+        tcg_out_and_vec(s, TCG_VEC_TMP2, t, c);
+        tcg_out_andc_vec(s, d, f, c);
+        tcg_out_or_vec(s, d, d, TCG_VEC_TMP2);
+    }
+}
+
 static bool tcg_out_cmp_vec_noinv(TCGContext *s, unsigned vece, TCGReg a0,
                                   TCGReg a1, TCGReg a2, TCGCond cond)
 {
@@ -3798,6 +3826,18 @@ static void tcg_out_cmp_vec(TCGContext *s, unsigned vece, TCGReg a0,
     }
 }
 
+static void tcg_out_cmpsel_vec(TCGContext *s, unsigned vece, TCGReg a0,
+                               TCGReg c1, TCGReg c2, TCGReg v3, TCGReg v4,
+                               TCGCond cond)
+{
+    if (tcg_out_cmp_vec_noinv(s, vece, TCG_VEC_TMP1, c1, c2, cond)) {
+        TCGReg swap = v3;
+        v3 = v4;
+        v4 = swap;
+    }
+    tcg_out_bitsel_vec(s, a0, TCG_VEC_TMP1, v3, v4);
+}
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3889,17 +3929,17 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         insn = sarv_op[vece];
         break;
     case INDEX_op_and_vec:
-        insn = VAND;
-        break;
+        tcg_out_and_vec(s, a0, a1, a2);
+        return;
     case INDEX_op_or_vec:
-        insn = VOR;
-        break;
+        tcg_out_or_vec(s, a0, a1, a2);
+        return;
     case INDEX_op_xor_vec:
         insn = VXOR;
         break;
     case INDEX_op_andc_vec:
-        insn = VANDC;
-        break;
+        tcg_out_andc_vec(s, a0, a1, a2);
+        return;
     case INDEX_op_not_vec:
         tcg_out_not_vec(s, a0, a1);
         return;
@@ -3919,9 +3959,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_cmp_vec:
         tcg_out_cmp_vec(s, vece, a0, a1, a2, args[3]);
         return;
-
+    case INDEX_op_cmpsel_vec:
+        tcg_out_cmpsel_vec(s, vece, a0, a1, a2, args[3], args[4], args[5]);
+        return;
     case INDEX_op_bitsel_vec:
-        tcg_out32(s, XXSEL | VRT(a0) | VRC(a1) | VRB(a2) | VRA(args[3]));
+        tcg_out_bitsel_vec(s, a0, a1, a2, args[3]);
         return;
 
     case INDEX_op_dup2_vec:
@@ -4287,6 +4329,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bitsel_vec:
     case INDEX_op_ppc_msum_vec:
         return C_O1_I3(v, v, v, v);
+    case INDEX_op_cmpsel_vec:
+        return C_O1_I4(v, v, v, v, v);
 
     default:
         g_assert_not_reached();
-- 
2.43.0


