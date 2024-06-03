Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A486C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEU5h-0001Vb-R8; Tue, 04 Jun 2024 09:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sEU5f-0001JD-10
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:20:39 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sEU5a-0000MV-7B
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717507234; x=1749043234;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9qPRVDqYJ1GSM6lsYGd0cn82rTIDnWj3ydOQmYlJqpE=;
 b=UIC8UFOKvOTS30+9Vz81nnAN9/Ei5AeHfqVjbxjX9VmgcV9DvWFk9Zf/
 ei8lf3jTwRcNnc6xtseWe6tRZRdUpoMwzoVFDIEAh1iAudbgXJlS/aKrT
 H41Rynx3f6m7jhkiFlQZM0ogXugXHqMlMXuHCitj331DoZzlB/72IgyOS
 x9KFV7cCZ292PkFbOT1YlhTvuq6JEuFZgPrvbcPQ2Y3Y3k4j3zl0Ij8G5
 gz60pBCtH3CaSxVe6Q4cG6QAl2Zt1/ZAffk/WPpZ0IEp6QjbbOGAOSata
 L59nYlM5Ozd1eU9kBC3RxqnEFi4TNk1zaALGsA+X2+p0cZnIG3mbpulhS A==;
X-CSE-ConnectionGUID: aWOZgLCUTka6wKymXt4J8g==
X-CSE-MsgGUID: 64OGoQAiQHKNKCkzZVWtsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14244686"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="14244686"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 06:20:28 -0700
X-CSE-ConnectionGUID: gy9YbELNTEWzsOnb7S8aBg==
X-CSE-MsgGUID: lXrLsf19Sv6uOrfH3AKHpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="41674369"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa003.fm.intel.com with ESMTP; 04 Jun 2024 06:20:23 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v7 0/7] Live Migration With IAA
Date: Mon,  3 Jun 2024 23:40:59 +0800
Message-ID: <20240603154106.764378-1-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I am writing to submit a code change aimed at enhancing live migration
acceleration by leveraging the compression capability of the Intel
In-Memory Analytics Accelerator (IAA).

The implementation of the IAA (de)compression code is based on Intel Query
Processing Library (QPL), an open-source software project designed for
high-performance query processing operations on Intel CPUs.
https://github.com/intel/qpl

I would like to summarize the progress so far
1. QPL will be used as an independent compression method like ZLIB and ZSTD,
   For the summary of issues compatible with ZLIB, please refer to
   docs/devel/migration/qpl-compression.rst

2. The QPL method supports both software path and hardware path (use IAA device)
   for multifd migration compression and decompression.
   The hardware path is always used first, if the hardware path is unavailable,
   it automatically falls back to the software path.

3. Compression accelerator related patches are removed from this patch set and
   will be added to the QAT patch set, we will submit separate patches to use
   QAT to accelerate ZLIB and ZSTD.

4. Advantages of using IAA accelerator include:
   a. Compared with the non-compression method, it can improve downtime
      performance without adding additional host resources (both CPU and
      network).
   b. Compared with using software compression methods (ZSTD/ZLIB), it can
      provide high data compression ratio and save a lot of CPU resources
      used for compression.

Test condition:
  1. Host CPUs are based on Sapphire Rapids
  2. VM type, 16 vCPU and 64G memory
  3. The source and destination respectively use 4 IAA devices.
  4. The workload in the VM
    a. all vCPUs are idle state
    b. 90% of the virtual machine's memory is used, use silesia to fill
       the memory.
       The introduction of silesia:
       https://sun.aei.polsl.pl//~sdeor/index.php?page=silesia
  5. Set "--mem-prealloc" boot parameter on the destination, this parameter
     can make IAA performance better and related introduction is added here.
     docs/devel/migration/qpl-compression.rst
  6. Source migration configuration commands
     a. migrate_set_capability multifd on
     b. migrate_set_parameter multifd-channels 2/4/8
     c. migrate_set_parameter downtime-limit 100
     f. migrate_set_parameter max-bandwidth 100G/1G
     d. migrate_set_parameter multifd-compression none/qpl/zstd
  7. Destination migration configuration commands
     a. migrate_set_capability multifd on
     b. migrate_set_parameter multifd-channels 2/4/8
     c. migrate_set_parameter multifd-compression none/qpl/zstd

