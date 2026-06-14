Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D594CD98DE
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDK-0007mI-9I; Sun, 14 Jun 2026 15:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCn-0007L0-RT
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCl-0002S7-4j
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UJX+Nq7r7a7nzrqVQPKDrYeY3XcVLdwNa+3KVMcJknc=;
 b=T9HQqEwrj0F1A5clUC+5lsAoy2RSjcSa3xE7dRydp8MyUUmdXXNyguTZzu3KVDQve/h3HV
 PJhGdYCQnfnxyyH2YZGxNM4duaoPCU7FXJeR8pI0qdc0kON9tz4Zl37hF6NzpAyiQmeLVs
 CQyI7Z9fup+JAmP+Sun2xP+j94FiY5w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-9ZrzfdtCNzCt650kZMDodQ-1; Sun, 14 Jun 2026 15:09:09 -0400
X-MC-Unique: 9ZrzfdtCNzCt650kZMDodQ-1
X-Mimecast-MFC-AGG-ID: 9ZrzfdtCNzCt650kZMDodQ_1781464148
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45eebc943bfso2062404f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464148; x=1782068948; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UJX+Nq7r7a7nzrqVQPKDrYeY3XcVLdwNa+3KVMcJknc=;
 b=RlgrA8MClFGr2shYIELEDK7Lo4jGsVPMRMiOHcaimKQ9bwEJ6NQmr/MfhYkSlaM1Lg
 /I0SRBom8zmCncWls0i9OYifysAEWz875Cg90thSQld6UC5GJBxng1ZNqGn8HYh1NUH6
 miilijrNXMt0dAHlK9OnCOLc35EXE43ioRRY60dq0BB+p4uHhrsXCt/BlgO97afq6FlW
 e8QpackB+aQlgfHSAoOoC4ohVDFIWdAqqCt2LoYjKfgSxyFyeVJKLvBde4enkfGWmg4R
 ROhVf4JVRBH4PjX752VzATd10bfzncr5ghQDCZkAqv//lNP9qYJDGDjprXT7Ul3A0YSs
 iP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464148; x=1782068948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJX+Nq7r7a7nzrqVQPKDrYeY3XcVLdwNa+3KVMcJknc=;
 b=JD+5wdzTvHB8eB8o3Z6dAu6wqbr1ppK5xat3rVbQ3i+N4M4XR5QXL7nxCn7wJXphWS
 wx4cQ2bB1buc2+FW+2EzKEEwIF8Za4nJdjK34tbWPPN4iJe7ryn+BCGQQkZ7FPGy4h4F
 A2rMZzpJdgHSottZi53tXXIs2wKUAn5q0xzeh7b7M5HR6+Jc0hccrh2LIlMXZRencaQf
 wmBSqATDauF5jMkhmblkALfxE79M+T0hpLfn2fXC8epjOFCyWibXTQp+1tl45Jizt6Gx
 oIqLN1bguWUX3pz3s1qj9om9lRXMIHcBYPfjsU/RlsrrtLOMPAOSdv4RVj2rwOKn+Cmy
 z73Q==
X-Gm-Message-State: AOJu0Yz2ZQ3L76hwTuVoVjcF1U9jYDgVjzhu4xAQF8k+dapuIH0vWaGk
 bXVr089Muny8kzvZSNDekCc3zLCWLri84Ddav9gvw2M8px7rz39gtBCl3oCTzzU12Tf/7vdnoMU
 7++cMr84vvaOl4ygb3mELdCJUrJ3yVyWl43/c1kDgevVGGF7+9YM5bmUGemoo4jSqWjcOdmR7q2
 zKQVI2o/YT4ypRbLd51vz/OLULhGU+b0xSvQ==
X-Gm-Gg: Acq92OGaHmR7N98rDfN7hM3ZT5h8jibidu+0nm/3v6q0QOBS2Hbmbmc16rJJeFg7Wdc
 2Q/ciixd6WV8eu4zhJ4J1nCpIMUKJcCgn3nrbXf30EXi1fekRSD3aa/KomSqVS18ROmQm6Jn1U4
 SezY+fskAv7RrcxuAmnuJeLuDlUwOwlGq5DT5FzUHgsNKe8UlyQhd+WMQ7RE7Y2s0WLi9S9Py5F
 54BVxxz1FHaTCFs4tkDZ7Kev6Bc43z4ctcGeZOXtABgx01jViH9SFhKCnHRdPg9bHuCEqTECAxa
 F7tsqrh33LtXrTaldnHAZrPL1Hmejgym64MD3SZdILEq5z1NmBY8WTvq9HD7vNysH377CfGtXFc
 UpGzYPyocG9dsldjYu3l5ykJ07V0Di7TlWj9m0RyxYJ0=
