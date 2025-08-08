Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1921C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHNh-0006CB-0w; Fri, 08 Aug 2025 03:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHMv-00050h-2v
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHMr-0007dO-TW
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdJIwQWRjJdgSFjThN7WsD8UV7gf4FkX35TZaDUeuj4=;
 b=EGqsIzd8j1eap1kW/qwFGmsaPoV+9zehWay/jC6vHm/HcMDEd86QjckzzxWZMOPBKJHt0X
 o51iy+kdIQVPXB+mboatCX/3ShlOQFOB1dHGDExOeHsOvRPC1d7v9XFCeDho8CypmsQlXK
 tcVOOCUNdWdA9MU7vAjx8JChtJ+bRJ4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-rj_mURrlNR6vRd0Jvks94w-1; Fri, 08 Aug 2025 03:18:17 -0400
X-MC-Unique: rj_mURrlNR6vRd0Jvks94w-1
X-Mimecast-MFC-AGG-ID: rj_mURrlNR6vRd0Jvks94w_1754637497
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b42ebea2f2aso168837a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637496; x=1755242296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdJIwQWRjJdgSFjThN7WsD8UV7gf4FkX35TZaDUeuj4=;
 b=lXEQZPNuWe22G+JFVNE0VWNVvVl7aF8FfSDhp6zo7ojJMS8tl4cBV0pB8MwhWL5gZN
 eQaugM6gwN3mDU6fP9y641nPzIPsdpHuJMvitDutlmmWV3z8TXYIOKDueOX5XIXhl+ZZ
 H1h9kcjHGOCQPzpBfn2H+sRticgkyQJ7j+DZ1fMNXfFsg+FtwpKqgGPoz8/LBcS24HgN
 BySfxjbyqjKAfYKwngrRM35O0fQ8hCmlwJDdtEt3wEgh8th8iUCKhDoqyHO0xBWWth+T
 Qpa4JaWzlUpgDDUTjHHwZxazUuQTV9+8+zlQp6W2irCPWTXyn1QekbyZnF6oaPvxaHok
 l4JQ==
X-Gm-Message-State: AOJu0Yx06vpYHZ4RV6b5HQu3PIY4yarqm7GwYJB7V2EfJqwPhur7S1s7
 wrTimup8LzeFZnQK+q2aAOEIHVwWOkc3ZeuwMMnLmlI+sEN1qSwrCykGczc3ZBMr298WGDM8NLo
 zz2jyRU2Fk7lxZgIW6OFfXjoTwfMjmpQVZZeYvgQZyEbez+S4QtJr9C0C
X-Gm-Gg: ASbGncuMsREihFvkmsq8lpVxcYQsBPiE7vvhZj9ixNfoMzQGD6i/5xCak2xgNkiI1YX
 lgFXrUg/IKuJl7V9kCUIPQ/VFVKNMR6gsVj83BAZhuoEIq4gPmR/mLuh1yzuA2JMXYwEa+BSl+j
 IFuPPmd1BifnbetP0Gj5EzN6gJiHGFCs5kKir6AL7FJiM3+xhELMvpExx6pqH2kzM+6x4d3XUF/
 TCJnD2Tlp+2YmE9xEuJSFZaVTUPk/h/cheyA1coQg559SVs2IUOnGfJk/N6px04F0UHt1Cx/lOy
 Xo5jmBmH5fT2du00i2v+aSuC4fpeGJlYiSr+2pOHXpRUD3qbuICGiQ==
X-Received: by 2002:a17:902:ce90:b0:226:38ff:1d6a with SMTP id
 d9443c01a7336-242c2003629mr30422735ad.7.1754637495664; 
 Fri, 08 Aug 2025 00:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa7aE0nuwtT1TzGtVq/iK2DPv0yLPDW9FgqQ7PgBMUyAiYd9BsmxNlmWYhskIb1dAT2u+0Ag==
X-Received: by 2002:a17:902:ce90:b0:226:38ff:1d6a with SMTP id
 d9443c01a7336-242c2003629mr30421875ad.7.1754637494701; 
 Fri, 08 Aug 2025 00:18:14 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:18:14 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:50 +0530
