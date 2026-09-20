Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B5EC982D8
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8J1I-0007vP-N5; Sun, 20 Sep 2026 10:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hushunchao@bosc.ac.cn>)
 id 1x8Irq-00069t-T0; Sun, 20 Sep 2026 10:50:10 -0400
Received: from [115.124.28.170] (helo=out28-170.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hushunchao@bosc.ac.cn>)
 id 1x8Irl-0008GB-Pa; Sun, 20 Sep 2026 10:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bosc.ac.cn; s=default;
 t=1789915547; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=QdxZYsIfLTy2C8bFFuERzBT2ZIZ+sCRqwS0/KqiXkpo=;
 b=RsxEB/WpCe/TxzxNNLCcYbA14SbYqwRT4GSAj8Avhp/SGkB5TdCyJMJGjmS8gO2mngawOo9q/LZTkMQFbKpGE9r1vLBGUHkaxy0bsfk7XZB1hPx2K4uqr29wg3FhpJ8MRmkqgCtZS6mwqCX9jU3Bw7Z08J6N9jx1QxYXgK/a55fROYRUoCOOcWknl+Ka4FYoyi0gRe1EbnKgv9IsvROYm2ZSfAmJwNqXONwKgtRd0Ztfgfuq614yGeXGXs4uqJtVV4d4M2JUQggCm3lM6r7vRp0V9bVjZt9d1gcWOszQpqxqrIeSU9hBOOaknEe3mba06Jxo5mfTVWd10F3mspnrYQ==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0747086|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.131045-0.000224676-0.86873;
 FP=12719691304069185114|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037031241; MF=hushunchao@bosc.ac.cn; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.jIHq3RM_1789915226; 
Received: from 127.0.1.1(mailfrom:hushunchao@bosc.ac.cn
 fp:SMTPD_---.jIHq3RM_1789915226 cluster:ay29) by smtp.aliyun-inc.com;
 Sun, 20 Sep 2026 22:40:26 +0800
From: Shunchao Hu <hushunchao@bosc.ac.cn>
Date: Sun, 20 Sep 2026 22:39:39 +0800
Subject: [PATCH] target/riscv: add hgatp-specific WARL legalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-riscv-hgatp-warl-v1-1-2e52f78c8027@bosc.ac.cn>
X-B4-Tracking: v=1; b=H4sIACrwr2oC/yWMQQrCMBBFr1JmbSCJItWriItJOm1GNJaZWIXSu
 5vo8n3+eysoCZPCuVtBaGHlZ67gdh3EhHkiw0Nl8NYf7clbI6xxMWnCMps3yt04OvTjsPfO9T1
 UbRYa+fNLXq5/1le4USyt0x4BlUwQzDG16YFaSGDbvp/wU3KNAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789915226; l=3666;
 i=hushunchao@bosc.ac.cn; s=default; h=from:subject:message-id;
 bh=vaBvtOL7LJ0M3zKXfYTfIu6zaQJDiKn4VIDXT5hoilw=;
 b=i/2D+WEF5pRfmjwskodiEqf5xFk0ZaXJZfP5or+cb0G8vu7f+bENlAP2ab5g0bT/8McnlOjwv
 Pi64Uo3jIamAEUO97gTfSMSSyJbVdFAHJoqbOJbBDJqm/K0FtL08QzX
X-Developer-Key: i=hushunchao@bosc.ac.cn; a=ed25519;
 pk=OyMXRGlCgZVrm0K+KasRMUzjwUAmDW79SvlVdwZt4f4=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.170 (deferred)
Received-SPF: pass client-ip=115.124.28.170;
 envelope-from=hushunchao@bosc.ac.cn; helo=out28-170.mail.aliyun.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 20 Sep 2026 10:59:53 -0400
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
 target/riscv/cpu_bits.h |  8 ++++++++
 target/riscv/tcg/csr.c  | 43 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

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
index 061bc9db77..ef08600ca7 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5050,17 +5050,56 @@ static RISCVException read_hgeip(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static target_ulong hgatp_mask(CPURISCVState *env)
+{
+    target_ulong mask;
+
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        mask = HGATP32_MODE | HGATP32_VMID | HGATP32_PPN;
+    } else {
+        mask = HGATP64_MODE | HGATP64_VMID | HGATP64_PPN;
+    }
+
+    /* G-stage x4 root page tables are always 16 KiB aligned. */
+    return mask & ~(target_ulong)3;
+}
+
+static target_ulong legalize_hgatp(CPURISCVState *env,
+                                   target_ulong old_hgatp,
+                                   target_ulong val)
+{
+    target_ulong mode_mask = riscv_cpu_mxl(env) == MXL_RV32 ?
+                             HGATP32_MODE : HGATP64_MODE;
+    target_ulong hgatp = val & hgatp_mask(env);
+    target_ulong mode = get_field(hgatp, mode_mask);
+
+    /*
+     * Unlike satp, an unsupported hgatp.MODE does not discard the whole
+     * write.  Keep the old MODE while accepting the other WARL fields.
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


