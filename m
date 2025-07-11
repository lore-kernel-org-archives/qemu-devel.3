Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B32C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuy-0006gz-MU; Fri, 11 Jul 2025 09:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDuA-0004YB-Cj
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu7-0003PO-Cu
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:10 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4555f89b236so6495285e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240906; x=1752845706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rt9y+/Q3kbLfenOke8pPv0fzPqohcdD2CUbik7idoc0=;
 b=kgZ2YKtZBprQR4OyaTQv1ymLgXxFzYe25ThgNJ4EFCh4A24na/SyyCiAUedxyLcfIU
 BLDM+jfAxS3RIKGy44s6G8OGthu9/NQv5X7fxzBoALxNAZ5jQCLy4HHzArBGQjAhqaGw
 ltep/kHyhXT8TcLcgdUSOfjBCAkonXAHJTg3rNOnvVET2isRNUr7LE8YgkXf1/0OK3H+
 OBVApXd69BA4mYzCFQsjurXlWyM56Gt92Wa6p5pvDLefjZFE37XfDWbZBF0VC1WMflHx
 3qW0eKDhFqEhX9wPzE0cSYjGxhcWZLRN1TvnSVK2KHrlxSz79m+ADSyeVsbUflM6JzRR
 GMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240906; x=1752845706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rt9y+/Q3kbLfenOke8pPv0fzPqohcdD2CUbik7idoc0=;
 b=ULLT99CQRnFrseHGTlCMxrPZp+cNnj1+E91euRj2hsvKLt+/SMoOGDckJhDpL+J95T
 mpixQ078WhTeUlNPrB1fY3/06Lbm7A9SC71HB9+W8egcweU6CHEwqU4qCWNOTBp/iLfs
 PhVsqTuQIyYG94dCPCZ1l1Z+813SKzziYClQfeutEWKkveOa3shSA5d03h0VPl+w5DBS
 D15m687sNIWgs3dyuEN+YCFa7iSC9qZEBf19q85d+7pN+ES2Nz3FUuTvAvEr5GgDpHbw
 ti3mpdEyiQ3LiQrEqg1hvALGm2TM89bLRQnHkBeDofNc7ZAchKsVIm6rL6gnGGNNSATl
 YMnA==
X-Gm-Message-State: AOJu0YySFznZS6RAcXjIEkOtSXA2CK5cTAm+DgB+aME/Mx3Q5c98cZGI
 6lQz73TvBPnYAjJKoHNKCaefX6WcQdp8LC7NPDSD8Ib5VxYMi5q1jIiXO+2jG5UapgpYqsRWssS
 +fnxN
X-Gm-Gg: ASbGncv99khjugq8Imt/q7VF1X9AsyvwzIkJgQIVRUCcKfJakqmoCFHCo44F5T4v8KV
 X+QqHmDKP4aeUy/3kK3fIGusvvPWNBrRwBdbssH+t1g9FJqkpgdEDlzYB/2fjeyoRwdkYNVHr+k
 Ku54yOeGft2bmvbX8w6/7n4vnbgOJQ7W4hahy18bAWbwNS/nEpZuS7JfKiLTC7mx1VZxK2I1J9A
 kxHvHrxvdVjYxEm6mSOOPL6TMs8HOW31aWpIIzrV2TCBtw0DYvPlNjJUKWCBrLoO3KJHGhLDSoF
 nVAiG7WkswIeg5LEmf9y/MDhf2QjpHuGPak7ZyLH7vMn6E7Agz14Axhs0hk8Z4ooY0C1lBdbkNo
 UyzwMug1ovP+LQ6VVEpjas7LE4Pe9HTjnrSD+x7g=
X-Google-Smtp-Source: AGHT+IHCB//tHl9uAR1WVTQAjs3fDJrj+1/k6lV2nQkDwoFQxDNzEqrgDWqFN8s6mWaAZX0jDaTCzg==
X-Received: by 2002:a05:600c:3595:b0:442:f8e7:25ef with SMTP id
 5b1f17b1804b1-454ec15e5c5mr30323905e9.11.1752240905739; 
 Fri, 11 Jul 2025 06:35:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.35.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:35:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/36] hw/arm/virt-acpi-build: Don't create ITS id mappings by
 default
Date: Fri, 11 Jul 2025 14:34:26 +0100
Message-ID: <20250711133429.1423030-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Commit d6afe18b7242 ("hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables
when its=off") moved ITS group node generation under the its=on condition.
However, it still creates rc_its_idmaps unconditionally, which results in
duplicate ID mappings in the IORT table.

Fixes:d6afe18b7242 ("hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables when its=off")
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c3b9b3f6ea4..0dfb8ec2c35 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -358,12 +358,6 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Sort the smmu idmap by input_base */
         g_array_sort(rc_smmu_idmaps, iort_idmap_compare);
 
-        /*
-         * Knowing the ID ranges from the RC to the SMMU, it's possible to
-         * determine the ID ranges from RC that are directed to the ITS.
-         */
-        create_rc_its_idmaps(rc_its_idmaps, rc_smmu_idmaps);
-
         nb_nodes = 2; /* RC and SMMUv3 */
         rc_mapping_count = rc_smmu_idmaps->len;
 
-- 
2.43.0


