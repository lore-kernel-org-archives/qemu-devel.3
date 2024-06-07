Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC5AC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 13:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFa2m-0004oZ-KY; Fri, 07 Jun 2024 09:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sFa2l-0004oD-7P
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:54:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sFa2i-000870-G2
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:54:11 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwjLz0qG8z67SnG;
 Fri,  7 Jun 2024 21:52:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 0BF3014025A;
 Fri,  7 Jun 2024 21:53:57 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 14:53:48 +0100
To: <qemu-devel@nongnu.org>, <peterx@redhat.com>, <farosas@suse.de>
CC: <yuan1.liu@intel.com>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <marcandre.lureau@redhat.com>, <thuth@redhat.com>, <armbru@redhat.com>,
 <lvivier@redhat.com>, <linuxarm@huawei.com>, <linwenkai6@hisilicon.com>,
 <zhangfei.gao@linaro.org>, <huangchenghai2@huawei.com>
Subject: [PATCH v2 0/7] Live migration acceleration with UADK
Date: Fri, 7 Jun 2024 14:53:03 +0100
Message-ID: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.28]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) AC_FROM_MANY_DOTS=0.001, BAYES_00=-1.9,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

v1 --> v2
(v1: https://lore.kernel.org/qemu-devel/20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com/)

-Rebased on top of Intel IAA v7 series[0].
-Addressed comments from Fabiano. Thanks.
-Gathered tags received.

Please take a look and let me know your feedback.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20240603154106.764378-1-yuan1.liu@intel.com/

---

This series adds support for UADK library based hardware acceleration
for live migration. UADK[0] is a general-purpose user space accelerator
framework that uses shared virtual addressing (SVA) to provide a unified
programming interface for hardware acceleration of cryptographic and
compression algorithms.

UADK makes use of the UACCE(Unified/User-space-access-intended Accelerator
Framework) Linux kernel module which enables hardware accelerators from
different vendors that support SVA to adapt to UADK. Linux kernel from
v5.9 has support for UACCE and SVA on ARM64 platforms.

Currently, HiSilicon Kunpeng hardware accelerators have been registered with
UACCE and the Zip accelerator on these platforms can be used for compression
which can  free up CPU computing power and improve computing performance.

This series is on top of Intel IAA accelerator live migration support
series[1] from Yuan Liu. Many thanks for doing this.

Initial tests were carried out on HiSilicon D06 platforms and the results
are as below:

Test setup: HiSilicon D06 boards connected over a 1Gbps n/w.
Host Kernel: Host Kernel: 6.7.0 Mainline Kernel.
Guest VM: 64 cpus, 16GB mem, hugepages, prealloc=on (80% Memory filled
          with random data)

 +--------+-------------+--------+--------+----------+------+
 |        | The number  |total   |downtime|pages per | CPU  |
 | None   | of channels |time(ms)|(ms)    |second    | Util |
 | Comp   |             |        |        |          |      |
 |        +-------------+-----------------+----------+------+
 |Network |            2|  114536|      79|   32849  |   18%|
 |BW:  1G +-------------+--------+--------+----------+------+
 |        |            4|  114327|      78|   34217  |   22%|
 |        +-------------+--------+--------+----------+------+
 |        |            8|  114231|     107|   211840 |   24%|
 +--------+-------------+--------+--------+----------+------+
 
 +--------+-------------+--------+--------+----------+------+
 |        | The number  |total   |downtime|pages per | CPU  |
 | UADK   | of channels |time(ms)|(ms)    |second    | Util |
 | Comp   |             |        |        |          |      |
 |        +-------------+-----------------+----------+------+
 |Network |            2|  77192 |      75|   182679 |   24%|
 |BW:  1G +-------------+--------+--------+----------+------+
 |        |            4|  77000 |      86|   185600 |   25%|
 |        +-------------+--------+--------+----------+------+
 |        |            8|  76835 |      97|   330966 |   27%|
 +--------+-------------+--------+--------+----------+------+
 
 +--------+-------------+--------+--------+----------+------+
 |        | The number  |total   |downtime|pages per | CPU  |
 | ZLIB   | of channels |time(ms)|(ms)    |second    | Util |
 | Comp   |             |        |        |          |      |
 |        +-------------+-----------------+----------+------+
 |Network |            2|  134664|      73|   42666  |  200%|
 |BW:  1G +-------------+--------+--------+----------+------+
 |        |            4|  71550 |      72|   181227 |  390%|
 |        +-------------+--------+--------+----------+------+
 |        |            8|  67781 |     108|   200960 |  460%|
 +--------+-------------+--------+--------+----------+------+
 
 +--------+-------------+--------+--------+----------+------+
 |        | The number  |total   |downtime|pages per | CPU  |
 | ZSTD   | of channels |time(ms)|(ms)    |second    | Util |
 | Comp   |             |        |        |          |      |
 |        +-------------+-----------------+----------+------+
 |Network |            2|  67822 |      73|   202772 |  160%|
 |BW:  1G +-------------+--------+--------+----------+------+
 |        |            4|  67460 |     107|   198400 |  180%|
 |        +-------------+--------+--------+----------+------+
 |        |            8|  67422 |     83 |   349808 |  215%|
 +--------+-------------+--------+--------+----------+------+

From the above results, UADK has considerable CPU cycle savings
compared to both Zlib/Zstd.  Also compared with Qemu 
"multifd-compression none" mode UADK has an edge on migration
"total time".

Please take a look and let me know your feedback.

Thanks,
Shameer

[0] https://github.com/Linaro/uadk/tree/master/docs
[1] https://lore.kernel.org/qemu-devel/20240505165751.2392198-1-yuan1.liu@intel.com/

Shameer Kolothum via (7):
  docs/migration: add uadk compression feature
  configure: Add uadk option
  migration/multifd: add uadk compression framework
  migration/multifd: Add UADK initialization
  migration/multifd: Add UADK based compression and decompression
  migration/multifd: Switch to no compression when no hardware support
  tests/migration-test: add uadk compression test

 docs/devel/migration/features.rst         |   1 +
 docs/devel/migration/uadk-compression.rst | 144 +++++++++
 hw/core/qdev-properties-system.c          |   2 +-
 meson.build                               |  14 +
 meson_options.txt                         |   2 +
 migration/meson.build                     |   1 +
 migration/multifd-uadk.c                  | 369 ++++++++++++++++++++++
 migration/multifd.h                       |   5 +-
 qapi/migration.json                       |   5 +-
 scripts/meson-buildoptions.sh             |   3 +
 tests/qtest/migration-test.c              |  23 ++
 11 files changed, 565 insertions(+), 4 deletions(-)
 create mode 100644 docs/devel/migration/uadk-compression.rst
 create mode 100644 migration/multifd-uadk.c

-- 
2.34.1


