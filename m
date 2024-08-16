Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707BAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezaR-0008LE-Py; Fri, 16 Aug 2024 12:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sezaP-0008BH-Am
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:13:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sezaM-0007ds-SS
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:13:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-428101fa30aso15664365e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723824833; x=1724429633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhHY2mwb1dwmyJC3ZOyMGrBB8Z2DIi78BFy4b8vQ1Pg=;
 b=eXWdA4c/ewN9lCK7I0lr1HAAcsNc9+bNK+hu4TBPHHktOPuIgX9sFsMxKZVYgPqZEa
 GlgX76b1pyXeqElpq3sgnTP13TvHPxuHLE7OrLHCfvQ4yEzH+GUqEZQjqgzn2w2v5+gz
 J8xt0xSTYojn2HD9F4zwr1gcDgGIy1tdqArrAw10TTbcSeMdV1c5nuISwb9APT3rImBC
 ohZ3PuXjEUIKAxQCtEPnjBZzAycB5opO3WIPFeZOBL/xriq+S9ewDvlnzdh/Bwq907v7
 Qq1W+8OXRG5kmTkFrfOOQL8FAcRbB01aXU1OHwpAmAVH8hlcMAdZFzBHopK4BF1fFCPR
 BnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723824833; x=1724429633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RhHY2mwb1dwmyJC3ZOyMGrBB8Z2DIi78BFy4b8vQ1Pg=;
 b=kjAilZK6CEPun1fZUBfPpw9C10fwLQpgCDZ35GmJXJcQGoe7758qR4oLZzClrtf+MT
 BOZ+Nb4oCC69nnHr0EuZe6d3FG4dccys63swnr1OrhwT63Hl3sIE04l6Vgqq6pLolmsP
 XuUZGn0h1IMg9x7+RDAmhfWdW4+sKbebobKaS79BOsFaE9rFf4WqOVsf/qdH21LZtDRH
 L+AEyIMl0UERy3vh6jFGO5zhv6lzBxvXc7QBS0yuvWKxTM+mJXumvb95BxYzQiZkGA2B
 JR023k1ake2uFaN+dNApcOflBuBg/8YqhoKkJNmodx5ds7NPmi1cui9sUapKY+uBxLEt
 YN9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSYARKjmbAHBLg3xeIvceQuKqBFJB0DWzbYciTmX3XcV+d2bX2hSbIrkz8NA2gFPX9ps2XANxD7xZRqjyXBQJyDcoPoZc=
X-Gm-Message-State: AOJu0Yz1wdwiLpUiL/dHq45LTlAZgL/J2bjOk2tB0gHiKW2oZv9byjqh
 Du4ax4yt9bD6A0vsKWm4QE6aPHcrdGDt9BBcI5acuFCjGBTFDmJL8i1sjz8puiA=
X-Google-Smtp-Source: AGHT+IGng8vqkM+NNqGzGYSX5euov/zftirVpPInK9sZqGHfVBHq8bkM8WEGQqJL8phJoVM7LB1ndg==
X-Received: by 2002:adf:fc44:0:b0:371:7e73:de6e with SMTP id
 ffacd0b85a97d-371946897d8mr2727433f8f.52.1723824833475; 
 Fri, 16 Aug 2024 09:13:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898bb588sm3912269f8f.115.2024.08.16.09.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:13:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 3/4] hw/arm/virt: Default to two-stage SMMU from virt-9.2
Date: Fri, 16 Aug 2024 17:13:49 +0100
Message-Id: <20240816161350.3706332-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816161350.3706332-1-peter.maydell@linaro.org>
References: <20240816161350.3706332-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that our SMMU model supports enabling both stages of translation
at once, we can enable this in the virt board.  This is no change in
behaviour for guests, because if they simply ignore stage 2 and never
configure it then it has no effect.  For the usual backwards
compatibility reasons we enable this only for machine types starting
with 9.2.

(Note that the SMMU is disabled by default on the virt board and is
only created if the user passes the 'iommu=smmuv3' machine option.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h | 1 +
 hw/arm/virt.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index a4d937ed45a..aca4f8061b1 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -134,6 +134,7 @@ struct VirtMachineClass {
     bool no_cpu_topology;
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
+    bool no_nested_smmu;
 };
 
 struct VirtMachineState {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a5d3ad9bf9e..7934b236516 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1408,6 +1408,7 @@ static void create_pcie_irq_map(const MachineState *ms,
 static void create_smmu(const VirtMachineState *vms,
                         PCIBus *bus)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     char *node;
     const char compat[] = "arm,smmu-v3";
     int irq =  vms->irqmap[VIRT_SMMU];
@@ -1424,6 +1425,9 @@ static void create_smmu(const VirtMachineState *vms,
 
     dev = qdev_new(TYPE_ARM_SMMUV3);
 
+    if (!vmc->no_nested_smmu) {
+        object_property_set_str(OBJECT(dev), "stage", "nested", &error_fatal);
+    }
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -3308,8 +3312,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(9, 2)
 
 static void virt_machine_9_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_9_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_9_1, hw_compat_9_1_len);
+    /* 9.1 and earlier have only a stage-1 SMMU, not a nested s1+2 one */
+    vmc->no_nested_smmu = true;
 }
 DEFINE_VIRT_MACHINE(9, 1)
 
-- 
2.34.1


