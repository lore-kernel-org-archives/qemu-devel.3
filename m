Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BA2E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 09:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNq8U-0006ZJ-PJ; Wed, 18 Dec 2024 04:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1tNq8S-0006YI-GO
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:14:28 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1tNq8P-0001nF-Ku
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734513265; x=1766049265;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fxPgzF2ktFu+HE+iDNfw/JIEC9OxbBQtqbPt3YWfSZ8=;
 b=kFkbvzw1CAVFf+G++0B69F7N8JQPWVzRuE4l6RWNMgAVkHtMucy9tenT
 hMZj/uSF51WsUY2HkFYhgfpOAtfDkxJkDO6HYIRN6hmAkS2eh1EnwV2A2
 n1Shsd90F3cUAT6w8TxIRVhtXGHk2b366ka3uN63x4RR3fDMui/nX2W32
 6/X757uL4YNMExCuoZ4PoxBVY00Lo8VgECXgZejF8urXgvg4QkDiMuWPy
 pxC8wAQ5gjxcBacWJgA6drFpZjK3kV6c0FVAK+JHc3c1WhrRWysxu/rGx
 KGb3jyXzYv8j4zpDvXel2+EVoqXzS0K1rY6XMdX5QbiDrykM9S5YlcSqP g==;
X-CSE-ConnectionGUID: Xs1I6t0hRrGZ4WSwL/99rg==
X-CSE-MsgGUID: VoqA4tKOQ464mawozxqOdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="38760658"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="38760658"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 01:14:23 -0800
X-CSE-ConnectionGUID: PP+i61UUSAqO+fZoqliEsg==
X-CSE-MsgGUID: ereCnxXLQTaprSBc7H3U3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="102896455"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa003.jf.intel.com with ESMTP; 18 Dec 2024 01:14:22 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, jason.zeng@intel.com,
 yichen.wang@bytedance.com
Subject: [PATCH 3/3] multifd: bugfix for incorrect migration data with qatzip
 compression
Date: Wed, 18 Dec 2024 17:14:13 +0800
Message-ID: <20241218091413.140396-4-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218091413.140396-1-yuan1.liu@intel.com>
References: <20241218091413.140396-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

When QPL compression is enabled on the migration channel and the same
dirty page changes from a normal page to a zero page in the iterative
memory copy, the dirty page will not be updated to a zero page again
on the target side, resulting in incorrect memory data on the source
and target sides.

The root cause is that the target side does not record the normal pages
to the receivedmap.

The solution is to add ramblock_recv_bitmap_set_offset in target side
to record the normal pages.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Jason Zeng <jason.zeng@intel.com>
---
 migration/multifd-qatzip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
index 7b68397625..6a0e989fae 100644
--- a/migration/multifd-qatzip.c
+++ b/migration/multifd-qatzip.c
@@ -373,6 +373,7 @@ static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
     /* Copy each page to its appropriate location. */
     for (int i = 0; i < p->normal_num; i++) {
         memcpy(p->host + p->normal[i], q->out_buf + page_size * i, page_size);
+        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
     }
     return 0;
 }
-- 
2.43.0


