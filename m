Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4675D6C28B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDTj5-0002jD-3r; Tue, 19 Nov 2024 14:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTj3-0002iP-3z
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:25 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTj0-0007cy-Eu
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:24 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7245a9d0e92so4569714b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 11:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732043841; x=1732648641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhW2FSBGXHAYwMA8dkq4vzQjZXR1p5LWWIboLCYp7gM=;
 b=kgXhaalxDbdN+2294Cpb68Lqq31/3YTRGZL0fHHqcf62HwgUfoFjVL+V+Q1MP2JNaZ
 v8PB0tjcTsT6Uch2OH2HPs1NDqOqAh+QGUZrOhuFP80o/jqHvktPFuBfA+SINWPQ8UPu
 tdSVznkKaBqTkjyFe5BkW63URcm2MOlezfhT3h7KFsp6AW8CJteT79EnEbNtCeK0RkSq
 0agOAQZEoYeZp8zZNtRv5wggb0nB9lR81mGPMr+53GocZvfTE5oaD6ajBS9UVgX5wLQ+
 vKB2NAFcCJL5plp0WsmRuYNuH0oLh6a4x0xcNwvhj02Kq/iT7IWtmLBdpkt41mm14TzG
 trDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732043841; x=1732648641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PhW2FSBGXHAYwMA8dkq4vzQjZXR1p5LWWIboLCYp7gM=;
 b=fXnOfzDguzmIhW/XjcpjcunjZpwkU1frn6eln97m0T9b6YY03xo4rYsQ6NXu5+IIGS
 kMxjMRBn/dJTCIrIsn8wJATWibRY58QUPVSXRxrWrDQxAPCXfq1vAHmM4n88D1mRJd0f
 psiTx42xjLZy5Oq0h+EqbybXlu42hXqcJkV27f9phRrDjpDHOuU6L8K3rVsHmSH/5XBR
 gGix+hNkO0daPEmWgUyYIWxEQq2Eze8FTY8PwySgWqiAwrEgg1GlwemdMx/WoEzAEiKe
 uON1BZTWvkt4PMVJcsAhLVW3DNOYRtTYBJ1MwwyHMfkUfm+LmOuLzut0wSJ7HC1RVlvb
 yT5g==
X-Gm-Message-State: AOJu0Yw0OgB10iHkQ9IRJAAOdG+M7C99KNwIEL9n67RUdykd9Xn4gmIe
 lsvXqugA85CM/kAdaQZIhWENZUn/wtYwwakyV9JKY4VGn2kXbsMPFD7oF+ELu9qnDqxwYjfqp/r
 s
X-Google-Smtp-Source: AGHT+IEwV+X94YGX7mnZrhjl05S8fc22Mo52WJsdy3gaIxYje7r5rPbvAxwB/Uue7WskqyX75pIbWQ==
X-Received: by 2002:a05:6a00:852:b0:71e:4c34:e294 with SMTP id
 d2e1a72fcca58-724beca52e9mr131079b3a.7.1732043840589; 
 Tue, 19 Nov 2024 11:17:20 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724beeb82f2sm24271b3a.35.2024.11.19.11.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 11:17:20 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 v2 3/8] hw/riscv/virt.c: rename helper to
 virt_use_kvm_aia_aplic_imsic()
Date: Tue, 19 Nov 2024 16:17:01 -0300
Message-ID: <20241119191706.718860-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119191706.718860-1-dbarboza@ventanamicro.com>
References: <20241119191706.718860-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
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

Similar to the riscv_is_kvm_aia_aplic_imsic() helper from riscv_aplic.c,
the existing virt_use_kvm_aia() is testing for KVM aia=aplic-imsic with
in-kernel irqchip enabled. It is not checking for a generic AIA support.

Rename the helper to virt_use_kvm_aia_aplic_imsic() to reflect what the
helper is doing, and use the existing riscv_is_kvm_aia_aplic_imsic() to
obscure details such as the presence of the in-kernel irqchip.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e200fc561a..12176ae871 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -58,9 +58,11 @@
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
@@ -775,8 +777,8 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
         *msi_pcie_phandle = msi_s_phandle;
     }
 
-    /* KVM AIA only has one APLIC instance */
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
+    /* KVM AIA aplic-imsic only has one APLIC instance */
+    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
         create_fdt_socket_aplic(s, memmap, 0,
                                 msi_m_phandle, msi_s_phandle, phandle,
                                 &intc_phandles[0], xplic_phandles,
@@ -1565,7 +1567,7 @@ static void virt_machine_init(MachineState *machine)
         }
     }
 
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
+    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
         kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
                              VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
                              memmap[VIRT_APLIC_S].base,
-- 
2.47.0


