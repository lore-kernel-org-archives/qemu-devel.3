Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BA0E6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Pw-0002Hc-Ud; Tue, 23 Dec 2025 09:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PP-0001Jz-Uk
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PL-0003oc-6e
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IfXKt3fTkz6GEBBSc40+ZiXCkHpPU8KfJa3ty8O0Src=;
 b=TNBgyaHQgBSn+jplxhDlHBylRkG2Ap4pVm/3Z6r+co8dEXTru8ScrEUNwTxpsQCw9uRu8Y
 RNSZl5NITMw1f6NVijmROY9MtK4p5fYZnaStgX1bXq+Y/PGghjrVuf6est24yPSGP2PaQ0
 AeZcJjlMZnCLpfIdty5KfkHw2+Vm33k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-zmY5c-JZPACwIvWjfn2faQ-1; Tue, 23 Dec 2025 09:30:32 -0500
X-MC-Unique: zmY5c-JZPACwIvWjfn2faQ-1
X-Mimecast-MFC-AGG-ID: zmY5c-JZPACwIvWjfn2faQ_1766500231
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88a47331c39so129291776d6.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500231; x=1767105031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IfXKt3fTkz6GEBBSc40+ZiXCkHpPU8KfJa3ty8O0Src=;
 b=SwqMNvbALc1HzmG1/R2oqv1PDVWKndG9yTO4N6YXcZVeO6PqYx70pjX5lb401LBsz4
 w7l9L3OuDGgUrQYZgJcR9ETGWXORYb9gk1l/mFNk17Sn9NkvDQgSIujEUHH5r9LBy4u2
 pyLqwm2mfKevv8foysu6zlPM0uiOM91xwFX048lf2i1RxtAJWsCjEkOzVOAGH3WiTGcI
 ILDXLSe4xFV01teWofHbWWX/QltPpddqP08jzgaT9NMCx+zFDE5rztcxdkdl2tfYp6bn
 2FhQj84I8Hi51iklfD2/3PtmZV2E0/9yQmmOQP90p5kQmrWOatEt5VslQrr3ylHfwjEn
 A4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500231; x=1767105031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IfXKt3fTkz6GEBBSc40+ZiXCkHpPU8KfJa3ty8O0Src=;
 b=FZltey5s4cJvGOJAimkNAX5JHxta6Y1pj7h5+B1oULmDP73sFxhwQoS4C3ngDrA5qj
 lJNf1ZFeTLRd/Lef8IfrFmurUHboO9+h0HaJBgnSN3eQazbI6TWKgKJOY2leQSB58r6A
 VTK0h8g32KjL99PnLnB8pEtjHt2eN5vtRY2eqLWV1XYQXRmgcbTrFrxlC3m/io3ZmrEF
 DEr6/NnuxYICsD4H8j85oAEKDWrFE1Sj41tDY1BWepmnw5Wq79Rx3sR2Byd+ZXASv1yk
 Vcl+CXqsx7aS4EjRcNMjG3yHr6FKyQci/flaLJPkInUQBqWBnI3Wor4BVkgpKe2tyTFV
 aiCw==
X-Gm-Message-State: AOJu0YxI8IJOyh/SO6ZITJzqi/7mYo0EVR5d9j1CxWPCQMO9C5/z438b
 6r+lO2YY+KVtnVYTwIRu+5OT205C5ZeuaLCiNQmyxIAHPQcFTu38yILgMEQhxthVJxVjCHjt90a
 avzaJTE/tAT6qJSntVYFiXEHx3BBDnhkorGp+TFJF+WMPPeHq54YqFAMZYVZz84lS/OuUthI5L8
 jbtVGvm93pShhLgIfQZc7dCWgp4sgynMJ84pYXyQ==
X-Gm-Gg: AY/fxX7JlEaciUhU9wiIHx7xIGPeojVkVEu1Q0zacYrTgvZYEY5T9c5wRplhnfWNwoT
 HkIFUy2fq8xQGDOiEorRqUyi9tjMX9jJRJMT3uk/IYyehIvL+xQHMpbGhoefePXWCR2Jk0Q9gdM
 idZs6NylKccAq7jcGUqyUhejTuFo7x5D/DUE6+VjdkqHmI96QOpjgMjWKUMtTBr3i19Ewrm1msI
 C6BJ952qwGfpB/bzTzhaH+LMe8NW2y1M041HvAhtqkP/iWEYkOUZYfMgC1VCtprbjd4e6gZOAAJ
 myKKp5cR0Th7qHCv879PzWYTb135pvovgH9xKHycdAM52gxifFu5Wpq3qKmhca+u9Ku+3PczmIC
 JsAs=
