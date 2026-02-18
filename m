Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508D3E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 01:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsWjk-0007Aj-Dl; Tue, 17 Feb 2026 20:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=502105d20=graf@amazon.de>)
 id 1vsWjY-00077l-TN; Tue, 17 Feb 2026 20:52:10 -0500
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.13.214.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=502105d20=graf@amazon.de>)
 id 1vsWjW-0004Yi-Da; Tue, 17 Feb 2026 20:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1771379526; x=1802915526;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yGwpH6mNXADUzH7l283Vcqo8pTgMS9qPjwIVA1ZPJ58=;
 b=HGNKdO3IhkUHGD8WlAcm16esybqRAf13/jjrGHFY7JxI6PJYQ772bxRO
 Vuph6zyvj2FPBrdF5C+6Tzfus44kS2c/7Rjy8EA0EFHaMpHEJv/QeO5WP
 5yXQe9yvfWMDlNLTChO/YW9/GsyatdDH87OmMP2NOoV+cBfkVgWs51c3I
 A5Ft5YpMghAah7qI7fuGi1VoP/2/XaiCt+AqeCOM/GF+7QpeO5cOxO6LF
 RkwaMLAKVuAUcA6TmDiwNKq7mCdXNBkP6k4eYtCJdGRyr3ZFJKP7t7XM4
 2OGjmNrXOkzUrK51lVqFAhD+whs/4rQewAazfAaU5i9xSRG/hQh1GCOza g==;
X-CSE-ConnectionGUID: RNK+XsRQT1iCEso/DI0gHA==
X-CSE-MsgGUID: NS7BQMwZS5GwenlipWFxpQ==
X-IronPort-AV: E=Sophos;i="6.21,297,1763424000"; d="scan'208";a="13261378"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 01:52:01 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:1796]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.39:2525]
 with esmtp (Farcaster)
 id 5097c958-82f7-4ad6-b0fd-8686e47214c8; Wed, 18 Feb 2026 01:52:01 +0000 (UTC)
X-Farcaster-Flow-ID: 5097c958-82f7-4ad6-b0fd-8686e47214c8
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 01:52:00 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 01:51:58 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Thomas
 Huth" <thuth@redhat.com>, <alex.bennee@linaro.org>, <philmd@linaro.org>,
 <berrange@redhat.com>, <marcandre.lureau@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, <mst@redhat.com>, Dorjoy Chowdhury
 <dorjoychy111@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyler Fanelli <tfanelli@redhat.com>,
 <mknaust@amazon.com>, <nh-open-source@amazon.com>
Subject: [PATCH 02/10] linux-headers: Add nitro_enclaves.h
Date: Wed, 18 Feb 2026 01:51:42 +0000
Message-ID: <20260218015151.4052-3-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260218015151.4052-1-graf@amazon.com>
References: <20260218015151.4052-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=52.13.214.179;
 envelope-from=prvs=502105d20=graf@amazon.de;
 helo=pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

QEMU is learning to drive the /dev/nitro_enclaves device node. Include
its UAPI header into our local copy of kernel headers so it has all
defines we need to drive it.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 .../standard-headers/linux/nitro_enclaves.h   | 359 ++++++++++++++++++
 1 file changed, 359 insertions(+)
 create mode 100644 include/standard-headers/linux/nitro_enclaves.h

