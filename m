Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599EFE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2ZM-00038W-B6; Wed, 18 Dec 2024 17:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZG-00037P-0a
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:58 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZE-0003F8-BU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:57 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2164b1f05caso1577605ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561055; x=1735165855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9kGRz8yBDn3xNhaRpjl5eLNif1NBmGaYms609zt52g=;
 b=UQy8oaq1Q+IynoiIYPpZqXz/BWX0OjcMh3zT900ELNARF/+MCHa/uZpzVFyyI2FqRh
 KSuzHTc36RYDO3WuzA2s+AbNkMIFWiA17ao+uSPuGI7nawl7dg8iY6qRwMN9qSMahyJm
 ZH6lxwQRe3F9RmF+fPUjQ2ijId8NZwD9aFPqktsKrXZTbOPdhSEJ9A1aBPfFCrNq+FXL
 6tbWNevCLXrC/q//Sg/cjJQr5G1xVdGAjqmCzrZTIbjy07ADMOty9eflXhEK3nnBR2pB
 GJBXjZBSKT8yCVEmMvLmbFM/2oOPeLTF8GAktKfij3nllJJNkxW33xasBpvmlhWjiZzJ
 YoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561055; x=1735165855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9kGRz8yBDn3xNhaRpjl5eLNif1NBmGaYms609zt52g=;
 b=lX/fduyOkzDufWVP9QRvhygP3K7XdRfVqVSctyz+Il1jO0FVftds0V3U/cGXl72rTp
 JAXbF8hZJ1vj58LOhDTrL3lgg0yycqwaddl9peecxJbhPrJyiO/dRCE2CSE33QuJkoPc
 wtnXhuqa2FUbztNGggrRb7gE2z0VThhhq8YxnQt/vWsyvsUYgbn003PptI9I9LnSf0UW
 UkoDRWDljyzalHLnIMhWZesXSpR7uknLN7fhF3aUz4H5QdCryrs6yzP7GKYJ0BRwVGuS
 hrYWw9qWQdlqajEFEtkgt2H63lmbvyyG5RcQHaloTDz/i0YCKtBBbskZEQxGmG8fHOmm
 RWTQ==
X-Gm-Message-State: AOJu0YxDFVhxKalOcM2JMj9qi/PhHHKEpw9gEaeeNO4/ytwzF9q7WGx/
 0sypEe9dX3F8jvtrTvR3B0Vye3JYWJRrqqVRqF8s/eArnXsvJ0iSVUS/rL8/
X-Gm-Gg: ASbGncs62P2bUyM6/imHLeAsCegduBsnsbMQVF4xC2q09J6pQxM/xgmRVIfJwgo1N+D
 dV6CX1bAnveo7pURQvlxZGaFlaMDhPvptZTXmEb3gl3caFsHE/FMBhj4amlFpCTLcrp7o+9gsd1
 MKTQgRmj0GE7RwU7XnV5IcVLzFc0lLOAb4HHq4pi7PI/OJ5ylKunBAqRMVmN17i08amJR0aibyH
 0IMoeGtVbIu0QA5aHTC0O8dI+hDt/L++4UaqjdD4u0pJ1akdn8vjFUishwRxMDk7CEtkBwQ6Eyg
 KdC9L2ob8On28mY3E/JC1/bmYWm5C3LIhTLC0EMM5ScLGmePuVbya2HQxWm5ovM=
X-Google-Smtp-Source: AGHT+IGPqEWuwEry06U5g4/L1T2HfYDkIDdSkl3cm2TvsZtZroBSzVw3YdCJMzx+lc2ToJvExsZCVA==
X-Received: by 2002:a17:903:22c4:b0:215:5c1a:f369 with SMTP id
 d9443c01a7336-218d6fca33bmr62402215ad.11.1734561054867; 
 Wed, 18 Dec 2024 14:30:54 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:54 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/39] hw/riscv/virt.c: rename helper to
 virt_use_kvm_aia_aplic_imsic()
Date: Thu, 19 Dec 2024 08:29:43 +1000
Message-ID: <20241218223010.1931245-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

Similar to the riscv_is_kvm_aia_aplic_imsic() helper from riscv_aplic.c,
the existing virt_use_kvm_aia() is testing for KVM aia=aplic-imsic with
in-kernel irqchip enabled. It is not checking for a generic AIA support.

Rename the helper to virt_use_kvm_aia_aplic_imsic() to reflect what the
helper is doing, and use the existing riscv_is_kvm_aia_aplic_imsic() to
obscure details such as the presence of the in-kernel irqchip.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241119191706.718860-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e54e1257c0..a67ab80b16 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -59,9 +59,11 @@
 #include "hw/virtio/virtio-iommu.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
-static bool virt_use_kvm_aia(RISCVVirtState *s)
+static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
 {
-    return kvm_irqchip_in_kernel() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
+    bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
+
+    return riscv_is_kvm_aia_aplic_imsic(msimode);
 }
 
 static bool virt_aclint_allowed(void)
@@ -777,8 +779,8 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
         *msi_pcie_phandle = msi_s_phandle;
     }
 
-    /* KVM AIA only has one APLIC instance */
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
+    /* KVM AIA aplic-imsic only has one APLIC instance */
+    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
         create_fdt_socket_aplic(s, memmap, 0,
                                 msi_m_phandle, msi_s_phandle, phandle,
                                 &intc_phandles[0], xplic_phandles,
@@ -1619,7 +1621,7 @@ static void virt_machine_init(MachineState *machine)
         }
     }
 
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
+    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
         kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
                              VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
                              memmap[VIRT_APLIC_S].base,
-- 
2.47.1


