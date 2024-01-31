Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B20C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7tU-0006eV-R5; Wed, 31 Jan 2024 05:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV7tN-0006Y1-JA
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:32:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV7tL-0005iK-JR
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706697146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5BznSsUeQgE8jqC5Fqg/VQQUrmZ60X5UizbN/zWa8g=;
 b=eTDiCD+fuLzqFcCoLief1vefwzY6ThJsGNMmCprxO5hSeMhuffK93isjhU1+dZFX2K6YSz
 Q84ngcYzsENczEy6XUuJq2n4REF1zx27gJmcsZtCw2QEcJV4EE88SZnEfhN4cPwv2h+Tfl
 rFYQOiGvQHshKwSJiK6Iw5eSBEjm7S8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-s4Bcl2GHP66-LulmabqxAg-1; Wed, 31 Jan 2024 05:32:24 -0500
X-MC-Unique: s4Bcl2GHP66-LulmabqxAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 128D5185A782;
 Wed, 31 Jan 2024 10:32:24 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27EFE1BDB1;
 Wed, 31 Jan 2024 10:32:19 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 14/14] migration/multifd: Forbid spurious wakeups
Date: Wed, 31 Jan 2024 18:31:11 +0800
Message-ID: <20240131103111.306523-15-peterx@redhat.com>
In-Reply-To: <20240131103111.306523-1-peterx@redhat.com>
References: <20240131103111.306523-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

From: Peter Xu <peterx@redhat.com>

Now multifd's logic is designed to have no spurious wakeup.  I still
remember a talk to Juan and he seems to agree we should drop it now, and if
my memory was right it was there because multifd used to hit that when
still debugging.

Let's drop it and see what can explode; as long as it's not reaching
soft-freeze.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 0f22646f95..bd0e3ea1a5 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -766,9 +766,6 @@ static void *multifd_send_thread(void *opaque)
             p->pending_sync = false;
             qemu_mutex_unlock(&p->mutex);
             qemu_sem_post(&p->sem_sync);
-        } else {
-            qemu_mutex_unlock(&p->mutex);
-            /* sometimes there are spurious wakeups */
         }
     }
 
-- 
2.43.0


