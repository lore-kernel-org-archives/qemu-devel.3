Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAE6C5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjx4-0005Ms-4a; Tue, 11 Aug 2026 06:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liliang2057@phytium.com.cn>)
 id 1wtjx1-0005MM-Fi; Tue, 11 Aug 2026 06:43:19 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liliang2057@phytium.com.cn>)
 id 1wtjwz-0007Y5-5e; Tue, 11 Aug 2026 06:43:19 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwB3fMS9_HpqDAbfAA--.750S2;
 Tue, 11 Aug 2026 18:43:09 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwwXO5_HpqqmUiAA--.55911S3;
 Tue, 11 Aug 2026 18:43:06 +0800 (CST)
From: Liang Li <liliang2057@phytium.com.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, tangtao1634@phytium.com.cn,
 Liang Li <liliang2057@phytium.com.cn>
Subject: [RFC PATCH 0/1] RISC-V vector fault-only-first vl truncation under
 plugin memory callbacks
Date: Tue, 11 Aug 2026 18:43:00 +0800
Message-ID: <20260811104301.1377245-1-liliang2057@phytium.com.cn>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwwXO5_HpqqmUiAA--.55911S3
X-CM-SenderInfo: 5oloxttqjsikux6sx5pwlxzhxfrphubq/1tbiAQAEAGp6JskBdQANsD
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=liliang205
 7@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKF1rKr4UZFWftr1rXryDGFg_yoWxCF1UpF
 1kCry3trWktr97u3WfAw12kw13trs7Wa1UG34xGr18Aan8Jr1qq397K340yFy5Gr4rZ3W2
 9rW3Xa4Uua17AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=liliang2057@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi,

This is an RFC for a RISC-V vector fault-only-first interaction with plugin
memory callbacks. I'd like feedback on whether this is considered a bug and
whether the fix is at the right layer before I invest in tests/etc.

The fault-only-first load (vle*ff, e.g. vle8ff.v) decides vl by probing each
element and truncating at the first fault. That probe goes through
probe_access_flags(), which -- when a plugin registers a vcpu_mem callback --
returns a non-zero "not plain RAM" flag for ordinary RAM: TLB_MMIO via
force_mmio in system mode (commit 6d03226b42), or TLB_FORCE_SLOW in user mode.

For a normal load these flags only select the fast/slow path and the data is
still read correctly. But vext_ldff() treats any flag other than TLB_WATCHPOINT
as "this element faults", so the first non-first element is reported faulting
and vl is truncated to 1. The loaded data stays correct, but a vectorized
strlen/scan degenerates from N bytes/iter to 1 byte/iter, inflating the
dynamic instruction count whenever a memory-observing plugin is attached.

We hit this in practice while generating SimPoint BBVs for SPECcpu2017
500.perlbench_r under a memory-observing plugin: the instruction stream
diverged from the plugin-disabled baseline at perl_parse's vectorized strlen.

Patch 1 routes vext_ldff()'s probes through probe_access_full_mmu()
(check_mem_cbs=false), leaving the plain-load path unchanged so plugin
observation of real loads/stores is preserved. A user-mode counterpart of
probe_access_full_mmu() is added (it previously only existed in system mode).

Reproduced on master (v11.1.0-rc3) in riscv64-linux-user. With the minimal
reproducer below: enabling the plugin inflates the vle8ff execution count
from 32M to 512M (~16x) and total insns from ~234M to ~3594M; with this
patch applied, both counts are identical to the no-plugin baseline (32M).

Questions:

  1. Is the vl truncation under a memory-observing plugin a bug, or is
     reflecting force_mmio/TLB_FORCE_SLOW into the FOF probe intentional?
  2. Is probe_access_full_mmu() at the FOF call sites the preferred layer,
     or should probe_access_flags() itself not fold plugin-induced force-slow
     into its returned flags?
  3. I noticed target/i386/tcg/access.c already works around the same
     force-slow (the "No haddr means probe_access wants to force slow path"
     comment). Would a more general fix at the probe_access_flags() layer be
     preferred so each target doesn't paper over it independently?

Patch is compile-tested on riscv64 system and user modes. A proper tests/tcg
case will follow once the approach is agreed.

Reproducer (two files, linux-user)
==================================

Below are two self-contained files verified against this tree. Build the
plugin with gcc, the guest with a riscv64 cross-gcc (needs rv64gcv), then
run with qemu-riscv64 built from this tree.

