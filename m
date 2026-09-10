Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E9AC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oUc-0002t6-4M; Thu, 10 Sep 2026 19:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lTj-0005uF-7G
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lTR-0003BG-6e
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SgB+S9u3GSAcq8/Uuupwqbwj/4AB+NAz4BxPvnZlGUs=;
 b=epF8NG8hzj0WKDkMmAUlq5SzA2QDx8W3pI+XFKlXzOuOghQJZb1uzpvizoyQiq38j3DJKf
 P3aOeK33fLcmowftEVnD7+dlYL9HtO2XaNv2uCTG3tps1FAXjoMwbUv8jn4LYlMzaA9Qzt
 8sL7V2srVmOfFcPYRs12RYivtWPjnbM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Pd7bbjUNNFKgWGgudRia1A-1; Thu, 10 Sep 2026 16:13:03 -0400
X-MC-Unique: Pd7bbjUNNFKgWGgudRia1A-1
X-Mimecast-MFC-AGG-ID: Pd7bbjUNNFKgWGgudRia1A_1789071182
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-482f763db88so47200f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071182; x=1789675982; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SgB+S9u3GSAcq8/Uuupwqbwj/4AB+NAz4BxPvnZlGUs=;
 b=dfaqVToegu2f9z5DT1dtsJcK7NzzeDoQEIhws0R9u5RLZI2O/08q20JRdo0RoIfHZh
 zTMuwZcRFd+kddpAqTnj0wLOXHTct8RmI+NwO5SEKrgGIW8yVmsX3HY2I8mFv2q9RxYC
 EJC6IDiI4R33Xi5Yj7exyUlSPSHqrY8gAxII9hq+ClPfSWB0ctNrSXaGowd8O5F3drEP
 upGK/v5TYKunVWWo+kLsS6djkb0T99/A4MhMkymuIog7xVCt+zomccIWoSA+Ao6EPn0o
 +giAHfDuPkfl7mI9V2o9CTmwQu/bToDIqrp2t6RxeX61E6/DFZGqgLnLxb/ENKpBkezW
 KVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071182; x=1789675982;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SgB+S9u3GSAcq8/Uuupwqbwj/4AB+NAz4BxPvnZlGUs=;
 b=i/aoZZ+roGVqZtyOm5JdrAg46JNfW7LX9qYg1oUbjzLS+QHIQ/sgDhK0uCceYGq90k
 VXB3YPP3TKyjZ7lw55JrqQSZQe821INETYw2PoMHrnPYoARtGtKPTBUz3AFvDiMH9M1d
 uIQiyw4CX8evTllqGfzhuvcYozfKGeUl9feN0oPtb2JFaQ5TFYuymkVRSymvKi6GBegx
 b/L+8rtQh/8UH4tvAO4drvmEAtzIz8WNRfmCXhobhGkkshkGXbgPg/Wzj9y/nvWVc4bE
 lw7/9r77KRm5Dfq5JSZMOCy2kfcVBK6K50OfKmD+f55p2t6ru5m+sne5zu6gXotZc8FN
 Bp/w==
X-Gm-Message-State: AFuF++l3MhP47B/9+JCsYicx0ybxcRr+g4pV15F7zMCt4v1IQSTrnnh3
 RPAh4sUmDjw7hyipIG2jFrWYTNu3+UTaRdL4u/zEYixWX/P2uBoCn0iuUIUW9ZEKqTHCTOkHK9M
 vLh54TK3lidjR/+5uiNFpEaOhFYyzyUqkI48G2nOlNr2Fczt7dtzjlaX+Pi0cvSacnnfGP8u+RM
 HIB3/aGPs2WYLeBMvoQMdALT8zEEJ7Ag9hxQ==
X-Gm-Gg: AYBFou0P0+5/gpZ9FPqFaa4NPD6CqlzS8bpvHngrCtpByBkd85XQXjMQ8EgQ1LtM5c+
 0Epk2R+YsxiLpZ+x93MopuLHgvwUEq9YCVZKMbU1lghOHumDOXfQDGVcU6+YqqXCIul0FS6eyDn
 ikXvM0j+AK+WvAbNqZrLRkr4FEipvImRsT39tVsJzUOgeq5+Yljbctz0Sz+KKgzS606KKzv2yNT
 MB9hpNx0Va8t+0M4YVryIQyKyYDoNYTbT2fJxM3v6ycspnaTcfRj6dwzHpXWHP6MtaqCpmAYGnt
 HWx2mDKhAC2PtpwNPEGOnk7EulSM1sdrb1VdSl9GZ6aJl8iLwMZbmMe8/ujHp0dw8PnzlCNYUrR
 wqP4BmtxbmWts9RvPy/H8W4A=
X-Received: by 2002:a05:6000:384:b0:482:e124:836f with SMTP id
 ffacd0b85a97d-486eb1d99afmr639097f8f.3.1789071182054; 
 Thu, 10 Sep 2026 13:13:02 -0700 (PDT)
X-Received: by 2002:a05:6000:384:b0:482:e124:836f with SMTP id
 ffacd0b85a97d-486eb1d99afmr639058f8f.3.1789071181564; 
 Thu, 10 Sep 2026 13:13:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm805192f8f.20.2026.09.10.13.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:01 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matej Hrica <mhrica@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Dorinda Bassey <dbassey@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 37/90] vhost-user-gpu: Add shared memory region support
Message-ID: <ad817502026a0013e2347d606770a5bddfec37dc.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260717134920.265128-3-dbassey@redhat.com>
---
 hw/display/vhost-user-gpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index cd684d6363..80ab6b773e 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -687,6 +687,16 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
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
@@ -697,6 +707,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
 
 static const Property vhost_user_gpu_properties[] = {
     VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
+    DEFINE_PROP_SIZE("hostmem", VhostUserGPU, parent_obj.conf.hostmem, 0),
 };
 
 static void
-- 
MST


