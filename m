Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0088AC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBD-0007I0-Ex; Fri, 11 Sep 2026 05:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAV-0004Ph-4I
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAR-0008Ja-Uo
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BDaUJ5n6w1ultc7lfv5pJdGM89J/WSuiZOQnoJO8Zqs=;
 b=Vkgf9iW2+iGxwEWXG7v/5Z/pTlc4JGpqctbYpHdExP+eC0uKq5Sr8+bjlZ+hhClMFZiFXw
 XT8w15RiK9Mz1a/xqJgccQWycp+TH3CHvDXw8ieseao9GTHn6aKVkJub1Fgf9DOs0FMi0x
 VkmVsg7roUtaErLrnmKcfav09ga2YhA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-nwV1CcEuNxGqThK_onToLg-1; Fri, 11 Sep 2026 05:03:28 -0400
X-MC-Unique: nwV1CcEuNxGqThK_onToLg-1
X-Mimecast-MFC-AGG-ID: nwV1CcEuNxGqThK_onToLg_1789117407
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48439eea716so326660f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117407; x=1789722207; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BDaUJ5n6w1ultc7lfv5pJdGM89J/WSuiZOQnoJO8Zqs=;
 b=anjD7uhffufuEOSrcesWuDjF+/UYoIFx1FDbuYf3SBTpxleqlx0Go0iYFFVTCG5o16
 V6ao6wmZXCsIwK4mRVaPt3KDlwLFzB7yJVbzeiQu0Q1G5YLD/h7F1oXvsTassK8Ib51B
 A2J1NVJjlrVx/MWGqrqlJTgK2E7JLaTx/tSHKVsJSc9XKrAgCEkgDrHa+bc4qv3GlWji
 hI19KB6nxi3KWcGhiutOx542BATkvPHRqcQBbDClMyoJe2oWtB1u2gJl0qi5X/p7jpBQ
 bWpdQjygjvgvceZX5R2gqWG3FAbfR/eBi9GQ73YwWeBSfV1KWcEdb/A8rk7IsfoywYva
 cVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117407; x=1789722207;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BDaUJ5n6w1ultc7lfv5pJdGM89J/WSuiZOQnoJO8Zqs=;
 b=ToTIzewImB03xslEuPTD747CsyVPpr8bbGrpV3OkdnZMLQvCHTjqSCZ0G+jI+6BndU
 I0YD/l/YEFfnr6aYkrZt8+r2ZjtwgWxr6+aRyn6jLDpxuV1tGSCAbDGEB3kI/mPHoH4k
 7Xi4t2vvB83fsNhH0nDdnfYcaqweI93KFEWiW3uG1tk4fy+nJmvFzQKzUXdGji+t/x6x
 ywcbXU5TIGSlzzmp+H3jTIE/+89QqfwVPUD9ahkehzeAgyZyyp+4atNoBJmgjkSAUrrf
 lqh/l70KNNELXzBz6/ulC1NuWTLDQMMWmS37iXsXSgAa87Gx2KFfW2reCvFDGVyQTJBk
 o25A==
X-Gm-Message-State: AFuF++maxve+E2LtYuXcsE/awKF+6Meio/pzLvdo9w6z3gdDdCk7IQ/9
 Qxw+gi7Nttq1bMWCNDprW+p3HwJfjb8ZXuPr5NETOOnoF1ri1KPrBIpThAkQGEO7e6j14ZFzd92
 pofzFfn49PTxNYKczGXIsD/0bQRjxY5oiYippsN1g3MvvvWmntRMiQQ0qO9PoGxiZTclPpqqf+n
 nl74CkvZVd9840EELO2bCYRLxDtkjmZolohw==
