Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79712C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 05:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhNem-0004PV-Ic; Tue, 05 Mar 2024 00:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNei-0004Nj-1w
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:01 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNee-0003aU-Iq
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709617676; x=1741153676;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=H2mvl17dSiAUIDoFYQN8d7YiTbsTtHB7N8zpSdNZzsA=;
 b=WF5jUENaABYEQgoe1IWQEzQdNKHtQMO2zW//71BcPq3Ai6cu/Jfj02G2
 WkmfiM7nqK55o/PIARH/d57O93vqtvMBve/1yPT+BUQLA4h/R6e+9b/Zt
 dXiaMcUfi+7oJ0BBPn0XzUXJNqyupL5u9qs3d5tYzfAY2HiAa+9cqMWlu
 0Cv9gVPF4lM9Gi8ogHqfMaRGnKMhw9Vcxl81wFuGB7E7XnHpKcJWkXCtu
 hoItpLZWD6BA5eCjx7mwXHiM/Szcua6R6bzx+wzITXWRvMHBployfPkMy
 aoK02a9siZKZbc2/Ibb2fttf95gtsAuCFncZddLtI1I9pIpo5ZsJpMuwS w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4006172"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4006172"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 21:47:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; d="scan'208";a="40135847"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa002.jf.intel.com with ESMTP; 04 Mar 2024 21:47:50 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v4 0/8] Live Migration With IAA
Date: Mon,  4 Mar 2024 22:00:20 +0800
Message-Id: <20240304140028.1590649-1-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.571, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

I am writing to submit a code change aimed at enhancing live migration
acceleration by leveraging the compression capability of the Intel
In-Memory Analytics Accelerator (IAA).

The implementation of the IAA (de)compression code is based on Intel Query
Processing Library (QPL), an open-source software project designed for
IAA high-level software programming. https://github.com/intel/qpl

Sorry that the submission of v4 version took so long due to the Chinese New
Year holiday. I would like to summarize the progress so far

1. QPL will be used as an independent compression method like ZLIB and ZSTD,
   QPL will force the use of the IAA accelerator and will not support software
   compression. For a summary of issues compatible with Zlib, please refer to
   docs/devel/migration/qpl-compression.rst

2. Compression accelerator related patches are removed from this patch set and
   will be added to the QAT patch set, we will submit separate patches to use
   QAT to accelerate ZLIB and ZSTD.

3. Advantages of using IAA accelerator include:
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
     c. migrate_set_parameter downtime-limit 300
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
 |Network |            2|    8571|      69|    58391|   1896525|  256%|
 |BW:100G +-------------+--------+--------+---------+----------+------+
 |        |            4|    7180|      92|    69736|   1865640|  300%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|    7090|     121|    70562|   2174060|  307%|
 +--------+-------------+--------+--------+---------+----------+------+

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 | QPL    | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|    8413|      34|    30067|   1732411|  230%|
 |BW:100G +-------------+--------+--------+---------+----------+------+
 |        |            4|    6559|      32|    38804|   1689954|  450%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|    6623|      37|    38745|   1566507|  790%|
 +--------+-------------+--------+--------+---------+----------+------+

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 | ZSTD   | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|   95846|      24|     1800|    521829|  203%|
 |BW:100G +-------------+--------+--------+---------+----------+------+
 |        |            4|   49004|      24|     3529|    890532|  403%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|   25574|      32|     6782|   1762222|  800%|
 +--------+-------------+--------+--------+---------+----------+------+

When network bandwidth resource is sufficient, QPL can improve downtime
by 2x compared to no compression. In this scenario, with 4 channels, the
IAA hardware resources are fully used, so adding more channels will not
gain more benefits.

 
 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 | None   | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|   57758|      66|     8643|    264617|   34%|
 |BW:  1G +-------------+--------+--------+---------+----------+------+
 |        |            4|   57216|      58|     8726|    266773|   34%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|   56708|      53|     8804|    270223|   33%|
 +--------+-------------+--------+--------+---------+----------+------+

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 | QPL    | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|   30129|      34|     8345|   2224761|   54%|
 |BW:  1G +-------------+--------+--------+---------+----------+------+
 |        |            4|   30317|      39|     8300|   2025220|   73%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|   29615|      35|     8514|   2250122|  131%|
 +--------+-------------+--------+--------+---------+----------+------+

 +--------+-------------+--------+--------+---------+----------+------|
 |        | The number  |total   |downtime|network  |pages per | CPU  |
 | ZSTD   | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
 | Comp   |             |        |        |(mbps)   |          |      |
 |        +-------------+-----------------+---------+----------+------+
 |Network |            2|   95750|      24|     1802|    477236|  202%|
 |BW:  1G +-------------+--------+--------+---------+----------+------+
 |        |            4|   48907|      24|     3536|   1002142|  404%|
 |        +-------------+--------+--------+---------+----------+------+
 |        |            8|   25568|      32|     6783|   1696437|  800%|
 +--------+-------------+--------+--------+---------+----------+------+

When network bandwidth resource is limited, the "page perf second" metric
decreases for none compression, the success rate of migration will reduce.
Comparison of QPL and ZSTD compression methods, QPL can save a lot of CPU
resources used for compression.

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

Yuan Liu (8):
  docs/migration: add qpl compression feature
  migration/multifd: add get_iov_count in the multifd method
  configure: add --enable-qpl build option
  migration/multifd: add qpl compression method
  migration/multifd: implement initialization of qpl compression
  migration/multifd: implement qpl compression and decompression
  migration/multifd: fix zlib and zstd compression levels not working
  tests/migration-test: add qpl compression test

 docs/devel/migration/features.rst        |   1 +
 docs/devel/migration/qpl-compression.rst | 231 +++++++++++
 hw/core/qdev-properties-system.c         |   2 +-
 meson.build                              |  18 +
 meson_options.txt                        |   2 +
 migration/meson.build                    |   1 +
 migration/multifd-qpl.c                  | 485 +++++++++++++++++++++++
 migration/multifd-zlib.c                 |  18 +-
 migration/multifd-zstd.c                 |  18 +-
 migration/multifd.c                      |  24 +-
 migration/multifd.h                      |   3 +
 migration/options.c                      |  12 +
 qapi/migration.json                      |   7 +-
 scripts/meson-buildoptions.sh            |   3 +
 tests/qtest/migration-test.c             |  40 ++
 15 files changed, 858 insertions(+), 7 deletions(-)
 create mode 100644 docs/devel/migration/qpl-compression.rst
 create mode 100644 migration/multifd-qpl.c

-- 
2.39.3


