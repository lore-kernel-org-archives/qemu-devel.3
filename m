Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDF5CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3P3-0001hR-8Q; Mon, 01 Sep 2025 08:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3OV-0001QE-2B
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3OH-0006D2-Ub
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=bRV9OOJyHJvhWIpd9mvExzO8HtMA/H5nba9hQcm9jMc=;
 b=OmDPKT8Q1ovh0CtG7flWAWRZwla17N2GzLSY00HxWmHMBycRGn6Fig/8dSnhgGHsZN5q0Q
 6lxBEHAsYvMDBZ2areK3LZbTlaxUmzG+ZDevTSFC0Y7dt8NEyFr+uEUHhz6TqBD/5Usp6y
 aY8hcCSW2Xggh72I7+nkHb+mUpUd1d0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-qJ2LIQ-SNZ6c_zVvbaHb-A-1; Mon,
 01 Sep 2025 08:11:56 -0400
X-MC-Unique: qJ2LIQ-SNZ6c_zVvbaHb-A-1
X-Mimecast-MFC-AGG-ID: qJ2LIQ-SNZ6c_zVvbaHb-A_1756728714
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A841F195608A; Mon,  1 Sep 2025 12:11:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48BC030001A2; Mon,  1 Sep 2025 12:11:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A69521E6924; Mon, 01 Sep 2025 14:11:51 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 01 Sep 2025 14:11:51 +0200
Resent-Message-ID: <87v7m22wzc.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Sep  1 13:53:00 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F40621E6924; Mon, 01 Sep 2025 13:53:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 1/5] qtest/qom-test: Shallow testing of qom-list / qom-get
Date: Mon,  1 Sep 2025 13:52:56 +0200
Message-ID: <20250901115300.2541937-2-armbru@redhat.com>
In-Reply-To: <20250901115300.2541937-1-armbru@redhat.com>
References: <20250901115300.2541937-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Message-ID: <20250725135034.2280477-3-armbru@redhat.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/qom-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 4ade1c728c..7dea0d802d 100644
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



