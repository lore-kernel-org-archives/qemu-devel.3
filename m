Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D429CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RrP-0004uo-2G; Tue, 30 Sep 2025 00:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RrB-0004ku-QJ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rr1-0002ro-2a
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759206039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igMc6h1HM3pQRpz/BTdoMtp4PcxDiZcMQfEFv09YVZ0=;
 b=OwT+ML7jkVWNlp0ykMsHGeWfEg+ubC/yeJJBSwlMrhXdBUJb2KJDu7tD/P9FDOJlyRAwY8
 Ax7izKqyNCDOzFWMAsUH0IOlYCYZYqnsIsOBrON5o8qBb6kwoyv0M27IYa6YY56UPvuuTU
 a3sQ0UIDJFWucnX5LPlzxqIB4+D1WQY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-VelC-x-CO7OWv6DZU_TW7Q-1; Tue, 30 Sep 2025 00:20:34 -0400
X-MC-Unique: VelC-x-CO7OWv6DZU_TW7Q-1
X-Mimecast-MFC-AGG-ID: VelC-x-CO7OWv6DZU_TW7Q_1759206033
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b4f87c691a7so8495475a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759206033; x=1759810833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igMc6h1HM3pQRpz/BTdoMtp4PcxDiZcMQfEFv09YVZ0=;
 b=fmTFeC652NLn6tDkLxH2dTdilI1et8bEVWM/MCC9vsg7Z1HmN+LrerhHKrQ0zwO/Zh
 JIz19FafMaRJNEiM5yOMe0JstcLK7y70hcuHfwzkcZBdgzPEJ7vFhwwsGYXCy7jcXhJl
 phcnFa17kzLCyq0Tih2jJeb+hgdirWr9tZ/ZrsfTDx/7cE9BtCJrO/OllNSl3jDE7rT6
 V1gNm/8mwne98yivBCGUzEr8lMgtWFO3NcXaIkQ3n/QqQb5gqKD6A+O8URAs3ydutWwq
 txnKTEIdWlQYUs46Q5HKBQjusv/FLshUYdxOWwIK8DN69VPbrfVw5OA4/XWDITXYenhT
 1LqQ==
X-Gm-Message-State: AOJu0Yxu3UsLPzGWBJ0o1X6qmq/AmaGRdfcKpyJ3aYLZq7qDl/fUlEMo
 4NSDJK78IQN/IofFRhe2avtZIh3xd1VvEcmJ3GDKJ4Y2YrQQtM7VjHkJUAqbJbYzB4Ex1wogTbk
 HT8EINat1hsNV6LmKMTG2U1TQrSyZqvVV3EiiuncqSPH/z7UBBNSqHFjp
X-Gm-Gg: ASbGnct7jhfuwuWWex4HBeidrjJ8CnAKrengtvs4KSMyPW/s/AXuNb/pyGXyoC0RTcD
 6esgPL3MbhZP9zL1tI5y6YGTqvgcFqqVapRpvaW9EvkahOSfbwU0zkv/lddfvROSKg2DjH56DFx
 Jrt85tld130mhGgza+nb/a7nEiKatZIWHeH50Oig1+ucPD9OQCON5D0nEIjcVrEuYsBiusGW6QI
 EL8FRGbxasuFb8ofvDIt70AAy04G2HYsNuNqLj2NuVkK3S3OoDQNSejFvRlLSRo6ydw2xNz5XML
 uHhmiYJ5PQUS3bWo6yCfmX9qSY4mZFgA7a49FzujaNf6bXzYdb+3vIxZEg==
X-Received: by 2002:a05:6a20:72a5:b0:2c5:f4a:8826 with SMTP id
 adf61e73a8af0-2e7d9da07c2mr23274967637.54.1759206032879; 
 Mon, 29 Sep 2025 21:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKhHKdKXjgV8ghRo3ME71YUMuIA5qe5w4JZUN96t8qm1858G2jEGM/gX3GS0l9VimAO5FNMA==
