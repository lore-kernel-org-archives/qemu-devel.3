Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E20606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OClbU0Zm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW8d6-0003JH-3S; Wed, 25 Nov 2026 03:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xW8cz-0003Gp-Kr
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:45:21 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xW8cx-0003vR-EI
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795596319; x=1827132319;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=efQlwBLWPc0/UAD+yTdxkWU+G2FmgZpzmCch4Zq98/M=;
 b=OClbU0ZmlwCkWk1SpfNCxxKhV15j/GfhThQm4Qay029uVSmfB5Di8DKo
 vi8EovxlKeLIfl904yibgLG8QtAfdfGJmQJYJcquu1gPOLZ2L5UrBHaej
 bC8W132VigSZ9mGvZF7cDePQppofcmzoa6o7gzHmaVFct5MwEXgGVqnVJ
 dmexfXMOAabHkZNKSx/FYwJkxKVRuFGPLxYvsocHte3LtSxJXhBuJ7yiB
 msvvv2cvzBMYdvL2CRhUNbtZL+4pTgeZYydTE+EWOKNKcqjL1jQklcgpM
 uTlJNVMg0gvhF3ZBXBJkQCNKPS9URE3JYlB9XEGqTBA63T+2rZbvNxdA1 A==;
X-CSE-ConnectionGUID: DYdxh/rERBqRlf+Juz5XbA==
X-CSE-MsgGUID: 0AMWVkBPSBaZWeK7r3Enbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4481101"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4481101"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 00:41:28 -0800
X-CSE-ConnectionGUID: Dbwy4ml8SdGW13UEqNm+fQ==
X-CSE-MsgGUID: GCJkOsLqSOeTj4tqDuZz4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="12091453"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 00:41:26 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 1/3] hostmem-memfd: close fd and untrack CPR on failure
Date: Wed, 25 Nov 2026 16:41:06 +0800
Message-ID: <20261125084108.1849966-2-zhenzhong.duan@intel.com>
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

If memory_region_init_ram_from_fd() fails when setting up hostmem-memfd,
the RAM block doesn't take ownership of the fd. Since we don't hit
qemu_ram_free() here, the fd just leaks.

Also, because the stale file descriptor stays registered in the CPR
registry, any future attempt to recreate this memory backend will end up
trying to reuse that dead fd number rather than opening a new one.

Fix this by deleting the fd from CPR and closing it directly on the
failure path.

Fixes: dbb9e0f40d7d ("Add memfd based hostmem")
Fixes: 28eaa5957d3e ("hostmem-memfd: preserve for cpr")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 backends/hostmem-memfd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 46489212a2..678ca7f826 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -95,8 +95,18 @@ have_fd:
     ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
-    return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
-                                          backend->size, ram_flags, fd, 0, errp);
+    if (!memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
+                                        backend->size, ram_flags, fd, 0,
+                                        errp)) {
+        /*
+         * No RAM block took ownership of the fd, so qemu_ram_free() won't
+         * clean up after it: drop the CPR entry and close the fd here.
+         */
+        cpr_delete_fd(name, 0);
+        close(fd);
+        return false;
+    }
+    return true;
 }
 
 static int
-- 
2.52.0


