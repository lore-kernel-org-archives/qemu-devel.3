Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D23CD185EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 12:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpY2-0001uy-HJ; Thu, 08 Jan 2026 07:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdpXx-0001uG-3l
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:55:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdpXu-0005LG-5L
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767876921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eOHTmsngTX/h/fzMLmGrM+0LJo6gOgPawHYtAV0OeaE=;
 b=i1sxo8MlhP9jmv+Mfl/6/4po69TdWhwT4cggn7n1dgYdkHV0FhnBwHZ0NGVc/lxmq0V4Jd
 AvOBR6+PdMMcbxrq92NgrgC9XY+1mWwiBbCSeqL1YepYE94f+Ng/18lnEeuY4zdWFUyzCC
 AoV/Pe3V68xeK2tiT1OhnWYK/BisNaw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-Syf0byNeNeqju8TuVy7-mQ-1; Thu,
 08 Jan 2026 07:55:17 -0500
X-MC-Unique: Syf0byNeNeqju8TuVy7-mQ-1
X-Mimecast-MFC-AGG-ID: Syf0byNeNeqju8TuVy7-mQ_1767876916
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C16821956050; Thu,  8 Jan 2026 12:55:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E78519560A2; Thu,  8 Jan 2026 12:55:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DFB3521E61AA; Thu, 08 Jan 2026 13:55:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, devel@lists.libvirt.org,
 eblake@redhat.com
Subject: [PATCH 2/2] migration: Drop deprecated QMP migrate argument @detach
Date: Thu,  8 Jan 2026 13:55:12 +0100
Message-ID: <20260108125512.2234147-3-armbru@redhat.com>
In-Reply-To: <20260108125512.2234147-1-armbru@redhat.com>
References: <20260108125512.2234147-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Deprecated in commit c2fb6eaeb9d4 (qapi/migration: Deprecate migrate
argument @detach), v10.1.0.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/about/deprecated.rst       | 5 -----
 docs/about/removed-features.rst | 5 +++++
 qapi/migration.json             | 8 --------
 migration/migration-hmp-cmds.c  | 2 +-
 migration/migration.c           | 2 +-
 5 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e9b019b41c..b53d885533 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -142,11 +142,6 @@ Use ``job-dismiss`` instead.
 
 Use ``job-finalize`` instead.
 
-``migrate`` argument ``detach`` (since 10.1)
-''''''''''''''''''''''''''''''''''''''''''''
-
-This argument has always been ignored.
-
 Human Machine Protocol (HMP) commands
 -------------------------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 9e5a4dcbac..5eee371f5f 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -760,6 +760,11 @@ without reporting any destination threads, or non-multifd source
 threads).  For debugging purpose, please use ``-name
 $VM,debug-threads=on`` instead.
 
+``migrate`` argument ``detach`` (since 11.0)
+''''''''''''''''''''''''''''''''''''''''''''
+
+This argument has always been ignored.
+
 QEMU Machine Protocol (QMP) events
 ----------------------------------
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 7bd24e66e9..c99ae433e0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1397,19 +1397,12 @@
 # @channels: list of migration stream channels with each stream in the
 #     list connected to a destination interface endpoint.
 #
-# @detach: this argument exists only for compatibility reasons and is
-#     ignored by QEMU
-#
 # @resume: when set, use the new uri/channels specified to resume
 #     paused postcopy migration.  This flag should only be used if
 #     the previous postcopy migration was interrupted.  The command
 #     will fail unless migration is in "postcopy-paused" state.
 #     (default: false, since 3.0)
 #
-# Features:
-#
-# @deprecated: Argument @detach is deprecated.
-#
 # Since: 0.14
 #
 # .. admonition:: Notes
@@ -1469,7 +1462,6 @@
 { 'command': 'migrate',
   'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
-           '*detach': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*resume': 'bool' } }
 
 ##
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a2863e6a2f..0a193b8f54 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -829,7 +829,7 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate(NULL, true, caps, false, false, true, resume, &err);
+    qmp_migrate(NULL, true, caps, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 94ade36574..42eaceb38a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2203,7 +2203,7 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
 }
 
 void qmp_migrate(const char *uri, bool has_channels,
-                 MigrationChannelList *channels, bool has_detach, bool detach,
+                 MigrationChannelList *channels,
                  bool has_resume, bool resume, Error **errp)
 {
     bool resume_requested;
-- 
2.52.0


