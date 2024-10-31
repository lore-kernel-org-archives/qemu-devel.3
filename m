Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A30D767F7
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNt-0005aV-Fz; Thu, 31 Oct 2024 13:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMW-00027q-Ti
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMV-0007Q7-3V
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXWKUxEScRO0x2Vpd3yUytpTHeCcdbqyX30ALU4opb4=;
 b=dWIo2p4+1aX2eQDLdHXxpC+lxxpTmY/fw+NKndi3CGOmm/rpYHo9tppdZCEpDmHetShFMa
 ccq1zm7GqhnLlFmvaowRVsl58kqV8vOTy63QiXraSVPNfhYtSKV9/XZWZZzTzTtC4Q4nV5
 IMJGTCmdZnmhQBOMv1CTRuHligotuR0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-LHR7PSVXNX-FG5SxNURLEw-1; Thu, 31 Oct 2024 13:53:30 -0400
X-MC-Unique: LHR7PSVXNX-FG5SxNURLEw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d531a19a9so613776f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397208; x=1731002008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXWKUxEScRO0x2Vpd3yUytpTHeCcdbqyX30ALU4opb4=;
 b=SUyG9ZNMx8tqiJRmGnltQ/wGyZWMikfu8rL/LueXou8tRKTpLh2Hkz1vgTKPePAEp7
 RAeKHotNucHrDTISaJVhZFo0jA08JT+Q7ggoKd0ZJVyRo6FMojrpEJDyt4bc9O4MnbHh
 YMH/hUMO0ttnZtJhyAVPxK3Ju6Uy/IfxYip5pxRIsKJhytK+AD1QkQWBrxB0n125cRM6
 ZRRzZd3UVHc8d1VIGB5XEa/SYV5O/cDyeTqyLOQ8KaYkX/Q8hF2+jNeu3vXEd3xw4piI
 xEWx6C+SQN0H1Fus4XyM7RGPDAkhgjCy/4mex6lfpPZXiymsUoujduJY+w1S4thzx4hS
 z7kg==
X-Gm-Message-State: AOJu0YxGn4CBE/m/9dnRF2Cwh+H5XyTzUegPW1FeSG1xDHiNQOA8bom8
 Auvwg3uamsAxfaxopZbUsqVn1FKD25DC0j5/PiMrv+tj/czG3Pad2lOpzF5rqWJsob+/xfACxCY
 gyU/f5urvqndl4lbFgIKFGqlG/2+7XhCMT7DqtiwAgLnxa0ntgAlDhcfioEC+d/ZnPnqo0ZZZXQ
 nesezRZ+wx1+HEiuVYwmirb/RwYrhHdkwIBtVcKD0=
X-Received: by 2002:a05:6000:410a:b0:37d:2d45:b3d4 with SMTP id
 ffacd0b85a97d-381bea1093fmr4193548f8f.52.1730397208538; 
 Thu, 31 Oct 2024 10:53:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR9bYcjySqFre0Qvml4dmdhID4w5TiWwVlbrMegxo99F93TXniKXN/crFY0ZrkuAMRfiIX2g==
X-Received: by 2002:a05:6000:410a:b0:37d:2d45:b3d4 with SMTP id
 ffacd0b85a97d-381bea1093fmr4193517f8f.52.1730397207844; 
 Thu, 31 Oct 2024 10:53:27 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10ea91bsm2777007f8f.61.2024.10.31.10.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 32/49] target/i386: Introduce cc_op_size
Date: Thu, 31 Oct 2024 18:51:56 +0100
Message-ID: <20241031175214.214455-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace arithmetic on cc_op with a helper function.
Assert that the op has a size and that it is valid
for the configuration.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240701025115.1265117-6-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           | 17 ++++++++++++++++-
 target/i386/tcg/translate.c | 17 +++++++----------
 target/i386/tcg/emit.c.inc  |  5 +++--
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6ec63380473..1bf4dfdc5bb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -24,6 +24,7 @@
 #include "cpu-qom.h"
 #include "kvm/hyperv-proto.h"
 #include "exec/cpu-defs.h"
+#include "exec/memop.h"
 #include "hw/i386/topology.h"
 #include "qapi/qapi-types-common.h"
 #include "qemu/cpu-float.h"
