Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252CCCE9D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9SM-0004K4-5o; Tue, 06 Jan 2026 10:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vd9SJ-0003yx-EE; Tue, 06 Jan 2026 10:58:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vd9SG-0006jd-4C; Tue, 06 Jan 2026 10:58:47 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlwnL6qCFzJ46CZ;
 Tue,  6 Jan 2026 23:58:30 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id B819A40571;
 Tue,  6 Jan 2026 23:58:32 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.31.135) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 Jan 2026 15:58:31 +0000
To: <qemu-devel@nongnu.org>, <gustavo.romero@linaro.org>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <imammedo@redhat.com>, <jiangkunkun@huawei.com>,
 <maobibo@loongson.cn>, <mst@redhat.com>, <mtosatti@redhat.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <shannon.zhaosl@gmail.com>,
 <yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <zhao1.liu@intel.com>
Subject: [PATCH v17 0/8] Specifying cache topology on ARM
Date: Tue, 6 Jan 2026 15:58:19 +0000
Message-ID: <20260106155828.643-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.31.135]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Specifying the cache layout in virtual machines is useful for
applications and operating systems to fetch accurate information about
the cache structure and make appropriate adjustments. Enforcing correct
sharing information can lead to better optimizations. Patches that allow
for an interface to express caches was landed in the prior cycles. This
patchset uses the interface as a foundation.  Thus, the device tree and
ACPI/PPTT table, and device tree are populated based on
user-provided information and CPU topology.

Example:

+----------------+                         +----------------+
|    Socket 0    |                         |    Socket 1    |
|    (L3 Cache)  |                         |    (L3 Cache)  |
+--------+-------+                         +--------+-------+
         |                                          |
+--------+--------+                        +--------+--------+
|   Cluster 0     |                        |   Cluster 0     |
|   (L2 Cache)    |                        |   (L2 Cache)    |
+--------+--------+                        +--------+--------+
         |                                          |
+--------+--------+  +--------+--------+   +--------+--------+  +--------+----+
|   Core 0         | |   Core 1        |   |   Core 0        |  |   Core 1    |
|   (L1i, L1d)     | |   (L1i, L1d)    |   |   (L1i, L1d)    |  |   (L1i, L1d)|
+--------+--------+  +--------+--------+   +--------+--------+  +--------+----+
         |                    |                     |                    |
+--------+              +--------+             +--------+           +--------+
|Thread 0|              |Thread 1|             |Thread 1|           |Thread 0|
+--------+              +--------+             +--------+           +--------+
|Thread 1|              |Thread 0|             |Thread 0|           |Thread 1|
+--------+              +--------+             +--------+           +--------+


The following command will represent the system relying on **ACPI PPTT tables**.

./qemu-system-aarch64 \
 -machine virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluster,smp-cache.3.cache=l3,smp-cache.3.topology=socket \
 -cpu max \
 -m 2048 \
 -smp sockets=2,clusters=1,cores=2,threads=2 \
 -kernel ./Image.gz \
 -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
 -initrd rootfs.cpio.gz \
 -bios ./edk2-aarch64-code.fd \
 -nographic

The following command will represent the system relying on **the device tree**.

./qemu-system-aarch64 \
 -machine virt,acpi=off,smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluster,smp-cache.3.cache=l3,smp-cache.3.topology=socket \
 -cpu max \
 -m 2048 \
 -smp sockets=2,clusters=1,cores=2,threads=2 \
 -kernel ./Image.gz \
 -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=off" \
 -initrd rootfs.cpio.gz \
 -nographic

Failure cases:
    1) There are scenarios where caches exist in systems' registers but
    left unspecified by users. In this case qemu returns failure.

    2) SMT threads cannot share caches which is not very common. More
    discussions here [1].

Currently only three levels of caches are supported to be specified from
the command line. However, increasing the value does not require
significant changes. Further, this patch assumes l2 and l3 unified
caches and does not allow l(2/3)(i/d). The level terminology is
thread/core/cluster/socket. Hierarchy assumed in this patch:
Socket level = Cluster level + 1 = Core level + 2 = Thread level + 3;

Possible future enhancements:
  1) Separated data and instruction cache at L2 and L3.
  2) Additional cache controls.  e.g. size of L3 may not want to just
  match the underlying system, because only some of the associated host
  CPUs may be bound to this VM.

