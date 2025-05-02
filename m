Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F6EC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvar-0007LK-Q9; Fri, 02 May 2025 14:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvad-0006Qv-Tg
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:28 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvab-0005el-MT
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:27 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aca99fc253bso369738166b.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212302; x=1746817102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABC8+QfGyso1WyDvOcXI+0OZWgW+TnNwcrP3jxKT+bs=;
 b=RL7w98xih3fjFfElmNHdixUCO/AJpZ3/GBJBsKCH5V9vcGXmN/KbnRktUVkQVeONRT
 L427/3QkkRGhV4mlJDosO0OFuEuOZsngS5X9Nh9bEtwU4nugPCABfkD+4N+vqajdaEje
 vNQmtfhaYyHuT31FxKWIMcccbQAxP4LONbGWnutZYm46N6N7fS315o6QgnwCJni6x/bB
 ysIrml2BayGqWVFKLEq02SHakh02tRWMCB/s2Uu0xfaxs8YHCVNb5XWlOADX/Dgua4st
 knpD/GNqgneVrks/Vhn39t2AqIu7QB+wk6xlGIN+oUm5GVk+bUoNK+kiQMjwnhO5WybP
 earA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212302; x=1746817102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ABC8+QfGyso1WyDvOcXI+0OZWgW+TnNwcrP3jxKT+bs=;
 b=kySE8vy/LpXYFO/rEYY8ySCCi/8+n6z0Iveilx3ViBmJZh7emahFT9obMZ0360kJyi
 w8NOVI+mXRcNyGUZoO98MFVGFXFgmzXzp3/g3NAB0oLI86E4SdWbanTQZHx8uPbp/GHr
 B2yb5eFUb4gBeOZ609k9Sy2sqweW/k9Lrh74cBl78owuxzEe9uTorCN+bt7Z7WlSwbwU
 c55W+jPFJ+gIVTWVtybTC7ecXv2vAmerYMKaNNs9tbs+T6S26paO/JK5KDS58OE40GHD
 A8QZWwfG2UJu/YwdoTcoAAxHdxHrPwI3CLm5kvbAhFxUs17L3KuJs4WT+IUsJnmsZAUZ
 dgig==
X-Gm-Message-State: AOJu0YxGUn5ZybNd7Zgv4wOuWCXeVePWBqTDyVuvXV4x0ic4F56Rc8KF
 j4omUbQZt5F3KoZxJJ5VZZLXOB8D5uaj+NVIuO5UGUWwK+ogpgpeMb8cT8xx965D+yRWaWl+gB1
 Q
X-Gm-Gg: ASbGncszMPZDduNccekIVqzY/4WNO0tP+IvuucckvBk/atk0KVA185H1Np0USt4Bo30
 D+h9y6iAwR8Egd52eepHou2s+sxGx4gBnYiDvQkuc+O+DVYVRUNlidruE/5CD/i1K7dZNLLZmBj
 CzKdgAuUFpBDVK49etSTIfnMlsKoS7yP6gEclZo5jiys7/ILGzMvruahkdElh3z2iao8Dram7aK
 D+YCugSLk+nKcPFSGj196c7+svk730TzrEva0I6BNnY6omacMOpUaqosM4RUoFfV+vuRgYOK4PI
 L/QJzOfwQ4/bDF0qiY0xluN6F8eqvQY0VtWbqLCZ4xtXMXGwqF/WWFN8vLnBTJ3bgiupCg7lvwC
 GiMJeu73eru/Ghy6da2ai
X-Google-Smtp-Source: AGHT+IEa6dQWqraimJIsF2zuuhgShfG2AxC1Jl46LPV84Msdt0/W0Ub0k1nlQBHreLFL1jBlNVLYyw==
X-Received: by 2002:a17:907:94c1:b0:aca:d6f2:5d5 with SMTP id
 a640c23a62f3a-ad17af8f6famr328521366b.39.1746212302362; 
 Fri, 02 May 2025 11:58:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad18950830csm84058166b.124.2025.05.02.11.58.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:58:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 15/19] hw/i386/intel_iommu: Remove
 IntelIOMMUState::buggy_eim field
Date: Fri,  2 May 2025 20:56:47 +0200
Message-ID: <20250502185652.67370-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

The IntelIOMMUState::buggy_eim boolean was only set in
the hw_compat_2_7[] array, via the 'x-buggy-eim=true'
property. We removed all machines using that array, lets
remove that property, simplifying vtd_decide_config().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/i386/intel_iommu.h | 1 -
 hw/i386/intel_iommu.c         | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index e95477e8554..29304329d05 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -303,7 +303,6 @@ struct IntelIOMMUState {
     uint32_t intr_size;             /* Number of IR table entries */
     bool intr_eime;                 /* Extended interrupt mode enabled */
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
-    bool buggy_eim;                 /* Force buggy EIM unless eim=off */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
     bool dma_translation;           /* Whether DMA translation supported */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5f8ed1243d1..c980cecb4ee 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3823,7 +3823,6 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),
     DEFINE_PROP_ON_OFF_AUTO("eim", IntelIOMMUState, intr_eim,
                             ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
@@ -4731,11 +4730,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     }
 
     if (s->intr_eim == ON_OFF_AUTO_AUTO) {
-        s->intr_eim = (kvm_irqchip_in_kernel() || s->buggy_eim)
+        s->intr_eim = kvm_irqchip_in_kernel()
                       && x86_iommu_ir_supported(x86_iommu) ?
                                               ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
-    if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
+    if (s->intr_eim == ON_OFF_AUTO_ON) {
         if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
             error_setg(errp, "eim=on requires support on the KVM side"
                              "(X2APIC_API, first shipped in v4.7)");
-- 
2.47.1


