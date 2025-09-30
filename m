Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52700CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rl3-0001t3-Fb; Tue, 30 Sep 2025 00:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rkx-0001rU-9b
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rku-0000w8-C0
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:27 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so3873308f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205661; x=1759810461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRsfrHQBMjnrXhlxfeiXrXfyISPq/9LUWh417J9QSAY=;
 b=Xls/3qWGuta13qzkwcQJhAr4OFyJjsL1IfVcFDuzkddc2ff15XB4vVKraHVfrv9ci7
 EdFln1gXNQ7dyXZVhZ/tDh1evwGfrpEI9U3Twbon4+h/ZJXYce9E4Y6tkSdxU7SMrLUl
 UKxtXuUJSFFk+9mmJ/po7sO/HLTT8wHW2Gw7rEerYdG7GQaVIx8Sw21znL2eYbu7e1GQ
 zLD+7R+r8A8uSHH4oglSiuCzOA37uWplcPFhePz7VXCCyOum6a9NQ8GkOdmWoKA12o/1
 +anpvCglOAy/ZVw3MwEe+vDuFPgNEm0jZLgFcb4pUNoy5OzF7t1uXYsTFHTP25wvAsD5
 hpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205661; x=1759810461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRsfrHQBMjnrXhlxfeiXrXfyISPq/9LUWh417J9QSAY=;
 b=b1Usl9b9Sf598lEqoNzGPvLpaZgpKRecmue1viU9dZzAP+FmwZUb7WgfHzmUI7KjlF
 fyy7RHxjXXYytFoQ5r7u++DOZIka0XiDt+3NZK/0jFXmDusEkOxwrzNq9z3euL96W0QF
 /SWW/I/2Le1EVNBkCJCeNsj82+z/AvuPyi6zpdvbwoEhpXANFwKo7yjEcdm7wSHNsDSB
 pjwbUfFTJ8rsSeqFXmIB1eJ9urYfKj1wHvYepWaRw0dnkocyfQwKxdvMzaCWk7WUhwXt
 N+ovw5Q1Soar+qhMpns6lh2r75h7b0SKGTiaMVl3vSFHifDR4S0Mc5R/pjzjchaJmNyh
 CnFw==
X-Gm-Message-State: AOJu0Yzz7QDh282AZ4JoIT06HxrYnH7gEhyRcye7dVfT4HAOz4wlzA0g
 lRQ0AAlcYKtWLk9zTgORx7NwU+EJdEwroRfiqORc0mGYkzlTP2yivdV1KtG4J6HQYmKwib3Lb1z
 wYFhSr74rAQ==
X-Gm-Gg: ASbGncvqCgQbOJW1erq5hETZSVwtRrRJPjy8ppAWYnEAx1oCGLPZU7lbAQ7Oj0wkc02
 Wh2U/by2CQkmoJk/zC6acz6TcxH3T7dY9GwmY4l/mFw0AHcbZ0mrzWS/VBytlukoQXxcCdBPsGS
 hMHbtBqVH9vPgTfWgaZbzjZuDxuEqMicV2nXmGrdj3yV3ZsYMoLYXe+TU87rWs8ABV8/M3Km/j3
 0PQuXP3s9fb4Oz+7/Q+T24SPEoX9JWkkbibWllC34Assb8IdrsfW1FyuQoHID94NTPYXSnUK5jh
 jncGozJLWZRxzR0OWUKT3pQWXnjY5MwX4InaRw7zkQklsHYDoAUB/2QvYiKB1EWcf653r9ZLXRd
 1FjEG97LWUQdOnX3HovP6njspw2PCIP3cvWeOWrLtMxQCaNjOElNdSTz/Ky9pJD5qXikQmgjFTk
 LuQW3N4NXtBmFsuoaLNaaSCJlM2fqpKB8=
X-Google-Smtp-Source: AGHT+IEAmcRaAQ7y3JKYkZc+1B3lBRPGfbSyTbOeVCtcFaGQrh4be0IXziHu3DKBh/h2DslEMGPKwA==
X-Received: by 2002:a05:6000:2dc9:b0:3eb:c276:a362 with SMTP id
 ffacd0b85a97d-40e3d69c099mr16747038f8f.0.1759205660946; 
 Mon, 29 Sep 2025 21:14:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb74e46bcsm20884752f8f.8.2025.09.29.21.14.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:14:19 -0700 (PDT)
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
Subject: [PATCH v2 09/17] target/s390x/mmu: Replace [cpu_physical_memory ->
 address_space]_rw()
Date: Tue, 30 Sep 2025 06:13:17 +0200
Message-ID: <20250930041326.6448-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

When cpu_address_space_init() isn't called during vCPU creation,
its single address space is the global &address_space_memory.

As s390x boards don't call cpu_address_space_init(),
cpu_get_address_space(CPU(cpu), 0) returns &address_space_memory.

We can then replace cpu_physical_memory_rw() by the semantically
equivalent address_space_rw() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 00946e9c0fe..4e2f31dc763 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -23,6 +23,7 @@
 #include "kvm/kvm_s390x.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
+#include "system/memory.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "hw/hw.h"
@@ -522,6 +523,7 @@ int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset, void *hostbuf,
 int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
                          int len, bool is_write)
 {
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     int currlen, nr_pages, i;
     target_ulong *pages;
     uint64_t tec;
@@ -545,8 +547,8 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
             currlen = MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE_SIZE));
-            cpu_physical_memory_rw(pages[i] | (laddr & ~TARGET_PAGE_MASK),
-                                   hostbuf, currlen, is_write);
+            address_space_rw(as, pages[i] | (laddr & ~TARGET_PAGE_MASK),
+                             MEMTXATTRS_UNSPECIFIED, hostbuf, currlen, is_write);
             laddr += currlen;
             hostbuf += currlen;
             len -= currlen;
-- 
2.51.0


