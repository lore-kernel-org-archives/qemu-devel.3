Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E608C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 09:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s10UZ-0007jP-44; Sun, 28 Apr 2024 05:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10UW-0007i2-Sy
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:36 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10UU-0003xt-7V
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ed01c63657so3438395b3a.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714295192; x=1714899992;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=agEvzBa4RHbrJsI2JBzinS8CmNut8NaPKnAYNO+Q2DM=;
 b=jpgz4nN65R37bbTD8IrdFiuetISPfEEWCdveRoUV+FkDqDgcykw6ZRql68NdGTrOWn
 DpCPGpEGSSVMry+51g86Jaa9dPyj585l0bNl+2U6x5S5bVn3Q1AlXBc2Anapco2VT+ZD
 YaJCFtEmQduQf3lYT1ESAYMJwhTkvQJn9soGCc6Oe9VulZAKJRK44eRPF11CV+6FeAMd
 OVmtQqUew16kaRN8ExYMhfCi2GyqroocRJg7rbxqV8jLULP5NrzXqfysSlGvR6B/ZZ4k
 FS5ze7MLKLmlo3TL6LaFvcArrvnOYyYhcYF6FlWzsL2eG0XDJwrytdRv3PGAsvaYK7hD
 Wg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714295192; x=1714899992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agEvzBa4RHbrJsI2JBzinS8CmNut8NaPKnAYNO+Q2DM=;
 b=LB0UaVVnz/uTi/VPB8vC6kClHrlEMnKz4gzEPOsVx7djudn3TfWbwPurh19HGHWd6j
 lSRx+/eEcADJj0IJEcKJb173bDVmCkA13f1wlmxiC8zouXeCRpQBLA3UrawdKbitK31K
 2n05tANE1mxqqoQ2pjPPz2VpPEjZv+qIeyaFT6MpKYhyoHd6rNEnUY7fOL6XYRMLEDHe
 v+rA2TSy60wUhjz7iXPyVr8Nu2/X7hxMjPmmMy7tHzLyoUkF1CFTX4/CGIl4QmV+rdJq
 BVl+V/3vEIdXgIGNwiV9dCFsqrhkITY8I3BjcCtlJiAVSaiUOZJRgTxTUgwGVm2mMB83
 tX8A==
X-Gm-Message-State: AOJu0Yz5+SS9g5TAAomOxDxVO3OnqwiefOnHnVU2oyz6rkVnCKqpiD17
 mrSWp7ArPaj1kTr0TIaQlwEI+8gMyGK9BDXgyBX4sDS/9zKHBO+qchfXQb6au9c=
X-Google-Smtp-Source: AGHT+IGbTbWS711n0c6sAoeBV+trTnvp8SbIWmZ63HmTOa4PtBTSzTi8mYezMIVy2+mVJArKa8YrqA==
X-Received: by 2002:a05:6a00:39a1:b0:6ec:db05:36cd with SMTP id
 fi33-20020a056a0039a100b006ecdb0536cdmr5316627pfb.9.1714295192494; 
 Sun, 28 Apr 2024 02:06:32 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 v28-20020a63481c000000b005f7536fbebfsm16765604pga.11.2024.04.28.02.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 02:06:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 18:05:47 +0900
Subject: [PATCH RFC v4 7/7] virtio-net: Implement SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-sriov-v4-7-ac8ac6212982@daynix.com>
References: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
In-Reply-To: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
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
X-Mailer: b4 0.14-dev-a718f
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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
2.44.0


