Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C626AC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqID-0004tu-Sc; Tue, 25 Aug 2026 08:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqIB-0004q1-P3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqI7-0000j3-50
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787661010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CeIBcEAroUJ3Fvfnbs5pB5G04GNsPJK+AJJUR2I9Ymw=;
 b=YlUc+gPYOJZIx/vdKLGCArxZBjA4x2iaqkuIghzhjMTiGuHWC6dYXsGAtjWAfKOq+7M7aY
 LvP1aPFQXyTQHxF7+F1OvYKyY97gIaa/djcJoAYy29goPDi6/cOW/R5+WF2Zoo9KO/UWox
 aG5aFcZ4bZvQ6pxTvQ2BxChSlsYvfAo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-hHUeZVD9OPm5PGTA_10Z3A-1; Tue, 25 Aug 2026 08:30:08 -0400
X-MC-Unique: hHUeZVD9OPm5PGTA_10Z3A-1
X-Mimecast-MFC-AGG-ID: hHUeZVD9OPm5PGTA_10Z3A_1787661008
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c1670dd0f5dso157132766b.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787661007; x=1788265807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CeIBcEAroUJ3Fvfnbs5pB5G04GNsPJK+AJJUR2I9Ymw=;
 b=p6uzlXFCWfmP0rX01S7ZzF/RjzezDio/q+3SC+d4POo2C5edk0CN5f+FTPmdsUzXGF
 886X+S1qCosKW7ATpFgG3+MVvWPDojqZhist6Hmpv0IhfpqPl3ERCacETVWNdL9fjbxh
 yTH/9n3BRKmj6vJ/77b17r1FcI/yjLrbZm9/wvkvjubunwV+xOt0eDrlqi0XfCctEvZu
 CBEw1ZtlsBTnjQ7PmwYPXVj+TyZNsgoXD0rASi6frISLt7GA2k+cY7c2iBJ2Uyh7W5iC
 O6W5R4ceXbHwrsnhpG6X4ptVujPM0KRUaDm9KWdUriNazmRC+hf6NnDQtqXkwQ662Szq
 7tDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661007; x=1788265807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CeIBcEAroUJ3Fvfnbs5pB5G04GNsPJK+AJJUR2I9Ymw=;
 b=sKzdo5eOm0Qxg0x4AKRqq9qiLY/L1+4Vtm+Xn0JGtk5QfBK//QiAZljLIGkYoZXRwg
 pFoUiHWxFOHFZG/iE71h5SeG+su5UxEcNpoEXqz6e+eO9X8/BaviXb3baBPMY6zIjiT0
 Lx7zxcSb667uFvt8+NzRJ0crwugd8brKDocJAS4fqbAh4CzX7bErmc6O+qLpp5/ZBv5y
 w7bMqRAFAwRW01TBe+EpNIrTa27SXQXjfD8R9xszhArsagcq0iEwh0rgXcV8hyU4wEeI
 0nYCjMUiAjLyiuQV6POi8Z7ZqmCKwtRfjKG3cAwa1UzNtqt+KKlAhV9l0JadPynECE9k
 xb8Q==
X-Gm-Message-State: AFuF++mxiScDRPAXZg+w6blB0Dz1mDkjvRouoAClcEkEFXg+MleZE89u
 ttM2IpN/hMT9iSzWZZYxQy/2XGgwXotUEF+dt2qJ5HL4/fXo1mSEooWHx61eEDV3k8EKu3ivRkz
 l4tBFvV4WwwGzwkbt7FoMDz3GGx+CPNs8cvN6gK6u+afrZXYER7VHi68tQu5s/wJ7/URR+YpH2t
 s91g5JSxLBOVptQjpe2bG4JqhLSjPIT0y1w/5Exx8R
X-Gm-Gg: AR+sD10Ri1jTbw58214f5q1hIGTEhC7ZR6aD1vyzX+WvkaCkLNQ/sEl9P++me53MC9H
 e4zri7QablRg113w8qiUeXxUYuuK5Dz1O/Qkd8/V5jVNKAAoPFCUbnhIV3s//GIUNrMyAfS1Y/z
 HzedtrLGrQShVk48XCSPXwykwyvA1dDghgLfaMbUpR0xvZqStg4A3TZoaPRVJA9cxUnJVpB0wWb
 XOi11bnBQveAb/3yNzQev6m4liM5Axdge4olw+fjY3HWqYV8A2P74oLWaEYP3Quzi+JhhjE9Hbj
 qofhvnv0VMW9skdcL9KNEbz2YXcmwK7EMsJVnI5uHKw+6ojF0kmYWoW6TXoz44yAbyIZ1YYuA/I
 k9RKA5IRG2xAlKYmC+Q0EDqHj0YbEUMo61PxRW+zWOqnht9TO60/lE7yRNseIFQhcKlcbjwqyid
 Y8Dr8=
