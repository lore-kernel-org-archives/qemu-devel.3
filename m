Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFCAC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8P8-0001Xx-7D; Wed, 30 Apr 2025 10:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8Ot-0001KT-B7
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:27:05 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8Op-00078I-6n
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:27:03 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6e8f6970326so82985526d6.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746023216; x=1746628016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWzzyY58ZMdH5v7Oa0GKNWiemzjm5i3yFvWM3N4y4TI=;
 b=FP2IhDW9K0SvWemtP8zwGPxWN0JiotsRyFuGOxa/Xq4Brhp2rCd0NGybgoCnlH55qu
 mxDHKjlnUlOIF6R77E+DBrvETXAoutCP3Fa7vzaLR48TfiZXKvgim9/ilaylgH/eQw/x
 JB7gj0qIMmsyXeQd0mYNUBZD20hQKcTLLe7bLqMZRXLbz/GjHBykl+dF4GpNgX5uanCf
 dlotbDwN4/3ZipO/A6lq1HXSK/d+xQF6vgFcm0LGwyQEDAvQUUUUM2PwQPIOhJXgaunv
 1wOKKCLU28Dyn4EwSthqyeBCAfoD/WIdpaP52jbwT11aNXaFpf62He+q09fEHyr5rRVQ
 jvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023216; x=1746628016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWzzyY58ZMdH5v7Oa0GKNWiemzjm5i3yFvWM3N4y4TI=;
 b=wg7q+nMgt/HvgMMWWkVdUUoHJnZtlyF/tiDK3+jVajXg3ZfRP1wgsyr2ksdJDoznpe
 +MSllc2A5A8zR3erPfWg9TS5YBNKgdsg8VXclnA3wLa9EoXg9Aj5wunB1HN52pP7FPcp
 dR1ufXZpEnzQfuFynJzyyW654ymHbuGb3U4DdEICDqRKH2cbRK7BdywxAd+VcCV9Y50+
 lvIbDzUGr31M/9HI+GM6JDkjYbssRU5bTMyULzZi4I1ycSGfGaMjIMGDxCv8QD6NxB+y
 dIuvhRGmAc+Gyd2JhZSD4qaqhvcx3lgiMoF7YGjzXZqy86TZytbrzvDsx9tIXbVA2w/3
 hxkQ==
X-Gm-Message-State: AOJu0YwzQdwkGEXsehtqnYKSbwfTTmWT97Gv+D/II6Eukpo9FZf9RB1H
 IYFK9+EKuSH1SmBDiiRp+fKmUPdNUmNTfsDTNeIf7TNwxHIBR8JydTSDa3rWpGX/U3HZj9YMng/
 V
X-Gm-Gg: ASbGncsNTEPOgvN8d0c/A7NWaVOJ34Fwp/s2QAKa+u/NJjvchtuuwMiNAqgp2qqVoL3
 NqeQXlp5UunGtucrMNRNuoP8rc9VNmEED9WoHHAQtGZ4RbnNM/rBPFf4HB0OkMEf+ZGgiTlsH8C
 AuZ/HgFUS4PK1XsOmxsVk3irSIZy9phjyrZnaN0NIQ/Lsdell0LzQvp8IbNQIgBHkPzMALtf55j
 My/RyV1d2pf9XsPZu8mErQPYBgPkAAipJP5wm9r00qKbQ/fidYrG5VJ/0ngYfShKQP9QXzrgECV
 kCZnAu+NRsN7cjlKFL9RFA71CLjZQowRA4bbItfg0fM1RwssmhsizMLARw+a0gcK3J+Puj72RZg
 0oWvDMqt2o5JQgPc=
X-Google-Smtp-Source: AGHT+IH4vUYd5XRQ5+HCEjLa0M60O6KHzOjle44KqFdJYxiyUC2Mr7TqD8TAI07EtZWMaynkQurWlQ==
X-Received: by 2002:a05:6214:2405:b0:6e8:fa33:2969 with SMTP id
 6a1803df08f44-6f4fce7b58cmr70829346d6.10.1746023216254; 
 Wed, 30 Apr 2025 07:26:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f4fe6d1933sm8798406d6.40.2025.04.30.07.26.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Apr 2025 07:26:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_PAGE_PER_VQ
 definition
Date: Wed, 30 Apr 2025 16:26:09 +0200
Message-ID: <20250430142609.84134-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430142609.84134-1-philmd@linaro.org>
References: <20250430142609.84134-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=philmd@linaro.org; helo=mail-qv1-xf35.google.com
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


