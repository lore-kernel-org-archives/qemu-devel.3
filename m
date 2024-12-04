Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174E9E77169
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdcb-0003Fc-Sa; Tue, 03 Dec 2024 19:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcV-0003D2-6F
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:52:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcT-0005g8-LD
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZntSzqNWuBb17WbCKGc0zhRMJFYOiINDmC++y1Vats0=;
 b=gdSIGiWNW0ITT3E3TZfK4Wl+uHw5Z/btfpvcQw7n0v3i5Agd+2RF6fORKITh3sZpzPJZFC
 pOzIknN8qo2FcZJ31OhO7Rltg5/7BuRulcbOaOf6D9SIEOM1cKl25LD0B4neNhktirqDCB
 GmkM/daf+xxkWhiAS+XuaE9u2jgmhmY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-rGZQarT0Pw2_7qXoitjgnw-1; Tue, 03 Dec 2024 19:51:52 -0500
X-MC-Unique: rGZQarT0Pw2_7qXoitjgnw-1
X-Mimecast-MFC-AGG-ID: rGZQarT0Pw2_7qXoitjgnw
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b665521dabso93631585a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273511; x=1733878311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZntSzqNWuBb17WbCKGc0zhRMJFYOiINDmC++y1Vats0=;
 b=uhByttN+Pp5X1pxr+tTijZDy3dFuvfU7bjg7mncfh9q25OAAVB/Z7MizPnQfs0hRul
 e6THOLotpx5me0bHWW/5Bkh8bN8ZddCln6Om6Hge0t7lw40RpW3LUb8yLBnKTm1CHtnV
 HN61yRxi1YqAKWcsXMmipQ3hcQhyCoA8L+QPUg+/1jJC7x6z7AEmKhTa1n6dlZAQlVf4
 UUYatopu/4r7FcFAJ6HwtjeTkZ3+d4U5y/uma5udubf2SkxZtRQUGbxOVw2s5TI9Zyln
 QxvL2MCq/3Yl1lsPrgt0eLdBvprxfVaQRK6W9+QhWyTEao33iqPF38gdQO7iRcF3Vt0c
 HN1w==
X-Gm-Message-State: AOJu0YyY5cvBhVtoxRLoNk8HlugOx6KE6mwV3SPsM1Y37ezKy3Kb9MTg
 xPLuE+yn406BMygVJKJcxGEAmJAICmTR2rry4MND23mkCvksEac5E1sroU5vEwx6QDsnzaJ+WWs
 eeiHeIObAi3i9/fUbgwpwdtoOdCLwm8IaRvubrf50IQlcfIDPtnk4Xw27Row6q+DLHtKW4xrIyF
 lv/IGLZCx+lokPDSv/3y/S6N8sb4QX2C5dCQ==
X-Gm-Gg: ASbGncu75uRlUURL2ckMnHp3K0lW58ZhVjmQK55wRFbr1UPV0aLWOldGmk7vJ55D0lT
 gOIQgjhwCa5sG4iO8c6VYqCg4n2QEcfcbYDT+EEZGMmSgG5X/nEs42WjXCH+OsUUyOj5JiFWQ4q
 KxuXNPNCeEBxtOh9KJposljLC7iwzlxjxaOMvSMhpXDvX5id+k4euojMJyQSMvlU23rCzSIKLUI
 N+9XdAXuQN3Q1sjBvcUX1GKfAq2Qd8LIAIeLsvI075Das+gvADFRj+k1GOTnjbTzGWdhNMMloy4
 Er1RzlGd21RdmS+0ypNRqDvIEQ==
X-Received: by 2002:a05:620a:170f:b0:7b1:3c0e:3289 with SMTP id
 af79cd13be357-7b6a671f8a2mr603590685a.22.1733273511248; 
 Tue, 03 Dec 2024 16:51:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8P6MkeCNieGQeIuDha8vXOKH5080KvlShL6IdO4CYNP6LAXEbiBdBrreI+UpJm6UvqEIBrQ==
X-Received: by 2002:a05:620a:170f:b0:7b1:3c0e:3289 with SMTP id
 af79cd13be357-7b6a671f8a2mr603572285a.22.1733273508150; 
 Tue, 03 Dec 2024 16:51:48 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492cb81sm559974785a.34.2024.12.03.16.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:51:47 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, peterx@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC 04/11] migration/block: Fix possible race with
 block_inactive
Date: Tue,  3 Dec 2024 19:51:31 -0500
Message-ID: <20241204005138.702289-5-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204005138.702289-1-peterx@redhat.com>
References: <20241204005138.702289-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
index 0d52fe522c..3c75257318 100644
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


