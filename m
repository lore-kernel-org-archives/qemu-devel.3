Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44ADC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFre9-0001hN-8k; Sat, 08 Jun 2024 04:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFre7-0001dT-Io
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFre5-0001Q5-PS
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1J3/JD1dn7MgaT8Ll/a2KX3nRmtx9rCL7vpXkttTP8=;
 b=g2shNsR8O7z8hMuRgEejcXPZo3Jw2/SPHM2pdmSQuoWw/iRA5GscwFSspx5CR63rZOXhZ7
 xBhJFM0zx7x6YYPRTtE8y6HDHawTQXXktCkirkbWE/f4l5CaYQBmcEvXJp1ZfFvhkAqffG
 B2kILyVydLedgleFmo1DHZckEEVVcIM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-iJ6EVuG9PEShWwTDHqYEtQ-1; Sat, 08 Jun 2024 04:41:50 -0400
X-MC-Unique: iJ6EVuG9PEShWwTDHqYEtQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6c72164f46so151784166b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836108; x=1718440908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1J3/JD1dn7MgaT8Ll/a2KX3nRmtx9rCL7vpXkttTP8=;
 b=slCtIbE02nG5jloOSl2fn9XgXF0QDbfTCLNviqM891Jr9NKIYLME7CcrovuiNRMt7L
 dDUI8v5ioAsFLgM6LpjYrMBvFyT8ZlaoOIkAppZum/Y2InKAtBZXmiMCHSJ/qoHv0CsM
 Muc8+uiK511Z9Kd3hYWne104zYC1nJA3lvVm3yTJ7lgxkllfyMLcS/BpyEbOSzjwQPUL
 nXj71gZtzHo6iY8R6LIMCQXafjNtBNVhnRMTTv4mM0XDwPWQXqXWnMESc3egcVFovt1p
 do32mA8BjSnkMXkSWBwCnKGVnsxJBel6pH3gwQJ78kYRJsDg6CEyUAJBP4BpF/zXQXlc
 tw7g==
X-Gm-Message-State: AOJu0YyI12w+aAhbaHGjZKTQRDtOw9GwtWfhTGGMdA0qXwIlLpBY//j6
 MwyB6IzLsBtBHbfuYQ8XLcERxemigLsAhdD6+Y26Up60VEdWWeHxpCzkB0cfeHXbwWhkxkw+q7Y
 ayzH+k1sq8lIkEXPboG8jb9hJ66LgesYNfblih5nlbvnxmMWph9W1kW1CttXrjQp5tEOPDmzh96
 LCbRElsl1Cm6iP4xScKV+oc+HiSGGl1F1ZMi16
X-Received: by 2002:a17:906:6953:b0:a68:be21:8dca with SMTP id
 a640c23a62f3a-a6cd561a934mr301993166b.10.1717836108513; 
 Sat, 08 Jun 2024 01:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3vHcAzvdhy79AqHo6t6sYrYmDKux2gq77OmDRSzwflzUCiN6eps7a8lSpYK2EYyKnbGXhtA==
X-Received: by 2002:a17:906:6953:b0:a68:be21:8dca with SMTP id
 a640c23a62f3a-a6cd561a934mr301992266b.10.1717836107958; 
 Sat, 08 Jun 2024 01:41:47 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f0cdfb226sm26713866b.151.2024.06.08.01.41.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:41:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/25] target/i386: fix bad sorting of entries in the 0F table
Date: Sat,  8 Jun 2024 10:40:57 +0200
Message-ID: <20240608084113.2770363-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Aesthetic change only.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 93 ++++++++++++++++----------------
 1 file changed, 46 insertions(+), 47 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 4c567911f41..4e745f10dd8 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1006,14 +1006,6 @@ static void decode_MOV_CR_DR(DisasContext *s, CPUX86State *env, X86OpEntry *entr
 }
 
 static const X86OpEntry opcodes_0F[256] = {
-    [0x0E] = X86_OP_ENTRY0(EMMS,                              cpuid(3DNOW)), /* femms */
-    /*
-     * 3DNow!'s opcode byte comes *after* modrm and displacements, making it
-     * more like an Ib operand.  Dispatch to the right helper in a single gen_*
-     * function.
-     */
-    [0x0F] = X86_OP_ENTRY3(3dnow,       P,q, Q,q, I,b,        cpuid(3DNOW)),
-
     [0x10] = X86_OP_GROUP0(0F10),
     [0x11] = X86_OP_GROUP0(0F11),
     [0x12] = X86_OP_GROUP0(0F12),
@@ -1086,8 +1078,54 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xa0] = X86_OP_ENTRYr(PUSH, FS, w),
     [0xa1] = X86_OP_ENTRYw(POP, FS, w),
 
