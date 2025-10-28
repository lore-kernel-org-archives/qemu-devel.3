Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE299CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoVf-0006Pk-8E; Tue, 28 Oct 2025 14:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoUX-0005vD-9g
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:32:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoUN-00044p-No
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:32:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso66772075e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761676323; x=1762281123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaTjF09SMgISnzDEeFqSTFyM00Tszf9mX6IdYxJoDH0=;
 b=albqiIAmyTsoZqMcLCX4yCZHpvnaxuCbScltHjjLppfShOMUxhSj2t1AVbPJbPMEGO
 Q5qmOy10hBn+o+4lFyJEzQasmnUtBrj+OjDl5TqoDAwOuHqz+dtDqxsyNCpLhvjAJQLy
 zasXs8imyHfU9KOpvcDRGpikibe25SqTDmXyyRqZTJfNtkfv6kGaqV+Lh9TpwgvuDBCO
 fFbDDMnOZWaKJUN63rxmdn+bnewPGH3F79RqFDikX0dj55Jv4niX91HLCFWIxsP1TpOZ
 BnE3X+gctoS7a55jAJVWitemWi2Gvodvqv7ZpYwGks/262ZAfBZ+mS6xWfM5zBhChwFW
 CY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676323; x=1762281123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IaTjF09SMgISnzDEeFqSTFyM00Tszf9mX6IdYxJoDH0=;
 b=YDdkzPJAoKGVi/9BQvx72fRqcd+RrmXtNhMc7LRo1LZt4BKxk+MCJaNHSRQ33H8HlB
 k7baID38QTAksUsb8MNgGTn9oe8XpHszTcqniGOehbE2IonewH6ZI9aWn8WbrK5y1JdD
 C9YsbbozGKCMef01DcW44oE+rmjMx/0tN1ZxTaknSurAJdxR3JqFnDg3BBAm19j1H1Cn
 qbjfASfyiytRWY56MHi5tEDR4Az5JTKm6HBWyPKEMo/5zqOeJGoxXmJZ2z4k09SGPmfW
 8ha5YLt6vVnJ6Fk7ZTAwHq3JWy0r7D0q6zab3KhsH84QyS2PqS2Fi1Y8yFi9S571lqvh
 2BbQ==
X-Gm-Message-State: AOJu0YxjzKQIMonwUG+MRi0x9OpBFfbtqgsFlqf28v4wSnogy03Aa/XW
 EZI39pU+w/JRrgcoRKJe3fbknVeiySqqxPT7ERfQdslsCoOcp3ob32vmvMX0uv3OFVnWQIZu+8U
 2JzhHS7U=
X-Gm-Gg: ASbGnctpsfwB4V3GALLenruIQ0zhytqfBQFIXrTAZ6sztkQQU2EaycYrDpB8HtZYFhb
 dkpBolu4bt9zjtsBehwIJrA+lYY5k2uDEQlxC2egZCRmxsTgiP19AwxAvRi4Pgj4h/wxvbpW2R8
 1Pn7Et/qv4/Ab9v3P1ww+v1iTnFx7ViESXZyRoOdwapbzcaLH3odax770OSFGPnJCSTWJuNxEmk
 UNtp5IrF+4g54mdkqx+v/rP+iqVrg3sD6bbq44IuXNyh8i9DFuXRzy/TCO5AdhUrSmf36GRIbhk
 LdHnEIOugXARPr1CaycDfGzkEIYnGzn4DqKY3y3/2x2uYJCVzDvtx7qfmoB86u9M5iCcpk3sARc
 Qqiaf3JrnwM98wKlxUJzP/ZtwQw38uOxQSxJqc1uuj+ELMcSsPcosrx7tB6niuiX1GArW5FYn4T
 yV8ZQP7Gb8cUGRPcrnvz1UhDmfZUnxJr1oncw1/GgaCdeIHvszvQ==
X-Google-Smtp-Source: AGHT+IGNoilMZftYdlFoABEz7HqlIZBlWvUUKsoIyM+4ZJE0nhNjCJZlyq17dqhndnBKugd6FhWXWQ==
X-Received: by 2002:a05:600c:4ec6:b0:475:df91:ddf0 with SMTP id
 5b1f17b1804b1-4771e1f0f49mr4024465e9.33.1761676323157; 
 Tue, 28 Oct 2025 11:32:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5773sm23558062f8f.27.2025.10.28.11.32.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:32:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 16/25] hw/s390x: Use memory_region_get_address()
Date: Tue, 28 Oct 2025 19:12:50 +0100
Message-ID: <20251028181300.41475-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

MemoryRegion::addr is private data of MemoryRegion, use
memory_region_get_address() to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-pci-inst.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 5841dfc4fec..d4adf782ca1 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -394,11 +394,14 @@ static MemoryRegion *s390_get_subregion(MemoryRegion *mr, uint64_t offset,
 {
     MemoryRegion *subregion;
     uint64_t subregion_size;
+    hwaddr subregion_addr;
 
     QTAILQ_FOREACH(subregion, &mr->subregions, subregions_link) {
         subregion_size = memory_region_size(subregion);
-        if ((offset >= subregion->addr) &&
-            (offset + len) <= (subregion->addr + subregion_size)) {
+        subregion_addr = memory_region_get_address(subregion);
+
+        if ((offset >= subregion_addr) &&
+            (offset + len) <= (subregion_addr + subregion_size)) {
             mr = subregion;
             break;
         }
@@ -410,11 +413,12 @@ static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
                                  uint64_t offset, uint64_t *data, uint8_t len)
 {
     MemoryRegion *mr;
+    hwaddr subregion_base_addr;
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
-    offset -= mr->addr;
-    return memory_region_dispatch_read(mr, offset, data,
+    subregion_base_addr = memory_region_get_address(mr);
+    return memory_region_dispatch_read(mr, offset - subregion_base_addr, data,
                                        size_memop(len) | MO_BE,
                                        MEMTXATTRS_UNSPECIFIED);
 }
@@ -510,11 +514,12 @@ static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
                                   uint64_t offset, uint64_t data, uint8_t len)
 {
     MemoryRegion *mr;
+    hwaddr subregion_base_addr;
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
-    offset -= mr->addr;
-    return memory_region_dispatch_write(mr, offset, data,
+    subregion_base_addr = memory_region_get_address(mr);
+    return memory_region_dispatch_write(mr, offset - subregion_base_addr, data,
                                         size_memop(len) | MO_BE,
                                         MEMTXATTRS_UNSPECIFIED);
 }
@@ -832,6 +837,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     S390PCIBusDevice *pbdev;
     MemoryRegion *mr;
     MemTxResult result;
+    hwaddr subregion_base_addr;
     uint64_t offset;
     int i;
     uint32_t fh;
@@ -900,7 +906,8 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
-    offset -= mr->addr;
+    subregion_base_addr = memory_region_get_address(mr);
+    offset -= subregion_base_addr;
 
     for (i = 0; i < len; i += 8) {
         if (!memory_region_access_valid(mr, offset + i, 8, true,
-- 
2.51.0


