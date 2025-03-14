Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDD9C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 06:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsyL6-00055w-MY; Fri, 14 Mar 2025 02:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKg-0004Zt-9K
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKd-0005Py-5s
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:44 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2243803b776so50812805ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 23:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741932941; x=1742537741;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=biLmuq0clhGv+AwW0GSZTI17ZCwKpJG4MasDFHakMBY=;
 b=iAVbUhf6Vd95BN+0LU1/Vx5CZvfdDG+cqZR2jiErZRto5oR4jN1xRhCyXCp6Fm/+eL
 0Hhd0TuMs3MS4F1RHWlbRvnhvbEx29M7RzcXTFPfXw/Pzh5v/IaW/3eaAaf7R7czlY8E
 bpYS9cuF7AbXyUMUoSAofcpqxJDjmXj8P24x6BhIeR+75OMS2s0n0YywGglHTmXr3BKM
 Zir6BHtFQC1CSXtnPB85e9KJCIiU6mBHGl/bV1geWqDLgdjmevUqr9pkXH06RLnV366Y
 DqFNVh/iBtgCYqE5DvuO8/Wf9hguP9kAKPKInhT+BrslEiK9Hu6FT6V4KBogzdtmGZi/
 kakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741932941; x=1742537741;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=biLmuq0clhGv+AwW0GSZTI17ZCwKpJG4MasDFHakMBY=;
 b=Ef+8OB74oiEQWlAglo9nQM7jW93eD2MLDqmKmwg/CyVdG6SqRa3ddusMBCL2oz+P3b
 gqbRfAdP6hvKivX6yskTdZgXUqalSStA7hpy2i9ujFrPJqv6oPLpmatK+EeibglB590X
 LyCvxCm9sFFxP+T07TiiGsOP6QGA2sMjmL8tKNL20Rrr9HZY++v9oL4RsNwZClOY80RE
 PGbktw50dxqp0NuwmrNaqfqKafvDPjNN8Z7Ih3zfJ8vZqDMISKsUKNuFyfzJQA223dbp
 cOxjkfb/aWPZZ3TtTkOqA3YdeSob4k8E7SOpsZxWXAlEDS1fQOkjSKdByKg/Z94jsTL0
 Pwig==
X-Gm-Message-State: AOJu0YyftfpCk94BP4zIxm3TTZS2+A49QwDZv6lp9vnV5/MRWTH3oVWT
 WibcpUYyXHKsx6ka5Re1HECHua9vCFAqNLEfgo8UsglvgAgDwADBTVZp3jhPvpg=
X-Gm-Gg: ASbGncv0TKdSZtjZNI/X/EiLIfnnIkkOkJc6VEbiMdAuY1QhRsTORp0YaRzuw1Z9/GV
 b1jGGNrdlop/pgneJaw9RSpzjozMqEdfjVw+eU4izNb2vvdt7knGfiQXeDrnI6fQA3nU1mC1hFj
 eKGPUSutfncbw5Wwj+lAcBefYdAQCeRde5lSrg9eh4LGdsjQ+TmtNnV5yTa8O6U5PIA9RnbhgTd
 K7q34Ri1P0ISIhi64U/VgJdrAYvlNVbpriWgR82FnOL+RjFL8dF9d/dt3zC6I4Tn3dgGpc0aASS
 NHNLTBdCp1cm8DhFX3AXhVOBSBrQJEuZK3PNPsOqxJfFhQWG
X-Google-Smtp-Source: AGHT+IF3djNJvGZTpPiyRPSQ3n+Iw1McHKxVR+TVT/M+1DBEC1uXLAeVeH9ii98JKlV4EGE5tGJCfA==
X-Received: by 2002:a17:902:db09:b0:224:7a4:b2a with SMTP id
 d9443c01a7336-225e0a1d3d0mr21404795ad.11.1741932941166; 
 Thu, 13 Mar 2025 23:15:41 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3015364ec6esm383282a91.49.2025.03.13.23.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 23:15:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 14 Mar 2025 15:14:56 +0900
Subject: [PATCH for-10.1 v9 7/9] virtio-net: Implement SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sriov-v9-7-57dae8ae3ab5@daynix.com>
References: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
In-Reply-To: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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
2.48.1


