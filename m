Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77BBE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 23:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJhRN-00032c-6F; Fri, 06 Dec 2024 18:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRL-00031p-1g
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRJ-0005pD-Ia
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733526529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bj8MGswrXWKOgEfQ2x9IDB2aXSksN2FVHW5jduhyU+Q=;
 b=A8r04v2/BpN4jrt1Il3eSaFeoIzXc9dg6zDOTeqaSIMX335/JdMZ9nDxVOg8CyTTC2Nn9I
 mPxTYstsBPmFGCBwDZ+A9o9oTFtcI8Gu7+Em3MkyAPlVXVbJ4SE4Hn8Dv9p5380J4Fw54U
 /zU2+lz/7RUBMZFAMFQBoG87WnPn4yg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-hli23DxeNsWWZEWRLgWGpA-1; Fri, 06 Dec 2024 18:08:47 -0500
X-MC-Unique: hli23DxeNsWWZEWRLgWGpA-1
X-Mimecast-MFC-AGG-ID: hli23DxeNsWWZEWRLgWGpA
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-843eac1b9dbso231716439f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 15:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733526526; x=1734131326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bj8MGswrXWKOgEfQ2x9IDB2aXSksN2FVHW5jduhyU+Q=;
 b=IZqpu3qqvPRZUJGZvYGcgGS+UStqeuJ2G6mUCMdkSWcQfKekrSUGhTaLg4XkXmi8+X
 a1VNQZKjT4qPSc7mdPVT2eT4tJ7rpSQlyPlBn0hkcLFoOqCGRK2PM/olYpLZ8WaymTzn
 dlN7QR0N3PAdlo50y12QFNDn3RgxKjjUB1RndUcAOi4aSsb4dgE+OneL8lo430kLwzvJ
 DJcWmeNcMw/Sg2ubihfAoNP1djkteLG4ERaEGUrJXKPNIzgXsr/sUagw4yOiMWBdNXVU
 xYlzPeAMdJiqbNDjNmsnsZsCDBJeX5+9dwipCSk5UphbYm4OhOVJ5eYh2wJU39McDKjE
 x5Mw==
X-Gm-Message-State: AOJu0YyObsqsF8lEBbr/VVkF4XShSnXMZVrWg2j9vuk8sceyBOseaMVa
 P9k+xO8JiJzNl0HXs5SVdi8Xjs5vPmq+Kz+zy5KN478UvMBJI3AOv7OPlE7AsQXq2fFYlBYWLoc
 Yx54pImf7GVYaGRSgK6UfDphzjzJLnhUb6+AIaROp5f09qvtjDJvm9ynGOwQ/LUjUmNeSI7lERz
 uA551Yh22uUYDoISkAbc2lJc9b4gP1Nr9eZw==
X-Gm-Gg: ASbGnct361u5/QFvrSUzSrSgBn9Aln12cWPLhoZdZj64ayBV/TUH3DcK1GpNhBBAY/E
 X7qljPCOXeysiIk9uD+5z0BL6WvmwTW4QLZuchnhgwMYfpSSW3YNTXzPZAce8G0eMk5fXFWXT31
 /gnBLzAlCW//5tjlKLyKy0UyQV5gzu0nIEIQpcEjKIvRIcbd3cJVH1WPyx1KbJ540HVyG1Z5T3M
 FGJUSniiebwPRcrdp8N9A4pL5F1MTn8QOC5tXXCA/KupjHDglOdN++n2rErgFOo4MiyrvtH+NCa
 k0FDd6cZt8VK6j5bzSjDnlUQuA==
X-Received: by 2002:a05:6e02:1c43:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3a811dae3b7mr61957695ab.1.1733526526336; 
 Fri, 06 Dec 2024 15:08:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwTFoqMI0boqnnrTCMSIJ/MaBO3VmAH2bAWjST7Ns0G37MN56nMw+NdMUHYywLIoKDyN2qlQ==
X-Received: by 2002:a05:6e02:1c43:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3a811dae3b7mr61957445ab.1.1733526526004; 
 Fri, 06 Dec 2024 15:08:46 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d9a8dsm1038895173.86.2024.12.06.15.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 15:08:44 -0800 (PST)
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
Subject: [PATCH v2 3/6] migration/block: Make late-block-active the default
Date: Fri,  6 Dec 2024 18:08:35 -0500
Message-ID: <20241206230838.1111496-4-peterx@redhat.com>
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

Migration capability 'late-block-active' controls when the block drives
will be activated.  If enabled, block drives will only be activated until
VM starts, either src runstate was "live" (RUNNING, or SUSPENDED), or it'll
be postponed until qmp_cont().

Let's do this unconditionally.  There's no harm to delay activation of
block drives.  Meanwhile there's no ABI breakage if dest does it, because
src QEMU has nothing to do with it, so it's no concern on ABI breakage.

IIUC we could avoid introducing this cap when introducing it before, but
now it's still not too late to just always do it.  Cap now prone to
removal, but it'll be for later patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d2a6b939cf..e6db9cfc50 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -743,24 +743,6 @@ static void process_incoming_migration_bh(void *opaque)
 
     trace_vmstate_downtime_checkpoint("dst-precopy-bh-enter");
 
-    /* If capability late_block_activate is set:
-     * Only fire up the block code now if we're going to restart the
-     * VM, else 'cont' will do it.
-     * This causes file locking to happen; so we don't want it to happen
-     * unless we really are starting the VM.
-     */
-    if (!migrate_late_block_activate() ||
-        (autostart && runstate_is_live(migration_get_target_runstate()))) {
-        /* Make sure all file formats throw away their mutable metadata.
-         * If we get an error here, just don't restart the VM yet. */
-        bdrv_activate_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            local_err = NULL;
-            autostart = false;
-        }
-    }
-
     /*
      * This must happen after all error conditions are dealt with and
      * we're sure the VM is going to be running on this host.
@@ -775,7 +757,25 @@ static void process_incoming_migration_bh(void *opaque)
 
     if (runstate_is_live(migration_get_target_runstate())) {
         if (autostart) {
-            vm_start();
+            /*
+             * Block activation is always delayed until VM starts, either
+             * here (which means we need to start the dest VM right now..),
+             * or until qmp_cont() later.
+             *
+             * We used to have cap 'late-block-activate' but now we do this
+             * unconditionally, as it has no harm but only benefit.  E.g.,
+             * it's not part of migration ABI on the time of disk activation.
+             *
+             * Make sure all file formats throw away their mutable
+             * metadata.  If error, don't restart the VM yet.
+             */
+            bdrv_activate_all(&local_err);
+            if (local_err) {
+                error_report_err(local_err);
+                local_err = NULL;
+            } else {
+                vm_start();
+            }
         } else {
             runstate_set(RUN_STATE_PAUSED);
         }
-- 
2.47.0