Subject: [PATCH v10 24/27] migration: Remove error variant of
 vmstate_save_state() function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-propagate_tpm_error-v10-24-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
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
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16459; i=armenon@redhat.com;
 h=from:subject:message-id; bh=mKo6xoNHTAGi3qZ//iY63FCMqz0hq9OcaTNyTNUA4CQ=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxdeuXN93jWXG8t55Xg6/tE+vut243cl34v2J/fdWl
 z5I4z+a2VHKwiDGxSArpsjS8DVAtimgMCLS9uV1mDmsTCBDGLg4BWAiklaMDHtORL193rTjfM2y
 zkPi1a/9zKb0Pez/897wh8J6vcuhLa6MDP+uT3uzx/DmZL6ktmSdDG3DJ1uvFe/9vnTbPKZDKne
 nrOYHAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This commit removes the redundant vmstate_save_state_with_err()
function.

Previously, commit 969298f9d7 introduced vmstate_save_state_with_err()
to handle error propagation, while vmstate_save_state() existed for
non-error scenarios.
This is because there were code paths where vmstate_save_state_v()
(called internally by vmstate_save_state) did not explicitly set
errors on failure.

This change unifies error handling by
 - updating vmstate_save_state() to accept an Error **errp argument.
 - vmstate_save_state_v() ensures errors are set directly within the errp
   object, eliminating the need for two separate functions.

All calls to vmstate_save_state_with_err() are replaced with
vmstate_save_state(). This simplifies the API and improves code
maintainability.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/display/virtio-gpu.c     |  3 ++-
 hw/pci/pci.c                |  2 +-
 hw/s390x/virtio-ccw.c       |  2 +-
 hw/scsi/spapr_vscsi.c       |  2 +-
 hw/vfio/pci.c               |  4 ++--
 hw/virtio/virtio-mmio.c     |  2 +-
 hw/virtio/virtio-pci.c      |  2 +-
 hw/virtio/virtio.c          |  4 ++--
 include/migration/vmstate.h |  2 --
 migration/cpr.c             |  5 +++--
 migration/savevm.c          |  7 ++++---
 migration/vmstate-types.c   | 12 +++++++-----
 migration/vmstate.c         | 14 ++++++--------
 tests/unit/test-vmstate.c   |  8 +++++---
 ui/vdagent.c                |  3 ++-
 15 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5ff9f5e6dc0b6b112e36170318c900f893a73c5e..bddb26fa21312e5d0b2b6412cdf2a6c28dd06eb3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1246,7 +1246,8 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     }
     qemu_put_be32(f, 0); /* end of list */
 
-    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
+    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
+                              &error_warn);
 }
 
 static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 80545189980f176ca6a3dc9abce7043c8bc2708c..f7fb3931ff190c25ffa665ba80abe7737dbefdb6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -926,7 +926,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
      * This makes us compatible with old devices
      * which never set or clear this bit. */
     s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
-    vmstate_save_state(f, &vmstate_pci_device, s, NULL);
+    vmstate_save_state(f, &vmstate_pci_device, s, NULL, &error_warn);
     /* Restore the interrupt status bit. */
     pci_update_irq_status(s);
 }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index bafcb9b76d81749925e31b5a0a1320b3332ad2cf..14304fd3e8901d28a7788266df2c7ef7334b691c 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1130,7 +1130,7 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
 static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL);
+    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &error_warn);
 }
 
 static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index a4812afd0cc7c495080ef03a531c7d279af29b33..2204beb40c7cdc827db2bf86fb8612d8c09999ed 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -630,7 +630,7 @@ static void vscsi_save_request(QEMUFile *f, SCSIRequest *sreq)
     vscsi_req *req = sreq->hba_private;
     assert(req->active);
 
-    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL);
+    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL, &error_warn);
 
     trace_spapr_vscsi_save_request(req->qtag, req->cur_desc_num,
                                    req->cur_desc_offset);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 04d385d7674f444844beeee7364ee0424f762758..8e2b6d611de8efdf98235355226f5e5a6fd87b19 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2780,8 +2780,8 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
