Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F25CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHE4-0007I3-PV; Thu, 04 Jun 2026 19:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVHE2-0007Hf-93
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVHE0-0006Na-Mf
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780614703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=53eCSdM5/9myqcXLcdEsBbfYriv+6smkrhaDwhp6cx4=;
 b=RU9TLzJ0POYxJA4bY2/pYbTMte/yQVK6QxZc2hDPBcaMCuXXEdHpK9Ehsfyzxw1hUWhWyw
 52F79sOAvNeG626A56KJoEgUpTkaBCG51xkHPBF6jmN17RsXgV+li2VIeWpxgWfdScNaEJ
 m3ffF7Si+j3FnlcYyUtphIbwZrgfMys=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-70nB35rLMd2pGQ88wNCJaw-1; Thu, 04 Jun 2026 19:11:37 -0400
X-MC-Unique: 70nB35rLMd2pGQ88wNCJaw-1
X-Mimecast-MFC-AGG-ID: 70nB35rLMd2pGQ88wNCJaw_1780614697
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157929bf8fso131842185a.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780614697; x=1781219497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53eCSdM5/9myqcXLcdEsBbfYriv+6smkrhaDwhp6cx4=;
 b=pgrIO7lPV63WSCxG6ZVhORNiMUxI8SFTjWtxD4lc6G+wBNa8wrQtMd6uBM0lb8Jtyg
 adn0CdDvvBhcTpmBPMP0rICH4/xkwC82hzo/AZr4Jltf48ZaMHEDhIfQg3R7bw83Ckv4
 YyXQDkIg8y/kYVAm+8kfymvE0na1A1La3uIcWiTLpolFZvgslWr0LF9ljT1l9YnRC/Ka
 I03A3JZSiiV0dDi78+O7eJtuQlp0h+3D9jBfIv9AR5hcgXVSTBGwoC2ErBqB9cgvC3eA
 c0oeZezb/eWrB+9uPNDlztzw5af0+Y8CL6WzOfTYB2E8HLqpfn3bzMqxdTeFg1Tfz/2I
 ErMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780614697; x=1781219497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=53eCSdM5/9myqcXLcdEsBbfYriv+6smkrhaDwhp6cx4=;
 b=LvIhHyXsMZkaxxSMbpdd0tQDrYZ+vJPU+VsMrwrq5qMezxw6TFVRyYmQ6FCfPnUiej
 A5R9W/HeX18/qbh5D5lNqvmnqmJBr4FMpywVvm038Ge7yQlMIXtQXen+dxgWJiqpjtaT
 PBk6liq6kSXieT5kjsl2b1v3kFLTXkaMAsGoal3ctpWLKysxcV2famDdo6h7aGfR9Aki
 C8wgJK7NQrfu+0bnlBR+vqcVYgPIA3GKrfN2YUIY0s8Vi8enVW2z6D7A7DNyK05E9t5z
 H8wUcc7euHcRymv+H1miGRqy3AEhni3CvO/1Dfif1T2jEYbfCoFbVt5qYgK1u/FWbNYm
 6ekA==
X-Gm-Message-State: AOJu0YxJwWGhcqneM62FYacDzJf/FySGTJF9cwLx372BY1BqnsBa4isa
 8rP4puEx3KvKovew7D4NtNHBrlCjy9XbPA+wgX2X6MsJ9KTb0iaiw1Bh/W29Ru02X9Hd+y+gMXF
 Ndkyngni8ZwfHNSf2HVIKiod5H8LvEuQc/VXV0SExX7RkHkaqBod/Mn9OJvG34Yw2xdimf5LBcH
 D9BYwNhd1TqM85wo9vb9+8pdd8/9jXUdYOcQhTdw==
