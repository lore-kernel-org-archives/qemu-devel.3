Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727F606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL234-0008Jv-1H; Sun, 25 Oct 2026 13:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL231-0008J2-Dq; Sun, 25 Oct 2026 13:30:19 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL22z-0007Ec-RU; Sun, 25 Oct 2026 13:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=M6ex60zK398cvgKdVKteAITHgRG0b/rtvXv/kgnNP1E=; b=FOz9yY5XfdTCM4yd/HfzmR4x8b
 WiIFGBJIX1ND3wu4ky3lZRP7a+E+0PKC4a2wprGe5lEc8p3TqTpE2doXENpN5Yb5s4KiCM7z0/Iol
 hMLWhjbrDeqJn7hPp0lFJ51J9X9zAdGuVLRHJxVHiNdr6DIVGZvKLJtyJfy6fXEjuChquvZMC0OuV
 gvGCjI80fxv9hIvAeXbA0t91KiUxpGDkelhPstEMu6PCQTRWQVVlNqth6gOTfx7AM47oSjXEjGjlj
 CCK4hsK3lCPhvTHCJZjCNf48GJKcupE2EhHpawErzzm9+z2zuBjgXiM+rjjWo7byy8SX2C+AwHR0I
 o2VV2Yag==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gS-000990-2a; Sun, 25 Oct 2026 18:07:00 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-0h; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:31 +0100
Subject: [PATCH v2 15/31] target/rx: add RXv3 BFMOV and BFMOVZ
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-15-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=4491;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=LylqfL0lARNXTOxrwsJtsEz46DDu4d7BvDok87Ke92s=;
 b=3LGmVNgNco06cz7nHYdLifvKc0cE57kfyQmXpu9k2/8pZeprjJPRbHP68oB1vRSlMk0Ch9Gz1
 S6OGoRbHbCjCIwXEF+3yssuP9XvzukZRcqK+3YQramUzIQ6rueQZSz0
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

BFMOV/BFMOVZ move a bit field selected by a 16-bit field descriptor
that follows the opcode. BFMOV leaves the bits outside the
destination field untouched; BFMOVZ clears them. Empty or
out-of-range fields are architecturally undefined and rejected as
illegal instructions.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/disas.c      | 26 ++++++++++++++++++++++
 target/rx/insns.decode |  7 ++++++
 target/rx/translate.c  | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index e9e504fc9b..7d6cad753e 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1469,6 +1469,32 @@ static bool trans_DMOV_mld(DisasContext *ctx, arg_DMOV_mld *a)
     return true;
 }
 
+static void prt_bfmov(DisasContext *ctx, const char *name, int rs, int rd)
+{
+    unsigned bf = disas_fetch(ctx, 2);
+    unsigned dlsb = (bf >> 5) & 0x1f;
+    unsigned msb = (bf >> 10) & 0x1f;
+    int delta = bf & 0x1f;
+
+    if (delta >= 0x10) {
+        delta -= 0x20;
+    }
+    prt("%s\t#%d, #%d, #%d, r%d, r%d", name,
+        (int)dlsb - delta, dlsb, (int)msb - (int)dlsb, rs, rd);
+}
+
+static bool trans_BFMOV(DisasContext *ctx, arg_BFMOV *a)
+{
+    prt_bfmov(ctx, "bfmov", a->rs, a->rd);
+    return true;
+}
+
+static bool trans_BFMOVZ(DisasContext *ctx, arg_BFMOVZ *a)
+{
+    prt_bfmov(ctx, "bfmovz", a->rs, a->rd);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index e2a3c5601a..55c7e3994d 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -44,6 +44,8 @@
 &dmovi		drd imm
 &dmovst		rd ld
 &dmovld		rs ld
+# RXv3 bit field move
+&bfm		rd rs
 ########
 %b1_bdsp	24:3 !function=bdsp_s
 
@@ -713,3 +715,8 @@ MVFDR		0111 0101 1001 0000 0001 1011
 # displacement, so it is read during translation rather than by decodetree.
 DMOV_mst	1111 1100 0111 10 ld:2 rd:4 1000		&dmovst
 DMOV_mld	1111 1100 1100 10 ld:2 rs:4 1000		&dmovld
+
+########
+# RXv3: bit field move. The 16-bit field descriptor follows the opcode.
+BFMOVZ		1111 1100 0101 1010 rs:4 rd:4			&bfm
+BFMOV		1111 1100 0101 1110 rs:4 rd:4			&bfm
diff --git a/target/rx/translate.c b/target/rx/translate.c
index f16fc8fb6c..db037634d5 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2441,6 +2441,66 @@ static bool trans_DMOV_mld(DisasContext *ctx, arg_DMOV_mld *a)
     return true;
 }
 
+/*
+ * bfmov / bfmovz. The 16-bit field descriptor that follows the opcode packs
+ *   bits  4:0  (dlsb - slsb), as a signed 5-bit value
+ *   bits  9:5  dlsb
+ *   bits 14:10 dlsb + width
+ * BFMOV leaves the bits outside the destination field untouched; BFMOVZ
+ * clears them.
+ */
+static bool bfmov_common(DisasContext *ctx, int rd, int rs, bool zero)
+{
+    unsigned bf, dlsb, msb, width;
+    int delta, slsb;
+    TCGv_i32 tmp;
+
+    bf = translator_lduw_end(ctx->env, &ctx->base, ctx->base.pc_next, MO_LE);
+    ctx->base.pc_next += 2;
+
+    dlsb = (bf >> 5) & 0x1f;
+    msb = (bf >> 10) & 0x1f;
+    delta = bf & 0x1f;
+    if (delta >= 0x10) {
+        delta -= 0x20;
+    }
+    slsb = dlsb - delta;
+
+    if (msb <= dlsb || slsb < 0 || slsb > 31) {
+        /* Empty or out-of-range field: architecturally undefined. */
+        return false;
+    }
+    width = msb - dlsb;
+    if (slsb + width > 32) {
+        width = 32 - slsb;
+    }
+
+    tmp = tcg_temp_new_i32();
+    tcg_gen_extract_i32(tmp, cpu_regs[rs], slsb, width);
+    if (zero) {
+        tcg_gen_shli_i32(cpu_regs[rd], tmp, dlsb);
+    } else {
+        tcg_gen_deposit_i32(cpu_regs[rd], cpu_regs[rd], tmp, dlsb, width);
+    }
+    return true;
+}
+
+static bool trans_BFMOV(DisasContext *ctx, arg_BFMOV *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    return bfmov_common(ctx, a->rd, a->rs, false);
+}
+
+static bool trans_BFMOVZ(DisasContext *ctx, arg_BFMOVZ *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    return bfmov_common(ctx, a->rd, a->rs, true);
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


