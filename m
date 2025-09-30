Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E97ACAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeC-0000cf-Mi; Tue, 30 Sep 2025 04:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VdY-0000Be-DV
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vd1-000114-6o
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e430494ccso24383085e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220538; x=1759825338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kEeDKj/VliAI89NHWLpYrYcoI7vlOg/a8aX+CJnHKA=;
 b=mpeQIc1QFPZ9F37U6XggwuTUBeBIvANR8yviqyXY0ZUXXWBfh3IhK4UCA+M4XNu3qU
 O5wFtaVkXmWCmzR7QRFI1UoGqVv/ymiuhd/4Bf77oQKnEr+dQ5a2hUwfCvHFqPsH1Acq
 Qh3UHycUXPeuFyJFo8jNW1jhPde8NewtoC/r5PHxi9OmO94a12HaVnkEk09uIVcbq2W5
 4qOulhS5KPJpWFztdY0M2emPya0U0TbPWoTUIrX/yT4Yoo14lSo4Jtih9fOq44BmAEhW
 SvT6ABBqegYoYNrOcWgQVQwVBCBfpdu+z1RzUSeEwb8taHNvuzdaDaWGcdadYfpog0DE
 TFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220538; x=1759825338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2kEeDKj/VliAI89NHWLpYrYcoI7vlOg/a8aX+CJnHKA=;
 b=sj6H9H9aj/4SswTJopZvWsxxGmtWMXNj102qQju3WraWGYdqy4Xllvw1nazRzv1VNl
 2ser2AxoOvpeh53szrmeYnnZhBCNd9JlvvUPYiKQgazbmOtD2j0d/ukk/V/8afWi6+/9
 hkpOTdWhwEnVMzWyn49TU2IVLmYd7RzzsIigdIqKwbf7VxMCUp53T4TZCmgJVd+l7mKj
 rDeQK3iEIyUCG5PsZbCnx0VUdg8EFV43ZVHhNJ7CTTHS1miOmSNBleUYPajgHN+zYD+v
 fu0lT0MYCoXtXrpstnZnCkSSFSmFPkVRyD/yDdbbDGgEwrUIvLIB2vVX4gO0kREp/yNJ
 jzHQ==
X-Gm-Message-State: AOJu0YxCaG2TyELxR5oc191SDKUxSKzkZXpoS76CM42odkSk+Oega7p+
 Z2P9W8bSfePUJQfFm7RM1QF695lfi4k1J9u2tMbLHMK9e7ElVSoiV9TTYw6Tkb9SIZgEBnsFkE/
 J3JZ91MI5XQ==
X-Gm-Gg: ASbGnculaIK2Gi3C34qWNk9s0SDEkrIpRbIQEMyRtH0gCnRa+xZZXjW+lFqbUpS5VQ7
 I41+yniRiEpgUKGDgvsXFmK4xymoQDnRRQxY0+p53kmt+5kETyRcqPh0o8uu/gWPU7FK7ybNv2T
 yPQIw3C1k6bqMaDVGhLJSZ4XR3qWv7Qy4nPhWEADcCBZxmuYmkOwxerg85BlPJppQ1WU43P3pIn
 MEljCIzom5PRlaTJGqxUXL3ynip12dzIt86Ree4uDsEc7+xIMtmx+5Jx50Hx45f3XdtV6FPeqlG
 08HPFytyL/OjURyyQIXH36HjGT0TGPvXOYGxARGovlRRljYiew7eZIHQV/rtCdv5NONI9QOHeNE
 jlraw8cLS5smMyWEohHNMWUvWle9KjC/hC6QvR6hjyxLOZ4M7xe1+rORDBF6oz2PkWww29J/SUL
 1qDAQTk/ljTVKR6XAOFcVH9YiONqR9WrU=
X-Google-Smtp-Source: AGHT+IE8kOnIri7d9kIT89vkssg0QjxuyhNQyNkBu4zqQAFaAaCY/pGZVE1XfJtvAVhQrg/vBoJaIA==
X-Received: by 2002:a05:600c:1386:b0:46e:1b89:77f1 with SMTP id
 5b1f17b1804b1-46e329e28f8mr169270875e9.9.1759220538270; 
 Tue, 30 Sep 2025 01:22:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb871c811sm21599810f8f.15.2025.09.30.01.22.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:22:17 -0700 (PDT)
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
Subject: [PATCH v3 09/18] target/s390x/mmu: Replace [cpu_physical_memory ->
 address_space]_rw()
Date: Tue, 30 Sep 2025 10:21:16 +0200
Message-ID: <20250930082126.28618-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

When cpu_address_space_init() isn't called during vCPU creation,
its single address space is the global &address_space_memory.

As s390x boards don't call cpu_address_space_init(),
cpu_get_address_space(CPU(cpu), 0) returns &address_space_memory.

We can then replace cpu_physical_memory_rw() by the semantically
equivalent address_space_rw() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


