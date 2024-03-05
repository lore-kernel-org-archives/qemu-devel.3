Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2351DC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQeA-0004IT-6J; Tue, 05 Mar 2024 03:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhQe1-000434-T9
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:59:30 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhQe0-0003ic-E1
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:59:29 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc75972f25so44871415ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709629167; x=1710233967;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=agEvzBa4RHbrJsI2JBzinS8CmNut8NaPKnAYNO+Q2DM=;
 b=UAbW0h6FOVu17lww1MdOmJQzERVEg8J1bySy3cF+day+0KDDN1Ojr4IwOdQuH0niXR
 s/G5xrJYVPI7eljUvPUaaMgYMnvzt2yZur/mqP0SW8sgfpgJlgTsiMafT/1EuMA6Fahl
 rfOkV0XunLlKJObQvw/6OP7RMDrxAGw+dopnsRkxDaFw4PkedM/wTdK9m2urh4Cjy9CC
 mctUNrMrKwS0FzsPAwLXf0oQaYX7fVSI8N2YUlmMrysFKb+dTz4EI0JlZJh4y6Sawqob
 02kuOKml0FDhdZvaZSlW+DDJsdaqAJx14ZEeMqgCDXKnT0VsaB4ztEyAJ+4DurZwJDLv
 N2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709629167; x=1710233967;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agEvzBa4RHbrJsI2JBzinS8CmNut8NaPKnAYNO+Q2DM=;
 b=I5jM5xnhED1nPdHwOPACTGXMPyMRisxVSpB3ei7ReDCTGMEEasIvu96lb16i8Mq3Bp
 H0GPRJpNl/kA+SJ9Kt24K32gGdDyj68hKw/IxnoLuNqZuUUWgsgDQ7YFTLdCJkRSDDNB
 628atUF65z6PCBTZwTaQL05AA5WgBY0DHqS/EV8aQnfj8ZAI/7QE7n5vfYboFYI2ahD3
 1Qmfe8XrQVo4yu+IDveDJ2wL9NsZx+bKwo+i25s1X0cpCuvfdWbtuD1y223IHuaIlpQE
 6F0AUmqYmQpnxd2n61cL1M0/pVP+aqh4bSGcMKVS2bUAl30OxrFOD5mHkBaXxHqfF3RQ
 dZlg==
X-Gm-Message-State: AOJu0YyVv/sHsejNBUI/ZM9MWJlJqFc/RNdxte8T1I+QJHrw46S3lVE4
 N07bxgIQD9F6zoatAYwpt9WYXM8aNS4Y5A17CJOS9yZ/ZGxmG6SYwQIzuo8cbug=
X-Google-Smtp-Source: AGHT+IGxiMWtBmC2IwLho96So1A+U3w93tecQCB5aKQ9TL6sI1iiHX2jwOWCgSQsn4EdbdV1bTG3Zg==
X-Received: by 2002:a17:902:a987:b0:1db:fc02:f96e with SMTP id
 bh7-20020a170902a98700b001dbfc02f96emr961011plb.24.1709629167148; 
 Tue, 05 Mar 2024 00:59:27 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 l12-20020a170903120c00b001db66f3748fsm9934013plh.182.2024.03.05.00.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 00:59:26 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 17:58:53 +0900
Subject: [PATCH RFC v3 6/6] virtio-net: Implement SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-sriov-v3-6-abdb75770372@daynix.com>
References: <20240305-sriov-v3-0-abdb75770372@daynix.com>
In-Reply-To: <20240305-sriov-v3-0-abdb75770372@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 20240228-reuse-v8-0-282660281e60@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


