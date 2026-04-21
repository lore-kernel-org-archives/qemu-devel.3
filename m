Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FCDF94CA7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbD-0000yX-7x; Tue, 21 Apr 2026 16:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb8-0000xG-2T
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb5-0008QU-5A
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DL2qnbA9IqENDBtthFbQ2rEXlgTK6uX9yJOp2U+0EAo=;
 b=CSr0twybRX0NUE3VgS9rmxpIW/xUrdR0U2nRpOcnSmYvAQUR/0MlpKJwtL40p0DhBdLE8L
 VmTOOYnnV9pl9jowlCKYHbSuJSTbRPYUbShmxMH8Rgr5+AMRuIaOSktiTnhTlH1uUhphbr
 RQY9eVPcHiGP2P3mQnxRxP4guhXRwVY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-iNXdY0gWNsePvNRd4S2wgQ-1; Tue, 21 Apr 2026 16:21:23 -0400
X-MC-Unique: iNXdY0gWNsePvNRd4S2wgQ-1
X-Mimecast-MFC-AGG-ID: iNXdY0gWNsePvNRd4S2wgQ_1776802883
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8a16036c90eso117703196d6.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802882; x=1777407682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DL2qnbA9IqENDBtthFbQ2rEXlgTK6uX9yJOp2U+0EAo=;
 b=EfxXDgq0sUcT7ABkdTExtmIJB7In6KHuAI9KcPYNiGNpYXMjWcOv2WrYXvsu/h0wCW
 ye4E5BGozxYrdSAjFj0yFZrSYjsfq2YtHrytdB33EASWXxH05OBs4tHL1QDYlcbCH4mR
 T9xxrMhBeE0A08d16TRcYA3e6lGZ+ITX9r80wJyYDs0H7X5bhsXQeKQq12L8acz3ifhJ
 jLtKez1K+uesNkn39GA0XVUEdMb/lOegru1nCLy2oDIbxoZ8Dd2SWy+SbcLNd+aRIWAr
 eCpu6YPWhf4xg2i9QfEF3QcN2eMAfZubo2cCX8Hm1YQ6stMt0h9vU+uR1njLOqa28q0Y
 uj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802882; x=1777407682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DL2qnbA9IqENDBtthFbQ2rEXlgTK6uX9yJOp2U+0EAo=;
 b=l55bgUQ3EWJNLFFgmnECgU72yNtp93om0tv4oc0JAZS7NRDMAfUTN9UJ6byFQrRARr
 hNOH73PL9SYX99Rf8dEglmspUMHIENsS10EHdYISRlJ560Gl2xCxA7Epv5DQ58NBnKX3
 NPTYupOil2DjiqliMoJz1j+X2wnORWCzm2L+KAiGbX3z+kbL4QWRYj1Mef00sp2ocf56
 uhkPUmkn2TvajY03C0FZh2Z4o7becL10tFH07GQtRzBoJEbVZ574NI15EEi6blGPxlNa
 7M3o/ehMZAza2FjYq5WcaWXs1mmY/X32glZR6EvV+osI+/T9MTDgD2AAzwsqy6pU+FUd
 Y63Q==
X-Gm-Message-State: AOJu0YzjYumXNgPb4RxSKXy5vMo4yNIeD17/fXKUVLoxLY576qdOk3+g
 dpTC1wKM7p6Mnl5i8iryybsl+AfwZ1rDm7DHi80uirk8nFQjT1pCY+Y2vyF/rJDNrLP0xMf5cf6
 Afv9U49cC3fZZBjIsfoc8+ssfXSGpswyWY+wGcV3konvjLT8L0y+UkhrUBDo7fcn5ptuxLA3Etu
 hvigX7E/F5MXHBeWw2056JuuVEc8PPFRLiEINp5g==
