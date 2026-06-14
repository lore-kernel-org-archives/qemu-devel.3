Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6B2CD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAD-0007Wd-9s; Sun, 14 Jun 2026 15:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAB-0007WJ-Jc
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqA9-0001iu-VZ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34ZF7kP1Cw8CG+J52COEqtjiniPCM5H5FgXYvWHG2n4=;
 b=QKkozSJfNkDabvk1dJzM3F+YdTlmrdFm8BQl8MKlK3k/wEafR0wt2Zc3Y0sqzO+ucc5PX0
 etHOigG+KijvtKyQXZZhYU5I5+c7Rg4iX7JBZ+q408715Dbbgrk+r3o21ePXM1iOxznRjU
 yqPBVrPo4doTVyoYCvKEi1Bv8dJXpB4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-K3FVfLcgMges0skVipenRA-1; Sun, 14 Jun 2026 15:06:28 -0400
X-MC-Unique: K3FVfLcgMges0skVipenRA-1
X-Mimecast-MFC-AGG-ID: K3FVfLcgMges0skVipenRA_1781463987
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490c840efe6so31074975e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463987; x=1782068787; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=34ZF7kP1Cw8CG+J52COEqtjiniPCM5H5FgXYvWHG2n4=;
 b=EZYwi2ZWDa8zhc0EOtY1rqEQQdddDuhTwYYVN1DMFub6OLF4Rs30gS1BfMmU5KoiTd
 8hLcRArB82OYF1aGdGB+a27JQmril30PqXBQGvNuy5LfuMiolY1sCXBtqAjmS2sYajg1
 f1MUhmHyb3ZhJPx3nJRcR3i76IasAN9aJ0nKdLEDVoHMIL6vbK1Dl83ldss+Igz68oQr
 fXTSsHmsx3F1ZxDacPwph9cdBWqxJ+T2ZaNYXvckDF6LVDzNxEW3HYi0hOZC266Pczc8
 GzaTVrDL6JsQk7T0qTgH5CXGOGu8yaNcGS1oxdBvngEcscMRvM53vNErxA7S+QJCisLc
 hZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463987; x=1782068787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34ZF7kP1Cw8CG+J52COEqtjiniPCM5H5FgXYvWHG2n4=;
 b=lDAgyQZZTkZC7kdsCOeczo0sY05NovAV/6QEPQ3S/J+EUwtcXWQaViWNv0cb7Qh4QJ
 D/Pfv2Qkf0TfPGVly/eWAbsfNeHKNAeoD2JdghJA0QLllkQHF+aG3DQP/o9YqrIRw3uA
 ZPx5fvLYiWDxUVNjxD0XzNVkJvFtqhzDEzLS/luJmDH/OcZO+4tb9nKdTUXIk2bHhUy7
 Uu44j9V6+egDsAgZvDJxjcl3smpPigobjWUCHa/xHXH09cKwoag5hWLFpuycXFjb5G/2
 pdAbr0k/Ghtm2enYiUQcEZyXVLAXNVyT69aST9238Vy6xjiDBukxncAv9WRG8dAnA0ZE
 Rayw==
X-Gm-Message-State: AOJu0YysDqeHw6L9j9ju2RBqsVt5FZ8pKUnrMVSykH+jkHvp72jlln5g
 QlI8LZ9nrvPxiOIDrchtf0puk/brAMEdIjlZyLdgeGaqsxkWu0iFX6PprZVQ5K4bjgfDM/8OZbm
 fVSPzpTZI17NMdyfNvoVMxbAQuRefpbL0hMF0MbJlLyXx+fRx8lII1Y89xwJt8cqTVBNc0ufyUC
 N9h9EmdDqgod8mRzTuPDS1ghmM6LoPmlEUAg==
