Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCF5CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYp-0001DU-O7; Wed, 20 May 2026 17:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYo-00019D-Lj
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYm-0007Fp-RC
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQxVEIAkWR2vrOFpn3uiifZT3gsCoVVKIdJuUCwFfHc=;
 b=HqP68PnRb9fbIRmjEQlj5jdGlJHnVtJOejT2A8qHdJLE5GTl1gXp4mT7UpDxChC1Ljb6N7
 ocJi27zjzfIUujr6tBsPDQ8r8tp2AgQd8VEDQUBmt+K9Xtj9npab0p/VrfQxqpi2bKTWP8
 /HxrqEX0tbwF9F9m0eNC500OayI/waY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117--DvtWjUBOj-RySnNmp5_KQ-1; Wed, 20 May 2026 17:34:34 -0400
X-MC-Unique: -DvtWjUBOj-RySnNmp5_KQ-1
X-Mimecast-MFC-AGG-ID: -DvtWjUBOj-RySnNmp5_KQ_1779312874
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8cc616cd846so18246746d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312874; x=1779917674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQxVEIAkWR2vrOFpn3uiifZT3gsCoVVKIdJuUCwFfHc=;
 b=AO61mmvfvR79/ElPY4rIY6nxfX+d7rnZG3Td/la7OiwTMrEV3tN7VtWBrz5e3XRfhc
 ipHUXS1QqXQi0e1gY2tQuZ8/wGT81sv+GdF8l3E2BqP8pUw43DcovCNYOVMGljouH84m
 PSvfQVEuPDjjYTzXcreOfPzhaY9HSLw2xyXf94M/EtqFOt58l3jm+Fv/HGhkQupqrb0n
 LvXfSIuHbz9efaqZCFvZjPfvxoUrVP30IZ+KvypZguQKzJFrCopFrw5B1+5DysoGicPL
 o8+ASm7d0GNVMCWvW4/1EqqAqpZUnpEsgIbbUZvftXPst8OiuHIZdFO5+RQMaLcRdRSW
 TSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312874; x=1779917674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bQxVEIAkWR2vrOFpn3uiifZT3gsCoVVKIdJuUCwFfHc=;
 b=mqKPYVnWiMF1MQd/77bjMCBJvCTzTuDeQW0DD/IU/EGQJuKNmFNFkw1y4k0x9b94Xq
 14yZrsfOa8soWTfn0X0E2UbetQ7kmu+g6x/7EFI0RrdmQ68iI82F3b9PH1lW9diIcJR7
 1Nm16Y4N/1SxY9fhmj2ighqCRQJo/wm0dU+4SYzz9UHNEYfPfOCfQZkWlLtN4sKb6YG7
 OdswSiRUVuOak2m+e8uw5uHMshEoUxG+ELUZWu8ST1OafGq0BVRjJdSBnPvATdj1PsSL
 TekVLU5+2X+/Q7tu2ooOLwcp0QuapSoqzJtySpKDpmE9pBNJTCHGD3k1ebvA0jW1UK+9
 oteQ==
X-Gm-Message-State: AOJu0YyiH59MAzQdJWMqk5KKtDkaOsvMKUtb8ZFPou4n88iPiC814YV0
 nX6fu9yaSEqxWOZZEj3VzA6wn1Alh5T00ATA1IsMj6+YQfIL45quNApzW/PJsl2/9+GbtcBcPTi
 vW5Hwj1YBRES+X7A+pX19/aMPc63AHRisZYf8Yyofe+Yf2biGcn/NOqMznmE3Lf3fWcqQA7AiLc
 bvoXPQLetQM1eHzi1AmJHdLFpC0m3qLTQ2utMfYA==
