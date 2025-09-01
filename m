Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F29CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3Ou-0001U1-Ef; Mon, 01 Sep 2025 08:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3OT-0001Ph-H8
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3OG-0006D1-7x
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=hYAt5OdegkmQavTKluTT3PGB4sCDDQMCHHmoN9ydOtE=;
 b=FOp9C8tALbvgmZWK1btvGZ3dGlKS+ZD3ZcFcjiXPt2JGbQ4+kCuDUhU2cw6GVrt0eOXmOx
 MfSKinxrQv7KcErGlI4uPMEoiCtRxunMrzaH2MW//MnlkTdE1aQTtooonBMdRdzAKD9xLS
 qkbBQ+zEC7pN3LRmz8sQz8K+U3IZftk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-_t7I7wyAOd6SUHEzYTBXMA-1; Mon,
 01 Sep 2025 08:11:56 -0400
X-MC-Unique: _t7I7wyAOd6SUHEzYTBXMA-1
X-Mimecast-MFC-AGG-ID: _t7I7wyAOd6SUHEzYTBXMA_1756728714
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 675AF1800357; Mon,  1 Sep 2025 12:11:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20DB7180028F; Mon,  1 Sep 2025 12:11:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 742B821E6925; Mon, 01 Sep 2025 14:11:51 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 01 Sep 2025 14:11:51 +0200
Resent-Message-ID: <87qzwq2wzc.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Sep  1 13:53:00 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A303221E6925; Mon, 01 Sep 2025 13:53:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 2/5] qtest/qom-test: Traverse entire QOM tree
Date: Mon,  1 Sep 2025 13:52:57 +0200
Message-ID: <20250901115300.2541937-3-armbru@redhat.com>
In-Reply-To: <20250901115300.2541937-1-armbru@redhat.com>
References: <20250901115300.2541937-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This test traverses the QOM sub-tree rooted at /machine.  Traverse the
entire tree instead.

The x86_64 test runs some 40 additional QMP commands, and stays under
5s for me.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250725135034.2280477-4-armbru@redhat.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/qom-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 7dea0d802d..a2db56bf22 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -211,7 +211,7 @@ static void test_machine(gconstpointer data)
 
     test_properties(qts, "/machine", true);
 
-    qlist_append_str(paths, "/machine");
+    qlist_append_str(paths, "/");
     test_list_get(qts, paths);
     test_list_get_value(qts);
 
-- 
2.49.0