X-Received: by 2002:a05:6a20:72a5:b0:2c5:f4a:8826 with SMTP id
 adf61e73a8af0-2e7d9da07c2mr23274938637.54.1759206032484; 
 Mon, 29 Sep 2025 21:20:32 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:20:32 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:21 +0530
Subject: [PATCH v15 12/26] migration: Update qemu_file_get_return_path()
 docs and remove dead checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-12-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4011; i=armenon@redhat.com;
 h=from:subject:message-id; bh=tq1dZSNLjlmmOhiP24C3MCRIU5Ho0BTJB1jR+Ld5Ek0=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKMFrmXvLs1MefM2aO91k/eHu5G+fanVtnts1+BseT
 l6UVcfRUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCKp1xn+u+z42uCWcWyntLlQ
 34KFTx5ZSW3eW/+jf6/DuzdO0vfZ/jH8d50oH8ixkM+KrzJLpFApjMtVwOzqxHevXi5YP0GUP/8
 YDwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The documentation of qemu_file_get_return_path() states that it can
return NULL on failure. However, a review of the current implementation
reveals that it is guaranteed that it will always succeed and will never
return NULL.

As a result, the NULL checks post calling the function become redundant.
This commit updates the documentation for the function and removes all
NULL checks throughout the migration code.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c      |  4 ----
 migration/migration.c | 12 ++----------
 migration/qemu-file.c |  1 -
 migration/savevm.c    |  4 ----
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index ad50a3abc9cfa544819a79b9c75a4f538249e6c0..db783f6fa77500386d923dd97e522883027e71d8 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -847,10 +847,6 @@ static void *colo_process_incoming_thread(void *opaque)
     failover_init_state();
 
     mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
-    if (!mis->to_src_file) {
-        error_report("COLO incoming thread: Open QEMUFile to_src_file failed");
-        goto out;
-    }
     /*
      * Note: the communication between Primary side and Secondary side
      * should be sequential, we set the fd to unblocked in migration incoming
diff --git a/migration/migration.c b/migration/migration.c
index cba2a393555053bd18d104b78a3c1bad471c3557..ce17dcc1c0ab46a851cc841d9f397c87f5d43d16 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2656,12 +2656,9 @@ out:
     return NULL;
 }
 
-static int open_return_path_on_source(MigrationState *ms)
+static void open_return_path_on_source(MigrationState *ms)
 {
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
-    if (!ms->rp_state.from_dst_file) {
-        return -1;
-    }
 
     trace_open_return_path_on_source();
 
@@ -2670,8 +2667,6 @@ static int open_return_path_on_source(MigrationState *ms)
     ms->rp_state.rp_thread_created = true;
 
     trace_open_return_path_on_source_continue();
-
-    return 0;
 }
 
 /* Return true if error detected, or false otherwise */
@@ -4022,10 +4017,7 @@ void migration_connect(MigrationState *s, Error *error_in)
      * QEMU uses the return path.
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
-        if (open_return_path_on_source(s)) {
-            error_setg(&local_err, "Unable to open return-path for postcopy");
-            goto fail;
-        }
+        open_return_path_on_source(s);
     }
 
     /*
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 0f4280df21f6357ca3b315c732ce0b5292f3622a..0ee0f48a3ecb1467701727a5c82ba938d653e065 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -125,7 +125,6 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
 
 /*
  * Result: QEMUFile* for a 'return path' for comms in the opposite direction
- *         NULL if not available
  */
 QEMUFile *qemu_file_get_return_path(QEMUFile *f)
 {
diff --git a/migration/savevm.c b/migration/savevm.c
index c1ae36b50a5d602360a47e3818e82954f8694369..eb2a905f32eabccf56f3444d0705409c7d765a0b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2588,10 +2588,6 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
             return 0;
         }
         mis->to_src_file = qemu_file_get_return_path(f);
-        if (!mis->to_src_file) {
-            error_setg(errp, "CMD_OPEN_RETURN_PATH failed");
-            return -1;
-        }
 
         /*
          * Switchover ack is enabled but no device uses it, so send an ACK to

-- 
2.51.0


