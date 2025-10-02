Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0941DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Eux-0007bo-VK; Thu, 02 Oct 2025 04:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Euu-0007Y3-Bl
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:44:00 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EuV-000118-1g
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so7882015e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394607; x=1759999407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sizE8fixTdjMLNdHvH96mSdoNGp/FmemDWUp22VSw54=;
 b=ifBF6U6Kiyij5JahSDNl8WJ0LBHyt4Mte2s/HFGz4e5uvCLEROzrKAFmH98BaX6F6x
 1OrcMJjPI9zc/GCCCdC5bJoEiPpR8tpkgIlSwbtCTD+8/RID77ICGiBhU+gWnwPnOXOU
 8v7EnMyRMIENwmDEdFUeS1TO+HCw7m4sY0NoFn9XWOAQvd43Fp32E060wKRB0kIgTW/I
 0xnv+z8yASxJfH6/4CqMWvPFMaobt6I0mVcymev9KXWN/dw1yztsMuzylzaVwYoXh3lg
 gyFmV5HJMDpOQRH71jVh1xXU62gAZPx7QMKRsH7G0+xj0A3CaTafmR+hnKSjL1a4ySYo
 80iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394607; x=1759999407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sizE8fixTdjMLNdHvH96mSdoNGp/FmemDWUp22VSw54=;
 b=m/N+7245EzqiA3a4vxLjzYYG2lKJ01FrNTz96zT9suJUi1sQkNayo9Vs9IiKsB+MXX
 tLz6ctQE7J3+vYyCYidhYcb0Ix+j2xjZzi/6y03gu38rQ5q2yvOzQJKZCrXfzJr6bH8Q
 TKu7LyxtQyEA6N6Twhr19vMESc0yDYpcLzPtjP86oHZrsFViru5akDBpSyUbwARnTY8B
 eVM+9mIDct5DMbyK6IBwJGVp43RexKjhOCIb9NfQ4rJVx1TTdBusWqZX3hnV1UhaqHN+
 CeILC8ySZMPzRJIc17UbJEoYzvLsXfniG2bG3JhnjoH3oxdK7nOOAtX5NZT4RkQCZ6Ki
 nAOQ==
X-Gm-Message-State: AOJu0YwClKoB9hY/mwNb94GHzGvCKYJchWlxk94e3ce1x856QO+DJkm8
 RHMlg7/NSNtgY3LmoB/QF/kOvFOufp9vxWrRD7hom2zM4wQ9yuMNXnS+s1jpgL8OWb3HweGzPWW
 UYQR/ji+lzw==
X-Gm-Gg: ASbGncvtz/bnsaoXz5HOLAw5XFY6oN+esqrRNl0CJBPY8RVkjCy6qbP3a21w6gFbrv+
 f5zpOpSyh0DRUy1ZWtKOH88OVDOc1/CyNeOsN+yvCdZH2z37hKFZ6Vi68G7zoX4Wk4JMazf1nRx
 6PMPY1U8BNs3tN/1pdLyPFTzmjotiHbpV+GKomHYc+Kocu4uroAw5Try7xzWlljGc+aRJ1f3n0H
 sqgDszojBTa4ZrerEVtpTVZ4QPBjDhbtQBzJizukzhPokLjRqRrgDjj2+x0yocqIKJ2nufI7Fhq
 BlBmLO7AOr/3fkCYpt0KlKB/s/1ltfypH5aClEhRZs89mIGRFXISwtjzInfE30ZrvNSGpUV+why
 bSxdLMvqT282fIgt4YpT+dkKprcIBxWrvuZvke3rl2yvsq9jEym8VD1PlGeztNBmA7AdtoVQQY5
 3Yh8QzVhdCPym8AsIkU6GPO/1f4pxBXg==
X-Google-Smtp-Source: AGHT+IF9YgQxjGmfBS/VLSZ9Yn1NV8aiLQRYv9H/Rha4by/slLu+GOg0yeUsYkmlZm+Qs2ADprJnow==
X-Received: by 2002:a05:600c:5289:b0:46e:6d5f:f59 with SMTP id
 5b1f17b1804b1-46e6d5f1183mr8939815e9.4.1759394606884; 
 Thu, 02 Oct 2025 01:43:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e693bd655sm26669815e9.14.2025.10.02.01.43.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:43:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 17/17] hw/virtio/virtio: Replace legacy
 cpu_physical_memory_map() call
Date: Thu,  2 Oct 2025 10:42:02 +0200
Message-ID: <20251002084203.63899-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Propagate VirtIODevice::dma_as to virtqueue_undo_map_desc()
in order to replace the legacy cpu_physical_memory_unmap()
call by address_space_unmap().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/virtio/virtio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e0..1ed3aa6abab 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "system/dma.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "virtio-qmp.h"
 
@@ -1622,7 +1623,8 @@ out:
  * virtqueue_unmap_sg() can't be used).  Assumes buffers weren't written to
  * yet.
  */
-static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
+static void virtqueue_undo_map_desc(AddressSpace *as,
+                                    unsigned int out_num, unsigned int in_num,
                                     struct iovec *iov)
 {
     unsigned int i;
@@ -1630,7 +1632,7 @@ static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
     for (i = 0; i < out_num + in_num; i++) {
         int is_write = i >= out_num;
 
-        cpu_physical_memory_unmap(iov->iov_base, iov->iov_len, is_write, 0);
+        address_space_unmap(as, iov->iov_base, iov->iov_len, is_write, 0);
         iov++;
     }
 }
@@ -1832,7 +1834,7 @@ done:
     return elem;
 
 err_undo_map:
-    virtqueue_undo_map_desc(out_num, in_num, iov);
+    virtqueue_undo_map_desc(vdev->dma_as, out_num, in_num, iov);
     goto done;
 }
 
@@ -1982,7 +1984,7 @@ done:
     return elem;
 
 err_undo_map:
-    virtqueue_undo_map_desc(out_num, in_num, iov);
+    virtqueue_undo_map_desc(vdev->dma_as, out_num, in_num, iov);
     goto done;
 }
 
-- 
2.51.0