X-Gm-Gg: AeBDieubxMH/ajHVpjyqFgL15KCnZ9fjEz7XzS60ppvM38Cf5xk5bcKMnTNCLapqiCZ
 YdJMIHuIM3T0fD+BjPTC5T0wXf7qJnkxaJh0cqom7ioSa0Aq7J8kNuW3UbWKQE4Yea8HUb4VCLl
 fVHL7H7X34Vao34BfZaoCc/8pU2cDqzuQ+9Pws2LgXaX75LN5fqgt/RJ0qSRR9GDuaoxy1JE87I
 VLFGIynOOU7nY0KsJ1DPR8HoSIowq6zKf6scbvDZ6TANYP/uxG3Mj3ON06gnklO/U9xwIp0nPsF
 vV61pUR1Pks9xrgBAdvBNcf0Im2Be5HvKXuUe1rRyvzGpXkoT3kgNfvKwzDV2goajLP5UbIABoU
 SKUw8NsvpHt3rEJU42OOze6HM0prbtllQX4uMnJkcK1gNyMWHJslYL6vaCw==
X-Received: by 2002:a05:6214:8085:b0:8ac:a2f6:fbf7 with SMTP id
 6a1803df08f44-8b02812ba4amr262990746d6.40.1776802882087; 
 Tue, 21 Apr 2026 13:21:22 -0700 (PDT)
X-Received: by 2002:a05:6214:8085:b0:8ac:a2f6:fbf7 with SMTP id
 6a1803df08f44-8b02812ba4amr262989836d6.40.1776802881278; 
 Tue, 21 Apr 2026 13:21:21 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:20 -0700 (PDT)
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
 Juraj Marcin <jmarcin@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: [PATCH v2 05/16] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
Date: Tue, 21 Apr 2026 16:20:59 -0400
Message-ID: <20260421202110.306051-6-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

These two APIs are a slight duplication.  For example, there're a few users
that directly pass in the same function.

It might also be error prone to provide two hooks, so that it's easier to
happen one module report different things via the two hooks.

In reality, they should always report the same thing, only about whether we
should use a fast-path when the slow path might be too slow, as QEMU may
query these information quite frequently during migration process.

Merge it into one API, provide a bool showing if the query is an exact
query or not.  No functional change intended.

Export qemu_savevm_query_pending().  We should use the new API here
provided when there're new users to do the query.  This will happen very
soon.

Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: John Snow <jsnow@redhat.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/main.rst  |  9 ++----
 docs/devel/migration/vfio.rst  |  9 ++----
 include/migration/register.h   | 52 ++++++++++++----------------------
 migration/savevm.h             |  3 ++
 hw/s390x/s390-stattrib.c       |  9 +++---
 hw/vfio/migration.c            | 48 ++++++++++++++-----------------
 migration/block-dirty-bitmap.c | 10 +++----
 migration/ram.c                | 33 +++++++--------------
 migration/savevm.c             | 42 +++++++++++++--------------
 hw/vfio/trace-events           |  3 +-
 10 files changed, 86 insertions(+), 132 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 234d280249..e6a6ca3681 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -515,13 +515,8 @@ An iterative device must provide:
   - A ``load_setup`` function that initialises the data structures on the
     destination.
 
-  - A ``state_pending_exact`` function that indicates how much more
-    data we must save.  The core migration code will use this to
-    determine when to pause the CPUs and complete the migration.
-
-  - A ``state_pending_estimate`` function that indicates how much more
-    data we must save.  When the estimated amount is smaller than the
-    threshold, we call ``state_pending_exact``.
+  - A ``save_query_pending`` function that indicates how much more
+    data we must save.
 
   - A ``save_live_iterate`` function should send a chunk of data until
     the point that stream bandwidth limits tell it to stop.  Each call
diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 0790e5031d..691061d182 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -50,13 +50,8 @@ VFIO implements the device hooks for the iterative approach as follows:
 * A ``load_setup`` function that sets the VFIO device on the destination in
   _RESUMING state.
 
-* A ``state_pending_estimate`` function that reports an estimate of the
-  remaining pre-copy data that the vendor driver has yet to save for the VFIO
-  device.
-
-* A ``state_pending_exact`` function that reads pending_bytes from the vendor
-  driver, which indicates the amount of data that the vendor driver has yet to
-  save for the VFIO device.
+* A ``save_query_pending`` function that reports the remaining data that
+  the vendor driver has yet to save for the VFIO device.
 
 * An ``is_active_iterate`` function that indicates ``save_live_iterate`` is
   active only when the VFIO device is in pre-copy states.
