Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A20C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrNw-0004Wo-Rw; Wed, 20 Mar 2024 04:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmrNr-0004VZ-J9
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:33:15 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmrNk-0005Th-Co
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710923589; x=1742459589;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GBZcCOsGD7ZmQp9PU1A9rqWNILUdlUdgFQIOAZ2ddnM=;
 b=luj3B6e2dVnwK1m1GRWgBs7g3nEj6n+tB6StX8lJtnlterLqpP/jFUfG
 mB4Qy1Dy4raGycHm2ouznEKs93Ne3bnH7RGotfUZP1l3+KForzdJV9mOR
 3/94pWuxMxuMQXDH5RPLbtjGa1bCEEOEMSgjSL4nuinIEDNX7OIm4ZElC
 c2IV/enasfA0OZRs0307zvFrqMbTKVfR8ct8WRcfBjQMlI7G8Ai4SNzit
 IIT5nVDi0g2FzefQT5UL07/C5vA/VbQKsSOXR4/CtwxfKQHF6+du3zVbh
 tJhEIGSHZHE7IJ7/QbZhXuBxUI/UZteDU0KdsfLMR53TSmBRsnExliT7v A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5952899"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5952899"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 01:33:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="13986682"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa010.jf.intel.com with ESMTP; 20 Mar 2024 01:32:57 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v5 0/7] Live Migration With IAA
Date: Wed, 20 Mar 2024 00:45:20 +0800
Message-Id: <20240319164527.1873891-1-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.422, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
IAA high-level software programming. https://github.com/intel/qpl

I would like to summarize the progress so far
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

v5:
  - patch based on v9.0.0-rc0 (c62d54d0a8)
  - use pkgconfig to check libaccel-config, libaccel-config is already
    in many distributions.
  - initialize the IOV of the sender by the specific compression method
  - refine the coding style
  - remove the zlib/zstd compression level not working patch, the issue
    has been solved

Yuan Liu (7):
  docs/migration: add qpl compression feature
  migration/multifd: put IOV initialization into compression method
  configure: add --enable-qpl build option
  migration/multifd: add qpl compression method
  migration/multifd: implement initialization of qpl compression
  migration/multifd: implement qpl compression and decompression
  tests/migration-test: add qpl compression test

 docs/devel/migration/features.rst        |   1 +
 docs/devel/migration/qpl-compression.rst | 231 +++++++++++
 hw/core/qdev-properties-system.c         |   2 +-
 meson.build                              |  16 +
 meson_options.txt                        |   2 +
 migration/meson.build                    |   1 +
 migration/multifd-qpl.c                  | 482 +++++++++++++++++++++++
 migration/multifd-zlib.c                 |   4 +
 migration/multifd-zstd.c                 |   6 +-
 migration/multifd.c                      |   8 +-
 migration/multifd.h                      |   1 +
 qapi/migration.json                      |   7 +-
 scripts/meson-buildoptions.sh            |   3 +
 tests/qtest/migration-test.c             |  24 ++
 14 files changed, 782 insertions(+), 6 deletions(-)
 create mode 100644 docs/devel/migration/qpl-compression.rst
 create mode 100644 migration/multifd-qpl.c

-- 
2.39.3


