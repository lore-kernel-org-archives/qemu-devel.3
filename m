Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9562C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtcxl-0001jY-4p; Mon, 10 Aug 2026 23:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liliang2057@phytium.com.cn>)
 id 1wtcxh-0001gS-2T; Mon, 10 Aug 2026 23:15:33 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liliang2057@phytium.com.cn>)
 id 1wtcxe-0005WG-27; Mon, 10 Aug 2026 23:15:32 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwAHD7fEk3pqunvdAA--.60634S2; 
 Tue, 11 Aug 2026 11:15:16 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwfHTAk3pqUTgiAA--.58848S3;
 Tue, 11 Aug 2026 11:15:13 +0800 (CST)
From: Liang Li <liliang2057@phytium.com.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, tangtao1634@phytium.com.cn,
 Liang Li <liliang2057@phytium.com.cn>
Subject: [RFC PATCH 0/1] RISC-V vector fault-only-first vl truncation under
 plugin memory callbacks
Date: Tue, 11 Aug 2026 11:14:54 +0800
Message-ID: <20260811031455.1330838-1-liliang2057@phytium.com.cn>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwfHTAk3pqUTgiAA--.58848S3
X-CM-SenderInfo: 5oloxttqjsikux6sx5pwlxzhxfrphubq/1tbiAQAEAGp6JskBaQACsQ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=liliang205
 7@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWw4kGF1xXFyfGr1DKrWxZwb_yoW5CryxpF
 Z2k3y3K34kXr93X34fAa17Xw1rtw4rGa1UCas7Jr1xZrW5ZrnFv3yxKw4jkFy5Gr1rA34a
 vFZ0vFy7uF1UAaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Reproduced on master (v11.1.0-rc3) with a minimal memory-callback plugin and
a vle8ff strlen guest: enabling the plugin inflates the vle8ff execution
count ~16x without the fix, and has no effect with it. Reproducer (plugin +
guest sources, ~100 lines total) available on request or in a follow-up.

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

Patch is compile-tested on riscv64 system and user modes; full functional
testing and a proper tests/tcg case will follow once the approach is agreed.

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


