Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B612BD3C546
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4r-000532-JE; Wed, 10 Dec 2025 08:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4R-0004sA-Ne
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4O-0003OF-J1
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w13dSM8SN/G/eyeKhZHaUnvdET5uHotxh7kCkFaT+gs=;
 b=ZGnF+gsLfmi6d/86NOphslI7CwCGS4HnSLvccbkmyzq1eRZ/NipHCf6UnBw+7ragbRHGqw
 3aVByDMp8QVAdf0Co9Qnptwr42W1rTuxNP0Odkreoi8JoVPFfAb2JvWWU41qTnGZiGjLS3
 yz7VyiFHMNOvrjb5xz0P8Db5R9GAIR0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-agA4M8gXP6yRbZSAG2-13w-1; Wed, 10 Dec 2025 08:17:26 -0500
X-MC-Unique: agA4M8gXP6yRbZSAG2-13w-1
X-Mimecast-MFC-AGG-ID: agA4M8gXP6yRbZSAG2-13w_1765372645
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42f9ed47dd8so866914f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372644; x=1765977444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w13dSM8SN/G/eyeKhZHaUnvdET5uHotxh7kCkFaT+gs=;
 b=mbqNpdeTeRcMxUM3zx7APgvFheRof9b5W2vYvXQuQ0ypglArA8KIY59TFkYkyiQvPC
 Go33BN/sFwechA9XkSPjrf8tNIDPuciOLGPpQYcrOCf0Uop/bmQpXat9k9p16kf764cW
 yB6kXLf2etpWANYtuAqjXX+wORJ7aRogEXh1eLXU2YPOdOxbqBiuNwMUshxJIm802ZWe
 ZfAj6lO99JY/JKbXG2FmSAw6LIIteAdSJWQ4S8WQRu42CbkbZVj5xa1T9U0wvyUH0++2
 Za1d4LsupBWF+/kchEmE3eGpqN9S3dKPLbxPmlOaxe0egWr7hcjP/M2A+JImv2fyAn/5
 j62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372644; x=1765977444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w13dSM8SN/G/eyeKhZHaUnvdET5uHotxh7kCkFaT+gs=;
 b=CwOqkxgtlP3Ow7FlLph6YDUaFdMbKW48ya0WUmfrP2rnyeZsQzqZAORi5u9VaUPfLY
 zMk0CYxT+T3iGV9urNDGIe9Mc4xmPe/qpvrtyrMPXP8uJr9TnTy9DqZO44pBCyKHtElY
 Z005AMolf1VXtFr2VY55iGPSNSEOXCOvNTHIydI8ufEdcJ6Pd3uflpiwRN+X0zSeQbHL
 1jLLIpEWFRKxgfBO69a976L+NjkSwW5etDRMTc6MVfp6GFrS50Qj10b5FqT0m9l6N1wI
 PGCxRoy4W+nxPQnMFEWWCR75jepfWrblqCYkllg+BsJ29zx+ueoAlKVBcPj2zQHKiePh
 1zXg==
X-Gm-Message-State: AOJu0YzYdCHdWeoCyTrKrdT80Esdrc5mUjp1l5DY/rhK2duSTc8S3+Pe
 CuEOqDmmhBcVZlBvJ06TiBiGOGFf/MiwUcKRRFRZOu/j5U7pRsMwB/sFFDT66eTKID/T+qOkhpJ
 gENlOfnZ5dmfgaTAkJT7t7ti522ebhCf9vmYZ4aD7/Vcea5c4qk0AhhkLe7ejjvfszUlKnwS9d2
 rZd3j+b//H5rQGWH/pjkq8S8cPmZXBTQ4vSIVBZVP8
