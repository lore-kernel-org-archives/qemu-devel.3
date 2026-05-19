Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4B7CD4F5E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNrj-0008DR-BJ; Tue, 19 May 2026 13:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrI-00086H-0I
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrG-0004IN-H4
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AH5az7khb5tHxCCsE9fq8iMXZ1Gsct4n9e5LQg79iI=;
 b=S5Yp7ontSAQoUPwQsT++TJA/wKYcDDUbeWB0scJnYKz0nj8PcgxFDgUBRUlrW6IdpMTmGn
 yXFUO3rxoJDloEPE0i1OFkDFT+aOJiEXyr93KJQCtwgExSaYxcECbJgx9hx0bGjpBjzYO6
 XXfUEo/xtkwK/G9u2wSTFxxUJPDjGH0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-1RtbaCCKOEacnnL8jE3iDg-1; Tue,
 19 May 2026 13:03:50 -0400
X-MC-Unique: 1RtbaCCKOEacnnL8jE3iDg-1
X-Mimecast-MFC-AGG-ID: 1RtbaCCKOEacnnL8jE3iDg_1779210229
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8F7D18002CB; Tue, 19 May 2026 17:03:49 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55BD01681; Tue, 19 May 2026 17:03:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 11/18] block: Create DEFAULT_BLOCK_CONF macro
Date: Tue, 19 May 2026 19:03:10 +0200
Message-ID: <20260519170317.345032-12-kwolf@redhat.com>
In-Reply-To: <20260519170317.345032-1-kwolf@redhat.com>
References: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The property default values from include/hw/block/block.h were
duplicated in scsi_bus_legacy_handle_cmdline(), allowing them to go out
of sync easily. There doesn't seem a good way to avoid the duplication,
but moving them next to each other in the header file should help to
avoid this problem in the future.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260410152314.86412-2-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/block/block.h | 7 +++++++
 hw/scsi/scsi-bus.c       | 7 +------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 7dc19d8a453..e0a427039ee 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -51,6 +51,13 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
     return exp;
 }
 
+#define DEFAULT_BLOCK_CONF (BlockConf) {                                \
+    .bootindex = -1,                                                    \
+    .share_rw = false,                                                  \
+    .rerror = BLOCKDEV_ON_ERROR_AUTO,                                   \
+    .werror = BLOCKDEV_ON_ERROR_AUTO,                                   \
+}
+
 #define DEFINE_BLOCK_PROPERTIES_BASE(_state, _conf)                     \
     DEFINE_PROP_ON_OFF_AUTO("backend_defaults", _state,                 \
                             _conf.backend_defaults, ON_OFF_AUTO_AUTO),  \
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1a6b181b9d6..dccb2f25b2a 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -485,12 +485,7 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
     Location loc;
     DriveInfo *dinfo;
     int unit;
-    BlockConf conf = {
-        .bootindex = -1,
-        .share_rw = false,
-        .rerror = BLOCKDEV_ON_ERROR_AUTO,
-        .werror = BLOCKDEV_ON_ERROR_AUTO,
-    };
+    BlockConf conf = DEFAULT_BLOCK_CONF;
 
     loc_push_none(&loc);
     for (unit = 0; unit <= bus->info->max_target; unit++) {
-- 
2.54.0


