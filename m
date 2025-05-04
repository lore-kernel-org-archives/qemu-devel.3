Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9D7C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBhLH-0007Nm-05; Sun, 04 May 2025 17:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLF-0007NV-3U
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLD-0005AR-FR
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22401f4d35aso42950245ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746395861; x=1747000661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8rB/8xBZmswHJCiwCgkX6MTRXJBKKdtzkzYjbWxeAqk=;
 b=jeFTCCw12a3RJuZ+DgZN/3LgS1MK0jokN9K431a1Rir09ZOvJGaDMXmkauMms82tFB
 swNq0Q3rW/XWBEONoqa+G+JT08PFxb+n2BfTYrkDLELYvZnCTk+8gZ6//qtVKDp6b4jx
 3/EXqm67Rru+7oqWat3t8afTy/N1A9kqfAsowrHhypjcRb+XvSbwag0eWoIxNcAh1nBb
 cPBsCV/UfuaJLNy4MpJeZ1DlJDlK+rDgiCCz3ffAy+JOlLFM2F1hF3E1BI331s418gZ0
 IUwptu8LPQ5wRkc2PHZnYoLE5YLZwOCdfieSNK7/hMFtPpHINYEDgYxHbLyboHpVTgo7
 qMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746395861; x=1747000661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8rB/8xBZmswHJCiwCgkX6MTRXJBKKdtzkzYjbWxeAqk=;
 b=QQnzLAwLud2/AzYzaO27p8wY1cqKBvUDLz2f/ErUFQnVTHdNNJ0XdPmLF3KoC2TJDE
 pERIDuH07aq4eFeiVxHG8JnEL4XJ8imcwLzQCNu91XzKuTUI8WDtdOldg+DCqEHjq6ca
 3Vz3+3D9aPr4+Y9/TeYAO/E3VuWHZnOqSpje2Y2FJbx7uHt18Jl+UqCq0teDfcNXbSaO
 FFpEadxyge6ujrbR49NSD7zzg/ICF4ntmyF7ma3R+XCSrFuN4Om1Ckj7Si7NAMALooHM
 0SLLZ81iFw4+iUumtJD/8e2ksdOyyuV+afoTbQyRBnZJiOyamCXzipX/GdccsvhdEpyw
 dC1Q==
X-Gm-Message-State: AOJu0YzguKE8rtf/5RmTqZUKp2Fh0Lr22b1s0Ysx4G5cB/HM7YtIbpW8
 IcJF2Do4Nwnhgc/Ca7Q9tGQZMpwoLERYG8FdGxycrXPv26cGZ7/XapgHTAybmqCOsDEP93sgsWY
 Zuz4=
X-Gm-Gg: ASbGncuMPW5VwvjupqAukEiG2HU19N0X6Pa102ifkHku9eXvUcJKu+vjAnYak4zBBGW
 cu0j9CL6H22zYtAryoSde3Og7oX4TKAc6/xn1+Vo3tkCbIDf2mpDrkBITymkdoUCGkG/aqgq78O
 zCRAMeH7fVjVH2eHgbh4MduueEYeINLmUh91pRoRUcke+NUunFrgRVS2f3fmwojiEORMjxI2zjr
 2uwWh1pQXAbrOWgqH1PCHQ+dWRq/xbpheKwYWs2eWaw5is4T9cI9XKi+tpql1bq+jOPAU08DmYM
 3DkYXszIopbRI3szdlRwIiyRnA3oZ44iB/gQoLl1yfdzVHMh
X-Google-Smtp-Source: AGHT+IGOfoUo5R8E50tqvpsstcNS8aNq+ltwe2IyoE4AGKB02pjVb7B7iD67sPWlh3UNySXRCQkILQ==
X-Received: by 2002:a17:903:1a30:b0:220:e156:63e0 with SMTP id
 d9443c01a7336-22e18b8612cmr87433525ad.8.1746395861469; 
 Sun, 04 May 2025 14:57:41 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204fesm41664875ad.137.2025.05.04.14.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 14:57:40 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH] hw/pci-host/gpex-acpi: Fix typo in comment
Date: Sun,  4 May 2025 21:56:29 +0000
Message-Id: <20250504215639.54860-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x633.google.com
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

Fix typo in a comment about the creation of the ACPI CRS method.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/pci-host/gpex-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index e8b4c64c5f..0aba47c71c 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -182,7 +182,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
 
             /*
              * Resources defined for PXBs are composed of the following parts:
-             * 1. The resources the pci-brige/pcie-root-port need.
+             * 1. The resources the pci-bridge/pcie-root-port need.
              * 2. The resources the devices behind pxb need.
              */
             crs = build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent), &crs_range_set,
-- 
2.34.1


