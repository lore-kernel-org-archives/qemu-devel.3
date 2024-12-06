Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3754BE7717D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 23:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJhRL-00031q-3D; Fri, 06 Dec 2024 18:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRJ-0002zy-2w
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRH-0005oW-27
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733526526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YeSfgc7Jyo9nB/kprDl4lAEUoTylMcAzUPDJAOUL/0Y=;
 b=QrETPzxfsPiPpl04J3ieuCEfn+05sl8TMxxL2kohQ7PHc3Wx/CuYOHDeUw/7YOIbfuEpyu
 RQinNp3tVR/N3THYxHPAzDhRumaYPZlfCNyFz55ca4gUSYnXkLsleIc31TtsJ3C3gcFkUr
 GW5+KKeJkEseyCH86fuDZ5Zxcc9wi2U=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-mEmT4ZSsMmmh76IKKtBB0w-1; Fri, 06 Dec 2024 18:08:44 -0500
X-MC-Unique: mEmT4ZSsMmmh76IKKtBB0w-1
X-Mimecast-MFC-AGG-ID: mEmT4ZSsMmmh76IKKtBB0w
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-8418612c3b5so233686039f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 15:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733526523; x=1734131323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeSfgc7Jyo9nB/kprDl4lAEUoTylMcAzUPDJAOUL/0Y=;
 b=LS91gTDPlvKmYNImtUS3rcTYEbqbuD0ivo7Bh+4a6KEFXedDk938sSTR1anCNJjdzf
 4tVJQnjWEDsVKhpao2qqTfP+ZPPAfxfvteptIKutedHMG8N7R5bcppFOidRuJ1/jJzmu
 /8VIxG9/M+ThmT3SkVZEvw99hoeX3VBDDyKe+/ZADM3U3AbSpBxvAyAkV+GUFAINq4GY
 gmwF0xF83Pyl53uALi0QIy6WKabZk7kJk0OXYQy39GW3itHbKjJ33HgZpw3iHYoPOqqI
 4a2JJN6p9p/rBqg83oajqpt6RJpReEV9Y5AUmas7BSEFsokkn3pD/3UkvEOGZuhWKIwW
 F4ow==
X-Gm-Message-State: AOJu0YyJhhpop7PKi8cDidauG3x2raVmFEQTHp6YmhUmgV04BgM9DH45
 rnaLGxG/xKvKjQ1EBZS5gPDVy0QdtObbtdMIsyLOYsMBw06azkaY3rsIDiNGtTeG1bpJxPiAiu/
 pc/ogCuDQ1j+1OBbW2eRllvc/yJhx7dQb0CrjPIQuye/drqpiCFpRGMepzGb9NCyYFZ+MHK/ZxU
 VF5pqFI9gBG+sQ/NAVs5tFGEWSVzxBQUHwkg==
X-Gm-Gg: ASbGncv1j1rns5hEZMEXqnglEIlCHwuys3YApoKq/HWiYFUF9VbWRw1jr0LUyL6o4lS
 cc9GJl1vKMPZ3d4/TrEAPwnWJB2r6EnW2VlOO+w1x347tqlGNnB9n7CMiGUnXM/yRZKDCa13IHN
 vJWezvGE7m1C8se8mvug2eACg5HDw+XQt3uiJ8RTL3Sf/jOWhfreUR+eIhdo6pG0zkwXFxljZhG
 JAYiBxXFy4d3JPvYgUd98p5ANKzPSdFR1t7L87j6SAjYAnjazx7f3wbz7eovHcLoO3WfrJ8mP9Z
 LpejSZgEbN9PdDlipJUbam7OBA==
X-Received: by 2002:a05:6e02:1c43:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3a811dae3b7mr61956095ab.1.1733526522842; 
 Fri, 06 Dec 2024 15:08:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtpW+lr+3gAKOHU9LGhBgNRJRDHf+1H5T+17CLUh7VcjL60p2b8j+a/CiPIF24GgDa2oiXIw==
X-Received: by 2002:a05:6e02:1c43:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3a811dae3b7mr61955835ab.1.1733526522455; 
 Fri, 06 Dec 2024 15:08:42 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d9a8dsm1038895173.86.2024.12.06.15.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 15:08:41 -0800 (PST)
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
Subject: [PATCH v2 1/6] migration: Add helper to get target runstate
Date: Fri,  6 Dec 2024 18:08:33 -0500
Message-ID: <20241206230838.1111496-2-peterx@redhat.com>
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

In 99% cases, after QEMU migrates to dest host, it tries to detect the
target VM runstate using global_state_get_runstate().

There's one outlier so far which is Xen that won't send global state.
That's the major reason why global_state_received() check was always there
together with global_state_get_runstate().

However it's utterly confusing why global_state_received() has anything to
do with "let's start VM or not".

Provide a helper to explain it, then we have an unified entry for getting
the target dest QEMU runstate after migration.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c..d2a6b939cf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -135,6 +135,21 @@ static bool migration_needs_multiple_sockets(void)
     return migrate_multifd() || migrate_postcopy_preempt();
 }
 
+static RunState migration_get_target_runstate(void)
+{
+    /*
+     * When the global state is not migrated, it means we don't know the
+     * runstate of the src QEMU.  We don't have much choice but assuming
+     * the VM is running.  NOTE: this is pretty rare case, so far only Xen
+     * uses it.
+     */
+    if (!global_state_received()) {
+        return RUN_STATE_RUNNING;
+    }
+
+    return global_state_get_runstate();
+}
+
 static bool transport_supports_multi_channels(MigrationAddress *addr)
 {
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
@@ -735,8 +750,7 @@ static void process_incoming_migration_bh(void *opaque)
      * unless we really are starting the VM.
      */
     if (!migrate_late_block_activate() ||
-         (autostart && (!global_state_received() ||
-            runstate_is_live(global_state_get_runstate())))) {
+        (autostart && runstate_is_live(migration_get_target_runstate()))) {
         /* Make sure all file formats throw away their mutable metadata.
          * If we get an error here, just don't restart the VM yet. */
         bdrv_activate_all(&local_err);
@@ -759,8 +773,7 @@ static void process_incoming_migration_bh(void *opaque)
 
     dirty_bitmap_mig_before_vm_start();
 
-    if (!global_state_received() ||
-        runstate_is_live(global_state_get_runstate())) {
+    if (runstate_is_live(migration_get_target_runstate())) {
         if (autostart) {
             vm_start();
         } else {
-- 
2.47.0