Early migration result, each result is the average of three tests

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 | None   | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|    7493|      64|    66782|   2549993|  205%|
 |BW:100G +-------------+--------+--------+---------+----------+------+
 |        |            4|    5901|      49|    84832|   5289304|  283%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|    5789|      58|    86488|   4674351|  266%|
 +--------+-------------+--------+--------+---------+----------+------+

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 |QPL(IAA)| of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|    7330|      23|    34537|   5261385|  216%|
 |BW:100G +-------------+--------+--------+---------+----------+------+
 |        |            4|    5219|      31|    48899|   6498718|  405%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|    5250|      22|    49073|   5578875|  768%|
 +--------+-------------+--------+--------+---------+----------+------+

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 | QPL(SW)| of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|   73535|      21|     3887|    515976|  202%|
 |BW:100G +-------------+--------+--------+---------+----------+------+
 |        |            4|   37299|      27|     7668|   1637228|  403%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|   18964|      38|    15093|   3074972|  795%|
 +--------+-------------+--------+--------+---------+----------+------+

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 | ZSTD   | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|   78291|      24|     2201|    435601|  212%|
 |BW:100G +-------------+--------+--------+---------+----------+------+
 |        |            4|   39544|      21|     4366|   1036449|  457%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|   20180|      26|     8581|   1958901|  894%|
 +--------+-------------+--------+--------+---------+----------+------+

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 |QPL(IAA)| of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |without +-------------+-----------------+---------+----------+------+
 | --mem- |            2|   51431|      68|     4884|    227428|  202%|
 |prealloc+-------------+--------+--------+---------+----------+------+
 |        |            4|   29988|      92|     8392|    405648|  403%|
 |Network +-------------+--------+--------+---------+----------+------+
 |BW:100G |            8|   22868|      89|    11039|    222222|  795%|
 +--------+-------------+--------+--------+---------+----------+------+

When network bandwidth resource is sufficient, QPL can improve downtime
by 2x compared to no compression. In this scenario, with 4/8 channels,
IAA hardware resources are fully used, so adding more channels will not
gain more benefits.


 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 | None   | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|   57758|      66|     8643|    264617|   28%|
 |BW:  1G +-------------+--------+--------+---------+----------+------+
 |        |            4|   57216|      58|     8726|    266773|   28%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|   56708|      53|     8804|    270223|   28%|
 +--------+-------------+--------+--------+---------+----------+------+

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 |QPL(IAA)| of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|   30129|      34|     8345|   2224761|   26%|
 |BW:  1G +-------------+--------+--------+---------+----------+------+
 |        |            4|   30317|      39|     8300|   2025220|   58%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|   29615|      35|     8514|   2250122|  130%|
 +--------+-------------+--------+--------+---------+----------+------+

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 | QPL(SW)| of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|   93358|      41|     3064|    534588|  202%|
 |BW:  1G +-------------+--------+--------+---------+----------+------+
 |        |            4|   47266|      52|     6067|   1392941|  403%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|   33134|      45|     8706|   2433242|  480%|
 +--------+-------------+--------+--------+---------+----------+------+

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 | ZSTD   | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|   95750|      24|     1802|    477236|  263%|
 |BW:  1G +-------------+--------+--------+---------+----------+------+
 |        |            4|   48907|      24|     3536|   1002142|  411%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|   25568|      32|     6783|   1696437|  783%|
 +--------+-------------+--------+--------+---------+----------+------+

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 |QPL(IAA)| of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |without +-------------+-----------------+---------+----------+------+
 | --mem- |            2|   50908|      66|     4935|    240301|  200%|
 |prealloc+-------------+--------+--------+---------+----------+------+
 |        |            4|   31334|      94|     8030|    451310|  400%|
 |Network +-------------+--------+--------+---------+----------+------+
 |BW:100G |            8|   29010|     103|     8690|    629132|  620%|
 +--------+-------------+--------+--------+---------+----------+------+

