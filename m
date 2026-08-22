Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FA7C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 08:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxgjC-0000hh-Ex; Sat, 22 Aug 2026 04:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wxgjA-0000hU-RE; Sat, 22 Aug 2026 04:05:20 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wxgj8-0006Ms-Tl; Sat, 22 Aug 2026 04:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787385919; x=1818921919;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZQTpR5m2HYemScE6+fxCLUrN5DDI2sT+aIhkpWEB6dM=;
 b=hikNDsQoN1O3elUxRLohC8RXVVOXNV4dDj8zcukS/MWpj9gF3HSPKZHo
 0kIpeTcfvl3KbRpFiO42i1vStNlxmXAre15bTmmoYDDr3J9vzL7R6vPGl
 7v+c0hMq/3aV1kRv2MMih7xzeyx3B1kGVThagJkPoLkThv/MhhQZJ/bbY
 j3DIk5DzAncjTv+NYQB+7eSnW1vYIjMIXWpIdox50a0SccoVkbiT4wuSf
 I+AdjU76x5Kv3YegiSehuY6pseLhDB0J3rIp/BhtG22whNb/idIj9Pzfe
 g1PtlgVajGqRPu/617p4CpwTIa5h7eg1dOOIeVeyyryyK/HuO2Ucf7EG6 w==;
X-CSE-ConnectionGUID: Rt5fP7RZQ6uPPIHOhbzBCg==
X-CSE-MsgGUID: lH5WOFXXR7ueEMsjAAQ7SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91796015"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91796015"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2026 01:05:15 -0700
X-CSE-ConnectionGUID: 0ydaDvUJS3WXKU+NoTnpBw==
X-CSE-MsgGUID: Y8FloF0nTMKA/9UkbFQ9Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="265239305"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2026 01:05:13 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/cxl: Fix heap buffer overflow in Set Feature cleanup path
Date: Sat, 22 Aug 2026 16:05:08 +0800
Message-ID: <20260822080508.300921-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

cmd_features_set_feature() uses set_feat_info->data_size as the memset
length when zeroing write-attribute buffers on Finish/Abort.  data_size
accumulates bytes_to_copy across transfer parts but is only reset on
INITIATE.  Since QEMU never returns Feature Transfer Out of Order,
repeated transfers at the same offset grow data_size past sizeof(struct),
and the final memset overflows the target buffer.

b71a179148 bounded the per-transfer memcpy against sizeof, but the
cleanup memset still runs on the accumulated data_size, so the overflow
survives that fix.

Pass sizeof() of the target struct to memset instead of data_size.

Fixes: d88f66741410 ("hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature")
Fixes: 2d41ce38fb9a ("hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature")
Fixes: 5e5a86bab830 ("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
Fixes: da5cafdc4ddd ("hw/cxl: Add emulation for memory sparing control feature")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ec18338b42..f81b7b3303 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1947,22 +1947,28 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         data_transfer_flag ==  CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER) {
         memset(&set_feat_info->uuid, 0, sizeof(QemuUUID));
         if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
-            memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->patrol_scrub_wr_attrs, 0,
+                   sizeof(ct3d->patrol_scrub_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &ecs_uuid)) {
-            memset(&ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->ecs_wr_attrs, 0, sizeof(ct3d->ecs_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
-            memset(&ct3d->soft_ppr_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->soft_ppr_wr_attrs, 0,
+                   sizeof(ct3d->soft_ppr_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
-            memset(&ct3d->hard_ppr_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->hard_ppr_wr_attrs, 0,
+                   sizeof(ct3d->hard_ppr_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &cacheline_sparing_uuid)) {
             memset(&ct3d->cacheline_sparing_wr_attrs, 0,
-                   set_feat_info->data_size);
+                   sizeof(ct3d->cacheline_sparing_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &row_sparing_uuid)) {
-            memset(&ct3d->row_sparing_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->row_sparing_wr_attrs, 0,
+                   sizeof(ct3d->row_sparing_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &bank_sparing_uuid)) {
-            memset(&ct3d->bank_sparing_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->bank_sparing_wr_attrs, 0,
+                   sizeof(ct3d->bank_sparing_wr_attrs));
         } else if (qemu_uuid_is_equal(&hdr->uuid, &rank_sparing_uuid)) {
-            memset(&ct3d->rank_sparing_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->rank_sparing_wr_attrs, 0,
+                   sizeof(ct3d->rank_sparing_wr_attrs));
         }
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;

base-commit: af06b5df2610fe5de6c02d17c17bced9e9f0d47d
-- 
2.43.0


