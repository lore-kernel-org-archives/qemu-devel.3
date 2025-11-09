Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B50CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6Vw-0002CU-IB; Sun, 09 Nov 2025 09:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vu-0002C9-FT
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vs-0001no-UA
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CWHbclnZjXpCqepcqPMo+sVS3js+OLhnZCkOniF4+6g=;
 b=Xpy5MM80L0F3UAwd/07TZLaxbwbT6pMUpSb1Fr0auxV/94rJ5Vm5DFSHkruMIwAUDSpLGR
 OMWW496MJKcz+NeaLJcsmwbIhzpmqvhX5mVf6rKyr1siPHyKGqtTeUlV6U+vW7msfp73HM
 pWN593DDXDLuSPlHuV5jQjL4W0bLooM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-syybwYipOnCd2ABNysUcPg-1; Sun, 09 Nov 2025 09:35:27 -0500
X-MC-Unique: syybwYipOnCd2ABNysUcPg-1
X-Mimecast-MFC-AGG-ID: syybwYipOnCd2ABNysUcPg_1762698926
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ecdb10a612so1226686f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698925; x=1763303725; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CWHbclnZjXpCqepcqPMo+sVS3js+OLhnZCkOniF4+6g=;
 b=lhe0VE1dqG6KjG305NkS5t46kD4hYoUwodqRQT3ZQFZwzKgUa2yEjoUysLPIc4hQ78
 VH1S6I+w0abbX92p7S7vgyaeSE7khrxo4oQ0g581eyRDrQ5Z8Y9z69GpfBi68BTBYAcl
 ArlEp/kk7flDVi06rghD/5XyQynbEx95NuwXNlYlWEtDWnD93Irs6LS7TpGTy6yKD7Ii
 nn7mfH01s6J3qpn1LFezP2DDhuvXFAQwGRNA1DEcary46tfLOYQxsXz9MjE8sp7LB22Q
 cfSq9gIdZex1eFj4J84SnWwVtkGxGE5wr/CVGUIjgw6jVJUXWdKKOfrOcsIDhAr1g2UX
 2ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698925; x=1763303725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWHbclnZjXpCqepcqPMo+sVS3js+OLhnZCkOniF4+6g=;
 b=qanL2Gm9U02/SUEzlxCkCfU2cTlcBkMkNr0D/88VU1lxvQ1rLjcELKnqMCHD8sdXHA
 XTc4AJ0ZbJZL9dh8JLPnF65JONR9/2q2JR5nNUxhVGSBpaGj63bMyZ9CgnS8tLRCPaU/
 ZmsSTg0YHWFdMbBndAyiuxezVE1LuQfP8isLhfUjYMJFBExivT80BkOSdw4L+4alKNw+
 ezNdTGF38RYVZZJfMOjPMD+1DLeA4cGtUfdF4j/GRLK9vyNfFavENQSm0fJr26Hlo7pN
 LFziujIc8F3HELsJnElF4rKkrwx9oNCxtJaxOex74W4rYpmbzyqJ4gDTmLQzWJbV+HsH
 LpqQ==
X-Gm-Message-State: AOJu0Yy++slDhjHVJapLd6zRXs9BYXpyRL+L/iOzqfONgvvxtfMBWJby
 apIr6x4mNPQsD3nctKznN67L4Gtvwbz8dProPbeGU5OyuGM41I0BaaSZbSo6VhvcLuwBwCE++/J
 dy5+JoFVHe99Rz7hxtZBE31RwQOFz2k6Jvo0tYcOtBOI7zqf034cMLtux0Vei+3JRSgTvYn4MT/
 /O5EqJRZWbwaorvXHapAEGFrny89tS1EQMZQ==