When network bandwidth resource is limited, the "page perf second" metric
decreases for none compression, the success rate of migration will reduce.
Comparison of QPL and ZSTD compression methods, QPL can save a lot of CPU
resources used for compression.

without --mem-prealloc test is based on I/O page faults are handled by
QPL software. The performance bottleneck occurs on the receiving side
because hardware descriptors need to be submitted repeatedly, which
increases performance overhead, so it is still necessary to use
--mem-prealloc on the receiving side.

v2:
  - add support for multifd compression accelerator
  - add support for the QPL accelerator in the multifd
    compression accelerator
  - fixed the issue that QPL was compiled into the migration
    module by default

v3:
  - use Meson instead of pkg-config to resolve QPL build
    dependency issue
  - fix coding style
  - fix a CI issue for get_multifd_ops function in multifd.c file

v4:
  - patch based on commit: da96ad4a6a Merge tag 'hw-misc-20240215' of
    https://github.com/philmd/qemu into staging
  - remove the compression accelerator implementation patches, the patches
    will be placed in the QAT accelerator implementation.
  - introduce QPL as a new compression method
  - add QPL compression documentation
  - add QPL compression migration test
  - fix zlib/zstd compression level issue

v5:
  - patch based on v9.0.0-rc0 (c62d54d0a8)
  - use pkgconfig to check libaccel-config, libaccel-config is already
    in many distributions.
  - initialize the IOV of the sender by the specific compression method
  - refine the coding style
  - remove the zlib/zstd compression level not working patch, the issue
    has been solved

v6:
  - rebase to commit id 248f6f62df, Merge tag 'pull-axp-20240504' of
    https://gitlab.com/rth7680/qemu into staging.
  - add qpl software path, if the hardware path(IAA) is unavailable, the
    qpl will fall back to software path automatically.
  - add pkgconfig to check qpl, qpl version 1.5 already supports pkgconfig,
    users can install the qpl library and qpl.pc file through source code.
  - remove libaccel-config library detection, if there is no the library,
    the qpl will automatically switch to the software path.
  - use g_malloc0 instead of mmap to apply for memory.
  - add the more introduction of IAA device management, including usage
    permission, resource configuration, etc in qpl-compression.rst.
  - modified unit test to use software path to complete testing when
    hardware path is unavailable.

v7:
  - rebase to commit id 3ab42e46ac, Merge tag 'pull-ufs-20240603' of
    https://gitlab.com/jeuk20.kim/qemu into staging.
  - add the maximum number of retries for hardware job resubmission,
    if the hardware job resubmission fails, use the software job instead.
  - retest performance data based on the latest code base and add a test
    for I/O page fault handled by QPL.

Yuan Liu (7):
  docs/migration: add qpl compression feature
  migration/multifd: put IOV initialization into compression method
  configure: add --enable-qpl build option
  migration/multifd: add qpl compression method
  migration/multifd: implement initialization of qpl compression
  migration/multifd: implement qpl compression and decompression
  tests/migration-test: add qpl compression test

 docs/devel/migration/features.rst        |   1 +
 docs/devel/migration/qpl-compression.rst | 262 ++++++++
 hw/core/qdev-properties-system.c         |   2 +-
 meson.build                              |   8 +
 meson_options.txt                        |   2 +
 migration/meson.build                    |   1 +
 migration/multifd-qpl.c                  | 750 +++++++++++++++++++++++
 migration/multifd-zlib.c                 |   7 +
 migration/multifd-zstd.c                 |   8 +-
 migration/multifd.c                      |  22 +-
 migration/multifd.h                      |   1 +
 qapi/migration.json                      |   7 +-
 scripts/meson-buildoptions.sh            |   3 +
 tests/qtest/migration-test.c             |  24 +
 14 files changed, 1085 insertions(+), 13 deletions(-)
 create mode 100644 docs/devel/migration/qpl-compression.rst
 create mode 100644 migration/multifd-qpl.c

-- 
2.43.0


