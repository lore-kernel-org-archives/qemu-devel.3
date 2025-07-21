Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280EFC87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udkWP-0002mW-9d; Mon, 21 Jul 2025 03:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1udkWA-0002fh-Qc
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:01:01 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1udkW4-0005n3-WA
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753081253; x=1784617253;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=k/TAaWSXHX/7A6kEJcH3ylHERJw5T2U3vNI/+sglqZA=;
 b=d7Ie8eSvHKAQ/G0CuJBdZEUTOVcoVPmA6U7MBHnM8dfIshBsqXtETKa7
 62eQiMeDFDuKJWR+YuTKrn4f4UYuDUHSMu90cwrzrISimCRivKN/DP3H9
 RDcc0W23BDKYaXBos7kXjfqLqK16ASsCZEBqufQFU7G5DkSARvZkpe6lP
 F+kjnhUzAFpL4I8IEcYvIJjDfiEv3zAJ+XazxcuLkxHdrcdqDQCPVlfx6
 kzlscrPEgzw6ufQn59eZB51TL7Q/2ue104Gey8VR4xPBwI6dyhyvaFF3e
 MVsDgUgDDqDekL4RgKQLhDqBRt/ssu+Gqp1GKPv0FNTouJ26N9aSO+cZr w==;
X-CSE-ConnectionGUID: 6pa67n3fTZ6EH/arv/aZhw==
X-CSE-MsgGUID: xJunZyu9QaOjkR3p7YFkiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="59099907"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; d="scan'208";a="59099907"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 00:00:48 -0700
X-CSE-ConnectionGUID: 8a5hHC3SSAu4jFbWBdZkww==
X-CSE-MsgGUID: cWPg/EDpRnyXw88jogLF3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; d="scan'208";a="158067516"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 21 Jul 2025 00:00:46 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] hostmem/shm: Allow shm memory backend serve as shared memory
 for coco-VMs
Date: Mon, 21 Jul 2025 14:52:20 +0800
Message-ID: <20250721065220.895606-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

shm can surely serve as the shared memory for coco-VMs. But currently it
doesn't check the backend->guest_memfd to pass down the RAM_GUEST_MEMFD
flag. It leads to failure when creating coco-VMs (e.g., TDX guest) which
require private mmeory.

Set and pass down RAM_GUEST_MEMFD when backend->guest_memfd is true, to
allow shm memory backend serve as shared memory for coco-VMs.

cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 backends/hostmem-shm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index f66211a2ec92..806e2670e039 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -54,6 +54,7 @@ have_fd:
     /* Let's do the same as memory-backend-ram,share=on would do. */
     ram_flags = RAM_SHARED;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
 
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
                                               backend_name, backend->size,
-- 
2.43.0


