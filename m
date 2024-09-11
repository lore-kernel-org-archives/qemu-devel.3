Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F90EE49B8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOMQ-0003HC-0t; Wed, 11 Sep 2024 10:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOMJ-0002mo-Mj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOMH-0003z7-Id
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726065012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9zYqBsPTLqrTzbWp9haBTVRFIhZalRfUREIb3ugShtk=;
 b=IIPwhmyMf1kwfeTvJpCfsdxz6ceQYAcGzlW0/nnblhtebE6IFN/GeXrXFmsMFj4vJl6CgQ
 JwwWpJGzCx8CfzVIeXvjEfoqtm9XlNonkLD4Y9hLbgWN+IaDn2FKMiLLgyehvuSUye0uAv
 gbT5H7uPQjRcZr/XnQEN4rQAf0so1lE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-S1qeoSNsPQmPUueHa0qQHw-1; Wed, 11 Sep 2024 09:51:50 -0400
X-MC-Unique: S1qeoSNsPQmPUueHa0qQHw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a8a7463c3d0so428596866b.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062708; x=1726667508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zYqBsPTLqrTzbWp9haBTVRFIhZalRfUREIb3ugShtk=;
 b=ZAcjcVjv0HJSfq8L3ZLj2Ph+Ui21QvtgxrfuNzGsVHQP2KdJNdsoNSuG7dRu0AbGjW
 xDiRcMFvZBATsE80q3mUqST3AhAwNRQzaEjbTzYKiLf/SOKyrypzX+2bXArwTgW5MV1t
 NqnDnV9JQ9XCGGvVnKnq8OPvwb2QLJN8K0Qz9AJisoDpEVe5a5pxELopKGp6XkEX6q2Y
 Pj/NYgNB5NjIg4HbmpTpZtPEUbhoNooXlPRsHzh92UIlZq/Ygne/4Ntr7SzYVe+dmqRo
 MPbZdx0/gMTQ0IHq/Lu5if4deg88fs6lgKhmC4QPUVFlaY2vrpDZiTTOyaALiqfWCR+h
 f3yA==
X-Gm-Message-State: AOJu0Yzfyf41rM1mspZ1ygvtxa7xmM2MHYBbCByK35E/Bjwkzd8LyfJW
 2u74smDqlByZIM4rF8+sHcsLG0dd5vZxhsav6TykOboY1QcJrdxYCzzWnrPqt76GsfTwZi8dNL7
 tGfArLO4iJJUJqCUZ2kX57ZEde7ozVhKZh0jUbeEJFr7pSYYW8wAvbdiHf0PoePp545Kowztz24
 doCPKd3dCExtzhAGSjeGyZ7xT4TvzooA==
X-Received: by 2002:a17:907:3d8e:b0:a8d:4e13:55f9 with SMTP id
 a640c23a62f3a-a8ffaae3670mr459512166b.19.1726062708365; 
 Wed, 11 Sep 2024 06:51:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXJxl0aTKQb2byWlm3XEdxeHepi5POGTMCrx84gqqyUSQ7HgXr1fjPY9AUOB0fBDYzlpIwmQ==
X-Received: by 2002:a17:907:3d8e:b0:a8d:4e13:55f9 with SMTP id
 a640c23a62f3a-a8ffaae3670mr459508666b.19.1726062707830; 
 Wed, 11 Sep 2024 06:51:47 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c62541sm621866966b.111.2024.09.11.06.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:51:47 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Wenyu Huang <huangwenyuu@outlook.com>
Subject: [PULL 07/18] virtio: rename virtio_split_packed_update_used_idx
Message-ID: <e667485a80ed3f3849ea7421a63fe8ba553cd25e.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Wenyu Huang <huangwenyuu@outlook.com>

virtio_split_packed_update_used_idx should be
virtio_queue_split_update_used_idx like
virtio_split_packed_update_used_idx.

Signed-off-by: Wenyu Huang <huangwenyuu@outlook.com>
Message-Id: <TYBP286MB036536B9015994AA5F3E4495ACB22@TYBP286MB0365.JPNP286.PROD.OUTLOOK.COM>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 42589adf2c..a26f18908e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3669,7 +3669,7 @@ static void virtio_queue_packed_update_used_idx(VirtIODevice *vdev, int n)
     return;
 }
 
-static void virtio_split_packed_update_used_idx(VirtIODevice *vdev, int n)
+static void virtio_queue_split_update_used_idx(VirtIODevice *vdev, int n)
 {
     RCU_READ_LOCK_GUARD();
     if (vdev->vq[n].vring.desc) {
@@ -3682,7 +3682,7 @@ void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
         return virtio_queue_packed_update_used_idx(vdev, n);
     } else {
-        return virtio_split_packed_update_used_idx(vdev, n);
+        return virtio_queue_split_update_used_idx(vdev, n);
     }
 }
 
-- 
MST