X-Received: by 2002:a17:906:7316:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c2491cbca79mr2860397266b.9.1787661007201; 
 Tue, 25 Aug 2026 05:30:07 -0700 (PDT)
X-Received: by 2002:a17:906:7316:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c2491cbca79mr2860381966b.9.1787661006121; 
 Tue, 25 Aug 2026 05:30:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5d82a283dsm1234190a12.11.2026.08.25.05.30.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:30:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/20] target/i386/tcg: decode APX instructions
Date: Tue, 25 Aug 2026 14:29:19 +0200
Message-ID: <20260825122921.431739-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The bulk of the APX implementation, comprising new map4-specific
encodings, extensions to legacy root and 0F tables, and the
implementation of new instructions CFCMOV, PUSH2 and POP2.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h             |   1 +
 target/i386/tcg/decode-new.h     |   1 +
 target/i386/tcg/excp_helper.c    |   5 +
 target/i386/tcg/decode-new.c.inc | 307 +++++++++++++++++++++++++------
 target/i386/tcg/emit.c.inc       |  55 ++++++
 5 files changed, 312 insertions(+), 57 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index 3f67098f11f..99cbbacadfc 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -57,6 +57,7 @@ DEF_HELPER_2(sysret, void, env, int)
 DEF_HELPER_FLAGS_1(pause, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_3(raise_interrupt, TCG_CALL_NO_WG, noreturn, env, int, int)
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
+DEF_HELPER_FLAGS_1(raise_gpf, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_1(icebp, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_3(boundw, void, env, tl, int)
 DEF_HELPER_3(boundl, void, env, tl, int)
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 1c7ed73c437..de35fb44a37 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -53,6 +53,7 @@ typedef enum X86OpType {
     X86_TYPE_nop, /* modrm operand decoded but not loaded into s->T{0,1} */
     X86_TYPE_2op, /* 2-operand RMW instruction */
     X86_TYPE_LoBits, /* encoded in bits 0-2 of the operand + REX.B */
+    X86_TYPE_ZERO, /* Constant zero, for CFCMOV */
     X86_TYPE_0, /* Hard-coded GPRs (RAX..RDI) */
     X86_TYPE_1,
     X86_TYPE_2,
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 1eaa602c91d..d6410d6fc11 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -37,6 +37,11 @@ G_NORETURN void helper_raise_exception(CPUX86State *env, int exception_index)
     raise_exception(env, exception_index);
 }
 
+G_NORETURN void helper_raise_gpf(CPUX86State *env)
+{
+    raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+}
+
 /*
  * Check nested exceptions and change to double or triple fault if
  * needed. It should only be called, if this is not an interrupt.
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 33d366769e7..a92bc1faeff 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -184,6 +184,8 @@
     X86_OP_GROUP3(op, op0, s0, None, None, None, None, ## __VA_ARGS__)
 #define X86_OP_GROUPwr(op, op0, s0, op1, s1, ...)                 \
     X86_OP_GROUP3(op, op0, s0, op1, s1, None, None, ## __VA_ARGS__)
+#define X86_OP_GROUPrr(op, op0, s0, op1, s1, ...)                 \
+    X86_OP_GROUP3(op, None, None, op0, s0, op1, s1, ## __VA_ARGS__)
 #define X86_OP_GROUP0(op, ...)                                    \
     X86_OP_GROUP3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
@@ -275,8 +277,10 @@
 #define p_f3          .valid_prefix = P_F3,
 #define p_f2          .valid_prefix = P_F2,
 #define p_00_66       .valid_prefix = P_00 | P_66,
+#define p_00_f2       .valid_prefix = P_00 | P_F2,
 #define p_00_f3       .valid_prefix = P_00 | P_F3,
 #define p_66_f2       .valid_prefix = P_66 | P_F2,
+#define p_66_f3       .valid_prefix = P_66 | P_F3,
 #define p_00_66_f3    .valid_prefix = P_00 | P_66 | P_F3,
 #define p_66_f3_f2    .valid_prefix = P_66 | P_F3 | P_F2,
 #define p_00_66_f3_f2 .valid_prefix = P_00 | P_66 | P_F3 | P_F2,
@@ -866,28 +870,33 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
 
     /*
      * REG selects srcdest2 operand, VEX.vvvv selects src3.  VEX class not found
-     * in manual, assumed to be 13 from the VEX.L0 constraint.
+     * in manual, assumed to be 13 from the VEX.L0 constraint; EVEX-APX-BMI and
+     * EVEX-APX-CMPccXADD are also pretty much the same; the difference are
+     * reflected in chk(nf0) and in the M operand type.
      */
-    [0xe0] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe1] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe2] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe3] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe4] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe5] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe6] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe7] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe0] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe1] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe2] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe3] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe4] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe5] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe6] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe7] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
 
