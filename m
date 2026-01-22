Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B591BD6CFAB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 23:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj3iL-0004yB-4f; Thu, 22 Jan 2026 18:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj3iI-0004wF-PF
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:03:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj3iG-0007Ub-F6
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769123019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x6Clafm83cpUvxlAJaqZR0gZqoh8vU0lKtAXEYMO/5I=;
 b=A3e2pYAJBW+yHMcXSL83Lqpz5THIF59strYKeVBXPPZf9+ara5msN+GKEGgiU14Q4rRykF
 AR+kBmeZMMg4FO9L6xTOcM5dNfoPIiBIM3bjIYx1/jd730yjlXGlCkuijISwnZ6lJZW6ks
 qcFy51sk6LXp3QUeZu4zZAF6dFxaqW4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-3CV5EfCoNJKM7ml1EJF9eg-1; Thu, 22 Jan 2026 18:03:38 -0500
X-MC-Unique: 3CV5EfCoNJKM7ml1EJF9eg-1
X-Mimecast-MFC-AGG-ID: 3CV5EfCoNJKM7ml1EJF9eg_1769123018
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c6ae763d03so176156785a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 15:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769123017; x=1769727817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6Clafm83cpUvxlAJaqZR0gZqoh8vU0lKtAXEYMO/5I=;
 b=OUrEM3If36hVNO1tkSCSsET56ry3xPz856BEuZeaPd/Te9etRLRr/0LN5996X7eJne
 cngMN8jNiLZ9v9vllHHI+gvGykk2lS07dUceGrgRttzZsibQRJQYhGrAzG0PtAlqTCaa
 Pbc6siBg8eMfwTGLf9LF9ThfKOlC3GT+ogohPE1ao4ITGBVOl4xzytc6upSIIsU2Gztx
 muIeEQ03SSK4ATKQFaFD3okmlOAEUCWBlyAliSmUmfuvpI70UfuMhElmCt5dqqRV1Xh2
 +DBmn9T4Rm0+1NH+NsUw/gHK3E5jmILzYOPiFh2CaWKxUM2sZhZH8B+8vHHEkPNGx0by
 pZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769123017; x=1769727817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x6Clafm83cpUvxlAJaqZR0gZqoh8vU0lKtAXEYMO/5I=;
 b=ktW8MKL77KRvII5nf5AeW6YaGuVZBvv7Ft8/hocrPxFwTjwspeGuwdgVRGRMxH889X
 AD0r1pvPE1OUX0GF5YEkxtn+oYpB5guO7EToYu6tJ5WY23kJq8ueM+QtWdsOzBHXys77
 ZgYzohlsN8J2SuWwjp2CAtfWi78A69Pftxu1C7+RsjzAVrQLpUV7VLlN2QB8NCf4XV0e
 kk/c9R6RtT6Gov771r2m6NpWV6EZKTAL/q68AQ94mHn8vakGAVQTd+z0ssflR8a0qFep
 lHQwLUkfpa/kHhtsVb3Nfjm/mqwhN0YypfPXLDBGm1345dtAwJ2eUScc3c3fGlUIrtzs
 p6Bg==
X-Gm-Message-State: AOJu0Yzk7zNZPaRjXk2VdZt7y9ISVlWSRkxMqlqh7xscwZAWoqy5RAnE
 DD/S2vLBd07Lc4Cjb0fEMubFBhx0YqJpTm9xdwyZg28PBPVrrbaoOG4zG0Mkisa3Ox3WvfRQOyf
 +JqbfHUq8Lq37dObW4+4FtTs17MzJfB7J8uqtTVgUXshCCpomUhUiUPz5eVHYgSqWqQiIzYsBMD
 OdWG3EDgt/mcjvzEMVT2j89MrsTiCHyaP3RcGkow==
X-Gm-Gg: AZuq6aKKB8iyTN1BOAyzRdVgo0i5h/wR/5D+/R3rUZr8kE2MIAu253UGnST6zkux2Ei
 AIcX8i/sIrkB8AJ7gD2KEBf4vfgAugadHeEeupuLbj0SY/8yZb9LZxSR0muv3GvhTmjqwhtpCP3
 kjGc3e34We7HjKSLnE4BeV2YKpuYyU2XFscRls28h+V2CvYx9i9sb9RL2DeqgHIJ7RyYgvnOpCx
 e8JRJcV68rd3y2Vqmrd2/vgTuVooW2NUOyyAQs7zPYMBC8NQWiP4Or5dtQKpnI/P9+1bV9EYLia
 B3rIjPDb0tl9PT5URETeGkY+tbmWDCupEo+zwwcajK36344TN5+833/8QSIjgtGIoA14tFZNOrA
 y
