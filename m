Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684C3C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwQv-0008Am-FO; Tue, 11 Jun 2024 04:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sGwQt-00089G-8b
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:00:43 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sGwQp-0006jb-Sf
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718092840; x=1749628840;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yZclYataE8oUk3+OrIlf/wHgyHNC2yjRy371bVDuXoc=;
 b=TmnwfV3/kgIKOzBuR9vboMG+Dh2dgYyupubtZFq9d0n+6b9/MriyYgqx
 EGvX+LH+0uKhPqCG5c3FcANTDiEwlBAnq2BY2l19gAsiacuAxDXD1qX5K
 rTrB0atBjOpmWYUHLPXrZKOeTSGSvhestHMqqKE8/vC9/AVvncZDGiUd8
 yWr8ZmcjDSPuFlLapqyJEerAsnNW+KQ8vqTx/fwxPtS+5jlhzWGX81FDd
 UJVfwhz00tHkyLNmp4pLqYhI9WSYNJoGqZwv54X0gSgRtuQLbQaANsIsi
 hrRTvZGmeQrAra87pqQXFJL7HLSaGO8GpaKXKL+aCpzWHGmW1BUIfkG1W Q==;
X-CSE-ConnectionGUID: 9mnQJZvTTQmcNBTfxcyqDg==
X-CSE-MsgGUID: PmAQjLNDRFmiwUm8ITR+kA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14510006"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="14510006"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2024 01:00:37 -0700
X-CSE-ConnectionGUID: n7I6srg6SaaI9CPOgDLfcg==
X-CSE-MsgGUID: 4xgPB4ARQ2WsrOJPl8Smew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="39184810"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa007.fm.intel.com with ESMTP; 11 Jun 2024 01:00:33 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v8 1/7] docs/migration: add qpl compression feature
Date: Mon, 10 Jun 2024 18:21:04 +0800
Message-ID: <20240610102110.900410-2-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610102110.900410-1-yuan1.liu@intel.com>
References: <20240610102110.900410-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.143, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
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

