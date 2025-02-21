Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3816C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS5P-00028l-IZ; Fri, 21 Feb 2025 07:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5L-0001b2-1p
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5J-0007F5-7h
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4ygtfE//+SZN2f+zX5YmIK1yZQyKJU0PdMA77xslew=;
 b=GeaufGUJsZmDCwmKTa6NSiLIPtNPUCUbSVl8IIC3UZYTER2OjOpq1bNXdX2xE3AgIbJ6Dh
 fcfqx8Ew+4jVod4qlHcZ2WgusC1Uog9cizOzNBVDozdAl88qgsjkxCIMd/E64313l6s4wp
 4OolDQW5h4LIsJdw18OFHr1gJ1pm0Uw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-QEHEHu19N_a5fOLWoiijHw-1; Fri, 21 Feb 2025 07:24:47 -0500
X-MC-Unique: QEHEHu19N_a5fOLWoiijHw-1
X-Mimecast-MFC-AGG-ID: QEHEHu19N_a5fOLWoiijHw_1740140686
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f4e3e9c5bso941201f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140686; x=1740745486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4ygtfE//+SZN2f+zX5YmIK1yZQyKJU0PdMA77xslew=;
 b=cbx+Qhp27ruGqlQnafU3Mdt+6hczPkbFmSzrdoMfd1Zk6ZHCK0fw7BV10S2OhaBnB8
 jm7t86tGbk81s2MylKIkaovb7Z+1e6kYlnrcC5ROfvKWqwr5ImbJ/1yTZjF5nGnZ4LDy
 2TUVIG2K3akIwbvadqXjzFAuOkKOB7E8fJR2eKQrWrf7SgpX5S+2nb9cdr7XvGyKwuGG
 DCob6wMnBViZiRBEqAmxZcX1HxKjyOpy9LedmSCLEX/zdzPqOXqwMf+WK15Pa/VS7P/9
 B2v5rPPV7iFweI1n044yQkaG9ez7AWl0NwWIMDvWbKycTEz3WBrE1i+UvVs2TC1EWw4e
 zMog==
X-Gm-Message-State: AOJu0Yw4KsQMEuLD4Ulwq7HoYhl9EorbWJmL0yRM6OG4/WVpgFn0Axs2
 yWHk0/tnpeHKQ/V5F9DP68iYAAus/CHnxSyMm/WjygvdY00p/o/5h/EjRa/yqU7NqDH0cnM4dio
 TCSlHl7phmlreGmVeTOFG45/ALMIV1afbRbpYd/OxMOQTl6Ht6dBPvXEdX0JCnm7qy2ECey+wk0
 nEntECpT+BdOHjh1QD8m5vXjZaoEF+zw==
X-Gm-Gg: ASbGncvJ3BSbo/p5RNEzWngKnbGxGk/mzlkvcsl2UeQFZffeLXam7cMbgZpoOLm0zvb
 0XTMo54LoK/AdHDnRUjjrDC5VnUkRCVtC3ipC38F22MSGMEXy4kRVWzLj6A68MqDfukgDYAfIr5
 f+5szt1zBv0f66lObFOBUeZ9JhQe4JZZE1Kl5sOB/SrLxHXoaCgYuGu5Y7hsziua0wn67BR8qXi
 Wi5h1FJNM5u44Uoq7eoJLBjqX3q58bWWUt3utnvdv5rAGYQQ8Dk3FnRu5Muzh2cMFl5xPjI61ro
 UfZHnw==
X-Received: by 2002:a5d:5848:0:b0:38f:2990:c074 with SMTP id
 ffacd0b85a97d-38f6e95e697mr3088099f8f.16.1740140685843; 
 Fri, 21 Feb 2025 04:24:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEAdCWQAFIFZ/v616ucdhekMHqtcZK/hSR9FKGYG/dGXHtJrunXzIBiWwyHzBiOLfsZ2Mf0g==
X-Received: by 2002:a5d:5848:0:b0:38f:2990:c074 with SMTP id
 ffacd0b85a97d-38f6e95e697mr3088064f8f.16.1740140685378; 
 Fri, 21 Feb 2025 04:24:45 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259fe1efsm23442781f8f.97.2025.02.21.04.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:44 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 38/41] hw/i386/intel-iommu: Migrate to 3-phase reset
Message-ID: <2aaf48bcf27d8b3da5b30af6c1ced464d3df30f7.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

Currently the IOMMU may be reset before the devices
it protects. For example this happens with virtio devices
but also with VFIO devices. In this latter case this
produces spurious translation faults on host.

Let's use 3-phase reset mechanism and reset the IOMMU on
exit phase after all DMA capable devices have been reset
on 'enter' or 'hold' phase.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Zhenzhong Duan <zhenzhong.duan@intel.com>

Message-Id: <20250218182737.76722-3-eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 12 +++++++++---
 hw/i386/trace-events  |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f366c223d0..a5cf2d0e81 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4697,10 +4697,11 @@ static void vtd_init(IntelIOMMUState *s)
 /* Should not reset address_spaces when reset because devices will still use
  * the address space they got at first (won't ask the bus again).
  */
-static void vtd_reset(DeviceState *dev)
+static void vtd_reset_exit(Object *obj, ResetType type)
 {
-    IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
+    IntelIOMMUState *s = INTEL_IOMMU_DEVICE(obj);
 
+    trace_vtd_reset_exit();
     vtd_init(s);
     vtd_address_space_refresh_all(s);
 }
@@ -4864,8 +4865,13 @@ static void vtd_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     X86IOMMUClass *x86_class = X86_IOMMU_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    device_class_set_legacy_reset(dc, vtd_reset);
+    /*
+     * Use 'exit' reset phase to make sure all DMA requests
+     * have been quiesced during 'enter' or 'hold' phase
+     */
+    rc->phases.exit = vtd_reset_exit;
     dc->vmsd = &vtd_vmstate;
     device_class_set_props(dc, vtd_properties);
     dc->hotpluggable = false;
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 53c02d7ac8..ac9e1a10aa 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -68,6 +68,7 @@ vtd_frr_new(int index, uint64_t hi, uint64_t lo) "index %d high 0x%"PRIx64" low
 vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
 vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
 vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
+vtd_reset_exit(void) ""
 
 # amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-- 
MST


