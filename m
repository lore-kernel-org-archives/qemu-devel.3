Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7BACA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB0c-0005CD-PX; Mon, 28 Sep 2026 09:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0Q-00059g-JD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0N-0004Li-VJ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8Z2Howvt+ht69Xjzhv6iIFW39HwWL2tc8fuzRCp4fM=;
 b=A//roeH50/NeNjdcfcyhP5pQAT7PR/GTfKkNlbTJNDYx+L6jsZD/HdCp7mMuQuaNTDnKUY
 +X8/8iMYiwVxevz7AkIXk10coPhTdnl9HBsrnxNt/jMtJNum1N8F420D7HhWwBOyPZ+mC+
 lXx9M1MAgUHZ2B4nNtL19WWBywbWbfs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-6HBFt9_YN_yFbBbw_iviAg-1; Mon, 28 Sep 2026 09:02:49 -0400
X-MC-Unique: 6HBFt9_YN_yFbBbw_iviAg-1
X-Mimecast-MFC-AGG-ID: 6HBFt9_YN_yFbBbw_iviAg_1790600568
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c293e604f0eso286404466b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600568; x=1791205368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w8Z2Howvt+ht69Xjzhv6iIFW39HwWL2tc8fuzRCp4fM=;
 b=nU5vdzC+ciHYxPVzOSFR8oUpNoAsjID2ix8tZkMq43JcRV7YSzJcPzS8cDlzM1+6hX
 q6jn3MmV40Eu1hSSGNYsQkwMXiJLgSVhsU/9a/CRD8PG5pDYsl+T/ZkjauTHgZaY429B
 ifapuayzj1tiQkujFJY/AplwceO2xX2iF/K7e1rVp8pObQlrrTBuiNSW03mJJBzOOJgF
 FMQoPgsjRzbiOQeZNZtgT6cesVBSl0W9lJaN6fyLpqU1mnZixg2UCH/422/Dt5qYtrsE
 rojt+dlVVjlMobJJccYV+EYitTyIsEAC5gHATA/iex0wuX9wpLARGi4uEKdF/dkV7oMG
 ZcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600568; x=1791205368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w8Z2Howvt+ht69Xjzhv6iIFW39HwWL2tc8fuzRCp4fM=;
 b=MRwzKRNw1Xm56/1CBacR1GR+L+mIyAhFP6ZNCxtmTffOgVd9JS+kPGnXPBX51TEk3B
 lcq8tRwwKkx8QJIcMD3KZcBB0ctYrCDGsrkp/hbPtZ0UJebjA600xfAN4JJblybJBLtf
 0vSzewd0d6uqgOd6OBdtXJ4mqlWDica60W5G702rsKpOf4U+M6EBZIXAeXtOFri4KMxI
 spL9BNW0ncxXPp72FvM5U+Qj6ltx2iEZGU9tbRaETDOnxIIhd4aNs3XTQ/WK6shLF1Kx
 RL1lR3M9NDm+e/KGXzFCjn05a6cUVeelg+al4qnUA+DXXgEBPsgbKg8jGSC+yKInjd4U
 ZNyA==
X-Gm-Message-State: AFuF++n/IM53r5zGJo9zaIbCiHzM/yyyATfnCCNx5Iy/31lTmxSSTn9W
 YONLiHZ4Ki9+mJa8nbBVmDsuDd3CczzfrjgKiTNpfHB/ss0yv/LjuoFeItTR7w2/E6LIYV3dw++
 eMz77LNWbMrL/bzvNdZekZvb6/wihFew04WqEmEdrTkebZsgImxJ2r51TgNC4vTiQhqQCQTlFuS
 8rTbgoaveeOojDp2SkH86MOd2Cgq7aSj7kWAJG5w3w
X-Gm-Gg: AYBFou2CJT+oCHPBSRSbweCjvuhCk8BQ2EkwS8/MaWnYUmDDiWwbAiLZ4YN8PryO+lr
 hGJXDxXntclYZmFMlxbOsblSTi0/b+hYXB/eCT8NQlYvNtm8VCIHSA4xoqgUbK96cT7RZxcU/y9
 Jj5WSf10+L1iFsZXTikQPHw21ej691mBFMpRM8cVzI/A4k4qRfo6PXZVcosLJBMJdaBDx+d9WgK
 npi9L8bAncV3P6OjCWYzC8lvyDxj7Y/cK+BYzOjdcL1ngmf+/v2RRf7OEkNV1gAgf64hSp0A4ho
 8qgzLcLIrPxqY1q2Y5TZfyJIMJZmPjNd1681/ytFSGbgm642FdC66FfnFcu0QwfT2doKeEtiU0L
 rhmmoJX8MwnAC8E3egDAl/IsgcjLQId4/4NXa0CGkY61IxlNTxW8v+m7n2/ZOed+ZHQ==
X-Received: by 2002:a17:907:1999:b0:c29:349e:7c1d with SMTP id
 a640c23a62f3a-c2ac268060fmr1028062466b.49.1790600567887; 
 Mon, 28 Sep 2026 06:02:47 -0700 (PDT)
