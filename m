Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C36EC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 06:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHdCv-00084i-JC; Wed, 21 May 2025 02:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHdCc-00080t-JM
 for qemu-devel@nongnu.org; Wed, 21 May 2025 02:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHdCY-0002tQ-W0
 for qemu-devel@nongnu.org; Wed, 21 May 2025 02:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747809915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZN/ywnWRQxirZwjG+Hq28J1iTV7enZxRL7cjhSPRM4I=;
 b=hVJg2Swln3qhqiLwYq5jmlcNWxt7Ktp/PAhgE56SoBXI3yYlZqd3g3eJP11xdw/v8T/29m
 msgTmkYFwXQJcdWOVdSjSmLDrBeoe/D5wvf3K8jxXiPn/x9bPyHP+JS4H3RH0Gzkuf2uUm
 o0arz5XhryAOHmkKS04EnHtFboCZ4HI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-_v2KEIJtMBCadncfWfyGZw-1; Wed,
 21 May 2025 02:45:14 -0400
X-MC-Unique: _v2KEIJtMBCadncfWfyGZw-1
X-Mimecast-MFC-AGG-ID: _v2KEIJtMBCadncfWfyGZw_1747809913
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8422C19560A7; Wed, 21 May 2025 06:45:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 264C81956095; Wed, 21 May 2025 06:45:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A2B121E65D0; Wed, 21 May 2025 08:37:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 2/4] qapi/migration: Deprecate migrate argument @detach
Date: Wed, 21 May 2025 08:37:09 +0200
Message-ID: <20250521063711.29840-3-armbru@redhat.com>
In-Reply-To: <20250521063711.29840-1-armbru@redhat.com>
References: <20250521063711.29840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Argument @detach has always been ignored.  Start the clock to get rid
of it.

Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/about/deprecated.rst |  5 +++++
 qapi/migration.json       | 18 +++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 9665bc6fcf..ef4ea84e69 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -179,6 +179,11 @@ Use ``job-dismiss`` instead.
 
 Use ``job-finalize`` instead.
 
+``migrate`` argument ``detach`` (since 10.1)
+''''''''''''''''''''''''''''''''''''''''''''
+
+This argument has always been ignored.
+
 ``query-migrationthreads`` (since 9.2)
 ''''''''''''''''''''''''''''''''''''''
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 8b9c53595c..ecd266f98e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1660,6 +1660,10 @@
 #
 # @resume: resume one paused migration, default "off".  (since 3.0)
 #
+# Features:
+#
+# @deprecated: Argument @detach is deprecated.
+#
 # Since: 0.14
 #
 # .. admonition:: Notes
@@ -1668,19 +1672,14 @@
 #        migration's progress and final result (this information is
 #        provided by the 'status' member).
 #
-#     2. All boolean arguments default to false.
-#
-#     3. The user Monitor's "detach" argument is invalid in QMP and
-#        should not be used.
-#
-#     4. The uri argument should have the Uniform Resource Identifier
+#     2. The uri argument should have the Uniform Resource Identifier
 #        of default destination VM.  This connection will be bound to
 #        default network.
 #
-#     5. For now, number of migration streams is restricted to one,
+#     3. For now, number of migration streams is restricted to one,
 #        i.e. number of items in 'channels' list is just 1.
 #
-#     6. The 'uri' and 'channels' arguments are mutually exclusive;
+#     4. The 'uri' and 'channels' arguments are mutually exclusive;
 #        exactly one of the two should be present.
 #
 # .. qmp-example::
@@ -1724,7 +1723,8 @@
 { 'command': 'migrate',
   'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
-           '*detach': 'bool', '*resume': 'bool' } }
+           '*detach': { 'type': 'bool', 'features': [ 'deprecated' ] },
+           '*resume': 'bool' } }
 
 ##
 # @migrate-incoming:
-- 
2.48.1


