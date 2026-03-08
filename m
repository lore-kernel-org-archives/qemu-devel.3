Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51626F55138
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8S2-00030P-J3; Sun, 08 Mar 2026 03:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8RP-00029h-8o
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:47 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8RL-0002s5-KL
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:43 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2be1b5fe11cso6989105eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954437; x=1773559237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pf7Lj7RfCx/IUDSUNJ3d5FggA7Ilj5s8BkMaCOmMuME=;
 b=MVa5G9IKXGPxheaq2QFWcjUUHlce13sFoqObImIeojbk45/l1DOOeNe3afABqatBna
 eW9nClaA3gxIFPbLLZq1NKdVEODxSTFHd/Bqu73npg1J90GF+fJgGuJcAqFWWEi3MAPF
 0Rn8c0BtAMgDb/kRQqJ7KZVDLnKSpxTxK1n0bXNtruFZlcKDRr2Emcz46CVFyMlaxU7y
 59BYq03SU8WnCS/aXqzHjx6NXsdtfJl3eLASP7TqGdWlWqaPJv07Vux+wN0I8OhBh5R6
 bqNzeCfs7cnuD1/r1dW6vchtu8qT4SBKPThlkdtAD3CdAZkUWiNjqQOD+SvUH9NY3b5X
 +bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954437; x=1773559237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pf7Lj7RfCx/IUDSUNJ3d5FggA7Ilj5s8BkMaCOmMuME=;
 b=jtmWNmxtzpP/jddA96VB3Nt82VYhsurU1GDnnCAqpZMs1IWVniZbTeYB5ISDf02T6V
 D9bXUOry4UGti2+GAeKMJI2GfYSjGK2SIWNgFqnU/WlWgrWXfUaC1ErFz/D3wP+b5lGE
 COmT7KIM12+uI2Px6kTGjrsxXe8JXSGZoGKgYjWox0tqbWHS2UyFDjY5I+CcNjxxtuC9
 ow37Jik8TbMPYR5RYWOtOaqqmF4jyklGOlri3iwYC8cjbi0kJyORbEx314Sn6KIxRLQT
 WPqL8xhAoRenMD5+80Qn/nPbY0wOsmEESLJMdb9hDNBaUi8PuK1b+EWqbCEsM6zu/sN/
 RV+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp5EgS+6ZzszNrQLx4FpeWCOHCr+97O/d7u41B4sZ6dB/INYokfl+Q5j2at5H/qctO2VuFGi7EkwXA@nongnu.org
X-Gm-Message-State: AOJu0YztUKQZwQcQTLJejxXdW9nH0iPBHnSWlY7O/N+dK3jaafQYR4OM
 2PooiS2sdNb1WZX3ZWgx9F6NSlKJ0GPx+2IHjwcKrnTDYroZ5abZ8wi1
X-Gm-Gg: ATEYQzy/gN7gCNykSW3hx1OGSrm3UQwPYU8eK/yN0brszJUTVEluEW9iZwq3XKMehpZ
 Tt4V0eslbsbwNp5Zixt7CBhLDL5JKYoUO3xd8ZXcbnJFfrWEH7+l73AEJjsaDegDqTpJKr+oVOE
 TucB4Av1IRsMQ5/AfhXhxf1jOXA87E1tQBH4r65F81PUWu4sVWfFb0nQh5D9XtvcBvHp3Fp5agr
 zyKrxxIyZPi9pu9Sfxld7+mKrFhphRsmaE+henC+OmO3Bl8uF4y6fW2BwRvxO0Ftcc81AvNArjN
 8ZLGFTUzkn67sWXcailaMJsOO/zjuPuxfMUAgTO1LxZWOM7NmaNFKGRCGM8AEudwCKiTPZ0XWkc
 XoMr3/a2SPHA9k+BkM0GUvJ44o7BvcTgf1leEJxzWKuMbns5GLNotL+bGwuByZtdS4ur8n6ChXF
 OuQKq8L6hULTZWrd+o0OFoyQ/3k2kWdHFl/ApJy6zAQehgGbXkDM6b+8GNPr0zS352rM/D8K19p
 StQj4nzAoYWWw8jPLgnWbPUOz4=
X-Received: by 2002:a05:7022:6892:b0:119:e569:f615 with SMTP id
 a92af1059eb24-128c2ddc872mr3107220c88.14.1772954437073; 
 Sat, 07 Mar 2026 23:20:37 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:20:35 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 21/28] hw/riscv/dm: add abstract command execution
