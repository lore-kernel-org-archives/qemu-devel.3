Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974DFC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mTX-0001o1-Tr; Thu, 10 Sep 2026 17:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lUB-000604-CI
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lTi-0003jH-VX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4xO9Jj7yHXJpXhsIddL9LHeTxBWYycN9Rwv/iB+IGEU=;
 b=ghnB/iJZJLXciHyGrGDJ97lHwO9hNXyZ1+8XecIA3xZmU6AgjYcS8isT1Fj1c8yiroaJdy
 UztfJ+MayQ52en7/IK8aZeBnU0SCESclkJskhTPGkwQwVoiEHKRbsJmC5gpEpyvIKGRiXC
 ETzFN/rYOjmcg0k3MhY8E4M5R0laEOo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-JM-nPsnmNnOz7WNf_fkoLA-1; Thu, 10 Sep 2026 16:14:13 -0400
X-MC-Unique: JM-nPsnmNnOz7WNf_fkoLA-1
X-Mimecast-MFC-AGG-ID: JM-nPsnmNnOz7WNf_fkoLA_1789071252
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-485835753caso82824f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071252; x=1789676052; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4xO9Jj7yHXJpXhsIddL9LHeTxBWYycN9Rwv/iB+IGEU=;
 b=dp1pncu2WhpwP7D7l+4t7zMSxIq3mKmmcIk0ajW9QxLl6uNlJOjKpS8fvVQIk/2ASj
 b6R0fM6rsi2HmN0NUNWEDUwtgOp1G0WSLHdgATUQN2ObFImR+fAHOUz8x5LVIHCmEi+i
 WULsWJQd1n9eNH0E1TtNMc3aHtPZw1wnxWkvqehzoDtp3AUFAELpC1l2PnonbLNnX2Yi
 ZZG2V5ytx96Rvo2WyLAu7rpBRDVbrLVX1zxKw1FalZeweMA1rT4rba440ScH6tVxoQLf
 7RJFebz6Nv7LaTUxubyX/XPEvwUt4d2I9qpFjeNDmG+raEg1fW1fUWh2IoauxkWdjt0S
 kOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071252; x=1789676052;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4xO9Jj7yHXJpXhsIddL9LHeTxBWYycN9Rwv/iB+IGEU=;
 b=p3OycSEwh0HdbgdMMB1kS58PyJjzNBQ8fD3M1hMbaIitJZ+EUGX3Wlzp5ZRw/k3oj2
 KezH/W/mAdoFQn8Uh6hFcX3I8RPNbNAK2OpFNxGbjoX0JF0y/nJXftm9oDuW8iYg47qy
 aGYu5Xb/R3mD2vOnfxa+4Y0HWloTOYopillR16IBw/prnDg2bXove3HTpZ02m2XUN7zp
 oL19rLg9qJBIKj/AfHxmJr4ZS2ERLsF7wkLz6d1kfBxzTDLbQaA/cdM/6vVCnbim+EsH
 feFumqXpG9pyQHNSQaqPIIdUpbLp5jXUliOzPXA933zVI8xX/3rMmgcYUil8oI/QuKzh
 7K3Q==
X-Gm-Message-State: AFuF++lV5EIJDOuw4SVxwb+s2nzjETirsLWK+A09XxOXMTSCqDgZgPyz
 0Ij7azlrm9vi9R1NbHq6Fi8W+6E2pgtUxb4rOG/3TtHdNPXZNvsVGeAyj8NcrGopHD2OC/IJ8Yp
 eVZpo+YnqlR6rELqGr+Tm+zqpy2OllH9UAgky+MatgeUPxZPL3yqkvvZsxzjmntvEOYww0inCfE
 xCqHcDcYE6rqMpXC0R81VeP4+ioV20LXhqPg==
X-Gm-Gg: AYBFou0ibHHWG36LJvSJOIwhgeyqQ5YLQfWbyuPoCexyjMh1KyHF4trGhwcFN6qJ0QI
 Pl/jqZIaR/Eq59tQ0vUdBPjHhETjVMW3oV+yVfY5w0FFaCQak1lifyufD8OKNM39k9U0T0wTpNy
 ThnDuyKKhsLYNkXwe8eEA7TvGgVoLFY6JAEZ7YiY1t/j7fPLPIhD3zC2/JgzXUZOZoWJ0oG2vyB
 DPvkW0fJABv29fg8y1MlENVO+G71cVzDq8lzGlHhAW/rlCUtVGnyfbYunfj1VPVthkfGB6hja51
 PlgTzpa31PHb8n5AI6xbTF5oCJgBMZ2Sri05YV9BwzgodFPBnzz8Ka5SnvXBaTNPPVb26m0dEMY
 NkfBZQUNp9zU7J3JWwVj0pB8=
X-Received: by 2002:a05:6000:46c5:b0:486:e0f0:f2e9 with SMTP id
 ffacd0b85a97d-486eb2e3d82mr515397f8f.8.1789071251723; 
 Thu, 10 Sep 2026 13:14:11 -0700 (PDT)
X-Received: by 2002:a05:6000:46c5:b0:486:e0f0:f2e9 with SMTP id
 ffacd0b85a97d-486eb2e3d82mr515354f8f.8.1789071251220; 
 Thu, 10 Sep 2026 13:14:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35bed0sm737699f8f.32.2026.09.10.13.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:10 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Subject: [PULL 64/90] amd_iommu: acpi-build: Remove unsupported PPR and HE
 feature
Message-ID: <32adc52ecb7cfca74279c993a22959677bf6f306.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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

From: Sairaj Kodilkar <sarunkod@amd.com>

AMD IOMMU does not support ppr and hardware error registers. Hence do not
publish these features to guest through extended feature MMIO register
and IVHD 10h flags field.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807061250.27739-7-sarunkod@amd.com>
---
 hw/i386/amd_iommu.h  | 5 ++---
 hw/i386/acpi-build.c | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 319db18618..c5b346cc35 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -227,9 +227,8 @@
 
 /* default extended feature */
 #define AMDVI_DEFAULT_EXT_FEATURES \
-        (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_PPR | \
-        AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
-        AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
+        (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | \
+         AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
 
 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7bf3858b63..6d7308b4e4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1938,8 +1938,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     build_append_int_noprefix(table_data,
                              (1UL << 0) | /* HtTunEn      */
                              (1UL << 4) | /* iotblSup     */
-                             (1UL << 6) | /* PrefSup      */
-                             (1UL << 7),  /* PPRSup       */
+                             (1UL << 6),  /* PrefSup      */
                              1);
 
     /* IVHD length */
-- 
MST


