Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B96C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBg-0000W6-Bd; Fri, 11 Sep 2026 05:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xB8-00071g-JE
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xB3-0008SX-Sh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUsqkqSEg6ABsPYNlxkrlq9VUldheG28GlxZUj5JBUE=;
 b=fUUm6TYbhHh5f/lzi52ONMCjUB0OtIT7wpp16kvHZApzvyrSzREBs0sSQ5Ly9dE148I/oY
 ubUELk01+0f22L+I7nzCgisB2lHquZ0LETmeSC69Xp/QUE1Y7BzElVMdViX/tJVcuRUmkA
 tQMpiEI5J5YSpGjjP8+2Km+msJhod0o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-kzFOfbpXOKmfSmyrj64PRg-1; Fri, 11 Sep 2026 05:04:07 -0400
X-MC-Unique: kzFOfbpXOKmfSmyrj64PRg-1
X-Mimecast-MFC-AGG-ID: kzFOfbpXOKmfSmyrj64PRg_1789117447
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48436a5fb42so321948f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117446; x=1789722246; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bUsqkqSEg6ABsPYNlxkrlq9VUldheG28GlxZUj5JBUE=;
 b=H6b5BsiM/lPDG2gq3qXbrvE5g0nfVvpU39nzO2gDDUf8aR5dFUWFrPtZgD0x036W4d
 uly0r7JoBjikGtj2vJOJPHn18RVwyQe++39s+Kbre5Yeav/J9g6bf6iRJbrMX+bOImnL
 rSnRQVZRi8aHdQTeuHa1cDLQGhD4zMFfLkREkWKoCUot9UCTYqXa4/F/EBXgNTxS7XCv
 0tnNwFebX07zAMkTdwBDSA6iSTLvRiq8DAPdXD2vJxN6MVtkYMfUpFp+NNB610wTsJVy
 ouQwrtuWjYcigoS5iL+9Kp2ynCjR/1aEqrt9mr2o5mtv/EggMSK7pcX0eZvQ8aabOn+Y
 vgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117446; x=1789722246;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bUsqkqSEg6ABsPYNlxkrlq9VUldheG28GlxZUj5JBUE=;
 b=JXsGGEHl9GeccEBL3MUy5MRLBMzTsH1fHZnqD7X7m90fTRuvUIjRm1nQbOZytikhx1
 QfwUoxR5zyMOILK1hE7CAM0Q5XWdsjs94GQe3AnRpHKx6QukFZL760b2CNppwAKpTVvx
 ci1ivhLDju8WS0rRe4EDYg3w/aeqD3gd+wHuaMmSqVEh41Emiakgxu4+c0YTpm8nCN0n
 FlQ1O1NJ2g1HYwkQETbCuqbMELx5E5q6FIIJVnD2cbH7cdiIyR8ovwjFrwqxvOa9FTVU
 u/ZV8qrIh+oDuoPMdBobHRTJPJNSoJ6Rz97ve3DmNXhLh66o62MZLppf11esK9MyQcdV
 tbsg==
X-Gm-Message-State: AFuF++kIuN+0gjsH56MzFRL7baTTrb3ogqr8NVTt/ympxb8J4JqbQI0h
 /DBVyEyIY5II0aD7WnmIKYg0rQBMKqnZi6YE4cAHwy22jFONooqM41T9W/Bw3IVWPZtzKIOEqP/
 rYXqZ5xRzWOb+jLUDdyydfvUjtcZDe3fZlT6PDCiqggDgIzx73QkDvNYi84QBvqLlZwt4FKsUqI
 r2whvLvGz7SniT5+xED1eyFTNS2Y6yjpSUFA==
X-Gm-Gg: AYBFou1TxRiOKKy+/JNL9BUV5ebMQSyra/P000XS34NqlZxN6/3fhu/7eWFbnnV+L1p
 V/chnAhkx9jZVNTlMMhY9XET43GdYMsUTbqfhPFg4jmQWGkM1gVb9SE2NAQnyE3EddnDaeN8ovV
 STEUhF6FLm6Q35Wl0IuuQEYEC6sAu4XW853GzwRNRRF/sSJD0m6tFfN8Z62YsmGKBQeO0nRzbHJ
 KNANoek7x7Etsv/2bt9etTi01013NvKClKRXHCKnm0oHr0ksY4wa2ETfDr7B4p+ecQlRgl62Xrw
 0vvLf2iqTbnDvP3Rt1D9Psz+Ri8eS2e4QkrOughprZRWgTWdSSXKdm0J/6z198BjY+nvoiiYywy
 1kG3gm757agYlPMPMG7/KPxs=
X-Received: by 2002:a05:6000:2c10:b0:486:e37d:c57d with SMTP id
 ffacd0b85a97d-486eb345e9dmr3832197f8f.43.1789117446450; 
 Fri, 11 Sep 2026 02:04:06 -0700 (PDT)
X-Received: by 2002:a05:6000:2c10:b0:486:e37d:c57d with SMTP id
 ffacd0b85a97d-486eb345e9dmr3832137f8f.43.1789117445869; 
 Fri, 11 Sep 2026 02:04:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e4b5sm4630040f8f.22.2026.09.11.02.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:04:05 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:04:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowangio@gmail.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 68/75] intel_iommu: Expose SMPWC when SVM is enabled
Message-ID: <49094452768e61416f2b7dad3393bb69bad5d654.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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