add Intel Query Processing Library (QPL) compression method
introduction

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/features.rst        |   1 +
 docs/devel/migration/qpl-compression.rst | 260 +++++++++++++++++++++++
 2 files changed, 261 insertions(+)
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
index 0000000000..990992d786
--- /dev/null
+++ b/docs/devel/migration/qpl-compression.rst
@@ -0,0 +1,260 @@
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
+For more ``QPL`` introduction, please refer to `QPL Introduction
+<https://intel.github.io/qpl/documentation/introduction_docs/introduction.html>`_
+
+QPL Compression Framework
+=========================
+
+::
+
+  +----------------+       +------------------+
+  | MultiFD Thread |       |accel-config tool |
+  +-------+--------+       +--------+---------+
+          |                         |
+          |                         |
+          |compress/decompress      |
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
+QPL Build And Installation
+--------------------------
+
+.. code-block:: shell
+
+  $git clone --recursive https://github.com/intel/qpl.git qpl
+  $mkdir qpl/build
+  $cd qpl/build
+  $cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DQPL_LIBRARY_TYPE=SHARED ..
+  $sudo cmake --build . --target install
+
+For more details about ``QPL`` installation, please refer to `QPL Installation
+<https://intel.github.io/qpl/documentation/get_started_docs/installation.html>`_
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
+  #lspci -d 8086:0cfe
+  6a:02.0 System peripheral: Intel Corporation Device 0cfe
+  6f:02.0 System peripheral: Intel Corporation Device 0cfe
+  74:02.0 System peripheral: Intel Corporation Device 0cfe
+  79:02.0 System peripheral: Intel Corporation Device 0cfe
+  e7:02.0 System peripheral: Intel Corporation Device 0cfe
+  ec:02.0 System peripheral: Intel Corporation Device 0cfe
+  f1:02.0 System peripheral: Intel Corporation Device 0cfe
+  f6:02.0 System peripheral: Intel Corporation Device 0cfe
+
+IAA Device Configuration And Enabling
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``accel-config`` tool is used to enable ``IAA`` devices and configure
+``IAA`` hardware resources(work queues and engines). One ``IAA`` device
+has 8 work queues and 8 processing engines, multiple engines can be assigned
+to a work queue via ``group`` attribute.
+
+For ``accel-config`` installation, please refer to `accel-config installation
+<https://github.com/intel/idxd-config>`_
+
+One example of configuring and enabling an ``IAA`` device.
+
+.. code-block:: shell
+
+  #accel-config config-engine iax1/engine1.0 -g 0
+  #accel-config config-engine iax1/engine1.1 -g 0
+  #accel-config config-engine iax1/engine1.2 -g 0
+  #accel-config config-engine iax1/engine1.3 -g 0
+  #accel-config config-engine iax1/engine1.4 -g 0
+  #accel-config config-engine iax1/engine1.5 -g 0
+  #accel-config config-engine iax1/engine1.6 -g 0
+  #accel-config config-engine iax1/engine1.7 -g 0
+  #accel-config config-wq iax1/wq1.0 -g 0 -s 128 -p 10 -b 1 -t 128 -m shared -y user -n app1 -d user
+  #accel-config enable-device iax1
+  #accel-config enable-wq iax1/wq1.0
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
+
+  Set work queue mode to shared mode, since ``QPL`` library only supports
+  shared mode
+
+For more detailed configuration, please refer to `IAA Configuration Samples
+<https://github.com/intel/idxd-config/tree/stable/Documentation/accfg>`_
+
+IAA Unit Test
+^^^^^^^^^^^^^
+
+- Enabling ``IAA`` devices for Xeon platform, please refer to `IAA User Guide
+  <https://www.intel.com/content/www/us/en/content-details/780887/intel-in-memory-analytics-accelerator-intel-iaa.html>`_
+
+- ``IAA`` device driver is Intel Data Accelerator Driver (idxd), it is
+  recommended that the minimum version of Linux kernel is 5.18.
+
+- Add ``"intel_iommu=on,sm_on"`` parameter to kernel command line
+  for ``SVM`` feature enabling.
+
+Here is an easy way to verify ``IAA`` device driver and ``SVM`` with `iaa_test
+<https://github.com/intel/idxd-config/tree/stable/test>`_
+
+.. code-block:: shell
+
+  #./test/iaa_test
+   [ info] alloc wq 0 shared size 128 addr 0x7f26cebe5000 batch sz 0xfffffffe xfer sz 0x80000000
+   [ info] test noop: tflags 0x1 num_desc 1
+   [ info] preparing descriptor for noop
+   [ info] Submitted all noop jobs
+   [ info] verifying task result for 0x16f7e20
+   [ info] test with op 0 passed
+
+
+IAA Resources Allocation For Migration
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+There is no ``IAA`` resource configuration parameters for migration and
+``accel-config`` tool configuration cannot directly specify the ``IAA``
+resources used for migration.
+
+The multifd migration with ``QPL`` compression method  will use all work
+queues that are enabled and shared mode.
+
+.. note::
+
+  Accessing IAA resources requires ``sudo`` command or ``root`` privileges
+  by default. Administrators can modify the IAA device node ownership
+  so that QEMU can use IAA with specified user permissions.
+
+  For example
+
+  #chown -R qemu /dev/iax
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
+For more ``SVM`` technology, please refer to
+`Shared Virtual Addressing (SVA) with ENQCMD
+<https://docs.kernel.org/next/x86/sva.html>`_
+
+
+How To Use QPL Compression In Migration
+=======================================
+
+1 - Installation of ``QPL`` library and ``accel-config`` library if using IAA
+
+2 - Configure and enable ``IAA`` devices and work queues via ``accel-config``
+
+3 - Build ``QEMU`` with ``--enable-qpl`` parameter
+
+  E.g. configure --target-list=x86_64-softmmu --enable-kvm ``--enable-qpl``
+
+4 - Enable ``QPL`` compression during migration
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
+``QPL`` only supports 4K history buffer, and ``ZLIB`` is 32K by default.
+``ZLIB`` compresses data that ``QPL`` may not decompress correctly and
+vice versa.
+
+``QPL`` does not support the ``Z_SYNC_FLUSH`` operation in ``ZLIB`` streaming
+compression, current ``ZLIB`` implementation uses ``Z_SYNC_FLUSH``, so each
+``multifd`` thread has a ``ZLIB`` streaming context, and all page compression
+and decompression are based on this stream. ``QPL`` cannot decompress such data
+and vice versa.
+
+The introduction for ``Z_SYNC_FLUSH``, please refer to `Zlib Manual
+<https://www.zlib.net/manual.html>`_
+
+The Best Practices
+==================
+When user enables the IAA device for ``QPL`` compression, it is recommended
+to add ``-mem-prealloc`` parameter to the destination boot parameters. This
+parameter can avoid the occurrence of I/O page fault and reduce the overhead
+of IAA compression and decompression.
+
+The example of booting with ``-mem-prealloc`` parameter
+
+.. code-block:: shell
+
+   $qemu-system-x86_64 --enable-kvm -cpu host --mem-prealloc ...
+
+
+An example about I/O page fault measurement of destination without
+``-mem-prealloc``, the ``svm_prq`` indicates the number of I/O page fault
+occurrences and processing time.
+
+.. code-block:: shell
+
+  #echo 1 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+  #echo 2 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+  #echo 3 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+  #echo 4 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+  #cat /sys/kernel/debug/iommu/intel/dmar_perf_latency
+  IOMMU: dmar18 Register Base Address: c87fc000
+                  <0.1us   0.1us-1us    1us-10us  10us-100us   100us-1ms    1ms-10ms      >=10ms     min(us)     max(us) average(us)
+   inv_iotlb           0         286         123           0           0           0           0           0           1           0
+  inv_devtlb           0         276         133           0           0           0           0           0           2           0
+     inv_iec           0           0           0           0           0           0           0           0           0           0
+     svm_prq           0           0       25206         364         395           0           0           1         556           9
-- 
2.43.0