[1] https://lore.kernel.org/devicetree-spec/20250203120527.3534-1-alireza.sanaee@huawei.com/

Change Log:
  v16->v17:
    * Rebased to 0fc482b73d8e085d1375b4e17b0647fd2e6fe8f0.
    * Addressed Gustavo's comments. Thanks for the review.
    * v16: https://lore.kernel.org/all/20250827142152.206-1-alireza.sanaee@huawei.com/

  v15->v16:
    * Rebase to e771ba98de25c9f43959f79fc7099cf7fbba44cce.
    * v15: https://lore.kernel.org/qemu-devel/20250812122829.204-1-alireza.sanaee@huawei.com/

  v14->v15:
   * Introduced a separate patch for loongarch64 build_pptt function.
   * Made sure loongarch64 tests pass.
   * Downgraded to V2 for ACPI PPTT. Removed PPTT IDs as was not necessary.
   * Removed dependency as it's been merged in the recent cycle.
     -- 20250604115233.1234-1-alireza.sanaee@huawei.com
   * Fixed styling issues and removed irrelevant changes.
   * Moved cache headers to core/cpu.h to be used in both acpi and virt.
   * v14: https://lore.kernel.org/qemu-devel/20250707121908.155-1-alireza.sanaee@huawei.com/
   # Thanks to Jonathan and Zhao for their comments.

  v13->v14:
   * Rebased on latest staging.
   * Made some naming changes to machine-smp.c, addd docs added to the
        same file.

  v12->v13:
   * Applied comments from Zhao.
   * Introduced a new patch for machine specific cache topology functions.
   * Base: bc98ffdc7577e55ab8373c579c28fe24d600c40f.

  v11->v12:
   * Patch #4 couldn't not merge properly as the main file diverged. Now it is fixed (hopefully).
   * Loonarch build_pptt function updated.
   * Rebased on 09be8a511a2e278b45729d7b065d30c68dd699d0.

  v10->v11:
   * Fix some coding style issues.
   * Rename some variables.

  v9->v10:
   * PPTT rev down to 2.

  v8->v9:
   * rebase to 10
   * Fixed a bug in device-tree generation related to a scenario when
        caches are shared at core in higher levels than 1.
  v7->v8:
   * rebase: Merge tag 'pull-nbd-2024-08-26' of https://repo.or.cz/qemu/ericb into staging
   * I mis-included a file in patch #4 and I removed it in this one.

  v6->v7:
   * Intel stuff got pulled up, so rebase.
   * added some discussions on device tree.

  v5->v6:
   * Minor bug fix.
   * rebase based on new Intel patchset.
     - https://lore.kernel.org/qemu-devel/20250110145115.1574345-1-zhao1.liu@intel.com/

  v4->v5:
    * Added Reviewed-by tags.
    * Applied some comments.

  v3->v4:
    * Device tree added.

Alireza Sanaee (8):
  target/arm/tcg: increase cache level for cpu=max
  hw/core/machine: topology functions capabilities added
  hw/arm/virt: add cache hierarchy to device tree
  bios-tables-test: prepare to change ARM ACPI virt PPTT
  acpi: add caches to ACPI build_pptt table function
  hw/acpi: add cache hierarchy to pptt table
  tests/qtest/bios-table-test: testing new ARM ACPI PPTT topology
  Update the ACPI tables based on new aml-build.c

 hw/acpi/aml-build.c                        | 203 +++++++++++-
 hw/arm/virt-acpi-build.c                   |   8 +-
 hw/arm/virt.c                              | 364 ++++++++++++++++++++-
 hw/core/machine-smp.c                      |  52 +++
 hw/loongarch/virt-acpi-build.c             |   4 +-
 include/hw/acpi/aml-build.h                |   4 +-
 include/hw/acpi/cpu.h                      |  10 +
 include/hw/arm/virt.h                      |  17 +-
 include/hw/core/boards.h                   |   5 +
 include/hw/core/cpu.h                      |  12 +
 target/arm/tcg/cpu64.c                     |  10 +
 tests/data/acpi/aarch64/virt/PPTT.topology | Bin 356 -> 516 bytes
 tests/qtest/bios-tables-test.c             |   4 +
 13 files changed, 678 insertions(+), 15 deletions(-)

-- 
2.43.0


