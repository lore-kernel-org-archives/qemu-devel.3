Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0219E7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 23:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJhRP-00034C-0m; Fri, 06 Dec 2024 18:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRO-00033S-7h
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRM-0005qM-PW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733526532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bS9WUYBupHARWAmcXHaiZdxJvm4+ljW4MwpDEWQXwEI=;
 b=eytdUVlLHmqddYD3Km+htAqOnnvmoIk4QJCuKQ0NpEV6V3R9SJ+a3WQ97W1vD+yDqUk7hz
 HUbP7PDKSeCYsY6/dJ8SKNv2UKxZEN7yuHhUZDvSLjSoKv8lSax0Gcpciqnme/mLFZC47h
 u+1u3jyNVO5BzkiYjfy8cWy4S8llUuk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-ksRqld-zOh6vfAD1CKCScg-1; Fri, 06 Dec 2024 18:08:51 -0500
X-MC-Unique: ksRqld-zOh6vfAD1CKCScg-1
X-Mimecast-MFC-AGG-ID: ksRqld-zOh6vfAD1CKCScg
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-8419946e077so428694239f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 15:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733526530; x=1734131330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bS9WUYBupHARWAmcXHaiZdxJvm4+ljW4MwpDEWQXwEI=;
 b=DeGOcFxXuxO73GN7lsvo0OvKsj9t3V/ojq7Um/7CjdU5MtqRw3V8Pr7LlGTZrZJYVP
 k4guUOzcf9zNILHhgqp5Rsg4tFWwvtKm0vjjot4DzVDuYnfaq8j9MJlDEmzjaP1APXqe
 Q/fZCcJu/GU2LVx253ZYRgh6ZySWxZOlLWgKIaw/6DqTx8dFu1oH6LptlXyPyaUOc0Qh
 ptfuvJN6yLvOxuI/Jl/Yf0KyySHlGBCiKADCquUqRom/1DMtmEdQk+Pbs8MZhgDgCYpS
 0VLiIrBwmI2Kpy+wgc9nlHI9G3xCm+Hqni0wfvDlbGRf8tOZg7RoFIiy4TSOtKKV9d2A
 02RQ==
X-Gm-Message-State: AOJu0YwC+1YpJH8kYAjsk9PQhE81Gwp85armr5Kk33JgahYYlorL+mzG
 ZCBEqNLXmzlElt/NPVyuZvsAZb/ixJJZVXPl9iUYG6sIGNfHY/syHdffnIIBsYdGpknUySIKx9D
 dhsWbTZ1L/kDAamM/S601AzPYpTQ1yYP6TgblUo/saxwALsj8jAZ/N0LAjFhAEkWb8SSCY/BHU0
 j8AtSm6zDcL/hIrIdGfX7zj8CDUMBBIwUvHw==
X-Gm-Gg: ASbGnctYmjQCmeSeU3Pto/HuXsbK1g7Jos0cTeBDMJcfvkRto+iPNFtb/dZ/6aTTkv2
 gygQJ1yfy27jjzENgPylEkTDWuI0qd1DskqDsVTKek+s1sbNMKqnB2RmLlaqgS7VhuoE3nV7XfE
 r2VNAUE3VqyIhzzOOVZN0iwE/1rXLZVAs5ajbKNeTSnZW17p93qUZRICh1IBrT4mx7RxemkRP8V
 2AA93hZSq/f8yd+5mfxpvg2LTop12Ci4Dv0Vg0zBUvufum4kcebaJFdbbEIVx85L8aHj0e8xO7s
 xB1tDl6oK36LCtHnKUl23pqmzw==
X-Received: by 2002:a05:6602:641c:b0:83b:2b89:a14e with SMTP id
 ca18e2360f4ac-8447e2c3059mr585271039f.13.1733526530055; 
 Fri, 06 Dec 2024 15:08:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1O0DiEPkcMsR47gYbS8NeUHYNgBIGz6sHzHftMJtOlco6RqciKtr/eHPZsSsobJC/ker4cg==
X-Received: by 2002:a05:6602:641c:b0:83b:2b89:a14e with SMTP id
 ca18e2360f4ac-8447e2c3059mr585268339f.13.1733526529709; 
 Fri, 06 Dec 2024 15:08:49 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d9a8dsm1038895173.86.2024.12.06.15.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 15:08:48 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 5/6] migration/block: Fix possible race with block_inactive
Date: Fri,  6 Dec 2024 18:08:37 -0500
Message-ID: <20241206230838.1111496-6-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206230838.1111496-1-peterx@redhat.com>
References: <20241206230838.1111496-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Src QEMU sets block_inactive=true very early before the invalidation takes
place.  It means if something wrong happened during setting the flag but
before reaching qemu_savevm_state_complete_precopy_non_iterable() where it
did the invalidation work, it'll make block_inactive flag inconsistent.

For example, think about when qemu_savevm_state_complete_precopy_iterable()
can fail: it will have block_inactive set to true even if all block drives
are active.

Fix that by only update the flag after the invalidation is done.

No Fixes for any commit, because it's not an issue if bdrv_activate_all()
is re-entrant upon all-active disks - false positive block_inactive can
bring nothing more than "trying to active the blocks but they're already
active".  However let's still do it right to avoid the inconsistent flag
v.s. reality.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 9 +++------
 migration/savevm.c    | 2 ++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e6db9cfc50..ba5deec5bc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2749,14 +2749,11 @@ static int migration_completion_precopy(MigrationState *s,
         goto out_unlock;
     }
 
-    /*
-     * Inactivate disks except in COLO, and track that we have done so in order
-     * to remember to reactivate them if migration fails or is cancelled.
-     */
-    s->block_inactive = !migrate_colo();
     migration_rate_set(RATE_LIMIT_DISABLED);
+
+    /* Inactivate disks except in COLO */
     ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
-                                             s->block_inactive);
+                                             !migrate_colo());
 out_unlock:
     bql_unlock();
     return ret;
diff --git a/migration/savevm.c b/migration/savevm.c
index 80726726fe..706b77ffab 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1558,6 +1558,8 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
             qemu_file_set_error(f, ret);
             return ret;
         }
+        /* Remember that we did this */
+        s->block_inactive = true;
     }
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
-- 
2.47.0


