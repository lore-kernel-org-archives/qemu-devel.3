Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1A1CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeC-0000ca-JX; Tue, 30 Sep 2025 04:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vdx-0000Ng-SJ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:35 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VdG-00018A-0w
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:25 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3fc36b99e92so3935290f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220560; x=1759825360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9bErLRqv9kjbdzs2kwz9FzL8C8SAPMQ12Esuz3D9Fo=;
 b=yg/UengvWyzhNDSLvQTojgd6Tn1F95bjFyZn1iU5JbgWrA6pt6/XlUN0IxRYtizGHZ
 peb3Mitzl4AAVbVHY6kegIyCP9+mmpYi+6/F0kIgoFXkKN5FyH6QRT3ffNxl0kh75w7+
 sBlXOV8Tvb/W/La6lwIVAocSK8U09HiGkdo3lXtis3I3PHkN8/yIIK96t4VE2VFSLTiz
 gJKDKCa98HVkP9feQB9yecXPZb+AJ2kl0aEe6aIe29lLzS/Qe69LOO+FsoH4WB16O2IH
 3O9Jjl4N8lu3ARf1nh78nHL0UgH59Hk1no97ErH42FiMx2otTMpF8nTf2dKrt20bYTTz
 bUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220560; x=1759825360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9bErLRqv9kjbdzs2kwz9FzL8C8SAPMQ12Esuz3D9Fo=;
 b=OQSM2OUGc2PTtJww+z8oWyFK+qAfsrdG6M2wJlroRztMyRj1W6NlVWj+KjGIWW9nSV
 Jc/yYt5x/ny/HkM7EC+IkHQtWr+fL4EkXbnSP+UxvlwpnbvPQYMKFVnNu5Krf/mw6VwM
 gSfVrtkyeoXLitMaKLNjMHG/gJpoVWEo/5vE8Hpf8jZQPzvrYWJIkZgpbNl6CCFMJlOY
 o7kAJVq8VYmWdMkzywzuORFp9e+xah/rf/m512ULeLDwDb8pD1YUPAtBf7vq4AucRC2M
 dN0GgOdgqSAnmYfgY72Pj69umJi3Fjmeh/EpoM338WHDf5RFwe2NU9FIkOOY0GNdQ4+H
 4lRQ==
X-Gm-Message-State: AOJu0Yyfs6NtUKjqynRxceCkTs9hv3eNJoWX0BfyMlPB3Cy8FgyA1bYN
 kqANt4Rt6fLy3gUVMzCsLMQ5LFJzkfRn/nnKqmsJIRN4ZEW1MVeSpZnvHvNMUc2tOEHYk8XxqMd
 s1c1CbtCTSg==
X-Gm-Gg: ASbGncsKJssukE1WOxDS2nQ4WHca+zAhVkH/v2wewVHM89HTXmbDBedWaQt8zXJHSWF
 CCAtU1AwOWNCBmyW0ByLIkMeS5wEWlUVnzPKcKvcvwfEWiluBONwijj/nWZ6fKHZh6pz0327F+u
 opfmY0GFmdnIrjv4DOAdn27J2Fwl1reOBUJbkFyCMCDV0UHgH9RpUPZv57If2kfjMuO/W5wiSo6
 PHWyMuQf/mv9UphCbSx+bXq0e2EYovc24N6zEmdE5VSzUCjVkU64830uri8PleC+1BN01HDZ+OH
 l+wjiLuEIzWg9lymRClRvDiNh3FNH5qJINc9oWuNRkQTUIJcXfUk4SqwOePdrpgqUH56HPz3iZR
 LLMN8fDBFgDKmI1Khl0ZAnor0ZHfpFx/iCAENFOg4LLv3jMl6cJDuvhXJRO2rvMiWgBP+/FpHbQ
 XVfhSjGNm6RseYCVb0aqAO7msVZQvB+mE=
X-Google-Smtp-Source: AGHT+IFKquQgcsAUg0Wckpi3Q1uVvpKK2LWW0oi9N9Q9t0bhLrHk1BTizML0eTatl5XEnZE1L5+HFQ==
X-Received: by 2002:a05:6000:40c7:b0:407:d776:4434 with SMTP id
 ffacd0b85a97d-4241227789emr2953961f8f.30.1759220560163; 
 Tue, 30 Sep 2025 01:22:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab4897bsm257449245e9.17.2025.09.30.01.22.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:22:39 -0700 (PDT)
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
Subject: [PATCH v3 13/18] hw/xen/hvm: Inline cpu_physical_memory_rw() in
 rw_phys_req_item()
Date: Tue, 30 Sep 2025 10:21:20 +0200
Message-ID: <20250930082126.28618-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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


