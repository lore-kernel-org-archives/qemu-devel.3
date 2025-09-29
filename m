Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE9ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Igg-00052P-KD; Mon, 29 Sep 2025 14:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Igc-00051F-Dz
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:24 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IgW-00034W-P9
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:18 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso4274680f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170793; x=1759775593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23QTyPjiy3YtVC18SQIGMGuPQmXq870ERJAMX9bHv6E=;
 b=DJz7Fx++2ORz+tPdRoFWX+hafk4iCB8t2HOawOmMZgvrEIX1fHnwwpQSXN3cMPtRCD
 jQ5awdCwlcCxMzOSfQF7smOiFS+kbbplzRYpunRLtGrowCDoUtkXNuU97NWMoCFm7p7I
 38s2+p/WmHHumX+IMPJ6yXsOpFG/p7vlfF08b9X4xkj64QBEgPp/1athyHYSBuiYxkfG
 ieciUv+PJgHOuSuk1uwPubqNjjoFbPESUY+cQokzg0iX7VR0uz+xuV5HoezKVLkAphGs
 ZaY3ya85fiU9oCo7bfgChAtI3qniJqFaNr201VtifM05bglH6k0WlXt5Jy6LsdpwHq0U
 5FFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170793; x=1759775593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23QTyPjiy3YtVC18SQIGMGuPQmXq870ERJAMX9bHv6E=;
 b=i35FyGrFY8wleq902Y4YIjzwy3QlSdGPDGIcWtgLZmmQp3fZ3m9ZnRY8nQ9y5mFcry
 vWfyzs1svmy/1knsvgT3CsSEntSpzw48GWXrXfxvqFA7I24X6oPzktJIF0ea95iZ97Y/
 OnlflMFMv4g6UBTBnDWih+7u8CQK7tqY75+PBo5GZJp1qKeanIu28lEGJOxOAPj5zsG0
 /i/LkLonoT3T4/pRxV0ND1VWOxIi6N5SkY9KX1gSkRSBFwjrm0IpOX7CJ60rhpK8N507
 dQ+iEqXJoetJ0Ln3EE045fPP1h9PQrRqiuktok6PT9qg6ga0HWCUfXZxgBMNeXPU33hs
 KMPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlw9zaMUmpjhh+pGRNp7yKje0hFTBias7Yq5XIDbVEKKIne67lQeTcADsDOSG76oaFGzZ/VsJJhyk/@nongnu.org
X-Gm-Message-State: AOJu0Ywx4g7cagnFm42Btwxj6OPJOzaM8zu/9bfsrdEBd1q82XdOGlwR
 FIhNJtkHDX6w2YhUnb8SJCuMOdlRL9ETnNLbTJDs3OLRiyybsQLN0VtPZCbQzvFOnxQ=
X-Gm-Gg: ASbGnctNNmYA7TdwKm61JczYBE+yCc3zoETHbxBxI/hOg87CxTLiULi77YkbPt7adBw
 LvtVPipygCFcmD5GMrQVVGKp1TpC5qjGkbMWflMq3bOs1Rhx9SgNuRfH6Cpb/NkNMx0JZAFuLa8
 254d+3HrrS+ZrqhKPh3bXpKteUrWJ2YH9O0lA4W47DER2f91d9ytwBuilmEPTvUk7YnfyQ77AS6
 6f4mszWl4nLxh35+7DNmTFMomqNWbJwtAnfz+EWaWzg7uJfDKT7Al/MqtLWQRc1fO20CULc6uIt
 sVVa82Z+sLMIGd+9E23m/WsoxVK+N2CDM2d9zmOsIkFxmJVfnDx4Bn08q5WGwuzxzaOvmtJLfwE
 G5+f5PWoRbBxkm2taDWCe+Ww7tY65I+aVyCroQwOMtmEzPTKAAIgTCunV2EwLWyYmjIu+nsNabG
 kic39BRrc=
X-Google-Smtp-Source: AGHT+IEcDsohAJY1q22fsASxxAoYQtWlMdbA7XCLoeuebdYNdITcBiYeKjk+UAJn3Z9pxuCxt6ME3A==
X-Received: by 2002:a05:6000:2586:b0:3e7:65a6:dbf with SMTP id
 ffacd0b85a97d-40e429c9c42mr14229584f8f.6.1759170793465; 
 Mon, 29 Sep 2025 11:33:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb8811ae8sm19065012f8f.19.2025.09.29.11.33.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:33:13 -0700 (PDT)
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
Subject: [PATCH 03/15] target/i386/arch_memory_mapping: Use
 address_space_memory_is_io()
Date: Mon, 29 Sep 2025 20:32:42 +0200
Message-ID: <20250929183254.85478-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Since all functions have an address space argument, it is
trivial to replace cpu_physical_memory_is_io() by
address_space_memory_is_io().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/arch_memory_mapping.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index a2398c21732..d596aa91549 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -35,7 +35,7 @@ static void walk_pte(MemoryMappingList *list, AddressSpace *as,
         }
 
         start_paddr = (pte & ~0xfff) & ~(0x1ULL << 63);
-        if (cpu_physical_memory_is_io(start_paddr)) {
+        if (address_space_memory_is_io(as, start_paddr, 1)) {
             /* I/O region */
             continue;
         }
@@ -65,7 +65,7 @@ static void walk_pte2(MemoryMappingList *list, AddressSpace *as,
         }
 
         start_paddr = pte & ~0xfff;
-        if (cpu_physical_memory_is_io(start_paddr)) {
+        if (address_space_memory_is_io(as, start_paddr, 1)) {
             /* I/O region */
             continue;
         }
@@ -100,7 +100,7 @@ static void walk_pde(MemoryMappingList *list, AddressSpace *as,
         if (pde & PG_PSE_MASK) {
             /* 2 MB page */
             start_paddr = (pde & ~0x1fffff) & ~(0x1ULL << 63);
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_memory_is_io(as, start_paddr, 1)) {
                 /* I/O region */
                 continue;
             }
@@ -142,7 +142,7 @@ static void walk_pde2(MemoryMappingList *list, AddressSpace *as,
              */
             high_paddr = ((hwaddr)(pde & 0x1fe000) << 19);
             start_paddr = (pde & ~0x3fffff) | high_paddr;
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_memory_is_io(as, start_paddr, 1)) {
                 /* I/O region */
                 continue;
             }
@@ -203,7 +203,7 @@ static void walk_pdpe(MemoryMappingList *list, AddressSpace *as,
         if (pdpe & PG_PSE_MASK) {
             /* 1 GB page */
             start_paddr = (pdpe & ~0x3fffffff) & ~(0x1ULL << 63);
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_memory_is_io(as, start_paddr, 1)) {
                 /* I/O region */
                 continue;
             }
-- 
2.51.0


