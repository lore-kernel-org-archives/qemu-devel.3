Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6086ACDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0YS-0004W3-4s; Tue, 23 Jun 2026 08:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YN-0004V6-KV
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YH-0006zJ-Ge
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDX2xpxPgNeOlEtNfh7SmSQxG2EOjd0N5xJ4fQJcAqM=;
 b=E7rgz2+ztkMXV8vl6pRBYbEb/3+kFlE+p9QW9jftmZyHQfxS7noHZc0ghCFZLey2NwrZTL
 FuMJ6rRja30HnWoOba/EggdRbDoJ+n3BG7iOdhAzach9nuHtS36dsVtxLYTHPXwYgHm9rs
 wEZepUqn7r+w4unk7m64v4eJ1vgBv44=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-7xcxJg14MJy4Udd_KdG0VA-1; Tue, 23 Jun 2026 08:48:26 -0400
X-MC-Unique: 7xcxJg14MJy4Udd_KdG0VA-1
X-Mimecast-MFC-AGG-ID: 7xcxJg14MJy4Udd_KdG0VA_1782218906
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a0761fdbdso66710761cf.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218906; x=1782823706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDX2xpxPgNeOlEtNfh7SmSQxG2EOjd0N5xJ4fQJcAqM=;
 b=ZvyZenXejmMpY9079cs5uKbg8dvQTzMDMPpf4F6JHGuSksZyO4x1vuo/uERONrEFS4
 hvWegoON4uvQwTYcDDg1MKaVgbUFj0gs4w4xcrVuPHRpseRUURLTp7Na69exQWW4qC8H
 8BelEF/ESGsI/k6Ltv1ZdhsmSaNOX/+MAy4a9rLHGqCSe/N7A0J5NgZyklFEBd1zvX2h
 y+bGUlDnQDK3uxobpq9t0CXROBPZemgcanHmOWrzkslfbq8tbQhlrtksrVg6j80gOFo0
 QPyK6kh//uzVT0DnJm17AgJ+N7FjTnpRg4a2guC70DTl4NpkHgllVm2S+nY3OTYI26O2
 KsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218906; x=1782823706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hDX2xpxPgNeOlEtNfh7SmSQxG2EOjd0N5xJ4fQJcAqM=;
 b=ft2/niCXH4pu6DeER9FJycBiI8aCABk9HWN1HwEGYvz/VLWAQxwvhjUEnf/nemlmgC
 JgWcvxziQZG9bXBAEuZogbQeI5RimZJih4+RnpCKgl8ajNSl86CQsPWxo7WzxfPQZEu6
 CAjaJMN/xUz391niwsDpUpMb/0oAw951jjedLhKIvcfmSaqJhmxaumjk0XHHtaj4U8QX
 0TEdhyIl8IDgR/QRKv13xyHFupT2PU9lsUUuxFmXUIq7qLo0Sn3SoNBkt0JobVOHSFog
 s19MgeiaXM8isMX8DTEW384eCztYYfJ9S7Z6VUcMRGyyBoYUZs395UDgpjAenu8LeFwE
 VaMA==
X-Gm-Message-State: AOJu0YzvXRZA5lPPKovyQsvigCSP+ws8mV4t+2PH4er6fhufag7Ss3Fy
 NyYuHvzP2ZcHSysc5VKjLHnn8xpJg7bohwWfemzTNZTZ1Av0y663l9uvCQd9Ya8P7HMlD2bbMfQ
 QyJEUkw+xAXJK3O41tXaiKkDmc4uegX0mBs+U/G0V3gjhORlhfiXN5SADvNbKVzKGWEPHIUf0sj
 DSsT8NawJ2MLe0ZTabg/6aAnZQT2joXdx7joAeCA==
X-Gm-Gg: AfdE7clHg/Zr0dtpOWKHNENYJ8oPSLpgQPz3mM2qkqOUeQxvSUzDunmmTxv6ulFntNE
 +nL4dj4b5fdH33p5bxkFFjT4tF77IM9czfFA9CqBo4qBTkKCirMsLmlADyONBkDrgC2mt5bImlC
 EsLzgff4K25731cIcKh3UiIsgDQ2KBmuy73OqYBWXgdYD89To/B2MhTMdTftEbxHJk5uT6IIvzn
 LHkxsuAJdH6Uptv+bw6BrQ0woKQIUMn4pkyJ4KN6ZeGcHv0bc4hPDrJ2PGHVqF1Jl7TqQ3/PlKc
 ghFTJvwJR+wTWCn2pND6PMAR430+BDYQJt/VMN7cj62VyaG80iPK8uNS3EemMaPW9qOpAworco+
 ROg==
X-Received: by 2002:a05:622a:389:b0:516:df62:bdd2 with SMTP id
 d75a77b69052e-51a06b2b24cmr221712631cf.55.1782218905977; 
 Tue, 23 Jun 2026 05:48:25 -0700 (PDT)
X-Received: by 2002:a05:622a:389:b0:516:df62:bdd2 with SMTP id
 d75a77b69052e-51a06b2b24cmr221711781cf.55.1782218905135; 
 Tue, 23 Jun 2026 05:48:25 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 05/18] migration: Use OBJECT_DECLARE_SIMPLE_TYPE
Date: Tue, 23 Jun 2026 08:47:46 -0400
Message-ID: <20260623124759.125399-6-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
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

Migration object's class has nothing special, switch to the newly
introduced macro.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260609172514.2037645-2-peterx@redhat.com
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
2.54.0