Date: Sun,  8 Mar 2026 15:17:24 +0800
Message-ID: <07fdc457972b18350ba37019370fea56fba70019.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement execution-based abstract commands following the pattern
described in the RISC-V Debug Specification Appendix A.2.

The Access Register command generates RISC-V instructions into
the ROM command space for CSR (0x0000-0x0FFF), GPR (0x1000-0x101F),
and FPR (0x1020-0x103F) transfers. The hart executes these
instructions, and the DM detects completion when the hart returns
to the park loop.

This also adds the COMMAND and ABSTRACTAUTO register handlers, the
autoexec mechanism that re-executes the last command on DATA or
PROGBUF access, and the CMDERR sticky error reporting.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/dm.c | 231 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 228 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/dm.c b/hw/riscv/dm.c
index 169863c54c..818e48629f 100644
--- a/hw/riscv/dm.c
+++ b/hw/riscv/dm.c
@@ -336,6 +336,18 @@ static inline bool dm_ndmreset_active(RISCVDMState *s)
     return ARRAY_FIELD_EX32(s->regs, DMCONTROL, NDMRESET);
 }
 
+static RISCVCPU *dm_get_cpu(RISCVDMState *s, uint32_t hartsel)
+{
+    CPUState *cs;
+
+    if (!dm_hart_valid(s, hartsel)) {
+        return NULL;
+    }
+
+    cs = qemu_get_cpu(hartsel);
+    return cs ? RISCV_CPU(cs) : NULL;
+}
+
 static bool dm_abstract_cmd_completed(RISCVDMState *s, uint32_t hartsel)
 {
     uint32_t selected = dm_get_hartsel(s);
@@ -545,6 +557,185 @@ static inline void dm_set_cmderr(RISCVDMState *s, uint32_t err)
         ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, CMDERR, err);
     }
 }
