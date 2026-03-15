Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7D0F3026D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 16:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1oUl-0006EY-Gy; Sun, 15 Mar 2026 12:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w1oUh-0006EE-Jg
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 12:39:12 -0400
Received: from out-182.mta1.migadu.com ([95.215.58.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w1oUe-0003kR-BC
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 12:39:11 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1773592744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qG1cFCLchytQdDL6JPUlWv/uaHhSzGiIiaOFboPuR0w=;
 b=eTEy4Er1Y6j2jkiqvy6A1bpHihvRT0yp2DIgTFNwRHAVRIBgzuw9EcZsA7QXYDiZ7+ORQ7
 tdDqn/yJaKxijKj/pe7BtudtbcC2zgnaFO3HHuhEJfi22+7cOpP8ZJ7apck6PwAE1SJldY
 GQJkNK3J7yJbhsxeq5T+CGBu1Q48VE0=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org,
 Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH rfc] hvf: arm: Inject SEA when executing insn in invalid
 memory range
Date: Mon, 16 Mar 2026 00:38:40 +0800
Message-ID: <20260315163840.30741-1-zenghui.yu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.182; envelope-from=zenghui.yu@linux.dev;
 helo=out-182.mta1.migadu.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It seems that hvf doesn't deal with the abort generated when guest tries to
execute instructions outside of the valid physical memory range, for
unknown reason. The abort is forwarded to userspace and QEMU doesn't handle
it either, which ends up with faulting on the same instruction infinitely.

This was noticed by the kvm-unit-tests/selftest-vectors-kernel failure:

  timeout -k 1s --foreground 90s /opt/homebrew/bin/qemu-system-aarch64 \
    -nodefaults -machine virt -accel hvf -cpu host \
    -device virtio-serial-device -device virtconsole,chardev=ctd \
    -chardev testdev,id=ctd -device pci-testdev -display none \
    -serial stdio -kernel arm/selftest.flat -smp 1 -append vectors-kernel

  PASS: selftest: vectors-kernel: und
  PASS: selftest: vectors-kernel: svc
  qemu-system-aarch64: 0xffffc000: unhandled exception ec=0x20
  qemu-system-aarch64: 0xffffc000: unhandled exception ec=0x20
  qemu-system-aarch64: 0xffffc000: unhandled exception ec=0x20
  [...]

It's apparent that the guest is braindead and it's unsure what prevents hvf
from injecting an abort directly in that case. Try to deal with the insane
guest in QEMU by injecting an SEA back into it in the EC_INSNABORT
emulation path.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 target/arm/hvf/hvf.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index aabc7d32c1..54d6ea469c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2332,9 +2332,32 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         bool ea = (syndrome >> 9) & 1;
         bool s1ptw = (syndrome >> 7) & 1;
         uint32_t ifsc = (syndrome >> 0) & 0x3f;
+        uint64_t ipa = excp->physical_address;
+        AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
+        hwaddr xlat;
+        MemoryRegion *mr;
+
+        cpu_synchronize_state(cpu);
 
         trace_hvf_insn_abort(env->pc, set, fnv, ea, s1ptw, ifsc);
 
+        /*
+         * TODO: If s1ptw, this is an error in the guest os page tables.
+         * Inject the exception into the guest.
+         */
+        assert(!s1ptw);
+
+        mr = address_space_translate(as, ipa, &xlat, NULL, false,
+                                     MEMTXATTRS_UNSPECIFIED);
+        if (unlikely(!memory_region_is_ram(mr))) {
+            uint32_t syn;
+
+            /* inject an SEA back into the guest */
+            syn = syn_insn_abort(arm_current_el(env) == 1, ea, false, 0x10);
+            hvf_raise_exception(cpu, EXCP_PREFETCH_ABORT, syn, 1);
+            break;
+        }
+
         /* fall through */
     }
     default:
-- 
2.53.0


