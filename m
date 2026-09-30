Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28EACA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrk8-0004FD-U1; Wed, 30 Sep 2026 06:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBriq-0001Ob-1V
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrih-0006mH-Kn
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9kexHToA4g8KAAOeKD2TikW0yeAiu0gVKdUWBf5nbY=;
 b=W7GsLACSXidRYQzoz1N0HYwZJSobxmsLXg1pPF3BftuLKiR0SihBQM6yNuRbh5rwjPUM16
 g7i8IH4KRGmAqDrf9+X2bEj0g+O7PJyKI2olY1X+bTzyJzywfPFJC5jrCuFFDYnKTTLYrf
 QKnqKqeIHF+w8rZZznGBFhMJ5l7Idc4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-yho9LXZEP-usrfvpdt4acA-1; Wed,
 30 Sep 2026 06:39:23 -0400
X-MC-Unique: yho9LXZEP-usrfvpdt4acA-1
X-Mimecast-MFC-AGG-ID: yho9LXZEP-usrfvpdt4acA_1790764762
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 982F1186FBB7; Wed, 30 Sep 2026 10:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52555195604E; Wed, 30 Sep 2026 10:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F8B021E677C; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 053/105] qapi: convert simple command intros for migration.json
Date: Wed, 30 Sep 2026 12:38:18 +0200
Message-ID: <20260930103910.3934848-54-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260901194324.458482-11-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 51 +++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 91681cdf03..1d4cdba5a0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -333,9 +333,9 @@
 
 ##
 # @query-migrate:
-#
-# Return information about current migration process.  If migration is
-# active there will be another json-object with RAM migration status.
+#     Return information about current migration process.  If
+#     migration is active there will be another json-object with RAM
+#     migration status.
 #
 # Since: 0.14
 #
@@ -825,8 +825,7 @@
 
 ##
 # @migrate-set-parameters:
-#
-# Set migration parameters.  All arguments are optional.
+#     Set migration parameters.  All arguments are optional.
 #
 # Since: 2.4
 #
@@ -1060,11 +1059,10 @@
 
 ##
 # @query-migrate-parameters:
-#
-# Return information about the current migration parameters.  Optional
-# members of the return value are always present, except
-# @block-bitmap-mapping, which is only present if it has been
-# previously set.
+#     Return information about the current migration parameters.
+#     Optional members of the return value are always present, except
+#     @block-bitmap-mapping, which is only present if it has been
+#     previously set.
 #
 # Since: 2.4
 #
@@ -1085,10 +1083,9 @@
 
 ##
 # @migrate-start-postcopy:
-#
-# Followup to a migration command to switch the migration to postcopy
-# mode.  The postcopy-ram capability must be set on both source and
-# destination before the original migration command.
+#     Followup to a migration command to switch the migration to
+#     postcopy mode.  The postcopy-ram capability must be set on both
+#     source and destination before the original migration command.
 #
 # Since: 2.5
 #
@@ -1235,12 +1232,11 @@
 
 ##
 # @x-colo-lost-heartbeat:
-#
-# Tell QEMU that heartbeat is lost, request it to do takeover
-# procedures.  If this command is sent to the PVM, the Primary side
-# will exit COLO mode.  If sent to the Secondary, the Secondary side
-# will run failover work, then takes over server operation to become
-# the service VM.
+#     Tell QEMU that heartbeat is lost, request it to do takeover
+#     procedures.  If this command is sent to the PVM, the Primary
+#     side will exit COLO mode.  If sent to the Secondary, the
+#     Secondary side will run failover work, then takes over server
+#     operation to become the service VM.
 #
 # Features:
 #
@@ -1455,9 +1451,8 @@
 
 ##
 # @migrate-incoming:
-#
-# Start an incoming migration.  QEMU must have been started with
-# -incoming defer.
+#     Start an incoming migration.  QEMU must have been started with
+#     -incoming defer.
 #
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
@@ -1527,9 +1522,8 @@
 
 ##
 # @xen-save-devices-state:
-#
-# Save the state of all devices to file.  The RAM and the block
-# devices of the VM are not saved by this command.
+#     Save the state of all devices to file.  The RAM and the block
+#     devices of the VM are not saved by this command.
 #
 # @filename: the file to save the state of the devices to as binary
 #     data.  See `xen-save-devices-state`.txt for a description of the
@@ -1567,9 +1561,8 @@
 
 ##
 # @xen-load-devices-state:
-#
-# Load the state of all devices from file.  The RAM and the block
-# devices of the VM are not loaded by this command.
+#     Load the state of all devices from file.  The RAM and the block
+#     devices of the VM are not loaded by this command.
 #
 # @filename: the file to load the state of the devices from as binary
 #     data.  See `xen-save-devices-state`.txt for a description of the
-- 
2.55.0