+static void dm_execute_access_register(RISCVDMState *s, uint32_t command)
+{
+    uint32_t regno     = FIELD_EX32(command, COMMAND, REGNO);
+    bool     write     = FIELD_EX32(command, COMMAND, WRITE);
+    bool     transfer  = FIELD_EX32(command, COMMAND, TRANSFER);
+    bool     postexec  = FIELD_EX32(command, COMMAND, POSTEXEC);
+    bool     aarpostinc = FIELD_EX32(command, COMMAND, AARPOSTINCREMENT);
+    uint32_t aarsize   = FIELD_EX32(command, COMMAND, AARSIZE);
+
+    uint32_t hartsel = dm_get_hartsel(s);
+    RISCVCPU *cpu = dm_get_cpu(s, hartsel);
+    bool csr_hit = (regno <= RISCV_DM_REGNO_CSR_END);
+    bool gpr_hit = (regno >= RISCV_DM_REGNO_GPR_START &&
+                    regno <= RISCV_DM_REGNO_GPR_END);
+    bool fpr_hit = (regno >= RISCV_DM_REGNO_FPR_START &&
+                    regno <= RISCV_DM_REGNO_FPR_END);
+    uint32_t max_aarsize = 0;
+
+    /* Hart must be halted */
+    if (!dm_hart_valid(s, hartsel) || !s->hart_halted[hartsel]) {
+        dm_set_cmderr(s, RISCV_DM_CMDERR_HALTRESUME);
+        trace_riscv_dm_abstract_cmd_rejected("hart_not_halted",
+            ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, CMDERR));
+        return;
+    }
+
+    if (!cpu) {
+        dm_set_cmderr(s, RISCV_DM_CMDERR_HALTRESUME);
+        trace_riscv_dm_abstract_cmd_rejected("hart_unavailable",
+            ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, CMDERR));
+        return;
+    }
+
+    dm_flush_cmd_space(s);
+
+    if (transfer) {
+        if (csr_hit || gpr_hit) {
+            max_aarsize = riscv_cpu_mxl(&cpu->env) == MXL_RV32 ? 2 : 3;
+        } else if (fpr_hit) {
+            if (riscv_has_ext(&cpu->env, RVD)) {
+                max_aarsize = 3;
+            } else if (riscv_has_ext(&cpu->env, RVF)) {
+                max_aarsize = 2;
+            }
+        }
+
+        if ((csr_hit || gpr_hit || fpr_hit) &&
+            (aarsize < 2 || aarsize > max_aarsize)) {
+            dm_set_cmderr(s, RISCV_DM_CMDERR_NOTSUP);
+            trace_riscv_dm_abstract_cmd_rejected("unsupported_aarsize",
+                ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, CMDERR));
+            return;
+        }
+
+        if (!write) {
+            /* Read: copy register -> data */
+            if (csr_hit) {
+                dm_rom_write32(s, RISCV_DM_ROM_CMD + 2 * 4,
+                               DM_CSRR(regno & 0xFFF));
+                dm_rom_write32(s, RISCV_DM_ROM_CMD + 3 * 4,
+                               DM_DATA_STORE(8, aarsize));
+            } else if (gpr_hit) {
+                if ((regno & 0x1F) == 8) {
+                    /*
+                     * GPR 8 (s0) is used as a scratch register by the ROM.
+                     * Read the architected x8 value from dscratch0 first.
+                     */
+                    dm_rom_write32(s, RISCV_DM_ROM_CMD + 2 * 4,
+                                   DM_CSRR(0x7b2));
+                    dm_rom_write32(s, RISCV_DM_ROM_CMD + 3 * 4,
+                                   DM_DATA_STORE(8, aarsize));
+                } else {
+                    dm_rom_write32(s, RISCV_DM_ROM_CMD + 2 * 4,
+                                   DM_DATA_STORE(regno & 0x1F, aarsize));
+                }
+            } else if (fpr_hit) {
+                dm_rom_write32(s, RISCV_DM_ROM_CMD + 2 * 4,
+                               DM_DATA_FP_STORE(regno & 0x1F, aarsize));
+            } else {
+                dm_set_cmderr(s, RISCV_DM_CMDERR_EXCEPTION);
+                trace_riscv_dm_abstract_cmd_rejected("unsupported_regno_read",
+                    ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, CMDERR));
+                return;
+            }
+        } else {
+            /* Write: copy data -> register */
+            if (csr_hit) {
+                dm_rom_write32(s, RISCV_DM_ROM_CMD + 2 * 4,
+                               DM_DATA_LOAD(8, aarsize));
+                dm_rom_write32(s, RISCV_DM_ROM_CMD + 3 * 4,
+                               DM_CSRW(regno & 0xFFF));
+            } else if (gpr_hit) {
+                if ((regno & 0x1F) == 8) {
+                    /* GPR 8 (s0) is saved in dscratch0 */
+                    dm_rom_write32(s, RISCV_DM_ROM_CMD + 2 * 4,
+                                   DM_DATA_LOAD(8, aarsize));
+                    dm_rom_write32(s, RISCV_DM_ROM_CMD + 3 * 4,
+                                   DM_CSRW(0x7b2));
+                } else {
+                    dm_rom_write32(s, RISCV_DM_ROM_CMD + 2 * 4,
+                                   DM_DATA_LOAD(regno & 0x1F, aarsize));
+                }
+            } else if (fpr_hit) {
+                dm_rom_write32(s, RISCV_DM_ROM_CMD + 2 * 4,
+                               DM_DATA_FP_LOAD(regno & 0x1F, aarsize));
+            } else {
+                dm_set_cmderr(s, RISCV_DM_CMDERR_EXCEPTION);
+                trace_riscv_dm_abstract_cmd_rejected("unsupported_regno_write",
+                    ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, CMDERR));
+                return;
+            }
+        }
+    }
+
+    /* Post-increment */
+    if (aarpostinc && transfer) {
+        s->last_cmd = FIELD_DP32(command, COMMAND, REGNO, regno + 1);
+    }
+
+    if (postexec) {
+        if (s->progbuf_size == 0) {
+            dm_set_cmderr(s, RISCV_DM_CMDERR_NOTSUP);
+            trace_riscv_dm_abstract_cmd_rejected("postexec_without_progbuf",
+                ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, CMDERR));
+            return;
+        }
+
+        /* Restore s0 first, then continue with Program Buffer. */
+        dm_rom_write32(s, RISCV_DM_ROM_CMD + 9 * 4, DM_JAL(2));
+    }
+
+    dm_invalidate_dynamic_code(s);
+
+    /* Set BUSY */
+    ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, BUSY, 1);
+
+    /* Set FLAGS to going and signal hart */
+    dm_rom_write8(s, RISCV_DM_ROM_FLAGS + hartsel, RISCV_DM_FLAG_GOING);
+
+    trace_riscv_dm_abstract_cmd_submit(
+        FIELD_EX32(command, COMMAND, CMDTYPE), regno, transfer,
+        write, aarpostinc, postexec);
+}
+
+static bool dm_execute_abstract_cmd(RISCVDMState *s, uint32_t command)
+{
+    uint32_t cmderr = ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, CMDERR);
+
+    /* If cmderr is latched, reject silently */
+    if (cmderr != RISCV_DM_CMDERR_NONE) {
+        trace_riscv_dm_abstract_cmd_rejected("cmderr_latched", cmderr);
+        return false;
+    }
+
+    /* If busy, set cmderr=busy */
+    if (ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, BUSY)) {
+        dm_set_cmderr(s, RISCV_DM_CMDERR_BUSY);
+        trace_riscv_dm_abstract_cmd_rejected("command_while_busy",
+            ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, CMDERR));
+        return false;
+    }
+
+    uint32_t cmdtype = FIELD_EX32(command, COMMAND, CMDTYPE);
+
+    switch (cmdtype) {
+    case RISCV_DM_CMD_ACCESS_REG:
+        dm_execute_access_register(s, command);
+        break;
+    default:
+        dm_set_cmderr(s, RISCV_DM_CMDERR_NOTSUP);
+        trace_riscv_dm_abstract_cmd_rejected("unsupported_cmdtype",
+            ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, CMDERR));
+        break;
+    }
+
+    return true;
+}
+
+
 
 static void dm_status_refresh(RISCVDMState *s)
 {
@@ -805,9 +996,13 @@ static uint64_t dm_abstractcs_pre_write(RegisterInfo *reg, uint64_t val64)
 static uint64_t dm_command_pre_write(RegisterInfo *reg, uint64_t val64)
 {
     RISCVDMState *s = RISCV_DM(reg->opaque);
+    uint32_t command = (uint32_t)val64;
 
-    /* Stub: abstract command execution added in a follow-on patch. */
-    s->last_cmd = (uint32_t)val64;
+    if (dm_execute_abstract_cmd(s, command)) {
+        s->last_cmd = command;
+    }
+
+    /* COMMAND is WARZ: keep internal state, but reads always return 0. */
     return s->regs[R_COMMAND];
 }
 
@@ -825,7 +1020,6 @@ static uint64_t dm_abstractauto_pre_write(RegisterInfo *reg, uint64_t val64)
         return s->regs[R_ABSTRACTAUTO];
     }
 
