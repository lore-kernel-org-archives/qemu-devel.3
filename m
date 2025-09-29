Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8F5CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IiO-00065I-Je; Mon, 29 Sep 2025 14:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IhM-0005Wk-L9
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IhG-0003XY-9b
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so40588405e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170837; x=1759775637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9bErLRqv9kjbdzs2kwz9FzL8C8SAPMQ12Esuz3D9Fo=;
 b=SQYLSShEYnWTchhPmOGKdoNJql16x9xBJ9kQRABDR9HAsFMkQyTrV6a9gMWPPp3Nc5
 6tG3y+M4PbQwGghtj+AxDZEX0BqVgJ7ST1JA7RkSuO+yGvPha1xe2vRkiuPlXB+ymDao
 d6tCYJtYqBW5Om/hR2OdA2nDfqcWd6GQnkgVo544fX7FHs0JG6IIS1iPB55+Skd4IJgT
 +UMf+1EiwOnoe/9ik+Tx3H3T3LeE+mffSimsAjJ2XeRJsBIEeLVOoH+u3WL63CSPiofo
 OcJxYlQDawWdmeE6ty3M9UkIUa3UZ0JV0MdWOWdN4FYrOUwg048dFNSzgDHPt6dtSBDO
 hm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170837; x=1759775637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9bErLRqv9kjbdzs2kwz9FzL8C8SAPMQ12Esuz3D9Fo=;
 b=YGUbRoyba4onRhtaBOel3nBCzFpFFyw7GJC3jgihsmQvQDA6Y+OZ4DQym4wuIYOBNR
 VEqguth1FJYZcieSQfrQYM9toXEDXxyVFcOVhSzH4OHhnnSkZwzfZ37Bfed/FafRsXKe
 i+pumd4xA6WTvpcbE8bfKSTlkhKKxWGww3ZTaJ1Grdt0ZMmF6riAwWhAJcohY799idPr
 sjpHuD4kiSoaUitvKPCqft+IhrCxM2SNY2RBIrUItn1kdIzTFKr9YFkAt5v2tvsL98G7
 SCuaFIHhriXChkQTv9AbHiJ1wwehs5lRH7tDhfHMNxgOMGj5vrFZllNJQtCbJsenJOUi
 K7gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Ry9gU/UhzD8HrUPvJDr9kOqhyA0t2jQHUUh/cd3+Ox8TdBVa2AZHwt8paoIbiHA5fpx6oxNyGgh5@nongnu.org
X-Gm-Message-State: AOJu0YysyUdzWVTEhHGJxGug2z2pCSwFwgtaxUgrBXmX8gRoe58b7cEB
 H2PpJx1sf69jvf/j9L1iuFPDtzBQc1IbEx5RbA+W61ecfj73W76szDwWfRBYGNCLOgw=
X-Gm-Gg: ASbGncvdJ9+TUD0WThWxF+hO2RcN2r+Zf/gmfySEOEw31Scr8D6z4zUKQxUdDuDWbyV
 1HKBpfp9bBGw/qc3d8HQ0L5h5UOUNSGXHAFK6gQyLHRkVodRIackxI5aJ1qdrXTNaJDDPMddVKG
 6nZm7sbNMbIP2iXJjuhaTzMINWZ9ltHeCdAVvYX5mguJeM3ncJyrtdvZSkOAl6K8cLkmNmzXRcx
 oFYzITbRooxsOZp78f7vMa2uowR4VACL/1tTCTC+bxQ6l5bP0wk+0ECa2I8stg5tevxMe7SyuRc
 psQI1jmUPdqYwAnPNa/zcVo5rCthLTcIS9Xf0/NGL1Dqu1NY7F69YDcXrQDf3y6dxCIUijJlxzk
 XhSSHdhdjv4AQR/NRk8jmac1k3SieYAbBuaC59Kua9xjY9vqIXzNAeX5r6gk1guxDM34HZR2Cpf
 Hfo8Pu8cs=
X-Google-Smtp-Source: AGHT+IFV+pWpl9RpYQY3/vKNUQDjfsPx6DQqux2wn16tRZPr0u8FrK0pJwBF+V9pyB/rSvhEdc2qCg==
X-Received: by 2002:a05:600c:4b16:b0:46e:326e:4501 with SMTP id
 5b1f17b1804b1-46e329ba996mr129660275e9.10.1759170837108; 
 Mon, 29 Sep 2025 11:33:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb9e1bd14sm20127006f8f.28.2025.09.29.11.33.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:33:56 -0700 (PDT)
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
Subject: [PATCH 11/15] hw/xen/hvm: Inline cpu_physical_memory_rw() in
 rw_phys_req_item()
Date: Mon, 29 Sep 2025 20:32:50 +0200
Message-ID: <20250929183254.85478-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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


