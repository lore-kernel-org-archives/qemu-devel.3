Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E29ACD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYz-0001S8-2h; Wed, 20 May 2026 17:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYx-0001NU-QT
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYw-0007L4-3k
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oe2LBK8fDwEruVzCjrliSYntZKay/6ne0SQnWH9QpMA=;
 b=T7tm/IOUxcXT3lSF75QBihzn91vxljc3cfzHrX34UccznIu5e8NgLAaem6LfdqTvhgzupA
 wZeH6bgh4KDkRm6k9o+o8e25g17Ptu1+V5lTYOjrNELTRaG5MEjMNb7BzpA6A1iwv0GzqN
 UdgMo4Ml3lUdAL/F6tRXJ72Q2z46Ie8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-PactuG3sNGWc6mZfsQRw0A-1; Wed, 20 May 2026 17:34:43 -0400
X-MC-Unique: PactuG3sNGWc6mZfsQRw0A-1
X-Mimecast-MFC-AGG-ID: PactuG3sNGWc6mZfsQRw0A_1779312883
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50fbc49bef6so108832371cf.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312883; x=1779917683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oe2LBK8fDwEruVzCjrliSYntZKay/6ne0SQnWH9QpMA=;
 b=QsfnfJMU9nmuGIpzgIqq6DHKxwlz/EIEoAqVhGNqHVOJjFOjDY3Wt9u61z42QlBV8U
 2Q3bFU0NSIaRPcm0xiLYeyf5rz0lJ1r66U1OVg/o7/4ygpqALIXH0DGOdBKsFNNa6svb
 dv+jU+Fq9pLQxO25qIjokO+TL34dA14XqAE4gN6oBjKy2OuzCa7dQMjxg3XCF9Y/i/Bb
 OxVIhc75QrsG/q7MzMFk/kfJprBN6/6HWwDrBGeTP3K1GOXIFiSf3SFbFwNNCzDJkQ0N
 WX0gN4lp3XbcYJ6qxBwzuw79xBSDmksiyr3hweitNYqXu1rwHmAfTkXepHaoCByu+Bql
 AcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312883; x=1779917683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oe2LBK8fDwEruVzCjrliSYntZKay/6ne0SQnWH9QpMA=;
 b=rAIWC407KeA9S36wErxItr9Eh86LZUuJa/tbIruMz6xA/byyO2cvP105zQyZpqCQ0u
 NPtM+Ksfob2I+uf0dmiBe69f9RKKY5bQe2RapMj7231qqUQLW/zaHLrQ65tn5DcLaCO6
 hpr050naWszO0LvnWLC6EPue6nhaCHfSgTMXMkJ3NxdlrFuMqjUosuDujl0Zm14sVQd+
 XCCnP32aWccBJLmRto8FgsmicugCG6iJ4/mmbHPmEQOhhV0ze8IvlTkMsgsYfB/6Zu7I
 ndY+tA4M72Sdp7ox89dL0JuK2GU1JgNchfUGYoNKvv6lica5PCkvk++hCgmat0N0Ji81
 CpBQ==
X-Gm-Message-State: AOJu0YyTNJmr9gNMrpWY/3z3UIBdseCSOf0JtcPhvWDyJRDoP5Hl016c
 0ngROJXqugXfb8eVhPKk+GnPPV2cwr8GYLz/mx4LIh01eST1e7G1lUr93qhy99tikphwKJktALb
 +Hna0disaAe2PT9DEXUnKSCVeDbmi7SLQhYvl6traLqIbGohhnTjD2LAruJbLs5Z1dd8nAZ6xh1
 v3nFvkSm1u1/9gf0YifqZIR8jVSYSqQN+GYSSPLg==
X-Gm-Gg: Acq92OEzDQuhr2E/HK8jAuxMhGAdeKymyBc6idt9OoyYF+smteh0R/f44+libnvWi1d
 v+mYKf1S0BySTzFwTIYQi3vjwkFcfHcxjEsIQmDATRe8pJTDUprsxLWVy4cfBLrNz9MbOaR5X9p
 CWZ4+5jr6Zzcv4w79VOz3+K6sdTOAB6y6GYGL83FSRrysVjVPDKMvQA0blKVPuNYOqHg8kMzKrY
 vm4O0w7S8uY1eJcGHggvwIdpTdX4C5sTScmhppnmauYPNmKbOvjfDUbfQTGGfUcQ2YxBXBc2jM7
 W7o6WLjWrIMoUccZFFj+LKgbD9gNZH/N4H9M5Wyehu2RHRexo0mqInWvivCXyki7qnAjMt77I3u
 7mFOTe5lHqWvejPZZvo7o19eN8fCaCtH2N5wKw+ZXE9kjHn/bmpqLVaI=
X-Received: by 2002:a05:622a:4cc5:b0:50f:bc91:709 with SMTP id
 d75a77b69052e-516c559eccemr3413291cf.39.1779312883223; 
 Wed, 20 May 2026 14:34:43 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc5:b0:50f:bc91:709 with SMTP id
 d75a77b69052e-516c559eccemr3412871cf.39.1779312882705; 
 Wed, 20 May 2026 14:34:42 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 17/29] tests/qtest/migration: Use defer for cpr-tests
Date: Wed, 20 May 2026 17:33:45 -0400
Message-ID: <20260520213357.40646-18-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-12-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/cpr-tests.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 18217f0460..9091a84213 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -60,7 +60,7 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
     obj = migrate_str_to_channel(cpr_channel);
     qlist_append(channels_list, obj);
 
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
 
@@ -128,11 +128,17 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
     int cpr_sockfd = qtest_socket_server(cpr_path);
     g_assert(cpr_sockfd >= 0);
 
-    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
-                                  "addr.type=fd,addr.str=%d %s",
-                                  cpr_sockfd, opts);
+    if (incoming_defer) {
+        opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
+                                      "addr.type=fd,addr.str=%d %s",
+                                      cpr_sockfd, opts);
+    } else {
+        opts_target = g_strdup_printf("-incoming %s "
+                                      "-incoming cpr,addr.transport=socket,"
+                                      "addr.type=fd,addr.str=%d %s",
+                                      uri, cpr_sockfd, opts);
+    }
 
-    args->listen_uri = incoming_defer ? "defer" : uri;
     args->connect_channels = connect_channels;
 
     args->start.opts_source = opts;
@@ -224,7 +230,7 @@ static void test_cpr_exec(MigrateCommon *args)
     g_autofree char *filename = g_strdup_printf("%s/%s", tmpfs,
                                                 FILE_TEST_FILENAME);
 
-    if (migrate_start(&from, NULL, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, NULL, "defer", &args->start)) {
         return;
     }
 
@@ -274,10 +280,7 @@ static void test_mode_exec(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
-    g_autofree char *listen_uri = g_strdup_printf("defer");
-
     args->connect_uri = uri;
-    args->listen_uri = listen_uri;
     args->start_hook = test_mode_exec_start;
 
     args->start.only_source = true;
-- 
2.53.0


