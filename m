Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E85CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPorR-0008PE-LD; Wed, 20 May 2026 17:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqp-0007dh-Mp
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqo-0004z2-4D
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3KUG4432JhTrb0PuW80xNY0zS5CkpLg7NX6P+/NnTq4=;
 b=Q97PWMdX6Zz0DRLVwCkhYWEDBk9YkHYLc0efvT4nquMVcKAohRX3wZc+3Zo5Hoo8k2KmUN
 aoLXSokbNq72q6ScsMXfsqroydSQXFcFn9ruUephaVypA0LR79E+1XMtlExMXGg4WqWyqX
 dnyySyXqNaNkp8CD5VMBi/4GZ4U91LI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-7T6uL6ODNJKjpqYOrbDPPw-1; Wed,
 20 May 2026 17:53:10 -0400
X-MC-Unique: 7T6uL6ODNJKjpqYOrbDPPw-1
X-Mimecast-MFC-AGG-ID: 7T6uL6ODNJKjpqYOrbDPPw_1779313989
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B4F7195608D
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:53:09 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D828D18004A3; Wed, 20 May 2026 21:53:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:32 +0400
Subject: [PATCH 31/40] tests/qtest/drive_del-test: guard HMP-dependent
 tests with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-31-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3445;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9n36PJYlKJGC91zsIXys/gJy72dL3cNyBLFLxzQVzSE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyErCFQq0lbmS9OWR4wxhSc3KeytpqPvuEpX
 BIW/12Qx7mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4shAAKCRDa6OEJdZac
 5SuMEACXrOcPyWoIgD09m98sgj9mUIwLZJB/50k/PuzCITKxb8FKY+Nkn0iL7p2R8yBJpGrWI20
 /wW9zDiloDFLYRFAvAppM/jizbAFhP7xeh3IeniyRQ3cmoUN7sId94rZOUUjL7e43P5OxalZE2U
 K6j2bFmt3/a+O0ycv8Lr7E3AM4ETjfuynL1URp6jzTqaOeMAlWEFST2z0f2Q/TnjxcBI9voCLzp
 uEOT5yM/7HvZCsEbO+cc32u57Z7lW0Pcb05jPiX824VBNhaAdhdXREVgbyIpOpkGkOYyMxfbddJ
 ts+Q4hMNEVAYYTuanlkWKbf4KXSkexn15ptuAvUXRGdA/x/PozKqCqI8eme5CCqDAT0pDptC5D4
 pwKg3pqGuv35Ybi9QLfI7p9zW0D6pKWWqGTdk9RxeCu5lK44fr+EdtmKfbBYFZnfVubhlDwtsI8
 sSkxxvXSvK7kRIrRDWlE7VES6TAACUnTugVvUhX0ggFJX/Xq9uWaoNjLalLysjd3sENYjCQbbRs
 lxpN5+AkTKQoaoF+ZF+UtJdIs/cRJL/2v0bkBU71kOedtX4nIyXXNKmbK7o2guuphU2+F5ELZPA
 C0QyBUEku49icpViNUehD2bYXk5alzXF6wobESv4+9vZqMWbyL97Hu5KEjD1z+uUj06ZpBF3QsV
 VWNSr9HaMcUrO5A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

These tests rely on HMP commands (drive_add, drive_del) that have no
direct QMP equivalent. QMP's blockdev-del operates on node-names and
rejects deletion of in-use nodes, whereas HMP's drive_del operates on
BlockBackend IDs and can detach a drive from a device. The equivalent
QMP-based tests already exist (test_blockdev_add_device_add_and_del*).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/drive_del-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 30d9451ddda..d78816d44a7 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -87,6 +87,7 @@ static void blockdev_add_with_media(QTestState *qts)
     g_assert(has_blockdev(qts));
 }
 
+#ifdef CONFIG_HMP
 static void drive_add(QTestState *qts)
 {
     char *resp = qtest_hmp(qts, "drive_add 0 if=none,id=drive0");
@@ -117,6 +118,7 @@ static void drive_del(QTestState *qts)
     g_assert(!has_drive(qts));
     g_free(resp);
 }
+#endif
 
 /*
  * qvirtio_get_dev_type:
@@ -163,6 +165,7 @@ static void device_del(QTestState *qts, bool and_reset)
     qtest_qmp_eventwait(qts, "DEVICE_DELETED");
 }
 
+#ifdef CONFIG_HMP
 static void test_drive_without_dev(void)
 {
     QTestState *qts;
@@ -245,6 +248,7 @@ static void test_drive_del_device_del(void)
 
     qtest_quit(qts);
 }
+#endif
 
 static void test_cli_device_del(void)
 {
@@ -391,6 +395,7 @@ static void test_device_add_and_del_q35(void)
     qtest_quit(qts);
 }
 
+#ifdef CONFIG_HMP
 static void test_drive_add_device_add_and_del(void)
 {
     QTestState *qts;
@@ -443,6 +448,7 @@ static void test_drive_add_device_add_and_del_q35(void)
 
     qtest_quit(qts);
 }
+#endif
 
 static void test_blockdev_add_device_add_and_del(void)
 {
@@ -501,19 +507,25 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+#ifdef CONFIG_HMP
     qtest_add_func("/drive_del/without-dev", test_drive_without_dev);
+#endif
 
     if (qvirtio_get_dev_type() != NULL) {
+#ifdef CONFIG_HMP
         qtest_add_func("/drive_del/after_failed_device_add",
                        test_after_failed_device_add);
         qtest_add_func("/drive_del/drive_del_device_del",
                        test_drive_del_device_del);
+#endif
         qtest_add_func("/device_del/drive/cli_device",
                        test_cli_device_del);
         qtest_add_func("/device_del/drive/device_add",
                        test_device_add_and_del);
+#ifdef CONFIG_HMP
         qtest_add_func("/device_del/drive/drive_add_device_add",
                        test_drive_add_device_add_and_del);
+#endif
         qtest_add_func("/device_del/empty",
                        test_empty_device_del);
         qtest_add_func("/device_del/blockdev",
@@ -524,8 +536,10 @@ int main(int argc, char **argv)
                            test_cli_device_del_q35);
             qtest_add_func("/device_del/drive/device_add_q35",
                            test_device_add_and_del_q35);
+#ifdef CONFIG_HMP
             qtest_add_func("/device_del/drive/drive_add_device_add_q35",
                            test_drive_add_device_add_and_del_q35);
+#endif
             qtest_add_func("/device_del/blockdev_q35",
                            test_blockdev_add_device_add_and_del_q35);
         }

-- 
2.54.0