X-Received: by 2002:a05:620a:1709:b0:8b2:7726:c7c4 with SMTP id
 af79cd13be357-8c6e2e2e85dmr158956785a.63.1769123017370; 
 Thu, 22 Jan 2026 15:03:37 -0800 (PST)
X-Received: by 2002:a05:620a:1709:b0:8b2:7726:c7c4 with SMTP id
 af79cd13be357-8c6e2e2e85dmr158951385a.63.1769123016719; 
 Thu, 22 Jan 2026 15:03:36 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e37d2a56sm41032785a.20.2026.01.22.15.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 15:03:35 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 2/5] migration: Fix double notification of DONE/FAIL for
 postcopy
Date: Thu, 22 Jan 2026 18:03:28 -0500
Message-ID: <20260122230331.3543312-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260122230331.3543312-1-peterx@redhat.com>
References: <20260122230331.3543312-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Migration notifiers will notify at any of three places: (1) SETUP
phase, (2) migration completes, (3) migration fails.

There's actually a special case for spice: one can refer to
b82fc321bf ("Postcopy+spice: Pass spice migration data earlier").  It
doesn't need another 4th event because in commit 9d9babf78d ("migration:
MigrationEvent for notifiers") we merged it together with the DONE event.

The merge makes some sense if we treat "switchover" of postcopy as "DONE",
however that also means for postcopy we'll notify DONE twice..  The other
one at the end of postcopy when migration_cleanup().

In reality, the current code base will also notify FAILED for postcopy
twice.  It's because an (maybe accidental) change in commit
4af667f87c ("migration: notifier error checking").

First of all, we still need that notification when switchover as stated in
Dave's commit, however that's only needed for spice.  To fix it, introduce
POSTCOPY_START event to differenciate it from DONE.  Use that instead in
postcopy_start().  Then spice will need to capture this event too.

Then we remove the extra FAILED notification in postcopy_start().

If one wonder if other DONE users should also monitor POSTCOPY_START
event.. We have two more DONE users:

  - kvm_arm_gicv3_notifier
  - cpr_exec_notifier

Both of them do not need a notification for POSTCOPY_START, but only when
migration completed.  Actually, both of them are used in CPR, which doesn't
support postcopy.

I didn't attach Fixes: because I am not aware of any real bug on such
double reporting.  I'm wildly guessing the 2nd notify might be silently
ignored in many cases.  However this is still worth fixing.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 +
 migration/migration.c    | 3 +--
 ui/spice-core.c          | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e26d418a6e..b002466e10 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -63,6 +63,7 @@ typedef enum MigrationEventType {
     MIG_EVENT_PRECOPY_SETUP,
     MIG_EVENT_PRECOPY_DONE,
     MIG_EVENT_PRECOPY_FAILED,
+    MIG_EVENT_POSTCOPY_START,
     MIG_EVENT_MAX
 } MigrationEventType;
 
diff --git a/migration/migration.c b/migration/migration.c
index 47d9189aaf..91775f8472 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2857,7 +2857,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * at the transition to postcopy and after the device state; in particular
      * spice needs to trigger a transition now
      */
-    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE, NULL);
+    migration_call_notifiers(ms, MIG_EVENT_POSTCOPY_START, NULL);
 
     migration_downtime_end(ms);
 
@@ -2906,7 +2906,6 @@ fail:
         migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
     }
     migration_block_activate(NULL);
-    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
     return -1;
 }
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 8a6050f4ae..ce3c2954e3 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -585,7 +585,8 @@ static int migration_state_notifier(NotifierWithReturn *notifier,
 
     if (e->type == MIG_EVENT_PRECOPY_SETUP) {
         spice_server_migrate_start(spice_server);
-    } else if (e->type == MIG_EVENT_PRECOPY_DONE) {
+    } else if (e->type == MIG_EVENT_PRECOPY_DONE ||
+               e->type == MIG_EVENT_POSTCOPY_START) {
         spice_server_migrate_end(spice_server, true);
         spice_have_target_host = false;
     } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
-- 
2.50.1


