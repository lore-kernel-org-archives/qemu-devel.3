Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28353C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkixP-0004RC-QO; Fri, 17 Jul 2026 09:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkiws-0004Fy-87
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkiwp-0001YM-BY
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784296190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPiM/aoeSCDxMW8QTDsfI2a1F6P28NxKwnIXOOJ69Is=;
 b=P/SmubCn0XzEmRG4VnEgVTO+wdjjK+wljKZ+neghDTa97JRSkbdMPG0lvUG/Q7iMWfQ///
 0b8fUSKxz8T2P7BUtckBdek2iGBDQiyez+M6fMTY1/+ZDJHPRbdj9dp6GmBWJbfgQ1XAqz
 6dg+x7spE+Wrb4cO8ELko7nd2IR+Oe8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-mQPgLhGxN_e9BvQZmKrGkQ-1; Fri, 17 Jul 2026 09:49:49 -0400
X-MC-Unique: mQPgLhGxN_e9BvQZmKrGkQ-1
X-Mimecast-MFC-AGG-ID: mQPgLhGxN_e9BvQZmKrGkQ_1784296188
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493c47a09b5so42836875e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784296188; x=1784900988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PPiM/aoeSCDxMW8QTDsfI2a1F6P28NxKwnIXOOJ69Is=;
 b=c3I3wV85a93LlL7JndB0jx8ORjCDvHC9IEqvYgDilJcYoWOqMYo5CiknY/OI6QEfq5
 mIM0M0kfnVrrE9sv9zF1gphlWi2I5I1uqE2uKQf9gcETiDPyJagMNzc2d3PgFhVkZ4eQ
 z4ZYOCGla0HIMFs3haGu+B27FnXFIsOa5M90M2M2Npc3eoJcFxueBY0QH7lSbCls6S7l
 7y8fObVTykHQtsHD5vbJca/eJakk/T3tBKmiBYPRfEpvBTcNbTml6W257rYhSZ7al1Iq
 pgfI/y2lEgveSW67oVpaxMPVZqoofBfkQ94YUygNy1gvDn94RudYYK5mCkpchLL5wQKO
 bn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296188; x=1784900988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PPiM/aoeSCDxMW8QTDsfI2a1F6P28NxKwnIXOOJ69Is=;
 b=CWEHKUkaDkpEjIeQQ74ErZFeqTjdNM8SUaoLIFaIg2XU40r6nLxZ5XgtY3Hd607H4C
 Nwq6FduasFkMt4gcSQ+vatrV+eoxe5fLBCBA04I0Z0nG/s6ZT3FR08ZVXIxZbvVv0WYD
 REVQZxgQNTatWDIbg2ir0O1ZjVshx8dj2agN72jX+pME/2bYjotVz5BPnpTcB2CvVQIQ
 xS0hYki7uhzQKvM6e5X7ePOZOHqzIe8tl2PKJCLwThOqx0JiPiS2Q0G/unWGsOhQFalf
 5CCPtUnWohbC7C931JWUFg8+Nf3nYXOCuQFTFFjio78vk5t4Y8kHHR23wyO37eiDEsEL
 ZW5g==
X-Gm-Message-State: AOJu0YxFVAmpq2PwUOtb0Xo7sYu6KJne5GSAt0dhV+c3yGWm03lvxBKn
 z4L931tjwfhXVJpvMUSF4yLpIZoS9748geyp1rTm67fQfEbQTyB6sC5GJhJuDeU/f1KK5ny7bLH
 XBtuserNUFsAZM9QOH9c+uOOKvBonsHYe2J3v7InXDJQkA2EpPw8JH/0IzA9nZEMImwxSDPdirb
 Kxwtd6xLUZ7bJZTYX3DAVMwkycuzgmh4vfVdnqi7Ls72JN
X-Gm-Gg: AfdE7ck9Pr17Yxcpc9LX9caNcfn1cTIsh0rxf0YGfZhJuQCovw3yS6unoH+ABlUqHnt
 sfTmRpWiS94viAt+heMwSlFHseq87DLzfzLWtZana+AZbFkB+y103dQBRnAR4WrqYRdspFcMXoy
 RjvZZWJhiTWi0Nw5Ay49DqrgNdsE9lr3VYzTA8PNZvXU+6ONgZXH1SLFwM1ZPIhfzBMzk8Pd13N
 eNGSB3oQpfMcL3k/DO6LoyINPnKypvsSqxBISPZ0Z6x5X545y0wsQi3EGhrmyTpipQjC9WhlBTY
 gGoVdIedGosXJabj3tTQgLyUu7Q5SUnmEt3lZqrYKyF5/gGiL2pojHOdof0DvriRIYsnG6VsMwl
 ZeAL7SsVh1iicOFHbgyMaxYc1R9rN1WwBIBTyifeYTyZRxDAzVmtEiyxS42WQJQyzSAzE8gXnhR
 vlPxaRtNbHfw==
X-Received: by 2002:a05:600c:4ed0:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-4954a3d0872mr31772365e9.7.1784296187916; 
 Fri, 17 Jul 2026 06:49:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-4954a3d0872mr31771465e9.7.1784296187075; 
 Fri, 17 Jul 2026 06:49:47 -0700 (PDT)
Received: from fedora (cst-prg-27-253.cust.vodafone.cz. [46.135.27.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954ba2abd0sm30049525e9.15.2026.07.17.06.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 06:49:46 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v4 2/3] vhost-user-gpu: Add shared memory region support
Date: Fri, 17 Jul 2026 15:49:19 +0200
Message-ID: <20260717134920.265128-3-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717134920.265128-1-dbassey@redhat.com>
References: <20260717134920.265128-1-dbassey@redhat.com>
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
Reviewed-by: Albert Esteve <aesteve@redhat.com>
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


