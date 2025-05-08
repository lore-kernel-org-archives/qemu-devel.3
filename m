Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A15C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1YO-0001fg-QB; Thu, 08 May 2025 09:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1YI-0001RA-MH
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:44:42 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1YE-0004yN-St
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:44:42 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-30ac268a8e0so1460257a91.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711877; x=1747316677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABC8+QfGyso1WyDvOcXI+0OZWgW+TnNwcrP3jxKT+bs=;
 b=QOUTzPxCqlZc4K9W/VfTZrsgac9diUmTUlj3ALrUr05YAoqk3Z9Rk+P/DD7rotCo1x
 qyY/BzuH/fE6MoGbC7zHQtqUBXjNETy/7f+zoFfpwd0G+cwiDDAFCiX4ZJ2IAg+xPdFZ
 duT+inpobW+E/hI9pL/0Ic7KFTnjC4tOFFF5CuoJRMVBfcxHO+KxaSHIkzvLSOx0ElL8
 Mgimi4UwsTiVQeQ5npRArdK0Up4TAHqTXpdDtOtqrg6OAK+hz7p976M3qoU0w+SvLRDa
 Deo6oNpHp2jU6RCqcrFXi231i4uI8u8AXZcUacUDenng5dTEJkLYe0YQdiGNPT2E5cpM
 bL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711877; x=1747316677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ABC8+QfGyso1WyDvOcXI+0OZWgW+TnNwcrP3jxKT+bs=;
 b=m/qn/eleZRDsKwxCVgxqR1dIdyevJJ0S1Rpw9JSErrbJvi07poZ5STkMZ6Jx9sjCVr
 G0+5XwYt6KZzKzu8wdILsi2Ikh1adzl8Mst+e70qW5rkijtbWpXvgFkpg2p9JMtmVwes
 paR4zZ2dcxs4XRoK4HKdev3aD4MIXQLiM2+BBNN4DRYtAVIvVcqkn9GTjPZnnVDOY5e5
 jep6jVLyItyzXSjJ7zf7lCRGGMy4x+WaMHY3EfuixdlgetuUkxKhOBjFYxCIyuQl8sce
 bQG8gfdz8yYRcpW2zdEfHvry3xNL2QGikDgwtvWuhJpVoPYHlDdy5UflMv2LxOBUjB97
 +szg==
X-Gm-Message-State: AOJu0YyYYE/sPPfpk0+/3jzkpWHxjBIHls3u7aIDIWDyOScmi3vzr8RC
 WG873OF9wK33iCJOM57MqJUzienn/ppBHsw2UFWmjO8n+o7cnseEJiBZIHD+WGl4Xfx9wGNRIRi
 OjUT7lQ==
X-Gm-Gg: ASbGncsWv0sLSd37ocWmfZhuavXuBJ6btg6oZSR4+3q4JhGjlgIDrB2A97VlBZqcSks
 wrJjYPauUZ5kWs23bk2v6yD7DYkYGIViK9CBzABlygnkh72Cskw1cRJZ08+CiMtz+uyRYl1Z2aL
 P1vsm28W97tATdQXaYYryndwfT5KDeQQhhCNZAX0BLCrs54XUje8TxXAD2TarK25AUEDlZMorXD
 frD0VVhxVMtUBAmbR3SK9P8tgGW2P1vDQJpVG2RsrWxM+TrIBkGEADJ/1au/A8vrC7xc1CYKMjy
 RlU5yyl7P+U02CGdBo2lsUZXX3m3ImdSJYUgJjs7j7wMQ2uRror9HaLY85Ew3ls50gzyuK2kwmR
 qhoteZXqb8WeeZ5A=
X-Google-Smtp-Source: AGHT+IEUdsHAoEH5Q8KZKtz2AvzabbEqVKF3EUjTCg5XRDEcrks+oGqKHzSziA06tvgUnitC8tKtJg==
X-Received: by 2002:a17:90b:224e:b0:2ee:c30f:33c9 with SMTP id
 98e67ed59e1d1-30adbf3b191mr5502686a91.14.1746711876787; 
 Thu, 08 May 2025 06:44:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad474a05bsm2173239a91.2.2025.05.08.06.44.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:44:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v4 23/27] hw/i386/intel_iommu: Remove
 IntelIOMMUState::buggy_eim field
Date: Thu,  8 May 2025 15:35:46 +0200
Message-ID: <20250508133550.81391-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1033.google.com
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


