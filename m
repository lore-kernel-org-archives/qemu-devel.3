Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BEFFCA191
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziu3-0003MC-HS; Mon, 09 Mar 2026 18:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTG-0000t0-Ub
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:03 -0400
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTD-0002Ar-EZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:02 -0400
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-12732165d1eso13500479c88.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773092937; x=1773697737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rbuxkECdLoEOxEmz+ngMjXiYldsLydHqIYR1x0mlIIo=;
 b=jxN6qlRbOg2qvXMg8PMzluO88lsw0MmFls1AkmzCUNNcoDtE3UL+6FDDnYimgVu73d
 UbZUTXkxmkhV73I2YdRgZNjikwurYyls+pKSW301fxRtdA0y8Mp/5BC99d3z9GDkFWC2
 W1StnSoKhNzoXg9bWGEfBG5McE6iZNw9sZtRTz/vhWRaKxKoPoLbiofF1Dntw24HdpLN
 bSvZ68IUdFx7B1cU3bkmt/cft+NEGIeUHUj9EUJCepReXceERzO5H7oa1ApQA5XCgA4P
 mL9e21AvKYcG4BrlRsa3HBA9olDoms0AeSLN06cpDz7dQin8xEFswYixU/aGMW5koNh0
 JYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773092937; x=1773697737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbuxkECdLoEOxEmz+ngMjXiYldsLydHqIYR1x0mlIIo=;
 b=WsBGiDbNEfH+TJvI7zxktc0sIiYE6eKFEkhwvqQO4O3RdFEhOsvmd/w8WkG78qC4WN
 R/46HF4zYXHYrZcqfmYPozHCrSJpTPzuF0IVWvMUX+GxYcrq/vtuWmB3BBv5Ikl+K9kQ
 1sbvTblUy7ZE+8kv8azG7ShBIXwWLRnUVUVS5tKDQ2DHVpO6A3LU10QxQQaT7p/W2xXI
 jf4tkbbzPokOjaaFCW6in9VklDbE7T3FzcYjgqUUut0NsSy0x3Gr3lHWwGFhq+Snod2J
 EmGgT1s6l0XMT+BLccMhgcRJF3CdgyJsUtJmJBgJ12TgUOC593PGuP9RBCSZKHw2xVEZ
 fXzA==
X-Gm-Message-State: AOJu0Yx2XyFtBSySdy2/w+on7UT1U91SvxjTsmM0oSHK+2+mIn1G/ADr
 dwHKDGreO3+AbN3jXn9t/I+ONgoEGImucmIY2TdgXPg6u/poNS5anjNZlXe7duCK
X-Gm-Gg: ATEYQzx1QJ7kg4Z8zSu6eRSZLKtDwIaGBF4eW71w76GUxAqQfYm9sMua6jQkI6BBFuX
 it39XDcd9eFlzsjyWDC8R54TLoRmPbAW+iiw9Qyxrph6/nGvGiy3MIIDCz+TFt9TJ6eXpNJTdUa
 AzMyHC2tbLvQeYbq96UxRkgV6X2p8gQ2zL8we/seSS8NXNPu9jsSAu2jxuetii30FPYGIp4tXsG
 Am8HwsrODJRpcxaVhPyYwhPBybbjMCtede9FQPrRxtxAIOVRuBGXYnJ4B3t/3ZRXoPpGVt4Lm9a
 IJus9Ji/j8mRPTNhriAQTXfJcQQtznMYWgXk8BInWoT6MGX6RaqT3lKr9bFKsBHK7ksPVffIJwK
 mIlaqrGJy+CRTtiSZ0g7tQca1G0trkOecEbZq4AzNyk0eoU/eNaM1zLNlDNwwiQKsQllFFM1LO0
 ZyEWuLGcj+UfenHe1hkseiQABrGqEVuerZQ4qA5UrlSwUPOQ1I3vA=
X-Received: by 2002:a05:7022:688e:b0:11f:2c69:2d with SMTP id
 a92af1059eb24-128c2f0d8a6mr4561038c88.45.1773092937147; 
 Mon, 09 Mar 2026 14:48:57 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:4cc9:ee1b:bd8d:dbab])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128c3d5a85dsm10275643c88.3.2026.03.09.14.48.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 14:48:56 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH] target/arm/hvf: emulate ISV=0 data abort instructions
Date: Mon,  9 Mar 2026 18:48:52 -0300
Message-ID: <20260309214852.92545-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1236;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x1236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Mar 2026 18:16:41 -0400
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

