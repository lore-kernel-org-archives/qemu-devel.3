Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB1EC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4n3R-0002ba-Oj; Thu, 10 Sep 2026 18:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lW7-0006T8-KC
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVn-0004Qa-2E
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUsqkqSEg6ABsPYNlxkrlq9VUldheG28GlxZUj5JBUE=;
 b=HkBNZTWsTv0yxo2/tX+ija3kpqXKIRLU1J1dGpNPR3NKrPUh5//KdcvitndvLclyI57dRg
 nwHmMCBVmc6V0Jorw4OLpa2HJ1hTUqFsyTURtIVdH+UKnibbUpXZvzTfS3scTaUtef9RFR
 sfu70QGYzJRkX/c21TJ44sJ0/IfJb+I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-izVNm3pFPtSsp940VrXz4A-1; Thu, 10 Sep 2026 16:15:40 -0400
X-MC-Unique: izVNm3pFPtSsp940VrXz4A-1
X-Mimecast-MFC-AGG-ID: izVNm3pFPtSsp940VrXz4A_1789071338
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482e8e1ac69so683724f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071337; x=1789676137; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bUsqkqSEg6ABsPYNlxkrlq9VUldheG28GlxZUj5JBUE=;
 b=msGXNZOxGRInMU4T0buyu5dwW+l4eIErtii0edoAhA597tptX8+goKr6zhrEVSl4pr
 ziZ++M3Zjv1Dh2SVj8oG7EsFXnkaMeXOOouiPmdDBgp4aMnPwV7b7FxtWVTOAX2JvYty
 J43upgKBvPQsdOa8jhTVJ5tLHAAMRdDV5gfx5n/iZcfq/IGuJVoke3e63PgYwGngt+tH
 Xnd9MC29T8S2c/+zGPker8tPN5LSAMIDD06UaP88NAdvAdjvPJweGRIe2XpF9hc6yfP7
 1OEg/AjGa8tW+X0SCaguKsMyNnh2GC2IOn6vnejD6E+5PnIU691KAdqT34NlYFMfiNI5
 u3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071337; x=1789676137;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bUsqkqSEg6ABsPYNlxkrlq9VUldheG28GlxZUj5JBUE=;
 b=Z6gu62zukPav4e0HGTXZycWIXulnDl6JMhnYPzNIT/arZEOlKkBwTEPbcsHc4u2xoL
 2H8uf3jgiT5q+AdUDhlcU/nnAzVOH9+EF1uM1BTJJdVtYlxTif/WRRnNBsqFwgpKnvaM
 p9Y4dKLnW+UCIW0DOzWIThR20BYqElJX2pWNw6QvUA4lFK5IOvQ++7X4Qr6lyekhQ54Z
 L76HeBG/+ISOwl5F/d0wkVR0nIsXMTYeYqp8pBL2hliO21xDt65hZwLegYkErbAUDaIq
 0mp63QwgqYU5GPV3XQVEJlDQYQdxoGudiZC/UaMmcXQt/aT4QVuPqaGRA9JWJ7GHT9tg
 0ZLg==
X-Gm-Message-State: AFuF++l9YZGerFYXkKeELenCX1FfvyUINPa5t3ZsJhS8i1hbku58Utm+
 Ny7WMNnr9VD6n80xFUvof8/PAZkL1SrBMGtRm5XtyROu6OxZ8AMEK9BPAOTNFzckAGQXrZS/oT3
 WyA9kkn1324/ODaXSS9JO36ojh4anExJ7+dV0yg/VAUmDirN0kTJJ7jUuq6qUb0LpFzSSsfkqrm
 MfS/TuSslurD5LUYbQqeu2U+44dPBkrtMReA==
X-Gm-Gg: AYBFou3ceRZWEiDb3O3I6LxO4bw1rUAnBINe5Hmyh1v2i/bFz/ypvOWnYfBU5581dG7
 T1+HZPRGq1TxG5+HhocMYkcX/nnIr2TI3c1yVYlTwvXiqc3IZ0Vgr9s1R/p71uxJCSAdBv+mCvB
 AP1VEWWQaPcEt8dAi6VdGAnUz1WJbvHIURn5bqeaXf6YmaX0OBlm0gyMTw9UR5NnXbc1ncIM9Ep
 KJ5MQBqmmvk9wJKZplcKHdrL2QJm85IZuHUSgdfZ7piZ3hy8hM4HdYvhnhsNR2ze+5fldXlmmfz
 SO/HsKlrtV+zYdz9f80HFFqbkH5dKtMok4c/3GYReTxqqUJf2IQ0dGEvsUUGBOSOw769FAqeA4N
 xHJPmE9d5VLBnxdmr2LPkQoQ=
X-Received: by 2002:a05:600c:4114:b0:49e:5765:1426 with SMTP id
 5b1f17b1804b1-49e57651482mr36061405e9.3.1789071337546; 
 Thu, 10 Sep 2026 13:15:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4114:b0:49e:5765:1426 with SMTP id
 5b1f17b1804b1-49e57651482mr36060885e9.3.1789071337025; 
 Thu, 10 Sep 2026 13:15:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fc02sm749669f8f.16.2026.09.10.13.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:36 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowangio@gmail.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 83/90] intel_iommu: Expose SMPWC when SVM is enabled
Message-ID: <aa8cea79b79a5a3c0a90d23c7d2bce3925d36c8d.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Clément MATHIEU--DRIF <clement.mathieu--drif@bull.com>

SVM in Linux requires SMPWC. This is free in the current implementation
as it is already in line with the expected behaviour.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=780dfed68862
Fixes: 952e1a6e90eb ("intel_iommu: Add a CLI option to enable SVM")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260808153626.873965-1-clement.mathieu--drif@bull.com>
---
 hw/i386/intel_iommu_internal.h | 1 +
 hw/i386/intel_iommu.c          | 3 ++-
 hw/i386/intel_iommu_accel.c    | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 924e91cb8a..df7a0efa6e 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -202,6 +202,7 @@
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SSTS               (1ULL << 46)
 #define VTD_ECAP_FSTS               (1ULL << 47)
+#define VTD_ECAP_SMPWCS             (1ULL << 48)
 
 /* CAP_REG */
 /* (offset >> 4) << 24 */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 91ab549dbf..350d2b7753 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5121,7 +5121,8 @@ static void vtd_init(IntelIOMMUState *s)
     }
 
     if (s->svm) {
-        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS;
+        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS |
+                   VTD_ECAP_SMPWCS;
     }
 
     vtd_reset_caches(s);
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index c03435f8a2..c3677775e9 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -37,6 +37,12 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
         return false;
     }
 
+    if ((s->ecap & VTD_ECAP_SMPWCS) && !(vtd->ecap_reg & VTD_ECAP_SMPWCS)) {
+        error_setg(errp,
+                   "Scalable-mode coherent walk is unsupported by host IOMMU");
+        return false;
+    }
+
     if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
         error_setg(errp,
                    "First stage 1GB large page is unsupported by host IOMMU");
-- 
MST