@@ -1304,7 +1305,9 @@ typedef enum {
     CC_OP_ADOX = 2,    /* CC_SRC2 = O, CC_SRC = rest.  */
     CC_OP_ADCOX = 3,   /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
 
-    CC_OP_MULB, /* modify all flags, C, O = (CC_SRC != 0) */
+    /* Low 2 bits = MemOp constant for the size */
+#define CC_OP_FIRST_BWLQ CC_OP_MULB
+    CC_OP_MULB = 4, /* modify all flags, C, O = (CC_SRC != 0) */
     CC_OP_MULW,
     CC_OP_MULL,
     CC_OP_MULQ,
@@ -1374,6 +1377,7 @@ typedef enum {
     CC_OP_POPCNTL__,
     CC_OP_POPCNTQ__,
     CC_OP_POPCNT = sizeof(target_ulong) == 8 ? CC_OP_POPCNTQ__ : CC_OP_POPCNTL__,
+#define CC_OP_LAST_BWLQ CC_OP_POPCNTQ__
 
     CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
     CC_OP_NB,
@@ -1382,6 +1386,17 @@ typedef enum {
 /* See X86DecodedInsn.cc_op, using int8_t. */
 QEMU_BUILD_BUG_ON(CC_OP_DYNAMIC > INT8_MAX);
 
+static inline MemOp cc_op_size(CCOp op)
+{
+    MemOp size = op & 3;
+
+    QEMU_BUILD_BUG_ON(CC_OP_FIRST_BWLQ & 3);
+    assert(op >= CC_OP_FIRST_BWLQ && op <= CC_OP_LAST_BWLQ);
+    assert(size <= MO_TL);
+
+    return size;
+}
+
 typedef struct SegmentCache {
     uint32_t selector;
     target_ulong base;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a20fbb019c8..46062002c02 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -885,7 +885,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
-        size = s->cc_op - CC_OP_ADDB;
+        size = cc_op_size(s->cc_op);
         tcg_gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size);
         tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = cpu_cc_dst,
@@ -902,7 +902,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_SHLB ... CC_OP_SHLQ:
         /* (CC_SRC >> (DATA_BITS - 1)) & 1 */
-        size = s->cc_op - CC_OP_SHLB;
+        size = cc_op_size(s->cc_op);
         return gen_prepare_sign_nz(cpu_cc_src, size);
 
     case CC_OP_MULB ... CC_OP_MULQ:
@@ -910,11 +910,11 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
                              .reg = cpu_cc_src };
 
     case CC_OP_BMILGB ... CC_OP_BMILGQ:
-        size = s->cc_op - CC_OP_BMILGB;
+        size = cc_op_size(s->cc_op);
         return gen_prepare_val_nz(cpu_cc_src, size, true);
 
     case CC_OP_BLSIB ... CC_OP_BLSIQ:
-        size = s->cc_op - CC_OP_BLSIB;
+        size = cc_op_size(s->cc_op);
         return gen_prepare_val_nz(cpu_cc_src, size, false);
 
     case CC_OP_ADCX:
@@ -966,10 +966,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER };
     default:
-        {
-            MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            return gen_prepare_sign_nz(cpu_cc_dst, size);
-        }
+        return gen_prepare_sign_nz(cpu_cc_dst, cc_op_size(s->cc_op));
     }
 }
 
@@ -1007,7 +1004,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
                              .imm = CC_Z };
     default:
         {
-            MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
+            MemOp size = cc_op_size(s->cc_op);
             return gen_prepare_val_nz(cpu_cc_dst, size, true);
         }
     }
@@ -1028,7 +1025,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
     switch (s->cc_op) {
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* We optimize relational operators for the cmp/jcc case.  */
-        size = s->cc_op - CC_OP_SUBB;
+        size = cc_op_size(s->cc_op);
         switch (jcc_op) {
         case JCC_BE:
             tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 790307dbba8..45ac5edb1ae 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1466,7 +1466,7 @@ static void gen_bt_flags(DisasContext *s, X86DecodedInsn *decode, TCGv src, TCGv
          */
         decode->cc_src = tcg_temp_new();
         decode->cc_dst = cpu_cc_dst;
-        decode->cc_op = ((s->cc_op - CC_OP_MULB) & 3) + CC_OP_SARB;
+        decode->cc_op = CC_OP_SARB + cc_op_size(s->cc_op);
         tcg_gen_shr_tl(decode->cc_src, src, s->T1);
     }
 }
@@ -3346,7 +3346,8 @@ static bool gen_eflags_adcox(DisasContext *s, X86DecodedInsn *decode, bool want_
          * bit, we might as well fish CF out of EFLAGS and save a shift.
          */
         if (want_carry && (!need_flags || s->cc_op == CC_OP_SHLB + MO_TL)) {
-            tcg_gen_shri_tl(decode->cc_dst, cpu_cc_src, (8 << (s->cc_op - CC_OP_SHLB)) - 1);
+            MemOp size = cc_op_size(s->cc_op);
+            tcg_gen_shri_tl(decode->cc_dst, cpu_cc_src, (8 << size) - 1);
             got_cf = true;
         }
         gen_mov_eflags(s, decode->cc_src);
-- 
2.47.0