On Apple Silicon, HVF exits with ISV=0 (no syndrome information)
for STP/LDP/STNP/LDNP, SIMD/FP load/stores, and DC cache
maintenance instructions that access MMIO regions.  The existing
code asserted ISV!=0, crashing the VM.

Decode the faulting instruction from guest memory and emulate:
- Load/Store Pair (STP/LDP/STNP/LDNP) for GPR and SIMD registers
- Single Load/Store with writeback and SIMD/FP variants
- DC system instructions (NOP on MMIO regions)
- LDPSW (sign-extending load pair)

For pair instructions, compute the effective virtual address from
the base register to handle page-straddling accesses correctly.
HPFAR_EL2 reports the faulting page, not the effective address,
so using the IPA directly would produce wrong results when an
STP straddles an HVF-mapped / MMIO boundary.

Tested with virtio-gpu Venus blob resources on macOS ARM64.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/hvf/hvf.c | 309 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 306 insertions(+), 3 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d79469c..87ddcdb 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1871,10 +1871,313 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         assert(!s1ptw);
 
         /*
-         * TODO: ISV will be 0 for SIMD or SVE accesses.
-         * Inject the exception into the guest.
+         * ISV=0: syndrome doesn't carry access size/register info.
+         * This happens for STP/LDP/STNP/LDNP, SIMD/SVE load/stores,
+         * and DC (data cache) maintenance instructions.
+         *
+         * Sync all CPU state (including TTBR/TCR/SCTLR for page table
+         * walk) and decode the faulting instruction from guest memory.
          */
