Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD77C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqng-0007hX-0e; Fri, 01 Aug 2025 10:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhf-0005lv-2b
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhZ-0002rj-Ne
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vgmFtDgTAmGls1KrsF1UJKp0mhRKj20ErXb4GvRJyH4=;
 b=NXIY2Bt8cPCMwie1SBAaV+W342vam5lek6DyDLhfJqYeujcqQraEqRjja/v1ZP5QIDn8+m
 sno5LNWC4i/0chwecAoWSUAXb3aK5xzaUIgjfeGmx0a7t1pHiBJ5kdq+GvDDb2GxzOlBtq
 7GgIA+5BAdQ5dCDXoAKGn4T8aNkI/CA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-l1aZ-_vcM1mlv7HeJcMdhg-1; Fri, 01 Aug 2025 10:25:39 -0400
X-MC-Unique: l1aZ-_vcM1mlv7HeJcMdhg-1
X-Mimecast-MFC-AGG-ID: l1aZ-_vcM1mlv7HeJcMdhg_1754058338
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4588fb6854cso9271815e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058338; x=1754663138;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgmFtDgTAmGls1KrsF1UJKp0mhRKj20ErXb4GvRJyH4=;
 b=HsfJiLZpEuNuPf5FW4CaXAx4cnodMzFoPT6KbKLIxq9vgl879GCVUG3me6/BXy1V1g
 5wM3D2q/kql4mPyfLrckYLBmI77zRgPWpF6HxAWZ5e20r4qRyKByv/CCycRD1VnBNr0X
 decEQFh/7qXFanTB9/QFLBd2K4Jl5unXbaLP7+orZnbYuKMEpAo4HpanpYFCHtqOquaR
 IHcvsF7aay93SYcmAHG2q6QUKXlbFsqVRlF3aViCDhPi4TLdrqCdvoujSfNMRHApTQt2
 visG3ebUtbRSAmTdMecC47XjiGFGt1YZWLM3BWC8AOz/7RoI28kcHP28zDNslwJf+4ZC
 8g8A==
X-Gm-Message-State: AOJu0YxEHUrndJNAewkPtEEyJ+5yPmleodORVh+2vGptLy38IOwcMZxW
 JP3pwsSiBXxBHJZPKr+MlPngbmicI3YQmFfdZJMLyR4u8WZJXcgtVcOLeyBx9S5pAD290zmoFP6
 lP3TIA1mDl0mKJH4+/kQCbh9iqDn+PTp/3glYTdWWHzR81IHTnPkIR/qIlbsN+Mel9LgUh7Id1V
 56r6FarhdcTTtCc61qNvHEgirLGBFfDE1c9w==
X-Gm-Gg: ASbGncs0qVh7ZOTwQbr+LtwsnKyBxo63gt7prh8NXg2vt7GH9oPuq/8WiAluE0OOQl+
 4+xP/LSDLbB8VYlhV12iwqMNo14MUO3Vet2NTA4x5uuNnNfEk2C0S3coINT4jnLhwm10YvMTJLJ
 etDtY711WQ9/kEsmSuaLasVJYNVieFLTQRRKrHCITuVvARcL6t4romGXXO6/XJSwjbY7EoDCujm
 AsBo6q+pSlImyW+dGkMtkMWy89+YOb/nVnIoxz1yQEK6YTKXgp7XuqlI497oRdWWXB+xO1nXuIQ
 Ekh7HbPFwSYuwjdeUnL4JHMEujzcZysn
X-Received: by 2002:a05:600c:1da8:b0:456:1006:5415 with SMTP id
 5b1f17b1804b1-45892b92eb2mr101941035e9.6.1754058337608; 
 Fri, 01 Aug 2025 07:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl0NeQa4oobAXZ1gqHmJj27ixyO2S+aobjlaO9fdfdKRxhWHZg95Kc9OXyJpN1+EvwMq47qQ==
X-Received: by 2002:a05:600c:1da8:b0:456:1006:5415 with SMTP id
 5b1f17b1804b1-45892b92eb2mr101940645e9.6.1754058337116; 
 Fri, 01 Aug 2025 07:25:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458af77e7d5sm12689775e9.0.2025.08.01.07.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:36 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 15/17] intel_iommu: Allow both Status Write and Interrupt Flag
 in QI wait
Message-ID: <e8145dcd311b58921f3a45121792cbfab38fd2f6.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

FreeBSD does both, and this appears to be perfectly valid. The VT-d
spec even talks about the ordering (the status write should be done
first, unsurprisingly).

We certainly shouldn't assert() and abort QEMU if the guest asks for
both.

Fixes: ed7b8fbcfb88 ("intel-iommu: add supports for queued invalidation interface")
Closes: https://gitlab.com/qemu-project/qemu/-/issues/3028
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index fe9a5f2872..83c5e44413 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2828,6 +2828,7 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 {
     uint64_t mask[4] = {VTD_INV_DESC_WAIT_RSVD_LO, VTD_INV_DESC_WAIT_RSVD_HI,
                         VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+    bool ret = true;
 
     if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
                                      __func__, "wait")) {
@@ -2839,8 +2840,6 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
         uint32_t status_data = (uint32_t)(inv_desc->lo >>
                                VTD_INV_DESC_WAIT_DATA_SHIFT);
 
-        assert(!(inv_desc->lo & VTD_INV_DESC_WAIT_IF));
-
         /* FIXME: need to be masked with HAW? */
         dma_addr_t status_addr = inv_desc->hi;
         trace_vtd_inv_desc_wait_sw(status_addr, status_data);
@@ -2849,18 +2848,22 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
                              &status_data, sizeof(status_data),
                              MEMTXATTRS_UNSPECIFIED)) {
             trace_vtd_inv_desc_wait_write_fail(inv_desc->hi, inv_desc->lo);
-            return false;
+            ret = false;
         }
-    } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
+    }
+
+    if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
         /* Interrupt flag */
         vtd_generate_completion_event(s);
-    } else {
+    }
+
+    if (!(inv_desc->lo & (VTD_INV_DESC_WAIT_IF | VTD_INV_DESC_WAIT_SW))) {
         error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
                           " (unknown type)", __func__, inv_desc->hi,
                           inv_desc->lo);
         return false;
     }
-    return true;
+    return ret;
 }
 
 static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
-- 
MST