X-Gm-Gg: Acq92OEHaERyV4Ufn+TsBSr9UpEOBsmLyYw6BQvFzRO4pnV6P4tS/F6kEPfVIMjMQsp
 TK3gsx2OsKZOjCyJkzQtxpJVDDlOdDHG+yz1XC//i3YMXMKVP7VW59+ipLWzZ9mYncXsG3XnClS
 vOWMcljQPB9kkwFk0E8uqaEYTjj46OKs/VQd+XgiaWcX04nc+b2xF77khnuLpN3ihIE3J3xjdfe
 TuWX1ocKqgukhZtWB7GGu2KcJLg+9PF7xeL5K26YuYPSQFaI/NnuLsB6IORuqeEP3NjlCicE608
 OiRfOFPIxCqSe12blXVUCu+QdsmpfBmW2yrynyfmN9MeSqdQG2bppocyQSRmrQADznyoIHyy596
 i2XcPYKG4W9U2aNmLh8aYPtA=
X-Received: by 2002:a05:620a:690d:b0:915:9f87:eae6 with SMTP id
 af79cd13be357-915a9da5824mr228195685a.42.1780614696964; 
 Thu, 04 Jun 2026 16:11:36 -0700 (PDT)
X-Received: by 2002:a05:620a:690d:b0:915:9f87:eae6 with SMTP id
 af79cd13be357-915a9da5824mr228182985a.42.1780614696173; 
 Thu, 04 Jun 2026 16:11:36 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a37cab6sm707617285a.22.2026.06.04.16.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:11:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Sana Sharma <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 4/4] migration: Remove dependency to TYPE_DEVICE
Date: Thu,  4 Jun 2026 19:11:18 -0400
Message-ID: <20260604231118.1584889-5-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604231118.1584889-1-peterx@redhat.com>
References: <20260604231118.1584889-1-peterx@redhat.com>
MIME-Version: 1.0
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

While doing that, we still want to keep the Property list that migration
object used to use.  Apply them directly to ObjectClass instead of setting
them with a DeviceClass.

Manually apply the two extra properties (compat properties, global
settings) in an instance_post_init() hook, just like most of the rest
users, see callers of object_apply_compat_props().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  2 +-
 migration/migration.c | 33 +++++++++++++++++++--------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 841f49b215..8bdb8e8e6b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -274,7 +274,7 @@ struct MigrationClass {
 
 struct MigrationState {
     /*< private >*/
-    DeviceState parent_obj;
+    Object parent_obj;
 
     /*< public >*/
     QemuThread thread;
diff --git a/migration/migration.c b/migration/migration.c
index 074d3f2c69..f9f102e78a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3966,11 +3966,9 @@ fail:
 
 static void migration_class_init(ObjectClass *klass, const void *data)
 {
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->user_creatable = false;
-    device_class_set_props_n(dc, migration_properties,
-                             migration_properties_count);
+    for (int i = 0; i < migration_properties_count; i++) {
+        object_class_add_property(klass, &migration_properties[i]);
+    }
 }
 
 static void migration_instance_finalize(Object *obj)
@@ -4028,21 +4026,28 @@ static bool migration_object_check(MigrationState *ms, Error **errp)
     return migrate_caps_check(old_caps, ms->capabilities, errp);
 }
 
-static const TypeInfo migration_type = {
-    .name = TYPE_MIGRATION,
+static void migration_instance_post_init(Object *obj)
+{
     /*
-     * NOTE: TYPE_MIGRATION is not really a device, as the object is
-     * not created using qdev_new(), it is not attached to the qdev
-     * device tree, and it is never realized.
+     * Apply these properties on top of default values:
      *
-     * TODO: Make this TYPE_OBJECT once QOM provides something like
-     * TYPE_DEVICE's "-global" properties.
+     * (1) machine compat properties
+     * (2) -global settings in cmdlines
+     *
+     * Need to be applied in order so (2) takes precedence over (1).
      */
-    .parent = TYPE_DEVICE,
+    object_apply_compat_props(obj);
+    object_apply_globals(obj);
+}
+
+static const TypeInfo migration_type = {
+    .name = TYPE_MIGRATION,
+    .parent = TYPE_OBJECT,
     .class_init = migration_class_init,
-    .class_size = sizeof(MigrationClass),
+    .class_size = sizeof(ObjectClass),
     .instance_size = sizeof(MigrationState),
     .instance_init = migration_instance_init,
+    .instance_post_init = migration_instance_post_init,
     .instance_finalize = migration_instance_finalize,
 };
 
-- 
2.53.0


