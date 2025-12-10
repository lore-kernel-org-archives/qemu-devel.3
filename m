Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A89D3C54B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4x-0005AM-NK; Wed, 10 Dec 2025 08:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4R-0004s8-Mq
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4N-0003Nw-A7
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=egQDJl6t4YqyJqQTl1HjJNr6XNUoQaH3/fZv6Qi6H04=;
 b=dXLB4nhNr5oW1RHphN/gsF/LWfdrrKvYo8zjAuF8C4z/EDF7VWy82CZwDNLcCZ+rgKSDHs
 nzQLBrjtr64W4U+SRRzF3IBvvCSqw8nEgG8jPbyMqzqiDK9k1Z2p68/eKIUDHmpBvTQ8hK
 YTx6R3WIiy2aW1UbNGi2w4YrkvTxVJ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-RchannewO0SEzGbPmPxw7Q-1; Wed, 10 Dec 2025 08:17:25 -0500
X-MC-Unique: RchannewO0SEzGbPmPxw7Q-1
X-Mimecast-MFC-AGG-ID: RchannewO0SEzGbPmPxw7Q_1765372644
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47777158a85so81487445e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372643; x=1765977443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=egQDJl6t4YqyJqQTl1HjJNr6XNUoQaH3/fZv6Qi6H04=;
 b=MzQ1hdBZD2nZhuaQdy5UgL2PImzb9uG6tDOMuFbpm2qNVcbQC+iG1DPpi75E3f824G
 RhL3qQS5aChVZKLZhsNgfUp+K6MxmYATrhQh8hFPcrTMakFCZj4JhzgN8wxkT1peuLr+
 kXO2YzAp1OFBEvZGUAKgKc3HI2aR/AcYdUqwmihO40qRFX5oEW79fSBYF7BJCYhQD6LM
 wmVbtHt5GnzAgequ0HMaGUk90Cm0xhTUB5XvT8eiqYCR9PorjCizcE1JsNZphRM9V4nS
 4I2aPg3vkSQYhs0ZYnRDqn9catCGPQVBY2oZSha6+G52IFonOG+Zt67EXG8aI/HuO3/u
 M/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372643; x=1765977443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=egQDJl6t4YqyJqQTl1HjJNr6XNUoQaH3/fZv6Qi6H04=;
 b=TdSRYKMsXalwKAxhhDzF35bHiZfAFCGNcqaDosaclexsz1e2ufMHs/v47kWqhPuQQK
 NL7p3UpWOxVDuyXimZpy/id3RMX/5BQDgEl2iwRC/wi0Kteazu+Hdd9+qKLO1hy+hvZd
 9QtljDwT3uAZJiszXVIv8emYjTH80btunpErArTi1TJa6f05ZJH77Dal21kVBSfvfrXd
 B8JSogCyliD15esXUYb0pHHvKliUEpGkQoTQkn2ENj8gMB/qHZPlaGACRuwS3EaYkklY
 ru0OcC4GveQsykFO/tWBFNJRXEz3tsyIjCjrzs4N4lx+eOKLLzStBvmYUw0QRp8+89xZ
 Qbrw==
X-Gm-Message-State: AOJu0YzOGU2vYhNl1hf4tySkhgn4zvVIjpTIymjijUlVvkpfT3EhvLF2
 L6lZTzwXeeOi5sfN6kuYYhX2wRiCxiNAqKfZrNmnOroHy4/jGOLW+mDXl210wcoqHOTX/5TYnpT
 GPeIDFjPOqcg576yTfIXPy5LfEZPeZe7xATjhc12H0u8IxyZyR67UQVlGblC65tuREbb7fEDrp+
 fPGPpR90Czd5gLOR4qRjXz8ZlKcBqs0PGtPq9ZDuZx
X-Gm-Gg: ASbGncsl0AYx9K7vdw0L2esdzvmZ8QhcQMkm5v0TLZgtIu9VVqitYShbmY7SIuS+qpW
 mjyUw7/ZmeqsbnfrjBhXaTOU85oAbDHmVpRydkWqGO5iNzBQ0z/BkfrMveNV8bAQhoF1UaKxw0f
 IU6dJH8YxlGZ4tugs2AcJhenCB1T81kNbnXEpThHD6PSS+WH0L7FV6uAqmuCkCc2w0NOUjB1mn9
 XIhLYMVZMe6OCuivoQ5hfuIRmVL/Jo8ZuxG2rwAm/CVf2h0oxP+lEFmkgEks6hOsw8PQu4J79gG
 Mfl9LKdGL8rbVLrgdCdk0qPg3/okNMxmcNdPgcCr/nf9OW3YMqDPhxxRDN6T1Y33eDZKXX37jBj
 juoWIw1AlPpQZvvP1YgOmirrrq0ryFiCAMMayLyhR7hQ25aUolRvyNuFRQ9vs0wneP2bNEM2UbJ
 WUdBrc2oogvGsFJ7c=
