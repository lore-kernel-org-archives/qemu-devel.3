Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37026CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RmW-00033x-6M; Tue, 30 Sep 2025 00:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rlq-0002i9-4X
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:15:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rld-0001Ny-Il
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:15:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso48262065e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205705; x=1759810505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBpejQiq0e/vydo49FSQoIaJ0P/BjZpeA7dR40L/9NI=;
 b=ND+t5mfOKbBUx5QNwj57vGsZHD7gZP531fYr+92tiA1t6wy4/bUEiBoQE26VCgll//
 Iq0BIDqu+cNSGqutyFIf+O6CvC5oMtCBihqG4vh4CeiE+MIXQ2GOPOFaLHc6C4nd2VWU
 hV4KAIIHsv8R69IRXnPlAjQzfWTY7rBrt+YhLuYO4SpNszTvmm2FlL+V9w0Rju8qn71l
 5jMtZoNiAvxqets7EJFDfMxJ8TVYWOe9U3p/fuayZfcZQPD1cVClwo4GM+arXRLONEN4
 15jTPdnlxTLtPh0DFmG3u1WajjkT4ZY/0ZudUDJfYC8Jk+UTkcuV9AANRdj0OPlB15L9
 EoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205705; x=1759810505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBpejQiq0e/vydo49FSQoIaJ0P/BjZpeA7dR40L/9NI=;
 b=If6FpHwtM5h7Sys13tfwMVGSC14ioKfepnXMbtxOqJ23W7Ggb0j7AZeOzn1N3ZZBzv
 ZuyEOcnBvw/FSrO/0ymQAxukiiVg8PGyR10FcWc+zQmTmRYIyjAGD88Fycwj5hPvFvz7
 RU7PapFMQ8b4FpXFbKgMVjmR3npVChY5dNSQiVyyiGiAogdPGJBJbAspT96Q87SlUPWc
 GjEm8PZMbRIVFWq+3Oy20vzkUmNgqN2JU+bix9umnjU2kOhQuEeYZQq6A4brfVAKDiLh
 3A7Agliw7KyOBarY7FVOvv8DVJTsYxwLbIy5ca0YXsKIzVwB559tcqjg0vtXxYP7L3kx
 2tsw==
X-Gm-Message-State: AOJu0Yz5Rva6/fLwsxYF39Hw+RNNCs0br0SShyov9JOMrOOBSUugS+Ip
 VeEAfxaaxnMw6fpaxM94gNR1XXXvT6jamlB/fQCbiOouqgCBmScIchPSiRnfIfF/F6lYMZRya8o
 gYzANRPSwoQ==
X-Gm-Gg: ASbGnctQJfL//I8GAUTqtlZTqxnu3yhmANzl+O2c9ZJwQxoaX6006OXP34lmX8MvyR8
 sRClAKj+WYq+3UGCinGOT/0xyWV/N3zmEW4/Klk9RqWnAMQXRQCSZxrwAsuRRbNVr+K8xbEWguF
 OLwv/cJ8Zs3hVxOpYkQnVvL0jq5krAmCGGeWiFDRn9JYMZ2Qnmhp0/Zh/LfYyHmME8JAbzCcivP
 we7jt7UlFKrXQsGJjZFNXue+jl+8u5AbsjMlF/zpF5q9OyrCzsDxzYSAKRuEShMC1/c7kavnaRd
 tAwlivkM793zeuZMdixlmOYgfm04jNEJcoVFGbPEy+U2NW9fdJcHqBPe7tVHbBgIE8uLKjbbFQj
 0nb/3A2S7khUvsbFbB5l9/fI+OjS2f3yF9zdwRBfaj1rXj6ZJRpF/IqJTOvaqxO/RU3jRdiuzfV
 RIblDREd6gPEiIojuxSGkBIHFoP627hew=
X-Google-Smtp-Source: AGHT+IGgqJ0JuJ77y43D9HwYeERomJh5OkTJMDKGyPclR/IBy8JcemLZxj5L2abT5KLJLVAD5Z41ZA==
X-Received: by 2002:a05:6000:2385:b0:3da:d015:bf84 with SMTP id
 ffacd0b85a97d-40e481be8a9mr20254181f8f.25.1759205704783; 
 Mon, 29 Sep 2025 21:15:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm20002659f8f.16.2025.09.29.21.15.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:15:03 -0700 (PDT)
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
Subject: [PATCH v2 16/17] hw/virtio/vhost: Replace legacy
 cpu_physical_memory_*map() calls
Date: Tue, 30 Sep 2025 06:13:24 +0200
Message-ID: <20250930041326.6448-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


