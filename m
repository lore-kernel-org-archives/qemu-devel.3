Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C32CD11DB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrNw-0004WZ-L8; Wed, 20 Mar 2024 04:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmrNp-0004VO-Qj
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:33:14 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmrNk-0005U3-HP
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710923589; x=1742459589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jHoiX8d2IXGLQEQeJbBznT8raIIAGzjHe1GxhmOwODU=;
 b=JnzXLBnz5YfIH6Glow9UGMO3nL/oigIRvuGt8XJ5hqIT9tPpyNRRVpKV
 AJei3zYeKqJaMmVXhRbGyEArCT308KU2kUlVD/IivRuMoVNU0MDdxBg/n
 yVy6TDHJjHT4dgI0wj7BJBvA6IT++khWrTqtC4et5D5yh7XkpB7rVCoIM
 cAwUm4Q4515zq8KW4bpqqZkRso2GWO5AwZ+HdwBXCt+8rClADfV7bGlHC
 VlvnuRmk2qczJ7xSitjs0xgNpVyKMUIHHADW9a9kkNP+pz9wcJABsNKIC
 41iAz4Ld+TJwmldmgtcZDyArykJXoLtfv2qRjeSlwll6IOlNZ3FPzdBqz w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5952907"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5952907"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 01:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="13986696"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa010.jf.intel.com with ESMTP; 20 Mar 2024 01:33:00 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v5 1/7] docs/migration: add qpl compression feature
Date: Wed, 20 Mar 2024 00:45:21 +0800
Message-Id: <20240319164527.1873891-2-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240319164527.1873891-1-yuan1.liu@intel.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
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

add Intel Query Processing Library (QPL) compression method
introduction

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 docs/devel/migration/features.rst        |   1 +
 docs/devel/migration/qpl-compression.rst | 231 +++++++++++++++++++++++
 2 files changed, 232 insertions(+)
 create mode 100644 docs/devel/migration/qpl-compression.rst

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index d5ca7b86d5..bc98b65075 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -12,3 +12,4 @@ Migration has plenty of features to support different use cases.
    virtio
    mapped-ram
    CPR
