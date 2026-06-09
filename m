Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AD7CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0Cp-0007WB-AZ; Tue, 09 Jun 2026 13:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Cd-0007Kw-Lh
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Ca-0001p7-4e
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781025922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aVVARmJUwhep7oD37d2RCWN4JLy97YXNlME0a8arUGM=;
 b=Z01QdNG+wea6xfS2B3ZgWSRjIIym0Vfb89BPTFaf+zJ3K6DmQjhKcc4kRK76M2JcomK9oK
 0IdL0hm16JtTobpBJc6NE/5IodR4tkts3vDw6niQlzv2sDWbyWVTxM/578xQtF7P6CboTm
 dM9yu1KJZ8BTGWIOokoNrR9BY5/nx4U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Mn3wGF-3M4eQafikD8vjMQ-1; Tue, 09 Jun 2026 13:25:21 -0400
X-MC-Unique: Mn3wGF-3M4eQafikD8vjMQ-1
X-Mimecast-MFC-AGG-ID: Mn3wGF-3M4eQafikD8vjMQ_1781025920
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51760f997fdso172884531cf.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781025920; x=1781630720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVVARmJUwhep7oD37d2RCWN4JLy97YXNlME0a8arUGM=;
 b=jF0NpfXHA9T2ym3Cd1t/5cJ7w9+3nIVgghZosb0zGV5GHM8/GFbQDqhGk7UrmI1b9S
 rle+snf7xlwBAUyxz9pZKLXrVD4JQybYG0vKUFy+7jIgJtU9CUdRh1zLAODrJ6tVIEfT
 leNF3TmcNNq11cMQ9KDMJPNRYdZBVdjeNqsLHnPiA32b8h2K1DstM4SaVaqU9iiEtOY8
 8Xg97b6/Me5un/93sL+/n+edVcsofu3tsUIks4wApv3l75uHffPp2K61nHeFeiwfXbfQ
 i+57yB0kZ3QFtsE+v/d73lz07bAt/Sl9mrkJ0hQNu09MoCzi5pRIFtmuFzJyfJOd3n++
 DugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781025920; x=1781630720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aVVARmJUwhep7oD37d2RCWN4JLy97YXNlME0a8arUGM=;
 b=pngTpbqpyCPdVO1/ihDrdTicn3rK8Eh/jgm4O8caFGlUxzhcKG97sd7/0dfBaSLcpU
 OHYqZC1K17fQXqcVXSWMNL4/Quab7RCZfz7rtnQucVxCeMd0pFsKyP9ybiyv4xqL2rRf
 L9MTc2CzLa59/PBs5/WYYiUgCaXIxtsL+VkTvsrg2LkVbM3cogc4WJPll3v/FoltKBJP
 KQIXFSjI/t1z7YSqll2Pa+U13qqHTeuGFkqekE0+OghBuVvUVV0wd+rHyE0qfU32hDRd
 f3H9ZRFFFkKizOyjJk4AUE/l9RuE5iHhCodYo3jYO1lNoTYYr0Oni7EqyRM3DHiUBRc+
 Ou7w==
X-Gm-Message-State: AOJu0YxCSp/sGnAIb+TCWhFKeWxf00S9TBhJOvfE/uhA+PujthCRlLS7
 +NvC/IXtGTcLf9jmuPt89iwOAwka/onCoFMq21s4IWHhVw9YhN2Fe9Ka9LtNBdlA8K8G/9NWquv
 8DlnvthfDI2/ab1g5O4fsAYtpXWfrjd88m57TF2/NpitjgmLAKnRBINT76XCA5wtfo+oR+DPDvj
 7JNFxMl9YfLwCQW+TMuu0nDnS7rDlujXF+yk2XfA==
