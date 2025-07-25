Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C293C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufIpr-0001i0-Ns; Fri, 25 Jul 2025 09:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ufIos-0008OA-7e
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ufIoq-0005Zg-A8
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753451439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rnF8HW0U51J9PRsWKZGD7+44XDXZDNKdRUl1c4hdtE4=;
 b=JB+0+1gRDZnqN/2nQGr6YoxecxEzEI8NYGl69Qonvl/ug4CUpVAL74yuDjB5lw77XDJc02
 RO/EClU5H7Fs2eLT2LWHlRZE233ic78yDWSzNzTWpjKdKUIrFyVab0l13uYmvZ1nO3sGLd
 XEdURG+9IstIwghdtjBH0SaE2llmesw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-sGqxE6gGOT2vEk8O0EvbFQ-1; Fri,
 25 Jul 2025 09:50:38 -0400
X-MC-Unique: sGqxE6gGOT2vEk8O0EvbFQ-1
X-Mimecast-MFC-AGG-ID: sGqxE6gGOT2vEk8O0EvbFQ_1753451437
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ABDE1800446; Fri, 25 Jul 2025 13:50:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B290219560AA; Fri, 25 Jul 2025 13:50:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1EA1E21E6925; Fri, 25 Jul 2025 15:50:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 steven.sistare@oracle.com
Subject: [PATCH 2/5] qtest/qom-test: Shallow testing of qom-list / qom-get
Date: Fri, 25 Jul 2025 15:50:31 +0200
Message-ID: <20250725135034.2280477-3-armbru@redhat.com>
In-Reply-To: <20250725135034.2280477-1-armbru@redhat.com>
References: <20250725135034.2280477-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

This test traverses the QOM sub-tree rooted at /machine with a
combination of qom-list and qom-get.  In my x86_64 testing, it runs
almost 12000 QMP commands in 34 seconds.  With -m slow, we test more
machines, and it takes almost 84000 commands in almost four minutes.

Since commit 3dd93992ffb (tests/qtest/qom-test: unit test for
qom-list-get), the test traverses this tree a second time, with
qom-list-get.  In my x86_64 testing, this takes some 200 QMP commands
and around two seconds, and some 1100 in just under 12s with -m slow.

Traversing the entire tree is useful, because it exercise the QOM
property getters.  Traversing it twice not so much.

Make the qom-list / qom-get test shallow unless -m slow is given:
don't recurse.  Cuts the number of commands to around 600, and run
time to under 5s for me.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qtest/qom-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index cb5dbfe329..40bdc3639f 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -180,7 +180,7 @@ static void test_properties(QTestState *qts, const char *path, bool recurse)
         links = g_slist_delete_link(links, links);
     }
     while (children) {
-        test_properties(qts, children->data, true);
+        test_properties(qts, children->data, g_test_slow());
         g_free(children->data);
         children = g_slist_delete_link(children, children);
     }
-- 
2.49.0