-    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
-                                       errp);
+    return vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL,
+                              errp);
 }
 
 static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index f14f0487fec3ed30d2cc3aec96950c2121265716..58957990743f061e78d0eafcfcb6cc5989252edc 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -613,7 +613,7 @@ static void virtio_mmio_save_extra_state(DeviceState *opaque, QEMUFile *f)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
-    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL);
+    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL, &error_warn);
 }
 
 static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 07f144d6d1bfbb561b28015de71762601080dc23..0826399cdfbf09b5b3f9acd9967de3417858c9d2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -154,7 +154,7 @@ static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
 
-    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL);
+    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &error_warn);
 }
 
 static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index c73d1c5a3b790eb96df0de4d84c134ac68e326ff..7792c23be71944e7607bbc3917d2874c0a869473 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3035,14 +3035,14 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     }
 
     if (vdc->vmsd) {
-        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL);
+        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL, &error_warn);
         if (ret) {
             return ret;
         }
     }
 
     /* Subsections */
-    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
+    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL, &error_warn);
 }
 
 /* A wrapper for use as a VMState .put function */
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 056781b1c21e737583f081594d9f88b32adfd674..5fe9bbf39058d0cf97c1adab54cc516dbe8dc32a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1198,8 +1198,6 @@ extern const VMStateInfo vmstate_info_qlist;
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, JSONWriter *vmdesc);
-int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc, Error **errp);
 int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                          void *opaque, JSONWriter *vmdesc,
diff --git a/migration/cpr.c b/migration/cpr.c
index bdb24736f44e91ba59b6e622a315597c97e7f64d..d48f013dac21b531e41a26f4bb33eefe32097757 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -163,6 +163,7 @@ bool cpr_is_incoming(void)
 
 int cpr_state_save(MigrationChannel *channel, Error **errp)
 {
+    ERRP_GUARD();
     int ret;
     QEMUFile *f;
     MigMode mode = migrate_mode();
@@ -182,9 +183,9 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
     qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
 
-    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);
+    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0, errp);
     if (ret) {
-        error_setg(errp, "vmstate_save_state error %d", ret);
+        error_prepend(errp, "vmstate_save_state error %d: ", ret);
         qemu_fclose(f);
         return ret;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index c3187ca9ae8534870d47056fff0511426ed08fb6..06cb9c465a24fd7f96bd36735feaeeddf268cc87 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1056,8 +1056,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
     if (!se->vmsd) {
         vmstate_save_old_style(f, se, vmdesc);
     } else {
-        ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc,
-                                          errp);
+        ret = vmstate_save_state(f, se->vmsd, se->opaque, vmdesc,
+                                 errp);
         if (ret) {
             return ret;
         }
@@ -1303,7 +1303,8 @@ void qemu_savevm_state_header(QEMUFile *f)
             json_writer_start_object(vmdesc, "configuration");
         }
 
