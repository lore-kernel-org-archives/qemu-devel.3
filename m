Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77073C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufIsP-0006P7-GR; Fri, 25 Jul 2025 09:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ufIou-0008WL-Ho
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ufIos-0005ai-PD
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753451441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4POndAMoFNWfMRjRqyc8AFnihTJrFXzP2n4vSATUpM=;
 b=H4tSCQ6dOE0Tj0kGsba2LCiZCfZ+rhsCytSOLZZ2UiXVRDgAJN6Th4RlWovSodJDS8offn
 9qHoTi3Qeh10AUdkbFsuCfFY9cVOL3OX+ladmnOVIdGqTRdq3Gqm90aBfquYM85MUjfSET
 ZOA/wwXgEnfJg75z8si8YE25NBl9RLg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-7szoZeM0Mlem5ao7K-ZV8Q-1; Fri,
 25 Jul 2025 09:50:38 -0400
X-MC-Unique: 7szoZeM0Mlem5ao7K-ZV8Q-1
X-Mimecast-MFC-AGG-ID: 7szoZeM0Mlem5ao7K-ZV8Q_1753451437
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06A831944CC6; Fri, 25 Jul 2025 13:50:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95418300018D; Fri, 25 Jul 2025 13:50:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2298A21E6935; Fri, 25 Jul 2025 15:50:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 steven.sistare@oracle.com
Subject: [PATCH 3/5] qtest/qom-test: Traverse entire QOM tree
Date: Fri, 25 Jul 2025 15:50:32 +0200
Message-ID: <20250725135034.2280477-4-armbru@redhat.com>
In-Reply-To: <20250725135034.2280477-1-armbru@redhat.com>
References: <20250725135034.2280477-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This test traverses the QOM sub-tree rooted at /machine.  Traverse the
entire tree instead.

The x86_64 test runs some 40 additional QMP commands, and stays under
5s for me.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qtest/qom-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 40bdc3639f..d358b69c7e 100644
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