diff --git a/include/migration/register.h b/include/migration/register.h
index d0f37f5f43..e2117e8dd4 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -16,6 +16,13 @@
 
 #include "hw/core/vmstate-if.h"
 
+typedef struct MigPendingData {
+    /* Amount of pending bytes can be transferred in precopy or stopcopy */
+    uint64_t precopy_bytes;
+    /* Amount of pending bytes can be transferred in postcopy */
+    uint64_t postcopy_bytes;
+} MigPendingData;
+
 /**
  * struct SaveVMHandlers: handler structure to finely control
  * migration of complex subsystems and devices, such as RAM, block and
@@ -197,46 +204,23 @@ typedef struct SaveVMHandlers {
     bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
 
     /**
-     * @state_pending_estimate
-     *
-     * This estimates the remaining data to transfer
+     * @save_query_pending
      *
-     * Sum of @can_postcopy and @must_postcopy is the whole amount of
-     * pending data.
-     *
-     * @opaque: data pointer passed to register_savevm_live()
-     * @must_precopy: amount of data that must be migrated in precopy
-     *                or in stopped state, i.e. that must be migrated
-     *                before target start.
-     * @can_postcopy: amount of data that can be migrated in postcopy
-     *                or in stopped state, i.e. after target start.
-     *                Some can also be migrated during precopy (RAM).
-     *                Some must be migrated after source stops
-     *                (block-dirty-bitmap)
-     */
-    void (*state_pending_estimate)(void *opaque, uint64_t *must_precopy,
-                                   uint64_t *can_postcopy);
-
-    /**
-     * @state_pending_exact
+     * This estimates the remaining data to transfer on the source side.
      *
-     * This calculates the exact remaining data to transfer
+     * When @exact is true, a module must report accurate results.  When
+     * @exact is false, a module may report estimates.
      *
-     * Sum of @can_postcopy and @must_postcopy is the whole amount of
-     * pending data.
+     * It's highly recommended that modules implement a faster version of
+     * the query path (for example, by proper caching on the counters) if
+     * an accurate query will be time-consuming.
      *
      * @opaque: data pointer passed to register_savevm_live()
-     * @must_precopy: amount of data that must be migrated in precopy
-     *                or in stopped state, i.e. that must be migrated
-     *                before target start.
-     * @can_postcopy: amount of data that can be migrated in postcopy
-     *                or in stopped state, i.e. after target start.
-     *                Some can also be migrated during precopy (RAM).
-     *                Some must be migrated after source stops
-     *                (block-dirty-bitmap)
+     * @pending: pointer to a MigPendingData struct
+     * @exact: set to true for an accurate (slow) query
      */
