Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A157C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 05:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFX-0002XC-Jr; Fri, 31 Jul 2026 01:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM7-0005tf-3M; Thu, 30 Jul 2026 23:56:19 -0400
Received: from [115.124.30.118] (helo=out30-118.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM0-0002IC-7N; Thu, 30 Jul 2026 23:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470163; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=/IMVwNB06KOv98G3TbtOzyWq7d49eCbIfTpVOyNYHPw=;
 b=ryCmZ6O1WKiGXa21BR+DK0MlMzIBQOYM0rw7CxgfPyu68yx9hZ9JXj82GvNEiufy0FnmWnSnLOVmoVH4hTVW+g3zSps00Zn1oW3QuzRS4lz7lK3nZxkpAGEzcN0+OqWwTNyBIT5tP6ASRkDOgGW3ldHcehUnKO/3muZ4wQBjNW0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R361e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwSr_1785469851; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwSr_1785469851 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:52 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 06/17] hw/riscv/virt: measure the device tree of a CoVE
 guest
Date: Fri, 31 Jul 2026 11:50:00 +0800
Message-Id: <20260731035011.4178103-7-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.118 (deferred)
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:32 -0400
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

The device tree is the last piece of guest state that has to be part of
the initial measurement of a TEE VM.  The ROM blob holding it is only
written to guest memory when the machine is reset, which is too late, so
copy it into RAM and measure it right after its address is known.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 hw/riscv/virt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a76587d362..c15d8859ce 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1277,6 +1277,24 @@ static void virt_machine_done(Notifier *notifier, void *data)
                                            machine, &boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
+    /*
+     * The device tree is part of the initial measurement of a TVM. The ROM
+     * blobs holding it are not written to guest memory before the machine is
+     * reset, so copy it into RAM now to be able to measure it.
+     */
+    if (s->cove_vm) {
+        void *ram_base = memory_region_get_ram_ptr(machine->ram);
+        hwaddr fdt_offset = fdt_load_addr - s->memmap[VIRT_DRAM].base;
+        void *fdt_host;
+
+        memcpy((char *)ram_base + fdt_offset, machine->fdt, s->fdt_size);
+
+        fdt_host = kvm_gpa_to_userspace_addr(kvm_state, fdt_load_addr);
+        kvm_riscv_cove_measure_region((uint64_t)(uintptr_t)fdt_host,
+                                      fdt_load_addr,
+                                      ROUND_UP(s->fdt_size, 4 * KiB));
+    }
+
     /* load the reset vector */
     riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
                               s->memmap[VIRT_MROM].base,
-- 
2.34.1