+   qpl-compression
diff --git a/docs/devel/migration/qpl-compression.rst b/docs/devel/migration/qpl-compression.rst
new file mode 100644
index 0000000000..42c7969d30
--- /dev/null
+++ b/docs/devel/migration/qpl-compression.rst
@@ -0,0 +1,231 @@
+===============
+QPL Compression
+===============
+The Intel Query Processing Library (Intel ``QPL``) is an open-source library to
+provide compression and decompression features and it is based on deflate
+compression algorithm (RFC 1951).
+
+The ``QPL`` compression relies on Intel In-Memory Analytics Accelerator(``IAA``)
+and Shared Virtual Memory(``SVM``) technology, they are new features supported
+from Intel 4th Gen Intel Xeon Scalable processors, codenamed Sapphire Rapids
+processor(``SPR``).
+
+For more ``QPL`` introduction, please refer to:
+
+https://intel.github.io/qpl/documentation/introduction_docs/introduction.html
+
+QPL Compression Framework
+=========================
+
+::
+
+  +----------------+       +------------------+
+  | MultiFD Service|       |accel-config tool |
+  +-------+--------+       +--------+---------+
+          |                         |
+          |                         |
+  +-------+--------+                | Setup IAA
+  |  QPL library   |                | Resources
+  +-------+---+----+                |
+          |   |                     |
+          |   +-------------+-------+
+          |   Open IAA      |
+          |   Devices +-----+-----+
+          |           |idxd driver|
+          |           +-----+-----+
+          |                 |
+          |                 |
+          |           +-----+-----+
+          +-----------+IAA Devices|
+      Submit jobs     +-----------+
+      via enqcmd
+
+
+Intel In-Memory Analytics Accelerator (Intel IAA) Introduction
+================================================================
+
+Intel ``IAA`` is an accelerator that has been designed to help benefit
+in-memory databases and analytic workloads. There are three main areas
+that Intel ``IAA`` can assist with analytics primitives (scan, filter, etc.),
+sparse data compression and memory tiering.
+
+``IAA`` Manual Documentation:
+
+https://www.intel.com/content/www/us/en/content-details/721858/intel-in-memory-analytics-accelerator-architecture-specification
+
+IAA Device Enabling
+-------------------
+
+- Enabling ``IAA`` devices for platform configuration, please refer to:
+
+https://www.intel.com/content/www/us/en/content-details/780887/intel-in-memory-analytics-accelerator-intel-iaa.html
+
+- ``IAA`` device driver is ``Intel Data Accelerator Driver (idxd)``, it is
+  recommended that the minimum version of Linux kernel is 5.18.
+
+- Add ``"intel_iommu=on,sm_on"`` parameter to kernel command line
+  for ``SVM`` feature enabling.
+
+Here is an easy way to verify ``IAA`` device driver and ``SVM``, refer to:
+
+https://github.com/intel/idxd-config/tree/stable/test
+
+IAA Device Management
+---------------------
+
+The number of ``IAA`` devices will vary depending on the Xeon product model.
+On a ``SPR`` server, there can be a maximum of 8 ``IAA`` devices, with up to
+4 devices per socket.
+
+By default, all ``IAA`` devices are disabled and need to be configured and
+enabled by users manually.
+
+Check the number of devices through the following command
+
+.. code-block:: shell
+
+  # lspci -d 8086:0cfe
+  # 6a:02.0 System peripheral: Intel Corporation Device 0cfe
+  # 6f:02.0 System peripheral: Intel Corporation Device 0cfe
+  # 74:02.0 System peripheral: Intel Corporation Device 0cfe
+  # 79:02.0 System peripheral: Intel Corporation Device 0cfe
+  # e7:02.0 System peripheral: Intel Corporation Device 0cfe
+  # ec:02.0 System peripheral: Intel Corporation Device 0cfe
+  # f1:02.0 System peripheral: Intel Corporation Device 0cfe
+  # f6:02.0 System peripheral: Intel Corporation Device 0cfe
+
+IAA Device Configuration
+------------------------
+
+The ``accel-config`` tool is used to enable ``IAA`` devices and configure
+``IAA`` hardware resources(work queues and engines). One ``IAA`` device
+has 8 work queues and 8 processing engines, multiple engines can be assigned
+to a work queue via ``group`` attribute.
+
+One example of configuring and enabling an ``IAA`` device.
+
+.. code-block:: shell
+
+  # accel-config config-engine iax1/engine1.0 -g 0
+  # accel-config config-engine iax1/engine1.1 -g 0
+  # accel-config config-engine iax1/engine1.2 -g 0
+  # accel-config config-engine iax1/engine1.3 -g 0
+  # accel-config config-engine iax1/engine1.4 -g 0
+  # accel-config config-engine iax1/engine1.5 -g 0
+  # accel-config config-engine iax1/engine1.6 -g 0
+  # accel-config config-engine iax1/engine1.7 -g 0
+  # accel-config config-wq iax1/wq1.0 -g 0 -s 128 -p 10 -b 1 -t 128 -m shared -y user -n app1 -d user
+  # accel-config enable-device iax1
+  # accel-config enable-wq iax1/wq1.0
+
+.. note::
+   IAX is an early name for IAA
+
+- The ``IAA`` device index is 1, use ``ls -lh /sys/bus/dsa/devices/iax*``
+  command to query the ``IAA`` device index.
+
+- 8 engines and 1 work queue are configured in group 0, so all compression jobs
+  submitted to this work queue can be processed by all engines at the same time.
+
+- Set work queue attributes including the work mode, work queue size and so on.
+
+- Enable the ``IAA1`` device and work queue 1.0
+
+.. note::
+  Set work queue mode to shared mode, since ``QPL`` library only supports
+  shared mode
+
+For more detailed configuration, please refer to:
+
+https://github.com/intel/idxd-config/tree/stable/Documentation/accfg
+
+IAA Resources Allocation For Migration
+--------------------------------------
+
+There is no ``IAA`` resource configuration parameters for migration and
+``accel-config`` tool configuration cannot directly specify the ``IAA``
+resources used for migration.
+
+``QPL`` will use all work queues that are enabled and set to shared mode,
+and use all engines assigned to the work queues with shared mode.
+
+By default, ``QPL`` will only use the local ``IAA`` device for compression
+job processing. The local ``IAA`` device means that the CPU of the job
+submission and the ``IAA`` device are on the same socket, so one CPU
+can submit the jobs to up to 4 ``IAA`` devices.
+
+Shared Virtual Memory(SVM) Introduction
+=======================================
+
+An ability for an accelerator I/O device to operate in the same virtual
+memory space of applications on host processors. It also implies the
+ability to operate from pageable memory, avoiding functional requirements
+to pin memory for DMA operations.
+
+When using ``SVM`` technology, users do not need to reserve memory for the
+``IAA`` device and perform pin memory operation. The ``IAA`` device can
+directly access data using the virtual address of the process.
+
+For more ``SVM`` technology, please refer to:
+
+https://docs.kernel.org/next/x86/sva.html
+
+
+How To Use QPL Compression In Migration
+=======================================
+
+1 - Installation of ``accel-config`` tool and ``QPL`` library
+
+  - Install ``accel-config`` tool from https://github.com/intel/idxd-config
+  - Install ``QPL`` library from https://github.com/intel/qpl
+
+2 - Configure and enable ``IAA`` devices and work queues via ``accel-config``
+
+3 - Build ``Qemu`` with ``--enable-qpl`` parameter
+
+  E.g. configure --target-list=x86_64-softmmu --enable-kvm ``--enable-qpl``
+
+4 - Start VMs with ``sudo`` command or ``root`` permission
+
+  Use the ``sudo`` command or ``root`` privilege to start the source and
+  destination virtual machines, since migration service needs permission
+  to access ``IAA`` hardware resources.
+
+5 - Enable ``QPL`` compression during migration
+
+  Set ``migrate_set_parameter multifd-compression qpl`` when migrating, the
+  ``QPL`` compression does not support configuring the compression level, it
+  only supports one compression level.
+
+The Difference Between QPL And ZLIB
+===================================
+
+Although both ``QPL`` and ``ZLIB`` are based on the deflate compression
+algorithm, and ``QPL`` can support the header and tail of ``ZLIB``, ``QPL``
+is still not fully compatible with the ``ZLIB`` compression in the migration.
+
+``QPL`` only supports 4K history buffer, and ``ZLIB`` is 32K by default. The
+``ZLIB`` compressed data that ``QPL`` may not decompress correctly and
+vice versa.
+
+``QPL`` does not support the ``Z_SYNC_FLUSH`` operation in ``ZLIB`` streaming
+compression, current ``ZLIB`` implementation uses ``Z_SYNC_FLUSH``, so each
+``multifd`` thread has a ``ZLIB`` streaming context, and all page compression
+and decompression are based on this stream. ``QPL`` cannot decompress such data
+and vice versa.
+
+The introduction for ``Z_SYNC_FLUSH``, please refer to:
+
+https://www.zlib.net/manual.html
+
+The Best Practices
+==================
+
+When the virtual machine's pages are not populated and the ``IAA`` device is
+used, I/O page faults occur, which can impact performance due to a large number
+of flush ``IOTLB`` operations.
+
+Since the normal pages on the source side are all populated, ``IOTLB`` caused
+by I/O page fault will not occur. On the destination side, a large number
+of normal pages need to be loaded, so it is recommended to add ``-mem-prealloc``
+parameter on the destination side.
-- 
2.39.3


