Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB8ACD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMO-0004c3-2W; Tue, 05 May 2026 16:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMK-0004X0-3n
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMH-0002f6-7C
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZOv4dkPxbigP2amkOsD1OyD2ureHpWxPWa9Eo8OsVWA=;
 b=c732tGR74BukJZx/YQhdkp/BCRGM60DbD5zLPH0hbWmoKQFtk8lAWNb/j8mn1f7FFgiyZ2
 JWuVRpAJH80IKUJrd6eRdePt0Vdgi7kBRBFq1x6c11gEa9yIycUiP9HOeDii9bTPAfPR/1
 Kj7l45UZtc5iLGHIQSLdBsmw7jrN5Cg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-pjZ11YRgOFGhEb71RgYl_A-1; Tue, 05 May 2026 16:27:06 -0400
X-MC-Unique: pjZ11YRgOFGhEb71RgYl_A-1
X-Mimecast-MFC-AGG-ID: pjZ11YRgOFGhEb71RgYl_A_1778012826
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-902e1e4f8ccso341009185a.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012825; x=1778617625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOv4dkPxbigP2amkOsD1OyD2ureHpWxPWa9Eo8OsVWA=;
 b=BfCcGKoPXrI/ouYOhelUYpBg+Wf+k1EbRIQgJF/gQXRYyRnmQRG0oA6AdwAee/F6By
 xoExRXSp9Ash5eR/Ww9SlQUNtSUa8Qfoyidoobx10f30zy2LvLRu1WLGcOD6wLLWUobd
 6k/lB5EzPKg1x4FRMcPX80ZrcjK8/osUsM0Z7QGX6uuVS45U13ikGaLYvfd+/GbodBcp
 kwlXt3an085yOxr1jsFdSiRWZGEg/dnTQhVXEl82IJ0kuVGJMscAMlQQp1nK/pwkFI5X
 6et0lheNVdwwTsIvxpGnT5KTIKEqoAxDQz/9mw9R4yiNndYzGT3sdigWSs8xRhkyzsN0
 e7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012825; x=1778617625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZOv4dkPxbigP2amkOsD1OyD2ureHpWxPWa9Eo8OsVWA=;
 b=dxQfmEEyS4YLpH3LwbHFZ2y2LJqhFmf5gkFwVQ/pi/HjL60/ZXWz8+kum9imWSouu5
 7xcysXZdbchGSFkOrFSoQCE/0iWuxoDi1+22ddh8jwmEyPk0Iemxh/rJSxYPYhqmFHw0
 qj+HvFp0Ac7F2kBJ2fSuM/FrTEXM+WbCyeNTVdZJHt6KdWM9RN0MtMVAWfHeMrSJ3LRG
 Me3Uw0lHp3wG3+ms8ss7EXqtpWIZzKYTPdCiGLk3sgJF+sfXoJVDBjDyU8wxFztQ8EXx
 Z0oX1ZA1Ke0RCLj/FUyBuChMboJMLtyB0p1/Q7tQ4aAu7oSftLtp7gdeuAnAhPYpI917
 xLtg==
X-Gm-Message-State: AOJu0Yzs8sTpMPpYYFiVQ2+3nn2vUICBQHYQT10RhTk6FZr4uPY/zgsJ
 DMsFJLBs0ICh8kg1Q1XGjopsi/t4mvDjPyXGinyfhM22guIj324HVUL6k0Jm/r3TKJ1cjoggO/1
 8XUv2r8P8KD3Ah2o5ohO0KrZi3iFbaw1K4bezU0tT8Bs20bYFQqsMd9S9HTNzfot7YRK7iK9h4T
 Ja0GArs3EykPv+sNMUSn7/bFy6JKWOexy3HqHuSA==
X-Gm-Gg: AeBDievwjsBvO17oJlxVMX7OpQEkGP4SbWLUnri3XqzZbVA0zoKrUkJyiTnXreFwrhW
 IqkEjemZV9qlsZtikrOS1f21Ih+3h4lcNCuQSmO/5k9rzAOQUvRarjxtr+4IKmpHV7n8zumEJya
 fbQIy0mTg7A+xSZm2H5koE9KaC79B9E1v8gXm++tndjAgULryjxLtCHY/y4JRSrM0OX1W+j7MXn
 b4d5wqIpY1cLB2KUJFIGb4P6M9kUIEnpBGYlkrfg6uiTnEkOMwNvgLgpaYs4SI9eKzx0JHrdWMw
 qOPdUiVj6RyYJPZu6sfgd02LduhOTiDQ5UFENOj8GUwL5D1oOPX9IoaJYRj8t/kEa4f3oaQxooj
 jbm/Lyypl9JcnJy6cnYNflYYaLuR+89hIZLnHsQt/0H5qMWG4bHNXReo=
