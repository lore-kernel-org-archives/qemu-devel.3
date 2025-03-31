Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B859C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 15:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzHTW-0001Ao-SH; Mon, 31 Mar 2025 11:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzHTE-00018e-Ps; Mon, 31 Mar 2025 11:54:41 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzHTD-0005Hj-0t; Mon, 31 Mar 2025 11:54:40 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224191d92e4so84740685ad.3; 
 Mon, 31 Mar 2025 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743436477; x=1744041277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBHNz0EIVz4BEQsRbPAif07dRvGcEYobdMBSDY/GLH0=;
 b=VYEauDfi8r3Kc/ORSputuWKn4f6ClPfvyumAhWWUt/X0liAYgNADJmrvRejhFjHWFY
 oVgj6OFq/4cSDjCjajoHyvUsO76avEjlU+8WwEp6Z4+Sf+c4eWy5GtBrfuOgE4xksGCj
 oQs5Yxii75FZ4h2zWS6I/JkswUiJwgfhIR6sb7R1VTVGW4uClQBlD+mOVYn/hFb7t1ju
 7dZ2UuyTVgQh9KXPhIrz3L4igRCwN9TdY32g+aGPlQ9R3/BQBvRWvCGxC/U/1bZ4Ii8c
 AA7cIAAqpTimPutWE5rBQs0XLYdxDykXyGanZK8D8ZPnZy38gR8LiPV6VuWYy5/AOMrq
 Gj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743436477; x=1744041277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBHNz0EIVz4BEQsRbPAif07dRvGcEYobdMBSDY/GLH0=;
 b=oPJoGd65czKvhqy14EnbzHctVJPl/IQEX7goP771gihwO6V1xoTon1cu1S13RFiJLz
 TrLSQ3RUWhY+ANTs8a/Ps1RKD6vqvxXHL3QstEvRqSpqo9oSqe5A2/20i1gqtQOUWizW
 Fjq/vXke7ULRqW5MvnGL6Z07HXu/hjGXMNFijLsrjyXJ6emwb5eKmd+puoK3FdJjr9YL
 6r2+jIDyBTT6IGt+pjPtq2T+8GcWOJSTb8XRxFyH50j1w2xsX7UGwTf5BKXxKSDNqbel
 Wm72cv6H0YKUR1GEoPy8oGFWWudIo6LiW9wSvx0OG+k1WTFfYQsHoWBYeol7Ryj6H2vs
 J/lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyNSWNN9yI34YCpNb/V/aXVxA0w5U6idTmer8x1Zj/wzVwUTwLoH1asnVVJm9xuOLulEYyIvFz8dlL@nongnu.org
X-Gm-Message-State: AOJu0YyuJ02HMX8quZ5OQVXIRZDwopWLZZ9hSSLlqEp+W01X0CLgZ7I9
 lJ9+Chd0Ihj7KDg/Lx+OYfgkpY5SBfRsG7BV/+Vwm6ZKrTlPWWyN7+gRww==
X-Gm-Gg: ASbGncvaKBpUQIanEz7LoUu8H1bXxOwWU9t4uw9BCUkRUrnFwzhJV77uSh+0pD4+YfW
 iXoprlunutorM2s4j4PiAJVbQxv7mln+44mliwBPpN5SzofCPRRKc85ynyy++okJuO9rlYJiYrc
 FLP4c8LCrtzzO6xt0zvZwHmOf0GDxaEw/v6RBD5CiPoxrA14d2PZ4qpc7t81XGQARQBsWdLYHXv
 NtodFbvDkdEacv2FSJqLEqO4AxCqT3qrcbmwm/IisMYkWSW5dWiRaRINSzggINQg4gsIc1WBRqQ
 od8ZSz84PFZsRvc72xTJCiq18E7pchxOW448nkxRfjrEmqanbg==
