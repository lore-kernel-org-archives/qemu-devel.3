Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA3BC87FD1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufIqs-0003Jh-0S; Fri, 25 Jul 2025 09:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ufIos-0008PL-Js
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ufIoq-0005Ze-AN
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753451439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cvSpiQ1SwZ1haFCTaBCprWzpxf+GZM90JxdKYWEWzrc=;
 b=ENJJ1BDrGqVLSW71ugnI+jXm0i4UFPe2rflHXbVjEazLG49omJ6J1uMbKzrAOLJB2QDiFL
 hgX/o/7UPsg+pv7PzNh+DV3mZys1BPOXdJazNJl2bEfqU/sdYghDWxIL+9CnUtzfWKEnuJ
 EorbWtAyEH9yjIvb8MNM7d/TOxxHaSc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-DB_ygEkrMF6zvSxRkm0JyQ-1; Fri,
 25 Jul 2025 09:50:37 -0400
X-MC-Unique: DB_ygEkrMF6zvSxRkm0JyQ-1
X-Mimecast-MFC-AGG-ID: DB_ygEkrMF6zvSxRkm0JyQ_1753451437
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE217195608E; Fri, 25 Jul 2025 13:50:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F7C618003FC; Fri, 25 Jul 2025 13:50:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A23121E6924; Fri, 25 Jul 2025 15:50:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 steven.sistare@oracle.com
Subject: [PATCH 1/5] qtest/qom-test: Plug memory leak with -p
Date: Fri, 25 Jul 2025 15:50:30 +0200
Message-ID: <20250725135034.2280477-2-armbru@redhat.com>
In-Reply-To: <20250725135034.2280477-1-armbru@redhat.com>
References: <20250725135034.2280477-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

The machine name g_strdup()ed by add_machine_test_case() is freed by
test_machine().  Since the former runs for all machines, whereas the
latter runs only for the selected test case's machines, this leaks the
names of machines not selected, if any.  Harmless, but fix it anyway:
there is no need to dup in the first place, so don't.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qtest/qom-test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 4ade1c728c..cb5dbfe329 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -220,7 +220,6 @@ static void test_machine(gconstpointer data)
     qobject_unref(response);
 
     qtest_quit(qts);
-    g_free((void *)machine);
 }
 
 static void add_machine_test_case(const char *mname)
@@ -228,7 +227,7 @@ static void add_machine_test_case(const char *mname)
     char *path;
 
     path = g_strdup_printf("qom/%s", mname);
-    qtest_add_data_func(path, g_strdup(mname), test_machine);
+    qtest_add_data_func(path, mname, test_machine);
     g_free(path);
 }
 
-- 
2.49.0


