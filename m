Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41BEC27C53
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:26:34 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf3Z-0005ry-DD; Fri, 07 Jun 2024 15:15:21 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf3X-0005rJ-Vt; Fri, 07 Jun 2024 15:15:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf3U-0002D1-On; Fri, 07 Jun 2024 15:15:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D71B56E551;
 Fri,  7 Jun 2024 22:14:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 14D50E274D;
 Fri,  7 Jun 2024 22:13:11 +0300 (MSK)
Received: (nullmailer pid 528749 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:08 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.5 40/45] target/riscv/kvm.c: Fix the hart bit setting of
 AIA
Date: Fri,  7 Jun 2024 22:12:59 +0300
Message-Id: <20240607191307.528622-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
References: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

In AIA spec, each hart (or each hart within a group) has a unique hart
number to locate the memory pages of interrupt files in the address
space. The number of bits required to represent any hart number is equal
to ceil(log2(hmax + 1)), where hmax is the largest hart number among
groups.

However, if the largest hart number among groups is a power of 2, QEMU
will pass an inaccurate hart-index-bit setting to Linux. For example, when
the guest OS has 4 harts, only ceil(log2(3 + 1)) = 2 bits are sufficient
to represent 4 harts, but we passes 3 to Linux. The code needs to be
updated to ensure accurate hart-index-bit settings.

Additionally, a Linux patch[1] is necessary to correctly recover the hart
index when the guest OS has only 1 hart, where the hart-index-bit is 0.

[1] https://lore.kernel.org/lkml/20240415064905.25184-1-yongxuan.wang@sifive.com/t/

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240515091129.28116-1-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 190b867f28cb5781f3cd01a3deb371e4211595b1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index fa00b14269..aa7444d958 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1455,7 +1455,14 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         }
     }
 
-    hart_bits = find_last_bit(&max_hart_per_socket, BITS_PER_LONG) + 1;
+
+    if (max_hart_per_socket > 1) {
+        max_hart_per_socket--;
+        hart_bits = find_last_bit(&max_hart_per_socket, BITS_PER_LONG) + 1;
+    } else {
+        hart_bits = 0;
+    }
+
     ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                             KVM_DEV_RISCV_AIA_CONFIG_HART_BITS,
                             &hart_bits, true, NULL);
-- 
2.39.2