X-Google-Smtp-Source: AGHT+IFzjAx+vbs9ylkPhmFiJtc3D/W3P+Bp1FUDRAqk487bB7ARegtB/kPZnRN3LduR+tlGK6ap1g==
X-Received: by 2002:a17:902:e852:b0:215:8d49:e2a7 with SMTP id
 d9443c01a7336-2292fa0cf9bmr140713685ad.50.1743436476921; 
 Mon, 31 Mar 2025 08:54:36 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eec6fbdsm70742045ad.16.2025.03.31.08.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 08:54:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 2/3] target/ppc: define TARGET_HAS_LAZY_ICACHE
Date: Tue,  1 Apr 2025 01:54:22 +1000
Message-ID: <20250331155423.619451-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331155423.619451-1-npiggin@gmail.com>
References: <20250331155423.619451-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use the new incoherent icache (incoherent TB) feature in the ppc target.

Performance problems with notdirty write accesses have been encountered
in two places now. One is where a large number of executable pages have
been freed (typically in KVM when a guest exits) and are being cleared
for reuse, most stores in a page will take the notdirty slowpath, which
can cause such s slowdown that the OS reports lockups. The other case is
PowerVM boot firmware which has real-mode interrupt handler code that
stores to memory in the same page-sized region as interrupt handler code
which causes significant slowdowns.

ppc implements TARGET_HAS_LAZY_ICACHE by calling tb_flush_incoherent()
from the ICBI instruction, which should conform to the ISA's CMODX (aka
SMC) requirement.
---
 target/ppc/cpu.h        | 16 ++++++++++++++++
 target/ppc/mem_helper.c |  2 ++
 target/ppc/translate.c  |  1 +
 3 files changed, 19 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 74ed28c8dac..de274d29637 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -34,6 +34,22 @@
 #define TARGET_PAGE_BITS_64K 16
 #define TARGET_PAGE_BITS_16M 24
 
+/* icaches are not kept coherent with dcaches. target is to call
+ * tb_flush_incoherent() to bring them into coherency */
+#define TARGET_HAS_LAZY_ICACHE
+/*
+ * Note that this does not model implementation specific behaviour of all
+ * CPUs, notably recent Power CPUs do keep i/d coherent, and only require
+ * context synchronization after code modification to ensure CPU pipeline
+ * is coherent. The ISA and User Manuals do say that icbi (to any address) ;
+ * isync should be used even for these CPUs, so tb_flush_incoherent() in
+ * icbi should work reasonably. The ppc target should continue to work without
+ * TARGET_HAS_LAZY_ICACHE, but some performance corner cases benefit (e.g.,
+ * KVM when clearing a lot of memory freed from a guest that has a lot of exec
+ * pages; PowerVM PFW/boot firmware that stores to globals in the same page as
+ * it executes from).
+ */
+
 #if defined(TARGET_PPC64)
 #define PPC_ELF_MACHINE     EM_PPC64
 #else
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 51b137febd6..647d37195dd 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "helper_regs.h"
 #include "exec/cpu_ldst.h"
+#include "exec/tb-flush.h"
 #include "internal.h"
 #include "qemu/atomic128.h"
 
@@ -335,6 +336,7 @@ void helper_icbi(CPUPPCState *env, target_ulong addr)
      * do the load "by hand".
      */
     cpu_ldl_data_ra(env, addr, GETPC());
+    tb_flush_incoherent(env_cpu(env));
 }
 
 void helper_icbiep(CPUPPCState *env, target_ulong addr)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 7f933537aaa..5e610bf29a5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4565,6 +4565,7 @@ static void gen_dss(DisasContext *ctx)
 static void gen_icbi(DisasContext *ctx)
 {
     TCGv t0;
+    translator_io_start(&ctx->base);
     gen_set_access_type(ctx, ACCESS_CACHE);
     t0 = tcg_temp_new();
     gen_addr_reg_index(ctx, t0);
-- 
2.47.1


