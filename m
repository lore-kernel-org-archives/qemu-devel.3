Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CF6C61DB8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 02:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNj2Y-0000PH-3n; Fri, 06 Jun 2025 22:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1uNj2V-0000ON-LY; Fri, 06 Jun 2025 22:12:07 -0400
Received: from mail-m16.yeah.net ([1.95.21.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1uNj2S-0000ZZ-L4; Fri, 06 Jun 2025 22:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nH
 btRKU8Gyt3giZG8w4jmWalT3bh7VUrtyE7KgGYAww=; b=JbF6QsRpusR5+8gs7m
 1ySXPiS+JMRjdQLHUBLTj8acoWDdX/0QQVvvOIFlf6XhEnq/UpcKnlY3kq5Ilc0L
 MYVd/thZnDbmiMECNaUy++lW74N3ONP4g1kbI0kHJNbcHCqr5gzRvyrSj5b9RHi+
 5h6Kej6VR5T6og+ZjunhOaZco=
Received: from localhost.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id M88vCgD3lzban0NoD9EbAA--.58043S2;
 Sat, 07 Jun 2025 10:11:39 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: dbarboza@ventanamicro.com,
	palmer@dabbelt.com,
	alistair23@gmail.com
Cc: zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhangtj@tecorigin.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v5 0/1] fix the way riscv_plic_hart_config_string() gets the
 CPUState
Date: Sat,  7 Jun 2025 10:11:27 +0800
Message-ID: <cover.1749224867.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: M88vCgD3lzban0NoD9EbAA--.58043S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWUCw45Zw1fAr15tFyfXrb_yoW8uw4UpF
 WUWFs8Ar1vyr97GayxWFZ7WrWkuwn5Gry5tF4Skr1fZ3yxKFW5AF4DCw4Yy347Aa4kG3WD
 ua9Yg3W5ZF4fJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxOz3UUUUU=
X-Originating-IP: [124.128.76.86]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiIBwKMmhDn9z8UgAA3C
Received-SPF: pass client-ip=1.95.21.16; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi,

Thanks to Daniel's testing, I have fixed this bug. 

PATCHv5:

The differences are as follows:

```
@@ -790,10 +790,11 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
     char *plic_hart_config;
-    int hartid_base = 1;
     int i, j;
 
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
-    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", hartid_base);
+    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);

...
@@ -829,7 +829,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)

-    plic_hart_config = riscv_plic_hart_config_string(hartid_base, ms->smp.cpus);
+    plic_hart_config = riscv_plic_hart_config_string(0, ms->smp.cpus);
```

s->u_cpus use (ms->smp.cpus - 1), but plic_hart_config use ms->smp.cpus,
so the same hartid-base should not be used.

Therefore, we should keep the original implementation here.

PS:

During my testing, I encountered a small issue, although riscv64_tuxrun passed
the test, it still displayed a timeout. When I removed my patch,
the result was still the same.

PATCH v4:

Rebasing this on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

PATCH v3:

Use cpu_by_arch_id() instead of qemu_get_cpu(), when registering gpio in
sifive_plic_create().

PATCH v2:

During plic initialization, CPUSate is obtained by traversing qemu_get_cpu(),
which was an early design flaw (see PATCH v1 reviewed).

A better approach is to use riscv's hartid for indexing via the cpu_by_arch_id()
interface.

PATCH v1 (Reviewed):
https://lore.kernel.org/qemu-riscv/416e68f4-bf12-4218-ae2d-0246cc8ea8ec@linaro.org/T/#u

--
Regards,
Chao

Chao Liu (1):
  hw/riscv: fix PLIC hart topology configuration string when not getting
    CPUState correctly

 hw/intc/sifive_plic.c      | 4 ++--
 hw/riscv/boot.c            | 4 ++--
 hw/riscv/microchip_pfsoc.c | 2 +-
 hw/riscv/sifive_u.c        | 2 +-
 hw/riscv/virt.c            | 2 +-
 include/hw/riscv/boot.h    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.49.0