+    [0xb2] = X86_OP_ENTRY3(LSS,    G,v, EM,p, None, None),
+    [0xb4] = X86_OP_ENTRY3(LFS,    G,v, EM,p, None, None),
+    [0xb5] = X86_OP_ENTRY3(LGS,    G,v, EM,p, None, None),
+    [0xb6] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, zextT0), /* MOVZX */
+    [0xb7] = X86_OP_ENTRY3(MOV,    G,v, E,w, None, None, zextT0), /* MOVZX */
+
+    [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
+    [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2)), /* MOVNTI */
+    [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
+    [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
+    [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
+
+    [0xd0] = X86_OP_ENTRY3(VADDSUB,   V,x, H,x, W,x,        vex2 cpuid(SSE3) p_66_f2),
+    [0xd1] = X86_OP_ENTRY3(PSRLW_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
+    [0xd2] = X86_OP_ENTRY3(PSRLD_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
+    [0xd3] = X86_OP_ENTRY3(PSRLQ_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
+    [0xd4] = X86_OP_ENTRY3(PADDQ,     V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
+    [0xd5] = X86_OP_ENTRY3(PMULLW,    V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
+    [0xd6] = X86_OP_GROUP0(0FD6),
+    [0xd7] = X86_OP_ENTRY3(PMOVMSKB,  G,d, None,None, U,x,  vex7 mmx avx2_256 p_00_66),
+
+    [0xe0] = X86_OP_ENTRY3(PAVGB,     V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
+    [0xe1] = X86_OP_ENTRY3(PSRAW_r,   V,x, H,x, W,x,        vex7 mmx avx2_256 p_00_66),
+    [0xe2] = X86_OP_ENTRY3(PSRAD_r,   V,x, H,x, W,x,        vex7 mmx avx2_256 p_00_66),
+    [0xe3] = X86_OP_ENTRY3(PAVGW,     V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
+    [0xe4] = X86_OP_ENTRY3(PMULHUW,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
+    [0xe5] = X86_OP_ENTRY3(PMULHW,    V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
+    [0xe6] = X86_OP_GROUP0(0FE6),
+    [0xe7] = X86_OP_ENTRY3(MOVDQ,     W,x, None,None, V,x,  vex1 mmx p_00_66), /* MOVNTQ/MOVNTDQ */
+
+    [0xf0] = X86_OP_ENTRY3(MOVDQ,    V,x, None,None, WM,x,  vex4_unal cpuid(SSE3) p_f2), /* LDDQU */
+    [0xf1] = X86_OP_ENTRY3(PSLLW_r,  V,x, H,x, W,x,         vex7 mmx avx2_256 p_00_66),
+    [0xf2] = X86_OP_ENTRY3(PSLLD_r,  V,x, H,x, W,x,         vex7 mmx avx2_256 p_00_66),
+    [0xf3] = X86_OP_ENTRY3(PSLLQ_r,  V,x, H,x, W,x,         vex7 mmx avx2_256 p_00_66),
+    [0xf4] = X86_OP_ENTRY3(PMULUDQ,  V,x, H,x, W,x,         vex4 mmx avx2_256 p_00_66),
+    [0xf5] = X86_OP_ENTRY3(PMADDWD,  V,x, H,x, W,x,         vex4 mmx avx2_256 p_00_66),
+    [0xf6] = X86_OP_ENTRY3(PSADBW,   V,x, H,x, W,x,         vex4 mmx avx2_256 p_00_66),
+    [0xf7] = X86_OP_ENTRY3(MASKMOV,  None,None, V,dq, U,dq, vex4_unal avx2_256 mmx p_00_66),
+
     [0x0b] = X86_OP_ENTRY0(UD),           /* UD2 */
     [0x0d] = X86_OP_ENTRY1(NOP,  M,v),    /* 3DNow! prefetch */
+    [0x0e] = X86_OP_ENTRY0(EMMS,                              cpuid(3DNOW)), /* femms */
+    /*
+     * 3DNow!'s opcode byte comes *after* modrm and displacements, making it
+     * more like an Ib operand.  Dispatch to the right helper in a single gen_*
+     * function.
+     */
+    [0x0f] = X86_OP_ENTRY3(3dnow,       P,q, Q,q, I,b,        cpuid(3DNOW)),
 
     [0x18] = X86_OP_ENTRY1(NOP,  nop,v),  /* prefetch/reserved NOP */
     [0x19] = X86_OP_ENTRY1(NOP,  nop,v),  /* reserved NOP */
@@ -1169,23 +1207,11 @@ static const X86OpEntry opcodes_0F[256] = {
      */
     [0xaf] = X86_OP_ENTRY3(IMUL3,  G,v, E,v, 2op,v, sextT0),
 
-    [0xb2] = X86_OP_ENTRY3(LSS,    G,v, EM,p, None, None),
-    [0xb4] = X86_OP_ENTRY3(LFS,    G,v, EM,p, None, None),
-    [0xb5] = X86_OP_ENTRY3(LGS,    G,v, EM,p, None, None),
-    [0xb6] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, zextT0), /* MOVZX */
-    [0xb7] = X86_OP_ENTRY3(MOV,    G,v, E,w, None, None, zextT0), /* MOVZX */
-
     /* decoded as modrm, which is visible as a difference between page fault and #UD */
     [0xb9] = X86_OP_ENTRYr(UD,     nop,v),                        /* UD1 */
     [0xbe] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, sextT0), /* MOVSX */
     [0xbf] = X86_OP_ENTRY3(MOV,    G,v, E,w, None, None, sextT0), /* MOVSX */
 
-    [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
-    [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2)), /* MOVNTI */
-    [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
-    [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
-    [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
-
     [0xc8] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
     [0xc9] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
     [0xca] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
@@ -1195,33 +1221,6 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xce] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
     [0xcf] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
 
-    [0xd0] = X86_OP_ENTRY3(VADDSUB,   V,x, H,x, W,x,        vex2 cpuid(SSE3) p_66_f2),
-    [0xd1] = X86_OP_ENTRY3(PSRLW_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xd2] = X86_OP_ENTRY3(PSRLD_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xd3] = X86_OP_ENTRY3(PSRLQ_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xd4] = X86_OP_ENTRY3(PADDQ,     V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xd5] = X86_OP_ENTRY3(PMULLW,    V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xd6] = X86_OP_GROUP0(0FD6),
-    [0xd7] = X86_OP_ENTRY3(PMOVMSKB,  G,d, None,None, U,x,  vex7 mmx avx2_256 p_00_66),
-
-    [0xe0] = X86_OP_ENTRY3(PAVGB,     V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xe1] = X86_OP_ENTRY3(PSRAW_r,   V,x, H,x, W,x,        vex7 mmx avx2_256 p_00_66),
-    [0xe2] = X86_OP_ENTRY3(PSRAD_r,   V,x, H,x, W,x,        vex7 mmx avx2_256 p_00_66),
-    [0xe3] = X86_OP_ENTRY3(PAVGW,     V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xe4] = X86_OP_ENTRY3(PMULHUW,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xe5] = X86_OP_ENTRY3(PMULHW,    V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
-    [0xe6] = X86_OP_GROUP0(0FE6),
-    [0xe7] = X86_OP_ENTRY3(MOVDQ,     W,x, None,None, V,x,  vex1 mmx p_00_66), /* MOVNTQ/MOVNTDQ */
-
-    [0xf0] = X86_OP_ENTRY3(MOVDQ,    V,x, None,None, WM,x,  vex4_unal cpuid(SSE3) p_f2), /* LDDQU */
-    [0xf1] = X86_OP_ENTRY3(PSLLW_r,  V,x, H,x, W,x,         vex7 mmx avx2_256 p_00_66),
-    [0xf2] = X86_OP_ENTRY3(PSLLD_r,  V,x, H,x, W,x,         vex7 mmx avx2_256 p_00_66),
-    [0xf3] = X86_OP_ENTRY3(PSLLQ_r,  V,x, H,x, W,x,         vex7 mmx avx2_256 p_00_66),
-    [0xf4] = X86_OP_ENTRY3(PMULUDQ,  V,x, H,x, W,x,         vex4 mmx avx2_256 p_00_66),
-    [0xf5] = X86_OP_ENTRY3(PMADDWD,  V,x, H,x, W,x,         vex4 mmx avx2_256 p_00_66),
-    [0xf6] = X86_OP_ENTRY3(PSADBW,   V,x, H,x, W,x,         vex4 mmx avx2_256 p_00_66),
-    [0xf7] = X86_OP_ENTRY3(MASKMOV,  None,None, V,dq, U,dq, vex4_unal avx2_256 mmx p_00_66),
-
     /* Incorrectly missing from 2-17 */
     [0xd8] = X86_OP_ENTRY3(PSUBUSB,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
     [0xd9] = X86_OP_ENTRY3(PSUBUSW,  V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
-- 
2.45.1