X-Gm-Gg: Acq92OGttgCgoCUFfoIkepIL3v87pDRD1fi0M/Zctev/CJA4GgbEPLmnC1vN/76JPYr
 KH31vgMa11scC77OeEa3h+CCA0vSrn7AVGdTBf3HarnOkKl81cLdwLdhG0NUyuIX9bAbScbfLFW
 dFv7w1J3LjOOT/60OBPU0PIsjbiaHnGei3kSXODLuN7wFQ9HxEY6W+80u+d0NZQdHozas5rS2u8
 RLRdcplSvFED+lA7V0sesLezx6DML8Ozz00LYSonTO9t0jssXV/L9lJ/zMRbaiKy33luvOqmx4x
 VeD/aUdZINGCJqTR5LS9rnrjKvn1CqLD56I0BB+EfRRp1juNhfBQ8OXgLjlbutM6JXAF3/brPoP
 WD0lUvgzWaqkpuGet0x6xTOl5uJFADJMK3J3wgg3/gro=
X-Received: by 2002:a05:600c:340a:b0:490:4035:323 with SMTP id
 5b1f17b1804b1-490ea9dc03amr87178365e9.9.1781463986868; 
 Sun, 14 Jun 2026 12:06:26 -0700 (PDT)
X-Received: by 2002:a05:600c:340a:b0:490:4035:323 with SMTP id
 5b1f17b1804b1-490ea9dc03amr87178155e9.9.1781463986397; 
 Sun, 14 Jun 2026 12:06:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d28sm27631245f8f.20.2026.06.14.12.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:26 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 017/106] intel_iommu_accel: Handle PASID entry removal for
 pc_inv_dsc request
Message-ID: <8f3301bde02620fcbd4ad337bb2cb9505fa2060f.1781463125.git.mst@redhat.com>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

When guest deletes PASID entries, QEMU will capture the pasid cache
invalidation request, walk through pasid_cache_list in each passthrough
device to find stale VTDAccelPASIDCacheEntry and delete them.

Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-13-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.c | 61 +++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index d2653f22ee..ed0d6bda7e 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -280,6 +280,59 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
 }
 
+static void vtd_accel_delete_pc(VTDAccelPASIDCacheEntry *vtd_pce)
+{
+    QLIST_REMOVE(vtd_pce, next);
+    g_free(vtd_pce);
+}
+
+static void
+vtd_accel_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
+                                     VTDPASIDCacheInfo *pc_info)
+{
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
+    VTDPASIDEntry pe;
+    uint16_t did;
+
+    /*
+     * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI require
+     * DID check. If DID doesn't match the value in cache or memory, then
+     * it's not a pasid entry we want to invalidate.
+     */
+    switch (pc_info->type) {
+    case VTD_INV_DESC_PASIDC_G_PASID_SI:
+        if (pc_info->pasid != vtd_pce->pasid) {
+            return;
+        }
+        /* Fall through */
+    case VTD_INV_DESC_PASIDC_G_DSI:
+        did = VTD_SM_PASID_ENTRY_DID(&vtd_pce->pasid_entry);
+        if (pc_info->did != did) {
+            return;
+        }
+    }
+
+    if (vtd_dev_get_pe_from_pasid(vtd_hiod->iommu_state, vtd_hiod->bus,
+                                  vtd_hiod->devfn, vtd_pce->pasid, &pe)) {
+        /*
+         * No valid pasid entry in guest memory. e.g. pasid entry was modified
+         * to be either all-zero or non-present. Either case means existing
+         * pasid cache should be invalidated.
+         */
+        vtd_accel_delete_pc(vtd_pce);
+    }
+}
+
+static void vtd_accel_pasid_cache_invalidate(VTDHostIOMMUDevice *vtd_hiod,
+                                             VTDPASIDCacheInfo *pc_info)
+{
+    VTDAccelPASIDCacheEntry *vtd_pce, *next;
+
+    QLIST_FOREACH_SAFE(vtd_pce, &vtd_hiod->pasid_cache_list, next, next) {
+        vtd_accel_pasid_cache_invalidate_one(vtd_pce, pc_info);
+    }
+}
+
 /*
  * This function walks over PASID range within [start, end) in a single
  * PASID table for entries matching @info type/did, then create
@@ -411,6 +464,14 @@ void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
                                  TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
             continue;
         }
+
+        /*
+         * The replay path inevitably needs to iterate through existing
+         * PASID cache entries. Since cached PASID entries that are marked
+         * for removal don't need to be iterated, we intentionally handle
+         * removals before additions to optimize the replay process.
+         */
+        vtd_accel_pasid_cache_invalidate(vtd_hiod, pc_info);
         vtd_accel_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
     }
 }
-- 
MST