X-Gm-Gg: ASbGncuLRQqIFnD3fkf9iE8l1rh+DpuXhJREJVg8WUQoNTuQpx6QsgSe49abhN/kZ+5
 +QMbXar7JH+1eoJz7g+hq38fLz4xLM1wtFbf+QBGm8tsb2lottzHZX6e4dSoKmInzIXkDtyEcF5
 +KRLBCyiJ0Th+u4B71pvnCuE2h0Dya+sxkyYdvxlTPX4b2FNGPsr/AuIyNbOn7FKNnxoFJVD1+X
 uD2nG+eUey8yZ9cNiIpvNpDiOYlYO/0/IAV91c9/THGrGMyt4h+8ODj3ZoIO7hFHLY9uvfuQAii
 Cp4kZgcsUxG+1XnKeIqJmg5tJWA8oq77X62K/2YR3Z/E2KJBTiZKRKgEVBDpTFUykmM=
X-Received: by 2002:a05:6000:1a8d:b0:426:f10c:c512 with SMTP id
 ffacd0b85a97d-42b2dcb7e82mr4293363f8f.43.1762698925399; 
 Sun, 09 Nov 2025 06:35:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyJQA33MPPPc3pBTqSi87TnHIlyDbsFjCaGZKiXheqlxK1CQY33YUh45BhHhv3MX35yWWYFg==
X-Received: by 2002:a05:6000:1a8d:b0:426:f10c:c512 with SMTP id
 ffacd0b85a97d-42b2dcb7e82mr4293338f8f.43.1762698924957; 
 Sun, 09 Nov 2025 06:35:24 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2dd927c9sm10139909f8f.27.2025.11.09.06.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:24 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 07/14] intel_iommu: Fix DMA failure when guest switches IOMMU
 domain
Message-ID: <c9cf33075a4c8eb299e0ac3bb67ad96490499ced.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Kernel allows user to switch IOMMU domain, e.g., switch between DMA
and identity domain. When this happen in IOMMU scalable mode, a pasid
cache invalidation request is sent, this request is ignored by vIOMMU
which leads to device binding to wrong address space, then DMA fails.

This issue exists in scalable mode with both first stage and second
stage translations, both emulated and passthrough devices.

Take network device for example, below sequence trigger issue:

1. start a guest with iommu=pt
2. echo 0000:01:00.0 > /sys/bus/pci/drivers/virtio-pci/unbind
3. echo DMA > /sys/kernel/iommu_groups/6/type
4. echo 0000:01:00.0 > /sys/bus/pci/drivers/virtio-pci/bind
5. Ping test

Fix it by switching address space in invalidation handler.

Fixes: 4a4f219e8a10 ("intel_iommu: add scalable-mode option to make scalable mode work")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251017093602.525338-4-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index cf0b62f29e..78b142ccea 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3086,6 +3086,11 @@ static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
     return vtd_ce_get_rid2pasid_entry(s, &ce, pe, vtd_as->pasid);
 }
 
+static int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
+{
+    return memcmp(p1, p2, sizeof(*p1));
+}
+
 /* Update or invalidate pasid cache based on the pasid entry in guest memory. */
 static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
                                         gpointer user_data)
@@ -3094,15 +3099,28 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     VTDAddressSpace *vtd_as = value;
     VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
     VTDPASIDEntry pe;
+    IOMMUNotifier *n;
     uint16_t did;
 
     if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
+        if (!pc_entry->valid) {
+            return;
+        }
         /*
          * No valid pasid entry in guest memory. e.g. pasid entry was modified
          * to be either all-zero or non-present. Either case means existing
          * pasid cache should be invalidated.
          */
         pc_entry->valid = false;
+
+        /*
+         * When a pasid entry isn't valid any more, we should unmap all
+         * mappings in shadow pages instantly to ensure DMA security.
+         */
+        IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
+            vtd_address_space_unmap(vtd_as, n);
+        }
+        vtd_switch_address_space(vtd_as);
         return;
     }
 
@@ -3128,8 +3146,15 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
         }
     }
 
-    pc_entry->pasid_entry = pe;
-    pc_entry->valid = true;
+    if (!pc_entry->valid) {
+        pc_entry->pasid_entry = pe;
+        pc_entry->valid = true;
+    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
+        return;
+    }
+
+    vtd_switch_address_space(vtd_as);
+    vtd_address_space_sync(vtd_as);
 }
 
 static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
-- 
MST


