Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497E3CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAI-0007YL-9i; Sun, 14 Jun 2026 15:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAH-0007YB-9e
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAF-0001kQ-Qi
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H5rmLf8agTT2XE/uJbv+8yNIdtm0RP3nvuuT/Alb5WQ=;
 b=FA3ECZiU7PYLIuj3SegeSU5zJ5sSkvinopBhXGMa7UXzJJZl1sJBp7B4ilP3Pn9UC4kvvo
 1xJvZFvuLVj3WgVBt/SPTsS77tnztu9T8i1hURG9nPcKWLZXfJh43fV2beOjAuL5cuukHp
 qY/tNI3OhM6YAx2tJxzy5tRBeT/hXp4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-nGLHfa2hNuWNxbPWIBYmNQ-1; Sun, 14 Jun 2026 15:06:34 -0400
X-MC-Unique: nGLHfa2hNuWNxbPWIBYmNQ-1
X-Mimecast-MFC-AGG-ID: nGLHfa2hNuWNxbPWIBYmNQ_1781463993
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490c4f61a34so17528395e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463993; x=1782068793; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H5rmLf8agTT2XE/uJbv+8yNIdtm0RP3nvuuT/Alb5WQ=;
 b=f0emrWwLYP26ENiwZF7kMi3xiJ9v4aXu/K6ZPLA5annCD/UfYlos7izn1qfUbFv8i3
 B7W5aGL6qaLU1Oui19VcSN3kd7VEeDm3D7qVl0FvgoBXiN7k3oezn6ZYdml5CpkzGm5+
 V6lSHpD+0g28Agm9o+lzcr72JgawK4kS97sRjiXfAkXQ6n1VxabR9JTI7buutIhW0V/B
 OzUkQ+Rmm498ED/FlnSn9UeRGJp69mVfqXL1kYJLMY2gJhqjXzJbd5UThfYFZQmuPTv3
 2SaKf/Yxubn1eCcIx/09ctdFDZ31V8lKHNY4KBFuIvBKv0+7UzFRqbdDE/BNjeDgn5vo
 fFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463993; x=1782068793;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5rmLf8agTT2XE/uJbv+8yNIdtm0RP3nvuuT/Alb5WQ=;
 b=HhJiu8HkRzP20VKj/4XZMmv0Sj0DGu8+k67F2zHor52PHk9lrLF3TX8VvM2/QWgQqK
 OgMe1MLMf29rYFLl+L/1Nctdrl01Te7VxEI+KnCGmp2R6Ze5dRfJ7/zhQ7zBjKUlSr9P
 tEHOK3TCKt9ClSSzmNE/P3oXbpmra+DlchcgiO4PsjhKSkkp5VcBq97n8ihs6NkinmsA
 xQWTvvSQiq7fqN7pIsogoWSytbVVarJpRyi7ySmml5S2wcRdKJ44vq5+GoZB+YBV7EjM
 eQKEIgtNkvE3ArDYER/CPsjgYZqAqA7LEbq+QSMGL1yNAKnOomtNPJoAI/8Q4zAoH0W0
 ibpA==
X-Gm-Message-State: AOJu0YwM7VM/Z+meBOcNgrwT5WAonIwJSN9XMjIvKCN+5MZ3kYa8cnXE
 5FpyRIU03/fko1fCB4Dvr62wDUqb3Iyd8yo/ZOPl0uaELlt7aoUALcMJK2QW9+PM1Qthb9xCmcb
 KFULb9+Tu3NU9YjCBdcz0xi2GCBe+QbCILeoJq7JQgvSNs/N33h4oUysEFDXw4FEUmIsqnTlqSx
 DCo420BhBJsWqQszJ462UqmA5v76YvahUV9w==
X-Gm-Gg: Acq92OF7eBpLq8upPlyPnB41B3UfGaiPYeSFMRSvDpWf/C7lSPlAvSYiu3zvF4VAcvz
 s1f1XX/3uX6YGfDyh5LdVUhrP0SjdK+C+QahqPk6YTBd0gNjH+Ean0847TqMNsfxmXjgIO7Qrla
 rmrp9kQAvvKBo9SSq1cnZqcNKFEQ+CUzZUKNvAh6zDpuxSn1cX30dTbyy1um7+xHDk6IYm3n1Eb
 7H1yiVwhA7BZPa5T3TS9aN54cZxG9Idf54YqZ1LaTTx6LFHAICnzgtBxzISCs+EJ//mXm3HaFFr
 40oXxAdlZcYEyzGtzI2tG98yG5g3aVBaYJmQLptu/n985016Gie5c56Til2733i8FA7AM89m+zC
 /VYG+TRAmpts+/EmWFtlcUXdWMKeTZvImkBltIoXhRWM=
X-Received: by 2002:a05:600c:c107:b0:490:e196:eaee with SMTP id
 5b1f17b1804b1-490ec509c52mr162075755e9.10.1781463992678; 
 Sun, 14 Jun 2026 12:06:32 -0700 (PDT)
X-Received: by 2002:a05:600c:c107:b0:490:e196:eaee with SMTP id
 5b1f17b1804b1-490ec509c52mr162075325e9.10.1781463992120; 
 Sun, 14 Jun 2026 12:06:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220308f13sm192912945e9.5.2026.06.14.12.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:30 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 019/106] intel_iommu_accel: Handle PASID entry removal for
 system reset
Message-ID: <b583cdbb0ebd62d9e2fe678f4620a2827d159038.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

When system level reset, DMA translation is turned off, all PASID
entries become stale and should be deleted.

vtd_hiod list is never accessed without BQL, so no need to guard with
iommu lock.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-15-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c       |  2 ++
 hw/i386/intel_iommu_accel.c | 13 +++++++++++++
 hw/i386/intel_iommu_accel.h |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8e034efdfc..0b341f741e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -391,6 +391,8 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_reset_context_cache_locked(s);
     vtd_pasid_cache_reset_locked(s);
     vtd_iommu_unlock(s);
+
+    vtd_accel_pasid_cache_reset(s);
 }
 
 static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index b823c405a1..8308eb00cb 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -486,6 +486,19 @@ void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
     }
 }
 
+/* Fake a global pasid cache invalidation to remove all pasid cache entries */
+void vtd_accel_pasid_cache_reset(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info = { .type = VTD_INV_DESC_PASIDC_G_GLOBAL };
+    VTDHostIOMMUDevice *vtd_hiod;
+    GHashTableIter hiod_it;
+
+    g_hash_table_iter_init(&hiod_it, s->vtd_host_iommu_dev);
+    while (g_hash_table_iter_next(&hiod_it, NULL, (void **)&vtd_hiod)) {
+        vtd_accel_pasid_cache_invalidate(vtd_hiod, &pc_info);
+    }
+}
+
 static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
                                           void *caps, uint32_t size)
 {
diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index c9b1823745..a2226b28b6 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -28,6 +28,7 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint32_t pasid, hwaddr addr,
                                       uint64_t npages, bool ih);
 void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
+void vtd_accel_pasid_cache_reset(IntelIOMMUState *s);
 void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
@@ -62,6 +63,10 @@ static inline void vtd_accel_pasid_cache_sync(IntelIOMMUState *s,
 {
 }
 
+static inline void vtd_accel_pasid_cache_reset(IntelIOMMUState *s)
+{
+}
+
 static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
 {
 }
-- 
MST


