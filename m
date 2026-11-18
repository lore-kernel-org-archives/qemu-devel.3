Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9C606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PhmkXveb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTbYp-0008IF-DD; Wed, 18 Nov 2026 04:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYi-0008GY-LT; Wed, 18 Nov 2026 04:02:29 -0500
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYc-000428-3z; Wed, 18 Nov 2026 04:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794992517; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=XM7VH7UpAJHWcHedQn+0lNYBsTWS2/H8sd8mCGBqPrI=;
 b=PhmkXvebvIjmmptNA8+kpxAEgGOaZcJkhPL95atbwRpdWSqD8kkmoDKKsxYJssIV4fj/OLdlFzMQQPadwobudN2tPfJMXgIaEFAVTwiFgQMnW6zIM2HUeKSwIO4TE/YzIgvTrkdzcOACRP1WhsEV3mIoBXrn4p0xNWcb39nkT+4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0XF0Gqhq_1794992516; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XF0Gqhq_1794992516 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 18 Nov 2026 17:01:57 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Wed, 18 Nov 2026 17:01:31 +0800
Subject: [PATCH RFC 4/8] disas/riscv: Decode Zl instruction lengths
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-zl-master-v1-4-129f85e0f887@linux.alibaba.com>
References: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
In-Reply-To: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794992514; l=4851;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=ZlSrbm9uKweZufnx0DfkXjICY9/CjSCeOVXamUQOyZc=;
 b=ReAza96r9Cke9uBx6R6+1wNrUWVoziWO9Wwmxph+Mx14p4QqDaKGreAvEG1FgCns0gO+VoAmv
 ++5NfKcABjRAimMLmqR4yz/050cM6CIeIfu13+m7kWaC8qUnjiBjcv2
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-31.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Zl draft identifies long instructions from parcel A and determines
their 48/64-bit length from parcel C.

Read complete 48-bit and 64-bit encodings and return their decoded
lengths. The disassembler does not yet decode instruction mnemonics for
these encodings, so print "unknown" rather than decoding part of a long
instruction as a 16-bit or 32-bit instruction. When opcode display is
enabled, also print the full encoding in hexadecimal.

Link: https://github.com/riscv/riscv-long-instruction/blob/65c377a665feb29a4848384ad566a9873c5fd423/src/unpriv/zl.adoc

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 disas/riscv.c              | 34 ++++++++++++++++++++++++++++------
 disas/riscv.h              |  4 ++--
 target/riscv/insn_length.h | 17 +++++++++++++++++
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 8c9e06b46f19efd6aa9f605ccd0bf3716fa62d44..d2a2b322374643dc51b3bc51775484da9a99e039 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3489,17 +3489,21 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
     return format_inst(24, &dec, op);
 }
 
-#define INST_FMT_2 "%04x              "
-#define INST_FMT_4 "%08x          "
+#define INST_FMT_2 "%04" PRIx64 "              "
+#define INST_FMT_4 "%08" PRIx64 "          "
+#define INST_FMT_6 "%012" PRIx64 "      "
+#define INST_FMT_8 "%016" PRIx64 "  "
 
 static int
 print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
 {
+    const RISCVCPUConfig *cfg = info->target_info;
     bfd_byte packet[2];
     rv_inst inst = 0;
     size_t len = 2;
     bfd_vma n;
     int status;
+    bool zl = cfg && cfg->ext_zl;
 
     /* Instructions are made of 2-byte packets in little-endian order */
     for (n = 0; n < len; n += 2) {
@@ -3510,7 +3514,15 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
         }
         inst |= ((rv_inst) bfd_getl16(packet)) << (8 * n);
         if (n == 0) {
-            len = insn_len(inst);
+            /* Zl needs parcel C to determine a long instruction's length. */
+            len = zl && riscv_insn_is_long(inst) ? 6 : insn_len(inst);
+        } else if (zl && n == 4) {
+            len = riscv_zl_insn_length(inst >> 32);
+        }
+        if (len == 0) {
+            (*info->fprintf_func)(info->stream,
+                                  "<unsupported instruction length>");
+            return -1;
         }
     }
 
@@ -3522,14 +3534,24 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
         case 4:
             (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
             break;
+        case 6:
+            (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
+            break;
+        case 8:
+            (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
+            break;
         default:
             g_assert_not_reached();
         }
     }
 
-    g_autoptr(GString) str =
-        disasm_inst(isa, memaddr, inst,
-                    (const RISCVCPUConfig *)info->target_info);
+    /* Long instruction mnemonics are not decoded yet. */
+    if (len > 4) {
+        (*info->fprintf_func)(info->stream, "unknown");
+        return len;
+    }
+
+    g_autoptr(GString) str = disasm_inst(isa, memaddr, inst, cfg);
     (*info->fprintf_func)(info->stream, "%s", str->str);
 
     return len;
diff --git a/disas/riscv.h b/disas/riscv.h
index 4f1ffc4ae02fb1e5940e833ef972f80e28603a19..b49bcadab8e4fa1f32f28e1d5ed9035c5b55a359 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -11,7 +11,7 @@
 
 /* types */
 
-typedef uint32_t rv_inst;
+typedef uint64_t rv_inst;
 typedef uint16_t rv_opcode;
 
 /* enums */
@@ -184,7 +184,7 @@ struct rv_opcode_data {
 typedef struct {
     const RISCVCPUConfig *cfg;
     uint64_t  pc;
-    uint64_t  inst;
+    rv_inst   inst;
     int32_t   imm;
     int32_t   imm1;
     uint8_t   rd;
diff --git a/target/riscv/insn_length.h b/target/riscv/insn_length.h
index bfb3af0e6358249daf464fed670f09d7184d307b..14bf5c7fa98a388705e023ff7d0d0840d1306c63 100644
--- a/target/riscv/insn_length.h
+++ b/target/riscv/insn_length.h
@@ -9,4 +9,21 @@ static inline int insn_len(uint16_t first_word)
     return (first_word & 3) == 3 ? 4 : 2;
 }
 
+static inline bool riscv_insn_is_long(uint16_t first_parcel)
+{
+    return (first_parcel & 0x1f) == 0x1f;
+}
+
+/* Call only after fetching parcel C; zero means an undefined length. */
+static inline unsigned riscv_zl_insn_length(uint16_t third_parcel)
+{
+    if ((third_parcel & 3) != 3) {
+        return 6;
+    }
+    if ((third_parcel & 0x1f) != 0x1f) {
+        return 8;
+    }
+    return 0;
+}
+
 #endif

-- 
2.43.0


