Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F13FC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zQ-0007B0-0a; Thu, 20 Aug 2026 12:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zN-00075a-8t
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zL-0005hF-B1
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rdHyprio2WIUkP4wRMjJtXdNaa+gjXkNn2M1xJTDrs=;
 b=F8plh3F2txWagY1HmCbQMtDE8xWQfC9AKFJ2V1zOhJ7TZCZINFRai9eUqXZ33rXG0Rw02h
 IBh3Jx8L8b0DzWNieSQRKCDa6PtJOHHYhJJhbNyxqw7W/Gqsl2FUZhz2jRLSuDiMVnx3w6
 XhCIy3JigYFMXPgb5p76blH+ECndgDA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-fXe_rogQMwesBluEnV2hMQ-1; Thu, 20 Aug 2026 12:51:27 -0400
X-MC-Unique: fXe_rogQMwesBluEnV2hMQ-1
X-Mimecast-MFC-AGG-ID: fXe_rogQMwesBluEnV2hMQ_1787244686
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47fe85684b9so94999f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244686; x=1787849486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6rdHyprio2WIUkP4wRMjJtXdNaa+gjXkNn2M1xJTDrs=;
 b=b6py1pHPGx5PVtVgpLXvSenaiaHFqxtBmMnEqK+rpr530+c9TUbUsh+DPik6ssHunH
 3PNbwfyQ3TkrYa99xC8DCQUcA2V5ZYbRYHK8biD31K9oxrahnSg8zBihHk0/pcpwAzmd
 YKIsBNjhGaLhaSsaPVJIyePq7cMZ01lWovHhnqcBPN46rn16YTuthRgqqPb0MDi9aOz0
 GylLXXz5MsEuTPs34122C1O2Z+Zav1RYmTJRxXGj6nsneVaC7RL+QR7F2YVsIMrSJ/B5
 YScXsxGjSYQFXkeKbqPwEvU4JT3oiwaz7CdDK1sNH9o0AAXSqwDvrJfk2OoSRkQx1hGt
 b6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244686; x=1787849486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6rdHyprio2WIUkP4wRMjJtXdNaa+gjXkNn2M1xJTDrs=;
 b=fvccGXLvZ7ptCu3E2tRL8qIWhm+xo1RVUNOg7R/MmX8TwPTqW5sa4FkLcy2fybu0WK
 C3pt6kgItaDzBPYyLmMs/np1VUVM8pM6H1oNJoM+xbuATmV+H6IvDSm7tXmmo7SISozi
 Dk8Sy7t4aC2EV2wjHEa4AP43uyRog2xb2DM1D9uuvfO2A2Ybn45KCGy+5t80I/KbjnqP
 fTOQWofmgyvofr/1PPFOtJTDK9GighfNpKjSH4rwjL3tSMnCD10ZTX+1WechHotoFr6I
 ghjIBMXf9I5lhltqj11gT6s9UW9netLKj0c1kgP/dhSu9D/duk1/E52QqS/QECtHjO6l
 Z5Pw==
X-Gm-Message-State: AFuF++nBuQnVTj0QIQcxXv8mnl3Onzv6SdUyalgNe4l2AgZPP5bXshRr
 ERIfadW6HukR4SU1X/Zlw5LhFIioJ8PurWnnKbxGsYn1OwTO1QL9csA+5r2+fujfBRhQLpbkIIf
 R61K8muqwSrKHMXrk3aPLVWRnbWbzf+bGs4M4KMhEYG9zIdVlMBNh4MgFzeWQy5xda1ON24C+Id
 v/AA1mK23dNz9Uf125LKUyfFdCWz1yKsB9o7ezxdQQ
X-Gm-Gg: AR+sD114037fPR0jU8d4zVVt+wT2r8rqWkFU7pGHi7MMgR6pHpf0ffQFJ2AyMUJ+ggy
 t7FOzav4coATAve0rsi05SCD/W5PvezltSiPd8KaYnbFOUCqhN4hI1Ux+3D2wYoH7e3zQ3uxcTH
 E0cLdEnmnlroC6dsw3ZaUgX5NQ8uCK7/YAhjVNGvh2G3lLnUhAk1vTxLEse+Bqll4KmmGO4gmcK
 2lDb3JI9BNF3RfC+gJ99Sg7u4Kt4hzUncdwV33YicwQmr0e1pVywHb1BvTgPPdmrIBp4XxHbfd8
 7CCVcYKeZDbAHbOfq+zyCM+7hGy3RGupWMGJLwa9JgX6eLu7sigV4bF6VEEkRktqcFw2kpSXjVG
 ggm8Yk53u2wIWOioXb+DCWKMlQt6+jwZYB8gLhNRbXpxBvKXYgBuzl9fIMjoHLNKpdFqNcJA8Aj
 Hfrgw=
X-Received: by 2002:a05:6000:22c6:b0:481:5021:33cd with SMTP id
 ffacd0b85a97d-482c0b5482cmr21785f8f.3.1787244686203; 
 Thu, 20 Aug 2026 09:51:26 -0700 (PDT)