-        vmstate_save_state(f, &vmstate_configuration, &savevm_state, vmdesc);
+        vmstate_save_state(f, &vmstate_configuration, &savevm_state, vmdesc,
+                           &error_warn);
 
         if (vmdesc) {
             json_writer_end_object(vmdesc);
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index e2020a733d0921d748b6f832a193e5de8d302d5f..2b88dc145ab32072f09845cee95b79aad7ac3cb2 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -564,7 +564,7 @@ static int put_tmp(QEMUFile *f, void *pv, size_t size,
 
     /* Writes the parent field which is at the start of the tmp */
     *(void **)tmp = pv;
-    ret = vmstate_save_state(f, vmsd, tmp, vmdesc);
+    ret = vmstate_save_state(f, vmsd, tmp, vmdesc, &error_warn);
     g_free(tmp);
 
     return ret;
@@ -675,7 +675,7 @@ static int put_qtailq(QEMUFile *f, void *pv, size_t unused_size,
 
     QTAILQ_RAW_FOREACH(elm, pv, entry_offset) {
         qemu_put_byte(f, true);
-        ret = vmstate_save_state(f, vmsd, elm, vmdesc);
+        ret = vmstate_save_state(f, vmsd, elm, vmdesc, &error_warn);
         if (ret) {
             return ret;
         }
@@ -712,7 +712,8 @@ static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
     if (!capsule->key_vmsd) {
         qemu_put_be64(f, (uint64_t)(uintptr_t)(key)); /* direct key */
     } else {
-        ret = vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc);
+        ret = vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc,
+                                 &error_warn);
         if (ret) {
             capsule->ret = ret;
             return true;
@@ -720,7 +721,8 @@ static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
     }
 
     /* put the data */
-    ret = vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmdesc);
+    ret = vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmdesc,
+                             &error_warn);
     if (ret) {
         capsule->ret = ret;
         return true;
@@ -856,7 +858,7 @@ static int put_qlist(QEMUFile *f, void *pv, size_t unused_size,
     trace_put_qlist(field->name, vmsd->name, vmsd->version_id);
     QLIST_RAW_FOREACH(elm, pv, entry_offset) {
         qemu_put_byte(f, true);
-        ret = vmstate_save_state(f, vmsd, elm, vmdesc);
+        ret = vmstate_save_state(f, vmsd, elm, vmdesc, &error_warn);
         if (ret) {
             error_report("%s: failed to save %s (%d)", field->name,
                          vmsd->name, ret);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 60ff38858cf54277992fa5eddeadb6f3d70edec3..4a6a33d5258cf271a0c58661b8a367eed2210601 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -403,12 +403,6 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
 
 
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, JSONWriter *vmdesc_id)
-{
-    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, NULL);
-}
-
-int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc_id, Error **errp)
 {
     return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
@@ -509,7 +503,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
                 if (inner_field->flags & VMS_STRUCT) {
                     ret = vmstate_save_state(f, inner_field->vmsd,
-                                             curr_elem, vmdesc_loop);
+                                             curr_elem, vmdesc_loop, errp);
                 } else if (inner_field->flags & VMS_VSTRUCT) {
                     ret = vmstate_save_state_v(f, inner_field->vmsd,
                                                curr_elem, vmdesc_loop,
@@ -518,6 +512,10 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 } else {
                     ret = inner_field->info->put(f, curr_elem, size,
                                                  inner_field, vmdesc_loop);
+                    if (ret) {
+                        error_setg(errp, "Save of field %s failed",
+                                   inner_field->name);
+                    }
                 }
 
                 written_bytes = qemu_file_transferred(f) - old_offset;
@@ -671,7 +669,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             qemu_put_byte(f, len);
             qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
             qemu_put_be32(f, vmsdsub->version_id);
-            ret = vmstate_save_state_with_err(f, vmsdsub, opaque, vmdesc, errp);
+            ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc, errp);
             if (ret) {
                 return ret;
             }
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 807deb3531f3079864ac99567d4dece7122571dd..5f31ed4b6969c4ebf72b298f965bcbdc752ff87f 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -69,7 +69,7 @@ static void save_vmstate(const VMStateDescription *desc, void *obj)
     QEMUFile *f = open_test_file(true);
 
     /* Save file with vmstate */
-    int ret = vmstate_save_state(f, desc, obj, NULL);
+    int ret = vmstate_save_state(f, desc, obj, NULL, &error_warn);
     g_assert(!ret);
     qemu_put_byte(f, QEMU_VM_EOF);
     g_assert(!qemu_file_get_error(f));
@@ -429,7 +429,8 @@ static void test_save_noskip(void)
     QEMUFile *fsave = open_test_file(true);
     TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
                        .skip_c_e = false };
-    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
+    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL,
+                                 &error_warn);
     g_assert(!ret);
     g_assert(!qemu_file_get_error(fsave));
 
@@ -451,7 +452,8 @@ static void test_save_skip(void)
     QEMUFile *fsave = open_test_file(true);
     TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
                        .skip_c_e = true };
-    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
+    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL,
+                                 &error_warn);
     g_assert(!ret);
     g_assert(!qemu_file_get_error(fsave));
 
diff --git a/ui/vdagent.c b/ui/vdagent.c
index b9a22a689d9acfeafb862ae73308db6fbd52331e..e0fc7ff71468bfe66761385387653c742c375f05 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -992,7 +992,8 @@ static int put_cbinfo(QEMUFile *f, void *pv, size_t size,
         }
     }
 
-    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc);
+    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc,
+                              &error_warn);
 }
 
 static int get_cbinfo(QEMUFile *f, void *pv, size_t size,

-- 
2.50.1


