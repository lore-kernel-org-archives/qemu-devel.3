Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6497BC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzas7-000383-77; Thu, 27 Aug 2026 10:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzas4-0002xf-SM
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarv-0005wg-S5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psmWnwdI++Dx6M1pX0Tg1KVRHh212DdLzILYjePfc5o=;
 b=OcwFwmQWKQJMGpE7d66kx7Mikf74bWeOjHTFvHEvx6hf3O8HemYuwFFs0fIsH7/DhSAwJQ
 abXgBH5AWK/m02/YPXwI3ncxRsUIu+rdRGh7bPX397uRJAqAc8gD+n7rUa9rE9jGxiZd4T
 2UGY6K1EpCFhNAaZr7inRxTv1RhNZcY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-ji6DmsS9Pk2fOd3dydK09w-1; Thu, 27 Aug 2026 10:14:13 -0400
X-MC-Unique: ji6DmsS9Pk2fOd3dydK09w-1
X-Mimecast-MFC-AGG-ID: ji6DmsS9Pk2fOd3dydK09w_1787840052
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-496bbcf7d1eso15104675e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840052; x=1788444852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=psmWnwdI++Dx6M1pX0Tg1KVRHh212DdLzILYjePfc5o=;
 b=gNa7BYz4AhxyZ73E0b1DeqM7WXG2mzyuqEs7RQy7nud+2Br+xI5jf6YIkyp8+T2edh
 emV7mUs06uX4jGwlNRVXiasmWiCNfi+OOwB/kARlqCH0YG0A0RhVjHUaOvYO15n8UhXQ
 /G/R29vnq5HbUMYD/rMcmmsc/IVwpgJ5GtXwMxclA9bjBE0gzAwdiqu1u5Hk8D/LO7Is
 Md2at/4AGVYnFa9qlj1css81L+CrLk86epkTGD/chTd/T3I4K1fx9Vc8vCSbLVjEJSUa
 ORDPbxUyGC2kroPIL+lIFVIi4h1MAB102QxvRKtgXF1DsNRWhPiveBX1ZYQC/F38yZCt
 2Ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840052; x=1788444852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=psmWnwdI++Dx6M1pX0Tg1KVRHh212DdLzILYjePfc5o=;
 b=VXmxxrNWpDI/XaVbn8wav1dEWekRu7V80TH6ZNjubGolPGBo/iFBKdCOf0hNZmixJP
 lzMjGXSOFrMDL+cSj42AqKydzDbNlrAzjBesuyrYAMCcDOmzGtVMek2phRyAEV+nIi+k
 37Ulg0O0fH3pwP+3srT455Jna1jTwvUllpUhb2IZ1plJzVKTNCqynd/MB4TlCpxRejP2
 /r+vNOThjKhB+pZCjBqD5VCL5GXKcNCXUflNFeVa+QUoYujlOrS4nzK+A70EludnlfnZ
 frmtabvtxjK8PN+YY8lreq1/8a+X3QLeTT+5Ua3AfJTTc6XWQAXbsb/tHoFsGu3gtcBk
 67Qw==
X-Gm-Message-State: AFuF++n0/PEZ/M09Qtjv4XWVoiB0WIfuh93zqr+l4YhNgBr7KlMs1WFt
 JsY5pCCTzTMIG/IjIO5KusBqE/8k39iyZ3O3NP9IHX1a+y4WaFO0E4Gjnc2qsgvn/Uw600GRpGh
 mH0nWSsmkSWb8/An2DxJkATHU6Q74++5QjQdJetV20bl/soe2EYgG9aXGVNqspiCYvvDepNZai7
 5Gs1f4Mh52ETm/zinxAl+U43YeIu4OAkEFCU/SPc+a
X-Gm-Gg: AR+sD107wXaVKxZ8QXA25tlHoj2MAdERVpLsrg4dctolO+nmtivcGbuo5a/e2PEbPO0
 775zpj0FP7vScvXe/swIKC+DFFT6sGdcsDCyY5SFsiwfnMc1JgWCdmNP0Vei4RD1a3dfESHMMue
 TfMhRBXSv3YPPuoGyhEUdtbA1XXQlbMFLlGBeJTbYsy+4oSOxQUm9JcBttIPpLIBdozbxu+RmUv
 F/nnaOKjV4CI+853JaSpW+sdQ4ECu8nPwCDEL03vDNty0M44g586ltWjQQ8A7RpcfYeft/QkyOP
 jB2rD1HLW5fc1YMEIbTBi95THOuY09KTbDsuQ7zHfAGT6dAqWr7XGtAdF/AAzVHAo0vtGW7M5g7
 Fxfimw7YKhS0WmDMvnlN8mNZNZAup4kqhpk4i8HVz8WGCdeiXu55xHilI9YsBl9BxPSqHUn7sVE
 s+4xQ=
