Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7D8E77169
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdcy-0003KG-Cl; Tue, 03 Dec 2024 19:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcc-0003Fz-EM
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:52:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdca-0005rC-Ju
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/1lUrwSbtWDIYxhFmJMUTG/9ArL3F+YVTSB3vhHZLQ=;
 b=imZrSrf7nZ/KRKFIvcsLqrNxcewZKwYsBRnhtBxt+P12u43eiwcMPHg7jy8JmXwcHu4x6j
 q1l9DlCbVRFpVYTb20cYfN1lU7SKsW52JdDOMFeevdsmBex/qvIC/kyDJLx/hol5ckr9hL
 K3SzwdKrxjKHBZ0eR85WEmf6A3jT6S0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-LeBMOdLJNkCcjtIHbCNGvw-1; Tue, 03 Dec 2024 19:52:03 -0500
X-MC-Unique: LeBMOdLJNkCcjtIHbCNGvw-1
X-Mimecast-MFC-AGG-ID: LeBMOdLJNkCcjtIHbCNGvw
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8b3173b5bso26845296d6.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273522; x=1733878322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/1lUrwSbtWDIYxhFmJMUTG/9ArL3F+YVTSB3vhHZLQ=;
 b=A4arnGj4iDekgGaoaEU0qJSGx9T1ASwbsXWkFhUpjVkLXhP/PHKTiHL4b/tPAsWtqA
 ONwGGDrxsj9d9AEF770ngSiEktxxW+8Z5IJrZr1Wi6idGvf83hMzPpbtc31i+mE+Soob
 jc7a4bLkLGrBmwny1RxdY8oiA48VpNM/0zJw2g4SVxzZiRkF8c0/E3mEnXu4IQfxxVE0
 0hYQG3/GBSUDXYz5BHM5Tqc+JstSxJMVoPnXeHFgq4Lvm5HSRRNccHE0I+1o7/yVCeRp
 rEA+fi8nCO3+495IkD+U2xPDJqLFlMKZOql+WthLOo8UWU2//xee/wQbFo8q3Jxu424X
 CHhw==
X-Gm-Message-State: AOJu0YxebkEyYXvUuIKANeq+VcUqYfEghMf+LSx2F9w88KIkF4Yy0of/
 lPQdRofA0O+E0X2gqd/zlPvyZsDs/GGpfs5aUp7EPHzFbpISIIexshWwGvDK9ZQ3a/LZHdDt2K2
 xWOuRg4Rp2CiDi8pYFBn5TfJs6a1drEnDWiL68VVGIiH8szTk+agFfuWhiXECxzk2yF/Tbmo84R
 oSBSo5ZgmBA2rUcSjKPteUhE6wlkbgylPQ5w==
X-Gm-Gg: ASbGnctHu7AUU96C2zfekZH912sJ5vBoYt7DyJhO5mIaa5f7me7pswiBGuubEHoJ7Sn
 C+sEF5cEH6PfOLWyUZQLVtfmcJP30t7yS/3xSPlTb+0S+UbaUoDAERj6Yn/4SZsnwdp+/OTIdFa
 Blk8Er6BcrdtiHxE2VIYw3pPnwMeiU283xVwnHDYb3pudL6lKg+l5gNF5dhJqxgdARYpzcOiJ+L
 Aah0fe1PWzWDYhNPmbRGdS7I8EmWlZ4E6SmAU94kb0QCpII2lBt/6A/T71yIOfDvTiCgtMu8rrk
 uLuQ6l/tlzUdrRH3OtSmBosYCQ==
X-Received: by 2002:ad4:5c46:0:b0:6d8:b189:541d with SMTP id
 6a1803df08f44-6d8b7331a75mr94271686d6.6.1733273522024; 
 Tue, 03 Dec 2024 16:52:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1lURGF+S355GWNV3rC+kOlmDmuNHXuiDQjcsKHwFOEYtHioiyra4eiKmdimAaOvMIs5j85A==
X-Received: by 2002:ad4:5c46:0:b0:6d8:b189:541d with SMTP id
 6a1803df08f44-6d8b7331a75mr94271216d6.6.1733273521673; 
 Tue, 03 Dec 2024 16:52:01 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492cb81sm559974785a.34.2024.12.03.16.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:52:00 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, peterx@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC 10/11] tests/qtest/migration: Support cleaning up only one
 side of migration
Date: Tue,  3 Dec 2024 19:51:37 -0500
Message-ID: <20241204005138.702289-11-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204005138.702289-1-peterx@redhat.com>
References: <20241204005138.702289-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

We don't always want to cleanup both VMs at the same time. One example
is the multifd cancel test, where there's a second migration reusing
the source VM. The next patches will add another instance, keeping the
destination VM instead.

Extract the cleanup routine from test_migrate_end() into another
function so it can be reused.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241125144612.16194-4-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 1452778c81..74645f749c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -883,13 +883,29 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     return 0;
 }
 
+static void migrate_cleanup(QTestState *from, QTestState *to)
+{
+    if (from) {
+        qtest_quit(from);
+        unlink(src_state.serial);
+        g_free(src_state.serial);
+    }
+
+    if (to) {
+        qtest_quit(to);
+        unlink(dst_state.serial);
+        g_free(dst_state.serial);
+    }
+
+    cleanup("migsocket");
+    cleanup(FILE_TEST_FILENAME);
+}
+
 static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
 {
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
 
-    qtest_quit(from);
-
-    if (test_dest) {
+    if (to && test_dest) {
         qtest_memread(to, start_address, &dest_byte_a, 1);
 
         /* Destination still running, wait for a byte to change */
@@ -909,14 +925,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
         check_guests_ram(to);
     }
 
-    qtest_quit(to);
-
-    cleanup("migsocket");
-    unlink(src_state.serial);
-    g_free(src_state.serial);
-    unlink(dst_state.serial);
-    g_free(dst_state.serial);
-    cleanup(FILE_TEST_FILENAME);
+    migrate_cleanup(from, to);
 }
 
 #ifdef CONFIG_GNUTLS
@@ -3309,9 +3318,7 @@ static void test_multifd_tcp_cancel(void)
 
     /* Make sure QEMU process "to" exited */
     qtest_set_expected_status(to, EXIT_FAILURE);
-    qtest_wait_qemu(to);
-    unlink(dst_state.serial);
-    g_free(dst_state.serial);
+    migrate_cleanup(NULL, to);
 
     /*
      * Ensure the source QEMU finishes its cancellation process before we
-- 
2.47.0


