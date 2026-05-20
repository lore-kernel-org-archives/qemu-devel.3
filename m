Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FC3CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYv-0001Hi-Rh; Wed, 20 May 2026 17:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYu-0001H5-Fn
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYs-0007KK-Lb
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XW0WUY+8SOS2wnOtPIllNDOMeReNO1Ag3bscX+uOO5g=;
 b=WEiJkvPLOJ4Y63yuepEwuYCJN4uxyUsmUkEHHl5W2zpo4bfgsX5FxnIoX2pZqGVMVt2f+M
 tGE1a3ust9mbL4EGLiTcaoKvNkZfVfpqGwgx7JrKChkyGMXlefeIKYyL02GxfqsrDukTe9
 d1uqZfNNOXeqve3kypVoDMMp91/Gog0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-wT44gs5bM-6168L0JH0cTw-1; Wed, 20 May 2026 17:34:40 -0400
X-MC-Unique: wT44gs5bM-6168L0JH0cTw-1
X-Mimecast-MFC-AGG-ID: wT44gs5bM-6168L0JH0cTw_1779312880
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8bc5ab12bb5so185439116d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312880; x=1779917680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XW0WUY+8SOS2wnOtPIllNDOMeReNO1Ag3bscX+uOO5g=;
 b=Kc7nzV3LL5FHnpmhyebzOBwkxGvSyOOG4DKWs9RbDv9o490gjvSLj/IYM4aq7modMH
 r8kGgFNvFi+/mkdyokKbpIQZqRfCLKVyRmLZY4bLADCeV5sL2lwOSwZdZ9AE6/s6HJnU
 NJNYNatdw0Iv0liJlZk9OXlftpmoe2kEPd/V0gV2W6gAECyZrKtByOOp2ubQKEJp62+q
 BMb00MNbz2NJpGwvfUyXPI8dP9pt9pmUR7c1mouBGYUI++weFeqoIqKp0MdDNp4E86+B
 B6+Xu0jFl1x72dEk6RjIiOJrfr/mu6xZ6HibFtGVMgP9SUsUUDwyykRkrK69bCUv4tlV
 mxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312880; x=1779917680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XW0WUY+8SOS2wnOtPIllNDOMeReNO1Ag3bscX+uOO5g=;
 b=QEcGeEV0Fnf7aMbD4fiwUxN+a9lJ+SHtvf5FSM28RKSSaSCIfd08DVqxipavzpyoiS
 W1op2b3L/7EqTsZzBIKqCGkaCXeiuXobxduHLtYnTgRSqeassrL0L1xX0BPTBEo4GZCi
 Jm6Awtjgh01Opist7QEZS6O5n7TCmj+2yMZq5ck/uqz4HHzwllB/Q5x9w0niIVnmnH+V
 hbyEpKevsJOsxxRf2vVw9tbrCeVBVrA+nf6EwvGnVFB5XdzQBkd0394zMC5BvyFKrGcZ
 JwAn8OCK1crtalVEduwNCaKMTQ/q7efuIescz89SnOvcPQCwbC5UK2iVj+VgLGJflo5a
 FJVg==
X-Gm-Message-State: AOJu0YzZa/fk6FQGvshQKGRYohPZbyE4Iu0klqiPiGLsX7gzGX8hk0l8
 zCruMJW1Nd/Y9ZxqHMeUXxLy5iqW6E4vgwHSCA1tbbs/dZChhQOPETXJgqQKsOHOqyOIExYizVm
 N4Y2Xof795QrzKo7cZzNlpbszajWYYDl8Ddu80dtIOuMKJijCNBrUB9VI8ekO/MVbqflTNnUzP5
 jxapTZMPYZSmZcbqvV16o27i/wq+GCIYvIjkezvg==
X-Gm-Gg: Acq92OGS99nS8K2obHeBIytsLsWTAOQmXRpGcrizUXSYhkjTeB7OSVmVF7e0hsuWoqT
 BOqIPg6fLb9mEK66tLi/x4h7B/dEx0nEBHPXOrvz2aeIp6vDH/BgHD5bUZyJVx/i/pynjUbDjC1
 X7MUNpVqp5n5n/joLoisPUTTq5rb3NBF1Skjsfmu4q6wtzKLEa8cOXWec3z6LCQ+e90PaLZzstZ
 IHJ3SzzRd+G042gXKGcAkiUC/91QenM3l4sw4Il1hN/2GWXOhePbjTnPBmQ3xQmRx0VRSM0rLog
 1b45FQh0V27KBPrIXosGSESlUiSjLC0zoemfr2ijzhcreU2mEBcAHLirw8ZOKcxWiQeQSky+oUp
 0FT7dki4A+gTsC5Twr4Mfo2JxkGYiaSlpZ8/VwJ5Nekyl
X-Received: by 2002:a05:6214:468f:b0:899:f0b1:7332 with SMTP id
 6a1803df08f44-8cc6e483a68mr3756986d6.32.1779312880029; 
 Wed, 20 May 2026 14:34:40 -0700 (PDT)
X-Received: by 2002:a05:6214:468f:b0:899:f0b1:7332 with SMTP id
 6a1803df08f44-8cc6e483a68mr3756446d6.32.1779312879497; 
 Wed, 20 May 2026 14:34:39 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 16/29] tests/qtest/migration: Use defer for all tests
Date: Wed, 20 May 2026 17:33:44 -0400
Message-ID: <20260520213357.40646-17-peterx@redhat.com>
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

Change all invocations of migrate_start to use defer. The uri
parameter will be removed from that function in subsequent patches.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-11-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/misc-tests.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 8d1cd44183..8216b5d79d 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -28,9 +28,11 @@ static void test_baddest(char *name, MigrateCommon *args)
 
     args->start.hide_stderr = true;
 
-    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
+
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
     migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
     wait_for_migration_fail(from, false);
     migrate_end(from, to, false);
@@ -52,8 +54,7 @@ static void test_analyze_script(char *name, MigrateCommon *args)
         return;
     }
 
-    /* dummy url */
-    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
@@ -69,6 +70,7 @@ static void test_analyze_script(char *name, MigrateCommon *args)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from);
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
     migrate_qmp(from, to, uri, NULL, "{}");
     wait_for_migration_complete(from);
 
@@ -178,13 +180,15 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     QTestState *from, *to;
     QObject *channels;
 
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
+
     /*
      * 'uri' and 'channels' validation is checked even before the migration
      * starts.
@@ -248,7 +252,6 @@ static void test_validate_caps_pair(char *test_path, MigrateCommon *args)
 
 static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer",
     args->connect_uri = "tcp:127.0.0.1:0",
     args->connect_channels = ("[ { ""'channel-type': 'main',"
                               "    'addr': { 'transport': 'socket',"
@@ -263,7 +266,6 @@ static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 
 static void test_validate_uri_channels_none_set(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start.hide_stderr = true;
 
     do_test_validate_uri_channel(args);
-- 
2.53.0


