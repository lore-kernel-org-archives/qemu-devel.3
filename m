Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34888E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTz6t-000422-AL; Sat, 04 Jan 2025 03:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6a-0003ks-QV
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:58 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6Z-0006i2-Fm
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:56 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21661be2c2dso165240065ad.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977714; x=1736582514;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J0JQM/aP0W17LDTb+wBV4wTDP/u13ijT1gRctKp4C3w=;
 b=v14/OGRA5ZbQJolrmycXl0PVRIuKbAXSOkJpNg7uw8xX45Sxavqah35AQ6Ui3ZPBxc
 y6s/9q1+mPm6y1UhbmC9GhBrnGqoLFFK7LhQyQt/rnmGGXLEOSg18dyX1S4AECy1RJrV
 jHezQf8zIpOHi7VnrGXCaE2YebTCcQNK555GVi+S3bZq8FJK+Z+bs6rVahBQaE2zlcjg
 1pX0tP3eagKFE8EYoqsSyu31s8yc2xeuqrQnL3mKxBbg0BifQLfvwj7jEHEMlmyNe3SM
 hZZUgx5lNyOPJvdJUs6u2NrzkdfXM+a2OAV8yXPKQgALx3dyLizKou8ZQfc5cf3K8m7G
 dMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977714; x=1736582514;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0JQM/aP0W17LDTb+wBV4wTDP/u13ijT1gRctKp4C3w=;
 b=vL+TsVw9rMmy8kOPZhHr1fmvHpXl7sHhBqncqm64orvrc9lS4L6IUrggDRgVrI0FUN
 aHdYa+yMtAvRATPX6CM0ZcR1klJYm1JpP43TqN0R4Ji+hFx+Leh9Rfn6msy+oYstKLu/
 63/DdlH24Pq0GgntFetHoNKHHSmgGixDWoFteOm2KEUYBEa30N6tVbBNwNAPOcuwJwSg
 KjTLN0rYt/al0mN0QdrcbvEC28rb1vOeZsqQEO2qmwvYLs0YoCvFYQ6j7XG6/GkAMq0K
 NTVSssbb8lqoaSiwf8vD6j+Fp9rBBzcaHQP2Y+YbbJCTNU5Uba2+TiQz/zkz6nRKkjTZ
 m5ZA==
X-Gm-Message-State: AOJu0Yx68m0LiM3YVwsNd9szj6BdKHSdkD9zkGav1zQqdCrYphvJIbFY
 nSDHS9tAPSedViW4U/9A5hQs31xJf5Q8DNoaK2LPHw8Ke42xZdiTn42JWtj4BLg=
X-Gm-Gg: ASbGncsCZ8HaAVPjXVV8utMQyXvxX/yyWAJ/MHBsrmAxFCdFnjhaRRsqGsimHYPUAJZ
 RBGA31HE5GNssdwx4vBpF99ughjMrbyo059q60fS0D1oAhr0f/4n72KMvpnrgj8AsK1fO+yFc3w
 mzbPMhqgHCNO59AugzVtQbfne2JX5BAUy2xBrvLC/qBYb/HtcxBLeB2Sw/hCZ4h1qdDVm7DDQXV
 XOFqjERkraRlQvtgel/aLadmmb1R5UHtRWMFK698U9eu0XHV5aRW+eIxSZu
X-Google-Smtp-Source: AGHT+IGhZtYVn3vNwV0TngVRHeMJ7ixq5+jl0fpOHdJ+oA4yH35WmqVBPx3HJYpZRVRvzBHA+NiFNw==
X-Received: by 2002:a05:6a21:8dc2:b0:1e1:ccf3:a72 with SMTP id
 adf61e73a8af0-1e5e07ffd40mr78064894637.28.1735977714265; 
 Sat, 04 Jan 2025 00:01:54 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad836bd9sm27512968b3a.78.2025.01.04.00.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 00:01:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 17:01:00 +0900
Subject: [PATCH v8 7/9] virtio-net: Implement SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-sriov-v8-7-56144cfdc7d9@daynix.com>
References: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
In-Reply-To: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A virtio-net device can be added as a SR-IOV VF to another virtio-pci
device that will be the PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/virtio-net-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index e18953ad674b..430b727ea3f4 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -74,6 +74,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_VIRTIO_NET;
     k->revision = VIRTIO_PCI_ABI_VERSION;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
+    k->sriov_vf_user_creatable = true;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     device_class_set_props(dc, virtio_net_properties);
     vpciklass->realize = virtio_net_pci_realize;

-- 
2.47.1


