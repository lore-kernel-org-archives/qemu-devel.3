Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D3FC71131
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN2c-0004Wp-Jt; Wed, 11 Jun 2025 11:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2Z-0004VX-5N
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2X-00077o-DR
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ghFrYcGKzo8WbE6moOqb9eH0dHqcHHVxhQWsNxMZpQ=;
 b=NHQFA3aDU/due2sHNTjlIuQVMPZ4s274Ehg0gMAmPEbA2wsX4kxzx/dyb6aXaHimMtlstx
 wj1GQETGmNLloc40agVYp44NX6iZ5gPBahQQ/IvPDMxD/Ub1MLMtP1UpDP8rMT4MJiZhOD
 v1XMZdwr25eP7jPEOW9t9LG7jkjY59k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-7DFRwzqAPHmAUHMkLvYo8A-1; Wed,
 11 Jun 2025 11:06:55 -0400
X-MC-Unique: 7DFRwzqAPHmAUHMkLvYo8A-1
X-Mimecast-MFC-AGG-ID: 7DFRwzqAPHmAUHMkLvYo8A_1749654413
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33D5619560AA; Wed, 11 Jun 2025 15:06:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF8F4180045C; Wed, 11 Jun 2025 15:06:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/27] migration: lower handler priority
Date: Wed, 11 Jun 2025 17:06:03 +0200
Message-ID: <20250611150620.701903-12-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Define a vmstate priority that is lower than the default, so its handlers
run after all default priority handlers.  Since 0 is no longer the default
priority, translate an uninitialized priority of 0 to MIG_PRI_DEFAULT.

CPR for vfio will use this to install handlers for containers that run
after handlers for the devices that they contain.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-3-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/vmstate.h | 6 +++++-
 migration/savevm.c          | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index a1dfab4460e9cffcce0df4562bd1cc420ff8cd85..1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -155,7 +155,11 @@ enum VMStateFlags {
 };
 
 typedef enum {
-    MIG_PRI_DEFAULT = 0,
+    MIG_PRI_UNINITIALIZED = 0,  /* An uninitialized priority field maps to */
+                                /* MIG_PRI_DEFAULT in save_state_priority */
+
+    MIG_PRI_LOW,                /* Must happen after default */
+    MIG_PRI_DEFAULT,
     MIG_PRI_IOMMU,              /* Must happen before PCI devices */
     MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
     MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
diff --git a/migration/savevm.c b/migration/savevm.c
index 52105dd2f10b4a3223d23667b34c0fd0bcb8ca21..bb04a4520df9a443d90cf6cb52a383a5f053aaff 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -266,7 +266,7 @@ typedef struct SaveState {
 
 static SaveState savevm_state = {
     .handlers = QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
-    .handler_pri_head = { [MIG_PRI_DEFAULT ... MIG_PRI_MAX] = NULL },
+    .handler_pri_head = { [0 ... MIG_PRI_MAX] = NULL },
     .global_section_id = 0,
 };
 
@@ -737,7 +737,7 @@ static int calculate_compat_instance_id(const char *idstr)
 
 static inline MigrationPriority save_state_priority(SaveStateEntry *se)
 {
-    if (se->vmsd) {
+    if (se->vmsd && se->vmsd->priority) {
         return se->vmsd->priority;
     }
     return MIG_PRI_DEFAULT;
-- 
2.49.0


