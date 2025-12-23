Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE496E6F099
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3QM-0003Jc-O8; Tue, 23 Dec 2025 09:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Pb-0001P0-4J
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PT-0003rv-KE
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fp4ZOzYBAvn1TvsTfSPIyPaAQ9Z1cZ4fCzi5usLsWzY=;
 b=MLGtMDWeZhb4THRwL/oOFIr7dKy/iJGqcW6Y+SP5hjCC5A8mQzE5iq63L+RQlXQdoAQ+Du
 nVBHpkiDxEjg5hUOIm92gLXv8luEuPxXFuVPNXhj+O18B+UzmiGZ4xSPPSAuHAWJ++c8JQ
 fqFod5BqfhRwcrWSFINnPTax+o4Th8Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-E9te049kN_O0ZUW3ppeKrQ-1; Tue, 23 Dec 2025 09:30:44 -0500
X-MC-Unique: E9te049kN_O0ZUW3ppeKrQ-1
X-Mimecast-MFC-AGG-ID: E9te049kN_O0ZUW3ppeKrQ_1766500244
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b9ff555d2dso1203549785a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500243; x=1767105043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fp4ZOzYBAvn1TvsTfSPIyPaAQ9Z1cZ4fCzi5usLsWzY=;
 b=EPMYWjP2UxbSXMvVxgTKV6VcQieUXo5cnlDn/C0mzoRjpJTBEhab5pgIciBO+0OuPK
 Dxj5zXvcR5Sg8O/UmkJRR9EQQvoo26+ecu2y1vYJQ833fFiZscOsg6pYpKRjUQfyGnSf
 4hJwO473NeRj6X3iKRdHO58kd07aTXUJ1WxMCHnti2Ri/9pblriO/nroa/ESVE1bB7Qh
 8qHtySGorkGZsm7iR5is4dE5soyLHRksqjZaWKbYPPZtR1tlXkh5gvChhMselIXHqyI8
 SFp4MlCtV1rqUWlGXopy/Se2y4AIN2RyR7+aLyXt2KEixICRUg8em8Whc+k27yy5T8Zu
 Swmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500243; x=1767105043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fp4ZOzYBAvn1TvsTfSPIyPaAQ9Z1cZ4fCzi5usLsWzY=;
 b=gODdo9DOvPl+sThA+VJ3bjpbqxoeg6x/t4Th03PZl9raw9rsxRQi02xHx+6K7i9BUo
 61XpBQkhAja/mJdssOXW+nM93GAM3NutVd5DPlMIrwgbYC7p8c5u74P79rupzILBtYsa
 ruFQl+qVu9PUiM1ERfTATdG/dQQ/UDf7PWt15AKgbr0A7mwQghwSs2lN/eBUjZxGXz3m
 saDBrmRpZai3sHlQ/XuaKxx/pQqSBUF+dQMJh+7+z+tBzSWs422Bau738Jj1C7iA509j
 lCXIvSduqoZdMDwgcRIn8nXUv7dwKWHhXfXgPTKvexoxxjHlZM+QHYpKGTIgvgl4vXY3
 tzPg==
X-Gm-Message-State: AOJu0YyCdvFDA6X0I8I97N+ZZlF0yUC2eU8FcGL3UOgvHsx1kXwqT8UR
 SqapwsnThsN5OgySd9Nnb5biCxIVMYsvZOeG0k2zrYofBlyUdAm74qMcPbO/y9osArOHCHq0aYN
 SBz4FKi3RWLNZNS7hFoeCHorU+0TG3E/PsWM5JaoK2zasoXLVRFll+dF87BbIxHq7bdoIFOpW1A
 zet3JzdR9k9feW0GxT/qh/d2xlMNd9EfTuVFxvLA==
X-Gm-Gg: AY/fxX4aPso2OMJFkw08zQLMdhk4DpZ7s20hp8BUTu0v+2Kxso83P3VD7Wdr+R/D872
 VAAEFAlDRSjinUupSgqxdgwCEYzhp/m0saf5/K3H4z2tijVnVei57p3sPNg2CikoTMM4+ho6P+z
 4YPXoJWVdvJtbCyrIva9tPh8lSjbFCL/2HQ48Pj5QiC8Z3zIHCwoh/UMfi/JseYnu/5dew080gr
 THMc9Afpp5aw9a++ebzAQpLYTP7k4GVFBtASjcr6ekgjhAysKc70DWBk2l8wHA5LdBZaGrFETl/
 JpOtqpYe1VWU/RlcHruK6wEAoFUwnoLved50573zgW5LD/cmCbOvq9tK4RRTRIWcIBzfZb2vcuF
 wt7Q=
