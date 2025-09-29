Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094E9CCA46F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IjC-00075g-RN; Mon, 29 Sep 2025 14:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Ihh-0005bT-24
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IhV-0003f3-1U
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:28 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so4557839f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170854; x=1759775654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBpejQiq0e/vydo49FSQoIaJ0P/BjZpeA7dR40L/9NI=;
 b=CAXr6CbcphUg7lDfgBQkmuyuyfFVHTCrhcMf+gjakSdRUr7Bh9sfBuDrgvq30BComw
 nnqp9/W5kK05AdpGB9Gdl2SroSxOPYkoVOcIf1Za7OvHWNO2nAXM69ujsOIdp+Ndc5Dm
 1iIrK1j86MhkNkbur4qV7gkT6cRzBrGrBGkSA/GomsMK462T/cBYVmUgz76Up1Du4W2q
 IEZ03AdQYUOUpyoDKcY5OXDSecFwYpw/AAZwGxEfRfIS0I79dEptFdgr1OcNagLB5xI6
 4fi60uB3uAtbL9q4d9CJ5CcpwU9IgJaJtNEwR+UWM7Y5s25Korj0Ca0ku04Pm3SOwyhH
 5SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170854; x=1759775654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBpejQiq0e/vydo49FSQoIaJ0P/BjZpeA7dR40L/9NI=;
 b=CcnSStS2rd3an8SSXEEVnJjh/1qDr6aitKl0FaiwLqX33oqvNvgpTLHHa3fsIhqO22
 RJeq89/3xVZUr2nFR450QCO9wrcCsQPRlDcp3g5EEkzDiizJAHgttV01worTktMS0Uhv
 v6aht/HYYfIFfnfi4Qxyc+xChPCjcTUB498R7vMCjQ3PvS6XTyylD2l3ymzOumsGSq+3
 8/XeLkGAwaaT0ievV6JAtBMgIUtzItQhvA+bGXilLdcix7/iGJFQJls2AbZuc2Q4tD3Y
 9LgWagVOO2lPAuP1kPVkh3y0Jyw273WIJs265k4ACzf7JLIxUU2t6IJJK3EsaHh1CqrU
 dnvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDUh+nACgXfVDgdVv1qQ0qMMylu5U1BDx3BIbQcxGwg6i/OkqZMlopqUGJdsTySxa8BmncsyvbF3D7@nongnu.org
X-Gm-Message-State: AOJu0YxqtufOciND8w3+ShXz8oJ55Ag5inhoAqkPc8aDH18BcHF/OrC7
 1iNd9zNKVuvsVqq5f2BUBDEdOFS4WFEw6G9ce2OqkGqMyARk7UMjWaNhg5D+dUToxfc=
X-Gm-Gg: ASbGncsc5peQHjmilLk0fMpm7kO+ikTv0wv9UWlDpPljeeNi9wdhfE+lIf3SNC/XYgC
 meP12zOPU2AI4+72DK5VdnoQvchuSQdem1BPbI2H/XtR6W1L3YXliB+Dw18DrIkFLPl5jJhoxOa
 PRuFQ49UdrrhFNz1elLEP2Yst7zCJqtF9vG5XjeB14H3ELrsEoZr4+/H9twWrQadnpgu7vZAJJp
 WNBF1cvJl2uL5/MvAjJCGUE6pxix/Zj9qEjUFkh0HJT8QbVmTmr+KBL1SMee7ksEn2/xbTCz4YC
 AcZGy4I3xedofFFzuY/UGuIqfYEembvmO4Wyiin8y8k5XI/ZD6vvX9Sw3pJGDTTwbnuH48IolMr
 0APBPbBfLIdSPJlKlxC5b5ql8XcpuuA9SOLZadfRQ44Eo7rM5FVS5z+0FvTzaUo8pLIOaXCZQQp
 WjMkl/S6A=
X-Google-Smtp-Source: AGHT+IGDdDVnNCTQHNmf7VOOiV8zymTG0ZaCom+HQXr9Sc1CkJ/8s/f399s7GfQrqulF9pKPADkmMg==
X-Received: by 2002:a05:6000:22c5:b0:3ec:d78d:8fde with SMTP id
 ffacd0b85a97d-40e4ce4bademr17302303f8f.44.1759170853668; 
 Mon, 29 Sep 2025 11:34:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a7c8531sm237281965e9.0.2025.09.29.11.34.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:34:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 14/15] hw/virtio/vhost: Replace legacy
 cpu_physical_memory_*map() calls
Date: Mon, 29 Sep 2025 20:32:53 +0200
Message-ID: <20250929183254.85478-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/virtio/vhost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6557c58d12a..890d2bac585 100644
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
+        return address_space_map(vdev->dma_as, addr, plen, is_write,
+                                 MEMTXATTRS_UNSPECIFIED);
     } else {
         return (void *)(uintptr_t)addr;
     }
@@ -466,7 +468,7 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
                                hwaddr access_len)
 {
     if (!vhost_dev_has_iommu(dev)) {
-        cpu_physical_memory_unmap(buffer, len, is_write, access_len);
+        address_space_unmap(vdev->dma_as, buffer, len, is_write, access_len);
     }
 }
 
-- 
2.51.0


