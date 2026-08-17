Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1CAC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyUd-0008Qh-9j; Mon, 17 Aug 2026 10:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvyUV-0008MH-Sg
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvyUT-0000V5-Tx
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786977543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6rdHyprio2WIUkP4wRMjJtXdNaa+gjXkNn2M1xJTDrs=;
 b=Invtzk0McabAkEKys5fxUd5/tmYCf6w6gFuWQ+D0Ta7D3AlKnI70rfDMP8MKpzR2ME0yHf
 3uauxwQwEU6xGOUzkeKWHxuJlQNEiaVFsD+xH1+ocdiUftC//FktZQT2Zc3bB3CNH9+JBw
 R/bJM3yLEFRtmvfJhNpVM6IqozvQosI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-myStvcp-PCekZPoAIVMOiw-1; Mon, 17 Aug 2026 10:38:52 -0400
X-MC-Unique: myStvcp-PCekZPoAIVMOiw-1
X-Mimecast-MFC-AGG-ID: myStvcp-PCekZPoAIVMOiw_1786977531
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482a5e9400eso487180f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786977531; x=1787582331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6rdHyprio2WIUkP4wRMjJtXdNaa+gjXkNn2M1xJTDrs=;
 b=NPy6hiEKDbSL5ldKE9ZJ2MaE60cVe2qK79AeuXNpUhjJkJzCRLJQ/9wuM170Oz1yc+
 QtuovzuR41e0OyUm6t/6u7GgzDzCbUd+i+/KAQzPpo2tRi9uU4nET5SAd2tJilXLHlBn
 Jt2E1FsULSz2qdoq7nUROYiKJabBE65FwMi+LU+fE514ldkzMVPMrAF8wWpqv6gkKCa2
 qI89r/wKr8n9vrb/BjvtYc9yL0JXEjRvJxtsBn14JtZeiIjttyyFFMo5/Jq7CVZ+LHnp
 Mbhe8iLlVHa071FvskqwYBOYNypOv8RxUhKiFBi2OpmZJkY2XL9VljxJrDWHJaB/YOgD
 YeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786977531; x=1787582331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6rdHyprio2WIUkP4wRMjJtXdNaa+gjXkNn2M1xJTDrs=;
 b=EBvXESZvKBMgv3sjpQtpN273IP6LIHezxABy9Ff5hscOyqk5EMTlohyOyty8Zf6rn3
 o2aVe9Tvs8KXIncNveDSygwllFUCCxJPSJHPJoSVfdCEF1EnX1rOp6QNHxRCZ4a6gZ0i
 WCgf68s0X/+M4Vh3G31Yeb8CwikM9AlLuPpCzbL99t+0apeVQKZFIEttjkhr660KLrbJ
 tml8xHw7RQNHZN1kjNLQ/sR4qnJodV8dI2IX6lqA4hMLzBTPO2Z/Ipnmq/Lv7iM75B/F
 ScrZIsjX1o4pmEc5uJpW3vpndGr2jzYH4RkAFM2otH6RcaWYbvEvoUjzzM6dLfF5fbaD
 fRKQ==
X-Gm-Message-State: AOJu0YxpCRH741+YbaHyxoeZfFBnQ6y38jyX8cF4heRJUZeDHICQoiGp
 lyXHuWwXZlb5lGHXnvDoWp6Il7Im1Pd3nD6MmRUgwTN1eVU3hrIMY0ROPqYlwc9ZQq8VQUmuch3
 27uk0iz8CGauoe2faJHSxtGiIV+0JZdReAJ0GvhZ0FpAFFegevTafI55b6K/m4myFslOOSqUv+0
 +R4GMuPttysBF7qqgC0eTblKqEdgDkYjED6lPTPsX/
X-Gm-Gg: AR+sD13Dl2zjLUnVOW73raRYIx8OdJEWSMbm+BlBlcWuq6JFRaETjH4NXl/j/FfK6ek
 J7l+MpoKrQ55UpzukYblp0S85gMoWDgL9q02VCPrZBdB0elYi9cyD8PYDIqiYmXxELw1t7C+sYA
 1Kinltjf8hjEStVWLkZUJHBtWMihTI4f9VnTiktA1Bwro7hmOZT9l6cN0OKogo+y9efeL8Ze/+D
 wrWPdKXfxaZPOH/ajFjMnYm07eFugUeAlnEKHIftVm1gkPAJb3qflQ+g9Knw+45rfK99ZoUkLLj
 WX+AaFwYIcIv/+zPOggCS1N7Y5ol8jolOUlx47imP5xPGLFsFCuFOmNS+BxQp5M6gC2PXafzSB3
 NyfUY0G24Sx998RzaS8TWAhh+o74EKRi4+SpYLRXXx+LacNRuMCVmM08ZVW3lGk1URZaHtys4wq
 UuQM8=
X-Received: by 2002:adf:f2c6:0:b0:47f:97e9:fe60 with SMTP id
 ffacd0b85a97d-482a90c53e6mr939282f8f.15.1786977530714; 
 Mon, 17 Aug 2026 07:38:50 -0700 (PDT)
X-Received: by 2002:adf:f2c6:0:b0:47f:97e9:fe60 with SMTP id
 ffacd0b85a97d-482a90c53e6mr939176f8f.15.1786977530113; 
 Mon, 17 Aug 2026 07:38:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b816c0sm3700857f8f.33.2026.08.17.07.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:38:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mohamed@unpredictable.fr
Subject: [PATCH] target/i386: emulate: stop torturing cc_src into carrying
 SF/PF
Date: Mon, 17 Aug 2026 16:38:48 +0200
Message-ID: <20260817143848.953284-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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