--- vle8ff_repro.c (plugin) ---
/*
 * Registers a vcpu_mem callback (the trigger) and counts vle8ff executions.
 * Load with ,nocb for the baseline, ,memcb=true to enable the callback.
 */
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <qemu-plugin.h>

QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;

static bool memcb_enable = false;
static uint64_t vle8ff_count = 0;
static uint64_t total_insn = 0;

static inline bool is_vle8ff(uint32_t insn)
{
    return (insn & 0x0007FFFF) == 0x00070087;
}

static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
                     uint64_t vaddr, void *udata)
{
    /* empty: registering this callback is what triggers force_mmio */
}

static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
{
    uint32_t insn = (uintptr_t)udata;
    total_insn++;
    if (is_vle8ff(insn)) {
        vle8ff_count++;
    }
}

static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *udata)
{
    size_t n = qemu_plugin_tb_n_insns(tb);
    for (size_t i = 0; i < n; i++) {
        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
        uint32_t code = 0;
        qemu_plugin_insn_data(insn, &code, sizeof(code));
        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
                                               QEMU_PLUGIN_CB_NO_REGS,
                                               (void *)(uintptr_t)code);
        if (memcb_enable) {
            qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
                                             QEMU_PLUGIN_CB_NO_REGS,
                                             QEMU_PLUGIN_MEM_RW, NULL);
        }
    }
}

static void plugin_exit(void *p)
{
    fprintf(stderr, "memcb=%d total_insn=%" PRIu64 " vle8ff=%" PRIu64 "\n",
            memcb_enable, total_insn, vle8ff_count);
}

QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                           const qemu_info_t *info,
                                           int argc, char **argv)
{
    for (int i = 0; i < argc; i++) {
        if (strstr(argv[i], "memcb") && !strstr(argv[i], "off")) memcb_enable = true;
        else if (strstr(argv[i], "nocb")) memcb_enable = false;
    }
    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
    return 0;
}

--- vle8ff_asm.c (guest) ---
#include <string.h>
#include <stdint.h>
volatile uint64_t sink;

static size_t my_strlen(const char *s) {
    register long a4 asm("a4") = (long)s;
    register long a2 asm("a2");
    for (;;) {
        long vl;
        asm volatile(".option push\n.option arch,+v\n"
                     "vsetvli %0, zero, e8, m1, ta, ma\n"
                     "vle8ff.v v1, (%1)\n"
                     "vmseq.vi v1, v1, 0\n"
                     "csrr %0, vl\n"
                     "vfirst.m %2, v1\n"
                     ".option pop\n"
                     : "=r"(vl), "+r"(a4), "=r"(a2) :: "v1","memory");
        if (a2 < 0) { a4 += vl; continue; }
        return (size_t)(a4 - (long)s) + a2;
    }
}

int main(void) {
    char buf[256];
    memset(buf, 'A', 255); buf[255] = 0;
    for (int i = 0; i < 2000000; i++) sink = my_strlen(buf);
    return (int)(sink & 1);
}

--- Build and run ---
# plugin (host gcc, needs glib)
gcc -shared -fPIC -O2 -I include/plugins \
    $(pkg-config --cflags glib-2.0) -o vle8ff_repro.so vle8ff_repro.c
# guest (riscv64 cross-gcc, needs V extension)
riscv64-unknown-linux-gnu-gcc -O2 -march=rv64gcv -mabi=lp64d -static \
    vle8ff_asm.c -o vle8ff_asm
# baseline vs with-callback
qemu-riscv64 -plugin vle8ff_repro.so,nocb     vle8ff_asm
qemu-riscv64 -plugin vle8ff_repro.so,memcb=on vle8ff_asm

On unpatched master the memcb=on run reports ~16x more vle8ff executions
than nocb; with this patch both runs report the same count.

Thanks,
Liang Li

Liang Li (1):
  target/riscv: fix vector fault-only-first vl truncation under plugin
    memory callbacks

 accel/tcg/user-exec.c            | 35 ++++++++++++++++++++++----
 include/accel/tcg/probe.h        |  8 ++++--
 target/riscv/tcg/vector_helper.c | 42 ++++++++++++++++++++++++--------
 3 files changed, 68 insertions(+), 17 deletions(-)

--
2.51.1


