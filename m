Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF582C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTE8V-0001J8-K0; Mon, 15 Jul 2024 01:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE8S-0000uF-Dg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:29 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE8P-0007i0-P0
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:28 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70b702be5e4so1721705b3a.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721020814; x=1721625614;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NlrY553tddcDoCWOe56+tRoCgkm3F8OvMmopjLbpLLI=;
 b=fdAYiZ93VHpy3qejRXnu/jUQKxnNEdsjXtnEyA2q+36v1/4XFmPq0g3RSrCA5r9FJO
 zCR3LODh+VJBJo7QfhiD+FZ5whNeBKgSVSc2EowRQIB/3/8cGDB1wDOKwOccZJ6ecCMI
 xhDepq9aoubBzM2uXkocXGGAUGguyhh13UL9kguyC835wqVrn3oqn2Ho8jyNJ5MI6nph
 PqZDOsdOVvm6X1tREjVmwrEc7pbQ8jC1HRAMVers2YypPuwVlU0AC0NKvdD72PAuHlUj
 3JzbOSzC+MZev3wWVIv2V9xY1883llYIkuuQKuqcXVmlIVUVZTUewdLNx6LDBdcCui7b
 id0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721020814; x=1721625614;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlrY553tddcDoCWOe56+tRoCgkm3F8OvMmopjLbpLLI=;
 b=Ar/VqPjgbnK+AYazu0h0+lHui7QzP5C7cUKNN678/dKgUU4/kovw3RCQCW2G2a45w8
 AVGbNjM0G4Efh+McjHRjnoYHGZ0+sU3//5r7bq3aW9Lxv98PO/MDxSk8aV0qpwBNZFw2
 yVWtsHDptV3q1ixen7BY3e4dDJFh7mK2aFU7NImohqOkvCl8uCYm/0VJR7U0N1MDPvZi
 1ncCm/PMe9YuaXU25bEgLjsRsvLkDUUIkQSvSFEhfOoUt8VGwDo/QQOekAGPPyQZ9Ulu
 bkGBHtoXRV0afYnrpQsjNQIb9sEma3l2r8YO6zskkwTIT+Z/N/+0yxoIjIGY8X9Q/Wyr
 L+DA==
X-Gm-Message-State: AOJu0Yx9R/WKRFYbhkBrGMa01hOtKee98HIFSBLE7H1O5OipsB5Hpi12
 cOJtkDQ952TCLNfdGW4EeymErGKleeOOQe08rRxLOgw9rEeDr9+jNGT9fQUkV9A=
X-Google-Smtp-Source: AGHT+IErokbw4zB+9xbYFnB4kBHSAh+U7fYTlr6MWbvurqXNSIAG0wa5vkdyMS5ChXICEfbirrXRvg==
X-Received: by 2002:a05:6a21:32a1:b0:1c0:e997:7081 with SMTP id
 adf61e73a8af0-1c29822cff8mr23862825637.29.1721020813751; 
 Sun, 14 Jul 2024 22:20:13 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2cacd419e5asm5437630a91.28.2024.07.14.22.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:20:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jul 2024 14:19:13 +0900
Subject: [PATCH v5 7/8] virtio-net: Implement SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-sriov-v5-7-3f5539093ffc@daynix.com>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
In-Reply-To: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

A virtio-net device can be added as a SR-IOV VF to another virtio-pci
device that will be the PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/virtio-net-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index e03543a70a75..dba4987d6e04 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -75,6 +75,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_VIRTIO_NET;
     k->revision = VIRTIO_PCI_ABI_VERSION;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
+    k->sriov_vf_user_creatable = true;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     device_class_set_props(dc, virtio_net_properties);
     vpciklass->realize = virtio_net_pci_realize;

-- 
2.45.2


