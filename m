Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECE1C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSGn-0004U0-NN; Mon, 14 Jul 2025 19:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGU-0003cO-JC
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGQ-0005Sr-5y
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ac5kQC28Wz5sTKphFJUv5ORfXNQ3SuWxyn60B2NigdE=;
 b=RuymoIwPz9vqwBhuDEWmjr3DUE4oqtS5eT+Hj7M3dLE0LsU2y4J2wzmOcgSvABp1ENP6ZS
 EaTmDF0oYWSwS6pXg+hWVn9Rr5fZMoQgLAxf8N7J/2IBcE0z4LisMUhnONmn7HgiiAv9MZ
 oAZiiwm7hurfJX5TF0XNiSlGqsNMXtk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-eCo8oCsqOJCDagnVij05SQ-1; Mon, 14 Jul 2025 19:07:08 -0400
X-MC-Unique: eCo8oCsqOJCDagnVij05SQ-1
X-Mimecast-MFC-AGG-ID: eCo8oCsqOJCDagnVij05SQ_1752534427
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45626e0d3e1so1099985e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534427; x=1753139227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ac5kQC28Wz5sTKphFJUv5ORfXNQ3SuWxyn60B2NigdE=;
 b=O8BnFpF04VcGvCEiEQhgIKq06BxSx1oyPOAfbIKAMnTQrp5rVrvCOxRuKR/Hnw+YEI
 GjFqWXOkrQUrywnPR4pdURYq8jj0+81PVI0UrQ0ig2qINo0qY9l+zElZo4Uo3bqylm//
 qwWFZkjhYCnkbav9bKvG0caKQaRAU3SIFn7q75wAHhVqa6zZ/+26mOmdl2zygBtf2xBN
 tQVZ3Dkp8hMu2x2LJ4V19oPtCfonqYzCUl0Ok2fGZkaZ+J9KK3Eu6HA0JQ3m6J3by3OA
 vBKiNzdw7plWmVNNcbZJCj14uMrbwQJ4ieeHIk0ap93zWzlX3Ua3+zAHATtSq5WY6ZOk
 aDjw==
X-Gm-Message-State: AOJu0YzJIPJZUGSzcGBQfhRc57cFpnkmMPZzWugviIbU++kWmOFXgVBq
 70VmKj5UoS/OnLAFqnl62qMbgVQF0BCCPirobLKc2txTYS+zQ30nbkl0tX+Hdht3EHu6Yue740j
 pT0hd9pOuxGXi6KOW0fYyyF0RTsQ2IBHDf19Vow6G1uyODTjbL5vvyZCGw9m7bNQByE4m97YEA7
 5vho2Mols6ztG3x2ymbxmy/asVVq+0pdj9yg==
X-Gm-Gg: ASbGncs5X44nauBknJHsLLyrLI64OZ+DYJX7LovnE3WdacaAOIQFqQuYajt12xPwWRv
 ZaQSqCp/MFXDdOPBOS6FWrRau1G8eGWUYHzyXI6ncWaCNutP38kAuMDFXjym2EGVP/zKUmhjXsI
 8dfC3Mc10IIl3cMhuVjmapZo/L8lUiL+0Tlin61Ul7ZZofIFLyiYBHXHRupflCXgryvT7jh5ct7
 7dPow4ls4r1puZuMYmKxCVDfrqiEqJwJl0ctoFjeWsCOfRVUWz/JLPMq9Uq5H7zEzGL4L3BTEIE
 xEtTREb3L6YVSMws45cDDMlwOQV5khZG
X-Received: by 2002:a05:6000:25ec:b0:3b4:b4d:6861 with SMTP id
 ffacd0b85a97d-3b5f18d98b6mr12383639f8f.27.1752534426591; 
 Mon, 14 Jul 2025 16:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhYjAS7nT/tYn58BN90w7GQ3aYvFmL+bStO/Kug1Q39DEg+brolPNLe35tZEZvDfYfh8UoYg==
X-Received: by 2002:a05:6000:25ec:b0:3b4:b4d:6861 with SMTP id
 ffacd0b85a97d-3b5f18d98b6mr12383618f8f.27.1752534426126; 
 Mon, 14 Jul 2025 16:07:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d785sm13820674f8f.59.2025.07.14.16.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:05 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-stable@nongnu.org, Vasant Hegde <vasant.hegde@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 20/97] amd_iommu: Fix masks for various IOMMU MMIO Registers
Message-ID: <108e10ff69099c3ebe147f505246be7c2ad2a499.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Address various issues with definitions of the MMIO registers e.g. for the
Device Table Address Register, the size mask currently encompasses reserved
bits [11:9], so change it to only extract the bits [8:0] encoding size.

Convert masks to use GENMASK64 for consistency, and make unrelated
definitions independent.

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250617150427.20585-5-alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index aacb29b617..988a485f80 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -68,34 +68,34 @@
 
 #define AMDVI_MMIO_SIZE               0x4000
 
-#define AMDVI_MMIO_DEVTAB_SIZE_MASK   ((1ULL << 12) - 1)
-#define AMDVI_MMIO_DEVTAB_BASE_MASK   (((1ULL << 52) - 1) & ~ \
-                                       AMDVI_MMIO_DEVTAB_SIZE_MASK)
+#define AMDVI_MMIO_DEVTAB_SIZE_MASK     GENMASK64(8, 0)
+#define AMDVI_MMIO_DEVTAB_BASE_MASK     GENMASK64(51, 12)
+
 #define AMDVI_MMIO_DEVTAB_ENTRY_SIZE  32
 #define AMDVI_MMIO_DEVTAB_SIZE_UNIT   4096
 
 /* some of this are similar but just for readability */
 #define AMDVI_MMIO_CMDBUF_SIZE_BYTE       (AMDVI_MMIO_COMMAND_BASE + 7)
 #define AMDVI_MMIO_CMDBUF_SIZE_MASK       0x0f
