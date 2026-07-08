Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CBCC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whSyP-0005qN-9c; Wed, 08 Jul 2026 10:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whSyN-0005qF-Ih
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:09:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whSyK-0004f1-Uo
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783519794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7T7fAKQvwRTo/C7bIfMBAGKEINEq0dDM9mTl6VaQ5BM=;
 b=XuLkLMlmXopjWA9inKnD06/VMyi43NMMRrV3gUWnpHQv20bbth+55Nl7mnQ69+s+t+m5Gr
 s6BWLJ0MFYTwbOZPgyrhAjXjdK8FPz/FzEBvaZ0AWGVMG7mGUtqLIbhboWVp7ACLBr+MzX
 kChAfrDWEjR3gaQH6sKnDFGJFyoCzS4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-xRS0A_N1NY6-eUmO67wctw-1; Wed,
 08 Jul 2026 10:09:52 -0400
X-MC-Unique: xRS0A_N1NY6-eUmO67wctw-1
X-Mimecast-MFC-AGG-ID: xRS0A_N1NY6-eUmO67wctw_1783519792
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D842A180047F
 for <qemu-devel@nongnu.org>; Wed,  8 Jul 2026 14:09:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97F743EEDE
 for <qemu-devel@nongnu.org>; Wed,  8 Jul 2026 14:09:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3CD821E6920; Wed, 08 Jul 2026 16:09:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH] qom: Fix device-list-properties & friends to show legacy-FOO
 props
Date: Wed,  8 Jul 2026 16:09:48 +0200
Message-ID: <20260708140948.2622814-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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