X-Gm-Gg: Acq92OFeF++OZNKer1nRVczHQenlCADzOnZr94Jm3eJFqnT1qoe9SGa7rRyN+K1exzk
 9IPD3/6nMo+77PKprlg9xNfPzKAmlWAcnSduEwIEZ/iDLK+HIGCV8dsowOD7oVlCNfwlCG8DY/R
 pYiEVjLE48uA10dr1zpwRMUg09YA0E7E2cvE0kP2hLdncUOxUHNcqL6ouWtlWNl7ZwVD9X8cqON
 jxnO7qcalCoAYAM5LlC04XVhL0BFLXz6J+PkjAXv2O0qI8Pa1LUXbz6TEfeRnXrk4o2I9SklWFt
 H5EVYAjnooMvewb7VewS0GbDfdJ8PcYs0orV4s47VrJmmm9q+hB3Fe2d/IEySfHWSKTL9djEr9f
 W1YGK98/evTmjirCZP/9vUgq4i0kgJcdfnrO5FNCHr9pO
X-Received: by 2002:ad4:5b85:0:b0:8cc:2a92:48e4 with SMTP id
 6a1803df08f44-8cc6e67b589mr3919946d6.32.1779312873884; 
 Wed, 20 May 2026 14:34:33 -0700 (PDT)
X-Received: by 2002:ad4:5b85:0:b0:8cc:2a92:48e4 with SMTP id
 6a1803df08f44-8cc6e67b589mr3919366d6.32.1779312873322; 
 Wed, 20 May 2026 14:34:33 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 12/29] tests/qtest/migration: Use a default TCP URI for precopy
Date: Wed, 20 May 2026 17:33:40 -0400
Message-ID: <20260520213357.40646-13-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Using a localhost TCP URI for testing is quite common. Set it as a
default for precopy tests that don't provide an URI.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-7-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.c     | 4 ++++
 tests/qtest/migration/precopy-tests.c | 3 ---
 tests/qtest/migration/tls-tests.c     | 9 ---------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 1d13b897a9..566437c17f 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -834,6 +834,10 @@ int test_precopy_common(MigrateCommon *args)
     void *data_hook = NULL;
     QObject *channels = NULL;
 
+    if (!args->listen_uri) {
+        args->listen_uri = "tcp:127.0.0.1:0";
+    }
+
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return -1;
     }
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 849aef3ed6..377597bc29 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -180,14 +180,11 @@ static void test_precopy_rdma_plain_ipv6(char *name, MigrateCommon *args)
 
 static void test_precopy_tcp_plain(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
-
     test_precopy_common(args);
 }
 
 static void test_precopy_tcp_switchover_ack(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     /*
      * Source VM must be running in order to consider the switchover ACK
      * when deciding to do switchover or not.
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 0677ca661e..4a3c404349 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -459,7 +459,6 @@ static void test_precopy_unix_tls_x509_override_host(char *name,
 
 static void test_precopy_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
@@ -468,7 +467,6 @@ static void test_precopy_tcp_tls_psk_match(char *name, MigrateCommon *args)
 
 static void test_precopy_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_psk_mismatch;
     args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
@@ -488,7 +486,6 @@ static void *migrate_hook_start_no_tls(QTestState *from, QTestState *to)
 
 static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_no_tls;
     /* the no_tls start hook requires no cleanup actions */
     args->end_hook = NULL;
@@ -529,7 +526,6 @@ static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
 static void test_precopy_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -539,7 +535,6 @@ static void test_precopy_tcp_tls_x509_default_host(char *name,
 static void test_precopy_tcp_tls_x509_override_host(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -563,7 +558,6 @@ static void test_precopy_tcp_tls_x509_mismatch_host(char *name,
 static void test_precopy_tcp_tls_x509_friendly_client(char *name,
                                                       MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_friendly_client;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -573,7 +567,6 @@ static void test_precopy_tcp_tls_x509_friendly_client(char *name,
 static void test_precopy_tcp_tls_x509_hostile_client(char *name,
                                                      MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_hostile_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
@@ -586,7 +579,6 @@ static void test_precopy_tcp_tls_x509_hostile_client(char *name,
 static void test_precopy_tcp_tls_x509_allow_anon_client(char *name,
                                                         MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_allow_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -596,7 +588,6 @@ static void test_precopy_tcp_tls_x509_allow_anon_client(char *name,
 static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
                                                          MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_reject_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
-- 
2.53.0


