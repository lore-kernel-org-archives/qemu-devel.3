Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B07CC44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkft1-0003Kx-A3; Fri, 17 Jul 2026 06:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkfsz-0003KW-NO
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkfsx-0001R6-09
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784284418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4s1N6E1ijreaKGc1qpNnCMTcrq6TD6MWW0x4mk/QYbs=;
 b=MbkdbBsOAhOQM6wtjkSY5CTI/hSF5IpACPX1wbdZFm0KgxbC805AJR6u/+72QKL4WHaerc
 xsPBWmPZiQP2YxLTa3MvkCKgirfdMMXr6QK0X4FO/yzhZTg4wmEK5XSCMQ5mZk8QfjH+9C
 r/8DPQsP4fzLpLLBqi/CvDHZlIYbyS8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-E_jOMVZZOxSGfUa0BwQZLg-1; Fri, 17 Jul 2026 06:33:35 -0400
X-MC-Unique: E_jOMVZZOxSGfUa0BwQZLg-1
X-Mimecast-MFC-AGG-ID: E_jOMVZZOxSGfUa0BwQZLg_1784284415
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-474170b59dfso4439645f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784284414; x=1784889214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4s1N6E1ijreaKGc1qpNnCMTcrq6TD6MWW0x4mk/QYbs=;
 b=e62vF6paSLs4DJ8KqX8JKMmmyjFzKTvSaudSDiOIO0CcpeFWmLUCy76iHlF1/Jf+lg
 72DlMLxrKkH2QisE3B/NNBn1MRq3dQuAB0/hcYfYgf0DYYrPq+xLoIb/g/Z/FMh73PuS
 ie3gb5sbJPFoJrNNUPtvpkyq5znSTIlzNDBqmsOvf0ms8ie7kccIP8U/6919Ma62kTuy
 nUFI6XnX3xHMP/Jhinn/Bp2p6wz4KSx/D8gmgW56tryBbhcXHrCiHvmY8KBaHPRUbGHc
 NOa04p7AHbpGhFkI9EXk1/XCWV51Y29R2EsUUpZ9kHRJpYhWQgo2XdySO61JFs32ZKI9
 2KYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784284414; x=1784889214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4s1N6E1ijreaKGc1qpNnCMTcrq6TD6MWW0x4mk/QYbs=;
 b=H1sKXPjYjmc8u1tVigG73DbZI0K1FDkZRduu5qLTLmq8s7idDXYkkZxDnGzu3v05CZ
 6FYoG519IMWLl7KxdjDR4NbZds2zR2F87Mv8Vdiu+F3LjRLIDF/sKl5gYuBOztEkMht0
 RNA2DzyCZVZ9iRzSLz2votrcx40oWZZoFSnA9rStp6yo2R6rCu9zT+7vQN7aaDqBaNxV
 wesgN6bF7V6xXdHDWt7S/4s/Ehj4ovSjZO0Dc6CzEEQVIF+tdiJkRgsqDqFDQO6pEXQm
 tus4NhxuDIJ3esfcX2XZjbvzoWZdMUIgKX9i6ssj6dR5yZjJne+6QRx7AgjYTBkhfFwx
 s/yA==
X-Gm-Message-State: AOJu0YwlCrcsejKgoWU0sh4UROZxo+6ukjgbWK25HpfbuMqEgFdLTvU4
 Yj/OmENghzQJQArPwVUBUb0T7QEI1rahAlUTOeRn+fFz7YZP+CztH/immgwBDKAdn79BHfZzjJr
 hbEqiHQc23di/JJPnItq3CR4R3nX6MJQZ9Stcm7tEDNL6F3NO1TTetE2nWmf8Vrurm8h+j0a+5U
 Bz5Dl5QH6uJkd79M2cZPvifM3+9ObPVzILUEkOO2zmwJcF
X-Gm-Gg: AfdE7cn8+7vEFWVRS/KUPN/AYi8C4h/yA7YVkqSGyUQAPEOlR4oc0F3OBHEt+I1cMcz
 22QvRn4XxBi+nbMm8S/h21IC8qAODbiH/hq8Hur/SG16G4+dw+GCggk+phIL+Zls1pT8Bxg2SrI
 pnZOzU3x+r4dP8rRjI7U9EAp0PTUtNfa7D7tfgsy4NNoK3iZkF5U9rMtemJjRtfOsqONus2Bqzz
 CCefqK6cSs+D4hBlnW6MNsBkvCxaMRAX3iDNkxpgLqgdlrulRu9xk/pBFH+c0OfbgC9veES15X1
 GDE4KjoNXaqLn7kTh2PWGYzK5Z1tR58cwbL2GV6z7H+EsKNS6nwZczb3u9xFJDM+OftxxaenA9q
 VsM4kolIHv9tfttxJ9mLj+B9prnxXCl26eRNf6v7I56Vuw6eDpkOY+JyXHFUnxky+0k6avueO4v
 iIUvJa7Z4=
X-Received: by 2002:a05:6000:41e7:b0:465:81cb:bb20 with SMTP id
 ffacd0b85a97d-47f6230767dmr2793949f8f.9.1784284414627; 
 Fri, 17 Jul 2026 03:33:34 -0700 (PDT)
X-Received: by 2002:a05:6000:41e7:b0:465:81cb:bb20 with SMTP id
 ffacd0b85a97d-47f6230767dmr2793894f8f.9.1784284414113; 
 Fri, 17 Jul 2026 03:33:34 -0700 (PDT)
Received: from fedora (cst-prg-95-48.cust.vodafone.cz. [46.135.95.48])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed2313sm2523298f8f.23.2026.07.17.03.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:33:32 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH v3 3/3] vhost-user-gpu: Forward RESOURCE_BLOB and CONTEXT_INIT
 flags
Date: Fri, 17 Jul 2026 12:33:01 +0200
Message-ID: <20260717103301.228974-4-dbassey@redhat.com>
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

Forward VIRTIO_GPU_F_RESOURCE_BLOB and VIRTIO_GPU_F_CONTEXT_INIT
received from a vhost backend to expose it to the guest.

Use vhost_dev_has_feature() to query the backend features, matching
the existing pattern for RESOURCE_UUID.

This allows the guest to negotiate blob resource support and context
initialization when the backend (e.g., vhost-device-gpu with Venus)
advertises these capabilities.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Matej Hrica <mhrica@redhat.com>
Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
 hw/display/vhost-user-gpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index dbba80c7783..4022a3026ca 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -643,6 +643,12 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
     if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_RESOURCE_UUID)) {
         g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
     }
+    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_RESOURCE_BLOB)) {
+        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_BLOB_ENABLED;
+    }
+    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_CONTEXT_INIT)) {
+        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
+    }
 
     if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
         return;
-- 
2.52.0


