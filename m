Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4E606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.a=rsa-sha256 header.s=default header.b=DITI4er3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJNK-00061T-0j; Mon, 26 Oct 2026 08:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hushunchao@bosc.ac.cn>)
 id 1xLJNG-0005yL-Bp; Mon, 26 Oct 2026 08:00:23 -0400
Received: from [115.124.28.218] (helo=out28-218.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hushunchao@bosc.ac.cn>)
 id 1xLJN9-0003qA-BD; Mon, 26 Oct 2026 08:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bosc.ac.cn; s=default;
 t=1793015755; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=Rf+MEEdbDA9KoCY/rQ+br8LXo2PEnR959iH6Cocwrjw=;
 b=DITI4er3KAbcwWjpXxoQGHgTYxDg8ynwRW4NYLlbezvH6t9LLE3/L53NX9D+TA7w2Ap1ZkPLEofAtjAqI2t3bvmA0GJxCA06u6rIBoTO+NeYfLFHIXcgpGk2093RbGmIrcgQeIvTKBKxTSOSR4c4m2/GbNkx+WIsLh/1z/utyujfW+kVhaA3ymv9BvX2u1CHvLVIP+0nMIPNPiUyC2moDrUuJFe4ZOuYVTL+iUibVWqQ+KOXVKV9wXUdbndWtinZ3dKhe8CQPkFNq4t8y16FdEZ/w5ygob8e9f6PvHrIS0wtGNMUF1/bV2Z65Wo0vUyxE6JflbJt0z6GLXdy7p+U9g==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07439265|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.145594-0.00143457-0.852971;
 FP=3521614369658846810|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033045099153;
 MF=hushunchao@bosc.ac.cn; NM=1; PH=DS; RN=10; RT=10; SR=0;
 TI=SMTPD_---.jprvNuO_1793015752; 