X-Received: by 2002:a05:620a:280e:b0:8f0:10b0:9e4a with SMTP id
 af79cd13be357-904d6fcc196mr91062185a.57.1778012825154; 
 Tue, 05 May 2026 13:27:05 -0700 (PDT)
X-Received: by 2002:a05:620a:280e:b0:8f0:10b0:9e4a with SMTP id
 af79cd13be357-904d6fcc196mr91057385a.57.1778012824538; 
 Tue, 05 May 2026 13:27:04 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:27:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/23] vfio/migration: Add tracepoints for precopy/stopcopy
 query ioctls
Date: Tue,  5 May 2026 16:26:35 -0400
Message-ID: <20260505202640.1011006-19-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

Add two tracepoints for both precopy and stopcopy query ioctls.  When at
it, add one warn_report_once() for each of them when it fails.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20260421202110.306051-17-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration.c  | 35 +++++++++++++++++++++++++----------
 hw/vfio/trace-events |  2 ++
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index e6e6a0d53d..150e28656e 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -329,6 +329,7 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
     struct vfio_device_feature_mig_data_size *mig_data_size =
         (struct vfio_device_feature_mig_data_size *)feature->data;
     VFIOMigration *migration = vbasedev->migration;
+    int ret;
 
     feature->argsz = sizeof(buf);
     feature->flags =
@@ -340,12 +341,19 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
          * is reported so downtime limit won't be violated.
          */
         migration->stopcopy_size = VFIO_MIG_STOP_COPY_SIZE;
-        return -errno;
+        ret = -errno;
+        warn_report_once("VFIO device %s ioctl(VFIO_DEVICE_FEATURE) on "
+                         "VFIO_DEVICE_FEATURE_MIG_DATA_SIZE failed (%d)",
+                         vbasedev->name, ret);
+    } else {
+        migration->stopcopy_size = mig_data_size->stop_copy_length;
+        ret = 0;
     }
 
-    migration->stopcopy_size = mig_data_size->stop_copy_length;
+    trace_vfio_query_stop_copy_size(vbasedev->name,
+                                    migration->stopcopy_size, ret);
 
-    return 0;
+    return ret;
 }
 
 static int vfio_query_precopy_size(VFIOMigration *migration)
@@ -353,18 +361,25 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
     struct vfio_precopy_info precopy = {
         .argsz = sizeof(precopy),
     };
-
-    migration->precopy_init_size = 0;
-    migration->precopy_dirty_size = 0;
+    int ret;
 
     if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
-        return -errno;
+        migration->precopy_init_size = 0;
+        migration->precopy_dirty_size = 0;
+        ret = -errno;
+        warn_report_once("VFIO device %s ioctl(VFIO_MIG_GET_PRECOPY_INFO) "
+                         "failed (%d)", migration->vbasedev->name, ret);
+    } else {
+        migration->precopy_init_size = precopy.initial_bytes;
+        migration->precopy_dirty_size = precopy.dirty_bytes;
+        ret = 0;
     }
 
-    migration->precopy_init_size = precopy.initial_bytes;
-    migration->precopy_dirty_size = precopy.dirty_bytes;
+    trace_vfio_query_precopy_size(migration->vbasedev->name,
+                                  migration->precopy_init_size,
+                                  migration->precopy_dirty_size, ret);
 
-    return 0;
+    return ret;
 }
 
 /* Returns the size of saved data on success and -errno on error */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 287df0b8cb..2049159015 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -162,6 +162,8 @@ vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
 vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
+vfio_query_precopy_size(const char *name, uint64_t init_size, uint64_t dirty_size, int ret) " (%s) init %"PRIu64" dirty %"PRIu64" ret %d"
+vfio_query_stop_copy_size(const char *name, uint64_t size, int ret) " (%s) stopcopy size %"PRIu64" ret %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
 vfio_save_cleanup(const char *name) " (%s)"
-- 
2.53.0