X-Gm-Gg: Acq92OF3BOfithApu3Ok7AfTRJFYafUMuqKD4gkyDPt8DXq00sNlsMePWqQMYE8VsIr
 bgmJ+EGABdAsfhoV/tM5GCvjAdXrY/d8fHdwurxE3sg3rw8AliIO6nBeEY5bF5nqtD3eE8XVKsD
 AVn8ev/2C6GSafqxHEbD+1hZV5hDsOb6io7It0aQwsrMmM5VkSMqtIKCQ0azVXmafe7mlnJoJ/U
 gGr3poTFrUnd82LYTw6LkRcUQlNpO/LrBaWVjwoQeQ76wkSJ0AGAUoAWMd4aDw+13jer+vRZY72
 Di3UVp7aof7BaB7edq5a31Ti22bHaR0y+eL7ZySEh8pZCSehMPNBymlf8YH6LF8vPjKBdrP1FNm
 gsmhqfHgFogY4Q3M2fpkzles=
X-Received: by 2002:a05:622a:47cf:b0:517:2c1e:8b6 with SMTP id
 d75a77b69052e-51795c66183mr278467501cf.38.1781025920373; 
 Tue, 09 Jun 2026 10:25:20 -0700 (PDT)
X-Received: by 2002:a05:622a:47cf:b0:517:2c1e:8b6 with SMTP id
 d75a77b69052e-51795c66183mr278466621cf.38.1781025919664; 
 Tue, 09 Jun 2026 10:25:19 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775da2c56sm187524711cf.21.2026.06.09.10.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 10:25:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v2 01/10] migration: Use OBJECT_DECLARE_SIMPLE_TYPE
Date: Tue,  9 Jun 2026 13:25:05 -0400
Message-ID: <20260609172514.2037645-2-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609172514.2037645-1-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Migration object's class has nothing special, switch to the newly
introduced macro.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 9 +--------
 migration/migration.c | 7 +++----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 841f49b215..293ad60e07 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -263,14 +263,7 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info);
 
 #define TYPE_MIGRATION "migration"
 
-typedef struct MigrationClass MigrationClass;
-DECLARE_OBJ_CHECKERS(MigrationState, MigrationClass,
-                     MIGRATION_OBJ, TYPE_MIGRATION)
-
-struct MigrationClass {
-    /*< private >*/
-    DeviceClass parent_class;
-};
+OBJECT_DECLARE_SIMPLE_TYPE(MigrationState, MIGRATION);
 
 struct MigrationState {
     /*< private >*/
diff --git a/migration/migration.c b/migration/migration.c
index 074d3f2c69..278cad502a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -297,7 +297,7 @@ void migration_object_init(void)
 {
     /* This can only be called once. */
     assert(!current_migration);
-    current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
+    current_migration = MIGRATION(object_new(TYPE_MIGRATION));
 
     /*
      * Init the migrate incoming object as well no matter whether
@@ -3975,7 +3975,7 @@ static void migration_class_init(ObjectClass *klass, const void *data)
 
 static void migration_instance_finalize(Object *obj)
 {
-    MigrationState *ms = MIGRATION_OBJ(obj);
+    MigrationState *ms = MIGRATION(obj);
 
     qapi_free_BitmapMigrationNodeAliasList(ms->parameters.block_bitmap_mapping);
     qapi_free_strList(ms->parameters.cpr_exec_command);
@@ -3993,7 +3993,7 @@ static void migration_instance_finalize(Object *obj)
 
 static void migration_instance_init(Object *obj)
 {
-    MigrationState *ms = MIGRATION_OBJ(obj);
+    MigrationState *ms = MIGRATION(obj);
 
     ms->state = MIGRATION_STATUS_NONE;
     ms->mbps = -1;
@@ -4040,7 +4040,6 @@ static const TypeInfo migration_type = {
      */
     .parent = TYPE_DEVICE,
     .class_init = migration_class_init,
-    .class_size = sizeof(MigrationClass),
     .instance_size = sizeof(MigrationState),
     .instance_init = migration_instance_init,
     .instance_finalize = migration_instance_finalize,
-- 
2.53.0


