Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266AFCAC5BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeV-00012T-3T; Tue, 30 Sep 2025 04:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VeE-0000dO-79
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vdb-0001HH-FZ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:45 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so4389342f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220582; x=1759825382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72P8ycFgSBQVWBZ3tJbVWDsHTvBRP8LSmdHVD/So9uo=;
 b=R9aJmwBqOFKXcwWsoGoUSSVuaWrfVLFE13Agq1sbz6ixH2Shsod9X3+6J5JntKqw8s
 LCZSxK/x1Xz6PnvU0M8NVCBM9Q3bP1FUGsdEZzPr45pcCixMLZxAd15Q8IT1+apJazpF
 R7oUmnyUNZHVLoWEJ8LF6dKZ8nxB7lbM4y9aMrNsk80LP+CJ4KzhYy9Zq4vvmkn9LP7/
 JlcjEo6ZwvGfAlDjD2C3UM0fMLs0ctYNL7KvCXHtILHStsptyktq82zHpXfN97eggKu1
 QHMkyOlwXmB25CITWSqVaKif/kIQx3L6humoctuG9o3sY6DfkgLc5OchHWqz9MIKyGV9
 kFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220582; x=1759825382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72P8ycFgSBQVWBZ3tJbVWDsHTvBRP8LSmdHVD/So9uo=;
 b=HSz+Wt7IR2/+2jYzEcQ8lIlEyFyK8LXdIIIZbUUjPgifqrNCaBMr/AEbtsBtX3Vt0k
 RzRZkbyhaH5J7bsTV5yGt8VcFMCPLmrmS6Dvnt7+gMftEeZhtkI+UqZd1kZ94FjS1HzR
 Xm58rgDqYvPgdhO+SfrASEn++oxhj72m8FMjmeBh7uM8E5BtOFXLSQeguF1sT5s62pnx
 l0Rmmx5d/vcEWfk+MkGJVelqrw+NazV6nOclcQkWzBt/zjTRJqiGw0yCnwyMN2Ea/8kf
 TGz4WN89YGdVWPul0GerWtx0LMjVNc+tMV5gSqrwajBIUdugM+c0OflLZw6k48YhUH8o
 5sFA==
X-Gm-Message-State: AOJu0Yw1DSjHwVg8z8csI/z4JaX+L3jTAdAbN5anvVBCZaqoMj3vrmRk
 Rlvc9DrH7w3PNUktzhjNPJqDj5N4ZOI3/BOoTJVv5E5XAaeAix/KwI4UArfMIKHE0u69TG9lRDC
 sEPV76pMyBg==
X-Gm-Gg: ASbGncvhcOOKvrHpRVmvsfhoQTOI/AaovGlDl7bSHPdg5rWwY4fMwXacML+UCz0zZEa
 htBmhRV5oKkDJMCRW9FMnBp2dAlHAXhAZAgB1Ly3MJSq2Y0zGY9SrvE09kcDBW5U2LWciYzPEXK
 6NADPfxCJLl6UEo0O9QYdceHiKpzmt+DXLQeAiTAALtNnvB/It43iLaMn5NevA/3PaQ9q26y4qf
 7hTid/tezZrOpV8O0hbVMpc9YeLLvUwQle+Vcv4LH7ggLFu/1vHruoD3WibuNpzxkvsLzUdfb6f
 dloDQtTX+JYK5ILe2XIImwReWFbRB5QD7Kz0OMrWKb4RgiKoZP8Q8iunspn8Lcz7ZymhGSpiCtc
 Qh1jaLyibIG7trps/+gCB6UsexkUgGPmE57fpfeZt8nhpT/WbIaS1LbG9QcFkuGY3ivpr67aRRC
 XqK/V3z+oL1rjCx5ukxwr0
X-Google-Smtp-Source: AGHT+IG0fDZU6KltrERn3higtjD7tJ2dh/0k92N8Tps8ggqNo2HbrRNaueeSukMTmfKt9k8lWLLnpA==
X-Received: by 2002:a05:6000:3101:b0:3e7:492f:72b4 with SMTP id
 ffacd0b85a97d-40e4be0c940mr16811180f8f.42.1759220581872; 
 Tue, 30 Sep 2025 01:23:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb21esm21742490f8f.7.2025.09.30.01.23.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:23:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 17/18] hw/virtio/vhost: Replace legacy
 cpu_physical_memory_*map() calls
Date: Tue, 30 Sep 2025 10:21:24 +0200
Message-ID: <20250930082126.28618-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Use VirtIODevice::dma_as address space to convert the legacy
cpu_physical_memory_[un]map() calls to address_space_[un]map().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6557c58d12a..efa24aee609 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
 #include "system/dma.h"
+#include "system/memory.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -455,7 +456,8 @@ static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
                               hwaddr *plen, bool is_write)
 {
     if (!vhost_dev_has_iommu(dev)) {
-        return cpu_physical_memory_map(addr, plen, is_write);
+        return address_space_map(dev->vdev->dma_as, addr, plen, is_write,
+                                 MEMTXATTRS_UNSPECIFIED);
     } else {
         return (void *)(uintptr_t)addr;
     }
@@ -466,7 +468,8 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
                                hwaddr access_len)
 {
     if (!vhost_dev_has_iommu(dev)) {
-        cpu_physical_memory_unmap(buffer, len, is_write, access_len);
+        address_space_unmap(dev->vdev->dma_as, buffer, len, is_write,
+                            access_len);
     }
 }
 
-- 
2.51.0


