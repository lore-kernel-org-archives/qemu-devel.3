Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697E3C021A0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrKv-0006UH-EZ; Tue, 11 Feb 2025 09:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKt-0006To-Qv
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKr-0001tk-Tx
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739284441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59hcE9AfFc9vC3VfPAyANCzHbu5uJ8g3zPTEk6idZ+k=;
 b=DlSarkRtB6jkKfWq6FyLhoIrQVuolqT0/PHVdZr/ZtE4eHE4VadZi6k0aHJa8rBznbEhQg
 g8cZBU+HOi4hDLGFeQaThTkgJJrnuZkqJGe5n0GkN1XKPuGjenupnAN0cuqscSlOaQ29h+
 wKQUjCXMOeHU3J0C3nSxmb12cdMwd4M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-QXjwdcJPO7CPC6cUQcQt4Q-1; Tue,
 11 Feb 2025 09:33:59 -0500
X-MC-Unique: QXjwdcJPO7CPC6cUQcQt4Q-1
X-Mimecast-MFC-AGG-ID: QXjwdcJPO7CPC6cUQcQt4Q
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 142C619560B1; Tue, 11 Feb 2025 14:33:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28DF61800115; Tue, 11 Feb 2025 14:33:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/12] vfio/iommufd: Fix SIGSEV in iommufd_cdev_attach()
Date: Tue, 11 Feb 2025 15:33:33 +0100
Message-ID: <20250211143340.787996-6-clg@redhat.com>
In-Reply-To: <20250211143340.787996-1-clg@redhat.com>
References: <20250211143340.787996-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

When iommufd_cdev_ram_block_discard_disable() fails for whatever reason,
errp should be set or else SIGSEV is triggered in vfio_realize() when
error_prepend() is called.

By this chance, use the same error message for both legacy and iommufd
backend.

Fixes: 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20250116102307.260849-1-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 3490a8f1eb8877c6f662d9676c82888d8713343a..df61edffc084360d9f332ae1d122518c0ecbb955 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -515,8 +515,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         } else {
             ret = iommufd_cdev_ram_block_discard_disable(true);
             if (ret) {
-                error_setg(errp,
-                              "Cannot set discarding of RAM broken (%d)", ret);
+                error_setg_errno(errp, -ret,
+                                 "Cannot set discarding of RAM broken");
                 goto err_discard_disable;
             }
             goto found_container;
@@ -544,6 +544,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     ret = iommufd_cdev_ram_block_discard_disable(true);
     if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
         goto err_discard_disable;
     }
 
-- 
2.48.1