X-Gm-Gg: AY/fxX6HE6wkvCeU4srb71zp8O0pLKl2DmeAANViYoV2SlVcDbmLkI6OXawYnftJaIp
 vUr+ssnE3je8mT75zH8ol0vD5l86sG8KW1hL1f+o/yUT2f8Mewq/ydDZPNiQ8Xuwnk5GAd63YvC
 XNReMaXGTqU9fvzZLSbT3iB2EnQfJUjTXQrgIdq20Tpj9u2bz5vpZAZiyafkw4AtEaqXUD1c8jF
 7VQVwu+BtjgsiOfTg15CQXYh2RcX40Dp5dO8C7+fZx66KVnP0BMQFJEgLJEJJyVydtS69ijInXS
 68I0xiHMyV066WAxeYputDvNQRLKSpT4gsI36eNNABdyRxHnESzHk5VM6ntWqP1ejNAosQ1Q/Gc
 WntiQMqqcf5pYMSXsyWy8b2zRPxDTiaSAadgc5+xbO+6bm+uDq6Yr9+2l+oM3f6ECzNqgE8oF53
 gLbzrRCvLEqh+OGQk=
X-Received: by 2002:a05:6000:144e:b0:42b:3cdf:9b6c with SMTP id
 ffacd0b85a97d-42fa39e0177mr2459589f8f.22.1765372644312; 
 Wed, 10 Dec 2025 05:17:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDU3SIU8my1KO9Nbc3x/sb7nV2Z5c1EnU4Vza673+efX3CDwpcvxW5uo3Vo5R0IQYIlitu2g==
X-Received: by 2002:a05:6000:144e:b0:42b:3cdf:9b6c with SMTP id
 ffacd0b85a97d-42fa39e0177mr2459550f8f.22.1765372643711; 
 Wed, 10 Dec 2025 05:17:23 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d2226c5sm38288147f8f.23.2025.12.10.05.17.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/18] target/i386/tcg: add a CCOp for SBB x,x
Date: Wed, 10 Dec 2025 14:16:52 +0100
Message-ID: <20251210131653.852163-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is more efficient both when generating code and when testing
flags.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           | 13 ++++++++++++-
 target/i386/cpu-dump.c      |  2 ++
 target/i386/tcg/cc_helper.c |  6 ++++++
 target/i386/tcg/translate.c | 13 +++++++++++++
 target/i386/tcg/emit.c.inc  | 33 ++++++---------------------------
 5 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ecca38ed0b5..314e773a5d4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1515,7 +1515,18 @@ typedef enum {
     CC_OP_POPCNTL__,
     CC_OP_POPCNTQ__,
     CC_OP_POPCNT = sizeof(target_ulong) == 8 ? CC_OP_POPCNTQ__ : CC_OP_POPCNTL__,
-#define CC_OP_LAST_BWLQ CC_OP_POPCNTQ__
+
+    /*
+     * Note that only CC_OP_SBB_SELF (i.e. the one with MO_TL size)
+     * is used or implemented, because the translation produces a
+     * sign-extended CC_DST.
+     */
+    CC_OP_SBB_SELFB__, /* S/Z/C/A via CC_DST, O clear, P set.  */
+    CC_OP_SBB_SELFW__,
+    CC_OP_SBB_SELFL__,
+    CC_OP_SBB_SELFQ__,
+    CC_OP_SBB_SELF = sizeof(target_ulong) == 8 ? CC_OP_SBB_SELFQ__ : CC_OP_SBB_SELFL__,
+#define CC_OP_LAST_BWLQ CC_OP_SBB_SELFQ__
 
     CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
 } CCOp;
diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index 67bf31e0caa..20a3002f013 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -91,6 +91,8 @@ static const char * const cc_op_str[] = {
     [CC_OP_BMILGQ] = "BMILGQ",
 
     [CC_OP_POPCNT] = "POPCNT",
+
+    [CC_OP_SBB_SELF] = "SBBx,x",
 };
 
 static void
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index 2c4170b5b77..91e492196af 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -100,6 +100,9 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
         return src1;
     case CC_OP_POPCNT:
         return dst ? 0 : CC_Z;
