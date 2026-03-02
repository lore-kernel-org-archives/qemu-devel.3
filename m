Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE853D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytz-0003vz-EK; Mon, 02 Mar 2026 03:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytu-0003WN-MP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytr-0001qc-Mb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1Rz9QbTUIby8OgnZLoQXmrNpFdDj3N+DUt7P7RG3Co=;
 b=M8d/co4L5f5KZlwi0pde9hf52WkQSD8zpFE2pWA6Pvo+ZCvrcJNEFbyxXRP0V1orecL/MB
 roap49jo1rXobCxxnI5hezxqa4/0uIJPNY7vBR/3LhmZmF6qwwhbXQzhfcF5mwz3P7QBoQ
 NubIBc+u5aSPA4mD5Aa9zfLQNKzNIj0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-b1CTK8HVN-6JzqZOhZ403Q-1; Mon, 02 Mar 2026 03:45:09 -0500
X-MC-Unique: b1CTK8HVN-6JzqZOhZ403Q-1
X-Mimecast-MFC-AGG-ID: b1CTK8HVN-6JzqZOhZ403Q_1772441108
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4832c4621c2so46271535e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441107; x=1773045907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1Rz9QbTUIby8OgnZLoQXmrNpFdDj3N+DUt7P7RG3Co=;
 b=XSleArtTa+hb6L4IU9VeZyYdTuNvBJESFQc81vlBKyVJJFACft8M1qEJGAyhA/Lwn6
 r8XVS4qJC+DddylYAHafXn4nKD6GCBL3glmLQ9G7RnYRsS65MBkyJt0vH2/0F6omk0iD
 MgYfLdchobdhkclfjklCq9HM12UFMx18iu8u56vYpGsqh8AGJhaRxB7/YlhQsNlSfHXY
 0xtgJyfwqkHPKmL6Bz231Z0TZ+/pxVi2OLWiYOmlCXEGZwcW4rppKt6z85fEV45Vu6uR
 EeJYr/xpBBU9dfW6qdcI1HG8uL41rgDg7GvWvg5fXEEJ1GMZNQpxQ/TO6f+Dx/runRz8
 TY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441107; x=1773045907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F1Rz9QbTUIby8OgnZLoQXmrNpFdDj3N+DUt7P7RG3Co=;
 b=i/kC7zOZiobeFOxblJqmgDuQt/lhdsZO8KS2xQRjk1QbA/ht++4Le0pQfItKx+rOu8
 jhkbSrENFHPuPGM9F4V8DwftYo1wYbAzp+ob6ryi5/8bV0Z2mGZdfYreN76hJPbLzxuj
 Bitx1s1wKrzLb2l1DnUY3wT+S1xdsuav4Xc8ttUzKrTjQusxQD/9wG+ZwfgmNphkB0bw
 K5+lK4dI9oxZ0QUVZTUPH4Qnrt4PQLvbZruk2oNx0uRO3Tgi/OYt3tMmhPUIu3BTCT1c
 V79RPTZUIcLCvdfhRqWhOP2mq3lMwOrPEa2xVaG1owWuLrjaVc2A4VfTkZ7LThVPgHfK
 Di4w==
X-Gm-Message-State: AOJu0YwMyBxMsCXKW6rhomxHM8/wgDKz2VZelMyHfflHOAzHq5kYdfRX
 LxtFI8jn3c4IhHpk+0ACkDzNS6GoaT2rD7CsmBVzbGqsKN96Yp/gm8K7+ni2spPXMT9t7YTHfhR
 XNtNBKdOdUO82SE9EQJre9JObGJh0io3Vrd2TbLe3akAcERJUWImY4k2JipZOnfciI6iIP3ICAG
 3ewzaFkiHKHTlz7gi0biQwqMc0XB81z9sKmDdZZs3o
X-Gm-Gg: ATEYQzxNl1A3hHTb2u7cTVqspial0ff2FXXjFH+3ttXq1RIlzBtXLr+0BETP2LsIbiH
 Jf1C2jmmtj+9V8tw/ZGihTDKkeAQllGRW7p7hIPXM+CMYdY0HQdu8blnaNz97FLVubMZuOZo/oU
 AnXj83Rb3UynHZSy0eglGGV5yaMIaEIJbJ1EEcXrusyHL143Uj5FY85Qe8/D3PgUfqykopPTQ05
 wVSHR8165Hj3pqLeiw2iP5dcABVekEXAQIc8lbHgERV6rg+PIXAXGudsSKFAWgU8uGFvtlfNByb
 R0ZdN/oeBk9S/PHvuv3qtE21FtN/L2NKxEWo1ORq4wQcps02HAB74/O0YIRI/5p8eH0PfUErmoH
 koL3B1pq/4ggqVnoBASzKD5E35lMfb5KtP7c4/dPAWjcb2EvS/fZv+Q3aDimP9T/80IQQLKoVDi
 NF+Qi6qt6BhIyEJZYvdKlAI/WWk+g=
X-Received: by 2002:a05:600c:a086:b0:483:b3d7:2e80 with SMTP id
 5b1f17b1804b1-483c9c1fc82mr192941495e9.33.1772441106890; 
 Mon, 02 Mar 2026 00:45:06 -0800 (PST)
X-Received: by 2002:a05:600c:a086:b0:483:b3d7:2e80 with SMTP id
 5b1f17b1804b1-483c9c1fc82mr192940835e9.33.1772441106122; 
 Mon, 02 Mar 2026 00:45:06 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f26d7sm409063305e9.3.2026.03.02.00.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>
Subject: [PULL 032/102] linux-headers: Add nitro_enclaves.h
Date: Mon,  2 Mar 2026 09:42:27 +0100
Message-ID: <20260302084338.473368-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

QEMU is learning to drive the /dev/nitro_enclaves device node. Include
its UAPI header into our local copy of kernel headers so it has all
defines we need to drive it.

Signed-off-by: Alexander Graf <graf@amazon.com>
Link: https://lore.kernel.org/r/20260225220807.33092-3-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../standard-headers/linux/nitro_enclaves.h   | 359 ++++++++++++++++++
 1 file changed, 359 insertions(+)
 create mode 100644 include/standard-headers/linux/nitro_enclaves.h

diff --git a/include/standard-headers/linux/nitro_enclaves.h b/include/standard-headers/linux/nitro_enclaves.h
new file mode 100644
index 00000000000..5545267dd95
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
2.53.0


