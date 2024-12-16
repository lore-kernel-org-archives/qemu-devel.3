Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A17E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 00:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMzJM-0001Ry-76; Sun, 15 Dec 2024 19:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tMzJJ-0001OX-LZ
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 19:50:09 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tMzJG-00078g-6f
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 19:50:09 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-725ea1e19f0so2910193b3a.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 16:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734310202; x=1734915002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0oPxPHNXebmd2yYjjqR5HgsogRG7IAY4swP2rcEypRg=;
 b=Y7ZlbFodL/B/qZgoU4q8J7NLqnVW809NykVvkjF8zL6JuHQQgfOAZeyz6SQPs+Ggrn
 gLhgOpub5AkwoY1XeFILSp15v8YS3kakXu5DdI79FPNTPoMVcTZSJBbgVaRDBMvZG/d4
 en9WxvIq7cdafhNUTQRS49gLoeg7QN58nvnt/p+0s15a2SnciomInVFWOW+X1Z8czNCX
 KGF/4Xi4imP6LSb2Hxw1VJfJZEDb5fvwWJfXiaLNQGEUClwBdxi+bZYvY3PHEiNwShX2
 4IXpJ/NhgPwlZdT1vzUUFaCFt4KDMBA68sv3rRxgOiuTkxlyYJTPKOrtY8nPsMNIJaRW
 CztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734310202; x=1734915002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0oPxPHNXebmd2yYjjqR5HgsogRG7IAY4swP2rcEypRg=;
 b=Ml50Xz2btgpigEUwzUgrc4oK1lYLGrs30n/9ipommaWfDRu2hy2GtORhI1/4McpJIx
 8jgN8o5Kp4JSJMefdWgUwhrQLxBJwjBK+RsKMWeMXiHdZ6+FdbtcIJR9wOIZi7QtJvQR
 s79ZMhJ556jd7QLkdaJBCK8NK1YHRGtUK9UuC+G7KHb+SbbURiQLAOgyCqYy21WuJ6IB
 JsL9GcL28+Aux41maAmnAF1X/5ojvwMUb9Vnd1pWc/71/lwc1FqY39lodFWPIdciirno
 TGQL2EwBdEPrnHbeQx1FlLYSBzJg/HjAmbCUrQiyFMBDJWNm/c1RNvfTMJcqnyC6X112
 6lOg==
X-Gm-Message-State: AOJu0Ywxjbw44GWUgcH7UniaSphi2pjTJmy9Z8pQjih6iwaChr0BAr1/
 +RgsfWCOT1Yxqwb3QkJIC4QOuWZxVJJ3UaeesKETndbqEOtLhVWZhVmo1WymLhigtrohLZSzeX9
 BAlXhW0iKC8d0za/j/iqzFugP6EmXPmXbcZsfWNBUzQ99OP8MSf+3T1aQr9CSr4W32EOz+FIEUv
 c4Xm9sFwx27TUcjwh02tsjtbkHeK/u0T+iaoViYV86WBvYJV8=
X-Gm-Gg: ASbGncuTuaBgf1bpPjvQnvNzsYppJ6OcXV6emNfg3xFrZZ7G7tiyih4+6lmquBwPWcr
 opUjd2HVfgWunwm8PHSCeJAIgqH9FilNJd6JTE4VEuReeQAEU0Z9MVgQZktDimvivdL+YxkJHzJ
 C6l+2cZrjlToyFLoAABpwK1bq7Z9cN/5rH1GU1+PE3pMm1vQNucGdU6+s9xmIZuGrrZnaqzDsTS
 FLCUy9FouxJ1Oe6aGvow7BcazU3N38fh5sFzHChFUwDSbNn8SNnxmmQ6Sw7pIAL3x5HjPkWYqlc
 s0hLd52M
X-Google-Smtp-Source: AGHT+IF8RC/+GZEDclJJCvf6VzrlYKa6blK5F29amI6V6WQnB5TzMJSe5092EESxCt6acxqa4ez+BQ==
X-Received: by 2002:a05:6a21:47c1:b0:1e1:e2d8:fd3a with SMTP id
 adf61e73a8af0-1e1e2d8fd4cmr13975584637.35.1734310201680; 
 Sun, 15 Dec 2024 16:50:01 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5addbf9sm3059586a12.47.2024.12.15.16.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 16:50:01 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org (open list:MCIMX7D SABRE / i...),
 Jason Chien <jason.chien@sifive.com>
Subject: [RFC PATCH 5/6] hw/riscv/riscv-iommu: Acquire device IDs dynamically
Date: Mon, 16 Dec 2024 08:48:56 +0800
Message-ID: <20241216004857.9367-6-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241216004857.9367-1-jason.chien@sifive.com>
References: <20241216004857.9367-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jason.chien@sifive.com; helo=mail-pf1-x42f.google.com
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

When all memory transactions from a PCIe host write to the same IOMMU
memory region, we need to distinguish the source device dynamically.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 hw/riscv/riscv-iommu.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f5d53a36b2..e4b7008306 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -48,6 +48,7 @@ struct RISCVIOMMUSpace {
     RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
     uint32_t devid;             /* Requester identifier, AKA device_id */
     bool notifier;              /* IOMMU unmap notifier enabled */
+    bool dynamic_devid;         /* Acquiring device_id dynamically */
     QLIST_ENTRY(RISCVIOMMUSpace) list;
 };
 
@@ -1184,7 +1185,8 @@ static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
 }
 
 /* Find or allocate address space for a given device */
-static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
+static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid,
+                                       bool dynamic)
 {
     RISCVIOMMUSpace *as;
 
@@ -1203,6 +1205,7 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
 
         as->iommu = s;
         as->devid = devid;
+        as->dynamic_devid = dynamic;
 
         snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
             PCI_BUS_NUM(as->devid), PCI_SLOT(as->devid), PCI_FUNC(as->devid));
@@ -2415,7 +2418,8 @@ static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int devfn)
 
     /* Find first matching IOMMU */
     while (s != NULL && as == NULL) {
-        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));
+        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn),
+                               false);
         s = s->iommus.le_next;
     }
 
@@ -2438,11 +2442,10 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
         pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
     } else if (bus->iommu_ops && bus->iommu_ops->set_memory_region) {
         /*
-         * TODO:
          * All memory transactions of this bus will be directed to this AS.
          * We need to distinguish the source device dynamically.
          */
-        AddressSpace *as = riscv_iommu_space(iommu, 0);
+        AddressSpace *as = riscv_iommu_space(iommu, 0, true);
         pci_setup_iommu_downstream_mem(bus, as->root);
     } else {
         error_setg(errp, "can't register secondary IOMMU for PCI bus #%d",
@@ -2453,6 +2456,12 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
 static int riscv_iommu_memory_region_index(IOMMUMemoryRegion *iommu_mr,
     MemTxAttrs attrs)
 {
+    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
+
+    if (as->dynamic_devid) {
+        as->devid = attrs.requester_id;
+    }
+
     return attrs.unspecified ? RISCV_IOMMU_NOPROCID : (int)attrs.pid;
 }
 
-- 
2.43.2


