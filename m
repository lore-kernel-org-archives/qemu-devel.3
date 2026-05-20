Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1D7CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPor9-0007qQ-Ke; Wed, 20 May 2026 17:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqX-0007AL-5j
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqV-0004wF-Ma
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rj62dwPwlt6J5YfC3tT9+7gzCNY1rF6F6nNec9xh4Gc=;
 b=OXgDV2wwHEJKoamCz4fmdTMxPj0Dlc5LHogpnaXooG02NPM98oSgf+lyaUo7KGVLi1R+Ui
 cZPliWZpqBc/LIeBe4Rs8PcMMTXONzbO8EkjcqcsdakTr0nueTZEoQFkgOfWnDl8kBCd8W
 wFKjKfYUgM01cNMr0XZlVA9Gf6CFBnc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-TtB8k5ktMHy0WgzZBEL0yw-1; Wed,
 20 May 2026 17:52:53 -0400
X-MC-Unique: TtB8k5ktMHy0WgzZBEL0yw-1
X-Mimecast-MFC-AGG-ID: TtB8k5ktMHy0WgzZBEL0yw_1779313972
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3A711956055
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:52:52 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61BD630001A2; Wed, 20 May 2026 21:52:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:29 +0400
Subject: [PATCH 28/40] tests/qtest/qmp-test: don't depend on
 human-monitor-command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-28-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=El52EsGFNCM8HmxNPKyL5nqBoHV5YFHr88LpAQg5+7o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyDffKUlgwIFQRXpssqW63I0KvFWzi4sR9Sk
 mforiHtWv6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5XHkD/9EBmxmFN1dDQaSfLPewd2spU06FICjpxRojloZweVR5RMY8SIbvOn5678hJKxRfzl92qY
 FhJzHF1KgA8ummrW0c1SmQlvlRmZy7W1I0Q4Blg83jNCh4zwx6ebLcwGnJpC24cNFdRPpXNkNBy
 So7YiQLTtGdx0WTboEXqNFtSTGLvKB3mk+UGkeY8F7Shr9ciqr5Ps5fmHrGSvK1pKE5txJUUu+F
 N01kOPO6o0QpS10d6bWvr0m2Gh/yUnFVSAv8dQbSEZ2YOqHGxxuUsD3SGjp1u4Z6xm+oKLalrY3
 UjF3bF9QyRQW8pNRfy7KkJJ6zgHgynQ6jcZ5rT6GO6utOv0EJPXi5EeGquKMDpLDwWtsmmKP+uH
 bC+0ZYBTCLKP7KCLzC6loj2EpgY4elIXw1EYoHKmHfSeH+kmna+n3mLUXUWmJrXU7LPe8dbOhf5
 UslpOzZuQlcUVv0yDWDIS86xpF5HUxXnqyduWA8iJpx9kr6Df+v9OveLcX6Bm4bYYZ+2xbszkYl
 A8kQMqo2MMkv75Ym/6Ei8X7yC6mcPuVTI9rR52dJ87/9VW3R++MKn2/JDJbtlpKaZIk+QBWs3LA
 DoQ/TaKo8smBMd7PQj0MrK6yVW3DiabETyLLWBda/adTzDOCZ1IACp8YRuEZQYad+UPyRZaKpe1
 CYeC3gX35ikbjXA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