X-Received: by 2002:a05:620a:198e:b0:8b2:e533:66f7 with SMTP id
 af79cd13be357-8c08f655061mr2161591985a.10.1766500238481; 
 Tue, 23 Dec 2025 06:30:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0WAclwNbrI8wZapYDsbuZMhGhvONV2TlgDZ65d9ODeSK2sQgfCqNT+jy1Rx8a+pm0u3Ksog==
X-Received: by 2002:a05:620a:198e:b0:8b2:e533:66f7 with SMTP id
 af79cd13be357-8c08f655061mr2161583985a.10.1766500237925; 
 Tue, 23 Dec 2025 06:30:37 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:37 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 29/31] tests/qtest/migration: Pass MigrateStart into cancel
 tests
Date: Tue, 23 Dec 2025 09:29:57 -0500
Message-ID: <20251223142959.1460293-30-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Fabiano Rosas <farosas@suse.de>

Pass the "args" parameter to the cancel tests so they can access the
config object which will be part of this struct.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251215220041.12657-27-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/precopy-tests.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 086d06a31c..aca7ed51ef 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -642,7 +642,8 @@ static void test_multifd_postcopy_tcp_cancel(char *name, MigrateCommon *args)
 }
 
 static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
-                                         const char *uri, const char *phase)
+                                         const char *uri, const char *phase,
+                                         MigrateStart *args)
 {
     /*
      * No migrate_incoming_qmp() at the start to force source into
@@ -669,7 +670,8 @@ static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
 }
 
 static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
-                                            const char *uri, const char *phase)
+                                            const char *uri, const char *phase,
+                                            MigrateStart *args)
 {
     migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
 
@@ -693,7 +695,8 @@ static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
 }
 
 static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
-                                           const char *uri, const char *phase)
+                                           const char *uri, const char *phase,
+                                           MigrateStart *args)
 {
     migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
 
@@ -714,7 +717,8 @@ static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
 }
 
 static void test_cancel_src_after_none(QTestState *from, QTestState *to,
-                                       const char *uri, const char *phase)
+                                       const char *uri, const char *phase,
+                                       MigrateStart *args)
 {
     /*
      * Test that cancelling without a migration happening does not
@@ -735,7 +739,8 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
 }
 
 static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
-                                           const char *uri, const char *phase)
+                                           const char *uri, const char *phase,
+                                           MigrateStart *args)
 {
     migrate_set_capability(from, "pause-before-switchover", true);
     migrate_set_capability(to, "pause-before-switchover", true);
@@ -775,20 +780,20 @@ static void test_cancel_src_after_status(char *test_path, MigrateCommon *args)
 
     if (g_str_equal(phase, "cancelling") ||
         g_str_equal(phase, "cancelled")) {
-        test_cancel_src_after_cancelled(from, to, uri, phase);
+        test_cancel_src_after_cancelled(from, to, uri, phase, &args->start);
 
     } else if (g_str_equal(phase, "completed")) {
-        test_cancel_src_after_complete(from, to, uri, phase);
+        test_cancel_src_after_complete(from, to, uri, phase, &args->start);
 
     } else if (g_str_equal(phase, "failed")) {
-        test_cancel_src_after_failed(from, to, uri, phase);
+        test_cancel_src_after_failed(from, to, uri, phase, &args->start);
 
     } else if (g_str_equal(phase, "none")) {
-        test_cancel_src_after_none(from, to, uri, phase);
+        test_cancel_src_after_none(from, to, uri, phase, &args->start);
 
     } else {
         /* any state that comes before pre-switchover */
-        test_cancel_src_pre_switchover(from, to, uri, phase);
+        test_cancel_src_pre_switchover(from, to, uri, phase, &args->start);
     }
 
     migrate_end(from, to, false);
-- 
2.50.1


