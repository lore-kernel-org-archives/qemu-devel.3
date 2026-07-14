Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA21C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZGJ-00041O-Jn; Tue, 14 Jul 2026 05:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjZGI-00040j-03
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjZGG-0006iE-1h
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784020625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ZCmfwn/7wgSvdA0lQAipufR6HwrM9C/L7ilVDnG0b4=;
 b=bDubft1I4WCDqk3Wn0OjbNsW+gGt4lSnR2clh70k/7dWqJPf7xFerUSQWlKeRXWkD7HtM0
 1qAAIheZ7xEsh1yzu1GUdkMerhBt9vx7yoiinDcaIvUY8sA98EsFWUfY/+JZgSJ6gLfK4V
 UBnBoPhNIqlWZ6Zu1LGtMVQBpie4i2c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-jQJYY2hFNuKnMaRCOZsriQ-1; Tue,
 14 Jul 2026 05:17:04 -0400
X-MC-Unique: jQJYY2hFNuKnMaRCOZsriQ-1
X-Mimecast-MFC-AGG-ID: jQJYY2hFNuKnMaRCOZsriQ_1784020623
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77AB218005A3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:17:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 353D5195608A
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:17:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7DE9B21E6931; Tue, 14 Jul 2026 11:17:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 2/4] qom: Fix device-list-properties & friends to show
 legacy-FOO props
Date: Tue, 14 Jul 2026 11:16:58 +0200
Message-ID: <20260714091700.3797064-3-armbru@redhat.com>
In-Reply-To: <20260714091700.3797064-1-armbru@redhat.com>
References: <20260714091700.3797064-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

qmp_device_list_properties() skips properties whose name starts with
"legacy-".  This is a flawed test for "is a legacy property".

The test is flawed because non-legacy properties can and do start with
"legacy-".  Back when it was added, no such properties existed.  Right
now, three such properties do: property "legacy-cmb" of device "nvme",
and properties "legacy-cache" and "legacy-multi-node" of devices
"x86_64-cpu", "i386-cpu", and its children.

This affects QMP command "device-list-properties", HMP command
"device_add T,help", and command line option "-device T,help".

Legacy properties are gone since commit a61383f7ab (qdev: Legacy
properties are now unused internally, drop, 2025-10-22).  This makes
the fix easy: delete the code that skips them.

Reproducer: -device nvme,help doesn't show legacy-cmb before the
patch, and does after.

Fixes: f4eb32b590 (qmp: show QOM properties in device-list-properties, 2014-05-20)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260708140948.2622814-1-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/qom-qmp-cmds.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 48b38d2b7f..330895361d 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -218,13 +218,6 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
             continue;
         }
 
-        /* Skip legacy properties since they are just string versions of
-         * properties that we already list.
-         */
-        if (strstart(prop->name, "legacy-", NULL)) {
-            continue;
-        }
-
         info = g_new0(ObjectPropertyInfo, 1);
         info->name = g_strdup(prop->name);
         info->type = g_strdup(prop->type);
-- 
2.54.0