X-Gm-Gg: AYBFou0bR454DaI/cMfwfQMGgtcjMvIxSGH1NC3UuoMwa+2QteOQia3obv/abSSz67d
 XgQCSuA5G5RUejx03MFWnNbGZF7mldj/4VfaE1hTiSGKnDxLmyU9tP+FNRecVAKq9IoluueMnfF
 OcqTlSp/h/xNbEPFGX2K5/XmaKg20UoLCIKMll8QdQCqIkOB7wyI+Jt1bm5E6uTIqCKykErd/mR
 kGrqHhcDsCDdkX7ky6xhPhfnim0+kflveu1FuRixowZ1bWqHYlZWnWeLkVFCsus3T0zBhTVuToh
 8o5nAxinjHu/EThPzgW+ViK5gZsq2aDEIRYNBL35CfYRURoeOAhHse0K3pESQ0KrOXN4D/WxBwo
 f/cwXbok2zHtxNouSt6LjWpw=
X-Received: by 2002:a05:600c:a05:b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49e619a0499mr34312205e9.7.1789117406665; 
 Fri, 11 Sep 2026 02:03:26 -0700 (PDT)
X-Received: by 2002:a05:600c:a05:b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49e619a0499mr34310955e9.7.1789117405817; 
 Fri, 11 Sep 2026 02:03:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60abab54sm60624535e9.5.2026.09.11.02.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:25 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 53/75] linux-headers: Update to Linux v7.3-rc1
Message-ID: <80661b84c384d4e40f3ccc8e9c8a2be35a624e7f.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Albert Esteve <aesteve@redhat.com>

VIRTIO_ID_MEDIA was added previously, synchronize the rest
of the headers to the same version.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260821135038.2676679-1-aesteve@redhat.com>
---
 include/standard-headers/linux/ethtool.h |  6 +++
 linux-headers/linux/iommufd.h            | 45 ++++++++++++++++++--
 linux-headers/linux/userfaultfd.h        | 54 ++++++++++++++++++++++--
 linux-headers/linux/vduse.h              | 28 ++++++++++++
 linux-headers/linux/vfio.h               | 21 +++++++++
 linux-headers/linux/vfio_zdev.h          |  2 +
 6 files changed, 149 insertions(+), 7 deletions(-)

diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index 55f608c3a7..622d634d04 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -2015,7 +2015,13 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT	= 39,
 	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT		= 40,
 	ETHTOOL_LINK_MODE_1000baseX_Full_BIT	= 41,
+
+	/* Despite the "baseCR" in 10000baseCR, this is not an IEEE 802.3 baseCR
+	 * It represents SFF-8431 Appendix-E SFP+ Direct Attach (10G-SFI-DA).
+	 * The name is kept as-is for uAPI backward compatibility.
+	 */
 	ETHTOOL_LINK_MODE_10000baseCR_Full_BIT	= 42,
+
 	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT	= 43,
 	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT	= 44,
 	ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT	= 45,
diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index 10c600d71e..3c61caadbf 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
 };
 
 /**
@@ -219,6 +220,33 @@ struct iommu_ioas_map {
 };
 #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
 
+/**
+ * struct iommu_ioas_noiommu_get_pa - ioctl(IOMMU_IOAS_NOIOMMU_GET_PA)
+ * @size: sizeof(struct iommu_ioas_noiommu_get_pa)
+ * @flags: Reserved, must be 0 for now
+ * @ioas_id: IOAS ID to query IOVA to PA mapping from
+ * @__reserved: Must be 0
+ * @iova: IOVA to query
+ * @length: On input, non-zero maximum number of bytes to query starting from
+ *          @iova. On output, number of physically contiguous bytes starting
+ *          from @out_phys, capped by the input length.
+ * @out_phys: Output physical address the IOVA maps to
+ *
+ * Query the physical address backing an IOVA range. The beginning of the
+ * range must be mapped already and length must be non-zero. For noiommu
+ * devices doing unsafe DMA only.
+ */
+struct iommu_ioas_noiommu_get_pa {
+	__u32 size;
+	__u32 flags;
+	__u32 ioas_id;
+	__u32 __reserved;
+	__aligned_u64 iova;
+	__aligned_u64 length;
+	__aligned_u64 out_phys;
+};
+#define IOMMU_IOAS_NOIOMMU_GET_PA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA)
+
 /**
  * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
  * @size: sizeof(struct iommu_ioas_map_file)
@@ -574,11 +602,22 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * enum iommu_hw_info_arm_smmuv3_flags - Flags for ARM SMMUv3 hw_info
+ * @IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI:
+ *    If set, user space must issue TLBI/CFGI+SYNC commands twice due to
+ *    hardware erratum T264-SMMU-3. See the description at
+ *    arm_smmu_erratum_repeat_tlbi_cfgi_key.
+ */
+enum iommu_hw_info_arm_smmuv3_flags {
+	IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI = 1 << 0,
+};
+
 /**
  * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware information
  *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
  *
- * @flags: Must be set to 0
+ * @flags: Combination of enum iommu_hw_info_arm_smmuv3_flags
  * @__reserved: Must be 0
  * @idr: Implemented features for ARM SMMU Non-secure programming interface
  * @iidr: Information about the implementation and implementer of ARM SMMU,
@@ -594,7 +633,7 @@ struct iommu_hw_info_vtd {
  * idr[0]: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN , CD2L, ASID16, TTF
  * idr[1]: SIDSIZE, SSIDSIZE
  * idr[3]: BBML, RIL
- * idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K
+ * idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K, DS
  *
  * - S1P should be assumed to be true if a NESTED HWPT can be created
  * - VFIO/iommufd only support platforms with COHACC, it should be assumed to be
@@ -602,7 +641,7 @@ struct iommu_hw_info_vtd {
  * - ATS is a per-device property. If the VMM describes any devices as ATS
  *   capable in ACPI/DT it should set the corresponding idr.
  *
- * This list may expand in future (eg E0PD, AIE, PBHA, D128, DS etc). It is
+ * This list may expand in future (eg E0PD, AIE, PBHA, D128 etc). It is
  * important that VMMs do not read bits outside the list to allow for
  * compatibility with future kernels. Several features in the SMMUv3
  * architecture are not currently supported by the kernel for nesting: HTTU,
diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
index 4283de22d5..c8e99df952 100644
--- a/linux-headers/linux/userfaultfd.h
+++ b/linux-headers/linux/userfaultfd.h
@@ -25,7 +25,8 @@
 #define UFFD_API ((__u64)0xAA)
 #define UFFD_API_REGISTER_MODES (UFFDIO_REGISTER_MODE_MISSING |	\
 				 UFFDIO_REGISTER_MODE_WP |	\
-				 UFFDIO_REGISTER_MODE_MINOR)
+				 UFFDIO_REGISTER_MODE_MINOR |	\
+				 UFFDIO_REGISTER_MODE_RWP)
 #define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |	\
 			   UFFD_FEATURE_EVENT_FORK |		\
 			   UFFD_FEATURE_EVENT_REMAP |		\
@@ -42,10 +43,13 @@
 			   UFFD_FEATURE_WP_UNPOPULATED |	\
 			   UFFD_FEATURE_POISON |		\
 			   UFFD_FEATURE_WP_ASYNC |		\
-			   UFFD_FEATURE_MOVE)
+			   UFFD_FEATURE_MOVE |			\
+			   UFFD_FEATURE_RWP |			\
+			   UFFD_FEATURE_RWP_ASYNC)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
+	 (__u64)1 << _UFFDIO_SET_MODE |		\
 	 (__u64)1 << _UFFDIO_API)
 #define UFFD_API_RANGE_IOCTLS			\
 	((__u64)1 << _UFFDIO_WAKE |		\
@@ -54,13 +58,15 @@
 	 (__u64)1 << _UFFDIO_MOVE |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
-	 (__u64)1 << _UFFDIO_POISON)
+	 (__u64)1 << _UFFDIO_POISON |		\
+	 (__u64)1 << _UFFDIO_RWPROTECT)
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
-	 (__u64)1 << _UFFDIO_POISON)
+	 (__u64)1 << _UFFDIO_POISON |		\
+	 (__u64)1 << _UFFDIO_RWPROTECT)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
@@ -79,6 +85,8 @@
 #define _UFFDIO_WRITEPROTECT		(0x06)
 #define _UFFDIO_CONTINUE		(0x07)
 #define _UFFDIO_POISON			(0x08)
+#define _UFFDIO_RWPROTECT		(0x09)
+#define _UFFDIO_SET_MODE		(0x0A)
 #define _UFFDIO_API			(0x3F)
 
 /* userfaultfd ioctl ids */