-    [0xe8] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe9] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xea] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xeb] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xec] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xed] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xee] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xef] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe8] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe9] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xea] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xeb] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xec] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xed] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xee] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xef] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
 };
 
-/* four rows for no prefix, 66, F3, F2 (including 66+F2 operand size override) */
+/*
+ * four rows for no prefix, 66, F3, F2 (including 66+F2 operand size override).
+ * all VEX13 instructions extend to APX, while MOVBE/CRC32 move to EVEX map4
+ */
 static const X86OpEntry opcodes_0F38_F0toFF[16][4] = {
     /*
      * MOVBE and CRC32 are incorrectly listed as always doing 32-bit operation
@@ -920,20 +929,20 @@ static const X86OpEntry opcodes_0F38_F0toFF[16][4] = {
     [5] = {
         X86_OP_ENTRY3(BZHI, G,y, E,y, B,y, vex13 cpuid(BMI1)),
         {},
-        X86_OP_ENTRY3(PEXT, G,y, B,y, E,y, vex13 zextT0 cpuid(BMI2)),
-        X86_OP_ENTRY3(PDEP, G,y, B,y, E,y, vex13 zextT0 cpuid(BMI2)),
+        X86_OP_ENTRY3(PEXT, G,y, B,y, E,y, vex13 zextT0 chk(nf0) cpuid(BMI2)),
+        X86_OP_ENTRY3(PDEP, G,y, B,y, E,y, vex13 zextT0 chk(nf0) cpuid(BMI2)),
     },
     [6] = {
         {},
         X86_OP_ENTRY2(ADCX, G,y, E,y, cpuid(ADX)),
         X86_OP_ENTRY2(ADOX, G,y, E,y, cpuid(ADX)),
-        X86_OP_ENTRY3(MULX, /* B,y, */ G,y, E,y, 2,y, vex13 cpuid(BMI2)),
+        X86_OP_ENTRY3(MULX, /* B,y, */ G,y, E,y, 2,y, vex13 chk(nf0) cpuid(BMI2)),
     },
     [7] = {
         X86_OP_ENTRY3(BEXTR, G,y, E,y, B,y, vex13 zextT0 cpuid(BMI1)),
-        X86_OP_ENTRY3(SHLX, G,y, E,y, B,y, vex13 cpuid(BMI1)),
-        X86_OP_ENTRY3(SARX, G,y, E,y, B,y, vex13 sextT0 cpuid(BMI1)),
-        X86_OP_ENTRY3(SHRX, G,y, E,y, B,y, vex13 zextT0 cpuid(BMI1)),
+        X86_OP_ENTRY3(SHLX, G,y, E,y, B,y, vex13 chk(nf0) cpuid(BMI1)),
+        X86_OP_ENTRY3(SARX, G,y, E,y, B,y, vex13 chk(nf0) sextT0 cpuid(BMI1)),
+        X86_OP_ENTRY3(SHRX, G,y, E,y, B,y, vex13 chk(nf0) zextT0 cpuid(BMI1)),
     },
 };
 
@@ -1022,7 +1031,7 @@ static const X86OpEntry opcodes_0F3A[256] = {
 
     [0xdf] = X86_OP_ENTRY3(VAESKEYGEN, V,dq, W,dq, I,b,  vex4 cpuid(AES) p_66),
 
-    [0xF0] = X86_OP_ENTRY3(RORX, G,y, E,y, I,b, vex13 cpuid(BMI2) p_f2),
+    [0xF0] = X86_OP_ENTRY3(RORX,       G,y, E,y, I,b,    vex13 chk(nf0) cpuid(BMI2) p_f2),
 };
 
 static void decode_0F3A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
