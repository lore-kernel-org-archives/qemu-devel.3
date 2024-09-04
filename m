Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6F1CA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 11:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slo8V-0005Y8-SZ; Wed, 04 Sep 2024 07:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1slo8T-0005Ok-Oc
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1slo8S-0004SH-5E
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725449115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krwGcnbmK4mJojLce1YySOaQMl7POMJC2LkjDvFBIHA=;
 b=d2akJHkPL1RufPEo71FUHvIjBBTneXN3mWonxJhXzWJlmIFB/wOpY0QZVyP2w8Vj5inJ82
 AtbET9WYeVw0iQ0cnN/GE3jaWGZ8vWtH+rW5X9rDBgixMwgQlyfzZUd3cKD7Z7PAGeEaWO
 /a8apITDF7L7ZWff2rZJySbvTRtq854=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-UFBGwjXIN7CxdUb05skooA-1; Wed,
 04 Sep 2024 07:18:52 -0400
X-MC-Unique: UFBGwjXIN7CxdUb05skooA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEBEF19560B2; Wed,  4 Sep 2024 11:18:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F7FE1955F44; Wed,  4 Sep 2024 11:18:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E475921E66CD; Wed,  4 Sep 2024 13:18:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berrange@redhat.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com, den@openvz.org,
 eblake@redhat.com, eduardo@habkost.net, farman@linux.ibm.com,
 farosas@suse.de, hreitz@redhat.com, idryomov@gmail.com, iii@linux.ibm.com,
 jamin_lin@aspeedtech.com, jasowang@redhat.com, joel@jms.id.au,
 jsnow@redhat.com, kwolf@redhat.com, leetroy@gmail.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 michael.roth@amd.com, mst@redhat.com, mtosatti@redhat.com,
 nsg@linux.ibm.com, pasic@linux.ibm.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org,
 pizhenwei@bytedance.com, pl@dlhnet.de, richard.henderson@linaro.org,
 stefanha@redhat.com, steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 avihaih@nvidia.com
Subject: [PATCH v2 19/19] qapi/vfio: Rename VfioMigrationState to Qapi*,
 and drop prefix
Date: Wed,  4 Sep 2024 13:18:36 +0200
Message-ID: <20240904111836.3273842-20-armbru@redhat.com>
In-Reply-To: <20240904111836.3273842-1-armbru@redhat.com>
References: <20240904111836.3273842-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