X-Received: by 2002:a05:600c:8b5b:b0:499:b3f0:ff05 with SMTP id
 5b1f17b1804b1-499dc81fa3dmr173639405e9.13.1787840052058; 
 Thu, 27 Aug 2026 07:14:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8b5b:b0:499:b3f0:ff05 with SMTP id
 5b1f17b1804b1-499dc81fa3dmr173637715e9.13.1787840051281; 
 Thu, 27 Aug 2026 07:14:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd55dd4bsm70993175e9.3.2026.08.27.07.14.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:14:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/23] target/i386/tcg: move VEX validation early
Date: Thu, 27 Aug 2026 16:13:07 +0200
Message-ID: <20260827141314.1099352-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Perform the X86_VEX_REPScalar transformation on X86OpEntry instead of
X86DecodedOp; everything else can be checked equally well before
immediates are fetched etc.

This is especially important for APX, which may decode operands
differently depending on the NDD bit: if EVEX.NDD=0, VEX.vvvv is
ignored and must be zero.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 54 ++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index f5f36ef1731..1f071f0a5f0 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2542,6 +2542,22 @@ static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_f
         decode->immediate = insn_get_signed(env, s, MO_8);
     }
 
+    if (e->vex_class == 12) {
+        /* Check no overlap between registers.  */
+        if (!decode->op[0].has_ea &&
+            (decode->op[0].n == decode->mem.index || decode->op[0].n == decode->op[1].n)) {
+            return false;
+        }
+        assert(!decode->op[1].has_ea);
+        if (decode->op[1].n == decode->mem.index) {
+            return false;
+        }
+        if (!decode->op[2].has_ea &&
+            (decode->op[2].n == decode->mem.index || decode->op[2].n == decode->op[1].n)) {
+            return false;
+        }
+    }
+
     return true;
 }
 
@@ -2648,9 +2664,9 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
             if (s->vex_l) {
                 goto illegal;
             }
-            assert(decode->e.s2 == X86_SIZE_x);
-            if (decode->op[2].has_ea) {
-                decode->op[2].ot = s->prefix & PREFIX_REPZ ? MO_32 : MO_64;
+            assert(e->op2 == X86_TYPE_W && e->s2 == X86_SIZE_x);
+            if ((s->modrm >> 6) != 3) {
+                e->s2 = s->prefix & PREFIX_REPNZ ? X86_SIZE_sd : X86_SIZE_ss;
             }
         }
         break;
@@ -2667,10 +2683,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
 
     switch (e->vex_class) {
     case 0:
-        if (s->prefix & PREFIX_VEX) {
-            goto illegal;
-        }
-        return true;
+        g_assert_not_reached();
     case 1:
     case 2:
     case 3:
@@ -2695,19 +2708,6 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
             goto illegal;
         }
 
-        /* Check no overlap between registers.  */
-        if (!decode->op[0].has_ea &&
-            (decode->op[0].n == decode->mem.index || decode->op[0].n == decode->op[1].n)) {
-            goto illegal;
-        }
-        assert(!decode->op[1].has_ea);
-        if (decode->op[1].n == decode->mem.index) {
-            goto illegal;
-        }
-        if (!decode->op[2].has_ea &&
-            (decode->op[2].n == decode->mem.index || decode->op[2].n == decode->op[1].n)) {
-            goto illegal;
-        }
         /* fall through */
     case 6:
     case 11:
@@ -3024,6 +3024,16 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         get_modrm(s, env);
     }
 
+    if (decode.e.vex_class == 0) {
+        if (s->prefix & PREFIX_VEX) {
+            goto illegal_op;
+        }
+    } else {
+        if (!validate_vex(s, &decode)) {
+            return;
+        }
+    }
+
     if (!decode_ops(s, env, decode_func, &decode)) {
         goto illegal_op;
     }
@@ -3085,10 +3095,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         goto illegal_op;
     }
 
-    if (!validate_vex(s, &decode)) {
-        return;
-    }
-
     /*
      * Checks that result in #GP or VMEXIT come second.  Intercepts are
      * generally checked after non-memory exceptions (i.e. after all
-- 
2.55.0


