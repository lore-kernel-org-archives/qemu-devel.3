Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B81DCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHgwD-0005Ps-O8; Fri, 16 Oct 2026 08:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xHgwB-0005PW-Mu
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:21:27 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xHgw8-0001Da-Ux
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:21:27 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so1245538f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792153280; x=1792758080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=opI6FZkZmMnSKYdwiohdXjYVyjoA/nis+AtssKoCGQE=;
 b=VgOGZAkVoPcaIB/cFrjmNRtogwQBfbpWqafNjoi8opNwHEI+lFU56VeifOAZSP0wPx
 3sxcOV8Ko6Zmmh9/o9GTwgUuiXbpLOCeuRvZywkJ8ZEsGfoymtzc9stM5S5BhqyCAS27
 A12BvL8IKJnlzprEsqSd8m3CuwziKVEhakY7PA8FBhcfsTyXWmYs8nyi8SxuvarNJHT5
 VXwSRE5jRWpRejOENRts8y5Cfhwk+jzAvc19oY3hbYq99YgET+AVYRhhiDppz2RkiWrO
 SkI3Ws8NP9xlvliX23riiywWf4+BdZhctGnv0z9NKdb/uRBwUq773qO/GdQroCpRZzQL
 nHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792153280; x=1792758080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=opI6FZkZmMnSKYdwiohdXjYVyjoA/nis+AtssKoCGQE=;
 b=ywVhlPUVIyXHatnWCE13Sw9V8zS1jaS/PSomcbbnNqUXttZfwkiq43hRD2AqZuj9Vc
 al1Tu8GTopcgMvt6Yu/ph7jNzN5k9B/qFmd6cFvUhK105nlhH+9I4kKJMlVD7BmW4K8c
 ViPRAz0RhBVkAM3NMLYm+Hr05mnv0QgrAShgiztZK7vUaUUoFcu3eYQ2iuBPioL0XIBO
 scJQLdfLGRSDuIZ5x0sMfR1QD4aY7SO5ggML+Bqxy0IeneNv3BBZq7nfVcZPKqPmNUqx
 SK+/ckGxXF2+nJ9ZHc8KyGpir5Q6PuvrN1N8sX8LBGY9xspVnfUQss1f2j8idbsvlHc7
 UzPw==
X-Gm-Message-State: AFq9FYIv05ejLfZIJE+4nxcrydaxkReS5zu5fr3wFz3sOUnp0tI3rO5I
 Tl1vEKjMCt5gjcmB5p9aNB27hmNgpvU3MBEIWow72Qtj2ioA2yFUbaen43bsg66H
X-Gm-Gg: AYBFou0A9Ry795BR+0yIfNruNkbXLWQ3zh84Gihxi1AkP2EkkcOCzuiQYC9KkSQMtXK
 /pEfn4jGJhdohjN2HYUFujF/r5ZKSzc+vrWzO+iqRSPVEzFUh4x1Ej+XAaNRsbluBsLKKP6BM7f
 kLEzp+O6ZNQTgQiprYrAtFgxeK4n7ZfsWHbSWA2KG/1OJ1SjRLEifB4lngRs1SBCfMJiBO8wWCJ
 xvbf1PvXjmCE2gq6Q/L8xLNeOqNliHZq3Xwly2ANM7QxYTkLZIImWz4Cx8+DYdmgZbHlSTWOfaL
 sIsPpssM7lYDvBdjLqF5j2eNhRUdZoFpb0/7dPBW2LCFGLZRVp6y6kVY8qjvHquYH8HCOGwRCCB
 Eo2Nr64mmun25TvVIEZP4HqNQRqH7ry/Tmfag02k2KsB+OP5CUkJ7NmRPcFegWSOGclnOGX5ITE
 6lCGF4CRjAtVAzp9/Ve/pGkodsIG38OtU1Tz2qaxIZRI5srdI2pheWXyQIqRfY6VbGjnOGIowGP
 aFi5QEsiLDryFpmJI/TxHg2Nu+wBbLu4MZP
X-Received: by 2002:a05:6000:2c05:b0:48b:118e:7454 with SMTP id
 ffacd0b85a97d-48dbaaed0fbmr46324448f8f.31.1792153278785; 
 Fri, 16 Oct 2026 05:21:18 -0700 (PDT)