X-Received: by 2002:a05:600c:3145:b0:490:9dc3:3483 with SMTP id
 5b1f17b1804b1-490ec480f88mr134826765e9.2.1781464147903; 
 Sun, 14 Jun 2026 12:09:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3145:b0:490:9dc3:3483 with SMTP id
 5b1f17b1804b1-490ec480f88mr134826405e9.2.1781464147270; 
 Sun, 14 Jun 2026 12:09:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220324211sm195363575e9.6.2026.06.14.12.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:06 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 080/106] amd_iommu: Turn on XT support only when guest has
 enabled it
Message-ID: <ced009256e6ed6ae93785d00699fdfb956584f5b.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Current code uses 32 bit destination ID irrespective of the fact that
guest has enabled x2APIC support through control register[XTEn] and
completely depends on command line parameter xtsup=on. This is not a
correct hardware behaviour and can cause problems in the guest which has
not enabled XT mode.

Introduce new flag "xten", which is enabled when guest writes 1 to the
control register bit 50 (XTEn). Also, add a new subsection in
`VMStateDescription` for backward compatibility during vm migration.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260302115130.5903-3-sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 21 +++++++++++++++++++--
 hw/i386/amd_iommu.h |  4 +++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 1c44848aa9..5947d3aecf 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1579,6 +1579,8 @@ static void amdvi_handle_control_write(AMDVIState *s)
     s->cmdbuf_enabled = s->enabled && !!(control &
                         AMDVI_MMIO_CONTROL_CMDBUFLEN);
     s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
+    s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup &&
+              s->ga_enabled;
 
     /* update the flags depending on the control register */
     if (s->cmdbuf_enabled) {
@@ -2054,7 +2056,7 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
     irq->vector = irte.hi.fields.vector;
     irq->dest_mode = irte.lo.fields_remap.dm;
     irq->redir_hint = irte.lo.fields_remap.rq_eoi;
-    if (iommu->xtsup) {
+    if (iommu->xten) {
         irq->dest = irte.lo.fields_remap.destination |
                     (irte.hi.fields.destination_hi << 24);
     } else {
@@ -2437,6 +2439,7 @@ static void amdvi_init(AMDVIState *s)
     s->mmio_enabled = false;
     s->enabled = false;
     s->cmdbuf_enabled = false;
+    s->xten = false;
 
     /* reset MMIO */
     memset(s->mmior, 0, AMDVI_MMIO_SIZE);
@@ -2501,6 +2504,16 @@ static void amdvi_sysbus_reset(DeviceState *dev)
     amdvi_reset_address_translation_all(s);
 }
 
+static const VMStateDescription vmstate_xt = {
+       .name = "amd-iommu-xt",
+       .version_id = 1,
+       .minimum_version_id = 1,
+       .fields = (VMStateField[]) {
+           VMSTATE_BOOL(xten, AMDVIState),
+           VMSTATE_END_OF_LIST()
+       }
+};
+
 static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
     .name = "amd-iommu",
     .version_id = 1,
@@ -2545,7 +2558,11 @@ static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
       VMSTATE_UINT8_ARRAY(romask, AMDVIState, AMDVI_MMIO_SIZE),
       VMSTATE_UINT8_ARRAY(w1cmask, AMDVIState, AMDVI_MMIO_SIZE),
       VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections = (const VMStateDescription *const []) {
+                    &vmstate_xt,
+                    NULL
+     }
 };
 
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 17b7ba899f..300d91b34d 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -102,6 +102,7 @@
 #define AMDVI_MMIO_CONTROL_COMWAITINTEN   (1ULL << 4)
 #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
 #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
+#define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
 
 /* MMIO status register bits */
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
@@ -413,7 +414,8 @@ struct AMDVIState {
 
     /* Interrupt remapping */
     bool ga_enabled;
-    bool xtsup;
+    bool xtsup;     /* xtsup=on command line */
+    bool xten;      /* guest controlled, x2apic mode enabled */
 
     /* DMA address translation */
     bool dma_remap;
-- 
MST


