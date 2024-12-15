Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC02E77186
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu03-0003NT-FM; Sun, 15 Dec 2024 14:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzr-00029i-Tj
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:44 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzp-0001Ur-9E
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:43 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-71e15d9629bso679074a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289780; x=1734894580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dufLCBl9eHHxrnVCe/umUFhwRr7vI1lAGb7uckjuB5g=;
 b=FrxsOV6sPlzUG5xw0lanUMi/DdI/dWsBoY0MMySk0DesTk7us818CHXZXurIWxfUoP
 ovrtr52M4aCFJQaw8052+Cv2dOGkM6dPGB63Oe73Ksdsy7odPmRkz3ku4/nAVFeqabZ5
 d7JPXmqcciSk9Crh7MGJSQMtgR8S9a9PV7WQNtOFzz99/PR7drJwE4WTE6h9EsBIyS95
 6olsxJSuxKfqEamDx6Bql2abAjLoIf2CQkJxCjTLqJ5e7O1T2eTkPEPkN10aBXFFrY/b
 +JAOQdX9p0DzLCMvwkG3+aH+TVmy07OY8V45OENKnfLgXNgzFWJBfyODY3DtVjh7YLAA
 nwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289780; x=1734894580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dufLCBl9eHHxrnVCe/umUFhwRr7vI1lAGb7uckjuB5g=;
 b=Cj8Y4t33ja8xLx4Em04EBbVGj3BwPisQWhjA8ixp/d1vQQPN+inhvNm7zgvlnMt4iQ
 /jYLJelhh2ABCVJiNFP2jmce8BuVwC88ZdcHY4m9BwBZfBDQVfDRGuqsbOf7jOTeBgBa
 iqfUiHjJRdG6kShuivFEe7ByDDoAZezQYcWQ3AzUQDsonXr4oeikR+81tblxOU3oiJJR
 ggyCzTDOInHGE7S2tGjJ3OwaScYqduV38dNMAQiI3iYX05f/v0cUXCiWNlXafqZs/vQZ
 PyHfEz4sUBdbsso+DQr5Mu72fXvy6BKgHF9kDl+xbReP1jszlILBVZ+zdidPsG/shDi1
 KLTg==
X-Gm-Message-State: AOJu0YyUb+l96vaWDP2K4wWBGnSF/ECwA8SywCaRn38rzQD4ZP74ByUb
 HhrBY8a/KcCQqGd1HYGtgjQiAdYdKGpCuto5kRzCW2Lp1+v9fswCbMuT6QRDRc/yLM0bCw+vn18
 Ol32cuPAj
X-Gm-Gg: ASbGncvEDGcwKKJhIGREdxfVLRNWRNbL4ampxDtL50eA2c8ig22W+vVXMdr33cPXPQq
 SGI4V7dpWI8WOl4yION6qFt5uqudglt7smh+7dQp6+dlqXrPssS+SL5NRlS4kw/VuA+CldtqRp8
 DOyzK/IHc9guPmYqGjyeGlzNOwlyvJgdnkvfJYwoyKp3YXK1Qm8HQudwucLCS03G0/C9AgBSDEi
 ac8YB/uBXrPcIq2++IYqwchoK6kfufCjhZd19bJ34CsGuEPMm2FSN+grN/BEQPXCPVf3zkUrqOd
 Zt2bY6+iMmWc2MPbq2ZaFi9Ag99cZXpzcyBL4kTcERQ=
X-Google-Smtp-Source: AGHT+IHBgcKWEP5mjTn9NanEiFb2hid1d5r/+jJGvs8ryBT3D5udgPgmwaQluW7yUa9DPq73lwdeTQ==
X-Received: by 2002:a05:6830:6b07:b0:71d:fd31:25b4 with SMTP id
 46e09a7af769-71e3b816842mr5646412a34.3.1734289779978; 
 Sun, 15 Dec 2024 11:09:39 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 46/67] hw/pci: Constify all Property
Date: Sun, 15 Dec 2024 13:05:12 -0600
Message-ID: <20241215190533.3222854-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/pci/pci.c        | 2 +-
 hw/pci/pci_bridge.c | 2 +-
 hw/pci/pci_host.c   | 2 +-
 hw/pci/pcie_port.c  | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bf0a1840db..90248481b1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -81,7 +81,7 @@ static const PropertyInfo prop_pci_busnr = {
     .get = prop_pci_busnr_get,
 };
 
-static Property pci_props[] = {
+static const Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 2c7bb1a525..dd4fd3674f 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -477,7 +477,7 @@ int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
     return 0;
 }
 
-static Property pci_bridge_properties[] = {
+static const Property pci_bridge_properties[] = {
     DEFINE_PROP_BOOL("x-pci-express-writeable-slt-bug", PCIBridge,
                      pcie_writeable_slt_bug, false),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index dfe6fe6184..321e7be709 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -240,7 +240,7 @@ const VMStateDescription vmstate_pcihost = {
     }
 };
 
-static Property pci_host_properties_common[] = {
+static const Property pci_host_properties_common[] = {
     DEFINE_PROP_BOOL("x-config-reg-migration-enabled", PCIHostState,
                      mig_enabled, true),
     DEFINE_PROP_BOOL(PCI_HOST_BYPASS_IOMMU, PCIHostState, bypass_iommu, false),
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index 9f978ba164..bac2822e98 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -111,7 +111,7 @@ void pcie_chassis_del_slot(PCIESlot *s)
     QLIST_REMOVE(s, next);
 }
 
-static Property pcie_port_props[] = {
+static const Property pcie_port_props[] = {
     DEFINE_PROP_UINT8("port", PCIEPort, port, 0),
     DEFINE_PROP_UINT16("aer_log_max", PCIEPort,
                        parent_obj.parent_obj.exp.aer_log.log_max,
@@ -204,7 +204,7 @@ static const TypeInfo pcie_port_type_info = {
     .class_init = pcie_port_class_init,
 };
 
-static Property pcie_slot_props[] = {
+static const Property pcie_slot_props[] = {
     DEFINE_PROP_UINT8("chassis", PCIESlot, chassis, 0),
     DEFINE_PROP_UINT16("slot", PCIESlot, slot, 0),
     DEFINE_PROP_BOOL("hotplug", PCIESlot, hotplug, true),
-- 
2.43.0