-        assert(isv);
+        if (!isv) {
+            ARMCPU *arm_cpu = ARM_CPU(cpu);
+            CPUARMState *env = &arm_cpu->env;
+            uint32_t insn;
+
+            /*
+             * Sync system registers (TTBR, TCR, SCTLR, etc.) from HVF
+             * so cpu_memory_rw_debug can walk guest page tables.
+             */
+            cpu_synchronize_state(cpu);
+
+            if (cpu_memory_rw_debug(cpu, env->pc,
+                                    (uint8_t *)&insn, 4, false) != 0) {
+                error_report("HVF: ISV=0 at ipa=0x%" PRIx64
+                             " -- cannot read insn at pc=0x%" PRIx64,
+                             ipa, (uint64_t)env->pc);
+                goto isv0_inject_fault;
+            }
+            insn = le32_to_cpu(insn);
+
+            /*
+             * System instructions (DC CIVAC, DC CVAC, etc.):
+             * bits [31:22] = 1101010100 identifies MRS/MSR/SYS class.
+             * Cache maintenance on MMIO regions is a harmless NOP.
+             */
+            if ((insn & 0xFFC00000) == 0xD5000000) {
+                advance_pc = true;
+                break;
+            }
+
+            /*
+             * Load/Store Pair (STP/LDP/STNP/LDNP):
+             * bits [29:27] = 101 identifies this instruction class.
+             * Supports both integer (GPR) and SIMD/FP register pairs.
+             */
+            if ((insn & 0x38000000) == 0x28000000) {
+                uint32_t opc = extract32(insn, 30, 2);
+                bool is_vec = extract32(insn, 26, 1);
+                bool is_load = extract32(insn, 22, 1);
+                uint32_t rt = extract32(insn, 0, 5);
+                uint32_t rt2 = extract32(insn, 10, 5);
+                uint32_t rn = extract32(insn, 5, 5);
+                uint32_t type = extract32(insn, 23, 3);
+                bool writeback = (type == 1 || type == 3);
+                uint32_t esize;
+                int32_t imm7 = sextract32(insn, 15, 7);
+
+                if (!is_vec) {
+                    esize = (opc & 2) ? 8 : 4;
+                } else {
+                    esize = 4u << opc;  /* 4, 8, or 16 bytes */
+                }
+
+                int64_t stp_offset = (int64_t)imm7 * esize;
+
+                /*
+                 * Compute the effective virtual address from the base
+                 * register and immediate offset. HPFAR_EL2 reports
+                 * the faulting page, not the effective address, so we
+                 * must derive the VA from the instruction encoding.
+                 *
+                 * After cpu_synchronize_state(), env->xregs[0..30] are
+                 * GPRs and env->xregs[31] is the current SP (restored
+                 * via aarch64_restore_sp).
+                 *
+                 * Using the VA with cpu_memory_rw_debug() correctly
+                 * splits page-straddling accesses via guest page tables.
+                 */
+                uint64_t rn_va = env->xregs[rn];
+                /* post-index: access at unmodified base */
+                uint64_t va = (type == 1) ? rn_va : rn_va + stp_offset;
+
+                if (is_load == iswrite) {
+                    error_report("HVF: ISV=0 load/write mismatch at "
+                                 "ipa=0x%" PRIx64, ipa);
+                    goto isv0_inject_fault;
+                }
+
+                if (iswrite) {
+                    /* Store pair */
+                    if (!is_vec) {
+                        uint64_t val1 = env->xregs[rt];
+                        uint64_t val2 = env->xregs[rt2];
+                        uint8_t buf[16]; /* max 2 x 8 bytes */
+                        memcpy(buf, &val1, esize);
+                        memcpy(buf + esize, &val2, esize);
+                        cpu_memory_rw_debug(cpu, va, buf,
+                                            2 * esize, true);
+                    } else {
+                        /*
+                         * SIMD STP: register data is in env->vfp.zregs[]
+                         * after cpu_synchronize_state().
+                         * esize=4: S reg, esize=8: D reg, esize=16: Q reg
+                         */
+                        uint8_t buf[32]; /* max 2 x 16 bytes */
+                        memcpy(buf, &env->vfp.zregs[rt], esize);
+                        memcpy(buf + esize,
+                               &env->vfp.zregs[rt2], esize);
+                        cpu_memory_rw_debug(cpu, va, buf,
+                                            2 * esize, true);
+                    }
+                } else {
+                    /* Load pair */
+                    if (!is_vec) {
+                        uint64_t val1 = 0, val2 = 0;
+                        uint8_t buf[16];
+                        memset(buf, 0, sizeof(buf));
+                        cpu_memory_rw_debug(cpu, va, buf,
+                                            2 * esize, false);
+                        memcpy(&val1, buf, esize);
+                        memcpy(&val2, buf + esize, esize);
+                        if (opc == 1 && !is_vec) {
+                            /* LDPSW: sign-extend 32-bit to 64-bit */
+                            val1 = (int64_t)(int32_t)val1;
+                            val2 = (int64_t)(int32_t)val2;
+                        }
+                        hvf_set_reg(cpu, rt, val1);
+                        hvf_set_reg(cpu, rt2, val2);
+                    } else {
+                        /* SIMD LDP */
+                        uint8_t buf[32];
+                        memset(buf, 0, sizeof(buf));
+                        cpu_memory_rw_debug(cpu, va, buf,
+                                            2 * esize, false);
+                        memset(&env->vfp.zregs[rt], 0,
+                               sizeof(env->vfp.zregs[rt]));
+                        memset(&env->vfp.zregs[rt2], 0,
+                               sizeof(env->vfp.zregs[rt2]));
+                        memcpy(&env->vfp.zregs[rt], buf, esize);
+                        memcpy(&env->vfp.zregs[rt2],
+                               buf + esize, esize);
+                        cpu->vcpu_dirty = true;
+                    }
+                }
+
+                /* Handle base register writeback (pre/post-index) */
+                if (writeback) {
+                    env->xregs[rn] = env->xregs[rn] + stp_offset;
+                    cpu->vcpu_dirty = true;
+                }
+
+                advance_pc = true;
+                break;
+            }
+
+            /*
+             * Load/Store Register (single):
+             * bits [29:27] = 111, bit [25] = 0.
+             * Covers immediate (unscaled, post-index, pre-index),
+             * unsigned offset, and register offset variants.
+             *
+             * ISV=0 for: writeback variants (pre/post-indexed) and
+             * all SIMD/FP loads/stores.
+             */
+            if ((insn & 0x3A000000) == 0x38000000) {
+                uint32_t size_field = extract32(insn, 30, 2);
+                bool is_vec = extract32(insn, 26, 1);
+                uint32_t opc = extract32(insn, 22, 2);
+                bool is_unsigned = extract32(insn, 24, 1);
+                bool bit21 = extract32(insn, 21, 1);
+                uint32_t rn = extract32(insn, 5, 5);
+                uint32_t rt = extract32(insn, 0, 5);
+                uint32_t sub_type = extract32(insn, 10, 2);
+                bool is_reg = !is_unsigned && bit21;
+
+                /*
+                 * [24]=0, [21]=1, [11:10]!=10 could be atomic ops
+                 * (LDADD, SWP, CAS, etc.) -- not handled.
+                 */
+                if (is_reg && sub_type != 2) {
+                    goto isv0_inject_fault;
+                }
+
+                bool writeback = !is_unsigned && !is_reg
+                                 && (sub_type == 1 || sub_type == 3);
+
+                uint32_t esize;
+                bool is_load;
+                bool is_signed = false;
+                uint32_t sign_extend_to = 0;
+
+                if (!is_vec) {
+                    esize = 1u << size_field;
+                    switch (opc) {
+                    case 0: /* STR */
+                        is_load = false;
+                        break;
+                    case 1: /* LDR */
+                        is_load = true;
+                        break;
+                    case 2:
+                        is_load = true;                      /* LDRS->64 */
+                        is_signed = true;
+                        sign_extend_to = 8;
+                        break;
+                    case 3:
+                        if (size_field == 3) {
+                            /* PRFM -- prefetch is NOP on MMIO */
+                            advance_pc = true;
+                            goto isv0_done;
+                        }
+                        is_load = true;                      /* LDRS->32 */
+                        is_signed = true;
+                        sign_extend_to = 4;
+                        break;
+                    }
+                } else {
+                    /* SIMD/FP: size+opc determines element width */
+                    is_load = (opc & 1);
+                    if (opc >= 2 && size_field == 0) {
+                        esize = 16;  /* Q register (128-bit) */
+                    } else if (opc < 2) {
+                        esize = 1u << size_field;
+                    } else {
+                        goto isv0_inject_fault;
+                    }
+                }
+
+                if (is_load == iswrite) {
+                    error_report("HVF: ISV=0 LDR/STR load/write mismatch "
+                                 "at ipa=0x%" PRIx64, ipa);
+                    goto isv0_inject_fault;
+                }
+
+                /* Perform memory access */
+                if (!is_load) {
+                    if (!is_vec) {
+                        uint64_t val = hvf_get_reg(cpu, rt);
+                        address_space_write(as, ipa,
+                                            MEMTXATTRS_UNSPECIFIED,
+                                            &val, esize);
+                    } else {
+                        address_space_write(as, ipa,
+                                            MEMTXATTRS_UNSPECIFIED,
+                                            &env->vfp.zregs[rt], esize);
+                    }
+                } else {
+                    if (!is_vec) {
+                        uint64_t val = 0;
+                        address_space_read(as, ipa,
+                                           MEMTXATTRS_UNSPECIFIED,
+                                           &val, esize);
+                        if (is_signed) {
+                            switch (esize) {
+                            case 1:
+                                val = (int64_t)(int8_t)val;
+                                break;
+                            case 2:
+                                val = (int64_t)(int16_t)val;
+                                break;
+                            case 4:
+                                val = (int64_t)(int32_t)val;
+                                break;
+                            }
+                            if (sign_extend_to == 4) {
+                                val &= 0xFFFFFFFF;
+                            }
+                        }
+                        hvf_set_reg(cpu, rt, val);
+                    } else {
+                        /* SIMD/FP load */
+                        memset(&env->vfp.zregs[rt], 0,
+                               sizeof(env->vfp.zregs[rt]));
+                        address_space_read(as, ipa,
+                                           MEMTXATTRS_UNSPECIFIED,
+                                           &env->vfp.zregs[rt], esize);
+                        cpu->vcpu_dirty = true;
+                    }
+                }
+
+                /* Base register writeback (post/pre-indexed) */
+                if (writeback) {
+                    int32_t imm9 = sextract32(insn, 12, 9);
+                    env->xregs[rn] = env->xregs[rn] + imm9;
+                    cpu->vcpu_dirty = true;
+                }
+
+                advance_pc = true;
+                goto isv0_done;
+            }
+
+isv0_inject_fault:
+            /*
+             * Inject data abort into guest for unrecognized or
+             * inconsistent ISV=0 instructions.  The guest kernel
+             * will deliver SIGBUS to the faulting process.
+             */
+            {
+                int target_el = 1;
+                bool same_el = arm_current_el(env) == target_el;
+                uint32_t esr = syn_data_abort_no_iss(same_el,
+                    /*fnv=*/1, /*ea=*/0, /*cm=*/0,
+                    /*s1ptw=*/0, iswrite, /*fsc=*/0x10);
+                env->exception.vaddress = ipa;
+                hvf_raise_exception(cpu, EXCP_DATA_ABORT,
+                                    esr, target_el);
+            }
+isv0_done:
+            break;
+        }
 
         /*
          * Emulate MMIO.
-- 
2.52.0