-#define AMDVI_MMIO_CMDBUF_BASE_MASK       AMDVI_MMIO_DEVTAB_BASE_MASK
-#define AMDVI_MMIO_CMDBUF_HEAD_MASK       (((1ULL << 19) - 1) & ~0x0f)
-#define AMDVI_MMIO_CMDBUF_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
+#define AMDVI_MMIO_CMDBUF_BASE_MASK       GENMASK64(51, 12)
+#define AMDVI_MMIO_CMDBUF_HEAD_MASK       GENMASK64(18, 4)
+#define AMDVI_MMIO_CMDBUF_TAIL_MASK       GENMASK64(18, 4)
 
 #define AMDVI_MMIO_EVTLOG_SIZE_BYTE       (AMDVI_MMIO_EVENT_BASE + 7)
-#define AMDVI_MMIO_EVTLOG_SIZE_MASK       AMDVI_MMIO_CMDBUF_SIZE_MASK
-#define AMDVI_MMIO_EVTLOG_BASE_MASK       AMDVI_MMIO_CMDBUF_BASE_MASK
-#define AMDVI_MMIO_EVTLOG_HEAD_MASK       (((1ULL << 19) - 1) & ~0x0f)
-#define AMDVI_MMIO_EVTLOG_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
+#define AMDVI_MMIO_EVTLOG_SIZE_MASK       0x0f
+#define AMDVI_MMIO_EVTLOG_BASE_MASK       GENMASK64(51, 12)
+#define AMDVI_MMIO_EVTLOG_HEAD_MASK       GENMASK64(18, 4)
+#define AMDVI_MMIO_EVTLOG_TAIL_MASK       GENMASK64(18, 4)
 
-#define AMDVI_MMIO_PPRLOG_SIZE_BYTE       (AMDVI_MMIO_EVENT_BASE + 7)
-#define AMDVI_MMIO_PPRLOG_HEAD_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
-#define AMDVI_MMIO_PPRLOG_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
-#define AMDVI_MMIO_PPRLOG_BASE_MASK       AMDVI_MMIO_EVTLOG_BASE_MASK
-#define AMDVI_MMIO_PPRLOG_SIZE_MASK       AMDVI_MMIO_EVTLOG_SIZE_MASK
+#define AMDVI_MMIO_PPRLOG_SIZE_BYTE       (AMDVI_MMIO_PPR_BASE + 7)
+#define AMDVI_MMIO_PPRLOG_SIZE_MASK       0x0f
+#define AMDVI_MMIO_PPRLOG_BASE_MASK       GENMASK64(51, 12)
+#define AMDVI_MMIO_PPRLOG_HEAD_MASK       GENMASK64(18, 4)
+#define AMDVI_MMIO_PPRLOG_TAIL_MASK       GENMASK64(18, 4)
 
 #define AMDVI_MMIO_EXCL_ENABLED_MASK      (1ULL << 0)
 #define AMDVI_MMIO_EXCL_ALLOW_MASK        (1ULL << 1)
-#define AMDVI_MMIO_EXCL_LIMIT_MASK        AMDVI_MMIO_DEVTAB_BASE_MASK
+#define AMDVI_MMIO_EXCL_LIMIT_MASK        GENMASK64(51, 12)
 #define AMDVI_MMIO_EXCL_LIMIT_LOW         0xfff
 
 /* mmio control register flags */
@@ -132,14 +132,14 @@
 #define AMDVI_DEV_TRANSLATION_VALID       (1ULL << 1)
 #define AMDVI_DEV_MODE_MASK               0x7
 #define AMDVI_DEV_MODE_RSHIFT             9
-#define AMDVI_DEV_PT_ROOT_MASK            0xffffffffff000
+#define AMDVI_DEV_PT_ROOT_MASK            GENMASK64(51, 12)
 #define AMDVI_DEV_PT_ROOT_RSHIFT          12
 #define AMDVI_DEV_PERM_SHIFT              61
 #define AMDVI_DEV_PERM_READ               (1ULL << 61)
 #define AMDVI_DEV_PERM_WRITE              (1ULL << 62)
 
 /* Device table entry bits 64:127 */
-#define AMDVI_DEV_DOMID_ID_MASK          ((1ULL << 16) - 1)
+#define AMDVI_DEV_DOMID_ID_MASK             GENMASK64(15, 0)
 
 /* Event codes and flags, as stored in the info field */
 #define AMDVI_EVENT_ILLEGAL_DEVTAB_ENTRY  (0x1U << 12)
@@ -197,7 +197,7 @@
 #define AMDVI_PAGE_SIZE  (1ULL << AMDVI_PAGE_SHIFT)
 
 #define AMDVI_PAGE_SHIFT_4K 12
-#define AMDVI_PAGE_MASK_4K  (~((1ULL << AMDVI_PAGE_SHIFT_4K) - 1))
+#define AMDVI_PAGE_MASK_4K      GENMASK64(63, 12)
 
 #define AMDVI_MAX_GVA_ADDR      (2UL << 5)
 #define AMDVI_MAX_PH_ADDR       (40UL << 8)
-- 
MST