X-Received: by 2002:a05:600c:3e1a:b0:477:7b30:a6fe with SMTP id
 5b1f17b1804b1-47a837923b0mr26365495e9.18.1765372643120; 
 Wed, 10 Dec 2025 05:17:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpavXF6icWeQFsFzP2fiMUFXhJpfivqca76l8ioMmw2CzjI1p46rZOUG2jW+3p/FXAyZ/mLQ==
X-Received: by 2002:a05:600c:3e1a:b0:477:7b30:a6fe with SMTP id
 5b1f17b1804b1-47a837923b0mr26364895e9.18.1765372642263; 
 Wed, 10 Dec 2025 05:17:22 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d935d4sm45943955e9.15.2025.12.10.05.17.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/18] target/i386/tcg: commonize code to compute SF/ZF/PF
Date: Wed, 10 Dec 2025 14:16:51 +0100
Message-ID: <20251210131653.852163-17-pbonzini@redhat.com>
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

PF/ZF/SF are computed the same way for almost all CC_OP values (depending
only on the operand size in the case of ZF and SF).  The only exception is
PF for CC_OP_BLSI* and CC_OP_BMILG*; but AMD documents that PF should
be computed normally (rather than being undefined) so that is a kind of
bug fix.

Put the common code at the end of helper_cc_compute_all, shaving
another kB from its text.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                        |   4 +-
 target/i386/tcg/cc_helper_template.h.inc | 112 +++------
 target/i386/tcg/cc_helper.c              | 274 +++++++++++++++--------
 3 files changed, 209 insertions(+), 181 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cee1f692a1c..ecca38ed0b5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1495,12 +1495,12 @@ typedef enum {
     CC_OP_SARL,
     CC_OP_SARQ,
 
-    CC_OP_BMILGB, /* Z,S via CC_DST, C = SRC==0; O=0; P,A undefined */
+    CC_OP_BMILGB, /* P,Z,S via CC_DST, C = SRC==0; A=O=0 */
     CC_OP_BMILGW,
     CC_OP_BMILGL,
     CC_OP_BMILGQ,
 
-    CC_OP_BLSIB, /* Z,S via CC_DST, C = SRC!=0; O=0; P,A undefined */
+    CC_OP_BLSIB, /* P,Z,S via CC_DST, C = SRC!=0; A=O=0 */
     CC_OP_BLSIW,
     CC_OP_BLSIL,
     CC_OP_BLSIQ,
diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index d8fd976ca15..af58c2409f7 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -1,5 +1,5 @@
 /*
- *  x86 condition code helpers
+ *  x86 condition code helpers for AF/CF/OF
  *
  *  Copyright (c) 2008 Fabrice Bellard
  *
@@ -44,14 +44,9 @@
 
 /* dynamic flags computation */
 
-static uint32_t glue(compute_all_cout, SUFFIX)(DATA_TYPE dst, DATA_TYPE carries)
+static uint32_t glue(compute_aco_cout, SUFFIX)(DATA_TYPE carries)
 {
-    uint32_t af_cf, pf, zf, sf, of;
-
-    /* PF, ZF, SF computed from result.  */
-    pf = compute_pf(dst);
-    zf = (dst == 0) * CC_Z;
-    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
+    uint32_t af_cf, of;
 
     /*
      * AF, CF, OF computed from carry out vector.  To compute AF and CF, rotate it
@@ -62,14 +57,14 @@ static uint32_t glue(compute_all_cout, SUFFIX)(DATA_TYPE dst, DATA_TYPE carries)
      */
     af_cf = ((carries << 1) | (carries >> (DATA_BITS - 1))) & (CC_A | CC_C);
     of = (lshift(carries, 12 - DATA_BITS) + CC_O / 2) & CC_O;
-    return pf + zf + sf + af_cf + of;
+    return af_cf + of;
 }
 
-static uint32_t glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_aco_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
     DATA_TYPE src2 = dst - src1;
     DATA_TYPE carries = ADD_COUT_VEC(src1, src2, dst);
-    return glue(compute_all_cout, SUFFIX)(dst, carries);
+    return glue(compute_aco_cout, SUFFIX)(carries);
 }
 
 static int glue(compute_c_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
@@ -77,12 +72,12 @@ static int glue(compute_c_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return dst < src1;
 }
 
-static uint32_t glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
+static uint32_t glue(compute_aco_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
                                          DATA_TYPE src3)
 {
     DATA_TYPE src2 = dst - src1 - src3;
     DATA_TYPE carries = ADD_COUT_VEC(src1, src2, dst);
-    return glue(compute_all_cout, SUFFIX)(dst, carries);
+    return glue(compute_aco_cout, SUFFIX)(carries);
 }
 
 static int glue(compute_c_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
@@ -97,11 +92,11 @@ static int glue(compute_c_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
 #endif
 }
 
-static uint32_t glue(compute_all_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
+static uint32_t glue(compute_aco_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
 {
     DATA_TYPE src1 = dst + src2;
     DATA_TYPE carries = SUB_COUT_VEC(src1, src2, dst);
-    return glue(compute_all_cout, SUFFIX)(dst, carries);
+    return glue(compute_aco_cout, SUFFIX)(carries);
 }
 
 static int glue(compute_c_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
@@ -111,12 +106,12 @@ static int glue(compute_c_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
     return src1 < src2;
 }
 
-static uint32_t glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
+static uint32_t glue(compute_aco_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
                                          DATA_TYPE src3)
 {
     DATA_TYPE src1 = dst + src2 + src3;
     DATA_TYPE carries = SUB_COUT_VEC(src1, src2, dst);
-    return glue(compute_all_cout, SUFFIX)(dst, carries);
+    return glue(compute_aco_cout, SUFFIX)(carries);
 }
 
 static int glue(compute_c_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
@@ -134,57 +129,35 @@ static int glue(compute_c_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
 #endif
 }
 
-static uint32_t glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_aco_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    uint32_t cf, pf, af, zf, sf, of;
-
-    cf = 0;
-    pf = compute_pf(dst);
-    af = 0;
-    zf = (dst == 0) * CC_Z;
-    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
-    of = 0;
-    return cf + pf + af + zf + sf + of;
-}
-
-static uint32_t glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
-{
-    uint32_t cf, pf, af, zf, sf, of;
+    uint32_t cf, af, of;
 
     cf = src1;
-    pf = compute_pf(dst);
     af = (dst ^ (dst - 1)) & CC_A; /* bits 0..3 are all clear */
-    zf = (dst == 0) * CC_Z;
-    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = (dst == SIGN_MASK) * CC_O;
-    return cf + pf + af + zf + sf + of;
+    return cf + af + of;
 }
 
-static uint32_t glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_aco_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    uint32_t cf, pf, af, zf, sf, of;
+    uint32_t cf, af, of;
 
     cf = src1;
-    pf = compute_pf(dst);
     af = (dst ^ (dst + 1)) & CC_A; /* bits 0..3 are all set */
-    zf = (dst == 0) * CC_Z;
-    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = (dst == SIGN_MASK - 1) * CC_O;
-    return cf + pf + af + zf + sf + of;
+    return cf + af + of;
 }
 
-static uint32_t glue(compute_all_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_aco_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    uint32_t cf, pf, af, zf, sf, of;
+    uint32_t cf, af, of;
 
     cf = (src1 >> (DATA_BITS - 1)) & CC_C;
-    pf = compute_pf(dst);
     af = 0; /* undefined */
-    zf = (dst == 0) * CC_Z;
-    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     /* of is defined iff shift count == 1 */
     of = lshift(src1 ^ dst, 12 - DATA_BITS) & CC_O;
-    return cf + pf + af + zf + sf + of;
+    return cf + af + of;
 }
 
 static int glue(compute_c_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
@@ -192,47 +165,25 @@ static int glue(compute_c_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return (src1 >> (DATA_BITS - 1)) & CC_C;
 }
 
-static uint32_t glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_aco_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    uint32_t cf, pf, af, zf, sf, of;
+    uint32_t cf, af, of;
 
     cf = src1 & 1;
-    pf = compute_pf(dst);
     af = 0; /* undefined */
-    zf = (dst == 0) * CC_Z;
-    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     /* of is defined iff shift count == 1 */
     of = lshift(src1 ^ dst, 12 - DATA_BITS) & CC_O;
-    return cf + pf + af + zf + sf + of;
+    return cf + af + of;
 }
 
-/* NOTE: we compute the flags like the P4. On olders CPUs, only OF and
-   CF are modified and it is slower to do that.  Note as well that we
-   don't truncate SRC1 for computing carry to DATA_TYPE.  */
-static uint32_t glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
+static uint32_t glue(compute_aco_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    uint32_t cf, pf, af, zf, sf, of;
-
-    cf = (src1 != 0);
-    pf = compute_pf(dst);
-    af = 0; /* undefined */
-    zf = (dst == 0) * CC_Z;
-    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
-    of = cf * CC_O;
-    return cf + pf + af + zf + sf + of;
-}
-
-static uint32_t glue(compute_all_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
-{
-    uint32_t cf, pf, af, zf, sf, of;
+    uint32_t cf, af, of;
 
     cf = (src1 == 0);
-    pf = 0; /* undefined */
     af = 0; /* undefined */
-    zf = (dst == 0) * CC_Z;
-    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = 0;
-    return cf + pf + af + zf + sf + of;
+    return cf + af + of;
 }
 
 static int glue(compute_c_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
@@ -240,17 +191,14 @@ static int glue(compute_c_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return src1 == 0;
 }
 
-static int glue(compute_all_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static int glue(compute_aco_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    uint32_t cf, pf, af, zf, sf, of;
+    uint32_t cf, af, of;
 
     cf = (src1 != 0);
-    pf = 0; /* undefined */
     af = 0; /* undefined */
-    zf = (dst == 0) * CC_Z;
-    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = 0;
-    return cf + pf + af + zf + sf + of;
+    return cf + af + of;
 }
 
 static int glue(compute_c_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index f1940b40927..2c4170b5b77 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -73,9 +73,25 @@ target_ulong helper_cc_compute_nz(target_ulong dst, target_ulong src1,
     }
 }
 
+/* NOTE: we compute the flags like the P4. On olders CPUs, only OF and
+   CF are modified and it is slower to do that.  Note as well that we
+   don't truncate SRC1 for computing carry to DATA_TYPE.  */
+static inline uint32_t compute_aco_mul(target_long src1)
+{
+    uint32_t cf, af, of;
+
+    cf = (src1 != 0);
+    af = 0; /* undefined */
+    of = cf * CC_O;
+    return cf + af + of;
+}
+
 target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
                                    target_ulong src2, int op)
 {
+    uint32_t flags = 0;
+    int shift = 0;
+
     switch (op) {
     default: /* should never happen */
         return 0;
@@ -85,90 +101,6 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
     case CC_OP_POPCNT:
         return dst ? 0 : CC_Z;
 
-    case CC_OP_MULB:
-        return compute_all_mulb(dst, src1);
-    case CC_OP_MULW:
-        return compute_all_mulw(dst, src1);
-    case CC_OP_MULL:
-        return compute_all_mull(dst, src1);
-
-    case CC_OP_ADDB:
-        return compute_all_addb(dst, src1);
-    case CC_OP_ADDW:
-        return compute_all_addw(dst, src1);
-    case CC_OP_ADDL:
-        return compute_all_addl(dst, src1);
-
-    case CC_OP_ADCB:
-        return compute_all_adcb(dst, src1, src2);
-    case CC_OP_ADCW:
-        return compute_all_adcw(dst, src1, src2);
-    case CC_OP_ADCL:
-        return compute_all_adcl(dst, src1, src2);
-
-    case CC_OP_SUBB:
-        return compute_all_subb(dst, src1);
-    case CC_OP_SUBW:
-        return compute_all_subw(dst, src1);
-    case CC_OP_SUBL:
-        return compute_all_subl(dst, src1);
-
-    case CC_OP_SBBB:
-        return compute_all_sbbb(dst, src1, src2);
-    case CC_OP_SBBW:
-        return compute_all_sbbw(dst, src1, src2);
-    case CC_OP_SBBL:
-        return compute_all_sbbl(dst, src1, src2);
-
-    case CC_OP_LOGICB:
-        return compute_all_logicb(dst, src1);
-    case CC_OP_LOGICW:
-        return compute_all_logicw(dst, src1);
-    case CC_OP_LOGICL:
-        return compute_all_logicl(dst, src1);
-
-    case CC_OP_INCB:
-        return compute_all_incb(dst, src1);
-    case CC_OP_INCW:
-        return compute_all_incw(dst, src1);
-    case CC_OP_INCL:
-        return compute_all_incl(dst, src1);
-
-    case CC_OP_DECB:
-        return compute_all_decb(dst, src1);
-    case CC_OP_DECW:
-        return compute_all_decw(dst, src1);
-    case CC_OP_DECL:
-        return compute_all_decl(dst, src1);
-
-    case CC_OP_SHLB:
-        return compute_all_shlb(dst, src1);
-    case CC_OP_SHLW:
-        return compute_all_shlw(dst, src1);
-    case CC_OP_SHLL:
-        return compute_all_shll(dst, src1);
-
-    case CC_OP_SARB:
-        return compute_all_sarb(dst, src1);
-    case CC_OP_SARW:
-        return compute_all_sarw(dst, src1);
-    case CC_OP_SARL:
-        return compute_all_sarl(dst, src1);
-
-    case CC_OP_BMILGB:
-        return compute_all_bmilgb(dst, src1);
-    case CC_OP_BMILGW:
-        return compute_all_bmilgw(dst, src1);
-    case CC_OP_BMILGL:
-        return compute_all_bmilgl(dst, src1);
-
-    case CC_OP_BLSIB:
-        return compute_all_blsib(dst, src1);
-    case CC_OP_BLSIW:
-        return compute_all_blsiw(dst, src1);
-    case CC_OP_BLSIL:
-        return compute_all_blsil(dst, src1);
-
     case CC_OP_ADCX:
         return compute_all_adcx(dst, src1, src2);
     case CC_OP_ADOX:
@@ -176,33 +108,181 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
     case CC_OP_ADCOX:
         return compute_all_adcox(dst, src1, src2);
 
+    case CC_OP_MULB:
+        flags = compute_aco_mul(src1);
+        goto psz_b;
+    case CC_OP_MULW:
+        flags = compute_aco_mul(src1);
+        goto psz_w;
+    case CC_OP_MULL:
+        flags = compute_aco_mul(src1);
+        goto psz_l;
+
+    case CC_OP_ADDB:
+        flags = compute_aco_addb(dst, src1);
+        goto psz_b;
+    case CC_OP_ADDW:
+        flags = compute_aco_addw(dst, src1);
+        goto psz_w;
+    case CC_OP_ADDL:
+        flags = compute_aco_addl(dst, src1);
+        goto psz_l;
+
+    case CC_OP_ADCB:
+        flags = compute_aco_adcb(dst, src1, src2);
+        goto psz_b;
+    case CC_OP_ADCW:
+        flags = compute_aco_adcw(dst, src1, src2);
+        goto psz_w;
+    case CC_OP_ADCL:
+        flags = compute_aco_adcl(dst, src1, src2);
+        goto psz_l;
+
+    case CC_OP_SUBB:
+        flags = compute_aco_subb(dst, src1);
+        goto psz_b;
+    case CC_OP_SUBW:
+        flags = compute_aco_subw(dst, src1);
+        goto psz_w;
+    case CC_OP_SUBL:
+        flags = compute_aco_subl(dst, src1);
+        goto psz_l;
+
+    case CC_OP_SBBB:
+        flags = compute_aco_sbbb(dst, src1, src2);
+        goto psz_b;
+    case CC_OP_SBBW:
+        flags = compute_aco_sbbw(dst, src1, src2);
+        goto psz_w;
+    case CC_OP_SBBL:
+        flags = compute_aco_sbbl(dst, src1, src2);
+        goto psz_l;
+
+    case CC_OP_LOGICB:
+        flags = 0;
+        goto psz_b;
+    case CC_OP_LOGICW:
+        flags = 0;
+        goto psz_w;
+    case CC_OP_LOGICL:
+        flags = 0;
+        goto psz_l;
+
+    case CC_OP_INCB:
+        flags = compute_aco_incb(dst, src1);
+        goto psz_b;
+    case CC_OP_INCW:
+        flags = compute_aco_incw(dst, src1);
+        goto psz_w;
+    case CC_OP_INCL:
+        flags = compute_aco_incl(dst, src1);
+        goto psz_l;
+
+    case CC_OP_DECB:
+        flags = compute_aco_decb(dst, src1);
+        goto psz_b;
+    case CC_OP_DECW:
+        flags = compute_aco_decw(dst, src1);
+        goto psz_w;
+    case CC_OP_DECL:
+        flags = compute_aco_decl(dst, src1);
+        goto psz_l;
+
+    case CC_OP_SHLB:
+        flags = compute_aco_shlb(dst, src1);
+        goto psz_b;
+    case CC_OP_SHLW:
+        flags = compute_aco_shlw(dst, src1);
+        goto psz_w;
+    case CC_OP_SHLL:
+        flags = compute_aco_shll(dst, src1);
+        goto psz_l;
+
+    case CC_OP_SARB:
+        flags = compute_aco_sarb(dst, src1);
+        goto psz_b;
+    case CC_OP_SARW:
+        flags = compute_aco_sarw(dst, src1);
+        goto psz_w;
+    case CC_OP_SARL:
+        flags = compute_aco_sarl(dst, src1);
+        goto psz_l;
+
+    case CC_OP_BMILGB:
+        flags = compute_aco_bmilgb(dst, src1);
+        goto psz_b;
+    case CC_OP_BMILGW:
+        flags = compute_aco_bmilgw(dst, src1);
+        goto psz_w;
+    case CC_OP_BMILGL:
+        flags = compute_aco_bmilgl(dst, src1);
+        goto psz_l;
+
+    case CC_OP_BLSIB:
+        flags = compute_aco_blsib(dst, src1);
+        goto psz_b;
+    case CC_OP_BLSIW:
+        flags = compute_aco_blsiw(dst, src1);
+        goto psz_w;
+    case CC_OP_BLSIL:
+        flags = compute_aco_blsil(dst, src1);
+        goto psz_l;
+
 #ifdef TARGET_X86_64
     case CC_OP_MULQ:
-        return compute_all_mulq(dst, src1);
+        flags = compute_aco_mul(src1);
+        goto psz_q;
     case CC_OP_ADDQ:
-        return compute_all_addq(dst, src1);
+        flags = compute_aco_addq(dst, src1);
+        goto psz_q;
     case CC_OP_ADCQ:
-        return compute_all_adcq(dst, src1, src2);
+        flags = compute_aco_adcq(dst, src1, src2);
+        goto psz_q;
     case CC_OP_SUBQ:
-        return compute_all_subq(dst, src1);
+        flags = compute_aco_subq(dst, src1);
+        goto psz_q;
     case CC_OP_SBBQ:
-        return compute_all_sbbq(dst, src1, src2);
-    case CC_OP_LOGICQ:
-        return compute_all_logicq(dst, src1);
+        flags = compute_aco_sbbq(dst, src1, src2);
+        goto psz_q;
     case CC_OP_INCQ:
-        return compute_all_incq(dst, src1);
+        flags = compute_aco_incq(dst, src1);
+        goto psz_q;
     case CC_OP_DECQ:
-        return compute_all_decq(dst, src1);
+        flags = compute_aco_decq(dst, src1);
+        goto psz_q;
+    case CC_OP_LOGICQ:
+        flags = 0;
+        goto psz_q;
     case CC_OP_SHLQ:
-        return compute_all_shlq(dst, src1);
+        flags = compute_aco_shlq(dst, src1);
+        goto psz_q;
     case CC_OP_SARQ:
-        return compute_all_sarq(dst, src1);
+        flags = compute_aco_sarq(dst, src1);
+        goto psz_q;
     case CC_OP_BMILGQ:
-        return compute_all_bmilgq(dst, src1);
+        flags = compute_aco_bmilgq(dst, src1);
+        goto psz_q;
     case CC_OP_BLSIQ:
-        return compute_all_blsiq(dst, src1);
+        flags = compute_aco_blsiq(dst, src1);
+        goto psz_q;
 #endif
     }
+
+psz_b:
+    shift += 8;
+psz_w:
+    shift += 16;
+psz_l:
+#ifdef TARGET_X86_64
+    shift += 32;
+psz_q:
+#endif
+
+    flags += compute_pf(dst);
+    dst <<= shift;
+    flags += dst == 0 ? CC_Z : 0;
+    flags += (target_long)dst < 0 ? CC_S : 0;
+    return flags;
 }
 
 uint32_t cpu_cc_compute_all(CPUX86State *env)
-- 
2.52.0


