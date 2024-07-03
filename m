Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14823C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8iw-00029z-RE; Wed, 03 Jul 2024 18:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8it-00028A-Al
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8id-0000uG-Ch
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8epoI+2XR2IZhKNbWvFqqmIBG6jX2/y5dIWNKzyj2M=;
 b=Gtu+L2sQgngilZs8geSlmw7cr+6Cb/ZpOfaWjROhKwY74YiKsYL1WiWCL0hnmOS/oMlTPS
 rw6sUKO7l8atv8EecYYpsjwDuHJKABkZERFJE703IDCX+/MsfMWExNbfGmiWe+Nbcj08lZ
 PW8mk8YlebKxmQWixzMV7qxqss6OdtM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-ITj7JCrkP9e4PEdjslWTDQ-1; Wed, 03 Jul 2024 18:44:49 -0400
X-MC-Unique: ITj7JCrkP9e4PEdjslWTDQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a77af33ce50so1193666b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046688; x=1720651488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8epoI+2XR2IZhKNbWvFqqmIBG6jX2/y5dIWNKzyj2M=;
 b=pg+POTc2S8LlZlqoIQnd89fdYGH0yovm7Ml8ZZRh0tW+lGPAJj6AAYLh/u1txuDBA2
 AOvDp6AbxsASx0/vXz0aRDZ7Np5PGCQ4r5SUSlSJR7py2RQqfObV2jaxLhxKURWvU6Du
 QG994EP40e75Z4nsMSvoDO8ytqGConrk2k3eukf4iZaG7g8k2io8zbN+kc43CdoIabLJ
 z78hmJWCbn6yLX8HHZeOuEGKrySmWw2thKzuqR9w0ZCmjuYKjOgGDg5gXgOsgKMXwN/N
 yHmyeym6Hf2G6WPBd1kXH/GEzUmqRuJV9b9NDMcwJ5h/DdNACVB6isiVBrvVPqmibxD9
 z5oQ==
X-Gm-Message-State: AOJu0YzgXuYRt4nidcHynOK4i0hxQIonQXSkfDZZmbwz1h6KR3z1IJFl
 WT9w2i6ORDX2qw4g+wkEX4e0friK5TGkz37m7OjDJsDNMZcAO16p/BW19bioB5OF1fA57b6qrwl
 KpZAWNAcDSkZBTF/vuU8UJX0qq4L9u8RFjzqP6VMyAitmjqny2SWIWEDc6DVpTBgT7A4jKW6ziP
 3PJzyH+dOceCsSb9ZfHoJ7PSe+4x1N4g==
X-Received: by 2002:a17:906:f2d3:b0:a72:7e82:7a15 with SMTP id
 a640c23a62f3a-a751440e853mr719976666b.23.1720046688355; 
 Wed, 03 Jul 2024 15:44:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYEQfzEs56MqWzOGDNAszCwhmos9UJKAtVuYn8Pk/MD4SYmLmw+MWhidktg1HcFjUSI8B+rw==
X-Received: by 2002:a17:906:f2d3:b0:a72:7e82:7a15 with SMTP id
 a640c23a62f3a-a751440e853mr719974566b.23.1720046687334; 
 Wed, 03 Jul 2024 15:44:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72b4280d6bsm501909866b.206.2024.07.03.15.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:44:46 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:44:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PULL v3 07/85] virtio-ccw: Handle extra notification data
Message-ID: <594b543a4a75d08f47e5ea92c96a89502a3eab72.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Add support to virtio-ccw devices for handling the extra data sent from
the driver to the device when the VIRTIO_F_NOTIFICATION_DATA transport
feature has been negotiated.

The extra data that's passed to the virtio-ccw device when this feature
is enabled varies depending on the device's virtqueue layout.

That data passed to the virtio-ccw device is in the same format as the
data passed to virtio-pci devices.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240315165557.26942-5-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index cd063f8b64..8cd912f20e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -126,9 +126,11 @@ static void subsystem_reset(void)
 static int virtio_ccw_hcall_notify(const uint64_t *args)
 {
     uint64_t subch_id = args[0];
-    uint64_t queue = args[1];
+    uint64_t data = args[1];
     SubchDev *sch;
+    VirtIODevice *vdev;
     int cssid, ssid, schid, m;
+    uint16_t vq_idx = data;
 
     if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
         return -EINVAL;
@@ -137,12 +139,19 @@ static int virtio_ccw_hcall_notify(const uint64_t *args)
     if (!sch || !css_subch_visible(sch)) {
         return -EINVAL;
     }
-    if (queue >= VIRTIO_QUEUE_MAX) {
+
+    vdev = virtio_ccw_get_vdev(sch);
+    if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, vq_idx)) {
         return -EINVAL;
     }
-    virtio_queue_notify(virtio_ccw_get_vdev(sch), queue);
-    return 0;
 
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
+        virtio_queue_set_shadow_avail_idx(virtio_get_queue(vdev, vq_idx),
+                                          (data >> 16) & 0xFFFF);
+    }
+
+    virtio_queue_notify(vdev, vq_idx);
+    return 0;
 }
 
 static int virtio_ccw_hcall_early_printk(const uint64_t *args)
-- 
MST