Received: from 127.0.1.1(mailfrom:hushunchao@bosc.ac.cn
 fp:SMTPD_---.jprvNuO_1793015752 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 26 Oct 2026 19:55:53 +0800
From: Shunchao Hu <hushunchao@bosc.ac.cn>
Date: Mon, 26 Oct 2026 19:55:42 +0800
Subject: [PATCH v3] target/riscv: add hgatp-specific WARL legalization
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-riscv-hgatp-warl-v3-1-4a1a962f3fca@bosc.ac.cn>
X-B4-Tracking: v=1; b=H4sIAL0/32oC/33OzQ6CMAwH8FchOzvD6gfDk+9hPJRSYEaBrDg1h
 neX4UUT4/Hfj1/7VMLesahd8lSegxPXtVNYLRJFDbY1a1dOWUEK2zSHVHsnFHRT49DrG/qzNry
 2VbkCY6xV01rvuXL3mTwc31muxYlpiE6cKFBYFx5bamLpgjKwj43GydD5x/xMMBH4czcYbTTwB
 qrMkk0h2xed0BJpSa2KhwN8CpsfAkQBMUfMMmOp/BLGcXwBXIUDAB4BAAA=
X-Change-ID: 20260920-riscv-hgatp-warl-1e48fd321188
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Tianze Wu <wutianze@ict.ac.cn>, Shunchao Hu <hushunchao@bosc.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793015752; l=4508;
 i=hushunchao@bosc.ac.cn; s=default; h=from:subject:message-id;
 bh=g9w8pVguEoMz2M1YuxUC7yJqrbHGK7pb2Y6yFfp8AMI=;
 b=AjGNWF5cidOfxL7DGt1y7W5OmtAbBb3uB1s/orwBxs6/Dq8KNZzH70iBCUZZE6asNh/WuCU1d
 lcKXxmEn3uYCwOmvJ+7VVCakeqnEuDMg6ypVmnQaufqUb2/m+BDTMNf
X-Developer-Key: i=hushunchao@bosc.ac.cn; a=ed25519;
 pk=OyMXRGlCgZVrm0K+KasRMUzjwUAmDW79SvlVdwZt4f4=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.218 (deferred)
Received-SPF: pass client-ip=115.124.28.218;
 envelope-from=hushunchao@bosc.ac.cn; helo=out28-218.mail.aliyun.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RDNS_NONE=0.793,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

According to the Hypervisor Extension in RISC-V spec:
- VMIDMAX is 7 bits for RV32 and 14 bits for RV64
- the fields of hgatp are WARL in the normal way
- the lowest two bits of the physical page number
  (PPN) in hgatp always read as zeros

These behaviors differ from those of the satp CSR,
so hgatp cannot reuse legalize_xatp(). Add a dedicated
legalize_hgatp() helper to implement the hgatp-specific
WARL semantics.

Co-authored-by: Tianze Wu <wutianze@ict.ac.cn>
Signed-off-by: Tianze Wu <wutianze@ict.ac.cn>
Signed-off-by: Shunchao Hu <hushunchao@bosc.ac.cn>
---
Changes in v3:
- Keep the hgatp masks and legalization helpers in 64-bit arithmetic,
  fixing the riscv32 build where the RV64 field masks do not fit in
  target_ulong. No functional change.
- Link to v2: https://lore.kernel.org/qemu-devel/20260925-riscv-hgatp-warl-v2-1-2aa9aa7718cd@bosc.ac.cn

Changes in v2:
- Reword the comment to clarify that retaining the previous MODE is
  QEMU's WARL legalization choice, not a requirement of the spec.
- Link to v1: https://lore.kernel.org/qemu-devel/20260920-riscv-hgatp-warl-v1-1-2e52f78c8027@bosc.ac.cn
---
 target/riscv/cpu_bits.h |  8 ++++++++
 target/riscv/tcg/csr.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index c01050ce2b..c4a914411b 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -711,6 +711,14 @@ typedef enum {
 #define SATP64_ASID         0x0FFFF00000000000ULL
 #define SATP64_PPN          0x00000FFFFFFFFFFFULL
 
+/* hgatp CSR field masks */
+#define HGATP32_MODE        SATP32_MODE
+#define HGATP32_VMID        0x1FC00000
+#define HGATP32_PPN         SATP32_PPN
+#define HGATP64_MODE        SATP64_MODE
+#define HGATP64_VMID        0x03FFF00000000000ULL
+#define HGATP64_PPN         SATP64_PPN
+
 /* RNMI mnstatus CSR mask */
 #define MNSTATUS_NMIE       0x00000008
 #define MNSTATUS_MNPV       0x00000080
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 061bc9db77..0e92a78c1f 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5050,17 +5050,63 @@ static RISCVException read_hgeip(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+/*
+ * Masks must be 64-bit: env->hgatp is a uint64_t and the RV64 field
+ * masks do not fit in target_ulong when built for riscv32.
+ */
+static uint64_t hgatp_mask(CPURISCVState *env)
+{
+    uint64_t mask;
+
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        mask = HGATP32_MODE | HGATP32_VMID | HGATP32_PPN;
+    } else {
+        mask = HGATP64_MODE | HGATP64_VMID | HGATP64_PPN;
+    }
+
+    /* G-stage x4 root page tables are always 16 KiB aligned. */
+    return mask & ~(uint64_t)3;
+}
+
+static uint64_t legalize_hgatp(CPURISCVState *env,
+                               uint64_t old_hgatp,
+                               uint64_t val)
+{
+    uint64_t mode_mask = riscv_cpu_mxl(env) == MXL_RV32 ?
+                         HGATP32_MODE : HGATP64_MODE;
+    uint64_t hgatp = val & hgatp_mask(env);
+    uint64_t mode = get_field(hgatp, mode_mask);
+
+    /*
+     * hgatp.MODE is a WARL field, so an unsupported value must be
+     * legalized rather than causing the entire write to be ignored.
+     * The specification does not require a particular legal value,
+     * QEMU here chooses to keep the previous mode while accepting
+     * writes to the remaining WARL fields.
+     */
+    if (!validate_vm(env, mode)) {
+        hgatp = set_field(hgatp, mode_mask,
+                          get_field(old_hgatp, mode_mask));
+    }
+
+    if (hgatp != old_hgatp) {
+        tlb_flush(env_cpu(env));
+    }
+
+    return hgatp;
+}
+
 static RISCVException read_hgatp(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
-    *val = env->hgatp;
+    *val = env->hgatp & hgatp_mask(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_hgatp(CPURISCVState *env, int csrno,
                                   target_ulong val, uintptr_t ra)
 {
-    env->hgatp = legalize_xatp(env, env->hgatp, val);
+    env->hgatp = legalize_hgatp(env, env->hgatp, val);
     return RISCV_EXCP_NONE;
 }
 

---
base-commit: c1c18d1e640b64292859ce9f30f3c344edfb0294
change-id: 20260920-riscv-hgatp-warl-1e48fd321188

Best regards,
--  
Shunchao Hu <hushunchao@bosc.ac.cn>


