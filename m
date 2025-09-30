Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F56CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RlW-0002GI-Ow; Tue, 30 Sep 2025 00:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RlU-0002Ca-9y
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:15:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RlK-00015C-AC
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so55743325e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205687; x=1759810487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9bErLRqv9kjbdzs2kwz9FzL8C8SAPMQ12Esuz3D9Fo=;
 b=PXO0idZ8+0HY+7ZspU8VSAx5vfgGq3lXQcAS9P0vuZNsoMsNXe/QA3q+Ssc7N2qhrE
 hvaRtBDxfJmw2dBYxz5EfXvFUVkKsLxQJ8scibopQPCKRRG+oq4FOZhIE2ihPi3lJGJU
 QeNmswjSyERWLP0r8mVd53dE5UrRGAGj59ecZICw3+fpxbl7SXFadik/Ds/U6gdSWr2M
 wFUYK9eDlNxd8TZUrQugZKVmSM4op3oaLBWuqjY7vhJLeg+lWCwfaBzy8vJnN0iDSn6Q
 FYM5Qc+TqsYnAMohmDaO3rZ82d3vbTsFpuYEcGM65uOiNMo86GBMbeCdEpjBIB8bgCCW
 G37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205687; x=1759810487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9bErLRqv9kjbdzs2kwz9FzL8C8SAPMQ12Esuz3D9Fo=;
 b=iXLr9XXdtZRLf+ElOY8gNoRoxACorE93adfbGdcNwGRc44OMsDe6XJohC93W3WuG+d
 l41Nlq1YoSH0Q5ooCjGU1zNvvQNAgKp/EvqOpqzkUsV6cY8rYgti0WEnw/YbH6um2iic
 aUafMfgv0iYSXYoeTgW9EQy881URhrB7lUosUub82FGdyyJAxKRM/MCmDlBYbJeJRPCv
 kHwxmDcpcCwwLBbhniwdIIXSu76YAwnpaQ6KV2Hv7olUb4gIfMiPwmZmSyXblyd/+4Xq
 vpBQ7Q9009hVAjG0uQvcL0QeVcxmhpl0RTxaElcerPqJ+qQ85XwxnB+vBnsb/3ixNGT0
 xf/g==
X-Gm-Message-State: AOJu0YzZRFxDWSnyY5Ykp5BoDL1aBXQYD6dooO5/KmJi418ab2n1MQ11
 +ZASlfqImAjF9s7/RPTV0lVFbmzIQ3Vqw9A6rn9BR4xW5Slz7yqrkVYV8xNWIAGkdzoTtgF43lG
 j58AVAKlGbQ==
X-Gm-Gg: ASbGnctkp43VrOECqz07OtNBpgS87XT6GBH0uwsi3npFgXoTfZ7Oa+t/eLOoheEElP2
 eED5U4yhc4+RAdqOh+JBRkhIeulePEi9/pYSKdXTG9EcPKwEyI24815iYQdDQze1vGKQbpzVO9G
 oEUr+uG3CJ5t8XKRAewo+EEU6ap1ymDBfGytOLclgFsXEguE8jBcwb4tBZCLQOBCWx90IxwwE4s
 2wt+FJtBBGdOERbG6ly/3O8RXklXtjSHh5gG26EepKAwmnuboUJ+Aq5oo5D6Py/Tpj9hoZ49pL0
 HRWHG0whxttu05+T6+ZFK4mYM8i+YU/J04VR8BRwwQ4PIhNjDb1ipjU+jZ8PGl2cgiJbVhMc6po
 g9iEybHI6Sx9+ksPvaeiHavaFnZPOBwfqjdKrNspsvLJQsQpEcmgn7IY2aSh/2Bulrxd1YOq6Sv
 ahE9Znnxgz3TWrSHVVifME
X-Google-Smtp-Source: AGHT+IGyKmmQIMqQURGJv7gP62rq5JnP7SAE6q2ubqy946YRUlo5uVTz66eDWtBwE0h2GgBG2/uY2w==
X-Received: by 2002:a05:600c:4e43:b0:46e:3f6f:a8ee with SMTP id
 5b1f17b1804b1-46e3f6faa76mr119745615e9.13.1759205686721; 
 Mon, 29 Sep 2025 21:14:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9ac5basm284686015e9.7.2025.09.29.21.14.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:14:46 -0700 (PDT)
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
Subject: [PATCH v2 13/17] hw/xen/hvm: Inline cpu_physical_memory_rw() in
 rw_phys_req_item()
Date: Tue, 30 Sep 2025 06:13:21 +0200
Message-ID: <20250930041326.6448-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

cpu_physical_memory_rw() is legacy, replace by address_space_rw().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-hvm-common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 78e0bc8f644..52e2cce397a 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -12,6 +12,7 @@
 #include "hw/xen/xen-bus.h"
 #include "hw/boards.h"
 #include "hw/xen/arch_hvm.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "system/system.h"
 #include "system/xen.h"
@@ -279,8 +280,8 @@ static void do_outp(uint32_t addr,
  * memory, as part of the implementation of an ioreq.
  *
  * Equivalent to
- *   cpu_physical_memory_rw(addr + (req->df ? -1 : +1) * req->size * i,
- *                          val, req->size, 0/1)
+ *   address_space_rw(as, addr + (req->df ? -1 : +1) * req->size * i,
+ *                    attrs, val, req->size, 0/1)
  * except without the integer overflow problems.
  */
 static void rw_phys_req_item(hwaddr addr,
@@ -295,7 +296,8 @@ static void rw_phys_req_item(hwaddr addr,
     } else {
         addr += offset;
     }
-    cpu_physical_memory_rw(addr, val, req->size, rw);
+    address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                     val, req->size, rw);
 }
 
 static inline void read_phys_req_item(hwaddr addr,
-- 
2.51.0


