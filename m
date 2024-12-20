Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246F6E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSF0-0006Ko-Nm; Thu, 19 Dec 2024 20:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEm-0006E0-GV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:34 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEl-0004SN-4I
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:32 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7fd5248d663so1017816a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659729; x=1735264529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfBsTLHHJAqAyiojHCc+AdM1qTiCchVJT8tynBYysmo=;
 b=e3yEl/kBGLxh+47eZ6tzFXhhwhP+8H0FRaDuutw4VSRZYKUlpc/E1/vsWZv4GMI2Qs
 fpWs5ZC1xHQdIlP8VyoNP7fsTNVYwzmWDI4p2caz0/KWcG/nB2yy64DMxEM0B41+bna5
 6vIk+G4bnNj5zyB/i1YZSmSZEVSY8K7KapC1FQ0goqbmelpYCloI2iH/+U5sVFwh3nRR
 HlRlCzsYmTYiCNa7OPmRLvOC1J4u5JrAcmoRjl8D3cFR//Dz30Lb753mszWcJi/6pQ6g
 ub9+90lje9nI91I7NcNl3YbN0gKf/KYS1zecZZz6rjt3LfQI8ipiZL0PSXgPksIdX6SC
 9rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659729; x=1735264529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfBsTLHHJAqAyiojHCc+AdM1qTiCchVJT8tynBYysmo=;
 b=Na5yrw0Sd8pOjmTIUvfZUBz5u/qbQwmCHr/Vb9TR3XDxHWWR/ISZ3HR8T2CPXXSYfh
 3DefYKRIckHkNg7RHIpuWJIKPJAKJvjk4mXlnpPLbT36YEdFzaQdgo4pq/bGG7iu04ID
 lzWm/CjAKuGTXTgGW/qKMKEKIsg4eXhas3bJ+LVgKLe2JsRf8Ofn5W6Dp/3sIsnyx0m+
 0VO1qvYlBfPoijmFqPVU6Xp/keO2Vh8f+THv9NDudPU8QhigUzcPnmf2j0SDCrW/4uaz
 Bs6aufkwtOaLnuFWjsZMjiBDETFTw2wozZiSTXrBHA7oBRR/XPa77qdTllFaPByZIs7K
 UZxg==
X-Gm-Message-State: AOJu0YwCtA8SdnzQ8t/Oazlbae7sopOUzn7ehkgrF37qpGm+U3JWjUo4
 kblHcxIzuhuKC3sUK+txDgFKh62cilN1NsLFsJu5hazBn76Gpjnh93fHO+VE
X-Gm-Gg: ASbGnctWq7H+FZRpepUz+4g9aGRVePtrUwBe8TRXBrs2cZlFpvCBIXM8p2Q5znFOKnk
 f74MBojFBwv30gu2mzwoLX80aGIYwWALMLHHoQ2apI+VhvZq56k5lzn8V1C1sQ/Wd3NrlUS4KXI
 61J67MEdAT5R8Xy8xkxWYseTwUaOQQ6OpiDCECTEqYYSe11vEIc/gqypjYS2wipTq3PlHg+vKSF
 rwr9Esl2h+ZlHD2uTmmzzcIJecdgjboMgD/0BKhTW1H786kDNY5bNDwZVZyjXDYaF48oIMwcAo1
 eoyFDvvwQOurnMSqhPN78d9/ZGAKT/XJEiX6vtQ0GTqE2l/YxuD/eLt913KSg7s=
X-Google-Smtp-Source: AGHT+IG9xXl1SiEo1evshAGnIVFmtlg/zxAwzH5YihtuW9GTn3LshUFKe2KTP/nbmj7fZ0ezECzpiQ==
X-Received: by 2002:a05:6a20:12d2:b0:1e0:c0fa:e088 with SMTP id
 adf61e73a8af0-1e5e059b19cmr2305283637.18.1734659729528; 
 Thu, 19 Dec 2024 17:55:29 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:28 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 12/39] hw/riscv/virt.c: reduce virt_use_kvm_aia() usage
Date: Fri, 20 Dec 2024 11:54:12 +1000
Message-ID: <20241220015441.317236-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

In create_fdt_sockets() we have the following pattern:

    if (kvm_enabled() && virt_use_kvm_aia(s)) {
        (... do stuff ...)
    } else {
        (... do other stuff ...)
    }
    if (kvm_enabled() && virt_use_kvm_aia(s)) {
        (... do more stuff ...)
    } else {
        (... do more other stuff)
    }

Do everything in a single if/else clause to reduce the usage of
virt_use_kvm_aia() helper and to make the code a bit less repetitive.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241119191706.718860-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5d058511be..e54e1257c0 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -783,6 +783,10 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
                                 msi_m_phandle, msi_s_phandle, phandle,
                                 &intc_phandles[0], xplic_phandles,
                                 ms->smp.cpus);
+
+        *irq_mmio_phandle = xplic_phandles[0];
+        *irq_virtio_phandle = xplic_phandles[0];
+        *irq_pcie_phandle = xplic_phandles[0];
     } else {
         phandle_pos = ms->smp.cpus;
         for (socket = (socket_count - 1); socket >= 0; socket--) {
@@ -800,13 +804,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
                                         s->soc[socket].num_harts);
             }
         }
-    }
 
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
-        *irq_mmio_phandle = xplic_phandles[0];
-        *irq_virtio_phandle = xplic_phandles[0];
-        *irq_pcie_phandle = xplic_phandles[0];
-    } else {
         for (socket = 0; socket < socket_count; socket++) {
             if (socket == 0) {
                 *irq_mmio_phandle = xplic_phandles[socket];
-- 
2.47.1


