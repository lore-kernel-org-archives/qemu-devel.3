Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BF2CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNJu-0006cu-La; Mon, 27 Oct 2025 09:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNJq-0006Ut-Tm
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:31:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNJe-0006Xw-7j
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:31:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-475d9de970eso21285875e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761571871; x=1762176671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APa/O04EWMXyReqhTKupLrjt6/G+ad1iD0NFL8JZM7I=;
 b=du2+S6xpcR3vRXsl6+7rvCb7Z6RI9PPDOdX7yPXSgWk+QWTdBvb0MAS8ymwwvDMs4k
 Yexjp5zVPTH6ri7l2NjQCBnOoKbPAmZbn2Kig2y+v8ITvelHemcerRuiqXeWdV5SOgyl
 Cawzp9r4mf+1yVgv/OXIwya4eD5fdxNpNERkPOW6qQFOnbovQ/05Ap9pN2kJgsI9WVGa
 HpQPeHPun+QaS+8TkKzQJuvtcQjKPJ034Kh5lLWdvLrobwhaL/nANylgkZgHU3Y88edw
 nnazR2d+4IvA/BZZCiCaYrU3j894UE236ni9TtBZV7no/BnIaxG/LRehgfQrGKG5WZih
 KRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761571871; x=1762176671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=APa/O04EWMXyReqhTKupLrjt6/G+ad1iD0NFL8JZM7I=;
 b=mfbtPh5A/ZzVGQuebXBnS3n/R41G22mLckQ4wFd6xP1VwPx8gYrjGEpxiyHDph9d7t
 7iiVRvuQ6z6Lz4RsgPJi6y8DLy73LYsRelW0KY9FJg1PgoqcUc3Zz24bquuyjF0wYqFE
 itNxCQghuRNShVgqC/rZI1Y56QKsRxJlOqfg18YGc4+TCzXJtF2wyOsdYurx4fCuwSET
 30d21YiKZ/z+hXbk5TZNFHLMj0Borh/QzTy8HWQf+ZQYsL17ra/OPdPpLD1LSQ1DbLQt
 V+9A21XxwYM2poZkZ9CfEJCZqkdKWmLDr1p0vVY//L18Cr1qebadJHde963z+TVBklEF
 CwkQ==
X-Gm-Message-State: AOJu0YwBnEXWBs0HIbOTU6piDuuSZvhoH5cRQQ0UOpFZKONs9+8NmcXh
 fAH0z977NyhmiqudVuClYZCNbaHqlc4xYaVQPcymkeUuSfOwsivgqM49rbscpIfKpcAPNX+uHJL
 Vg1SWeJs=
X-Gm-Gg: ASbGncua+sH/RvMCdx+g/tkllHQxKPGFjfM+qnWgQh9hgVqeoZZ5+LHmDF5Mhorvwj3
 C9VodDijwIyyawJE5tkGCDFzq4fJSvB2KokGzQPpBGAZkHfWCw8Lryzw0XYLo+WHBpQrEur5kSd
 vh0+PG0fx6AEIlXcUqSDujI0AQZWAaT6wLH1qFpBtsgqwyx4EbWKmjj98mZN3li8nYdLfjCgXD7
 90XhTCsH7M7kMXDLsXYIY2x9IeFUOPdsacwlBqdPkvBv3tu1wuFljew3gosPaqUy08ERRtAMF/6
 kvxtZNE5oDoTIa42ovVLvKWL86gyDVlqFe3dc09B8WM0keAicAEGM/UTD9DfwEk/mE9NjuxxQhp
 a5Tz5Yweheufx901hql+lTvGGgbk0ZXK9in8ugS5kK0ib+is8/QjwDHEZTVq9VnhkBUyY/AZj4P
 T5Gvlpkd4OUIsdKVCNXNsaRAYs44ay4vxWnIwhnne56VTIunA7bA==
X-Google-Smtp-Source: AGHT+IHAyX6xGgnhv5sODby8cXZrDrUvUlfRYSpXlpM5rafAq3N+Xpp8Ighf9dEj8Mtv9nymVFEYUQ==
X-Received: by 2002:a05:600c:8b16:b0:46e:384f:bd86 with SMTP id
 5b1f17b1804b1-4711787070amr286022915e9.5.1761571871430; 
 Mon, 27 Oct 2025 06:31:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd374e41sm137891585e9.12.2025.10.27.06.31.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 06:31:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/pci/pci_host: Add 'config-reg-check-high-bit' property
Date: Mon, 27 Oct 2025 14:30:34 +0100
Message-ID: <20251027133037.70487-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027133037.70487-1-philmd@linaro.org>
References: <20251027133037.70487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
index b5c624e12e8..06003188e1d 100644
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
@@ -237,6 +239,8 @@ const VMStateDescription vmstate_pcihost = {
 static const Property pci_host_properties_common[] = {
     DEFINE_PROP_BOOL("x-config-reg-migration-enabled", PCIHostState,
                      mig_enabled, true),
+    DEFINE_PROP_BOOL("config-reg-check-high-bit", PCIHostState,
+                     config_reg_check_high_bit, true),
     DEFINE_PROP_BOOL(PCI_HOST_BYPASS_IOMMU, PCIHostState, bypass_iommu, false),
 };
 
-- 
2.51.0


