Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4683CCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3Oi-0001QX-8O; Mon, 01 Sep 2025 08:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3OP-0001Os-6Z
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3OD-0006Cg-2c
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=FSN5P9oAzI6KeIFbHSJwmI6uOs4VIgbaSKqk6qbWR7Q=;
 b=epSzbgX21TR4VIx/XZLoW09hqRqlStcPSvLVASxGvjqfJp24E3uNUaiePoejiXHQjjNUp7
 OOF6OFklObAPaShxuVY06LUM+j9GPS9IfMIX2fxG/nH6sXuY1HVFdzQSvnna38PeFNEAQW
 mhWgYn69qhQ7i6Kp7gic+i/I0HOxgrk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-bQwQQS8JOKCoV0hEYKsntA-1; Mon,
 01 Sep 2025 08:11:55 -0400
X-MC-Unique: bQwQQS8JOKCoV0hEYKsntA-1
X-Mimecast-MFC-AGG-ID: bQwQQS8JOKCoV0hEYKsntA_1756728714
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 900F6180036E; Mon,  1 Sep 2025 12:11:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F93C180029F; Mon,  1 Sep 2025 12:11:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D7F421E6935; Mon, 01 Sep 2025 14:11:51 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 01 Sep 2025 14:11:51 +0200
Resent-Message-ID: <87ms7e2wzc.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Sep  1 13:53:00 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A6EE821E6935; Mon, 01 Sep 2025 13:53:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 3/5] qtest/qom-test: Don't bother to execute QMP command quit
Date: Mon,  1 Sep 2025 13:52:58 +0200
Message-ID: <20250901115300.2541937-4-armbru@redhat.com>
In-Reply-To: <20250901115300.2541937-1-armbru@redhat.com>
References: <20250901115300.2541937-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250725135034.2280477-5-armbru@redhat.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/qom-test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index a2db56bf22..2da9918e16 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -215,10 +215,6 @@ static void test_machine(gconstpointer data)
     test_list_get(qts, paths);
     test_list_get_value(qts);
 
-    response = qtest_qmp(qts, "{ 'execute': 'quit' }");
-    g_assert(qdict_haskey(response, "return"));
-    qobject_unref(response);
-
     qtest_quit(qts);
     g_free((void *)machine);
 }
-- 
2.49.0



