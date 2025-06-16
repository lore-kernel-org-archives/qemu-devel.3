Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E515C7115A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 13:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR9lY-00025u-3Z; Mon, 16 Jun 2025 09:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9lJ-0001wN-3k
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:36 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9lD-0005T8-9k
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:30 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-af6a315b491so4110843a12.1
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 06:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750080025; x=1750684825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8W/yE99oVdomm0D2Fyb+s9ZavOYJt5IOPZHZYUPXcU=;
 b=xz4bquyEtDX+kNBcYZ7Ud1ventzV5GmYQ1b0ve+NszrGdYCZs9QT+j9jx1KXKP8u+Y
 4/0Uq1StNuDpVQGF/N8zSFl+p7X0s4Qh2Nx4C8t/X1MfujFm6nuoKqrIwqQCuNTkXsIw
 9syKBohvboFEvmuHCprmz8LN3t6rD4hMBm6h/zNJjoBbwecGBzIksl+6FdI6lQYRnzbA
 q1Tuh+zLvlS8f7zApcqB2G2FwPfDNyg/RGIFMVYhssMplPHYEeycYNXgBij4z23QlKRJ
 8+zB/okCnhTCdAzhLZojSvlNWcMOFZEyFQkx8uFSvZ9SaV4noGx8W0t5Spmnb/5lO7v+
 Ny6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750080025; x=1750684825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8W/yE99oVdomm0D2Fyb+s9ZavOYJt5IOPZHZYUPXcU=;
 b=dTdgtrDwHUM9KavN1ylMqfCJityC9GFcQUa7VccDaYQTDtPGW7paG6kQfa8j4U1Fr2
 Tt41hrOdrG961yr6LD8TCcSVCo/oApuaoTkg9PaS+hmuOKP6U0aOaLAc9yHszDSspGWw
 y6UX1mBrp20hXsbTAoDLiY3kLee5ZaTgF9l0tnOOtJR/mndrYidc+aTKFIyWwvV6u6FC
 iMspzMzHRTPsDXtop7yZ8sW1K4TNofkoTcvvJw6/sKSGQEiXh2HnC5/fc0Bdm5uRQai1
 hJTYxUAmH1SLqurxSzXLbe6HmdMosYZ1eD6jfdkLBr3ulL3/fuVdWljj1VI+Cyzd+s2E
 C8mg==
X-Gm-Message-State: AOJu0Yy+2vrljTNmFCc7hvmtkq2cfQ2Xl19S+MG1pyZxhMqgfAc7oZX1
 mf2dmfvawuQlRKRAQzTkKQ99vXBU16O/T9oj1wNsqkK2smZqVCyKN27Rhas2KsRn9c1tRB3b7n6
 g/wHN
X-Gm-Gg: ASbGncvVKPQaZLC/zlQ4LQER+XwCd+qixN8W+J/wdsr1x9nxohSAq3Yb8tYF3FeF3gA
 u6z6hP9dhGzn4TqyKZ5ac7wqW+orOmPO1wOp1EotENjCdp/Vdjio0M/YDRq3JQRLxZG/iz64m6f
 L5HJVo+aghsk9Nayug2xVyvEOKBiBOuDNEXTn0MugO9d5G1/HFPNFro3ar0v3vWzbz57yaIiY2B
 s/vFoDV0T+lthf8bB5eHkaHTRLZFD5m5DSXhZGIqMkYH7x6VArOsADkw922SaiMpsrmnl5qLhG8
 PELzx6lmYokPp43Duwk18fTQuzZVIM13UVdKOLhW0LY6HwLq2iqCBCxfmGpEP6qy5PrrsxoaBF8
 wQA==
X-Google-Smtp-Source: AGHT+IFaHruaonQo5WTISuUKEmzod1ppAIC6mFjlggBADfSPAlO2iVq41L/proSl6+ZD/e9QDYYkgw==
X-Received: by 2002:a17:903:1a8d:b0:235:f18f:2911 with SMTP id
 d9443c01a7336-2366afd3873mr149900765ad.2.1750080023418; 
 Mon, 16 Jun 2025 06:20:23 -0700 (PDT)
Received: from gromero0.. ([186.215.60.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365de781dfsm60848405ad.131.2025.06.16.06.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 06:20:22 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v4 4/8] hw/arm/virt-acpi-build: Fix comment in build_iort
Date: Mon, 16 Jun 2025 13:18:20 +0000
Message-Id: <20250616131824.425315-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616131824.425315-1-gustavo.romero@linaro.org>
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The comment about the mapping from SMMU to ITS is incorrect and it reads
"RC -> ITS". The code in question actually maps SMMU -> ITS, so the
mapping in question is not direct. The direct mapping, i.e., RC -> ITS,
is handled a bit further down in the code, in the else block, and we
take the opportunity to update that as well, adding "RC -> ITS" to the
text so it's easier to see it's the direct map to the ITS Group node.

Signed-off-by Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/arm/virt-acpi-build.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9eee284c80..6990bce3bb 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -407,23 +407,27 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
         AcpiIortIdMapping *range;
 
-        /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
+        /* Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3. */
         for (i = 0; i < smmu_idmaps->len; i++) {
             range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
-            /* output IORT node is the smmuv3 node */
+            /* Output IORT node is the SMMUv3 node. */
             build_iort_id_mapping(table_data, range->input_base,
                                   range->id_count, smmu_offset);
         }
 
-        /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
+        /* Map DeviceIDs (input) from SMMUv3 to ITS Group nodes: SMMU -> ITS. */
         for (i = 0; i < its_idmaps->len; i++) {
             range = &g_array_index(its_idmaps, AcpiIortIdMapping, i);
-            /* output IORT node is the ITS group node (the first node) */
+            /* Output IORT node is the ITS Group node (the first node). */
             build_iort_id_mapping(table_data, range->input_base,
                                   range->id_count, IORT_NODE_OFFSET);
         }
     } else {
-        /* output IORT node is the ITS group node (the first node) */
+        /*
+         * Map bypassed RIDs (input) (don't go through the SMMU) to ITS Group
+         * nodes: RC -> ITS.
+         * Output IORT node is the ITS Group node (the first node).
+         */
         build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
     }
 
-- 
2.34.1