Received: from kali ([82.162.57.219]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd5035bbsm4770536f8f.44.2026.10.16.05.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 05:21:18 -0700 (PDT)
From: Andrey Polivoda <apolivodaa433@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/i386: Reject VPINSRW with VEX.pp != 0b01
Date: Fri, 16 Oct 2026 22:21:13 +1000
Message-ID: <20261016122113.226920-1-apolivodaa433@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=apolivodaa433@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

According to both Volume 2B of Intel 64 and IA-32 Architectures Software
Developer's Manual and Volume 4 of AMD64 Architecture Programmer's Manual,
VPINSRW instruction can be encoded with VEX prefix only when VEX.pp == 0b01
(which implies 0x66 prefix).

Currently, QEMU allows decoding VPINSRW with either VEX.pp == 0b00
(which implies that no prefix is used) or VEX.pp == 0b01.

The first case allows the guest code to crash QEMU, since vector_len()
returns 8 in this case, causing the following assertion failure:
../target/i386/tcg/emit.c.inc:3092: void gen_pinsr(DisasContext *, X86DecodedInsn *, MemOp): Assertion `vec_len == 16' failed.

Real hardware, however, simply raises a #UD exception when executing VPINSRW
with VEX.pp == 0b00.

This patch fixes this issue by modifying the decoder table entry for PINSRW
to require the use of 0x66 prefix when VEX prefix is used.

Fixes: aba2b8ecb905 ("target/i386: reimplement 0x0f 0xc2, 0xc4-0xc6, add AVX")
Cc: qemu-stable@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
---
Note: checkpatch.pl reported a few errors:
1. Decoder table entry line being longer than 80 characters
2. Missing space after colons at the decoder table entry line
These seem to be false positives, since the affected line follows
the style of the decoder table entries.

 target/i386/tcg/decode-new.c.inc | 12 +++++++++++-
 target/i386/tcg/decode-new.h     |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 3845fab5c8..5b9a4b4fa1 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -290,6 +290,8 @@
 #define p_66_f3_f2    .valid_prefix = P_66 | P_F3 | P_F2,
 #define p_00_66_f3_f2 .valid_prefix = P_00 | P_66 | P_F3 | P_F2,
 
+#define vex_p_66 .vex_valid_prefix = P_66,
+
 #define UNKNOWN_OPCODE ((X86OpEntry) {})
 
 #define X86_MAX_INSN_LENGTH 15
@@ -1391,7 +1393,7 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xc1] = X86_OP_ENTRY2(XADD,       E,v, G,v,            lock),
     [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
     [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2) p_00), /* MOVNTI */
-    [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
+    [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66 vex_p_66),
     [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
     [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
     [0xc7] = X86_OP_GROUP0(group9),
@@ -2760,6 +2762,9 @@ static bool validate_sse_prefix(DisasContext *s, X86OpEntry *e)
 
         /* fallthrough */
     default:
+        if ((s->prefix & (PREFIX_VEX | PREFIX_EVEX)) && e->vex_valid_prefix) {
+            break;
+        }
         if (!e->valid_prefix) {
             return true;
         }
@@ -2772,6 +2777,11 @@ static bool validate_sse_prefix(DisasContext *s, X86OpEntry *e)
 
     /* Now, either zero or one bit is set in sse_prefixes.  */
     sse_prefixes = s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA);
+
+    if ((s->prefix & (PREFIX_VEX | PREFIX_EVEX)) && e->vex_valid_prefix) {
+        return e->vex_valid_prefix & (1 << sse_prefixes);
+    }
+
     return e->valid_prefix & (1 << sse_prefixes);
 }
 
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 5f76b0c1b7..d021754d9a 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -325,6 +325,7 @@ struct X86OpEntry {
     unsigned     vex_class:8;
     X86VEXSpecial vex_special:8;
     unsigned     valid_prefix:16;
+    unsigned     vex_valid_prefix:16;
     unsigned     check:16;
     unsigned     intercept:8;
     bool         has_intercept:1;
-- 
2.53.0