@@ -1587,9 +1596,9 @@ static void decode_group1(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 
     if (op == 7) {
         /* prevent writeback for CMP */
-        entry->op1 = entry->op0;
         entry->op0 = X86_TYPE_None;
         entry->s0 = X86_SIZE_None;
+        entry->vex_class = X86_EVEX_APX_cmp;
     } else {
         entry->special = X86_SPECIAL_HasLock;
     }
@@ -1616,6 +1625,9 @@ static void decode_group2(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     };
     int op = (get_modrm(s, env) >> 3) & 7;
     entry->gen = group2_gen[op];
+    if (op == 2 || op == 3) {
+        entry->check |= X86_CHECK_nf0;
+    }
     if (op == 7) {
         entry->special = X86_SPECIAL_SExtT0;
     } else {
@@ -1627,24 +1639,24 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 {
     static const X86OpEntry opcodes_grp3[16] = {
         /* 0xf6 */
-        [0x00] = X86_OP_ENTRYrr(TEST, E,b, I,b),
-        [0x01] = X86_OP_ENTRYrr(TEST, E,b, I,b),
-        [0x02] = X86_OP_ENTRY1(NOT,  E,b,      lock),
-        [0x03] = X86_OP_ENTRY1(NEG,  E,b,      lock),
-        [0x04] = X86_OP_ENTRYrr(MUL, E,b, 0,b, zextT0),
-        [0x05] = X86_OP_ENTRYrr(IMUL,E,b, 0,b, sextT0),
-        [0x06] = X86_OP_ENTRYr(DIV,  E,b),
-        [0x07] = X86_OP_ENTRYr(IDIV, E,b),
+        [0x00] = X86_OP_ENTRYrr(TEST, E,b, I,b, evex_apx_cmp p_00),
+        [0x01] = X86_OP_ENTRYrr(TEST, E,b, I,b, evex_apx_cmp p_00),
+        [0x02] = X86_OP_ENTRYwr(NOT,  B,b, E,b, evex_apx p_00 chk(nf0) lock),
+        [0x03] = X86_OP_ENTRYwr(NEG,  B,b, E,b, evex_apx p_00 lock),
+        [0x04] = X86_OP_ENTRYrr(MUL,  E,b, 0,b, evex_apx p_00 zextT0),
+        [0x05] = X86_OP_ENTRYrr(IMUL, E,b, 0,b, evex_apx p_00 sextT0),
+        [0x06] = X86_OP_ENTRYr(DIV,   E,b,      evex_apx p_00),
+        [0x07] = X86_OP_ENTRYr(IDIV,  E,b,      evex_apx p_00),
 
         /* 0xf7 */
-        [0x08] = X86_OP_ENTRYrr(TEST, E,v, I,z),
-        [0x09] = X86_OP_ENTRYrr(TEST, E,v, I,z),
-        [0x0a] = X86_OP_ENTRY1(NOT,  E,v,      lock),
-        [0x0b] = X86_OP_ENTRY1(NEG,  E,v,      lock),
-        [0x0c] = X86_OP_ENTRYrr(MUL, E,v, 0,v, zextT0),
-        [0x0d] = X86_OP_ENTRYrr(IMUL,E,v, 0,v, sextT0),
-        [0x0e] = X86_OP_ENTRYr(DIV,  E,v),
-        [0x0f] = X86_OP_ENTRYr(IDIV, E,v),
+        [0x08] = X86_OP_ENTRYrr(TEST, E,v, I,z, evex_apx_cmp p_00_66),
+        [0x09] = X86_OP_ENTRYrr(TEST, E,v, I,z, evex_apx_cmp p_00_66),
+        [0x0a] = X86_OP_ENTRYwr(NOT,  B,v, E,v, evex_apx p_00_66 chk(nf0) lock),
+        [0x0b] = X86_OP_ENTRYwr(NEG,  B,v, E,v, evex_apx p_00_66 lock),
+        [0x0c] = X86_OP_ENTRYrr(MUL,  E,v, 0,v, evex_apx p_00_66 zextT0),
+        [0x0d] = X86_OP_ENTRYrr(IMUL, E,v, 0,v, evex_apx p_00_66 sextT0),
+        [0x0e] = X86_OP_ENTRYr(DIV,   E,v,      evex_apx p_00_66),
+        [0x0f] = X86_OP_ENTRYr(IDIV,  E,v,      evex_apx p_00_66),
     };
 
     int w = (*b & 1);
@@ -1657,12 +1669,12 @@ static void decode_group4_5(DisasContext *s, CPUX86State *env, X86OpEntry *entry
 {
     static const X86OpEntry opcodes_grp4_5[16] = {
         /* 0xfe */
-        [0x00] = X86_OP_ENTRY1(INC,     E,b,                           lock),
-        [0x01] = X86_OP_ENTRY1(DEC,     E,b,                           lock),
+        [0x00] = X86_OP_ENTRYwr(INC,    B,b, E,b,                      evex_apx p_00 lock),
+        [0x01] = X86_OP_ENTRYwr(DEC,    B,b, E,b,                      evex_apx p_00 lock),
 
         /* 0xff */
-        [0x08] = X86_OP_ENTRY1(INC,     E,v,                           lock),
-        [0x09] = X86_OP_ENTRY1(DEC,     E,v,                           lock),
+        [0x08] = X86_OP_ENTRYwr(INC,    B,v, E,v,                      evex_apx p_00 lock),
+        [0x09] = X86_OP_ENTRYwr(DEC,    B,v, E,v,                      evex_apx p_00 lock),
         [0x0a] = X86_OP_ENTRYr(CALL_m,  E,f64,                         zextT0),
         [0x0b] = X86_OP_ENTRYr(CALLF_m, M,p),
         [0x0c] = X86_OP_ENTRYr(JMP_m,   E,f64,                         zextT0),
@@ -1773,10 +1785,11 @@ static const X86OpEntry opcodes_root[256] = {
     [0x76] = X86_OP_ENTRYr(Jcc, J,b),
     [0x77] = X86_OP_ENTRYr(Jcc, J,b),
 
-    [0x80] = X86_OP_GROUP2(group1, E,b, I,b),
-    [0x81] = X86_OP_GROUP2(group1, E,v, I,z),
-    [0x82] = X86_OP_GROUP2(group1, E,b, I,b, chk(i64)),
-    [0x83] = X86_OP_GROUP2(group1, E,v, I,b),
+    /* decode_group1 is shared with EVEX map4.  */
+    [0x80] = X86_OP_GROUP3(group1, B,b, E,b, I,b),
+    [0x81] = X86_OP_GROUP3(group1, B,v, E,v, I,z),
+    [0x82] = X86_OP_GROUP3(group1, B,b, E,b, I,b, chk(i64)),
+    [0x83] = X86_OP_GROUP3(group1, B,v, E,v, I,b),
     [0x84] = X86_OP_ENTRYrr(TEST, E,b, G,b),
     [0x85] = X86_OP_ENTRYrr(TEST, E,v, G,v),
     [0x86] = X86_OP_ENTRY2(XCHG, E,b, G,b, xchg),
@@ -1809,8 +1822,9 @@ static const X86OpEntry opcodes_root[256] = {
     [0xB6] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
     [0xB7] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
 
-    [0xC0] = X86_OP_GROUP2(group2, E,b, I,b),
-    [0xC1] = X86_OP_GROUP2(group2, E,v, I,b),
+    /* decode_group2 is shared with EVEX map4.  */
+    [0xC0] = X86_OP_GROUP3(group2, B,b, E,b, I,b),
+    [0xC1] = X86_OP_GROUP3(group2, B,v, E,v, I,b),
     [0xC2] = X86_OP_ENTRYr(RET, I,w),
     [0xC3] = X86_OP_ENTRY0(RET),
     [0xC4] = X86_OP_ENTRY3(LES, G,z, EM,p, None, None, chk(i64)),
@@ -1818,10 +1832,11 @@ static const X86OpEntry opcodes_root[256] = {
     [0xC6] = X86_OP_GROUP3(group11, E,b, I,b, None, None), /* reg=000b */
     [0xC7] = X86_OP_GROUP3(group11, E,v, I,z, None, None), /* reg=000b */
 
-    [0xD0] = X86_OP_GROUP1(group2, E,b),
-    [0xD1] = X86_OP_GROUP1(group2, E,v),
-    [0xD2] = X86_OP_GROUP2(group2, E,b, 1,b), /* CL */
-    [0xD3] = X86_OP_GROUP2(group2, E,v, 1,b), /* CL */
+    /* decode_group2 is shared with EVEX map4.  */
+    [0xD0] = X86_OP_GROUPwr(group2, B,b, E,b),
+    [0xD1] = X86_OP_GROUPwr(group2, B,v, E,v),
+    [0xD2] = X86_OP_GROUP3(group2, B,b, E,b, 1,b), /* CL */
+    [0xD3] = X86_OP_GROUP3(group2, B,v, E,v, 1,b), /* CL */
     [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b, chk(i64)),
     [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b, chk(i64)),
     [0xD6] = X86_OP_ENTRYw(SALC, 0,b, chk(i64)),
@@ -2052,9 +2067,178 @@ static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entr
     decode_REX2(s, env, entry, b, opcode_rex2_map1);
 }
 
+static void decode_EVEX4cc(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    uint8_t modrm = get_modrm(s, env);
+    int mod = (modrm >> 6) & 3;
+
+    static const X86OpEntry setcc =
+        X86_OP_ENTRYw(SETcc, E,b, evex_apx_zu chk(nf0) p_f2);
+    static const X86OpEntry cfcmov_nd0[2][2] = {
+        { /* NF=0 */
+            X86_OP_ENTRY3(CFCMOVcc_ld,  G,v, ZERO,v, M,v, p_00_66 evex_apx),
+            X86_OP_ENTRY3(CMOVcc,       G,v, ZERO,v, E,v, p_00_66 evex_apx),
+        },
+        { /* NF=1 */
+            X86_OP_ENTRYwr(CFCMOVcc_st, M,v, G,v,         p_00_66 evex_apx),
+            X86_OP_ENTRY3(CMOVcc,       E,v, ZERO,v, G,v, p_00_66 evex_apx),
+        },
+    };
+    static const X86OpEntry cfcmov_nd1[2][2] = {
+        { /* NF=0 */
+            X86_OP_ENTRY3(CMOVcc,       B,v, G,v, E,v,    p_00_66 evex_apx),
+            X86_OP_ENTRY3(CMOVcc,       B,v, G,v, E,v,    p_00_66 evex_apx),
+        },
+        { /* NF=1 */
+            X86_OP_ENTRY3(CFCMOVcc_ld,  B,v, G,v, M,v,    p_00_66 evex_apx),
+            X86_OP_ENTRY3(CMOVcc,       B,v, G,v, E,v,    p_00_66 evex_apx),
+        },
+    };
+
+    if (s->prefix & PREFIX_REPNZ) {
+        *entry = setcc;
+        if (EVEX_APX_ND(s)) {
+            entry->s1 = X86_SIZE_q; /* optimization for zu */
+        }
+    } else {
+        *entry = (EVEX_APX_ND(s) ? cfcmov_nd1 : cfcmov_nd0)[EVEX_APX_NF(s)][mod == 3];
+    }
+}
+
+static void decode_EVEX4_66(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    entry->gen = (s->prefix & PREFIX_DATA) ? gen_ADCX : gen_ADOX;
+}
+
+static void decode_EVEX4_8F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    int op = (get_modrm(s, env) >> 3) & 7;
+    if (op == 0) {
+        entry->gen = gen_POP2;
+    } else {
+        *entry = UNKNOWN_OPCODE;
+    }
+}
+
+static void decode_EVEX4_FF(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry push2 =
+        X86_OP_ENTRYrr(PUSH2, B,d64, R,d64,     evex_apx_pp2 p_00);
+
+    int op = (get_modrm(s, env) >> 3) & 7;
+    if (op == 6) {
+        *entry = push2;
+    } else {
+        decode_group4_5(s, env, entry, b);
+    }
+}
+
+/*
+ * Missing: ENQCMD, ENQCMDS, INVEPT, INVPCID, INVVPID,
+ * KMOVD, KMOVW, KMOVD, KMOVQ, MOVDIR64B, MOVDIRI, URDMSR,
+ * UWRMSR, WRSSD, WRSSQ, WRUSSD, WRUSSQ, LDTILECFG, STTILECFG,
+ * TILELOADD, TILELOADDDT1, TILESTORED.
+ */
+static const X86OpEntry opcodes_EVEX_map4[256] = {
+    [0x00] = X86_OP_ENTRY3(ADD, B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x01] = X86_OP_ENTRY3(ADD, B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x02] = X86_OP_ENTRY3(ADD, B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x03] = X86_OP_ENTRY3(ADD, B,v, G,v, E,v, evex_apx p_00_66 lock),
+    [0x08] = X86_OP_ENTRY3(OR, B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x09] = X86_OP_ENTRY3(OR, B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x0A] = X86_OP_ENTRY3(OR, B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x0B] = X86_OP_ENTRY3(OR, B,v, G,v, E,v, evex_apx p_00_66 lock),
+
+    [0x10] = X86_OP_ENTRY3(ADC, B,b, E,b, G,b, evex_apx p_00 chk(nf0) lock),
+    [0x11] = X86_OP_ENTRY3(ADC, B,v, E,v, G,v, evex_apx p_00_66 chk(nf0) lock),
+    [0x12] = X86_OP_ENTRY3(ADC, B,b, G,b, E,b, evex_apx p_00 chk(nf0) lock),
+    [0x13] = X86_OP_ENTRY3(ADC, B,v, G,v, E,v, evex_apx p_00_66 chk(nf0) lock),
+    [0x18] = X86_OP_ENTRY3(SBB, B,b, E,b, G,b, evex_apx p_00 chk(nf0) lock),
+    [0x19] = X86_OP_ENTRY3(SBB, B,v, E,v, G,v, evex_apx p_00_66 chk(nf0) lock),
+    [0x1A] = X86_OP_ENTRY3(SBB, B,b, G,b, E,b, evex_apx p_00 chk(nf0) lock),
+    [0x1B] = X86_OP_ENTRY3(SBB, B,v, G,v, E,v, evex_apx p_00_66 chk(nf0) lock),
+
+    [0x20] = X86_OP_ENTRY3(AND,  B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x21] = X86_OP_ENTRY3(AND,  B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x22] = X86_OP_ENTRY3(AND,  B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x23] = X86_OP_ENTRY3(AND,  B,v, G,v, E,v, evex_apx p_00_66 lock),
+    [0x24] = X86_OP_ENTRY4(SHLD, B,v, E,v, G,v, evex_apx p_00_66),
+    [0x28] = X86_OP_ENTRY3(SUB,  B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x29] = X86_OP_ENTRY3(SUB,  B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x2A] = X86_OP_ENTRY3(SUB,  B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x2B] = X86_OP_ENTRY3(SUB,  B,v, G,v, E,v, evex_apx p_00_66 lock),
+    [0x2C] = X86_OP_ENTRY4(SHRD, B,v, E,v, G,v, evex_apx p_00_66),
+
+    [0x30] = X86_OP_ENTRY3(XOR, B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x31] = X86_OP_ENTRY3(XOR, B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x32] = X86_OP_ENTRY3(XOR, B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x33] = X86_OP_ENTRY3(XOR, B,v, G,v, E,v, evex_apx p_00_66 lock),
+    [0x38] = X86_OP_ENTRYrr(CMP, E,b, G,b, evex_apx_cmp p_00),
+    [0x39] = X86_OP_ENTRYrr(CMP, E,v, G,v, evex_apx_cmp p_00_66),
+    [0x3A] = X86_OP_ENTRYrr(CMP, G,b, E,b, evex_apx_cmp p_00),
+    [0x3B] = X86_OP_ENTRYrr(CMP, G,v, E,v, evex_apx_cmp p_00_66),
+
+    [0x40] = X86_OP_GROUP0(EVEX4cc),
+    [0x41] = X86_OP_GROUP0(EVEX4cc),
+    [0x42] = X86_OP_GROUP0(EVEX4cc),
+    [0x43] = X86_OP_GROUP0(EVEX4cc),
+    [0x44] = X86_OP_GROUP0(EVEX4cc),
+    [0x45] = X86_OP_GROUP0(EVEX4cc),
+    [0x46] = X86_OP_GROUP0(EVEX4cc),
+    [0x47] = X86_OP_GROUP0(EVEX4cc),
+    [0x48] = X86_OP_GROUP0(EVEX4cc),
+    [0x49] = X86_OP_GROUP0(EVEX4cc),
+    [0x4A] = X86_OP_GROUP0(EVEX4cc),
+    [0x4B] = X86_OP_GROUP0(EVEX4cc),
+    [0x4C] = X86_OP_GROUP0(EVEX4cc),
+    [0x4D] = X86_OP_GROUP0(EVEX4cc),
+    [0x4E] = X86_OP_GROUP0(EVEX4cc),
+    [0x4F] = X86_OP_GROUP0(EVEX4cc),
+
+    [0x60] = X86_OP_ENTRYwr(MOVBE,        G,v, M,v,     evex_apx cpuid(MOVBE) chk(nf0) p_00_66),
+    [0x61] = X86_OP_ENTRYwr(MOVBE,        M,v, G,v,     evex_apx cpuid(MOVBE) chk(nf0) p_00_66),
+    [0x66] = X86_OP_GROUP3(EVEX4_66, B,y, G,y, E,y,     evex_apx cpuid(ADX) chk(nf0) p_66_f3),
+
+    [0x80] = X86_OP_GROUP3(group1,   B,b, E,b, I,b,     evex_apx p_00),
+    [0x81] = X86_OP_GROUP3(group1,   B,v, E,v, I,z,     evex_apx p_00_66),
+    [0x83] = X86_OP_GROUP3(group1,   B,v, E,v, I,b,     evex_apx p_00_66),
+    [0x84] = X86_OP_ENTRYrr(TEST,    E,b, G,b,          evex_apx_cmp p_00_66),
+    [0x85] = X86_OP_ENTRYrr(TEST,    E,v, G,v,          evex_apx_cmp p_00_66),
+    [0x88] = X86_OP_ENTRYwr(POPCNT,  G,v, E,v,          evex_apx cpuid(POPCNT) zextT0 p_00_66),
+    [0x8F] = X86_OP_GROUPw(EVEX4_8F, R,d64, /* B,d64 */ evex_apx_pp2 p_00),
+
+    [0xA4] = X86_OP_ENTRY4(SHLD,     B,v, E,v, G,v,     evex_apx p_00_66),
+    [0xA5] = X86_OP_ENTRY3(SHLD,     B,v, E,v, G,v,     evex_apx p_00_66),
+    [0xAC] = X86_OP_ENTRY4(SHRD,     B,v, E,v, G,v,     evex_apx p_00_66),
+    [0xAD] = X86_OP_ENTRY3(SHRD,     B,v, E,v, G,v,     evex_apx p_00_66),
+    /*
+     * Note that unlike the non-APX version this cannot place the Ev
+     * operand in T0, because Bv rewrites op1 to OP_TYPE_2op if NDD=0.
+     */
+    [0xAF] = X86_OP_ENTRY3(IMUL3,    B,v, G,v, E,v,     evex_apx sextT0 p_00_66),
+
+    [0xC0] = X86_OP_GROUP3(group2,   B,b, E,b, I,b,     evex_apx p_00),
+    [0xC1] = X86_OP_GROUP3(group2,   B,v, E,v, I,b,     evex_apx p_00_66),
+
+    [0xD0] = X86_OP_GROUPwr(group2,  B,b, E,b,          evex_apx p_00),
+    [0xD1] = X86_OP_GROUPwr(group2,  B,v, E,v,          evex_apx p_00_66),
+    [0xD2] = X86_OP_GROUP3(group2,   B,b, E,b, 1,b,     evex_apx p_00), /* CL */
+    [0xD3] = X86_OP_GROUP3(group2,   B,v, E,v, 1,b,     evex_apx p_00_66), /* CL */
+
+    [0xF0] = X86_OP_ENTRY2(CRC32,    G,d, E,b,          evex_apx cpuid(SSE42) chk(nf0) p_00),
+    [0xF1] = X86_OP_ENTRY2(CRC32,    G,d, E,v,          evex_apx cpuid(SSE42) chk(nf0) p_00_66),
+    [0xF4] = X86_OP_ENTRYwr(TZCNT,   G,v, E,v,          evex_apx zextT0 p_00_66),
+    [0xF5] = X86_OP_ENTRYwr(LZCNT,   G,v, E,v,          evex_apx zextT0 p_00_66),
+    [0xF6] = X86_OP_GROUP1(group3,   E,b),
+    [0xF7] = X86_OP_GROUP1(group3,   E,v),
+    [0xFE] = X86_OP_GROUP1(group4_5, E,b),
+    [0xFF] = X86_OP_GROUP1(EVEX4_FF, E,v),
+};
+
 static void decode_EVEX_map4(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    *entry = UNKNOWN_OPCODE;
+    *b = x86_ldub_code(env, s);
+    *entry = opcodes_EVEX_map4[*b];
 }
 #endif
 
@@ -2071,6 +2255,10 @@ static void decode_EVEX_map4(DisasContext *s, CPUX86State *env, X86OpEntry *entr
 #undef vex11
 #undef vex12
 #undef vex13
+#undef evex_apx
+#undef evex_apx_cmp
+#undef evex_apx_pp2
+#undef evex_apx_zu
 
 static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
@@ -2524,6 +2712,11 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         op->n = type - X86_TYPE_ES;
         op->unit = X86_OP_SEG;
         break;
+
+    case X86_TYPE_ZERO:
+        op->unit = X86_OP_IMM;
+        decode->immediate = op->imm = 0;
+        break;
     }
 
     return true;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 48181182aa7..1144953abb1 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1644,6 +1644,30 @@ static void gen_CMC(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_xori_tl(cpu_cc_src, cpu_cc_src, CC_C);
 }
 
+#ifdef TARGET_X86_64
+static void gen_CFCMOVcc_ld(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGLabel *label_false = gen_new_label();
+    int cond = decode->b & 0xf;
+    MemOp ot = decode->op[2].ot;
+
+    gen_jcc_noeob(s, cond ^ 1, label_false);
+    gen_op_ld_v(s, ot, s->T0, s->A0);
+    gen_set_label(label_false);
+}
+
+static void gen_CFCMOVcc_st(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGLabel *label_false = gen_new_label();
+    int cond = decode->b & 0xf;
+    MemOp ot = decode->op[0].ot;
+
+    gen_jcc_noeob(s, cond ^ 1, label_false);
+    gen_op_st_v(s, ot, s->T0, s->A0);
+    gen_set_label(label_false);
+}
+#endif
+
 static void gen_CMOVcc(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_cmovcc(s, decode->b & 0xf, s->T0, s->T1);
@@ -3140,6 +3164,24 @@ static void gen_PMOVMSKB(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+#ifdef TARGET_X86_64
+static void gen_POP2(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGLabel *aligned = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cpu_regs[R_ESP], 15, aligned);
+    gen_helper_raise_gpf(tcg_env);
+    gen_set_label(aligned);
+
+    gen_lea_ss_ofs(s, s->A0, cpu_regs[R_ESP], 0);
+    gen_op_ld_v(s, MO_64, cpu_regs[s->vex_v], s->A0);
+
+    tcg_gen_addi_tl(s->A0, s->A0, 8);
+    gen_op_ld_v(s, MO_64, s->T0, s->A0);
+    gen_pop_update(s, MO_128);
+}
+#endif
+
 static void gen_POP(DisasContext *s, X86DecodedInsn *decode)
 {
     X86DecodedOp *op = &decode->op[0];
@@ -3337,6 +3379,19 @@ static void gen_PSLLDQ_i(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+#ifdef TARGET_X86_64
+static void gen_PUSH2(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGLabel *aligned = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cpu_regs[R_ESP], 15, aligned);
+    gen_helper_raise_gpf(tcg_env);
+    gen_set_label(aligned);
+    gen_push_v(s, s->T0);
+    gen_push_v(s, s->T1);
+}
+#endif
+
 static void gen_PUSH(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_push_v(s, s->T0);
-- 
2.55.0


