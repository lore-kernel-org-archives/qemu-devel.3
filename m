Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8C1CD8CA8
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCr-0007Mc-Io; Sun, 14 Jun 2026 15:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCe-00077c-Vq
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCd-0002Nw-FT
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L82IqZcjvhDjhQvEYE7lWFL29u1mdBHp70yRlARDTLY=;
 b=RvhyJConm9xYwVDT/XzFYOgXgpUv+mm6uEwsWD+3evZ5XsBVavnYX30SyZX3DOtV2K6Ubu
 3ZpkIReXPGBgmT8m1VN0JSIU/mLLr5nKnuPt8HTLKfjv/XaF8FEyDEdqfcabGoYerxJYzQ
 BtPYv4FTpcrHsYkBCHkuuSts5UaKjd8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-s3JJnyggPRSk45jtKii-OQ-1; Sun, 14 Jun 2026 15:09:00 -0400
X-MC-Unique: s3JJnyggPRSk45jtKii-OQ-1
X-Mimecast-MFC-AGG-ID: s3JJnyggPRSk45jtKii-OQ_1781464139
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b9318944so16620385e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464139; x=1782068939; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L82IqZcjvhDjhQvEYE7lWFL29u1mdBHp70yRlARDTLY=;
 b=Jg+qjBu7gPi3v7UiGja91nXe52MNDEE37qH1zG5W+eOUE1HiNaPFmCqMFGmAWHcfG+
 GWrC8wf8OXC8p6XuZn1jDhwWveVp8Ms6lHsq5QTsf9K+LfLI0CkMBD1WF2rwoKNrODNV
 ySAYNhc6V57riuTruS0W3Q+hAnGHGOuzD73oCYTHygyj54GOcLC35YIIL2VNoak04ac9
 yN+MMJQHrhPHtvKzcZKhnofsCyVc3uVXBI3sYsaRO1uOLrhVhnYeOEL7taJt4Fkxewpr
 ZBpcS67P7XhDu5onSYkP7HQDTVEqMLmPosnNkFM/HLUwEkuWCN9mm3JMziVJP/4E6YQG
 SvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464139; x=1782068939;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L82IqZcjvhDjhQvEYE7lWFL29u1mdBHp70yRlARDTLY=;
 b=DAL7dpegiXD+WhCknUMrv9vGl7s4M1ynxGsDI0Ew+V0QKEpiX193mcmNrl//RCz0Ej
 6entpeEFAH956vL1+0qjKM2zGdSTmNv893uCVvVCkXLSE9dXyHvRnZbV/IsnWkiFXr8T
 vKWct9JjkdYYy2VdxscC0zybiYmZlTlsHRq3A0jd92DbJz4GHhbv52F6nwUxppF9Cg6G
 Gdir6Sp5DTgeAiDNL+MT4Nct6wzxn+bjjzOJEfWe1jCXuiUKhXJ5g8TNH4JVSv+VxZKn
 1gmT/eddK9O8i2hvcUPk+d1QbKs0vB7dXDer+WusTxWpjt2dyDuyVrZXXw/gWqWH/T/C
 Drug==
X-Gm-Message-State: AOJu0YwPa4AhitU7KMo2pSAOmanHCVTY+r68+/XiTW7OSJVBoteI+B2s
 3ODncU4AYIgI7Vzr1yB1poJTxaT06Z+GDQNIAZLD7lG+O81W0MxJMns0FuLcro94ewWfcpX5x96
 v0ZTL4Ee3Hp7wU1MMZmI5rRB5/A7MH0USp9rnqDRTkgGjZf5/U1Vj6ie2c+zWLUKIRc+dfw9bN4
 /xC1JFNkhG2g3d3W5T8sajdA0OcDOVXnT3tw==
X-Gm-Gg: Acq92OEqycMxP52d3G14S3soqzMSF4RcWuhyLBE+eDq7l99EE3w32dMU/7kgd0vj2/F
 xPDLuh8FbIly3aeD2JBb4PpQBajggr3jLGYs6Nru7DD0jNfIwtF5LTEWIcnrvsX+RIp8FNTJldk
 wSuglDjxiuZKYb4f1HKSu+gH4lcss1L8gvpEvjds3GSGlEF1jyLx8O6OJmhn0UOALdnUXht2Jra
 xptdWFVY6ziQqlH1OJy7gydx3yjvg0jjSTPUj5wTMZwh4UamTW6GBGAAbyvf36/8skgvT0n1OAb
 IVRetRrHSU7ywF2pNRE6klnUBGhAyut/2rnLUm4NYF311LYShcKw7E8C68vuxRDRuOL5tyj7Jx/
 4lmNJX3mab4YlVwYTJsakUUP12+6kK7T8xAad9izXabg=
X-Received: by 2002:a05:600c:138e:b0:490:d354:bd00 with SMTP id
 5b1f17b1804b1-490ec507db7mr148172535e9.25.1781464138997; 
 Sun, 14 Jun 2026 12:08:58 -0700 (PDT)
X-Received: by 2002:a05:600c:138e:b0:490:d354:bd00 with SMTP id
 5b1f17b1804b1-490ec507db7mr148172285e9.25.1781464138472; 
 Sun, 14 Jun 2026 12:08:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d70sm27361271f8f.19.2026.06.14.12.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:58 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 076/106] vhost: factor out the detach buf logic in SVQ
Message-ID: <7291b1a5f8b0c2dfa95e544dd59fa8144dde72fc.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

This code path is modified to handle in order devices.  Abstract here so
we can generalize on the caller.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304173535.2702587-6-eperezma@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index e7e3c9155c..2d8fc82cc0 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -473,11 +473,24 @@ static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
     return i;
 }
 
+G_GNUC_WARN_UNUSED_RESULT
+static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue *svq,
+                                              uint16_t id)
+{
+    uint16_t num = svq->desc_state[id].ndescs;
+    uint16_t last_used_chain = vhost_svq_last_desc_of_chain(svq, num, id);
+
+    svq->desc_state[last_used_chain].next = svq->free_head;
+    svq->free_head = id;
+
+    return g_steal_pointer(&svq->desc_state[id].elem);
+}
+
 G_GNUC_WARN_UNUSED_RESULT
 static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
                                            uint32_t *len)
 {
-    uint16_t last_used, last_used_chain, num;
+    uint16_t last_used;
 
     if (!vhost_svq_more_used(svq)) {
         return NULL;
@@ -500,14 +513,9 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
         return NULL;
     }
 
-    num = svq->desc_state[last_used].ndescs;
+    svq->num_free += svq->desc_state[last_used].ndescs;
     svq->desc_state[last_used].ndescs = 0;
-    last_used_chain = vhost_svq_last_desc_of_chain(svq, num, last_used);
-    svq->desc_state[last_used_chain].next = svq->free_head;
-    svq->free_head = last_used;
-    svq->num_free += num;
-
-    return g_steal_pointer(&svq->desc_state[last_used].elem);
+    return vhost_svq_detach_buf(svq, last_used);
 }
 
 /**
-- 
MST


