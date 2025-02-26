Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B08C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEAt-0003Mr-Ds; Wed, 26 Feb 2025 04:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEAr-0003M1-Ar
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEAk-00084e-JN
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740563864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2M5PYFALtIPWw6gM+rJ5qYo7EJhQAol7H3JpncaODnE=;
 b=LxxcKu/58b2iNE+SxRrE+FlpwFxnTsr+n6HcwFrLNTf9CWtbcWYW+qP2DHRvQQr12FXvqF
 Wu9zysF7p+mm/7ocvFRffHdv8lmadYlS1Z16WetKELioF29cBT0TI99TI1+LGej2vhc5Rn
 DjGQmEpJz2JXD4kddZL7F5H/Zy6/aaE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-XiHZz-gvOFGNwN5_HED2KA-1; Wed,
 26 Feb 2025 04:57:41 -0500
X-MC-Unique: XiHZz-gvOFGNwN5_HED2KA-1
X-Mimecast-MFC-AGG-ID: XiHZz-gvOFGNwN5_HED2KA_1740563860
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 412391800875; Wed, 26 Feb 2025 09:57:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.144])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98F091800358; Wed, 26 Feb 2025 09:57:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 02/18] tests/qtest/qom-test: Test retrieval of machine class
 properties
Date: Wed, 26 Feb 2025 10:57:15 +0100
Message-ID: <20250226095731.1172375-3-thuth@redhat.com>
In-Reply-To: <20250226095731.1172375-1-thuth@redhat.com>
References: <20250226095731.1172375-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

There were recently some crashes that occurred when trying to
retrieve the properties of machines. Let's add a test to avoid
regression here.

Message-ID: <20250123204956.1561463-1-thuth@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/qom-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 1e30a5bfe8d..27d70bc11ce 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -88,6 +88,17 @@ static void test_machine(gconstpointer data)
 
     qts = qtest_initf("-machine %s", machine);
 
+    if (g_test_slow()) {
+        /* Make sure we can get the machine class properties: */
+        g_autofree char *qom_machine = g_strdup_printf("%s-machine", machine);
+
+        response = qtest_qmp(qts, "{ 'execute': 'qom-list-properties',"
+                                  "  'arguments': { 'typename': %s } }",
+                             qom_machine);
+        g_assert(response);
+        qobject_unref(response);
+    }
+
     test_properties(qts, "/machine", true);
 
     response = qtest_qmp(qts, "{ 'execute': 'quit' }");
-- 
2.48.1


