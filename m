Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599B5CEFC31
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 16:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syDMK-00037q-Oe; Tue, 08 Oct 2024 12:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1syDMJ-00037f-CD
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:46:51 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1syDMH-00036H-J0
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:46:50 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6e129c01b04so47389687b3.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728406006; x=1729010806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VZ6DCcUZIpjkjbo+HdIBkZWSoiW8VwPF5vcnXRm5F/c=;
 b=LKHGJKPD3V1+JKK7RczKP01Ob+2VKCbqsxuh8eDSXj40Q7NnHFycBaq3DSoCSMJR1j
 tTBFCz7q9Zr0JFnmofDqTOEjpxkxIDf6DBdVGzl2Sz50knwjh8cGTvkakNi5eUf4m5yY
 RDPXcZ1iOGrSIr0yKFf7InOETZtvwIk72aDXlkNy/1UEMootZl+zmbTD4SIYVTzH/RvA
 76ww4Q/d35ybPLSBCqSGp55WgQ0sRNQ1il17QS0O0sZUtjQfCz3gzSa2oiHLe7T/9MLo
 dWlZZDrTY68fL06u1lNwVV5zp84yQDXzcZ+/arIfz6TEcCGmsC7EzBcoXE7g6Yr01uAr
 Jb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728406006; x=1729010806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VZ6DCcUZIpjkjbo+HdIBkZWSoiW8VwPF5vcnXRm5F/c=;
 b=WE4EpTP1PanqEmRhlLSl24cGewnTwNy9DRxEJNrPtOMHzd0B//f2dEfaC7rVV2lXK6
 smPaa8zgEx7vV3GAjMSeRoFK6AlhGFzR0tl2Tmkrq9yOqTUhVcRifEiG/U+9Xe7qGF9N
 rMa8NptRiraidiz60HCkEPaBWqPlRBHSOqqegLpMY91eBVV1NtvJvE3j0qbeGX/84K8C
 0DTB8b2UrcRnYQc+siC/PyF/PPbPmyssAn6xGX9oCUOd2oyYqubhrJ/i1Q2XHOecYfT8
 ZNhpwbJALTfXX2ODFZsOBZMlWxXmHloefLHVQg56hRQBvE4L3AygdgE61T932N6IO41P
 hB8g==
X-Gm-Message-State: AOJu0YwJ2g8mwgPqxOxzN94t8HBoALXRAXsr67bkmtd/2svTKqPczd5q
 s1rOHKPZUtVxiYdff5uqhlGgMpSuv1aDLNHHTvH/q0I0YEWrCLbF11JLAA==
X-Google-Smtp-Source: AGHT+IHIAkPgWXq889nUNPQVkfBDdMNYDtX2A5WPUAZtxx3p+5qTBrz4vYbkueDHvb3dy+IAHwcXnA==
X-Received: by 2002:a05:690c:2d03:b0:6b1:61e0:5359 with SMTP id
 00721157ae682-6e2c723f257mr103013247b3.21.1728406006535; 
 Tue, 08 Oct 2024 09:46:46 -0700 (PDT)
Received: from fan.. ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6e2d9387db8sm14978437b3.59.2024.10.08.09.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 09:46:46 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 abhi.n@samsung.com, alok.rathore@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH] cxl/cxl-mailbox-utils: Fix size check for
 cmd_firmware_update_get_info
Date: Tue,  8 Oct 2024 09:44:47 -0700
Message-ID: <20241008164624.78608-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

In the function cmd_firmware_update_get_info for handling Get FW info
command (0x0200h), the vmem, pmem and DC capacity size check were
incorrect. The size should be aligned to 256MiB, not smaller than
256MiB.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9258e48f95..c82ad50ac8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -649,9 +649,9 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
-    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
+    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-- 
2.43.0


