Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C61AC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6xJQ-0000nw-EP; Wed, 16 Sep 2026 17:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIW-0000hZ-EL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIU-0007ZI-1R
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789594564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qaVb+pX+Dprf1Z/whMh/eAqXrLOZN7xKMykck4AAS0Y=;
 b=LzZg54NrQHiqlGqq78bpsDu7nItJHX8btdTiHXN/nkdbabE2qhpJlQ8XsPAHLRclQzhamP
 f/HvWOELkIYGVqwArfc1teec0N47TAhCowfYjTnV1gj9/+KZ76IYurcRWa80HEPxxwAdO1
 CNvyVQc4iNXmeS8h5zoCsB/zGqB3d5Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-jZCSu7vXNyaA4GwSaxD9Zw-1; Wed, 16 Sep 2026 17:36:03 -0400
X-MC-Unique: jZCSu7vXNyaA4GwSaxD9Zw-1
X-Mimecast-MFC-AGG-ID: jZCSu7vXNyaA4GwSaxD9Zw_1789594563
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-530ef845909so1762611cf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 14:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789594562; x=1790199362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qaVb+pX+Dprf1Z/whMh/eAqXrLOZN7xKMykck4AAS0Y=;
 b=fguZplTF1KPA7++SLPajjZOjTbxhffGcIEuvf6Cei80yoyuhF9VE8XzLd3CiEgbdAP
 MaqEfmR0d6MVcJk8BogLlOqMs2g/iBT4p+bgUSmPOKIa83gJ3D5jeX5FpqvQEi4aTDFA
 GVRexVgfYe59hrxo1gTqg//HJrukpoDDlvxy7K/A6g5S/qyrT3UzXLj0gvchQki45S9Q
 oWu+745Na7DZJw/dO3LUWkvNrLvh2XsKAMycsBPPZq54Skde2FwdAcg4LS5X5dmjiuaN
 zaFRcHDdumuwJgLNaYIYlducDyfCcqtBuyajvYlny1odZFw1hMxp/c+O51o/LeX8GD1u
 VXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789594562; x=1790199362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qaVb+pX+Dprf1Z/whMh/eAqXrLOZN7xKMykck4AAS0Y=;
 b=drU/EpOu0wWiYbFYaoZ/E+5pjBRe9EOtoKZHmTC0+3k11kil0W7Y7Vr8Q/t9Gbrbbb
 sj/MM+Z89NEu7OQSYHCEXOO/AYGinbXYcfaVrhCeFd2fTkBnqKN48tYxqynpIVp8iUwG
 J3Ikj4pQMaCHeoXdaO9CwAjz+sGOTvuYV0ouWzODOJuralMMdFVhw+Pt8Y4t5ZvBO7ll
 SdIS+jQ0LPOel4qFDKJZSa8MdE18wqa8qKr+RHS5jo9xWlgghQHjxQ9csO6ln3QyWLtq
 +eORmhJv42HBLIviZdMqZtYQ7SGjEUYCoxjQ4rHZ87gkriwUbntuHKAFBXxh1+QZJFtr
 U2DQ==
X-Gm-Message-State: AFuF++nq4rxci2f7mqv+tintH56x9xcCeQZM1XiuWX4yZX4cXacbzEOM
 Y+2klxbOFzvVEN5a6nUeKuQ7yPInsDBOD28n0hB+Y3OKNRuTy48NDkbQUjx9KL5ISzXyF0NegnO
 bt6h0yl9t6ZtSW594ejWUrjjozApqCcurfxzmqAK7r7nZZwJsFmfhf7gGawDA8vbRB0Xs5aotsf
 KDmGBXCoseR4hTIcKNt9EJC6797Ls+SYZ5eGdXsKyF
X-Gm-Gg: AYBFou0+DYZU59fKmNWmox+LQubKUwFqBWYS+QdzVQQE0GyIqa7V7+s+XGJoz0m5qZt
 9Ne1tpo8gJo5DnHUsPgliSETDV+9zhEczmAtrGRrAHjkeVb+dgqKBIEJFiHXq/ULw99ofuf+AnY
 6kHaPgaXv68d/F6ZbGqQuEnXdWwRE5a/FfYsW07Td2g69SFdu+IQeH0U4irD6x9fneE/yuw+ewV
 Exfr9bFr+1sMKGI4hrD8y76todw+SG37m1+FbZOjSoALer+aPbjPj3dyxzpmU2pFHYiyn8zvdAu
 0PGslxFnYvQ1pQcysBDTp+KeGaYfcgJt+inWcQ479BEbshYW5ialXgOXsd4EcH3ZL51Vx2U0Opl
 neD17cMBvBWm9QgHJs/tkk+qNWZxcJnR59vJq+j7R652rbmropuPb0wB/16g=
X-Received: by 2002:a05:622a:2cc:b0:530:e4fb:60fc with SMTP id
 d75a77b69052e-5327ee1b2bbmr72002001cf.15.1789594562522; 
 Wed, 16 Sep 2026 14:36:02 -0700 (PDT)
X-Received: by 2002:a05:622a:2cc:b0:530:e4fb:60fc with SMTP id
 d75a77b69052e-5327ee1b2bbmr72001641cf.15.1789594561936; 
 Wed, 16 Sep 2026 14:36:01 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53261fd4cc4sm31478721cf.6.2026.09.16.14.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:36:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 1/7] tests/migration-test: Add multifd+postcopy test for
 preempt recovery
Date: Wed, 16 Sep 2026 17:35:52 -0400
Message-ID: <20260916213558.587304-2-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213558.587304-1-peterx@redhat.com>
References: <20260916213558.587304-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We have one for TLS, but we don't have the non-TLS version.  Add it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/postcopy-tests.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 13a5759655..6c4fd31152 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -89,6 +89,15 @@ static void test_multifd_postcopy_preempt(char *name, MigrateCommon *args)
     test_postcopy_common(args);
 }
 
+static void test_multifd_postcopy_preempt_recovery(char *name,
+                                                   MigrateCommon *args)
+{
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
+
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
+}
+
 void migration_test_add_postcopy(MigrationTestEnv *env)
 {
     migration_test_add_postcopy_smoke(env);
@@ -113,6 +122,8 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
                            test_multifd_postcopy);
         migration_test_add("/migration/multifd+postcopy/preempt/plain",
                            test_multifd_postcopy_preempt);
+        migration_test_add("/migration/multifd+postcopy/preempt/recovery/plain",
+                           test_multifd_postcopy_preempt_recovery);
         if (env->is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
-- 
2.55.0


