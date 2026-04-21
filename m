Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFC8F94CAB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbO-00017p-Mk; Tue, 21 Apr 2026 16:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbM-00014U-UT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbL-0008UI-9i
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3YojhZNR/NVuUisrNqEPFb2MauGl3eXRbOu4+fMvCA=;
 b=GH4ibqgRV0Rnunv3B+P7DzgP4cu+xh3cgCRVLxwGoLI2sfinNQfzT5xB2CrtehMqcJQhFh
 5zHuxKGcJ2ehykMDQnIFuAsZPHiYQVd7ZyZewT9FRT62m9l5tWna/JYF2LyP0bN6Pq5DvR
 i5qCgGwDJ5nauB5ZwAcVDpdYdYFHVqs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172--xusRwE7Nxa80_PQyywIMw-1; Tue, 21 Apr 2026 16:21:41 -0400
X-MC-Unique: -xusRwE7Nxa80_PQyywIMw-1
X-Mimecast-MFC-AGG-ID: -xusRwE7Nxa80_PQyywIMw_1776802901
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8ee454b1b8cso144981785a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802900; x=1777407700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3YojhZNR/NVuUisrNqEPFb2MauGl3eXRbOu4+fMvCA=;
 b=A64XHWaXUKUk0+6SoxhymE8ri9Jcd3Bf2kWaTrSPjubEx/qHjrgnCkTUnP/pu/7/F/
 o+2Df4e0UIOIhuoDleYgEP3IT7B4fMkTD9PNzxh5iI+vtEK1ZR87qz2vU8T+7Voc3RNf
 /Xbr9f+RY1RCyDAz6VlLRnXKo+I6v3DRQjXoaCz1OhTv2c4i7luCIIhWHBqGqPpOe7lB
 frDT7TdP5S7KMEo3MC0D+1t/K8Twupr37e7jLOefnfV9oxizZEaOuI6NW9aYnixnMFab
 i86w+ndoX9JHGn0i2104wp0skVn9Y+gBi3BVY/9O0hz3BEHooUl0wfdw2FFgMTQKHkOg
 kt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802900; x=1777407700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z3YojhZNR/NVuUisrNqEPFb2MauGl3eXRbOu4+fMvCA=;
 b=YdexGFJaedQM9y+Uk0J0lnRpz985a5RhXfeHvNi0PE0MWtKrrwUQQ71UybhZuKHv8Y
 S7xfd5g6o88GaHje4Kow+7CEkcTLAM/AAnEmZp3KwzrmC/Op+VNswPZ/ZN547miH/5i8
 ccL8vxgtomRgwmj9i1M8u19eR+5+w25+iN2Rf9I4nkUAAVixTiBmz0L+eCZmIDAlHM1F
 FW4nciG1yGaIxRn0iCwrr8cRhEt8LfqwnUxZF+xdbvtMJSYn7LvG/3ywF/O1JZ0ks7jT
 1Ok19QzVkXR3Tqi0eRHdKef7PVi0wvum2P6rQfYtf/ujbwBYI/rDxUb+NN9UVGvp42QZ
 /3Kg==
X-Gm-Message-State: AOJu0Yxdxb2r7iq8jvC2HxbJUg6bnFgwKwZQS0NT62JznQHrSegJ1puJ
 iAlecBiYhVsyxi/b3MeNyt0A0tzGkvTUntZ68Rz8lSLTHhCtF5FJaVNIxm7BrZWZDlmreProC6J
 ss+vX0OaGEodX/w2DiXI1iWG9nhSYJ2vC5/Jt70ehRtOr7txefGXe15xd5YIPZuZ8UHdd62xFAs
 k5xVar8667fCN8zODBqUtMjcIeGaKazKBIGnmpvA==
X-Gm-Gg: AeBDietK2Lvmmr98i7YtnqCgKzzeE1vMfSj9NjloY/K4MvGovuh69EjphsAbylh5mpz
 fVKPZjGuXvwBounDtqjTc9A9P6P2wfbmZJM1YGNeyXnRM2UGSyT0Nip09RqoXodYIpfEBO9hQgf
 3BYRIPASeD5Z9s3U25F+11zfcbc9ck5GXtymxYGwpdajSNr8yy1ov+rnaC1CkE8D1iIfFkXWsgS
 qvp7kSq/QAtF1GDDgbLQl24ZP71Bqbc6QLc2KSOZFf7KnsESVO9iJOMt+EPGosuWG/FiekxwDsi
 M+tjSOieHN+FjeXm9zZjCk6mH1KfboZ3+RVQINLXGyMGHeq7Pkm7ZpWy8kvy+4l3RDMSJ0QAy5E
 1yJmQE8Rv6MePIyrKiZWUiEEfqnK/gvTPmyOaC4Q9bI/XOk4cZiMGnna3Rw==
X-Received: by 2002:a05:6214:4345:b0:8ac:adbe:fc8d with SMTP id
 6a1803df08f44-8b028015007mr303162626d6.8.1776802900470; 
 Tue, 21 Apr 2026 13:21:40 -0700 (PDT)
X-Received: by 2002:a05:6214:4345:b0:8ac:adbe:fc8d with SMTP id
 6a1803df08f44-8b028015007mr303161776d6.8.1776802899631; 
 Tue, 21 Apr 2026 13:21:39 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 16/16] vfio/migration: Add tracepoints for precopy/stopcopy
 query ioctls
Date: Tue, 21 Apr 2026 16:21:10 -0400
Message-ID: <20260421202110.306051-17-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Add two tracepoints for both precopy and stopcopy query ioctls.  When at
it, add one warn_report_once() for each of them when it fails.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration.c  | 33 +++++++++++++++++++++++----------
 hw/vfio/trace-events |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index e6e6a0d53d..04d9f94edb 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -329,6 +329,7 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
     struct vfio_device_feature_mig_data_size *mig_data_size =
         (struct vfio_device_feature_mig_data_size *)feature->data;
     VFIOMigration *migration = vbasedev->migration;
+    int ret;
 
     feature->argsz = sizeof(buf);
     feature->flags =
@@ -340,12 +341,18 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
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
+    trace_vfio_query_stop_copy_size(migration->stopcopy_size, ret);
 
-    return 0;
+    return ret;
 }
 
 static int vfio_query_precopy_size(VFIOMigration *migration)
@@ -353,18 +360,24 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
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
+    trace_vfio_query_precopy_size(migration->precopy_init_size,
+                                  migration->precopy_dirty_size, ret);
 
-    return 0;
+    return ret;
 }
 
 /* Returns the size of saved data on success and -errno on error */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 287df0b8cb..854a7e4b19 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -176,6 +176,8 @@ vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer
 vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
+vfio_query_stop_copy_size(uint64_t size, int ret) "stopcopy size %"PRIu64" ret %d"
+vfio_query_precopy_size(uint64_t init_size, uint64_t dirty_size, int ret) "init %"PRIu64" dirty %"PRIu64" ret %d"
 
 #iommufd.c
 
-- 
2.53.0


