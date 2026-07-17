Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217CAC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkf3R-0007z8-63; Fri, 17 Jul 2026 05:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkf3P-0007yj-87
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkf3N-0002sk-Ii
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784281220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYSfFq9oXIBf3ZUfwtzjbA8CNeqsnosYDVtMJ70W6gE=;
 b=URAQao/aA3VPUJ8OsopJkeWPBIC4UtCi6l1Y3A710PD5sX28ncZ5wY8Hb2wNuEDVdR/X8w
 w6YdbXKBDaJQnvJCH44tNtsIEQcT/RruFZ9v/1iAQ0/QqIuUClMju8Ar/C+jwVLKKJn1eB
 lmhmB93hH+BYooHLEQOisZqosNg/HRI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-dBjn0ArmPACEZcDzMuFFew-1; Fri, 17 Jul 2026 05:40:19 -0400
X-MC-Unique: dBjn0ArmPACEZcDzMuFFew-1
X-Mimecast-MFC-AGG-ID: dBjn0ArmPACEZcDzMuFFew_1784281218
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f3e6cc5c4so2570136f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 02:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784281218; x=1784886018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AYSfFq9oXIBf3ZUfwtzjbA8CNeqsnosYDVtMJ70W6gE=;
 b=iRdFEvlqyVZO/1XA3XisdUpZ0Ahcb2ob2i1XF1dZb9nIfSXAKG0QiWzVfrDi3g2akT
 BcSgOCVLv4X+gJs1uaY4w7kIL70oqAcQUWSt6/qobUyjh8SmiKIFr1AqpLx010g2dqXC
 JRK9PtNWa7ewajUfJYdeABw3Zdlo2Scw4bIKSfd8hiYk8AHx9dtoAHag+EfqBshorxnH
 Y1Y8irNItfJxMpbchWydK5Q4PYi+PnZfiC703F5yk/S6l2KBowTJhADvi+1xkc52oK9e
 OwUzlp5ctr6/kxC24g2/jZkrThlOCAtECs/krYk0esRWgk4fl2Gs2dq95dZPQb6hG7B0
 MFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784281218; x=1784886018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AYSfFq9oXIBf3ZUfwtzjbA8CNeqsnosYDVtMJ70W6gE=;
 b=DXr4w2bHKmGPq6mTFWF0OceNyIBsTMFEDLZ4sX0tlND5pzt2KfYThGAOjAmvflnuC+
 Aiv2URg2d5cTD1WLQbS9jngDKmfjAnjTP+B9oyIXmqIbcFDg+fDlxhIduULlfYOk96U8
 OJsDyCW2AqJTnYRhKOafWjenjwVjboipSuxzImT7KH9Dhje8v9EMQiLhS/TvFtaVDrpa
 8fWTD3FBZj284v3kz+g0OWkat5Fyb8PJMOFU/oykFOlbJWw4l8hhp2YQNsuz9VPqFGAX
 hQ69GgYr6F4qJ9vpzR0udJN5JXFSUKPSyC1i2InZTvIAPjfLF4iGhue7aUTiokSR6aqd
 aQog==
X-Gm-Message-State: AOJu0YyDw92kL1hnaUONRQ8a1GuS06pCkqQSmG1wwA1Z4pTwiaQ+HwNn
 VgbSUziJRH7e8GNLYGMACKb9S0b7b0aPQ8V1lU7cd+Tj5+p1P4q1Hmy4B1Gg7s0MzRVqIHZch8i
 xnop/WBg1moR1CTOPlBsDq2HHwyWF2OrAnn41+qrIG0FCdRcV33z5eqoPsvVaCZREjOgRQl0j3V
 TUI/SZs4gyQqDU+z13WUTvgphJ/BRBtUF6K3b8ZwaXuyKS
X-Gm-Gg: AfdE7ckgD1tEoxtit4FXCctEzp5dWFrzL9uZFiqIGZnNHuan5nKTpFCzV9kSucSp2ke
 wczLSscEuquO0lGmCrB7Jy5XIGzlA9nrGuTW8uB8J4RFPI1ZxLPdcO08yi210bOrnfWJplFtiDO
 ydcrIWenRd/eOyi/ZK86iG55xaueTjUxb5t8+eZuNTQ5wyh71FQFqLSnN1onqQau+qZ0lyFs2F1
 XxR90aarpMNXRGAt6Dm1JZmyb/YnC6ZzvYmwC5V3q5JzzKHA3NWcGKRRu5x44SFXuAnqVymgWEg
 /AoA3MgN+v+STEGofi1lErwl/+kJNTlFlrPLw/0DD9fG33KLUFOKqIz8+vzCCwqBfPfVmCUerGK
 dYoUtMQtmdPFEDfmJOaG4JQ==
X-Received: by 2002:a7b:cd10:0:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-4954a402e60mr14277815e9.20.1784281217709; 
 Fri, 17 Jul 2026 02:40:17 -0700 (PDT)
X-Received: by 2002:a7b:cd10:0:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-4954a402e60mr14277455e9.20.1784281217284; 
 Fri, 17 Jul 2026 02:40:17 -0700 (PDT)
Received: from fedora (cst-prg-95-48.cust.vodafone.cz. [46.135.95.48])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a35830sm38356565e9.3.2026.07.17.02.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 02:40:16 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v2 1/3] vhost-user-gpu: Add shared memory region support
Date: Fri, 17 Jul 2026 11:39:23 +0200
Message-ID: <20260717093925.214023-2-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717093925.214023-1-dbassey@redhat.com>
References: <20260717093925.214023-1-dbassey@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Matej Hrica <mhrica@redhat.com>

Add a 'hostmem' property to the vhost-user-gpu which enables the shared
memory in the parent object.

Register a container MR in the shmem_list for SHMEM_MAP/UNMAP
operations. A container MR is used so that SHMEM_MAP FD-backed
subregions each get their own KVM memory slot with the correct
backing fd.

Suggested-by: Albert Esteve <aesteve@redhat.com>
Signed-off-by: Matej Hrica <mhrica@redhat.com>
Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
 hw/display/vhost-user-gpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 57360898ca0..dbba80c7783 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -649,6 +649,16 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
     }
 
     g->vhost_gpu_fd = -1;
+
+    /*
+     * If shared memory is enabled, register the hostmem region for
+     * SHMEM_MAP/UNMAP operations.
+     */
+    if (virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
+        VirtioSharedMemory *shmem = virtio_new_shmem_region(
+            vdev, VIRTIO_GPU_SHM_ID_HOST_VISIBLE, g->parent_obj.conf.hostmem);
+        memory_region_add_subregion(&g->parent_obj.hostmem, 0, &shmem->mr);
+    }
 }
 
 static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
@@ -659,6 +669,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
 
 static const Property vhost_user_gpu_properties[] = {
     VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
+    DEFINE_PROP_SIZE("hostmem", VhostUserGPU, parent_obj.conf.hostmem, 0),
 };
 
 static void
-- 
2.52.0


