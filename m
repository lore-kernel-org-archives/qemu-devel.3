Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEABC61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLrK-0001sD-Ni; Wed, 26 Aug 2026 18:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLrJ-0001rv-RQ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:12:37 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLrI-0006cG-CD
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:12:37 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cc11a905ba5so1054682a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787782355; x=1788387155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yj3X6s5HDsl64/BQ6b/GU1IeAoNk6/eV2nZC5+pnfqY=;
 b=Bwu3V9yxyVLBPuBqmbXmyICv890UFcdWcZhLECPSFB50E2lmHAIAlb7Ktpg40Wtk+z
 MbmkoeJcKy/pQVcDOQLRalOSF99q/xtPNzAja4/6hnWFxZ3YszyaAiF8JyiyxIjR4nge
 F7LtxL2DyEd3JpPAzn8v8kL3teSE8SUSbf6DkLYdzkohlNap0znMe/9EE8D+7KaUH0mF
 VtD5iZbb1QV9aNyhivK4Pr0W38FmHxugmInO08cZDGruRllpfhw+ckbeu+qsd5DfA3zh
 EC498/8zUVpzLwVVrTuUEWOo9fcDXUt8sNIp4mOXxsCMlgF5imilyD6aIhU0bC2HL9Nn
 UmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787782355; x=1788387155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yj3X6s5HDsl64/BQ6b/GU1IeAoNk6/eV2nZC5+pnfqY=;
 b=ZNT5aMzVBe9QGf1+OXdoF0ZKfJsmriygDdl5h1wiEE9nBCd6SHqxe8FS2P0jk8GO4V
 nMFxXXbfa89Kv+dJNSR381P9BzxLu4yKMiy8cdc71+WFkZugs5+j+gbU1uHlVDjt7OYT
 FuuHvVlSeg8+LCEmmzUyHrnaBDxHT/9s5rRMIADULXwsSo5BZC+2p2Qy0EuE7kxEz91Z
 Lb1DDEBzha6li9mY9A7YJU4USPsSjjCLMe59/yQo83P+4wOhPwQEfxitLMlY72OWXZp2
 hqCE/Jqm45K0kzn1tlN5x89Ob+FYAmZA2/aO/wJSkes13mL4prUg7lp9lErPv9BOoeBt
 lyAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpM+mc3Zv5g3hmxpLQ5uXngkX28B97uimvpvf6uhJGEZOdZcV88D2fN7r7hN7K0ks0MVCvE6C6XXpvu@nongnu.org
X-Gm-Message-State: AFuF++nf8z0XwTkyGLhW0Jr57FcgWxjF1fOnAC+44LGo3eTb8CrpUTkG
 8ym9dtJAo5SprU+N+UeI+X5ROpM1IS8uEMQwFMwV/U++y36ay4hC7147
X-Gm-Gg: AR+sD12jAIvbEHMS5T05KotmDIQHbh3iOh+XWrGCQMiIE1PXbDDfl1Kc6WJuYk/ank+
 drR+IpMNpg1j55MecgfbRQoY8sCPbmOWl8QzQoRnhKVdfzDEqGx3iOB1jPp8PQ65vGEq4d0OvXh
 uYm0OF+kG2Ut58+5DS/p0LrU/B64CU20/stniP074M4Zjumv119ICzYbA/75ad/BJRFEGJ+Mzrz
 ujVv4gleGlSfN8uKeLzUvgEKpweclFhE5Ok9mmC6Jke9w9odo/sVzLHg0N4fQ7jmD7xqJkMxlb5
 PklpvS6a/1mixRyBk6OeTSE/TCLWqALhnkNUh4Esm7dRctK9+jLy/fnOSQaYsJvw1hX0UlGP4IK
 n8s54Jp7GGkFEKgRNZ4KvTr3oR4BPVlIlGQMn+W75RVi7MK/E/Zg5rVx1/B+37GyZUWOBRYhQhd
 c4HHQfEu2ANYnScf+r/ch6NBr25L5PSn5GIVukjgzxp85qsU7Qt4E1dxyCQTjFGTVTCrNSWF610
 edf6LdXIzZT3QdRC6zDvNOb6o+1iViDuXXaC6YsPnPEZokg5vs/dHRad0RyWN0rndYMxe04Urqn
 5jASo/KwZC7Pw1YGRLdP
X-Received: by 2002:a17:90a:d60f:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-3966d44aa98mr22082210a91.13.1787782355029; 
 Wed, 26 Aug 2026 15:12:35 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d3d7fbsm17459a91.3.2026.08.26.15.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:12:34 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Portia Stephens <portias@oss.tenstorrent.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 14/16] hw/riscv: Add property to hart to allow private memory
Date: Thu, 27 Aug 2026 07:41:50 +0930
Message-ID: <20260826221154.54577-6-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826221154.54577-1-joel@jms.id.au>
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826221154.54577-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Portia Stephens <portias@oss.tenstorrent.com>

There are platforms where CPUs have different mapping of system memory.
The global system memory does not allow for this. This adds an optional
property to assign a specific memory region to a hart. This allows for a
machine to alias the hart's memory to system memory while the hart only
views memory from its own memory region.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/riscv_hart.h | 2 ++
 hw/riscv/riscv_hart.c         | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index 197fa1623115..c3cd05a2c877 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -42,6 +42,8 @@ struct RISCVHartArrayState {
     uint64_t *rnmi_irqvec;
     uint32_t num_rnmi_excpvec;
     uint64_t *rnmi_excpvec;
+    /* Optional private memory region for use instead of system memory */
+    MemoryRegion *memory;
     RISCVCPU *harts;
 };
 
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 747754be6158..32fd39737ff6 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -53,6 +53,8 @@ static const Property riscv_harts_props[] = {
     DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
                       num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,
                       uint64_t),
+    DEFINE_PROP_LINK("memory", RISCVHartArrayState, memory,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void riscv_harts_cpu_reset(void *opaque)
@@ -117,6 +119,12 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
     object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
     qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec);
 
+    /* Use private memory instead of system_memory if provided */
+    if (s->memory) {
+        object_property_set_link(OBJECT(&s->harts[idx]), "memory",
+                                 OBJECT(s->memory), &error_abort);
+    }
+
     if (s->harts[idx].cfg.ext_smrnmi) {
         if (idx < s->num_rnmi_irqvec) {
             qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
-- 
2.47.3


