Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76230CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RmM-0002px-3L; Tue, 30 Sep 2025 00:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rlq-0002i8-4J
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:15:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rlg-0001PW-TZ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:15:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e414f90ceso5574395e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205710; x=1759810510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+R20KfaeepivX48ztS5Qk+Utu4Wf2nP4nwxC8R0e4a4=;
 b=Ew2p8msneU6d/cNB2wXDwy/bIxjB3bqGO3/3ZHGQbjzrEW1ccXwCMLtyZgbWpJfsbJ
 D4XAqWcEnZWKmEPqM+7Xdo959TcPTtzUIHRFbyHKo98A3OaEBNrUJi6vJms7mV3IlEFa
 Y2FxW5Gfmmh5KE/t4/gE4Mk3mZbJN37Sv6LscHMT6a3rFNiDpaAcl1x30yPS1jeMj6TV
 yvNOISKh534PGNbsWMsVbiUfsz2q174wVmd8HKhAaOUVc0fQoOGpN6xDr9yjpyeWyut1
 3PIktyZFJtfAHYkuXyV3XxR21ez25UYY6TiGwlRJfjFtmw8GMuNzrZplxlCcgTk5qR06
 O9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205710; x=1759810510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+R20KfaeepivX48ztS5Qk+Utu4Wf2nP4nwxC8R0e4a4=;
 b=ReMgWbO856NWiCedMbiKmJEe0O2371QsZcicnRzXEbySCc8mGIULEgQcVnbuPLZwbJ
 idkNuLeQz1X7ReEvLJZdiuOt2F4Z9wbPOgLNRoSZXF/UZefEz5XwL8uz1+7oPVLn5SAW
 PIgx4EptiWJsybqrYARJJYxjeNzgrQXywkfIkYJM209M2dld7zw1d1UjEe48PFbP6NwC
 ZL3vOsEZxwXeT8A83W/T92qxmBKu/ecEW0Kpc7CoS1R0qlWjO11+4N45p+FoY2KH9dLw
 PKD4ISy/dkT2W2JPtypBV4uHWIuoElhL3Oz+nGwhchHvQI5CFEKtH7Q0ECWN7xuP8YBR
 pS4A==
X-Gm-Message-State: AOJu0Yz2FLieDOMZ1LS9nmEBnpKUZARxCIXdwgVz0Cmxnx0+jYfFl14T
 DFZd00HhJCQm4X5VYZp5sQ81KMN0FdzCZl7ps5YjWv/HB5oXUAQ7TN1O70TZpFxFa5i/ENnF/xe
 lYoU41kwA5Q==
X-Gm-Gg: ASbGncs5JgcXjmhxGTfVAoac10YaT0g3JUMUIjkgJX1xISS5F3kTpOCTBTSTKjoq3N5
 vssiZk3DOTDFxlrb9cGpy43uPTzCfaH+u30IQPJNzifN+SZLV5MsqGtflqpFjunuRj2MYWDX7E2
 ZIrpcE6UYp1+k+Kt+TYofZSL6hhzH3KhjaMigSwMgMpFeXVFQ/ebn3DdRVkfq7Z1nMXeVkclCRL
 IzOwzLJAujMwTY38FFbJSMOmasQlffgCsVaoFyFn/JTkm6sn2HG15Y/WW89v8LihqGRYuR39Eiu
 q2mWVbBD5fKOVpZcFvLoecjCNx2iVTQ6YlcK1CkxVE39kh7vuP1HuZxSvRbfuKJW2Zehm1inUD+
 091vS7vEHyzqCiKLzM885lPuvNzwhY3SIDwiJmG/rZFiMWcvQh5/2wVf8zjGI70PotJ+OPCJcGx
 S0DJe4kpbw3EslJOzck5BlhTWTViYBdKQ=
X-Google-Smtp-Source: AGHT+IEUJE1IYP/kfT6NPYb+xEkszrcjL4tSyyPjenIF9G8p6iMdA3UofkAUQEEOCpstatyYsaodDw==
X-Received: by 2002:a05:600c:5290:b0:46e:394b:4991 with SMTP id
 5b1f17b1804b1-46e394b4b1emr152224145e9.11.1759205710145; 
 Mon, 29 Sep 2025 21:15:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3dcacsm39499115e9.2.2025.09.29.21.15.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:15:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 17/17] hw/virtio/virtio: Replace legacy
 cpu_physical_memory_map() call
Date: Tue, 30 Sep 2025 06:13:25 +0200
Message-ID: <20250930041326.6448-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Propagate VirtIODevice::dma_as to virtqueue_undo_map_desc()
in order to replace the legacy cpu_physical_memory_unmap()
call by address_space_unmap().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


