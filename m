Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801CBE6F097
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3PX-0001Eo-CE; Tue, 23 Dec 2025 09:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P1-00013L-GQ
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Oy-0003il-Jz
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfCJmm4Dm8wFO89mns7yUaE2hgJsbzVj37K2Drizgrg=;
 b=Rmd6hy7iLEL9L71XX4t5EtJ34xSC3DydqI1XKI5sjTGRO4KJ43+8eJ5eFZFOpR//mJ5iRX
 nY+Emhof5F6eFc3QncCpUut2FDDmd4+YgWW4mlitHhGJXJS7PjnvGvo7PgU7AJ6I9Sbf8W
 4taiCvXsojo37o6Tc96cu0xOD3cvg58=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-RKQAjzZ1OEiX08wQq68NiA-1; Tue, 23 Dec 2025 09:30:14 -0500
X-MC-Unique: RKQAjzZ1OEiX08wQq68NiA-1
X-Mimecast-MFC-AGG-ID: RKQAjzZ1OEiX08wQq68NiA_1766500213
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b2194e266aso161327285a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500213; x=1767105013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfCJmm4Dm8wFO89mns7yUaE2hgJsbzVj37K2Drizgrg=;
 b=nBbX/qWBHoYw5Ghxun7bc0bRDk87wzz2kSFLLDVKFBJgoxCIMuxbyuh8Cu8/h8IIja
 ryFdvYeML6RwG1fguXV/tpDax1hB2EjbTVv3XWRtSdknLN18P5MO2jEr+yEthWc3C/n2
 DWnTRQmAYuNZla3GOaMb8StXtnE/4nOAE7Onht9K3wH0sS9g3F1bNtEm0zkL8nuthk2s
 Q5ebCJo+jhby8t3aFMdyKvXc5WjiDsRyNEnVYC4OqCF3Na/d6owArGEpGgvqGTrEy+19
 OW2FDb/9SpXk/mkRNBlAmMH3WA/b+wQYTNq1mpGkfoqek1jWht7VvP+6brwE3W9u8gJr
 uulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500213; x=1767105013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bfCJmm4Dm8wFO89mns7yUaE2hgJsbzVj37K2Drizgrg=;
 b=YDG5NLo4d+xcHx/gDmN0rgfjaAjhosSQ4FlgmlI6WNNHaCX0Euwq4Y1qADnB1uUUc1
 ozgcr7oOg0wrcON6mR+aDV3KdUX8wJjDHwDPTJOXkl7Cmdt3oNkZl0kHKgwREIMTHL5W
 wHI5tFLVdCbmbq0MPTUcmRnYh0Lvexr0w2zM0XL+g9Tg8//+hk5zYCKG1OG0Zs11nV+y
 rFG7zVMsQzblvXi9ECieb15le+RW3uF1X4B1pNdlh9xm2aQ2ISjJqEg+0/UCEOdWIJqh
 8keQph3hv+w693hsDPMNcGp5UnsMQsx+qmxzIVyUVJv80x21djJcF7kozXaPSLE4d4eF
 hcHg==
X-Gm-Message-State: AOJu0YyQdJfQOqhnwpWgXNGnxfRsRaaz3vppucOPtxsz5JOxl/h0MPqb
 tHTTKUvdmQPkHNFksEHdRtq7I/UKZDu2rTZoIBHd36IJD10HxwzY1QCB9KRJgBXbO7h4wRknC67
 GQPx71UssktQB10kUgKNdX32ITGxSlxa5HfMo3Ve8qMBPoU/BZO9kQXJiAG/2Id0twSg2p8sonI
 p5LQPXxUZfnJLP2zMIevLuDO1mP8BuAc+FxjMzuA==
X-Gm-Gg: AY/fxX4SAtT2XjQP9FykvR4CW58kXBRpJarrGgKQIDjDVEpa+E6xMhEdSbYiHKWklFP
 90LlKmYKHdVwuBpBvdzv8K6y33aAIqBeAI0SOsujVWneXsvxia5mIaMUIMfllxAkcO5k8tBU/Lg
 lXgZ/UUtMAbYHk7P9+UFHYtAKLpeezdHoA9nkxDML/F4O9/sW+glXAzOM+0+df9QF18AbhdUWbM
 YAukEcyxU/T4kRvRA8rKOd+ww1vH/GVsYd06PexlvMvXQ+j4JePurJ+Dg++OZtQUetgPAFUhyi0
 rRQlrHqvGl8szrmAzxw5H/eXgoWUArvYW2u1tMAF2AuMGpx6NSo4a+O3x/uOgpqWpKpOT8bM7DX
 AVgQ=
X-Received: by 2002:a05:620a:1999:b0:8b2:6b9e:5383 with SMTP id
 af79cd13be357-8c0906fc98amr2253300185a.85.1766500212871; 
 Tue, 23 Dec 2025 06:30:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdFn6wJ4gpkztUBl0Xabf/70KnCMV094a3701B8u0wX3N4KKg0ePQu4s+YpuFoarBQBZEOfQ==
X-Received: by 2002:a05:620a:1999:b0:8b2:6b9e:5383 with SMTP id
 af79cd13be357-8c0906fc98amr2253289685a.85.1766500212220; 
 Tue, 23 Dec 2025 06:30:12 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:11 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 08/31] migration: Make migration_connect_set_error() own the
 error
Date: Tue, 23 Dec 2025 09:29:36 -0500
Message-ID: <20251223142959.1460293-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make migration_connect_set_error() take ownership of the error always.
Paving way for making migrate_set_error() to take ownership.

When at it, renaming it to migration_connect_error_propagate(), following
Error API, to imply the Error object ownership transition.

NOTE: this patch also makes migration_connect() to take ownership of the
Error passed in.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20251201194510.1121221-5-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.c   | 1 -
 migration/migration.c | 9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 462cc183e1..92435fa7f7 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -95,7 +95,6 @@ void migration_channel_connect(MigrationState *s,
         }
     }
     migration_connect(s, error);
-    error_free(error);
 }
 
 
diff --git a/migration/migration.c b/migration/migration.c
index b316ee01ab..0ff8b31a88 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1575,7 +1575,7 @@ static void migrate_error_free(MigrationState *s)
     }
 }
 
-static void migration_connect_set_error(MigrationState *s, const Error *error)
+static void migration_connect_error_propagate(MigrationState *s, Error *error)
 {
     MigrationStatus current = s->state;
     MigrationStatus next;
@@ -1602,6 +1602,7 @@ static void migration_connect_set_error(MigrationState *s, const Error *error)
 
     migrate_set_state(&s->state, current, next);
     migrate_set_error(s, error);
+    error_free(error);
 }
 
 void migration_cancel(void)
@@ -2292,7 +2293,7 @@ void qmp_migrate(const char *uri, bool has_channels,
 
 out:
     if (local_err) {
-        migration_connect_set_error(s, local_err);
+        migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
     }
 }
@@ -2337,7 +2338,7 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
-        migration_connect_set_error(s, local_err);
+        migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
         return;
     }
@@ -4039,7 +4040,7 @@ void migration_connect(MigrationState *s, Error *error_in)
 
     s->expected_downtime = migrate_downtime_limit();
     if (error_in) {
-        migration_connect_set_error(s, error_in);
+        migration_connect_error_propagate(s, error_in);
         if (resume) {
             /*
              * Don't do cleanup for resume if channel is invalid, but only dump
-- 
2.50.1


