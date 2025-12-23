Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6454E6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Pr-0001iS-Gl; Tue, 23 Dec 2025 09:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Ow-00010u-44
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Ou-0003hJ-2z
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTDOiW/Wq0+UwfLB6nQCcn38uaqN2wIwa/NSTff1+GA=;
 b=IeJnGcnYBuDuiayGjSKK26CoFRszMF0O3blDJamF6HKD8T10je0hXeCCa93P/EqYu+P+N5
 N3aPSZ9JcODM4uIryt3VeeNsh09UAmEWh4bQU2GlKTjWsFLpHe1Ezio/Q4kfFtJN/kU7X4
 JVgiXrPEjOVn6ZpX1mq+XF9jUIQxP0w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-XSmmCwDXMA2eE8Q2D4O1Tg-1; Tue, 23 Dec 2025 09:30:09 -0500
X-MC-Unique: XSmmCwDXMA2eE8Q2D4O1Tg-1
X-Mimecast-MFC-AGG-ID: XSmmCwDXMA2eE8Q2D4O1Tg_1766500209
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b2e19c8558so154710785a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500209; x=1767105009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTDOiW/Wq0+UwfLB6nQCcn38uaqN2wIwa/NSTff1+GA=;
 b=GDh3X7YCCSeTk5i60x9pB8KOQ6kcG2HX5+elUyo7ku/a9Il0ym7MTnF1CWnhnevH7B
 Oa1xXQs82ug+dcg8SChnf06Zik5t08G5CjEdKF5YHDnlF70P4oP+ZmtfEgAdrAUqUFT6
 OWrZKHjQQfbOuOgnWt9Fd1tYBfO/OHvIn7bGAqlf1El8EkoGa6hIeLh25tBR30dHg3xX
 FyJv8oJiZGdbRqb4VKzQ4htD9NcSz6DGuCxlkCEkNy5UIXxVj6k63zEYFHfFlGNd8K5k
 grucCpYXzZb/zK8FnxKCg0e5nrESKQS8iR4wgd2KjhF7pR4RYdkJ02TThbOXo4aPpA+z
 WRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500209; x=1767105009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TTDOiW/Wq0+UwfLB6nQCcn38uaqN2wIwa/NSTff1+GA=;
 b=nurzGzYhGdMAhxbFHm56+vcTnFyXoP0MXcNi8lfE2V4rdeTe07LXrgeiUsrmqAh54s
 4KzackgTZOWSn9Ia+RaSzoDNukcMI6aK6Ryr66c9Zt+C0LhfrqFHtOUqHj+lzHqQeiLp
 9/mfR8ltWGdY+RFM/YqHm+x7Lpa4ixt8wA5D9arCs9Pzg4DbA3/9gEJQK0JFTOOMuWli
 TM4qWHrXUbA9f1DHFFNAL6yXfc9c5T2jTnxX0r8+b8PTOFIdhHMCn5mgwixZaeuj0DG0
 KGpLdjGxLe4LZ6n0aAXcmPTTdEqnGroasPYr/ENUlxzW6ghEaazlUR8TjaS/sMNIiF6d
 jLoA==
X-Gm-Message-State: AOJu0Yy87x7BnEd6p2e18Bi18yJwnwLi9dfEvgGfIkQaB0voxYYCtipi
 za/QrgP+w6ixIoSAXodvFBGMI/g3vlKSO+jCsHR1EnclcHiIKa0mS68wTi8QiRobt9jJFLvuw9X
 ZkTs+CcrdfMqQtK1lummP513g6AnpuC+SK+k9eX3aFEe2Zdv/0AJGQ1v508ux0J8Sfvtpiv//sZ
 dt9iZOIG+PQagwX2/fT8aezXrBiaEhNwq3wtuGuQ==
X-Gm-Gg: AY/fxX6pUqjGCwfY8pUhJzcjPWlvOKW6KjaoxjGqpPYTDRqj3f6cMZ8LS35HGpqLARK
 dq8Duxfc1YMcojo5RRBYjovoyn12/dJKg0Dwx2HWOmGylkpybHu7V4k++eDuk0bItkrHN+FOPYy
 IH0cjbAlo+d6sSzV1mIucd9J1Xt44i9AGUEAcBZFc/VChViAO5zq4gcsu03PNTqzMQQhop2FpFP
 VcVbhe1/OISLnuQg0n0dfPRMXqgIfqdaWX4ZK/mC/JYiWjWzc5+C4/d+EAAlaJ3Vf9Nju9Mdow8
 W6buPyL1BvfWpK9knVB6qgFq59NKEcqUxQ3r5+y5gFvRWEiCtbtmPZoBe2ylWbimnVOMNgsdB6i
 A+LE=
X-Received: by 2002:a05:620a:294a:b0:8b3:c8ee:7240 with SMTP id
 af79cd13be357-8c08fc00b94mr2500177685a.5.1766500208979; 
 Tue, 23 Dec 2025 06:30:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzV/VTqm5/++H2CUARLN9+xV4/hHr9kAxP1KKfkimPuz1hf0BDyCf+QmHJSiyn639yJivm+w==
X-Received: by 2002:a05:620a:294a:b0:8b3:c8ee:7240 with SMTP id
 af79cd13be357-8c08fc00b94mr2500165785a.5.1766500208081; 
 Tue, 23 Dec 2025 06:30:08 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:07 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 05/31] migration: Use explicit error_free() instead of g_autoptr
Date: Tue, 23 Dec 2025 09:29:33 -0500
Message-ID: <20251223142959.1460293-6-peterx@redhat.com>
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

There're only two use cases of g_autoptr to free Error objects in migration
code paths.

Due to the nature of how Error should be used (normally ownership will be
passed over to Error APIs, like error_report_err), auto-free functions may
be error prone on its own.  The auto cleanup function was merged without
proper review, as pointed out by Dan and Markus:

https://lore.kernel.org/r/aSWSLMi6ZhTCS_p2@redhat.com

Remove the two use cases so that we can remove the auto cleanup function,
hence suggest to not use auto frees for Errors.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20251201194510.1121221-2-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-device-state.c | 3 ++-
 migration/savevm.c               | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index fce64f00b0..db3239fef5 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -140,7 +140,7 @@ static void multifd_device_state_save_thread_data_free(void *opaque)
 static int multifd_device_state_save_thread(void *opaque)
 {
     SaveCompletePrecopyThreadData *data = opaque;
-    g_autoptr(Error) local_err = NULL;
+    Error *local_err = NULL;
 
     if (!data->hdlr(data, &local_err)) {
         MigrationState *s = migrate_get_current();
@@ -159,6 +159,7 @@ static int multifd_device_state_save_thread(void *opaque)
          * return we end setting is purely arbitrary.
          */
         migrate_set_error(s, local_err);
+        error_free(local_err);
     }
 
     return 0;
diff --git a/migration/savevm.c b/migration/savevm.c
index 62cc2ce25c..638e9b364f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2823,7 +2823,7 @@ static int qemu_loadvm_load_thread(void *thread_opaque)
 {
     struct LoadThreadData *data = thread_opaque;
     MigrationIncomingState *mis = migration_incoming_get_current();
-    g_autoptr(Error) local_err = NULL;
+    Error *local_err = NULL;
 
     if (!data->function(data->opaque, &mis->load_threads_abort, &local_err)) {
         MigrationState *s = migrate_get_current();
@@ -2841,6 +2841,7 @@ static int qemu_loadvm_load_thread(void *thread_opaque)
          * return we end setting is purely arbitrary.
          */
         migrate_set_error(s, local_err);
+        error_free(local_err);
     }
 
     return 0;
-- 
2.50.1


