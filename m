Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B686EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAD-0007CB-7p; Wed, 04 Feb 2026 14:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniA4-00071E-71
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniA2-0007oi-HH
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=npw1QjPEPkrUSmQMTkhMuqAaf36Fs29cc+AU0ZeYdxU=;
 b=eYhFp2A9fvRG4kQWxmm1kQHEA7K8+F0yd3P4QgrMoxfnuay6WJgAaaj4YJDTrGUeJ4TgCq
 VCK+PWj2ZcpT01TfQLmUfsz0WlkUf0jV9MWvyKje8FZxw/RJILoVmDmzyWw7hglRK86oJS
 7QVLBVhcTLiIAOkS/6+MI8WQpJz9D3I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-HEu0iro1PvipcO24S1VhTw-1; Wed, 04 Feb 2026 14:03:32 -0500
X-MC-Unique: HEu0iro1PvipcO24S1VhTw-1
X-Mimecast-MFC-AGG-ID: HEu0iro1PvipcO24S1VhTw_1770231812
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43284f60a8aso172877f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231811; x=1770836611; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=npw1QjPEPkrUSmQMTkhMuqAaf36Fs29cc+AU0ZeYdxU=;
 b=HMtrQkQXmnd1TJ23oxvbyxUYJCo5NIombJTr40bBXBZ2mPGZUo9KytO8IOzj3mG9kA
 D7O6e3z/5vej64lQeR43B2f/Hf7zquxij9dZgjofTIl4MQ5+rzumh8d5MEOFhOHBcbnW
 QKqKNvZ+JYVoRtqZPdYa6GjFrxEFk8TaDmUpEYtpDfK2nic5I7zZO8qAO/w+A+CzJM+q
 oCK4wJmYuV/8mPaeTx6EvtkN885tI8NNz268+hbGx8DfGiQx9KkeexskJ5FR1hgZy/Va
 reFvdH9WrRG1tN5DS/w+m7E1gbVSAEjco+Dffbly5BnVgc9GYzwSh0PJ+QAxLUQY6BqR
 ZOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231811; x=1770836611;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npw1QjPEPkrUSmQMTkhMuqAaf36Fs29cc+AU0ZeYdxU=;
 b=v7E0+zcd5F3N1TkWhbw3qMNFURqg9YdZA59pg8SDp6y6++qbq0PR48GDfg7AOX34mV
 EyPjm1mBGhLjp5SI3Vwe36refzCwXJZfFQ1EMZJxoRSA4Qcl7A4gLuc1wkmlL/XrpI3Z
 EUUoD3L8/LHLBGWJqEwyQisyy5Ey5NvuQegG0Ky+PWS4hsSSXRR/hUDfrlyWRM5T1uUH
 MbyO+Y/uF653f8V0qdNFZrJRNGvbIoqLvsQ22T+Mvtg6PpN5Zm52QoKQBfrAbWulRoYN
 RYgRLEqb/Gc1B18woAX9T5VpDTPyqX93hYY6p28c+3uS5QWRKGqL7xHLAF1HtlMQth/x
 F3sQ==
X-Gm-Message-State: AOJu0YyWT+Winvq60M/2wJjGFkFQY655w0B7dfIV4TX3p7Uft7Ahv7ks
 QyclLI6DEXcdBoM0BLqNfceQio0XjJcL7WZbITLAuEldwtpmzHAW7MBCg75WOeHuFZFaqh4bZdJ
 GVrEeeZy1VbL/dZ6kJaUiJscnomQwho64db9Lr+m8DrJ+zDp3ZYj6sldTmLsXh/CcenxP5BYE87
 l0bnsqzNAXVC1iwQCfC1EPjh+4OQSfh1wE4A==
X-Gm-Gg: AZuq6aJvTjJQDt4Q8RYABoZML7ra/13cimT5zDpaCxZM6FxdawjsrIqKwE0Fjz2pAea
 wG2Vi/W9FBjW2k1pxvl5kc7z4CMgT6wbrmQMsj9Zgkk1neVLxXFU+CC1/1nd2ktakKnUKuvhPwb
 4YdbT/iLbIqlDzrx7AywiPfu33S+PM2bFLRnOQZD/5lFWqomwAOdBcHx1LOwfNKhwupUo/lXSbT
 LYacxsonW8pvLjNEWDVEA1fzhWe7Ludzk5JcOhVqBdfTJDRJVqjg47bRak9RTllg/YAqLs+aupt
 v61nd56GD9/jUsIpgsPrvH+NnUL/l+3iBq7wFrjFGcOXfl0IElux8yXJzAV9VoeNHghvELipB9q
 GF4mAt1X6qkrV5MswOBNnGMLRBVDVmfPBfQ==
X-Received: by 2002:a05:6000:26c9:b0:436:7e8:a10 with SMTP id
 ffacd0b85a97d-43617e317e2mr5379469f8f.13.1770231811338; 
 Wed, 04 Feb 2026 11:03:31 -0800 (PST)
X-Received: by 2002:a05:6000:26c9:b0:436:7e8:a10 with SMTP id
 ffacd0b85a97d-43617e317e2mr5379378f8f.13.1770231810755; 
 Wed, 04 Feb 2026 11:03:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805fec6sm7963220f8f.32.2026.02.04.11.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:30 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 17/51] intel_iommu: Minimal handling of privileged ATS request
Message-ID: <bbb8d5b6a3c0105054bd41849f72c04065296bca.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

The purpose of this commit is not to support privileged requests but
to prevent devices from doing things they wouldn't be able to do
with real hardware.

We simply block privileged requests when the SRS ecap is not set
and abort when the ecap is present.

For now, its not worth implementing support for privileged requests
because the kernel does not support it.
(https://lore.kernel.org/linux-iommu/20230411064815.31456-11-baolu.lu@linux.intel.com/)
However, we may consider working on it depending on how the development
goes in the kernel.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251029105137.1097933-7-clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6ba1c1676b..77adeed0cc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5190,13 +5190,27 @@ static IOMMUTLBEntry vtd_iommu_ats_do_translate(IOMMUMemoryRegion *iommu,
                                                 hwaddr addr,
                                                 IOMMUAccessFlags flags)
 {
-    IOMMUTLBEntry entry;
+    IOMMUTLBEntry entry = { .target_as = &address_space_memory };
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
+    IntelIOMMUState *s = vtd_as->iommu_state;
+
+    /* Guard that makes sure we avoid weird behaviors */
+    if ((flags & IOMMU_PRIV) && (s->ecap & VTD_ECAP_SRS)) {
+        error_report_once("Privileged ATS not supported");
+        abort();
+    }
 
     if (vtd_is_interrupt_addr(addr)) {
-        vtd_report_ir_illegal_access(vtd_as, addr, flags & IOMMU_WO);
         vtd_prepare_error_entry(&entry);
-        entry.target_as = &address_space_memory;
+        vtd_report_ir_illegal_access(vtd_as, addr, flags & IOMMU_WO);
+    } else if ((flags & IOMMU_PRIV) && !(s->ecap & VTD_ECAP_SRS)) {
+        /*
+         * For translation-request-with-PASID with PR=1, remapping hardware
+         * not supporting supervisor requests (SRS=0 in the Extended
+         * Capability Register) forces R=W=E=0 in addition to setting PRIV=1.
+         */
+        vtd_prepare_error_entry(&entry);
+        entry.perm = IOMMU_PRIV;
     } else {
         entry = vtd_iommu_translate(iommu, addr, flags, VTD_IDX_ATS);
     }
-- 
MST