+    case CC_OP_SBB_SELF:
+	/* dst is either all zeros (--Z-P-) or all ones (-S-APC) */
+        return (dst & (CC_Z|CC_A|CC_C|CC_S)) ^ (CC_P | CC_Z);
 
     case CC_OP_ADCX:
         return compute_all_adcx(dst, src1, src2);
@@ -326,6 +329,9 @@ target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
     case CC_OP_MULQ:
         return src1 != 0;
 
+    case CC_OP_SBB_SELF:
+        return dst & 1;
+
     case CC_OP_ADCX:
     case CC_OP_ADCOX:
         return dst;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e91715af817..17ad4ccacaf 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -304,6 +304,7 @@ static const uint8_t cc_op_live_[] = {
     [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_POPCNT] = USES_CC_DST,
+    [CC_OP_SBB_SELF] = USES_CC_DST,
 };
 
 static uint8_t cc_op_live(CCOp op)
@@ -938,6 +939,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
         size = cc_op_size(s->cc_op);
         return gen_prepare_val_nz(cpu_cc_src, size, false);
 
+    case CC_OP_SBB_SELF:
+        return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_dst };
+
     case CC_OP_ADCX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_dst,
@@ -999,6 +1003,7 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src2,
                              .no_setcond = true };
+    case CC_OP_SBB_SELF:
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER };
@@ -1078,6 +1083,14 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         }
         break;
 
+    case CC_OP_SBB_SELF:
+        /* checking for nonzero is usually the most efficient */
+        if (jcc_op == JCC_L || jcc_op == JCC_B || jcc_op == JCC_S) {
+            jcc_op = JCC_Z;
+            inv = !inv;
+        }
+        goto slow_jcc;
+
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
         /* Mostly used for test+jump */
         size = s->cc_op - CC_OP_LOGICB;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 8dac4d09da1..0fde3d669d9 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3876,37 +3876,16 @@ static void gen_SBB(DisasContext *s, X86DecodedInsn *decode)
         return;
     }
 
-    c_in = tcg_temp_new();
-    gen_compute_eflags_c(s, c_in);
-
-    /*
-     * Here the change is as follows:
-     * CC_SBB: src1 = T0, src2 = T0, src3 = c_in
-     * CC_SUB: src1 = 0, src2 = c_in (no src3)
-     *
-     * The difference also does not matter:
-     * - AF is bit 4 of dst^src1^src2, but bit 4 of src1^src2 is zero in both cases
-     *   therefore AF comes straight from dst (in fact it is c_in)
-     * - for OF, src1 and src2 have the same sign in both cases, meaning there
-     *   can be no overflow
-     */
+    /* SBB x,x has its own CCOp so that's even easier.  */
     if (decode->e.op2 != X86_TYPE_I && !decode->op[0].has_ea && decode->op[0].n == decode->op[2].n) {
-        if (s->cc_op == CC_OP_DYNAMIC) {
-            tcg_gen_neg_tl(s->T0, c_in);
-        } else {
-            /*
-             * Do not negate c_in because it will often be dead and only the
-             * instruction generated by negsetcond will survive.
-             */
-            gen_neg_setcc(s, JCC_B << 1, s->T0);
-        }
-        tcg_gen_movi_tl(s->cc_srcT, 0);
-        decode->cc_src = c_in;
-        decode->cc_dst = s->T0;
-        decode->cc_op = CC_OP_SUBB + ot;
+        gen_neg_setcc(s, JCC_B << 1, s->T0);
+        prepare_update1_cc(decode, s, CC_OP_SBB_SELF);
         return;
     }
 
+    c_in = tcg_temp_new();
+    gen_compute_eflags_c(s, c_in);
+
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_add_tl(s->T0, s->T1, c_in);
         tcg_gen_neg_tl(s->T0, s->T0);
-- 
2.52.0