X-Received: by 2002:a05:6214:470b:b0:7f1:c596:e1cc with SMTP id
 6a1803df08f44-88d820420fdmr210815866d6.19.1766500231024; 
 Tue, 23 Dec 2025 06:30:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz4NM9DJFprTzwKshkpulvy61pZsg1Jf3XqV4v1bxRwK5O/21xkcLsoi0oiMx2JrXZ7Qn8Xg==
X-Received: by 2002:a05:6214:470b:b0:7f1:c596:e1cc with SMTP id
 6a1803df08f44-88d820420fdmr210814646d6.19.1766500230171; 
 Tue, 23 Dec 2025 06:30:30 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:29 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 23/31] migration: Add a flag to track block-bitmap-mapping input
Date: Tue, 23 Dec 2025 09:29:51 -0500
Message-ID: <20251223142959.1460293-24-peterx@redhat.com>
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

From: Fabiano Rosas <farosas@suse.de>

The QAPI converts an empty list on the block-bitmap-mapping input into
a NULL BitmapMigrationNodeAliasList. The empty list is a valid input
for the block-bitmap-mapping option, so commit 3cba22c9ad ("migration:
Fix block_bitmap_mapping migration") started using the
s->parameters.has_block_bitmap_mapping field to tell when the user has
passed in an empty list vs. when no list has been passed at all.

Using s->parameters.has_block_bitmap_mapping field is only possible
because MigrationParameters has had its members made optional due to
historical reasons.

In order to make improvements to the way configuration options are set
for a migration, we'd like to reduce the open-coded usage of the has_*
fields of the global configuration object (s->parameters).

Add a separate boolean to track the status of the block_bitmap_mapping
option.

No functional change intended.

(this was verified to not regress iotest 300, which is the test that
3cba22c9ad refers to)

CC: Kevin Wolf <kwolf@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251215220041.12657-10-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h          | 7 +++++++
 migration/migration-hmp-cmds.c | 3 ++-
 migration/options.c            | 6 +++---
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index e4b4f25deb..4d42e8f9a7 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -514,6 +514,13 @@ struct MigrationState {
     QemuEvent postcopy_package_loaded_event;
 
     GSource *hup_source;
+
+    /*
+     * The block-bitmap-mapping option is allowed to be an empty list,
+     * therefore we need a way to know whether the user has given
+     * anything as input.
+     */
+    bool has_block_bitmap_mapping;
 };
 
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 8b1096db86..a2863e6a2f 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -321,6 +321,7 @@ static void monitor_print_cpr_exec_command(Monitor *mon, strList *args)
 void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 {
     MigrationParameters *params;
+    MigrationState *s = migrate_get_current();
 
     params = qmp_query_migrate_parameters(NULL);
 
@@ -404,7 +405,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
 
-        if (params->has_block_bitmap_mapping) {
+        if (s->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
 
             monitor_printf(mon, "%s:\n",
diff --git a/migration/options.c b/migration/options.c
index cb127e9c72..20e9438656 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -786,7 +786,7 @@ bool migrate_has_block_bitmap_mapping(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.has_block_bitmap_mapping;
+    return s->has_block_bitmap_mapping;
 }
 
 uint32_t migrate_checkpoint_delay(void)
@@ -1071,7 +1071,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_announce_step = true;
     params->announce_step = s->parameters.announce_step;
 
-    if (s->parameters.has_block_bitmap_mapping) {
+    if (s->has_block_bitmap_mapping) {
         params->has_block_bitmap_mapping = true;
         params->block_bitmap_mapping =
             QAPI_CLONE(BitmapMigrationNodeAliasList,
@@ -1559,7 +1559,7 @@ static void migrate_params_apply(MigrationParameters *params)
         qapi_free_BitmapMigrationNodeAliasList(
             s->parameters.block_bitmap_mapping);
 
-        s->parameters.has_block_bitmap_mapping = true;
+        s->has_block_bitmap_mapping = true;
         s->parameters.block_bitmap_mapping =
             QAPI_CLONE(BitmapMigrationNodeAliasList,
                        params->block_bitmap_mapping);
-- 
2.50.1


