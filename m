Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB16CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hvB-0005XL-E6; Fri, 03 Oct 2025 11:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hv3-0005UQ-4g
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hu6-0007lV-4Y
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zvoe1XuyFzw6D+/h8M2xMDoOxrnHPt+CbPDEsj1vlp0=;
 b=f/ugR1Cxmk0GLIv4D3XHlMKHhNKb2l37M/Y53BLDoyM+jnChjF6cXzGgqJXMGqc9EgWdP2
 pp9g7cK3PaulyeSTzznbvrsA+vIWtr86FnhZlM6ZNJuBsM5ZVLuXW0ASpR57gryT7Lg14B
 KdD5308gNycy2rsbkXKWg+UqS1sR+BE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-TloALoASPGGFHc3dei0_lQ-1; Fri, 03 Oct 2025 11:40:55 -0400
X-MC-Unique: TloALoASPGGFHc3dei0_lQ-1
X-Mimecast-MFC-AGG-ID: TloALoASPGGFHc3dei0_lQ_1759506054
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-7e90f268f62so42097746d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506054; x=1760110854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvoe1XuyFzw6D+/h8M2xMDoOxrnHPt+CbPDEsj1vlp0=;
 b=NH9QZ90amO6B5mtvfyp/MpgNeUvNuvKjinMxWtCzfA4wBjxCQmv8UGhV9yzxULM4lO
 mn5RNpU2/W1EGFb/nA+7rRIMEU06HzSbQhkxLU3Z8SazYvXuG4AYp+USy25ZSMDaVuKJ
 DTIBxp3Go8+h0lMwbzxgJuAoEjNKeVcRmkupzUGOOd8HnG0N0pQz4eJnf9YD5R22Dkn7
 Z88nqGLcIUlwVs2btAc92ylE+7hP3HHlSZ5zuWUbIIT/tIOEyaIc9DthBWbJ/47l+bA/
 S7+0VVmJZz8H+M5NqFgy7aAg+Hbd7d9DsmMsPsnV6Sj5ZgRWBfcvS+b4B0Uf61sInNEY
 nPNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu4tZFVrQQfdrTm4p7QXBlV0XAtqLWBcBtX+iGHbrZNRrf2FhovTjBu2EX/qTjl9Bh4b6zq1eNoTrp@nongnu.org
X-Gm-Message-State: AOJu0YxA43qarZfybF83IYSdu0aAVfmCAUhm1ArCWGiGN66Tdl9q3y3a
 6V5sv0iycy4xXYEfqXAfQ3Xo6RAr86lUaxst8Q819csUdzQcb6BT6XKkDoXuIUX+wYJRsZk7Wfz
 53mgg6F6t8LWGmKqPPMcX5xYbonsmXXtuFjDQwYSgQUW0+JzyF132El6w
X-Gm-Gg: ASbGncuqZsnaFc1nuD22kyg7xldI9RcBq4T+nXoRhljTm9sC+AdfZ6F9Glz9p/oDThS
 Hs6oa/e1mbToVS0/Tm43ee+WA7vAqPYVdhL24i5AisVLSooX+uACA0wVR+ZzWzhGC2pCO46qGyv
 IOtXhGQN7z+QcqItWwiCqjcgDidxII2vnp2JB2Lwpiiypf02ITSc6UzSFPYoA5cC1gxorNn63ae
 iR1duKiISm6daOHtDJ0Izi2/Mubvd/HIVl/iuaIKaKYs6131WFfsPa1ePjzR+8tfZJ8nMIOGrW9
 WKBgZzz7fgBSAz++cSBg7dzgl2Y3OwoOXDVv1w==
X-Received: by 2002:a05:6214:124f:b0:79c:f4b0:6813 with SMTP id
 6a1803df08f44-879dc79badbmr50201136d6.21.1759506054173; 
 Fri, 03 Oct 2025 08:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgmSM7dDiaoS8GFq7HVsdH6sDjfz2Zm9L6IIaW7JOaTfv2kHw9MiLmRFZpO7iIG0KTo5yo5Q==
X-Received: by 2002:a05:6214:124f:b0:79c:f4b0:6813 with SMTP id
 6a1803df08f44-879dc79badbmr50200646d6.21.1759506053636; 
 Fri, 03 Oct 2025 08:40:53 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 44/45] vfio: cpr-exec mode
Date: Fri,  3 Oct 2025 11:39:47 -0400
Message-ID: <20251003153948.1304776-45-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

All blockers and notifiers for cpr-transfer mode also apply to cpr-exec.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/30750362-d4a1-4392-8dd6-016624d01be1@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/container-legacy.c |  3 ++-
 hw/vfio/cpr-iommufd.c      |  3 ++-
 hw/vfio/cpr-legacy.c       |  9 +++++----
 hw/vfio/cpr.c              | 13 +++++++------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index c0f87f774a..c0540f2bdc 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -990,7 +990,8 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         error_setg(&vbasedev->cpr.mdev_blocker,
                    "CPR does not support vfio mdev %s", vbasedev->name);
         if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
-                                      MIG_MODE_CPR_TRANSFER, -1) < 0) {
+                                      MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
+                                      -1) < 0) {
             goto hiod_unref_exit;
         }
     }
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 1d70c87996..8a4d65de5e 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -159,7 +159,8 @@ bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
 
     if (!vfio_cpr_supported(be, cpr_blocker)) {
         return migrate_add_blocker_modes(cpr_blocker, errp,
-                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
+                                         MIG_MODE_CPR_TRANSFER,
+                                         MIG_MODE_CPR_EXEC, -1) == 0;
     }
 
     vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index bbf7a0d35f..1a16cb1188 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -179,16 +179,17 @@ bool vfio_legacy_cpr_register_container(VFIOLegacyContainer *container,
 
     if (!vfio_cpr_supported(container, cpr_blocker)) {
         return migrate_add_blocker_modes(cpr_blocker, errp,
-                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
+                                         MIG_MODE_CPR_TRANSFER,
+                                         MIG_MODE_CPR_EXEC, -1) == 0;
     }
 
     vfio_cpr_add_kvm_notifier();
 
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
-    migration_add_notifier_mode(&container->cpr.transfer_notifier,
-                                vfio_cpr_fail_notifier,
-                                MIG_MODE_CPR_TRANSFER);
+    migration_add_notifier_modes(&container->cpr.transfer_notifier,
+                                 vfio_cpr_fail_notifier,
+                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
     return true;
 }
 
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 2c71fc1e8e..db462aabcb 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -195,9 +195,10 @@ static int vfio_cpr_kvm_close_notifier(NotifierWithReturn *notifier,
 void vfio_cpr_add_kvm_notifier(void)
 {
     if (!kvm_close_notifier.notify) {
-        migration_add_notifier_mode(&kvm_close_notifier,
-                                    vfio_cpr_kvm_close_notifier,
-                                    MIG_MODE_CPR_TRANSFER);
+        migration_add_notifier_modes(&kvm_close_notifier,
+                                     vfio_cpr_kvm_close_notifier,
+                                     MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
+                                     -1);
     }
 }
 
@@ -282,9 +283,9 @@ static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
 
 void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
 {
-    migration_add_notifier_mode(&vdev->cpr.transfer_notifier,
-                                vfio_cpr_pci_notifier,
-                                MIG_MODE_CPR_TRANSFER);
+    migration_add_notifier_modes(&vdev->cpr.transfer_notifier,
+                                 vfio_cpr_pci_notifier,
+                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
 }
 
 void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)
-- 
2.50.1


