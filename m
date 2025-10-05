Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0BACCA472
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UGR-00063d-KL; Sun, 05 Oct 2025 15:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFu-0004qI-Kn
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFr-0006gZ-Qe
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TDyjruV7w7paGoEpfcBCyEgnLqMWCeMdqSyQl2kakFc=;
 b=fFhdCdnSt0s8J7GRiQsUrqQResEulZOaPud6/DGsn02bNC3hJxgz1nT+I5+fzo/Bwt7Bh8
 LY6fG5I5jM5IR46YBAhLGhiXVCgfk6kDSEXi0nLwZTV/fuVlwMtcl5QHgRa0UQJSRva4uz
 UBslBmwPWUOpMoPh4NpJ2nKgQ5od144=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Zs5pcooqON6506sQawg70Q-1; Sun, 05 Oct 2025 15:18:45 -0400
X-MC-Unique: Zs5pcooqON6506sQawg70Q-1
X-Mimecast-MFC-AGG-ID: Zs5pcooqON6506sQawg70Q_1759691924
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdd80ea44so2980037f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691924; x=1760296724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDyjruV7w7paGoEpfcBCyEgnLqMWCeMdqSyQl2kakFc=;
 b=XvTYyccYF0Z9curdCvwxgw3Qc7c4HT0BhRxp7H1pbCB9BoGWVHRAeJvAHv4VEHmH0S
 xZStiIN7c/T2/dlf36TAc0XOAi8VOi0OGMN7TZ9Q9eF4Pw6YOfRKaR4P2MscB6yA9aiy
 HiEO3bYwb17Xb4g5wRQFChtJVtIqzF0aU4eqgehkqenhgRG/d2/DdWk5OhigUYuf5hh4
 KtZmJYbnncfbzQuLx7dDNxpnq4z+vA7tm5cKIMKh+8QrAgit17e8bRrJ68V0JaY0Bayz
 xxyb8BlMCak1Xh756uZ+lcKuXB4876SSSVVb8Ntu/lzK/g3MalXCRAtb71vfjrVdOFDZ
 80HA==
X-Gm-Message-State: AOJu0Yzo9mSz92aNOK8wDEGdUwuY0Dv84GRYuRSFCZQ1wjtKZi/FHaE8
 /6+zRJ/3uDRn2+ZWD7DQpjezN2ZhKSNNI1uBYnVYXazkNf7jNFnP62m4rg73FTmp++JLdsZ1GUq
 acJVXaHWu11sjSDr8ryUv9o/0+RSrfoG3OPySqOv5xi0v07tvc1oilW/2qiu8wDHR5Bu6fsF6pf
 +bs8fkQICZ1vMKnX0SfOHDc7MeHv9dJoXtGQ==
X-Gm-Gg: ASbGnctFZFG6Lp7VhE7w8xbYlvA/9F2/lhRVE7JtLLqkVTkNxxzNnZ+NU/qSjLbtLN1
 REr+OPPZ48ImtTPVevIntlTIHiSUpwD1GIdvRjTEKagUtOmkkerE+LSmjOKfT167ypIFT4MiKls
 pdvxXCuLctipcWVsCppdCosBCgvBgjA4FEUz/FwieDQrr5aP5pMuplDLQVTUGc7eRV+/8gEy+Hf
 eO4Qyi00XKtxvXOdxsxoGhe6AWhH2TGNE0OQcqP23Z3HgMMBcjmLZZjPAacz00Tm7MKTdd4WJ8r
 bFuFF1TFf8/UZ8lZJ7bHDnF+jyVhiIPj7wwZRq8=
X-Received: by 2002:a5d:4745:0:b0:425:723b:377f with SMTP id
 ffacd0b85a97d-425723b3c83mr2536625f8f.11.1759691923607; 
 Sun, 05 Oct 2025 12:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGavaIZuPXrtSDNvT4Pbz1xuageFJjpJ8C+Nc9iPN0i0tPe+NIieVQvLiwmxBIzGnKsl80Qbg==
X-Received: by 2002:a5d:4745:0:b0:425:723b:377f with SMTP id
 ffacd0b85a97d-425723b3c83mr2536605f8f.11.1759691923000; 
 Sun, 05 Oct 2025 12:18:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b8507sm222807075e9.3.2025.10.05.12.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:42 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhaoxin <lizhaoxin04@baidu.com>, Miao Kezhan <miaokezhan@baidu.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 72/75] vdpa-dev: add get_vhost() callback for vhost-vdpa device
Message-ID: <f0e880f727e2c82e2a9654d53fcab732b6c353f2.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Li Zhaoxin <lizhaoxin04@baidu.com>

Commit c255488d67 "virtio: add vhost support for virtio devices"
added the get_vhost() function, but it did not include vhost-vdpa devices.

So when I use the vdpa device and query the status of the vdpa device
with the x-query-virtio-status qmp command, since vdpa does not implement
vhost_get, it will cause qemu to crash.

Therefore, in order to obtain the status of the virtio device under vhost-vdpa,
we need to add a vhost_get implement for the vdpa device.

Co-developed-by: Miao Kezhan <miaokezhan@baidu.com>
Signed-off-by: Miao Kezhan <miaokezhan@baidu.com>
Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <2778f817cb6740a15ecb37927804a67288b062d1.1758860411.git.lizhaoxin04@baidu.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vdpa-dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index d1da40afc8..4a7b970976 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -338,6 +338,12 @@ static int vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
     return 0;
 }
 
+static struct vhost_dev *vhost_vdpa_device_get_vhost(VirtIODevice *vdev)
+{
+    VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
+    return &s->dev;
+}
+
 static const Property vhost_vdpa_device_properties[] = {
     DEFINE_PROP_STRING("vhostdev", VhostVdpaDevice, vhostdev),
     DEFINE_PROP_UINT16("queue-size", VhostVdpaDevice, queue_size, 0),
@@ -369,6 +375,7 @@ static void vhost_vdpa_device_class_init(ObjectClass *klass, const void *data)
     vdc->set_config = vhost_vdpa_device_set_config;
     vdc->get_features = vhost_vdpa_device_get_features;
     vdc->set_status = vhost_vdpa_device_set_status;
+    vdc->get_vhost = vhost_vdpa_device_get_vhost;
 }
 
 static void vhost_vdpa_device_instance_init(Object *obj)
-- 
MST