-    /* Stub: autoexec trigger logic added in a follow-on patch. */
     uint32_t data_count = MIN(s->num_abstract_data, 12);
     uint32_t pbuf_size = MIN(s->progbuf_size, 16);
     uint32_t data_mask = data_count ? ((1u << data_count) - 1u) : 0;
@@ -835,6 +1029,27 @@ static uint64_t dm_abstractauto_pre_write(RegisterInfo *reg, uint64_t val64)
     return (uint32_t)val64 & mask;
 }
 
+static void dm_check_autoexec(RISCVDMState *s, bool is_data, int index)
+{
+    if (ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, BUSY)) {
+        dm_set_cmderr(s, RISCV_DM_CMDERR_BUSY);
+        return;
+    }
+
+    uint32_t autoexec = s->regs[R_ABSTRACTAUTO];
+    bool trigger;
+
+    if (is_data) {
+        trigger = (autoexec >> index) & 1;
+    } else {
+        trigger = (autoexec >> (16 + index)) & 1;
+    }
+
+    if (trigger) {
+        dm_execute_abstract_cmd(s, s->last_cmd);
+    }
+}
+
 static uint64_t dm_data_pre_write(RegisterInfo *reg, uint64_t val64)
 {
     RISCVDMState *s = RISCV_DM(reg->opaque);
@@ -852,10 +1067,15 @@ static void dm_data_post_write(RegisterInfo *reg, uint64_t val64)
     int index = (reg->access->addr - A_DATA0) / 4;
 
     dm_sync_data_to_rom(s, index);
+    dm_check_autoexec(s, true, index);
 }
 
 static uint64_t dm_data_post_read(RegisterInfo *reg, uint64_t val)
 {
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+    int index = (reg->access->addr - A_DATA0) / 4;
+
+    dm_check_autoexec(s, true, index);
     return val;
 }
 
@@ -876,10 +1096,15 @@ static void dm_progbuf_post_write(RegisterInfo *reg, uint64_t val64)
     int index = (reg->access->addr - A_PROGBUF0) / 4;
 
     dm_sync_progbuf_to_rom(s, index);
+    dm_check_autoexec(s, false, index);
 }
 
 static uint64_t dm_progbuf_post_read(RegisterInfo *reg, uint64_t val)
 {
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+    int index = (reg->access->addr - A_PROGBUF0) / 4;
+
+    dm_check_autoexec(s, false, index);
     return val;
 }
 
-- 
2.53.0


