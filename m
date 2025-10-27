Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258D6CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQTd-00016e-OM; Mon, 27 Oct 2025 12:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQTb-00014f-Jv
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:53:47 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQTW-0000zP-4m
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:53:46 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso3325534f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761584019; x=1762188819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFkZ8cP0wnsdBStuh/7APRD6ZJ8clBhIjPmasqtC2Tg=;
 b=vWR9iS+nznLuQE05XqEc1z0+lwZyB3gma02z6b1JpF2uaRBoOO6N5MjNvoZwOovvpT
 aNrtnzejm3KTuWEFeqN9xQhXD4AUL8MP4cbyyxB198euOxyqxbbzaqk2U9BAn8lGnHBs
 HXEzxfbERSxGE2X0I0BLziGfmaYPZ4ejmGFw7gwV8B68HC4aVKHrKDh90U1lDoMHCptD
 GpW8l4RYDSa9g8JKRIa9ucb/CSJJBUYSbvBIqjJVQZrOc7ToQ0wkXhHmzWCUMs8QbDOn
 iAYmimUF14jxgkvl7HQQQU/iRVEfUrkbfssUnrY8WqoR01/mmOZJM0Yu7lavlUY+MH+L
 Ef/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584019; x=1762188819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFkZ8cP0wnsdBStuh/7APRD6ZJ8clBhIjPmasqtC2Tg=;
 b=F+5PoI5cpe/+p/QiNq5F2XToN49EKFBO+lUmXlIXURS5OrITcpTap38mh5eBUJRnsy
 I/PLLrCDxx9XF6eW7D674pl4I+HZdZKBxbEcjiWtNwrXf/aAmlKcz4EWKbjuycko8AIE
 CwfczalnTZCPJDB1D+H8TUIv0Idx77li4jeql1NQHZmfi3j9Cr3130Mc/cG5FMyVslY/
 CMBR8+C7rHOd+/5bEZrtSmNKbr3eQfXzSsSjF3BeYnOtVFchKQi8RF/+Nm2FUQMucJui
 UNXQDUwBkPt7gkmlj69abNqt2gKZzaxrRlcIb+yB04F2ljUiGmUUrQWT9x+ppbrJeb9t
 v2ng==
X-Gm-Message-State: AOJu0Yxzc/jZtizYkhlHK8DemqiiPz3LYamK/w2cS17mSM22mhZTbhHJ
 5LJCfKLjtqhlyZZd33GHFt1B2naVLEHc1sgAwDlapVFVbLHxd1uYwwCR5Eww/ikwNKNSBZGWfkp
 oVYL2mdI=
X-Gm-Gg: ASbGnctlST6rfzbSmaL3yiiAhoJfKfUA16uhRa5jz+N8VEIXCMJRBrIcMRStfm8mUQ1
 rt6c248HUyTrvTM8Vg/W64g9SuKm57+sK6Q5N2Eo0v0G4UeFdlIeKwpTZ8atYV4DPFdgbC3a0gf
 VEceGYyDr3jKTrtP2+VTrMEGqyp+LUp6H/MDUwKCnVvG9Goiyxzza6IFBzsI5Z4qyH5PGZ53SRf
 Lvu6gGQX5pzPwWtSgjiPckbr9ni8zlEgQXHXtjB0uSr5pf2OBPtcyi9kZIjEQJj+pySHBDGR0Oq
 7ayNuoJSwUeAd4fSz1bxAd/GSRNgTNalDpoq26ZCmDwdyNA0vH5H82QSdThDo5chPkUKIupmwJ0
 K1BVHjxhikkAqPcqPdI86W70+35ZCAOfwWRFzwM5Zm8b+RLgEu+SY89T/Jma2G4983m/GGx/yJr
 M0WzOSrGLEXUzdk+bNmWaygd1rNQxxXMbvmKm5djztSBtKrsqHV75ffoEtH23F
X-Google-Smtp-Source: AGHT+IHXgATrce5pT0NQoZmgLmWFFPbMFW79b/gq4AcusqnA4li82KMNpxHk2jiw7g0BZTEuqnSHKg==
X-Received: by 2002:a5d:64c4:0:b0:414:6fe6:8fa1 with SMTP id
 ffacd0b85a97d-429a7e7699cmr329468f8f.38.1761584018851; 
 Mon, 27 Oct 2025 09:53:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db9d1sm15064456f8f.35.2025.10.27.09.53.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 09:53:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/7] hw/pci/pci_host: Add 'config-reg-check-high-bit'
 property
Date: Mon, 27 Oct 2025 17:52:57 +0100
Message-ID: <20251027165304.98296-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027165304.98296-1-philmd@linaro.org>
References: <20251027165304.98296-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

In order to have more PCI host bridges to re-use the
generic pci_host_data_le_ops MemoryRegionOps, add the
'config-reg-check-high-bit' property (%true by default).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci_host.h |  1 +
 hw/pci/pci_host.c         | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index 954dd446fa4..c04a567ec57 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -43,6 +43,7 @@ struct PCIHostState {
     MemoryRegion data_mem;
     MemoryRegion mmcfg;
     uint32_t config_reg;
+    bool config_reg_check_high_bit;
     bool mig_enabled;
     PCIBus *bus;
     bool bypass_iommu;
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index b5c624e12e8..d6db365e327 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -184,8 +184,10 @@ static void pci_host_data_write(void *opaque, hwaddr addr,
 {
     PCIHostState *s = opaque;
 
-    if (s->config_reg & (1u << 31))
-        pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
+    if (s->config_reg_check_high_bit && !(s->config_reg & (1U << 31))) {
+        return;
+    }
+    pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
 }
 
 static uint64_t pci_host_data_read(void *opaque,
@@ -193,7 +195,7 @@ static uint64_t pci_host_data_read(void *opaque,
 {
     PCIHostState *s = opaque;
 
-    if (!(s->config_reg & (1U << 31))) {
+    if (s->config_reg_check_high_bit && !(s->config_reg & (1U << 31))) {
         return 0xffffffff;
     }
     return pci_data_read(s->bus, s->config_reg | (addr & 3), len);
@@ -235,6 +237,8 @@ const VMStateDescription vmstate_pcihost = {
 };
 
 static const Property pci_host_properties_common[] = {
+    DEFINE_PROP_BOOL("config-reg-check-high-bit", PCIHostState,
+                     config_reg_check_high_bit, true),
     DEFINE_PROP_BOOL("x-config-reg-migration-enabled", PCIHostState,
                      mig_enabled, true),
     DEFINE_PROP_BOOL(PCI_HOST_BYPASS_IOMMU, PCIHostState, bypass_iommu, false),
-- 
2.51.0


