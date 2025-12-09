Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB86CD3B981
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0bq-0008WO-DR; Tue, 09 Dec 2025 11:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aa-0006Ii-4H
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aX-00028O-Pq
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765297761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNWCsudpDn8DQvfONwxl/IRDmiiY9UgHCPTpZhM5kqI=;
 b=RBS8sEgg+avRvK+RMX9i0rBsNlfaxY3B9Dj+QJOFRiA44X+e6djN5pMZr7+iEGUftVVs8q
 DaADwCLIlUvVMSqa808KOz99XdhHwLgOa2NV2+w4mMiPUWw6UgITKaO5RjB0m6h9jqqqWG
 +TqECQO7TIZ+Q8LD93q72xk667BTwqY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-VQc_3rGIM_27XP4M3epLSA-1; Tue, 09 Dec 2025 11:29:19 -0500
X-MC-Unique: VQc_3rGIM_27XP4M3epLSA-1
X-Mimecast-MFC-AGG-ID: VQc_3rGIM_27XP4M3epLSA_1765297759
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ee1b7293e7so187091531cf.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765297759; x=1765902559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNWCsudpDn8DQvfONwxl/IRDmiiY9UgHCPTpZhM5kqI=;
 b=eLzJ+AkqzFOcLUgIR9hHsKrgDkeLzORlrKQ6bcbCtHJPDzRxuP5bNWUmE2D3P69zUL
 RKg8z9VoJR1v74q6cede2GjwYACTA2+eMgOhtpPyWBX9h1ehSXtlgP6vKA6/SQf1wX9o
 R/Tgw0pcix88+psXAvKvjmfdK4Ul5JoAX4v7kpUdio5kkYr+PLzNmFzgi9oyqmWZGwNV
 yYzbqsXMj5u8JR++vNs+DjRPzzlQLz2kIgdGMChaH2XBIm6aezIrU64TiAsx9nUJPsFn
 kuXerbexvnKPfrkWtBfiqQAUI8g8BdnXmQWBbVGuVy63ZQsVlA4gMCB7NIp66Y5+YRyl
 cDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297759; x=1765902559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XNWCsudpDn8DQvfONwxl/IRDmiiY9UgHCPTpZhM5kqI=;
 b=B/8s+EduHMdRR7+ztnz5IJIWSG9mqiq69iuDpsl6j/yw9yDeI6vunNRZidYCEuIpA+
 Wnhd9AyR/1OREku6zzWZBPyT+BxoBOGTrEk9IyTT5menbWViTQOFAQwP6LzTHw8nbrM8
 C3FMC+uUNsI1XNPqhyQtdp/z8fI76EdRI+scwXFkIJTBrr9kuxPGiTzrhWRGZ7pHvuCZ
 ql6oh28Z4hru2RYh6sJltjOqjrKVzJQ1zecvTkkCA4tBAC240FLHWfp6RxlHAuKFbzLH
 x2S0qijwiVPdd5SUL7uSHGS0EkwOlXeGMJIVo2KytmxFGFXMfMq644QwTk1S9Ki1xhPt
 ZiFA==
X-Gm-Message-State: AOJu0YzgAmR1Ud+MsHqmJ00/wfJT41NaPW1RDUAqI+FzgMLLDrQJvEvG
 mvlNiC83AeZw+hCfKkO9ROGxELfoBvA/5LJpOEKzmHzNAIW9Nr5sNBLsh3kkFCC7rMOxkCWaDdG
 04K9SpUC29i+fOP7DTyCqzOwUrd7vjmh44hkNHsxKFlBXZDeicIk6txxj4jy6puVlM6d8hSzspt
 RewHTqXcdhYQ5Fb5UfmtPdj9j5Ekjz3uMDrZZk8A==
X-Gm-Gg: ASbGnctroAj7OPLRXNlltPkzpnphNcmzhrynBhrTKD11NhHEqaMts5Hig+LqglB6xrM
 CHwtLkBmpRQiyI8sPT//P7KyBt/61BjfO++Q+FG/kWXFywMNTHmMJmvzlMtKOuREMm7kKd0cg11
 vXwGW0OctUAEh4mY9OrvDCdx4hZkgmQ/eyjqX7tv7y1ffFPUCA8Pt8fm9b+LZG/uSV66NxYS+8l
 vBswHhVc6qspN0ekunT1owk6WwQ+jKjb/9tJPF9zipgKv/b/87PS2AVDsTZprZRMjUiQ7VmPEBY
 yJ92INFe98vbB7rwkYAZMBnBpD2XgZ9Zrnxbp9cnCvr93f7fz12M7WIJ9BumOkGQ6gFScFJOOpE
 un3Y=
X-Received: by 2002:a05:622a:4c05:b0:4ee:1625:f783 with SMTP id
 d75a77b69052e-4f03fd9b08amr189080491cf.21.1765297758900; 
 Tue, 09 Dec 2025 08:29:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBdPSDuC0vCxsc7QJAX1EVzz5tFJxDcqgwLRLVgeNAzR4QiJAjVcnDZSAQO3M+BsfVcgnRSQ==
X-Received: by 2002:a05:622a:4c05:b0:4ee:1625:f783 with SMTP id
 d75a77b69052e-4f03fd9b08amr189079561cf.21.1765297758366; 
 Tue, 09 Dec 2025 08:29:18 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f334d8sm131110256d6.10.2025.12.09.08.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:29:17 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH RFC 10/10] migration: Inherit from TYPE_OBJECT_COMPAT
Date: Tue,  9 Dec 2025 11:28:57 -0500
Message-ID: <20251209162857.857593-11-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209162857.857593-1-peterx@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
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

While doing that, we still want to keep the Property list that migration
object used to use.  Apply them directly to ObjectClass instead of setting
them with a DeviceClass.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  2 +-
 migration/migration.c | 31 ++++++++++++++++---------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 213b33fe6e..20a76664df 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -273,7 +273,7 @@ struct MigrationClass {
 
 struct MigrationState {
     /*< private >*/
-    DeviceState parent_obj;
+    Object parent_obj;
 
     /*< public >*/
     QemuThread thread;
diff --git a/migration/migration.c b/migration/migration.c
index b316ee01ab..913c005bcb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4136,11 +4136,9 @@ fail:
 
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
@@ -4198,21 +4196,24 @@ static bool migration_object_check(MigrationState *ms, Error **errp)
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
-     *
-     * TODO: Make this TYPE_OBJECT once QOM provides something like
-     * TYPE_DEVICE's "-global" properties.
+     * Note: ordered so that the user's global properties take
+     * precedence over compat properties.  Compat-properties will be
+     * applied first in the parent class (TYPE_OBJECT_COMPAT).
      */
-    .parent = TYPE_DEVICE,
+    object_apply_globals(obj);
+}
+
+static const TypeInfo migration_type = {
+    .name = TYPE_MIGRATION,
+    .parent = TYPE_OBJECT_COMPAT,
     .class_init = migration_class_init,
-    .class_size = sizeof(MigrationClass),
+    .class_size = sizeof(ObjectClass),
     .instance_size = sizeof(MigrationState),
     .instance_init = migration_instance_init,
+    .instance_post_init = migration_instance_post_init,
     .instance_finalize = migration_instance_finalize,
 };
 
-- 
2.50.1