X-Received: by 2002:a17:907:1999:b0:c29:349e:7c1d with SMTP id
 a640c23a62f3a-c2ac268060fmr1028058766b.49.1790600567189; 
 Mon, 28 Sep 2026 06:02:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2ae757857bsm461898066b.24.2026.09.28.06.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:02:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andrey Polivoda <apolivodaa433@gmail.com>
Subject: [PULL 06/30] target/i386/tcg: ignore VEX.L for unary scalar
 instructions
Date: Mon, 28 Sep 2026 15:02:04 +0200
Message-ID: <20260928130228.877003-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

According to both Volume 2 of Intel 64 and IA-32 Architectures Software
Developer's Manual and Volume 4 of AMD64 Architecture Programmer's Manual,
VEX.L is a "don't care" bit for `VROUNDSS`, `VROUNDSD`, `VMOVSS`, `VMOVSD`.

Currently, QEMU handles VEX.L with these instructions differently:
- In the VMOVSS and VMOVSD case, VEX.L allows to select the register size
  (XMM or YMM), leading to differences between QEMU and the real hardware.
- In `gen_VROUNDSS()` and `gen_VROUNDSD()`, there is an assert which checks
  that `s->vex_l` is not set. When either instruction is encountered with VEX.L
  bit set, the QEMU process crashes with an assertion failure.

These behaviors deviate from real hardware, and in VROUNDSS/VROUNDSD case,
it also allows unprivileged guest userspace to crash the QEMU process itself.
Instead, always handle the instructions as if VEX.L=0.

Reported-by: Andrey Polivoda <apolivodaa433@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  6 ++++++
 target/i386/tcg/decode-new.c.inc | 17 +++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 92822969003..25f7d2215ee 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -263,6 +263,12 @@ typedef enum X86VEXSpecial {
      * operands, and thus handled by decode_op_size.
      */
     X86_VEX_AVX2_256,
+
+    /*
+     * Instructions that do not care about VEX.L; used for scalar operands, because
+     * they *should* be used only with VEX.L=0 but may accept VEX.L=1 on some machines.
+     */
+    X86_VEX_LIG,
 } X86VEXSpecial;
 
 
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 459452b04e3..8d1e581cfde 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -260,6 +260,7 @@
 #define svm(a) .intercept = SVM_EXIT_##a, .has_intercept = true,
 
 #define avx2_256 .vex_special = X86_VEX_AVX2_256,
+#define vex_lig .vex_special = X86_VEX_LIG,
 
 #define P_00          1
 #define P_66          (1 << PREFIX_DATA)
@@ -996,8 +997,8 @@ static const X86OpEntry opcodes_0F3A[256] = {
      * For other unary operations such as VSQRTSx this is hidden by the "REPScalar"
      * value of vex_special, because the table lists the operand types of VSQRTPx.
      */
-    [0x0a] = X86_OP_ENTRY4(VROUNDSS,   V,x,  H,x, W,ss, vex3 cpuid(SSE41) p_66),
-    [0x0b] = X86_OP_ENTRY4(VROUNDSD,   V,x,  H,x, W,sd, vex3 cpuid(SSE41) p_66),
+    [0x0a] = X86_OP_ENTRY4(VROUNDSS,   V,x,  H,x, W,ss, vex3 vex_lig cpuid(SSE41) p_66),
+    [0x0b] = X86_OP_ENTRY4(VROUNDSD,   V,x,  H,x, W,sd, vex3 vex_lig cpuid(SSE41) p_66),
     [0x0c] = X86_OP_ENTRY4(VBLENDPS,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) p_66),
     [0x0d] = X86_OP_ENTRY4(VBLENDPD,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) p_66),
     [0x0e] = X86_OP_ENTRY4(VPBLENDW,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
@@ -1053,8 +1054,8 @@ static void decode_0F10(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0F10_mem[4] = {
         X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x,  vex4_unal), /* MOVUPS */
         X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x,  vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS_ld,  V,x,  H,x,       M,ss, vex5),
-        X86_OP_ENTRY3(VMOVSD_ld,  V,x,  H,x,       M,sd, vex5),
+        X86_OP_ENTRY3(VMOVSS_ld,  V,x,  H,x,       M,ss, vex5 vex_lig),
+        X86_OP_ENTRY3(VMOVSD_ld,  V,x,  H,x,       M,sd, vex5 vex_lig),
     };
 
     if ((get_modrm(s, env) >> 6) == 3) {
@@ -1076,8 +1077,8 @@ static void decode_0F11(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0F11_mem[4] = {
         X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4_unal), /* MOVUPS */
         X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex5),
-        X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex5), /* MOVSD */
+        X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex5 vex_lig),
+        X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex5 vex_lig), /* MOVSD */
     };
 
     if ((get_modrm(s, env) >> 6) == 3) {
@@ -2653,6 +2654,10 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
     case X86_VEX_None:
         break;
 
+    case X86_VEX_LIG:
+        s->vex_l = 0;
+        break;
+
     case X86_VEX_REPScalar:
         /*
          * Instructions which differ between 00/66 and F2/F3 in the
-- 
2.55.0