X-Received: by 2002:a05:6000:22c6:b0:481:5021:33cd with SMTP id
 ffacd0b85a97d-482c0b5482cmr21655f8f.3.1787244685466; 
 Thu, 20 Aug 2026 09:51:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c45d1sm12031794f8f.30.2026.08.20.09.51.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/53] target/i386: emulate: stop torturing cc_src into
 carrying SF/PF
Date: Thu, 20 Aug 2026 18:49:33 +0200
Message-ID: <20260820164957.1895963-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

x86_flags.c encodes the flags into cc_dst and cc_src with algorithms
essentially derived from Bochs; the exact details have changed but cc_dst
is Bochs result and cc_src is very close to Bochs auxbits.  However,
using only two words is unnecessarily limiting because it splits SF/PF
between the two words even though *ZF* is the real nuisance (ZF=1 implies
SF=PF=0) and the one that commands usage of PD/SD delta bits.

Within TCG, the CCMP instruction would have a similar need of efficiently
encoding an arithmetic result or an EFLAGS value; it is not implemented,
but there are plans (see commit message for 5dcdbd07125, "target/i386:
tcg: use cout to commonize add/adc/sub/sbb cases", 2025-04-17) to use
an algorithm very similar to target/i386/emulate's, but with *three* words.
Then SF and PF live together in harmony, because SF can be encoded with
either parity and PF does not use the high bit where SF is stored; by
placing them in a third word their computation is isolated from ZF's
and everything becomes simpler.

In fact I'm not even sure why Bochs did it like that, and did not just
give SF/PF their own home in a third word as well; the developers believe
that the extra store is too expensive.  I am not really sure about that,
but as far as QEMU is concerned, emulation proceeds one instruction at a
time so using SRC2 should actually be faster, not just easier.  To convert
from the output of arithmetic operations, PD and SD disappear and DST
simply has to be stored in two places; to convert to RFLAGS, SF/PF are
easily computed from SRC2 as if PD=SD=0; conversion to LFLAGS encodes
parity in bit 0 and mixes in SF as an even-parity value with the right
sign bit.

Unlike TCG, there is a single meaning for all operand lengths, which
corresponds to either CCMPL or CCMPQ depending on sizeof(target_ulong).
So the carry-out value still needs to be split---with AF in bit 3
and CF/PO in the higher bits of the target_ulong-sized env->cc_src.
This is an acceptable tradeoff for the interpreter, in order to optimize
lflags_to_rflags.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_flags.c | 65 +++++++++++++--------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/target/i386/emulate/x86_flags.c b/target/i386/emulate/x86_flags.c
index 3c4270a14c1..c49d8bb836a 100644
--- a/target/i386/emulate/x86_flags.c
+++ b/target/i386/emulate/x86_flags.c
@@ -30,28 +30,24 @@
 
 
 /*
- * The algorithms here are similar to those in Bochs.  After an ALU
- * operation, CC_DST can be used to compute ZF, SF and PF, whereas
- * CC_SRC is used to compute AF, CF and OF.  In reality, SF and PF are the
- * XOR of the value computed from CC_DST and the value found in bits 7 and 2
- * of CC_SRC; this way the same logic can be used to compute the flags
- * both before and after an ALU operation.
+ * The emulator always encodes flags in the same way as CC_OP_CCMPB + MO_TL.
+ * While for arithmetic operations ZF/SF/PF are computed from the same value,
+ * ZF=1 may be inconsistent with PF/SF for arbitrary RFLAGS values so CC_SRC2
+ * is used for SF and PF.  CC_SRC holds a carry-out vector that is used to
+ * compute AF, CF and OF.
  *
  * Compared to the TCG CC_OP codes, this avoids conditionals when converting
  * to and from the RFLAGS representation.
+ *
+ * The underlying ideas ultimately descend from Bochs, but with significant
+ * simplifications obtained by storing flags in three words rather than two.
  */
 
 #define LF_SIGN_BIT    (TARGET_LONG_BITS - 1)
 
-#define LF_BIT_PD      (2)          /* lazy Parity Delta, same bit as PF */
-#define LF_BIT_AF      (3)          /* lazy Adjust flag */
-#define LF_BIT_SD      (7)          /* lazy Sign Flag Delta, same bit as SF */
 #define LF_BIT_CF      (TARGET_LONG_BITS - 1) /* lazy Carry Flag */
 #define LF_BIT_PO      (TARGET_LONG_BITS - 2) /* lazy Partial Overflow = CF ^ OF */
 
-#define LF_MASK_PD     ((target_ulong)0x01 << LF_BIT_PD)
-#define LF_MASK_AF     ((target_ulong)0x01 << LF_BIT_AF)
-#define LF_MASK_SD     ((target_ulong)0x01 << LF_BIT_SD)
 #define LF_MASK_CF     ((target_ulong)0x01 << LF_BIT_CF)
 #define LF_MASK_PO     ((target_ulong)0x01 << LF_BIT_PO)
 
@@ -59,19 +55,15 @@
 /* OSZAPC */
 /* ******************* */
 
-/* use carries to fill in AF, PO and CF, while ensuring PD and SD are clear.
- * for full-word operations just clear PD and SD; for smaller operand
- * sizes only keep AF in the low byte and shift the carries left to
- * place PO and CF in the top two bits.
+/*
+ * For arithmetic operations ZF/SF/PF are consistent so DST == SRC2.
+ * For operations that are not full-word, keep AF in the low byte and shift
+ * the carries left to place PO and CF in the top two bits.
  */
 #define SET_FLAGS_OSZAPC_SIZE(size, lf_carries, lf_result) { \
-    env->cc_dst = (target_ulong)(int##size##_t)(lf_result); \
-    target_ulong temp = (lf_carries); \
-    if ((size) == TARGET_LONG_BITS) { \
-        temp = temp & ~(LF_MASK_PD | LF_MASK_SD); \
-    } else { \
-        temp = (temp & LF_MASK_AF) | (temp << (TARGET_LONG_BITS - (size))); \
-    } \
+    env->cc_dst = env->cc_src2 = (target_ulong)(int##size##_t)(lf_result); \
+    target_ulong temp = (lf_carries) & MAKE_64BIT_MASK(0, size); \
+    temp |= temp << (TARGET_LONG_BITS - (size)); \
     env->cc_src = temp; \
 }
 
@@ -93,13 +85,9 @@
 /* same as setting OSZAPC, but preserve CF and flip PO if the old value of CF
  * did not match the high bit of lf_carries. */
 #define SET_FLAGS_OSZAP_SIZE(size, lf_carries, lf_result) { \
-    env->cc_dst = (target_ulong)(int##size##_t)(lf_result); \
-    target_ulong temp = (lf_carries); \
-    if ((size) == TARGET_LONG_BITS) { \
-        temp = (temp & ~(LF_MASK_PD | LF_MASK_SD)); \
-    } else { \
-        temp = (temp & LF_MASK_AF) | (temp << (TARGET_LONG_BITS - (size))); \
-    } \
+    env->cc_dst = env->cc_src2 = (target_ulong)(int##size##_t)(lf_result); \
+    target_ulong temp = (lf_carries) & MAKE_64BIT_MASK(0, size); \
+    temp |= temp << (TARGET_LONG_BITS - (size)); \
     target_ulong cf_changed = ((target_long)(env->cc_src ^ temp)) < 0; \
     env->cc_src = temp ^ (cf_changed * (LF_MASK_PO | LF_MASK_CF)); \
 }
@@ -255,7 +243,7 @@ void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t v1, uint8_t v2,
 
 static inline uint32_t get_PF(CPUX86State *env)
 {
-    return ((parity8(env->cc_dst) - 1) ^ env->cc_src) & CC_P;
+    return (parity8(env->cc_src2) - 1) & CC_P;
 }
 
 static inline uint32_t get_OF(CPUX86State *env)
@@ -283,8 +271,7 @@ static inline uint32_t get_ZF(CPUX86State *env)
 
 static inline uint32_t get_SF(CPUX86State *env)
 {
-    return ((env->cc_dst >> (LF_SIGN_BIT - LF_BIT_SD)) ^
-            env->cc_src) & CC_S;
+    return (target_long)env->cc_src2 < 0 ? CC_S : 0;
 }
 
 void lflags_to_rflags(CPUX86State *env)
@@ -304,16 +291,14 @@ void rflags_to_lflags(CPUX86State *env)
 {
     target_ulong cf_af, cf_xor_of;
 
-    /* Leave the low byte zero so that parity is always even...  */
-    env->cc_dst = !(env->eflags & CC_Z) << 8;
-
-    /* ... and therefore cc_src always uses opposite polarity.  */
-    env->cc_src = CC_P;
-    env->cc_src ^= env->eflags & (CC_S | CC_P);
+    /* compute DST and SRC2 that reconstruct ZF/SF/PF.  */
+    env->cc_dst = ~env->eflags & CC_Z;     /* DST = 0 if ZF=1 */
+    env->cc_src2 = ~env->eflags & CC_P;    /* odd parity if PF=0 */
+    env->cc_src2 ^= -!!(env->eflags & CC_S);
 
     /* rotate right by one to move CF and AF into the carry-out positions */
     cf_af = env->eflags & (CC_C | CC_A);
-    env->cc_src |= ((cf_af >> 1) | (cf_af << (TARGET_LONG_BITS - 1)));
+    env->cc_src = ((cf_af >> 1) | (cf_af << (TARGET_LONG_BITS - 1)));
 
     cf_xor_of = ((env->eflags & (CC_C | CC_O)) + (CC_O - CC_C)) & CC_O;
     env->cc_src |= -cf_xor_of & LF_MASK_PO;
-- 
2.55.0


