Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D968AD1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Ic-0001q3-Hq; Mon, 04 Nov 2024 16:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ia-0001W4-Ng
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84IZ-0005Ox-4M
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=khVfGlwR2+qwyC0Ba42wfDZTF3bOsrqz5GwsbYu8ons=;
 b=eDoX3iHDzO2lkCby6jFPKhuClG0k8gQ/m//0OnbJR0CxXSBFNHDwH5cHgtV6eNPaq6g6IN
 V2UxlAjDWtsEVHTJ3Acmp/diNlLB+kERDhFBpMe6NDM66mvtVZMNzZV7wETO77RgfyCF+n
 dicoRHiSGRiEBVjVCrjD6eIGd31ncsY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-rYmtKGXCNMOSy4mTZuFUTw-1; Mon, 04 Nov 2024 16:07:41 -0500
X-MC-Unique: rYmtKGXCNMOSy4mTZuFUTw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d5a3afa84so2327520f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754460; x=1731359260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khVfGlwR2+qwyC0Ba42wfDZTF3bOsrqz5GwsbYu8ons=;
 b=bnXUEP6/sgtcqlZyBZ+4DDTnEGY9Y3XpqJaNxEC16vk6rSdNWYg1f72KFl9+MGvhBF
 ZbIIQbBQb7Zol3IAzh30SEXCdv4RIAH/Y5f3c9VCT3KuyM0eAqQYWkVIydxHEz3Y/kCY
 Wd5s4zyfGNPAIDiM63L+1DqgdqDlS8EZ2Mp5Lr9HosB6o1fJos2Fp1iI8wSIaL6HQMK6
 3Ge54PwTRX+iExUBU05FM1wYwvGMcmbigRs6f0vxk3ZtpXq57NB/jhum/P+1m8HnEHmz
 jc5i8BATH5P4F718Rg4lZncCUNaipUWqdSDbrd7K6aZtAaAvy32/OBhEI0JnSy7EUqKt
 V5Sw==
X-Gm-Message-State: AOJu0YwH532mjGBo5umlCIkiPR3Z4SNHun5QAoK6+thFgoQavnttCMGY
 QwV5xgKw4CmGPjQNqkJifE5BBkkTyfI6JkqJvZB3+G7NLCfFV0EmRT7MQLdDwMwhlhnfgiIrO+C
 bnQ4cuyarpcGNd0H3e1WhJK+zOmgNmpJsIJr4r30/nrr/IqWwkuoaJ4xCjxmCBteWcA0fwD6gbU
 qSoad94R+37dao31S9aKT7mRJmoF0ogw==
X-Received: by 2002:a05:6000:18a6:b0:37d:5364:d738 with SMTP id
 ffacd0b85a97d-381c7aa4715mr11631961f8f.45.1730754459798; 
 Mon, 04 Nov 2024 13:07:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdpdM8KENOFdEplgsKC+DSG4/GOUYDQEjViLGXBVniAqn0mJMeHx2Cbt9xdzG3w8VKv66/3Q==
X-Received: by 2002:a05:6000:18a6:b0:37d:5364:d738 with SMTP id
 ffacd0b85a97d-381c7aa4715mr11631940f8f.45.1730754459356; 
 Mon, 04 Nov 2024 13:07:39 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7b97sm14293415f8f.2.2024.11.04.13.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:07:37 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 31/65] amd_iommu: Send notification when invalidate interrupt
 entry cache
Message-ID: <f84aad4d718b83d2a4d90485992e5421430032e1.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

In order to support AMD IOMMU interrupt remapping emulation with PCI
pass-through devices, QEMU needs to notify VFIO when guest IOMMU driver
updates and invalidate the guest interrupt remapping table (IRT), and
communicate information so that the host IOMMU driver can update
the shadowed interrupt remapping table in the host IOMMU.

Therefore, send notification when guest IOMMU emulates the IRT
invalidation commands.

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
Message-Id: <20240927172913.121477-5-santosh.shukla@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9b923f6eb4..38297376e7 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -431,6 +431,12 @@ static void amdvi_complete_ppr(AMDVIState *s, uint64_t *cmd)
     trace_amdvi_ppr_exec();
 }
 
+static void amdvi_intremap_inval_notify_all(AMDVIState *s, bool global,
+                               uint32_t index, uint32_t mask)
+{
+    x86_iommu_iec_notify_all(X86_IOMMU_DEVICE(s), global, index, mask);
+}
+
 static void amdvi_inval_all(AMDVIState *s, uint64_t *cmd)
 {
     if (extract64(cmd[0], 0, 60) || cmd[1]) {
@@ -438,6 +444,9 @@ static void amdvi_inval_all(AMDVIState *s, uint64_t *cmd)
                                    s->cmdbuf + s->cmdbuf_head);
     }
 
+    /* Notify global invalidation */
+    amdvi_intremap_inval_notify_all(s, true, 0, 0);
+
     amdvi_iotlb_reset(s);
     trace_amdvi_all_inval();
 }
@@ -486,6 +495,9 @@ static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
         return;
     }
 
+    /* Notify global invalidation */
+    amdvi_intremap_inval_notify_all(s, true, 0, 0);
+
     trace_amdvi_intr_inval();
 }
 
-- 
MST


