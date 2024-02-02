Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E53DC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqon-0000fS-MZ; Fri, 02 Feb 2024 05:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqoj-0000Wb-Sw
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:30:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqoc-0001yc-2H
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFlOKHkHp+NTREGXzhlqyouK8g51RQcm5L4VHQC+QI0=;
 b=PM/kVmWsgiUuTGRpmc6BBXUPp1oAFum7FKJGv26cXpEuI2Fp9ykTkoRQnwGhzKGCrQ5yy8
 xrvhzDKfCXfsZ/IFH/XjlJPkVJGhBUlMXVoGK4OBZjWzG89is9CbAGYoOgI9Z7TU5yerXm
 aETpJrSVcrx2ODLSk4yzYqPInkU6k+4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-1VoMIqu7Mw-w5OiBJ9XMmg-1; Fri,
 02 Feb 2024 05:30:30 -0500
X-MC-Unique: 1VoMIqu7Mw-w5OiBJ9XMmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB8701C04B6F;
 Fri,  2 Feb 2024 10:30:29 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 788C0400DF3D;
 Fri,  2 Feb 2024 10:30:25 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 14/23] migration/multifd: Forbid spurious wakeups
Date: Fri,  2 Feb 2024 18:28:48 +0800
Message-ID: <20240202102857.110210-15-peterx@redhat.com>
In-Reply-To: <20240202102857.110210-1-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

Now multifd's logic is designed to have no spurious wakeup.  I still
remember a talk to Juan and he seems to agree we should drop it now, and if
my memory was right it was there because multifd used to hit that when
still debugging.

Let's drop it and see what can explode; as long as it's not reaching
soft-freeze.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 6aa44340de..28b54100cd 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -756,7 +756,9 @@ static void *multifd_send_thread(void *opaque)
             p->next_packet_size = 0;
             qatomic_set(&p->pending_job, false);
             qemu_mutex_unlock(&p->mutex);
-        } else if (qatomic_read(&p->pending_sync)) {
+        } else {
+            /* If not a normal job, must be a sync request */
+            assert(qatomic_read(&p->pending_sync));
             p->flags = MULTIFD_FLAG_SYNC;
             multifd_send_fill_packet(p);
             ret = qio_channel_write_all(p->c, (void *)p->packet,
@@ -771,9 +773,6 @@ static void *multifd_send_thread(void *opaque)
             qatomic_set(&p->pending_sync, false);
             qemu_mutex_unlock(&p->mutex);
             qemu_sem_post(&p->sem_sync);
-        } else {
-            qemu_mutex_unlock(&p->mutex);
-            /* sometimes there are spurious wakeups */
         }
     }
 
-- 
2.43.0