-    void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
-                                uint64_t *can_postcopy);
+    void (*save_query_pending)(void *opaque, MigPendingData *pending,
+                               bool exact);
 
     /**
      * @load_state
diff --git a/migration/savevm.h b/migration/savevm.h
index b3d1e8a13c..e4efd243f3 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -14,6 +14,8 @@
 #ifndef MIGRATION_SAVEVM_H
 #define MIGRATION_SAVEVM_H
 
+#include "migration/register.h"
+
 #define QEMU_VM_FILE_MAGIC           0x5145564d
 #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
 #define QEMU_VM_FILE_VERSION         0x00000003
@@ -43,6 +45,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(MigrationState *s);
+void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
 void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
                                      uint64_t *can_postcopy);
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index d808ece3b9..a22469a9e9 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -187,15 +187,15 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
     return 0;
 }
 
-static void cmma_state_pending(void *opaque, uint64_t *must_precopy,
-                               uint64_t *can_postcopy)
+static void cmma_state_pending(void *opaque, MigPendingData *pending,
+                               bool exact)
 {
     S390StAttribState *sas = S390_STATTRIB(opaque);
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
     long long res = sac->get_dirtycount(sas);
 
     if (res >= 0) {
-        *must_precopy += res;
+        pending->precopy_bytes += res;
     }
 }
 
@@ -340,8 +340,7 @@ static SaveVMHandlers savevm_s390_stattrib_handlers = {
     .save_setup = cmma_save_setup,
     .save_live_iterate = cmma_save_iterate,
     .save_complete = cmma_save_complete,
-    .state_pending_exact = cmma_state_pending,
-    .state_pending_estimate = cmma_state_pending,
+    .save_query_pending = cmma_state_pending,
     .save_cleanup = cmma_save_cleanup,
     .load_state = cmma_load,
     .is_active = cmma_active,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 5d5fca09bd..e965ba51fb 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -571,42 +571,39 @@ static void vfio_save_cleanup(void *opaque)
     trace_vfio_save_cleanup(vbasedev->name);
 }
 
-static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
-                                        uint64_t *can_postcopy)
+static void vfio_state_pending_sync(VFIODevice *vbasedev)
 {
-    VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
 
-    if (!vfio_device_state_is_precopy(vbasedev)) {
-        return;
-    }
-
-    *must_precopy +=
-        migration->precopy_init_size + migration->precopy_dirty_size;
+    vfio_query_stop_copy_size(vbasedev);
 
-    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
-                                      *can_postcopy,
-                                      migration->precopy_init_size,
-                                      migration->precopy_dirty_size);
+    if (vfio_device_state_is_precopy(vbasedev)) {
+        vfio_query_precopy_size(migration);
+    }
 }
 
-static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
-                                     uint64_t *can_postcopy)
+static void vfio_state_pending(void *opaque, MigPendingData *pending,
+                               bool exact)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
+    uint64_t remain;
 
-    vfio_query_stop_copy_size(vbasedev);
-    *must_precopy += migration->stopcopy_size;
-
-    if (vfio_device_state_is_precopy(vbasedev)) {
-        vfio_query_precopy_size(migration);
+    if (exact) {
+        vfio_state_pending_sync(vbasedev);
+        remain = migration->stopcopy_size;
+    } else {
+        if (!vfio_device_state_is_precopy(vbasedev)) {
+            return;
+        }
+        remain = migration->precopy_init_size + migration->precopy_dirty_size;
     }
 
-    trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
-                                   migration->stopcopy_size,
-                                   migration->precopy_init_size,
-                                   migration->precopy_dirty_size);
+    pending->precopy_bytes += remain;
+
+    trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
+                             migration->precopy_init_size,
+                             migration->precopy_dirty_size, exact);
 }
 
 static bool vfio_is_active_iterate(void *opaque)
@@ -851,8 +848,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .save_prepare = vfio_save_prepare,
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
-    .state_pending_estimate = vfio_state_pending_estimate,
-    .state_pending_exact = vfio_state_pending_exact,
+    .save_query_pending = vfio_state_pending,
     .is_active_iterate = vfio_is_active_iterate,
     .save_live_iterate = vfio_save_iterate,
     .save_complete = vfio_save_complete_precopy,
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index a061aad817..15d417013c 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -766,9 +766,8 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
     return 0;
 }
 
-static void dirty_bitmap_state_pending(void *opaque,
-                                       uint64_t *must_precopy,
-                                       uint64_t *can_postcopy)
+static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
+                                       bool exact)
 {
     DBMSaveState *s = &((DBMState *)opaque)->save;
     SaveBitmapState *dbms;
@@ -788,7 +787,7 @@ static void dirty_bitmap_state_pending(void *opaque,
 
     trace_dirty_bitmap_state_pending(pending);
 
-    *can_postcopy += pending;
+    data->postcopy_bytes += pending;
 }
 
 /* First occurrence of this bitmap. It should be created if doesn't exist */
@@ -1250,8 +1249,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
     .save_setup = dirty_bitmap_save_setup,
     .save_complete = dirty_bitmap_save_complete,
     .has_postcopy = dirty_bitmap_has_postcopy,
-    .state_pending_exact = dirty_bitmap_state_pending,
-    .state_pending_estimate = dirty_bitmap_state_pending,
+    .save_query_pending = dirty_bitmap_state_pending,
     .save_live_iterate = dirty_bitmap_save_iterate,
     .is_active_iterate = dirty_bitmap_is_active_iterate,
     .load_state = dirty_bitmap_load,
diff --git a/migration/ram.c b/migration/ram.c
index 979751f61b..e5b7217bf5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3443,30 +3443,18 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     return qemu_fflush(f);
 }
 