diff --git a/include/standard-headers/linux/nitro_enclaves.h b/include/standard-headers/linux/nitro_enclaves.h
new file mode 100644
index 0000000000..5545267dd9
--- /dev/null
+++ b/include/standard-headers/linux/nitro_enclaves.h
@@ -0,0 +1,359 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright 2020-2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#ifndef _LINUX_NITRO_ENCLAVES_H_
+#define _LINUX_NITRO_ENCLAVES_H_
+
+#include "standard-headers/linux/types.h"
+
+/**
+ * DOC: Nitro Enclaves (NE) Kernel Driver Interface
+ */
+
+/**
+ * NE_CREATE_VM - The command is used to create a slot that is associated with
+ *		  an enclave VM.
+ *		  The generated unique slot id is an output parameter.
+ *		  The ioctl can be invoked on the /dev/nitro_enclaves fd, before
+ *		  setting any resources, such as memory and vCPUs, for an
+ *		  enclave. Memory and vCPUs are set for the slot mapped to an enclave.
+ *		  A NE CPU pool has to be set before calling this function. The
+ *		  pool can be set after the NE driver load, using
+ *		  /sys/module/nitro_enclaves/parameters/ne_cpus.
+ *		  Its format is the detailed in the cpu-lists section:
+ *		  https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
+ *		  CPU 0 and its siblings have to remain available for the
+ *		  primary / parent VM, so they cannot be set for enclaves. Full
+ *		  CPU core(s), from the same NUMA node, need(s) to be included
+ *		  in the CPU pool.
+ *
+ * Context: Process context.
+ * Return:
+ * * Enclave file descriptor		- Enclave file descriptor used with
+ *					  ioctl calls to set vCPUs and memory
+ *					  regions, then start the enclave.
+ * *  -1				- There was a failure in the ioctl logic.
+ * On failure, errno is set to:
+ * * EFAULT				- copy_to_user() failure.
+ * * ENOMEM				- Memory allocation failure for internal
+ *					  bookkeeping variables.
+ * * NE_ERR_NO_CPUS_AVAIL_IN_POOL	- No NE CPU pool set / no CPUs available
+ *					  in the pool.
+ * * Error codes from get_unused_fd_flags() and anon_inode_getfile().
+ * * Error codes from the NE PCI device request.
+ */
+#define NE_CREATE_VM			_IOR(0xAE, 0x20, uint64_t)
+
+/**
+ * NE_ADD_VCPU - The command is used to set a vCPU for an enclave. The vCPU can
+ *		 be auto-chosen from the NE CPU pool or it can be set by the
+ *		 caller, with the note that it needs to be available in the NE
+ *		 CPU pool. Full CPU core(s), from the same NUMA node, need(s) to
+ *		 be associated with an enclave.
+ *		 The vCPU id is an input / output parameter. If its value is 0,
+ *		 then a CPU is chosen from the enclave CPU pool and returned via
+ *		 this parameter.
+ *		 The ioctl can be invoked on the enclave fd, before an enclave
+ *		 is started.
+ *
+ * Context: Process context.
+ * Return:
+ * * 0					- Logic successfully completed.
+ * *  -1				- There was a failure in the ioctl logic.
+ * On failure, errno is set to:
+ * * EFAULT				- copy_from_user() / copy_to_user() failure.
+ * * ENOMEM				- Memory allocation failure for internal
+ *					  bookkeeping variables.
+ * * EIO				- Current task mm is not the same as the one
+ *					  that created the enclave.
+ * * NE_ERR_NO_CPUS_AVAIL_IN_POOL	- No CPUs available in the NE CPU pool.
+ * * NE_ERR_VCPU_ALREADY_USED		- The provided vCPU is already used.
+ * * NE_ERR_VCPU_NOT_IN_CPU_POOL	- The provided vCPU is not available in the
+ *					  NE CPU pool.
+ * * NE_ERR_VCPU_INVALID_CPU_CORE	- The core id of the provided vCPU is invalid
+ *					  or out of range.
+ * * NE_ERR_NOT_IN_INIT_STATE		- The enclave is not in init state
+ *					  (init = before being started).
+ * * NE_ERR_INVALID_VCPU		- The provided vCPU is not in the available
+ *					  CPUs range.
+ * * Error codes from the NE PCI device request.
+ */
+#define NE_ADD_VCPU			_IOWR(0xAE, 0x21, uint32_t)
+
+/**
+ * NE_GET_IMAGE_LOAD_INFO - The command is used to get information needed for
+ *			    in-memory enclave image loading e.g. offset in
+ *			    enclave memory to start placing the enclave image.
+ *			    The image load info is an input / output parameter.
+ *			    It includes info provided by the caller - flags -
+ *			    and returns the offset in enclave memory where to
+ *			    start placing the enclave image.
+ *			    The ioctl can be invoked on the enclave fd, before
+ *			    an enclave is started.
+ *
+ * Context: Process context.
+ * Return:
+ * * 0				- Logic successfully completed.
+ * *  -1			- There was a failure in the ioctl logic.
+ * On failure, errno is set to:
+ * * EFAULT			- copy_from_user() / copy_to_user() failure.
+ * * NE_ERR_NOT_IN_INIT_STATE	- The enclave is not in init state (init =
+ *				  before being started).
+ * * NE_ERR_INVALID_FLAG_VALUE	- The value of the provided flag is invalid.
+ */
+#define NE_GET_IMAGE_LOAD_INFO		_IOWR(0xAE, 0x22, struct ne_image_load_info)
+
+/**
+ * NE_SET_USER_MEMORY_REGION - The command is used to set a memory region for an
+ *			       enclave, given the allocated memory from the
+ *			       userspace. Enclave memory needs to be from the
+ *			       same NUMA node as the enclave CPUs.
+ *			       The user memory region is an input parameter. It
+ *			       includes info provided by the caller - flags,
+ *			       memory size and userspace address.
+ *			       The ioctl can be invoked on the enclave fd,
+ *			       before an enclave is started.
+ *
+ * Context: Process context.
+ * Return:
+ * * 0					- Logic successfully completed.
+ * *  -1				- There was a failure in the ioctl logic.
+ * On failure, errno is set to:
+ * * EFAULT				- copy_from_user() failure.
+ * * EINVAL				- Invalid physical memory region(s) e.g.
+ *					  unaligned address.
+ * * EIO				- Current task mm is not the same as
+ *					  the one that created the enclave.
+ * * ENOMEM				- Memory allocation failure for internal
+ *					  bookkeeping variables.
+ * * NE_ERR_NOT_IN_INIT_STATE		- The enclave is not in init state
+ *					  (init = before being started).
+ * * NE_ERR_INVALID_MEM_REGION_SIZE	- The memory size of the region is not
+ *					  multiple of 2 MiB.
+ * * NE_ERR_INVALID_MEM_REGION_ADDR	- Invalid user space address given.
+ * * NE_ERR_UNALIGNED_MEM_REGION_ADDR	- Unaligned user space address given.
+ * * NE_ERR_MEM_REGION_ALREADY_USED	- The memory region is already used.
+ * * NE_ERR_MEM_NOT_HUGE_PAGE		- The memory region is not backed by
+ *					  huge pages.
+ * * NE_ERR_MEM_DIFFERENT_NUMA_NODE	- The memory region is not from the same
+ *					  NUMA node as the CPUs.
+ * * NE_ERR_MEM_MAX_REGIONS		- The number of memory regions set for
+ *					  the enclave reached maximum.
+ * * NE_ERR_INVALID_PAGE_SIZE		- The memory region is not backed by
+ *					  pages multiple of 2 MiB.
+ * * NE_ERR_INVALID_FLAG_VALUE		- The value of the provided flag is invalid.
+ * * Error codes from get_user_pages().
+ * * Error codes from the NE PCI device request.
+ */
+#define NE_SET_USER_MEMORY_REGION	_IOW(0xAE, 0x23, struct ne_user_memory_region)
+
+/**
+ * NE_START_ENCLAVE - The command is used to trigger enclave start after the
+ *		      enclave resources, such as memory and CPU, have been set.
+ *		      The enclave start info is an input / output parameter. It
+ *		      includes info provided by the caller - enclave cid and
+ *		      flags - and returns the cid (if input cid is 0).
+ *		      The ioctl can be invoked on the enclave fd, after an
+ *		      enclave slot is created and resources, such as memory and
+ *		      vCPUs are set for an enclave.
+ *
+ * Context: Process context.
+ * Return:
+ * * 0					- Logic successfully completed.
+ * *  -1				- There was a failure in the ioctl logic.
+ * On failure, errno is set to:
+ * * EFAULT				- copy_from_user() / copy_to_user() failure.
+ * * NE_ERR_NOT_IN_INIT_STATE		- The enclave is not in init state
+ *					  (init = before being started).
+ * * NE_ERR_NO_MEM_REGIONS_ADDED	- No memory regions are set.
+ * * NE_ERR_NO_VCPUS_ADDED		- No vCPUs are set.
+ * *  NE_ERR_FULL_CORES_NOT_USED	- Full core(s) not set for the enclave.
+ * * NE_ERR_ENCLAVE_MEM_MIN_SIZE	- Enclave memory is less than minimum
+ *					  memory size (64 MiB).
+ * * NE_ERR_INVALID_FLAG_VALUE		- The value of the provided flag is invalid.
+ * *  NE_ERR_INVALID_ENCLAVE_CID	- The provided enclave CID is invalid.
+ * * Error codes from the NE PCI device request.
+ */
+#define NE_START_ENCLAVE		_IOWR(0xAE, 0x24, struct ne_enclave_start_info)
+
+/**
+ * DOC: NE specific error codes
+ */
+
+/**
+ * NE_ERR_VCPU_ALREADY_USED - The provided vCPU is already used.
+ */
+#define NE_ERR_VCPU_ALREADY_USED		(256)
+/**
+ * NE_ERR_VCPU_NOT_IN_CPU_POOL - The provided vCPU is not available in the
+ *				 NE CPU pool.
+ */
+#define NE_ERR_VCPU_NOT_IN_CPU_POOL		(257)
+/**
+ * NE_ERR_VCPU_INVALID_CPU_CORE - The core id of the provided vCPU is invalid
+ *				  or out of range of the NE CPU pool.
+ */
+#define NE_ERR_VCPU_INVALID_CPU_CORE		(258)
+/**
+ * NE_ERR_INVALID_MEM_REGION_SIZE - The user space memory region size is not
+ *				    multiple of 2 MiB.
+ */
+#define NE_ERR_INVALID_MEM_REGION_SIZE		(259)
+/**
+ * NE_ERR_INVALID_MEM_REGION_ADDR - The user space memory region address range
+ *				    is invalid.
+ */
+#define NE_ERR_INVALID_MEM_REGION_ADDR		(260)
+/**
+ * NE_ERR_UNALIGNED_MEM_REGION_ADDR - The user space memory region address is
+ *				      not aligned.
+ */
+#define NE_ERR_UNALIGNED_MEM_REGION_ADDR	(261)
+/**
+ * NE_ERR_MEM_REGION_ALREADY_USED - The user space memory region is already used.
+ */
+#define NE_ERR_MEM_REGION_ALREADY_USED		(262)
+/**
+ * NE_ERR_MEM_NOT_HUGE_PAGE - The user space memory region is not backed by
+ *			      contiguous physical huge page(s).
+ */
+#define NE_ERR_MEM_NOT_HUGE_PAGE		(263)
+/**
+ * NE_ERR_MEM_DIFFERENT_NUMA_NODE - The user space memory region is backed by
+ *				    pages from different NUMA nodes than the CPUs.
+ */
+#define NE_ERR_MEM_DIFFERENT_NUMA_NODE		(264)
+/**
+ * NE_ERR_MEM_MAX_REGIONS - The supported max memory regions per enclaves has
+ *			    been reached.
+ */
+#define NE_ERR_MEM_MAX_REGIONS			(265)
+/**
+ * NE_ERR_NO_MEM_REGIONS_ADDED - The command to start an enclave is triggered
+ *				 and no memory regions are added.
+ */
+#define NE_ERR_NO_MEM_REGIONS_ADDED		(266)
+/**
+ * NE_ERR_NO_VCPUS_ADDED - The command to start an enclave is triggered and no
+ *			   vCPUs are added.
+ */
+#define NE_ERR_NO_VCPUS_ADDED			(267)
+/**
+ * NE_ERR_ENCLAVE_MEM_MIN_SIZE - The enclave memory size is lower than the
+ *				 minimum supported.
+ */
+#define NE_ERR_ENCLAVE_MEM_MIN_SIZE		(268)
+/**
+ * NE_ERR_FULL_CORES_NOT_USED - The command to start an enclave is triggered and
+ *				full CPU cores are not set.
+ */
+#define NE_ERR_FULL_CORES_NOT_USED		(269)
+/**
+ * NE_ERR_NOT_IN_INIT_STATE - The enclave is not in init state when setting
+ *			      resources or triggering start.
+ */
+#define NE_ERR_NOT_IN_INIT_STATE		(270)
+/**
+ * NE_ERR_INVALID_VCPU - The provided vCPU is out of range of the available CPUs.
+ */
+#define NE_ERR_INVALID_VCPU			(271)
+/**
+ * NE_ERR_NO_CPUS_AVAIL_IN_POOL - The command to create an enclave is triggered
+ *				  and no CPUs are available in the pool.
+ */
+#define NE_ERR_NO_CPUS_AVAIL_IN_POOL		(272)
+/**
+ * NE_ERR_INVALID_PAGE_SIZE - The user space memory region is not backed by pages
+ *			      multiple of 2 MiB.
+ */
+#define NE_ERR_INVALID_PAGE_SIZE		(273)
+/**
+ * NE_ERR_INVALID_FLAG_VALUE - The provided flag value is invalid.
+ */
+#define NE_ERR_INVALID_FLAG_VALUE		(274)
+/**
+ * NE_ERR_INVALID_ENCLAVE_CID - The provided enclave CID is invalid, either
+ *				being a well-known value or the CID of the
+ *				parent / primary VM.
+ */
+#define NE_ERR_INVALID_ENCLAVE_CID		(275)
+
+/**
+ * DOC: Image load info flags
+ */
+
+/**
+ * NE_EIF_IMAGE - Enclave Image Format (EIF)
+ */
+#define NE_EIF_IMAGE			(0x01)
+
+#define NE_IMAGE_LOAD_MAX_FLAG_VAL	(0x02)
+
+/**
+ * struct ne_image_load_info - Info necessary for in-memory enclave image
+ *			       loading (in / out).
+ * @flags:		Flags to determine the enclave image type
+ *			(e.g. Enclave Image Format - EIF) (in).
+ * @memory_offset:	Offset in enclave memory where to start placing the
+ *			enclave image (out).
+ */
+struct ne_image_load_info {
+	uint64_t	flags;
+	uint64_t	memory_offset;
+};
+
+/**
+ * DOC: User memory region flags
+ */
+
+/**
+ * NE_DEFAULT_MEMORY_REGION - Memory region for enclave general usage.
+ */
+#define NE_DEFAULT_MEMORY_REGION	(0x00)
+
+#define NE_MEMORY_REGION_MAX_FLAG_VAL	(0x01)
+
+/**
+ * struct ne_user_memory_region - Memory region to be set for an enclave (in).
+ * @flags:		Flags to determine the usage for the memory region (in).
+ * @memory_size:	The size, in bytes, of the memory region to be set for
+ *			an enclave (in).
+ * @userspace_addr:	The start address of the userspace allocated memory of
+ *			the memory region to set for an enclave (in).
+ */
+struct ne_user_memory_region {
+	uint64_t	flags;
+	uint64_t	memory_size;
+	uint64_t	userspace_addr;
+};
+
+/**
+ * DOC: Enclave start info flags
+ */
+
+/**
+ * NE_ENCLAVE_PRODUCTION_MODE - Start enclave in production mode.
+ */
+#define NE_ENCLAVE_PRODUCTION_MODE	(0x00)
+/**
+ * NE_ENCLAVE_DEBUG_MODE - Start enclave in debug mode.
+ */
+#define NE_ENCLAVE_DEBUG_MODE		(0x01)
+
+#define NE_ENCLAVE_START_MAX_FLAG_VAL	(0x02)
+
+/**
+ * struct ne_enclave_start_info - Setup info necessary for enclave start (in / out).
+ * @flags:		Flags for the enclave to start with (e.g. debug mode) (in).
+ * @enclave_cid:	Context ID (CID) for the enclave vsock device. If 0 as
+ *			input, the CID is autogenerated by the hypervisor and
+ *			returned back as output by the driver (in / out).
+ */
+struct ne_enclave_start_info {
+	uint64_t	flags;
+	uint64_t	enclave_cid;
+};
+
+#endif /* _LINUX_NITRO_ENCLAVES_H_ */
-- 
2.47.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


