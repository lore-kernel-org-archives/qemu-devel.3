Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F92EDE9A6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so41q-0007V4-AC; Tue, 10 Sep 2024 12:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41a-0006qf-SR
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41W-0007a1-FO
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Zdqqub+sWEXimNYFiEIiGuFYzmKpVqenGTfkuTRG8Q=;
 b=dXaTKnEjFnL0r+EfNJKY+I4HunfpJ4ptb/s9mYOVdvD+FcP0VLqAo30s0WKldJeMDZLrvA
 u3wB+WY5iwFCWBT4IpmbXkfs9usqXnmgiqb+SyTX7jKbdGLQa3pzCQbcbOmhA/t1PJOYJ6
 5Qm50ESq4jWDWijpHFTjelEWpKFSoSE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-I2gFaTf2OnqIVR15HPRgGg-1; Tue,
 10 Sep 2024 12:47:22 -0400
X-MC-Unique: I2gFaTf2OnqIVR15HPRgGg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F409819560A7; Tue, 10 Sep 2024 16:47:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 931FF19560AB; Tue, 10 Sep 2024 16:47:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AED2521E66E6; Tue, 10 Sep 2024 18:47:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/19] qapi/vfio: Rename VfioMigrationState to Qapi*,
 and drop prefix
Date: Tue, 10 Sep 2024 18:47:14 +0200
Message-ID: <20240910164714.1993531-20-armbru@redhat.com>
In-Reply-To: <20240910164714.1993531-1-armbru@redhat.com>
References: <20240910164714.1993531-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QAPI's 'prefix' feature can make the connection between enumeration
type and its constants less than obvious.  It's best used with
restraint.

VfioMigrationState has a 'prefix' that overrides the generated
enumeration constants' prefix to QAPI_VFIO_MIGRATION_STATE.

We could simply drop 'prefix', but then the enumeration constants
would look as if they came from kernel header linux/vfio.h.

Rename the type to QapiVfioMigrationState instead, so that 'prefix' is
not needed.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240904111836.3273842-20-armbru@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 qapi/vfio.json      | 9 ++++-----
 hw/vfio/migration.c | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/qapi/vfio.json b/qapi/vfio.json
index eccca82068..b53b7caecd 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -7,7 +7,7 @@
 ##
 
 ##
-# @VfioMigrationState:
+# @QapiVfioMigrationState:
 #
 # An enumeration of the VFIO device migration states.
 #
@@ -32,10 +32,9 @@
 #
 # Since: 9.1
 ##
-{ 'enum': 'VfioMigrationState',
+{ 'enum': 'QapiVfioMigrationState',
   'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
-            'pre-copy', 'pre-copy-p2p' ],
-  'prefix': 'QAPI_VFIO_MIGRATION_STATE' }
+            'pre-copy', 'pre-copy-p2p' ] }
 
 ##
 # @VFIO_MIGRATION:
@@ -63,5 +62,5 @@
   'data': {
       'device-id': 'str',
       'qom-path': 'str',
-      'device-state': 'VfioMigrationState'
+      'device-state': 'QapiVfioMigrationState'
   } }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 262d42a46e..17199b73ae 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -81,7 +81,7 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
     }
 }
 
-static VfioMigrationState
+static QapiVfioMigrationState
 mig_state_to_qapi_state(enum vfio_device_mig_state state)
 {
     switch (state) {
-- 
2.46.0


