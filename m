Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7736BEE3694
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvI-0005no-HP; Thu, 12 Feb 2026 09:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXv6-0005Td-Pv
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXv4-0006Bt-B4
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJbz9sfjacuujudUJwh17bT/zPXAUO3y3Cmg/O9D+sw=;
 b=CC4EZXlap7WHROIeY1LhPXhozwLJd4k9AQMnSL6u5BoGHuuKIEy/a1oV3gUh/s9g2y0jxs
 +f5oJzXE0C0gde/r5131ed7TR4qnVrgCwmMKcTPGR9Dn7ij3PNoa7VrlqFKhhwd24J403o
 0fYvbsicHf2EoqJSWdKI0fJIAqeHGFk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122--OvWcrXJM4W_yWu2Yw3Jtg-1; Thu, 12 Feb 2026 09:43:48 -0500
X-MC-Unique: -OvWcrXJM4W_yWu2Yw3Jtg-1
X-Mimecast-MFC-AGG-ID: -OvWcrXJM4W_yWu2Yw3Jtg_1770907427
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48070c21420so15035545e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907426; x=1771512226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJbz9sfjacuujudUJwh17bT/zPXAUO3y3Cmg/O9D+sw=;
 b=U5CSW0qEBNj1OFeetMTiwMtP9+mjDmhKiXRNsu9wxO35Zpo92Q4evSbccn9Vo9lfBq
 JY7jmRXhQ+x75YKuKUCQmACgF6AIsu0qLqjwkjQCIA1szcrTz2Wct1CrpFBzjHOSRVVd
 ULEjuCxCvQXqX9gZXIBAeBabb7SwAVf1ZFLUvO48VvtHMMBCMZ76/JlAo8KuuNIyuLki
 zUNmJR7tet15xkzotkv1+v2DW+5NKPiCPuQEJ7HZvW/TKd4YHLjZpLXKal5zvbjJIZmN
 lwcYGZDO1VAL0Lg0EAlH7Cu8pbAXIKn7KnUvEgezWOFjpPsFv82tWKIeCE5hMLN3fR9H
 BMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907426; x=1771512226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zJbz9sfjacuujudUJwh17bT/zPXAUO3y3Cmg/O9D+sw=;
 b=FxpPkY07r6RF/SEd6VXGMu6q0GhD2Du6WlGC7nVjxLyQL4niyuAmofBE/Ewn1shTgb
 dC39vqiakJglF9yEk/PU5h86ovPvtjJW57QWU//PnIWmQt8ujVzOo7ZbFIr23q+FViFg
 gB/QzVsSERUPTr6F6k0NZayEaUEK0RNkcURYPnCry7oHclKG8I5bX36Xczfd4sK1+MG1
 iYGtJXAPoG+Z49gGnVGHMiDTMtFNkmCTLp/oRGnSXxA6LvdVWOaPHqProDSbu/jqdjC7
 8QNQwjwv1iw6bQHhRcEn96XiO5J0QacK49T9a5yS607vE7DHR6mpBqTih7zy6wWWH9Tn
 8kFw==
X-Gm-Message-State: AOJu0YyUNGq++/xH/UxnwV89IavD7kbKpj42eWYzXxl+Xg8jJevSLY1f
 +RKQ9C/QSwthNrkUlkWPSrg3kEJbzuqU+cS54rH8fhQ7IwsuqeRt9t6wXdvGvinnBwX674OBv01
 1/DaVagJ4ezU9MQSvnHMnMeqhrpJf7YTBLorfnjVKCfQynULRykryWqH5BgqxRc2nwftUwEGwU0
 tyQhl+FUlfD+8mEjQu3pyEEFPHH8l9A+56kMpDHECD
X-Gm-Gg: AZuq6aIH5/rtSDNQVT3xJa/QdGMGbXdwfNdVe3283+3Ey/5fCyAq0NCd9PCTaNed9F5
 QqY5KXg4KAMCuOCNuEeIikgttvXaJua3sQfgSlzzPbHw4SU/w2u+TTzvgoqVJhGQTbEKSnPut5f
 LF4OujqT2WRkB9P1mnaQzgPQOPGO7KroZxjaa9mOWuuqk/G1J1avols9nH6kDJZTwhCevqhoQEr
 ytFvjNgm1ICwSVJ8LN7vmQf/AeMqlfgDwL6HwHFBBbkwDBlTTg3bfZTBpxwghOowv4gcG0x1iyf
 RURIBWiRJWZmYEKSGqkcjA71YOeDCjP9p6UA6LOdoDuU3aCm0FZny1oZM4bM08i0t+LQ6AyxrkS
 OVKNqRFebN2Op8dbCcO3pf1UMQpzh8jbXiP/2E/LuEe/K11vOBdLmp9JvNJTK+lgHwmHLxkSqr5
 633QGN9bY+U925JZf9TDD8a2M1kEFVuH8fPnv8c5f8QgURPbnDrpY=
X-Received: by 2002:a05:600c:4f48:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-48366031156mr38717875e9.14.1770907426195; 
 Thu, 12 Feb 2026 06:43:46 -0800 (PST)
X-Received: by 2002:a05:600c:4f48:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-48366031156mr38717415e9.14.1770907425574; 
 Thu, 12 Feb 2026 06:43:45 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e50casm192826095e9.8.2026.02.12.06.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 26/41] hw/i386/intel_iommu: Remove IntelIOMMUState::buggy_eim
 field
Date: Thu, 12 Feb 2026 15:42:28 +0100
Message-ID: <20260212144244.22579-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The IntelIOMMUState::buggy_eim boolean was only set in
the hw_compat_2_7[] array, via the 'x-buggy-eim=true'
property. We removed all machines using that array, lets
remove that property, simplifying vtd_decide_config().

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-26-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/intel_iommu.h | 1 -
 hw/i386/intel_iommu.c         | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index d600e5495f5..54c2b6b77a0 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -313,7 +313,6 @@ struct IntelIOMMUState {
     uint32_t intr_size;             /* Number of IR table entries */
     bool intr_eime;                 /* Extended interrupt mode enabled */
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
-    bool buggy_eim;                 /* Force buggy EIM unless eim=off */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
     bool pasid;                     /* Whether to support PASID */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dd00079a406..92a367d6577 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4180,7 +4180,6 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),
     DEFINE_PROP_ON_OFF_AUTO("eim", IntelIOMMUState, intr_eim,
                             ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
@@ -5539,11 +5538,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
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
2.52.0


