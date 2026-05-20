Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A006DCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYo-00017d-7B; Wed, 20 May 2026 17:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYm-00015y-LF
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYl-0007FP-0v
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omBGRJjt58xMhL4WgtDR4aWWabcyxt7MDOGFp1172VI=;
 b=UyxBpvRwI5BncfzgfnNvC1wKvFz+iDOAjSHxN4BY/GsALBlkHyrQZdW3cCWMAWfLppRXCP
 4H/QODbpb2Po+qF4whfbLzU5lXSUc5yBwoNn+S029x1wL2RP8VRZpZHJkzOdBZ5aW8mQUt
 lF4XFOxxn8qk2RyEAnEv5UzAv4hP6ng=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-qVs9vceXOnakmWh5EN71Jg-1; Wed, 20 May 2026 17:34:32 -0400
X-MC-Unique: qVs9vceXOnakmWh5EN71Jg-1
X-Mimecast-MFC-AGG-ID: qVs9vceXOnakmWh5EN71Jg_1779312872
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50e423a05c8so151955091cf.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312872; x=1779917672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omBGRJjt58xMhL4WgtDR4aWWabcyxt7MDOGFp1172VI=;
 b=nER9BBDx9XKy/8D4MeGK6w1NrVRwvXopN9bPQYF3VGYEkkY1+mBVA++CyOInAEckBM
 4xm2pKbniZLmE5xraXDOmdU/q55ZUxzdfnioIjnqZV7h9+H3DTuBnYU0CZvpPE+1wvMW
 pnWnQ4iP2siCicX8tSAUxrbMFG1wp5VckvqlmlN8nM8NkgzGSl851wNlexXM1w0DqoZW
 oUTKm+WOlqtKETTgWQBshvWV00NuCZpdsD4ZQ4+VHobmBRRLpOaUAxFAHyiGG2dwYQlI
 7LvRk7kieEPFJLBF2j+wNT9RykbzeJ9mjHeQeMT4/qBJSAEs6SEH6xGQjeD5E5Cq5ZWa
 OiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312872; x=1779917672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=omBGRJjt58xMhL4WgtDR4aWWabcyxt7MDOGFp1172VI=;
 b=QuOe7Zp3yD9rQS1TjWVA6WL9GQa6ea/8gsk6W9CuYIGmDN2Z+cNAB6fG4AkWDZ+lVU
 74rrhLsc6ryu9MRifk2XcnoQp+QYRUD8EfHtlZ/n0RVw3knBl7gy9LrnNJxDgP/j6k3w
 CzpEVCMAZmbU6Isxeatdfnlb766FOC1GFZKch6u6mamSzrDpjmVUJ7Zm/EM2gYg8MU5M
 9dgbrMISIpCGw3qQdgWtnRfUvur+Y0bmSfFMcgFHmTHKAW8GGp8cTEb8liOt3+OoE7ua
 tgaQoIH38gm54CkMFgZ+n7ZxfUkKiCre9QjB+sqDxrp95yz3feRvKY3siwhswsAYswuh
 OcnA==
X-Gm-Message-State: AOJu0Yy/1y/P6qcS0lSPjsReeyByF3Ag4padlOz/MCuQOjZAhMRp+Jbh
 KSU7cTgHb6NPDkc5AwCRoRXzjdL1EFxe+j327zn9Ufg1AKnzvhic7pqWMDAUxhTUPcv6CVrKIoA
 R3X9ErhoNGYCamT3PuxMcFFprf1WuIcpaZPEZXeJCDQinq/FynMWOjbzSG9uJ8UStF6dzrC+lXv
 Pkc26r3VwhCP8G1jYHuEP0+A2QMDK9uXSFUvY77g==
X-Gm-Gg: Acq92OH8oZxQdX7bK2uODcbddElQ8HRyaqr7ulYGNasI/PTKo5MKDfQW4J/8s5sZRgV
 Hzy1i3DurmmU5+esC9c8ofOR66G2eseOmYFcE9AUg0y90cthOo2yrVFxfBcbFelK6qT6OIlF97o
 wZfXl9GYsnZ9Huie1Dmi9Q1/CHcd/P8eHZiM8BDBbvURr5y41E6y+ulgQk/PLQvo9RjC38MlUao
 FIYdOLqxtvkiDJqJHXa8Op0WEZfs6Miff7ujaY1J6CSxwaxBG9romk6+ZJw1+7dmGmMt0Di/gtc
 vHx9nPAFcN4mNCu369Qk5v4K1XlYthkYUcODhTnKZb5Xd1y7a34DeyqBUFy9XzYGTK6I8+sOqgD
 K5eriMS+8R7DhZ4K7O0QagajS0cwalEJl68RtAXcNeytN
X-Received: by 2002:ac8:5d4f:0:b0:516:4f76:aead with SMTP id
 d75a77b69052e-516c5674961mr2490381cf.39.1779312872027; 
 Wed, 20 May 2026 14:34:32 -0700 (PDT)
X-Received: by 2002:ac8:5d4f:0:b0:516:4f76:aead with SMTP id
 d75a77b69052e-516c5674961mr2489821cf.39.1779312871413; 
 Wed, 20 May 2026 14:34:31 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 11/29] tests/qtest/migration: Use precopy_unix_common for
 ignore-shared test
Date: Wed, 20 May 2026 17:33:39 -0400
Message-ID: <20260520213357.40646-12-peterx@redhat.com>
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

The ignore-shared test has the same code as the precopy_common test
but inverting (probably incorrectly) the order of a few event
waits. Change it to use the common code instead.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-6-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/misc-tests.c | 40 ++++++++----------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index e114ac5972..8d1cd44183 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -90,40 +90,22 @@ static void test_analyze_script(char *name, MigrateCommon *args)
 }
 #endif
 
-static void test_ignore_shared(char *name, MigrateCommon *args)
+static void ignore_shared_assert_skipped(QTestState *from, QTestState *to,
+                                         void *data)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    QTestState *from, *to;
-
-    args->start.mem_type = MEM_TYPE_SHMEM;
-    args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
-
-    if (migrate_start(&from, &to, uri, &args->start)) {
-        return;
-    }
-
-    migrate_ensure_non_converge(from);
-    migrate_prepare_for_dirty_mem(from);
-
-    /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
-
-    migrate_qmp(from, to, uri, NULL, "{}");
-
-    migrate_wait_for_dirty_mem(from, to);
-
-    wait_for_stop(from, get_src());
-
-    qtest_qmp_eventwait(to, "RESUME");
-
-    wait_for_serial("dest_serial");
-    wait_for_migration_complete(from);
-
     /* Check whether shared RAM has been really skipped */
     g_assert_cmpint(
         read_ram_property_int(from, "transferred"), <, 4 * 1024 * 1024);
+}
+
+static void test_ignore_shared(char *name, MigrateCommon *args)
+{
+    args->live = true;
+    args->start.mem_type = MEM_TYPE_SHMEM;
+    args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
+    args->end_hook = ignore_shared_assert_skipped;
 
-    migrate_end(from, to, true);
+    test_precopy_unix_common(args);
 }
 
 static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
-- 
2.53.0