-static void ram_state_pending_estimate(void *opaque, uint64_t *must_precopy,
-                                       uint64_t *can_postcopy)
-{
-    RAMState **temp = opaque;
-    RAMState *rs = *temp;
-
-    uint64_t remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
-
-    if (migrate_postcopy_ram()) {
-        /* We can do postcopy, and all the data is postcopiable */
-        *can_postcopy += remaining_size;
-    } else {
-        *must_precopy += remaining_size;
-    }
-}
-
-static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
-                                    uint64_t *can_postcopy)
+static void ram_state_pending(void *opaque, MigPendingData *pending,
+                              bool exact)
 {
     RAMState **temp = opaque;
     RAMState *rs = *temp;
     uint64_t remaining_size;
 
-    if (!migration_in_postcopy()) {
+    /*
+     * Sync is not needed either with: (1) a fast query, or (2) after
+     * postcopy has started (no new dirty will generate anymore).
+     */
+    if (exact && !migration_in_postcopy()) {
         bql_lock();
         WITH_RCU_READ_LOCK_GUARD() {
             migration_bitmap_sync_precopy(false);
@@ -3478,9 +3466,9 @@ static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
 
     if (migrate_postcopy_ram()) {
         /* We can do postcopy, and all the data is postcopiable */
-        *can_postcopy += remaining_size;
+        pending->postcopy_bytes += remaining_size;
     } else {
-        *must_precopy += remaining_size;
+        pending->precopy_bytes += remaining_size;
     }
 }
 
@@ -4703,8 +4691,7 @@ static SaveVMHandlers savevm_ram_handlers = {
     .save_live_iterate = ram_save_iterate,
     .save_complete = ram_save_complete,
     .has_postcopy = ram_has_postcopy,
-    .state_pending_exact = ram_state_pending_exact,
-    .state_pending_estimate = ram_state_pending_estimate,
+    .save_query_pending = ram_state_pending,
     .load_state = ram_load,
     .save_cleanup = ram_save_cleanup,
     .load_setup = ram_load_setup,
diff --git a/migration/savevm.c b/migration/savevm.c
index dd58f2a705..392d840955 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1762,46 +1762,44 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
     return qemu_fflush(f);
 }
 
-/* Give an estimate of the amount left to be transferred,
- * the result is split into the amount for units that can and
- * for units that can't do postcopy.
- */
-void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
-                                        uint64_t *can_postcopy)
+void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
 {
     SaveStateEntry *se;
 
-    *must_precopy = 0;
-    *can_postcopy = 0;
+    pending->precopy_bytes = 0;
+    pending->postcopy_bytes = 0;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops || !se->ops->state_pending_estimate) {
+        if (!se->ops || !se->ops->save_query_pending) {
             continue;
         }
         if (!qemu_savevm_state_active(se)) {
             continue;
         }
-        se->ops->state_pending_estimate(se->opaque, must_precopy, can_postcopy);
+        se->ops->save_query_pending(se->opaque, pending, exact);
     }
 }
 
+void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
+                                        uint64_t *can_postcopy)
+{
+    MigPendingData pending;
+
+    qemu_savevm_query_pending(&pending, false);
+
+    *must_precopy = pending.precopy_bytes;
+    *can_postcopy = pending.postcopy_bytes;
+}
+
 void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
                                      uint64_t *can_postcopy)
 {
-    SaveStateEntry *se;
+    MigPendingData pending;
 
-    *must_precopy = 0;
-    *can_postcopy = 0;
+    qemu_savevm_query_pending(&pending, true);
 
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops || !se->ops->state_pending_exact) {
-            continue;
-        }
-        if (!qemu_savevm_state_active(se)) {
-            continue;
-        }
-        se->ops->state_pending_exact(se->opaque, must_precopy, can_postcopy);
-    }
+    *must_precopy = pending.precopy_bytes;
+    *can_postcopy = pending.postcopy_bytes;
 }
 
 void qemu_savevm_state_cleanup(void)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 846e3625c5..287df0b8cb 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -173,8 +173,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
-vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
-vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
+vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 
-- 
2.53.0


