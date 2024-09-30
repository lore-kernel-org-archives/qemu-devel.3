Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FB4CDD1D6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 20:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMYW-0004hR-Dm; Mon, 30 Sep 2024 15:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMY5-0004AN-MK
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMY3-00048s-Ql
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727726351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IVNh8rkuBzemuMWp2WPFFN8HowcfvDmFRDqv1ADWW0=;
 b=gSqmtYi0SQ4mYMazWZhULR6Jl95z5t2VT3LBWu7nwkVeWMo3cgypwEGDcvi0owJoka+c7m
 xz4ySB6Mlmdl3sFo9TdMr6seSQxqX1w5aYZJt0SFjWWqPeg45o4GfT7TbW1RHtDOVgc9XQ
 IGMDC4lKjqmjr5mHc8iJEA3UogjzHc8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-gC2mVLvGO8qfST2PGrVE-Q-1; Mon, 30 Sep 2024 15:59:09 -0400
X-MC-Unique: gC2mVLvGO8qfST2PGrVE-Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cb3d5736a4so70540996d6.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 12:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727726349; x=1728331149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IVNh8rkuBzemuMWp2WPFFN8HowcfvDmFRDqv1ADWW0=;
 b=VG1EmUdsIZto3oqFsB6AwO1Ev+RR5CkkMorjQHQ3FzIRQFhTBwJn8Cq4VwXYIHRYBC
 v+E6DTTtiUbklrNwQ0hD+jUrTQfYvq+pHYtYMqMqkGZOihkhhCd6DgkaOyOx3YKFzzOZ
 R3mQorJ4vAzGWdz6JXDd0H4Pzpan0LpTm+czwQZgLEpqoHYiwBYb9321iD7onSjSVlrj
 oHLkGzi9mtZZySdPeNZSUS+lpH3wQhuzjxTK80dcoaPiS4SQiOnqxSXihURj/Fc/OzQQ
 njALQFGBwpHjGsJ9Ytd2CxU2V+FRDFqxmH+DUPJ5+3POJK9ExluEISmt4lP5EkKqV+h1
 Ts7Q==
X-Gm-Message-State: AOJu0Yz0ueHEnx1BFapz7rSH3fM+nWEuVajgR9auicpcI04viQ87AjRs
 8Jc1Bqg6b0DvHxsYV/5WUPOIiJkPlDbSHj3YsuXMiMpbFOjCowKYHKaUoWPjwstSQ7tmC4idTI9
 BQr98KYV9yCV5FDdV0TPyGcA3HTbS6rflWOzmOPW6doXDR8XM/6Nkr7GnCUYgNuryTpLsQwbDS7
 uco+ZrRwj8SGsSpck/vMTGSbH+PGWej3DrFw==
X-Received: by 2002:a05:6214:328e:b0:6cb:2ad6:78ef with SMTP id
 6a1803df08f44-6cb3b5c6732mr186119366d6.4.1727726348852; 
 Mon, 30 Sep 2024 12:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVzVpt6MhFCkdOiTIb7rTrFVkeUwAuegBYrxZJiBIgstHCiSjypMXUonr8bOYSr/TzXdewRw==
X-Received: by 2002:a05:6214:328e:b0:6cb:2ad6:78ef with SMTP id
 6a1803df08f44-6cb3b5c6732mr186119176d6.4.1727726348511; 
 Mon, 30 Sep 2024 12:59:08 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f28e481sm38879371cf.16.2024.09.30.12.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 12:59:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 7/7] hmp: Add "info migrationthreads"
Date: Mon, 30 Sep 2024 15:58:37 -0400
Message-ID: <20240930195837.825728-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240930195837.825728-1-peterx@redhat.com>
References: <20240930195837.825728-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The QMP command was added in 671326201d ("migration: Introduce interface
query-migrationthreads", v8.0).  Add the HMP version of it.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/monitor/hmp.h          |  1 +
 migration/migration-hmp-cmds.c | 25 +++++++++++++++++++++++++
 hmp-commands-info.hx           | 13 +++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index ae116d9804..e44a399e4a 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -31,6 +31,7 @@ void hmp_info_mice(Monitor *mon, const QDict *qdict);
 void hmp_info_migrate(Monitor *mon, const QDict *qdict);
 void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict);
 void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict);
+void hmp_info_migrationthreads(Monitor *mon, const QDict *qdict);
 void hmp_info_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vnc(Monitor *mon, const QDict *qdict);
 void hmp_info_spice(Monitor *mon, const QDict *qdict);
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 20d1a6e219..63a6ea61f2 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -814,3 +814,28 @@ void loadvm_completion(ReadLineState *rs, int nb_args, const char *str)
         vm_completion(rs, str);
     }
 }
+
+void hmp_info_migrationthreads(Monitor *mon, const QDict *qdict)
+{
+    MigrationThreadInfoList *list;
+    MigrationThreadInfo *entry;
+    Error *err = NULL;
+
+    list = qmp_query_migrationthreads(&err);
+
+    if (!list) {
+        monitor_printf(mon, "No migration threads found\n");
+        return;
+    }
+
+    monitor_printf(mon, "%-16s%s\n", "TID", "Thread Name");
+    while (list) {
+        entry = list->value;
+        monitor_printf(mon, "%-16" PRId64 "%s\n",
+                       entry->thread_id, entry->name);
+        list = list->next;
+    }
+
+    qapi_free_MigrationThreadInfoList(list);
+    hmp_handle_error(mon, err);
+}
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index c59cd6637b..a8dc55dbd2 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -512,6 +512,19 @@ SRST
     Show current migration parameters.
 ERST
 
+    {
+        .name       = "migrationthreads",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show migration threads information",
+        .cmd        = hmp_info_migrationthreads,
+    },
+
+SRST
+  ``info migrationthreads``
+    Show migration threads information.
+ERST
+
     {
         .name       = "balloon",
         .args_type  = "",
-- 
2.45.0


