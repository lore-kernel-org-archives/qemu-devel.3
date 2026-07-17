Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA85DC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkft0-0003Ke-JL; Fri, 17 Jul 2026 06:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkfsv-0003Jf-Ol
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkfst-0001Ql-Li
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784284412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYSfFq9oXIBf3ZUfwtzjbA8CNeqsnosYDVtMJ70W6gE=;
 b=fxP0nSptRENhFZfulRhG7uMCLmfBLREdcIB9TEmpmWicYN5Lx7HEj3hyRzcCJI0wW2fwZE
 PLwBv5C/DvdN9m0AmHIwfCjmo7IdGpO0ilVvkrlRi1/xwiU8iuWzaCu0/NYhCpGVFwi+vU
 +IOyqOF0733NTnyVGmr9GKv/XlNQjzU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-T9jMUWbKMZeygPEwpx2TFw-1; Fri, 17 Jul 2026 06:33:31 -0400
X-MC-Unique: T9jMUWbKMZeygPEwpx2TFw-1
X-Mimecast-MFC-AGG-ID: T9jMUWbKMZeygPEwpx2TFw_1784284410
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f24a50f0cso6684991f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 03:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784284410; x=1784889210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AYSfFq9oXIBf3ZUfwtzjbA8CNeqsnosYDVtMJ70W6gE=;
 b=BmtEuIHMTMrrgec/p2uAyXeDkfe3ZcCjXyVTDp5xiXgRU5oeeY/eHNMEhm/6venJke
 OAsYygkE4W+W4hjXzZAqqO3UvXnv1wXKBOacYph6Ah8qPv47C3LoyrxD9YeyaNad0PsA
 8G2v9bQ1ZHzXygKwVh1HVkqdgpq2NETgtUDgD5u7YE+4ZOeYsrr0UViPT3olbGAKhW5E
 s+funcffVR6WTYY/TwLp6cix4n+TGmg0MZd0q60ELj1XKfTqYwcSb3/BD8onhMj2zgVJ
 XIYzSNSaXoWlKzqNgR7oxrSUpsHbqKbhD04IJfCKT2zargh6VUnppN+AhikYfSEcy0NN
 TBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784284410; x=1784889210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AYSfFq9oXIBf3ZUfwtzjbA8CNeqsnosYDVtMJ70W6gE=;
 b=g0dolh2A7sCWv5303OwG9IzhOwtKEovrcNP+uYNSI4qvhHEpMn7iBTSTVSAr3avQQv
 hN/SGBRWwIgQSbQLYKkJrJiadJm8C/R/bkMYA65cwjD5iS7WrVolsOtQEIi0+zNLV0BJ
 /z5aAx5a6cwSl3f/b10vQdVse1+qbsWMj61f+9PBELeixaLqAGOI7kTM+UNleH6lrU+q
 pVbP406Mm1mO5zD2peZnlqDm+bAvm2RXB/DVS0wjfwtb/6r710Eip5PuZkHfgXN8b9KZ
 ton2Yq01Pbb9Fs5ozJLuP5ZqQqwwOVWaMO7tZuQJci2DoSPnFZ+CskwQHqHYi4nkPs/n
 QU6Q==
X-Gm-Message-State: AOJu0YxXOC1eR8eylv1Su5VJUL6KR+PXI/hQeSoQRVqJANBT3zsOO7no
 A6CUqPZlsP/5oVIQgmuD/F9z+FiWLHbZaPPVZTLJAZmhpe168MEV0SEqhElBbCbq/Kc+ikLSszM
 KpRRE52muJ26/TMfdGPeRI6vtqO9OLlb09Cuq+25cqvGaNIDumuA+1OOhCLOEidrTkgtYj9o0C3
 j82fK26m8SISVoaHihVzrYnbJ9cFP28I+IPVzOnauD4tWd
X-Gm-Gg: AfdE7cka2JHrZSM+mvnpn4vdWULJbAh2g5z6UUdLaj/h0ja3W5oxcTAA4E7DwIxkkvA
 KmzmxYtqhKUVVkHcaq20InAFjwyjaxNvYJSCeDmACw7zRT9tvisnM7wCN9En+Uue4Fr0XtR2pUY
 Y7JrsCrM5thQyU0agr4iLsYDc4HFJjScfa6wDd7b83IHCpFUuTGB2/Rt8MFiubUw7Z+0/+Ba8GJ
 SXvrVJedJqkTZ3Uy9mhx44FQ/lTGkgN/Aw+s3sl5AbZ0J7uT8WcEcGOs6j4YE9lPSNYmtFNLLow
 zIlCYUtYdmnD9Us+zudYspFmnLWsYyC5fnoAVNtDHjrmO43wdeOZslP8s1Tt7uwXTeuQmTioCZD
 XgldsbPfVXupIWn0f1Bdzcw9TOjGIZTGZpgjDO6udM/BCnk4HkAn1AFCvv7NyfX9f6nIKznhIFJ
 EiYN4OzmY=
X-Received: by 2002:adf:e19b:0:b0:46d:d90b:bbe4 with SMTP id
 ffacd0b85a97d-47f6232c546mr2474855f8f.40.1784284410102; 
 Fri, 17 Jul 2026 03:33:30 -0700 (PDT)
X-Received: by 2002:adf:e19b:0:b0:46d:d90b:bbe4 with SMTP id
 ffacd0b85a97d-47f6232c546mr2474801f8f.40.1784284409517; 
 Fri, 17 Jul 2026 03:33:29 -0700 (PDT)
Received: from fedora (cst-prg-95-48.cust.vodafone.cz. [46.135.95.48])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed2313sm2523298f8f.23.2026.07.17.03.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:33:28 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v3 2/3] vhost-user-gpu: Add shared memory region support
Date: Fri, 17 Jul 2026 12:33:00 +0200
Message-ID: <20260717103301.228974-3-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717103301.228974-1-dbassey@redhat.com>
References: <20260717103301.228974-1-dbassey@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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


