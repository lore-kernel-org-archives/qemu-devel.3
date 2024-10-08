Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305F4CED62A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syS1A-00049Z-67; Wed, 09 Oct 2024 04:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1syS16-000494-IL
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:25:57 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1syS14-00086P-D4
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728462355; x=1759998355;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=A14cUYlcyaqY/8FGNkCFYP0DXFjFrok5EGdd57CqzLo=;
 b=iYsYX/Ltj8fNu4aoMOOkyxUasI7eO6npqpf3mMCPgw59bRlUUUCAskay
 xuR8GzvLMglFSB3f8FRRYCbdsjna+RSfSceKYp7YQeAl8xNCeCVvMtJVl
 mMqnwxtrhvj9FDmLo7kknujotYjyhtu5ytWVUS8amWwmZ65CCiWHseCKg
 PbJutog0YebjrqxsxVJmLTPVsMAyqF/9eCEqbuhTp3SiLGs7NrpmCn7Ld
 6LHNOsp2LTr8i5rMlQ9MZzTdapr5v0+gkoaPenSAcSyahn/uS3zjifB4B
 HO1yuUoBB2AFiPPTSYk9iLveI9qW+ewCV9afuCL3i2428Sd45CFBGrtr7 w==;
X-CSE-ConnectionGUID: G/VtTayZSQGWlB6u5wqQWQ==
X-CSE-MsgGUID: aPgCpl9nSoCgXoaFNZ5S8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31446724"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="31446724"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2024 01:25:51 -0700
X-CSE-ConnectionGUID: 6U/Ojdf7TH2dVcam/D1tbQ==
X-CSE-MsgGUID: QDDJPzxxSLq+xQGC6UADxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="76489913"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa010.fm.intel.com with ESMTP; 09 Oct 2024 01:25:50 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com
Subject: [PATCH] migration/multifd: fix build error when qpl compression is
 enabled
Date: Tue,  8 Oct 2024 18:45:27 +0800
Message-ID: <20241008104527.3516755-1-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.151, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The page_size member has been removed from the MultiFDSendParams
and MultiFDRecvParams. The function multifd_ram_page_size is used to
provide the page size in the multifd compressor.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
---
 migration/multifd-qpl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index b0f1e2ba46..bbe466617f 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -389,7 +389,7 @@ static void multifd_qpl_compress_pages_slow_path(MultiFDSendParams *p)
 {
     QplData *qpl = p->compress_data;
     MultiFDPages_t *pages = &p->data->u.ram;
-    uint32_t size = p->page_size;
+    uint32_t size = multifd_ram_page_size();
     qpl_job *job = qpl->sw_job;
     uint8_t *zbuf = qpl->zbuf;
     uint8_t *buf;
@@ -420,7 +420,7 @@ static void multifd_qpl_compress_pages(MultiFDSendParams *p)
 {
     QplData *qpl = p->compress_data;
     MultiFDPages_t *pages = &p->data->u.ram;
-    uint32_t size = p->page_size;
+    uint32_t size = multifd_ram_page_size();
     QplHwJob *hw_job;
     uint8_t *buf;
     uint8_t *zbuf;
@@ -560,7 +560,7 @@ static int multifd_qpl_decompress_pages_slow_path(MultiFDRecvParams *p,
                                                   Error **errp)
 {
     QplData *qpl = p->compress_data;
-    uint32_t size = p->page_size;
+    uint32_t size = multifd_ram_page_size();
     qpl_job *job = qpl->sw_job;
     uint8_t *zbuf = qpl->zbuf;
     uint8_t *addr;
@@ -598,7 +598,7 @@ static int multifd_qpl_decompress_pages_slow_path(MultiFDRecvParams *p,
 static int multifd_qpl_decompress_pages(MultiFDRecvParams *p, Error **errp)
 {
     QplData *qpl = p->compress_data;
-    uint32_t size = p->page_size;
+    uint32_t size = multifd_ram_page_size();
     uint8_t *zbuf = qpl->zbuf;
     uint8_t *addr;
     uint32_t len;
@@ -677,7 +677,7 @@ static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
     }
     for (int i = 0; i < p->normal_num; i++) {
         qpl->zlen[i] = be32_to_cpu(qpl->zlen[i]);
-        assert(qpl->zlen[i] <= p->page_size);
+        assert(qpl->zlen[i] <= multifd_ram_page_size());
         zbuf_len += qpl->zlen[i];
     }
 
-- 
2.43.0