@@ -103,6 +111,10 @@
 				      struct uffdio_continue)
 #define UFFDIO_POISON		_IOWR(UFFDIO, _UFFDIO_POISON, \
 				      struct uffdio_poison)
+#define UFFDIO_RWPROTECT	_IOWR(UFFDIO, _UFFDIO_RWPROTECT,	\
+				      struct uffdio_rwprotect)
+#define UFFDIO_SET_MODE		_IOW(UFFDIO, _UFFDIO_SET_MODE,	\
+				     struct uffdio_set_mode)
 
 /* read() structure */
 struct uffd_msg {
@@ -158,6 +170,7 @@ struct uffd_msg {
 #define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* If this was a write fault */
 #define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* If reason is VM_UFFD_WP */
 #define UFFD_PAGEFAULT_FLAG_MINOR	(1<<2)	/* If reason is VM_UFFD_MINOR */
+#define UFFD_PAGEFAULT_FLAG_RWP		(1<<3)	/* If reason is VM_UFFD_RWP */
 
 struct uffdio_api {
 	/* userland asks for an API number and the features to enable */
@@ -230,6 +243,18 @@ struct uffdio_api {
 	 *
 	 * UFFD_FEATURE_MOVE indicates that the kernel supports moving an
 	 * existing page contents from userspace.
+	 *
+	 * UFFD_FEATURE_RWP indicates that the kernel supports
+	 * UFFDIO_REGISTER_MODE_RWP for read-write protection tracking.
+	 * Pages are made inaccessible via UFFDIO_RWPROTECT and faults
+	 * are delivered when the pages are re-accessed.
+	 *
+	 * UFFD_FEATURE_RWP_ASYNC indicates asynchronous mode for
+	 * UFFDIO_REGISTER_MODE_RWP.  When set, faults on read-write
+	 * protected pages are auto-resolved by the kernel (PTE
+	 * permissions restored immediately) without delivering a message
+	 * to the userfaultfd handler.  Use PAGEMAP_SCAN with inverted
+	 * PAGE_IS_ACCESSED to find pages that were not re-accessed.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -248,6 +273,8 @@ struct uffdio_api {
 #define UFFD_FEATURE_POISON			(1<<14)
 #define UFFD_FEATURE_WP_ASYNC			(1<<15)
 #define UFFD_FEATURE_MOVE			(1<<16)
+#define UFFD_FEATURE_RWP			(1<<17)
+#define UFFD_FEATURE_RWP_ASYNC			(1<<18)
 	__u64 features;
 
 	__u64 ioctls;
@@ -263,6 +290,7 @@ struct uffdio_register {
 #define UFFDIO_REGISTER_MODE_MISSING	((__u64)1<<0)
 #define UFFDIO_REGISTER_MODE_WP		((__u64)1<<1)
 #define UFFDIO_REGISTER_MODE_MINOR	((__u64)1<<2)
+#define UFFDIO_REGISTER_MODE_RWP	((__u64)1<<3)
 	__u64 mode;
 
 	/*
@@ -356,6 +384,14 @@ struct uffdio_poison {
 	__s64 updated;
 };
 
+struct uffdio_rwprotect {
+	struct uffdio_range range;
+	/* !RWP means undo RWP-protection */
+#define UFFDIO_RWPROTECT_MODE_RWP		((__u64)1<<0)
+#define UFFDIO_RWPROTECT_MODE_DONTWAKE		((__u64)1<<1)
+	__u64 mode;
+};
+
 struct uffdio_move {
 	__u64 dst;
 	__u64 src;
@@ -374,6 +410,16 @@ struct uffdio_move {
 	__s64 move;
 };
 
+struct uffdio_set_mode {
+	/*
+	 * Toggle async mode for features at runtime.
+	 * Supported: UFFD_FEATURE_RWP_ASYNC.
+	 * Setting a bit in both enable and disable is invalid.
+	 */
+	__u64 enable;
+	__u64 disable;
+};
+
 /*
  * Flags for the userfaultfd(2) system call itself.
  */
diff --git a/linux-headers/linux/vduse.h b/linux-headers/linux/vduse.h
index e19b3c0f51..bab47129db 100644
--- a/linux-headers/linux/vduse.h
+++ b/linux-headers/linux/vduse.h
@@ -14,6 +14,12 @@
 
 #define VDUSE_API_VERSION_1	1
 
+/* The VDUSE instance expects a request for vq ready */
+#define VDUSE_F_QUEUE_READY	0
+
+/* The VDUSE instance expects a request for suspend */
+#define VDUSE_F_SUSPEND		1
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
@@ -63,6 +69,12 @@ struct vduse_dev_config {
  */
 #define VDUSE_DESTROY_DEV	_IOW(VDUSE_BASE, 0x03, char[VDUSE_NAME_MAX])
 
+/* Get the VDUSE supported features */
+#define VDUSE_GET_FEATURES	_IOR(VDUSE_BASE, 0x04, __u64)
+
+/* Set the VDUSE features */
+#define VDUSE_SET_FEATURES	_IOW(VDUSE_BASE, 0x05, __u64)
+
 /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
 
 /**
@@ -325,6 +337,8 @@ enum vduse_req_type {
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_SET_VQ_GROUP_ASID,
+	VDUSE_SET_VQ_READY,
+	VDUSE_SUSPEND,
 };
 
 /**
@@ -372,6 +386,15 @@ struct vduse_iova_range_v2 {
 	__u32 padding;
 };
 
+/**
+ * struct vduse_vq_ready - Virtqueue ready request message
+ * @num: Virtqueue number
+ */
+struct vduse_vq_ready {
+	__u32 num;
+	__u32 ready;
+};
+
 /**
  * struct vduse_dev_request - control request
  * @type: request type
@@ -382,6 +405,7 @@ struct vduse_iova_range_v2 {
  * @iova: IOVA range for updating
  * @iova_v2: IOVA range for updating if API_VERSION >= 1
  * @vq_group_asid: ASID of a virtqueue group
+ * @vq_ready: Virtqueue ready request
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -399,6 +423,10 @@ struct vduse_dev_request {
 		 */
 		struct vduse_iova_range_v2 iova_v2;
 		struct vduse_vq_group_asid vq_group_asid;
+
+		/* Only if VDUSE_F_QUEUE_READY is negotiated */
+		struct vduse_vq_ready vq_ready;
+
 		__u32 padding[32];
 	};
 };
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index f3282b8e86..c85dcbfe30 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -1534,6 +1534,27 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
+ * userspace for vfio-pci devices on s390. On s390, PCI error recovery
+ * involves platform firmware and notification to operating systems is done
+ * by architecture specific mechanism. Exposing this information to
+ * userspace allows it to take appropriate actions to handle an
+ * error on the device.
+ *
+ * Userspace provides an opaque buffer of fixed length, and the kernel
+ * fills it with the zpci_ccdf_err data structure. The length of
+ * zpci_ccdf_err is provided to userspace via the
+ * VFIO_DEVICE_INFO_CAP_ZPCI_BASE capability.
+ *
+ * The ioctl returns -ENOMSG if there are no pending PCI errors.
+ */
+struct vfio_device_feature_zpci_err {
+	__aligned_u64 data;
+};
+
+#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
diff --git a/linux-headers/linux/vfio_zdev.h b/linux-headers/linux/vfio_zdev.h
index 77f2aff1f2..d6c1175c88 100644
--- a/linux-headers/linux/vfio_zdev.h
+++ b/linux-headers/linux/vfio_zdev.h
@@ -32,6 +32,8 @@ struct vfio_device_info_cap_zpci_base {
 	/* End of version 1 */
 	__u32 fh;		/* PCI function handle */
 	/* End of version 2 */
+	__u32 ccdf_err_length;	/* PCI CCDF length */
+	/* End of version 3 */
 };
 
 /**
-- 
MST


