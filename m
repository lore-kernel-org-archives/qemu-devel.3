Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963C5CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RkZ-0001ht-8S; Tue, 30 Sep 2025 00:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RkX-0001hB-Er
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RkR-0000mn-JE
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso34333085e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205631; x=1759810431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPaFfZE+Vm6W3t7QC31lKwf41cuqTfJ0BWTKMrsHvkU=;
 b=s/FfLKRdElILKe9w5w2H7KUN63HnGFj8oW9q46C8Zeh+LACNh0b2uTRRbu8rTU7CXp
 SQK6+D/mlmJl9NL657qcUPJKyncqEZAO1uWVJ8Ic73WhjlgfdGsQz2MLs5Dssuaw8HA8
 ZujsDCLyljGtJGrQwo18SF3xrg+zl9kZ6+KFya9OiWjUMlUsnYGu9XXXRSiQ1CHK9+Et
 P5AgR+ph/m9vgZjSJMTXOMgNGWdPp1JoNcfRjrM1lg/xwqzLZi2q2cKNvy+b6QzY6F0e
 z3hwiNHLxLO0D//HJQFD1NuO3Vf35kGpBU0JYeENBuR/hDkOx4RVGm0R4egUbeL1EOZB
 tivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205631; x=1759810431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPaFfZE+Vm6W3t7QC31lKwf41cuqTfJ0BWTKMrsHvkU=;
 b=QgPNobXiHQ/siFPhfdiICjQIl/wXUJzg6z7TME8TfIpEaKzObHeJjL0r25os/k/LfZ
 7Kdrt5hdY8Oy6himejqOKva99wcw7xe23/7Q2wfrRGrvPJczhT7oCaFIwP4uvZf3NU1K
 0B9bkpHaCgmB4cMC8tnnuI+4T22aRCHY7v4dZarg3EsAHSOQ44Ue9ArRDz7nifQu3o28
 rt1npQkCPkqhgdYKEjaEoezN7lOmw+NT9XDzEPQlMb8gwmxdBa5pLCKziQeHWoARmE2n
 4cU9zMj/Fr+30nxZurgCa5A2ubSjehB8pBkekWPHYxls2QpocFJg4/WKfK8GvzMuClJ7
 WciQ==
X-Gm-Message-State: AOJu0YzvZaSZgADFA5PoWAwyAs/WCacGkd1RpU18D0VWRLmR1Tj8VNaB
 Tl2YIvxqtgvZZNRMVeSXnsXvVSrZXXMKtBUNYyVgRHEw7eRoGvpdmkvb7RtIDJ7Xh74Kx9S27DQ
 ywLqb2KiTiw==
X-Gm-Gg: ASbGncsBkIML3sOnmzL300hDGtvtRA6OsrJGyTz2yZhZI0XyAeY8G2GPx/QFVfHP3K3
 tbG4bT5Bw4LvibJcKwERMKeN/AqflOGyJOH24DYBtPJ6vMDe/smapw670fvdBV8McuXQb5qQ+iK
 RCrDkF7r/awoYGmNPEdi7/hvH19x9IqPUiC+b3imiTOq9M+ts/gSSTAg3c5UTJn4dPfGtzBVFPt
 H4Zf3kBSytz+nZb3WwbXdxn8+umNJdgOuKN3MMyRIB007CRmNKK+C8lYySZusw6utbMmJoH+Ts2
 bQW7UYF2cGZzfstukwxOkm+wjCsBPQ/2BXJf2DitQww7u3nrG/5K5cLP9hPZfBUhX6qIBJ4Z+GB
 d+wwWjtLCaYU4NWMJtehvPUzXwMe+J3+wGcVTjBof3e8yV838U/JLMXNkmTs2jjP73d3fLa1Y6F
 a1NnuFZ8aqbTSRui08TCQ95R27kuMa9t8=
X-Google-Smtp-Source: AGHT+IGcac+YiZIcZSnCrqiaQ5DwkBXJUwHzOeJuSpEQu46EHairXFh+p7pa80eZkns9YIhZ38oTxg==
X-Received: by 2002:a05:600c:444d:b0:45f:2cd5:5086 with SMTP id
 5b1f17b1804b1-46e3299f4f3mr172171215e9.3.1759205631445; 
 Mon, 29 Sep 2025 21:13:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f536a3sm43891685e9.8.2025.09.29.21.13.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:13:51 -0700 (PDT)
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
Subject: [PATCH v2 04/17] target/i386/arch_memory_mapping: Use
 address_space_memory_is_io()
Date: Tue, 30 Sep 2025 06:13:12 +0200
Message-ID: <20250930041326.6448-5-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Since all functions have an address space argument, it is
trivial to replace cpu_physical_memory_is_io() by
address_space_memory_is_io().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/arch_memory_mapping.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index a2398c21732..560f4689abc 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -35,7 +35,7 @@ static void walk_pte(MemoryMappingList *list, AddressSpace *as,
         }
 
         start_paddr = (pte & ~0xfff) & ~(0x1ULL << 63);
-        if (cpu_physical_memory_is_io(start_paddr)) {
+        if (address_space_is_io(as, start_paddr)) {
             /* I/O region */
             continue;
         }
@@ -65,7 +65,7 @@ static void walk_pte2(MemoryMappingList *list, AddressSpace *as,
         }
 
         start_paddr = pte & ~0xfff;
-        if (cpu_physical_memory_is_io(start_paddr)) {
+        if (address_space_is_io(as, start_paddr)) {
             /* I/O region */
             continue;
         }
@@ -100,7 +100,7 @@ static void walk_pde(MemoryMappingList *list, AddressSpace *as,
         if (pde & PG_PSE_MASK) {
             /* 2 MB page */
             start_paddr = (pde & ~0x1fffff) & ~(0x1ULL << 63);
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_is_io(as, start_paddr)) {
                 /* I/O region */
                 continue;
             }
@@ -142,7 +142,7 @@ static void walk_pde2(MemoryMappingList *list, AddressSpace *as,
              */
             high_paddr = ((hwaddr)(pde & 0x1fe000) << 19);
             start_paddr = (pde & ~0x3fffff) | high_paddr;
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_is_io(as, start_paddr)) {
                 /* I/O region */
                 continue;
             }
@@ -203,7 +203,7 @@ static void walk_pdpe(MemoryMappingList *list, AddressSpace *as,
         if (pdpe & PG_PSE_MASK) {
             /* 1 GB page */
             start_paddr = (pdpe & ~0x3fffffff) & ~(0x1ULL << 63);
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_is_io(as, start_paddr)) {
                 /* I/O region */
                 continue;
             }
-- 
2.51.0


