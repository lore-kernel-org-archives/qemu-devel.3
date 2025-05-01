Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C03C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYpN-00049v-RG; Thu, 01 May 2025 14:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYoG-0003Cp-W1
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:39:01 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYoD-0008M8-Ow
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:59 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-86135af1045so129719639f.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124736; x=1746729536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWzzyY58ZMdH5v7Oa0GKNWiemzjm5i3yFvWM3N4y4TI=;
 b=mtfQU7fOY+O838h6rpvgaw4qbRdlu9EzvpVcMpP8F2Gu/0FeeaGUam1OAfCRM6alAS
 nSNcexiqkaEMzGD0mdPRY3313RQiAdoS4AOSzc0XKi7syNJxuX+2gwJhD0d25rHesi47
 zew5z9TH2XS2Tl5z8m1zXlKhiObfTVHitFpVgpjGaREwH1/yCOy53dWlfSQdR51skXk0
 Fkp6WEntI5UtLa9a+yFdQKfger3F6J9z+usHcaxfD1KOmwX7z9HbHAFseawKC2Oig7zl
 kX50TFkTigNHawYCQhlH5xmbbJhDra+1W8KZwmEQf/5mTQOt46JBDkmH+2oKUAUPAVGL
 9adQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124736; x=1746729536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWzzyY58ZMdH5v7Oa0GKNWiemzjm5i3yFvWM3N4y4TI=;
 b=tvam02YAZaB5DXfc3Xt9PSers3MbAHyBHt8qiZGajuNGPu6/uAQOF7mlU4Jtvzc8t9
 257ywNx/WFPP8gsBUBckbv8FbjKuHPE3ZbtT6fqgYoLRPMEhBWrwmxl5s3dNoDIvb78H
 TjZhqMUdVCcF2A9jeAKU+/PwRnU9BBmT9hR8HmDYNZmo1wklQRQp0/Opr7aHOzTeGfji
 R7UxgMKGK8mb15kfKsCA81ejJMMpHqY/lnLRQbwsyjdxR2ixb9yX0j7a2AIb/qkMA17A
 cmilaNLWSuxNiAXeO3dTHn98Nt6K00wjcBu5YLvi61MPcBxQzhyxo7B6TNkGIFFdcj+E
 hbQw==
X-Gm-Message-State: AOJu0Yx+YJaNy6i9/KltdHI/x5YGbYa2VnsiQb27uVptwOCIxuywRi73
 cHCJo3KS0iEsudstlMnx27ldjEheOcScN2YmV+6Wxkeu5B8CnaSwPLQR76/6DyNPoW6xc+QWVN8
 8
X-Gm-Gg: ASbGncuQbPY85pynnFFYMKUaMRCeZADoFy8XS67FLa1IYadV9CjwUwsbZ/CFpXXreAK
 eyE9rVl6/8eITS7Kf4qQWEUWDonTM9O6nyBvwC634ADZQO7lxtIG7z0LiGUqEpbNaNGfZjsIIEc
 9HbZKyxcnQqVoaR/FTcsZ0uPDD4nPL39VuXwKtlmSYtYMEregImYaNzO/XsfxfsbDbisMtmkNxQ
 3bc4+TTQwwQ2iMCHvnPcWJX1qScm/VIjK6fhn3wBklTHN3VyyVY+epB2Lx5TVZ9rEWkR13xJLB7
 EeX+72fWkoXh2OuHKqHUw1wi9jKW5PYhNZKBqbrZ/SNwd0JcCjl8Qu14WOhngiadJNWSu35RUwr
 jbYMK0rlLxDGkm1joPbEjLWTI0H+HkLY=
X-Google-Smtp-Source: AGHT+IGhK4Phq+GRyl0Xi6cfy6zpDqAKYLtfCo23SFtZDR3R+jJu/ejPiPQcE4oromZBFc18FJ/g7A==
X-Received: by 2002:a05:6602:398b:b0:864:4a82:15ec with SMTP id
 ca18e2360f4ac-8669fad4facmr46468239f.6.1746124735919; 
 Thu, 01 May 2025 11:38:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882ee0bd8sm303406173.39.2025.05.01.11.38.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:38:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 16/16] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_PAGE_PER_VQ definition
Date: Thu,  1 May 2025 20:36:28 +0200
Message-ID: <20250501183628.87479-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

VIRTIO_PCI_FLAG_PAGE_PER_VQ was only used by the hw_compat_2_7[]
array, via the 'page-per-vq=on' property. We removed all
machines using that array, lets remove all the code around
VIRTIO_PCI_FLAG_PAGE_PER_VQ (see commit 9a4c0e220d8 for similar
VIRTIO_PCI_FLAG_* enum removal).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-pci.h |  1 -
 hw/display/virtio-vga.c        | 10 ----------
 hw/virtio/virtio-pci.c         |  7 +------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 9838e8650a6..8abc5f8f20d 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -33,7 +33,6 @@ enum {
     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
-    VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
     VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 40e60f70fcd..83d01f089b5 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -141,16 +141,6 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
                                VIRTIO_GPU_SHM_ID_HOST_VISIBLE);
     }
 
-    if (!(vpci_dev->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)) {
-        /*
-         * with page-per-vq=off there is no padding space we can use
-         * for the stdvga registers.  Make the common and isr regions
-         * smaller then.
-         */
-        vpci_dev->common.size /= 2;
-        vpci_dev->isr.size /= 2;
-    }
-
     offset = memory_region_size(&vpci_dev->modern_bar);
     offset -= vpci_dev->notify.size;
     vpci_dev->notify.offset = offset;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7c965771907..4e0d4bda6ed 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -314,12 +314,9 @@ static bool virtio_pci_ioeventfd_enabled(DeviceState *d)
     return (proxy->flags & VIRTIO_PCI_FLAG_USE_IOEVENTFD) != 0;
 }
 
-#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
-
 static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy)
 {
-    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
-        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
+    return 4;
 }
 
 static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
@@ -2348,8 +2345,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
     DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
-    DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
     DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
-- 
2.47.1


