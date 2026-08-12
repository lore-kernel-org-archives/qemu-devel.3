Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A3DC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAgh-0008DW-EM; Wed, 12 Aug 2026 11:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAgG-00082i-G0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAgD-0007BF-P0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786547745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iT8zWdwP/JoJO55pCA3wPGlSWkzRKH/4c+aZeB9UMc=;
 b=MQz1k3UtgXQ/38kU3Z7RLtKuT9oCduekoxOCd5eFLpeeZvHdNpxNwJyvMYSWvotEvdkTDX
 hjuXgRir9vgDLTwamKhNO7jYrvFBl+s0HOIeVEle/jras7OrdD/ryhcqoDAh8fXRrgCKI6
 Y5VP1KWzV9rbROixaUfJi+YamXffO0Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-4qchVrk6NSWi7ThBL5m4IQ-1; Wed, 12 Aug 2026 11:15:38 -0400
X-MC-Unique: 4qchVrk6NSWi7ThBL5m4IQ-1
X-Mimecast-MFC-AGG-ID: 4qchVrk6NSWi7ThBL5m4IQ_1786547738
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso10224001cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786547738; x=1787152538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0iT8zWdwP/JoJO55pCA3wPGlSWkzRKH/4c+aZeB9UMc=;
 b=oJ9NoN8V0DyoPpSNanukoD6ZVSVqiFR1k9tWTMEDrwJ5zX5OY07plA9xnyda5wHqSB
 5r2JD1/u/tWUS2zkq8glntWcjlm5AQuBGKOsW9BvBlcTK+qPHZXG3B+S8FJ1cJdSviG0
 UHaS9g+Ek57LJFqUM6npnF3U4vqPnRblamMz1FrcslL6Q8JHU4y6o+GMvEwLAWW7Nxtl
 rjcg18QmXwaaYEfw0meRE5G5W4UAARqAMqL7mgOh3082lM5xoU/RQVgi/d9fNIpk2DHe
 HZOCSWE+GqP31/EEb/Oue5WM3CS6ft8hK7VABngKJ02QUDghpXE78BfDzMH1b3lRLZv3
 rMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547738; x=1787152538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0iT8zWdwP/JoJO55pCA3wPGlSWkzRKH/4c+aZeB9UMc=;
 b=r42fpogVZQgS7TtW8D7GN/0qV4gE1V4G8p5YTTwenRu5dH9vNTOS4hu6mu8swhW0P9
 8vEvUCz3XDpkAXlmkCu5mMTQymi4eupHSt0Q+FX7tEbcr7IkUu6DwrlQeao7JvHy3u1A
 3gnS9kwgKCxpmqYZpBYE6owvrtP2HSI5rAKyOmbDwnv1yMxv7IQWg58MgOjoORRCiYzR
 uBZ26BY9RJSfQDpR5g/qUYxj0WS2M/ZM/u0Oyxua5GGVnZa3rfB8a/8G6NvQCjP1gn43
 Dn4SYudYsBuZmSqVpc8KNMBO83aeECG+y5xxb5jrz0UfDuGEAeB1EkeIeyre9PaQ4fe3
 vvjQ==
X-Gm-Message-State: AOJu0Yza0IKuTBaLBCxQfTX0bYKfLuJ6QPatIIeYPXCSp1lBf/9mXHSb
 VsBxPOTgbuN1T8YV/TqNgno0HWfsOmeePN5weHRoM4GeKhN2nF4bHFgxAg3o0g3lP4ub0pGdy3P
 qdslcYBNJ5Kqf9CoG1RiUH/SkhfgPja/gTTv5xH2M4e75okIam2t9QEBA67XJ5AwIOQ/r1kPHhj
 ZlKW6boWVQbLb6f6O2gy/pfxXW9yTJQKMV3dhN1A==
X-Gm-Gg: AR+sD128sZy6Ho4Bgv2hMnP86AfjSqxXRX21USob/mIe5q5xjIPzWfiXRklBYKXPXlV
 OyMV2tJdgzhonek9VfnDFU2lQFiCPX+dPIexOL2HSs2QpH7tAbhYII5lKy30GyQlKyQ/Li/KJud
 Tq2MCOB+WcW4Of3FQtPayjUT1RKVXfvSIoEjfeZQBvjxZEVdHgPjPLonzyu02llcw5a02/qKFNM
 GJdUpAtdaw2zupPbS2wZs98IRJdFe2T4KhhycB8BHAqHGnpHgpXvxc900NFJHO3BKqGddT4e6ET
 YEpwnBQIX7H2PUlwWUq98E01+zcxFOyeGMjdrRKeRnAQPBIVBuiNlLa5lx1lsMLYRw==
X-Received: by 2002:a05:622a:544b:b0:51b:feee:b08f with SMTP id
 d75a77b69052e-52d657dd626mr41570361cf.1.1786547737902; 
 Wed, 12 Aug 2026 08:15:37 -0700 (PDT)
X-Received: by 2002:a05:622a:544b:b0:51b:feee:b08f with SMTP id
 d75a77b69052e-52d657dd626mr41569571cf.1.1786547737325; 
 Wed, 12 Aug 2026 08:15:37 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d948d6sm19552841cf.15.2026.08.12.08.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:15:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Sam Heney <github@me.samiser.xyz>
Subject: [PULL 06/10] tests/qtest/migration: Only build tls_no_hostname test
 with TASN1
Date: Wed, 12 Aug 2026 11:14:39 -0400
Message-ID: <20260812151444.2611689-7-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812151444.2611689-1-peterx@redhat.com>
References: <20260812151444.2611689-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

From: Sam Heney <github@me.samiser.xyz>

The test_precopy_tcp_tls_no_hostname test and its start hook use
TestMigrateTLSX509 and migrate_hook_start_tls_x509_common(), which
are only defined when CONFIG_TASN1 is set. This means building with
gnutls enabled but libtasn1 unavailable fails:

  ../tests/qtest/migration/tls-tests.c: In function 'migrate_hook_start_tls_x509_no_host':
  ../tests/qtest/migration/tls-tests.c:510:5: error: unknown type name 'TestMigrateTLSX509'

Guard the test with CONFIG_TASN1 like the other x509 tests.

Fixes: df9c38b19af8 ("tests/qtest/migration: Add a NULL parameters test for TLS")
Signed-off-by: Sam Heney <github@me.samiser.xyz>
Link: https://lore.kernel.org/r/5f24de0e-49af-45a7-927f-f79b203bb335@app.fastmail.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/tls-tests.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 827cc7bcf8..9bdb1165af 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -492,6 +492,7 @@ static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
     test_precopy_common(args);
 }
 
+#ifdef CONFIG_TASN1
 static void *
 migrate_hook_start_tls_x509_no_host(QTestState *from, QTestState *to)
 {
@@ -519,7 +520,6 @@ static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
     test_precopy_common(args);
 }
 
-#ifdef CONFIG_TASN1
 static void test_precopy_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
@@ -719,8 +719,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
 
     migration_test_add("/migration/precopy/tcp/no-tls",
                        test_precopy_tcp_no_tls);
+#ifdef CONFIG_TASN1
     migration_test_add("/migration/precopy/tcp/tls/no-hostname",
                        test_precopy_tcp_tls_no_hostname);
+#endif /* CONFIG_TASN1 */
 
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
-- 
2.54.0


