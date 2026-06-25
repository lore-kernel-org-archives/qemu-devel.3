Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64963CDE010
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrVa-0001Hn-8H; Thu, 25 Jun 2026 17:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVO-0000kX-V6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVL-0003hj-QI
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rj62dwPwlt6J5YfC3tT9+7gzCNY1rF6F6nNec9xh4Gc=;
 b=L7hBN6l4N1wdzVue4uRfxp7I0SU0G998FRpQUTdEh8k6W/CVWPzjkZIiglVvLpiId1Q74A
 V3/lloV3h0H51U4143uwr6XdeBz6tCagadI2+S3tLJXqA0yHsFbIhOLE9svF7CKLRh364A
 e3gLm/Zql8s8/vb2B0rMkPD85Tg/zFM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-FkV_mNTiMtqu8eNr6UoDrw-1; Thu,
 25 Jun 2026 17:20:54 -0400
X-MC-Unique: FkV_mNTiMtqu8eNr6UoDrw-1
X-Mimecast-MFC-AGG-ID: FkV_mNTiMtqu8eNr6UoDrw_1782422454
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD125180AEB4; Thu, 25 Jun 2026 21:20:53 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 648EC1956047; Thu, 25 Jun 2026 21:20:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:16 +0400
Subject: [PATCH v2 15/39] tests/qtest/qmp-test: don't depend on
 human-monitor-command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-15-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=El52EsGFNCM8HmxNPKyL5nqBoHV5YFHr88LpAQg5+7o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdi6mx7Z7R0pMG0yLIyf8BFVIcXuzCcDCBD
 jV3V5K3pNCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5akID/4yeRTQfxAvGcH8s7c3MoiG7lbC5vWlZlAaFZyWp13tjNVKiV67N99XMRfXVOmll4/eY8T
 3S5Tl8qkLFYxV3k1nSOMRlP6bt4M3kALTcXCHcuS9n2HrrQm7xe0XBVfS/C66fnAIqNwBZbcpwS
 pyR6Ae1DqRRTGH5SvW4H+F24wXT0OX2k/Gk6HNx12tf/dydjNgkIsUo7VsVheY/UdEiMzJWfsDo
 LxxmAdfuD1H37twN5q/Z4IgkfhJp9Cgz+4N0QZAt6Z5tHw5NnzDeYP9G42qe5QLsLjXxLU1kPxc
 M9gPgrVgnQlqK9XnredLW/Q+jhyZCI4YpvcRt5E8tUSqr03STM5ylkMlZDum1IlODHBDI0stjsE
 xJOABrJMOzXC4qxhk2HWFFMNbAVD+WhAMiTYVIPWCgV1+6wmuZBCCls7zExlDM4jguvn97r7stA
 dOCgnRzU6oikdKv0QPAbD11V5z944hntN6Zp6hRJLpFFIq5Au7uFUmTHlzY4XHcPsxYFWcIg6//
 pUgGKT0zpEzt/vnmZTqSfkdVrajMCrfAYbslbdRI2N9+WThZctTRh2wa0KfbJx/GhLxb76IpMA4
 rkp/16hsBve2NUUhNJ8JYXFQAoHnKESaGIfOAVLGwvAaELZC7y/61ftgTAAbWCAxiBBPC02d90d
 08k6ZYjUvrNX40g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

The test was using 'human-monitor-command' (which requires HMP) to
verify that an integer 'id' is echoed back on failure. Replace with
'query-name' for the success case and 'block_resize' (missing
required args) for the failure case, so the test works regardless of
HMP availability.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/qmp-test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index edf08867874..03637b9e2d2 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -151,9 +151,14 @@ static void test_qmp_protocol(void)
     g_assert_cmpstr(qdict_get_try_str(resp, "id"), ==, "cookie#1");
     qobject_unref(resp);
 
-    /* Test command failure with 'id' */
-    resp = qtest_qmp(qts, "{ 'execute': 'human-monitor-command', 'id': 2 }");
+    /* Test integer 'id' is echoed back on success */
+    resp = qtest_qmp(qts, "{ 'execute': 'query-name', 'id': 2 }");
     g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
+    qobject_unref(resp);
+
+    /* Test integer 'id' is echoed back on failure */
+    resp = qtest_qmp(qts, "{ 'execute': 'block_resize', 'id': 3 }");
+    g_assert_cmpint(qdict_get_int(resp, "id"), ==, 3);
     qmp_expect_error_and_unref(resp, "GenericError");
 
     qtest_quit(qts);

-- 
2.54.0


