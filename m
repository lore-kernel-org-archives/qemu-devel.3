Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F429C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpL1-0001KA-1Z; Thu, 27 Jun 2024 09:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKy-0001FF-0Z
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:56 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKw-0006Rj-Ci
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:55 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1faad2f1967so4741795ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495533; x=1720100333;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jOjlX532fbSm/MfzxqkUiGMJdKmyu/k4tTVPVBmckwI=;
 b=p3qr0+SkmQk1jz7lZKJzBUqbMtbpK0mKS84hCbY8OIrNu4ryc/kwJ34HxyUK6UGGos
 Y0fqPcQBSitSEMI0PvER7pxpHlnqGTR/hH3SOrSBe7RusQ0uWT/Fo6YQAefIGvAg5amz
 yn/0Au5TJoeWbA1HzWHUbzPc6ygAgCiczONHwqCtycYjRD3g6vfHCXQVIFJFX4mhvELS
 Zpf2FZDI0L44Tzgq6/AXC3tnf2Y4OMoqPnvI1tk2SggsTxhkWtyr5EpJGwo1duUk43yj
 mCIBlXF/6uOprrzO7s6VV/pA2YPV01YDOKGjyQlSRfObhgPXrUknnkVa1WDv0lUlyXjz
 g5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495533; x=1720100333;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOjlX532fbSm/MfzxqkUiGMJdKmyu/k4tTVPVBmckwI=;
 b=N0Uu5nmhuc7O+W0rosJOy8VrDZnKoDhvBzRbFk8qM7XcgC8UIkZB3j0+qybIugGr6+
 8NVCNiZXS4gp9UMXaO32O+QwqAh1Nj8395CoId26TMdlq6m4l7Th4961tzXOqjoBcgvl
 wCy7fZmOVyVoS4EiRpuIeI+DuavQyYNPN1IPS/uZzkPgmmKDitSNogmGlSgCCPaAO/m0
 X6V+b9S1KbjZY+kA5TqUugLHMvipZVLFgDF+/pEnpn6TODoG7y6QLPPq2RMtREBzd3wX
 p1C/CIIZe2FSTQKFkKk0p9fcA6HruGXoy/MrwEslpNBkIGS5ZK6emppiLluN6siswzmt
 9yVw==
X-Gm-Message-State: AOJu0YxsE/OmyY4hg1M2MzWmfRDjOMAydeHKDoSYygHZP1AiJ5llvYX3
 CyyDZyyskx8RD4+rl5VjoQnqMD4j+PCWHIs/NGiWVjz1bvwV+CmDM19elBBfnGM=
X-Google-Smtp-Source: AGHT+IEsd/pK7793+mXsdWMSRBASbbLo0NH3GV736hPrqauCSFkiwnjE8CzZdSLfrh8RDV6qe4Qb4Q==
X-Received: by 2002:a17:902:ea05:b0:1f8:62a1:b6af with SMTP id
 d9443c01a7336-1faad4c7cc1mr26078615ad.21.1719495532682; 
 Thu, 27 Jun 2024 06:38:52 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac999bfcsm13185575ad.234.2024.06.27.06.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:38:52 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:50 +0900
Subject: [PATCH v2 07/15] hw/virtio: Free vqs after vhost_dev_cleanup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-7-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This fixes LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/vhost-user-base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index a83167191ee6..124ef536206f 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -223,6 +223,7 @@ static void vub_disconnect(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    struct vhost_virtqueue *vhost_vqs = vub->vhost_dev.vqs;
 
     if (!vub->connected) {
         return;
@@ -231,6 +232,7 @@ static void vub_disconnect(DeviceState *dev)
 
     vub_stop(vdev);
     vhost_dev_cleanup(&vub->vhost_dev);
+    g_free(vhost_vqs);
 
     /* Re-instate the event handler for new connections */
     qemu_chr_fe_set_handlers(&vub->chardev,

-- 
2.45.2


