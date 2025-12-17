Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E03D66B81
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 18:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwON-0006AI-6w; Wed, 17 Dec 2025 13:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVwNj-00068K-NV
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:36:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVwNg-0006vL-UG
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765996565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9dPzT6oTL8iJdcxVdO4U/j/xp5SBdiCDDzdyfsNCI1Y=;
 b=E2vGbDV15MSSXnPckcKJ6TKgnAqsdqd/BUGuOUKjjdsCACtKwymnuJeQRii9Ip/StZUUdH
 ULuTXT7gGxd1ShZZKknufiku/NPbUzwrSAxvuJPgeCz49qgDxaa316fHXih5uCbva714PT
 2dDXBt+3omFtq3mL9P+tZ/cgGvXguvE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-Sg1BogX3NdmwD0NFe02Bkw-1; Wed, 17 Dec 2025 13:36:04 -0500
X-MC-Unique: Sg1BogX3NdmwD0NFe02Bkw-1
X-Mimecast-MFC-AGG-ID: Sg1BogX3NdmwD0NFe02Bkw_1765996558
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7b9090d9f2eso10432431b3a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 10:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765996557; x=1766601357; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9dPzT6oTL8iJdcxVdO4U/j/xp5SBdiCDDzdyfsNCI1Y=;
 b=XR0tnHYtSK7u7N+CMHRbiBZYEFVcXQRry31c/sQEwrUy2zD3ky9OXS8kCuG3hflElg
 1zEP5XsJoRFvz3k5qpAjTv+5yGsu4fut863QtP62Hi4eWcehjvc2y9Mr9pqu/3FFKD99
 /yRGOLJhGy06Kk61U/oYV5UygKQYoKJulM1I20XD3kPWJqJUr4njZ2J7gzUm4MB/tyMa
 gcfPUeSPTy89xtcQQx5qNRNb+UJLZso63U1ASbNZyhYgPjym+T+MgNesQZeeEv13TdK0
 vMxxqq8lspVyjOy3mt/iByzKURSJ9q3tQ2z7mJNkWxsDGdlVKijxU0gGK7UHutX9O7nv
 MKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765996557; x=1766601357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9dPzT6oTL8iJdcxVdO4U/j/xp5SBdiCDDzdyfsNCI1Y=;
 b=L7UGZXMXap02ABOisL3ryu9TgdmsU1hUf/GB8WS9cSf/1H1zac1vXbTbSjkDY9OejD
 iZyL4/X38lRgDVSWLR8EKf2xXXWRuchh0lW9Sw2uDi1qdAiq3/ZG0oCI13u7FaSUlvKG
 A3F4lg0rsAiBUsZ6yE3yWwKUAZ7Kux0s8/dTJgnbjoxLxYArzKetzbpABr28BRjojc9Q
 qcYZpfoa3bZUhFu+El7U2EQhdsKz3kqv7/BIIOBAZkXCnxSvfk0BO2N60UWJgA9X/7ah
 3ADXkF6PCf2VcHIwXOp2EhMRdD8y6xGqfQp2iuhnA2x0od+Rx2Wqxvw39JkMdSKw1SJ+
 mOhQ==
X-Gm-Message-State: AOJu0YxClmHgo7bQoBCstXLpZ4RJNLw5Gw+JmbTEScp5K9i1DfNXsaAD
 z8nmo2Q8Wee69XO2Ty6awPBtMsvdsxOTgMn2UeqKMswbluG7YEmMW2noouZL7CzzvCiNL4UwZSX
 matmPrTeIeDPZcicdyIdSUmeoYKAwLPCy01FjW4MsJ+m6VucrvN8xY+9D
X-Gm-Gg: AY/fxX7Cvzas+j2EMGfl4dCl/+PllE6vY7vmoXwqANPkEmlT9gic/5wlJXF20DKa/eF
 G5o+RKFYWcI39dNaWFu3cee6tOYi7UGFlurzPmc6dCzUXyAOH9uWxEzYl3ZQBRFZe+tiU0+waNa
 0eTyI50cbCxtJytUVIlj07eBkTvSnd39lszzHQAJ6R1UoO8QpklUsiWSpD0sRt3039pUMETCI4y
 H1oP3xCNWMV5dNvoxqn7+79BDemlZ3cEvGmJtfIdHIBsivo9S81CZR2NulnpD4dPHmwdJfychCr
 9IK7rOTbqCfkSDlXd23y4UOVM48vlpFIPRTSaY5OMCLapI8/FGI2LRCu4pF7tkdlzokVz8r/grr
 zruU=
X-Received: by 2002:a05:6a00:2986:b0:7e8:4398:b34e with SMTP id
 d2e1a72fcca58-7f6691b29a1mr19813118b3a.33.1765996557360; 
 Wed, 17 Dec 2025 10:35:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoUnkCq3JD9WZvS+UbUJn1ky3DcMp0b+9NZNA2eUUjF376KOUO4peBd9xgAGd8LFuhKWdZqQ==
X-Received: by 2002:a05:6a00:2986:b0:7e8:4398:b34e with SMTP id
 d2e1a72fcca58-7f6691b29a1mr19813097b3a.33.1765996556905; 
 Wed, 17 Dec 2025 10:35:56 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fe13d85186sm152010b3a.40.2025.12.17.10.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 10:35:56 -0800 (PST)
Date: Wed, 17 Dec 2025 13:35:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 25/51] tests/qtest/migration: Pass MigrateCommon into
 test functions
Message-ID: <aUL4BpoD81k17ZZY@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-26-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-26-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Dec 15, 2025 at 07:00:11PM -0300, Fabiano Rosas wrote:
> With the upcoming addition of the config QDict, the tests will need a
> better way of managing the memory of the test data than putting the
> test arguments on the stack of the test functions. The config QDict
> will need to be merged into the arguments of migrate_qmp* functions,
> which causes a refcount increment, so the test functions would need to
> allocate and deref the config QDict themselves.
> 
> A better approach is to already pass the arguments into the test
> functions and do the memory management in the existing wrapper. There
> is already migration_test_destroy(), which is called for every test.

This patch has a conflict with the other mapped-ram fix patch queued for
11.0 already:

https://lore.kernel.org/all/20251126121233.542473-1-pzmarzly0@gmail.com/

I'll squash this fixup into this patch when sending the pull:

From 5a772b9f992d87055151ab3a026e08b8dc87409e Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 17 Dec 2025 13:31:08 -0500
Subject: [PATCH] fixup! tests/qtest/migration: Pass MigrateCommon into test
 functions

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/file-tests.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index c4c3016f0a..5d1b861cf6 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -281,20 +281,18 @@ static void migration_test_add_file_smoke(MigrationTestEnv *env)
                        test_multifd_file_mapped_ram_dio);
 }
 
-static void test_precopy_file_mapped_ram_ignore_shared(void)
+static void
+test_precopy_file_mapped_ram_ignore_shared(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-            .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
-        },
-    };
-
-    test_file_common(&args, true);
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
+
+    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
+    args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
+
+    test_file_common(args, true);
 }
 
 void migration_test_add_file(MigrationTestEnv *env)
-- 
2.50.1


-- 
Peter Xu


