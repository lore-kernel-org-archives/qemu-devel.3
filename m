Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEEBE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxr-0004Wg-IB; Thu, 19 Dec 2024 03:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxp-0004Vm-Cl
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxn-00056w-I5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRvXaOIiQljc+ZwkCS91Aq82+cVbl1J4OCKByiO2hkw=;
 b=HzxEuJPsYJPiHcnngpOs14x7B0HVKNAp4Q2NsYAv6PSageFa6Du4BcSAjgaDRjR0d8gas6
 MSXkl86dWtbYsfMBMQVeLLPW9NAq+n9R3Dzr046Ygi0yngA3i+fc7TvZ2aT81/whO4hM0y
 jGZz9lm0keD80zUuNL4cgNUiXEbFJj8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-GW3S7Ww-NSqGBZ1UG82NMw-1; Thu, 19 Dec 2024 03:32:53 -0500
X-MC-Unique: GW3S7Ww-NSqGBZ1UG82NMw-1
X-Mimecast-MFC-AGG-ID: GW3S7Ww-NSqGBZ1UG82NMw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385df115300so257124f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597172; x=1735201972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRvXaOIiQljc+ZwkCS91Aq82+cVbl1J4OCKByiO2hkw=;
 b=egXkdGDbP02XaX1zfILcAceJn5lMcIzQKblU9rTwCC3L9GyD8d+avnIvBaigvQKGlB
 czSqKBf4uLJWEhy+Dqp5cEfNqWV09iOHMhEXn2oAfcsJQBD14iXzsDNK74GvQcBZwOUj
 jEXWKPkI3/aP4w4R+e/d5/+DilTzSP3biI5ReRBGUOy1WU7jWqovA879w2EkqGHYDIpS
 K4TfWH/dR1A+I1a3QhBjnbXxBp+xBkGfXgucqcF7RhajEbEAEAnByiDzEvSDgQeQ8otZ
 UNELxVSf9rn9twr5exBoHVGGgIcooI86hz3+a90m4rLHZtSmC3okAxwk6+3QUpYOX+ZA
 wevA==
X-Gm-Message-State: AOJu0YwRZZUNXSzg0Gt3ZK9lPr/TJtg6lLtWE2ECK8Yj+ilOfjRqJWiX
 0VyxP6mgDzTnIslBY1ZduV1uBcsuGYuGcyblb/kFwHr4bVCOQQ4Gv1btplSOaD+TDRBOWf3fqeK
 WPYnxiXm7S75qx/AqUv2kKPjVoQiKTlJMUNxtA9SmQaqO9QZWKM8qjyYahjjBS74McekK+AlEKp
 YZesNmYOsQMJm54EY9KWfNPM5b5Sey5OVIIfwx
X-Gm-Gg: ASbGnct2y76S1fKCxCGFcmXF9vHwESTo0p5852SnNN9TqP4nCsWo+gwW1faJU56k9Lo
 CLLEi7UITNk877KjGaDOVqUHhlp2CVpOegCtXDgo8rqXca34XKskLcnLngYArP6oXdGlKN3r/PZ
 976hfK0k5MFDCkiI4O6wAZjnN35E+i0bp07W5y7+aeufU1QcbQ/7uGl0ZOyU4oHWnM1DySTCiSI
 6QtUdeRQwgV7f71Zm6VPsUUeKdhiXSbhuJICU/ISGcMcLOEYMZz0CyBdTGN
X-Received: by 2002:a5d:59a3:0:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-388e4d4b63cmr5617955f8f.5.1734597171799; 
 Thu, 19 Dec 2024 00:32:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ09Z+lsYrzmr5vyDxKKNjJvs02a0DcXYW666qQbSnNJ3MgDr8R8G96myg3ZKg4BSKuWpmGQ==
X-Received: by 2002:a5d:59a3:0:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-388e4d4b63cmr5617929f8f.5.1734597171359; 
 Thu, 19 Dec 2024 00:32:51 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2d2sm988883f8f.71.2024.12.19.00.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/41] hw/virtio: Remove empty Property lists
Date: Thu, 19 Dec 2024 09:31:58 +0100
Message-ID: <20241219083228.363430-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-12-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/vdpa-dev-pci.c       | 5 -----
 hw/virtio/vhost-user-snd-pci.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/hw/virtio/vdpa-dev-pci.c b/hw/virtio/vdpa-dev-pci.c
index 5446e6b393e..787926801a1 100644
--- a/hw/virtio/vdpa-dev-pci.c
+++ b/hw/virtio/vdpa-dev-pci.c
@@ -48,10 +48,6 @@ static void vhost_vdpa_device_pci_instance_init(Object *obj)
                               "bootindex");
 }
 
-static Property vhost_vdpa_device_pci_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static int vhost_vdpa_device_pci_post_init(VhostVdpaDevice *v, Error **errp)
 {
     VhostVdpaDevicePCI *dev = container_of(v, VhostVdpaDevicePCI, vdev);
@@ -80,7 +76,6 @@ static void vhost_vdpa_device_pci_class_init(ObjectClass *klass, void *data)
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    device_class_set_props(dc, vhost_vdpa_device_pci_properties);
     k->realize = vhost_vdpa_device_pci_realize;
 }
 
diff --git a/hw/virtio/vhost-user-snd-pci.c b/hw/virtio/vhost-user-snd-pci.c
index d61cfdae631..0cb86b7d85d 100644
--- a/hw/virtio/vhost-user-snd-pci.c
+++ b/hw/virtio/vhost-user-snd-pci.c
@@ -23,10 +23,6 @@ typedef struct VHostUserSoundPCI VHostUserSoundPCI;
 DECLARE_INSTANCE_CHECKER(VHostUserSoundPCI, VHOST_USER_SND_PCI,
                          TYPE_VHOST_USER_SND_PCI)
 
-static Property vhost_user_snd_pci_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void vhost_user_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VHostUserSoundPCI *dev = VHOST_USER_SND_PCI(vpci_dev);
@@ -44,7 +40,6 @@ static void vhost_user_snd_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
     k->realize = vhost_user_snd_pci_realize;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
-    device_class_set_props(dc, vhost_user_snd_pci_properties);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
     pcidev_k->revision = 0x00;
-- 
2.47.1


