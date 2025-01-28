Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F550C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqm2-0006p3-Dk; Tue, 28 Jan 2025 13:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tcqlw-0006oM-BM
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:57:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tcqlu-0000k3-OO
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738090633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l5FbHGBl+0zBGytJJJxn/pmQWmcnl8/OQLZN/pvKkjg=;
 b=VimwZ+rNsoQNcMCQ9sT0ImeE1rKuK4cvboApiy3iUZtZgdnZrXKBARwZqqKDoQbQrkHTeV
 mi5EiJFHokgRbpfEgqEyN1i52zx6BSvjWHX1JBTVNRN6gWqneqktajwwsXRqFT3jFLUr9y
 m2ScD/dx3Ue2wUlgHbwndtsTwZQHMYU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-6b4iiOXJM0G2aKhWWKNTPA-1; Tue, 28 Jan 2025 13:57:12 -0500
X-MC-Unique: 6b4iiOXJM0G2aKhWWKNTPA-1
X-Mimecast-MFC-AGG-ID: 6b4iiOXJM0G2aKhWWKNTPA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38a684a0971so2726824f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738090631; x=1738695431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5FbHGBl+0zBGytJJJxn/pmQWmcnl8/OQLZN/pvKkjg=;
 b=Zi8UdLEpUFMhIO6vjvCn06LRc/mXyEd5W7jWXJ87xTOL2zaaFU6EM20VF+O48H/T1z
 ud627RPSwMajfGx7w7QgpZfKkppAmgvrlCZyVg+To9QFyifoChzDlehGAQcUYqVkaNix
 UMrfKP/W59C2nixOrFMwF7ewsfsszAoS7ky3XppW80zlJkQkgo7lKq1y06SB06YNo9O7
 4Ls5a5n49GsXcYiXqUcgR1CqCYy49j1KUwf54CxZ71vgEGpsHv/cSOLcbIxGnAqddZlp
 wYA/eIrHozk5yCj/biGs7dTGv1k8CjmI1fGWOMUb0IepLx8jR+PxnBCPJjcHUvNcqSlO
 WMvA==
X-Gm-Message-State: AOJu0YzEy1uZLdPk0Bq2kORl0qNTzu/+xi9RXSh5uYTJmCz2j8gmdXsc
 ASf6UTmXFB/To4/ZHUbtKO5grFYR1ahqRetwQyiQyWTVWbPP0S4nBHDYiWeKiB3gvbeY/o7YdA9
 5kOdS8m70+bxpdEgmTcMr/8H0etR5gL8iqiwljCZoq2UCZ9UXgeF0hMS4MOD1VjhjDGHWDsXJQK
 bzcm2oUjVfC+poq29DBQYBkowuHRCmwcWhYg4=
X-Gm-Gg: ASbGnctGu6Noa62XLcpIK4gPNEqakRPmjbRn3bvWaBzDCwahdOO2hsRQ2YRglbcEETd
 prJoZNXt5Xg9wVdXqqlvDDVn1fJOjayjaO8awWoMv89vim/zcjAGYPAqBFUgv+4NjxstYcEylsR
 sDa088XF8mRyi+vZpqFQCS9Ut0by6FOiz1ZdsrKzPUzxkNY/1hdwyzyvXAg3fpd9zQiQeE4aZI2
 PmH4wbmoxFBAMwWTpPEX2Rq7TF8NJ5gFhJ/CDe6C/EWgrOv8EUV0KCrd4UMj8fdeXVTozeuoM1R
 I20Ij1U4wO1SREi2wRL0NqwIn68vMT4OxofoW+rMZOm+jpB903Vy9TSEVzHY5DMaQg==
X-Received: by 2002:a5d:6d86:0:b0:38b:ef22:d8c3 with SMTP id
 ffacd0b85a97d-38c5209395cmr155562f8f.35.1738090631561; 
 Tue, 28 Jan 2025 10:57:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlbqXLRBeD5JrbGGp92zVuF3Tt4hGcMgt8SRuYnkIv6AGBUBh9tA5Gc+3vli+RhQ2n+7BFIg==
X-Received: by 2002:a5d:6d86:0:b0:38b:ef22:d8c3 with SMTP id
 ffacd0b85a97d-38c5209395cmr155525f8f.35.1738090631116; 
 Tue, 28 Jan 2025 10:57:11 -0800 (PST)
Received: from localhost
 (p200300cbc73fce001be76d7f3cc3563d.dip0.t-ipconnect.de.
 [2003:cb:c73f:ce00:1be7:6d7f:3cc3:563d])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38c2a17d74esm15252942f8f.37.2025.01.28.10.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:57:10 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v2 1/2] virtio-mem-pci: Allow setting nvectors,
 so we can use MSI-X
Date: Tue, 28 Jan 2025 19:57:04 +0100
Message-ID: <20250128185705.1609038-2-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250128185705.1609038-1-david@redhat.com>
References: <20250128185705.1609038-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let's do it similar as virtio-balloon-pci. With this change, we can
use virtio-mem-pci on s390x, although plugging will still fail until
properly wired up in the machine.

No need to worry about transitional/non_transitional devices, because they
don't exist for virtio-mem.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/machine.c          |  1 +
 hw/virtio/virtio-mem-pci.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8f396ef803..7b74cde10a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@ GlobalProperty hw_compat_9_2[] = {
     { "virtio-balloon-pci", "vectors", "0" },
     { "virtio-balloon-pci-transitional", "vectors", "0" },
     { "virtio-balloon-pci-non-transitional", "vectors", "0" },
+    { "virtio-mem-pci", "vectors", "0" },
 };
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index 1b4e9a3284..6cc5f0fd3b 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -22,6 +22,10 @@ static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOMEMPCI *mem_pci = VIRTIO_MEM_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&mem_pci->vdev);
 
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = 2;
+    }
+
     virtio_pci_force_virtio_1(vpci_dev);
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
@@ -152,6 +156,13 @@ static void virtio_mem_pci_set_requested_size(Object *obj, Visitor *v,
     object_property_set(OBJECT(&pci_mem->vdev), name, v, errp);
 }
 
+static const Property virtio_mem_pci_class_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+};
+
 static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -164,6 +175,7 @@ static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
     pcidev_k->class_id = PCI_CLASS_OTHERS;
+    device_class_set_props(dc, virtio_mem_pci_class_properties);
 
     mdc->get_addr = virtio_mem_pci_get_addr;
     mdc->set_addr = virtio_mem_pci_set_addr;
-- 
2.48.1


