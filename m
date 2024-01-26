Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06916C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 04:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTDfT-0001t3-OE; Thu, 25 Jan 2024 23:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTDfR-0001ss-3i
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 23:18:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTDfN-0004zq-Ei
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 23:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706242688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ssSaIW3ahIip0O+ym1jhKD6aHZUz0kqQ0bfZMUBR5ng=;
 b=Tx6z7F1zqIvtsU4YuTR/Cn7JR7LtMJ8MOKSzXQ1wRJ+TclRFnAfpAha+BpydcsUv4sg1T/
 G6PmEqhKKCTyT0u+hZ0CA4tFknoO2Fk2WrN0ZnkJobUIbEA7J04XIJxFvdL2QNAvoaT5B5
 V/ZrLswIgbfk1EOgi4NyXwhpx/6q9ks=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-I6VGExejMGOnVvyuvAHYkA-1; Thu, 25 Jan 2024 23:18:04 -0500
X-MC-Unique: I6VGExejMGOnVvyuvAHYkA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73D6E85A58E;
 Fri, 26 Jan 2024 04:18:03 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64F05492BC6;
 Fri, 26 Jan 2024 04:18:01 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 11/15] migration: Take reference to migration state around
 bg_migration_vm_start_bh
Date: Fri, 26 Jan 2024 12:17:21 +0800
Message-ID: <20240126041725.124562-12-peterx@redhat.com>
In-Reply-To: <20240126041725.124562-1-peterx@redhat.com>
References: <20240126041725.124562-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

We need to hold a reference to the current_migration object around
async calls to avoid it been freed while still in use.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240119233922.32588-3-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index cf17b68e57..b1213b59ce 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3382,6 +3382,7 @@ static void bg_migration_vm_start_bh(void *opaque)
 
     vm_resume(s->vm_old_state);
     migration_downtime_end(s);
+    object_unref(OBJECT(s));
 }
 
 /**
@@ -3486,6 +3487,7 @@ static void *bg_migration_thread(void *opaque)
      * writes to virtio VQs memory which is in write-protected region.
      */
     s->vm_start_bh = qemu_bh_new(bg_migration_vm_start_bh, s);
+    object_ref(OBJECT(s));
     qemu_bh_schedule(s->vm_start_bh);
 
     bql_unlock();
-- 
2.43.0


