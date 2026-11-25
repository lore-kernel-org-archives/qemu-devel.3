Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA40606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gEwANtDb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW8d8-0003KI-1n; Wed, 25 Nov 2026 03:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xW8d2-0003Ht-I3
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:45:24 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xW8d0-0003vR-Os
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795596323; x=1827132323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0WTJb6mHTeFJKJDWmO4DaB3HjlljE3h7vk61Zh7GU3E=;
 b=gEwANtDbTwCiAVeHRGbsWIjZAjmLj/ucnNiOiMj6QL16v0CdMzSDUTqZ
 TUKjoNbT6iVkFMG5mkGHsblTU6s6ck4Apiq5EwrpUEtkO+Uad0mrL0U3f
 Kcbo2dtVp40Nl3rGZ0OY/2k3o/zOVNrVi/Quk0f2HDGVlkR4XQdnqTNcA
 S2xdt/6fHlhKU/IrbUUMmzNg+GcEuobgDkKWXOaU0tCYxq/mI+G2+YSQo
 pvxkZOR9XyJzQPxqvNXEjAaBdXNRh4jh/8Gl3Qa7N2E0bKLvERzEOUB/p
 rBkIqaMTTWOo5aH15W740X4F8Yqq+ugbwr7z7KAmEgDaqVQUZnnNbsoMg g==;
X-CSE-ConnectionGUID: 60CZ1dnYS+etIbUFf5IQCA==
X-CSE-MsgGUID: m+xQ1CTJQcCfTbZMiG5UOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4481115"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4481115"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 00:41:33 -0800
X-CSE-ConnectionGUID: zIiJC/c8TiyYiqHICMdwMw==
X-CSE-MsgGUID: VEq9ZSB3Rzql//ZaO0T1YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="12091469"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 00:41:31 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 3/3] hostmem-epc: fix fd leak on allocation failure
Date: Wed, 25 Nov 2026 16:41:08 +0800
Message-ID: <20261125084108.1849966-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261125084108.1849966-1-zhenzhong.duan@intel.com>
References: <20261125084108.1849966-1-zhenzhong.duan@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If memory_region_init_ram_from_fd() fails inside sgx_epc_backend_memory_alloc(),
the RAM block doesn't take ownership of the fd. Since qemu_ram_free() is never
called to clean up, the file descriptor simply leaks.

Fix this by closing the fd on the failure path.

Fixes: c6c023200045 ("hostmem: Add hostmem-epc as a backend for SGX EPC")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 backends/hostmem-epc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
index ab20b18233..bb92b1c0f6 100644
--- a/backends/hostmem-epc.c
+++ b/backends/hostmem-epc.c
@@ -37,8 +37,14 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     backend->aligned = true;
     name = object_get_canonical_path(OBJECT(backend));
     ram_flags = (backend->share ? RAM_SHARED : RAM_PRIVATE) | RAM_PROTECTED;
-    return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
-                                          backend->size, ram_flags, fd, 0, errp);
+    if (!memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
+                                        backend->size, ram_flags, fd, 0,
+                                        errp)) {
+        /* No RAM block took ownership of the fd, so close it here */
+        close(fd);
+        return false;
+    }
+    return true;
 }
 
 static void sgx_epc_backend_instance_init(Object *obj)
-- 
2.52.0


