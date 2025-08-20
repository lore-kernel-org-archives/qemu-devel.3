Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131ECCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 21:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoqDx-0005KW-2g; Wed, 20 Aug 2025 17:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDu-0005IS-Lf; Wed, 20 Aug 2025 17:19:58 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDr-00050e-SL; Wed, 20 Aug 2025 17:19:58 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61aa702c9ebso756519a12.3; 
 Wed, 20 Aug 2025 14:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755724793; x=1756329593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnU/2XOvhfKf0py0byocSk1ZC/ukvx07ErFoqRV6J40=;
 b=Ld/V4Nrj5kBCXYtdW91b4Hbh3ua5Korjw1rTmTuDewj+FGiKBMZopQrNAWkL0TEkdA
 DvA70Nsjhh2DD7Vg4UPWoRpNmeeYMdTOq8NHNcqYPEWvgPUE3NMrTbu7/vFO/C9NBlzJ
 UrvDNhzZZutzNmUNGRIzF8FZGxswtRlErRf8rqi66AxCNd7mH9wvZMuIy/ef4g34baEp
 qBQNR+kLmGO2J3FUdFvFRpQzaN2BC7qDnQ53hNm+XmVxiZSjFzB7QmvyUhZ0UDybXnZf
 0auv2NeV1UC8BP1IM/nJk1hQePvhuhVPxKO+JJz7gmWCAB+LU64x6TLELkYP6t4ksjSW
 RR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724793; x=1756329593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JnU/2XOvhfKf0py0byocSk1ZC/ukvx07ErFoqRV6J40=;
 b=LHG3iFpC0PE9qik5Yf9CbzCxQuouXBvHSbUUsmRE2ZM97Nq6JRuO9cUpfqBCPkvESD
 tNgw7apqyrgF6TxOalcXimrJYI0j7qTEabtzdGPdHlQ1rEQQ49fN+mi31rWajpd4jaUq
 KOP8MSvR9jg0lDbo9Jbc33j3wMPQCEBPi+f0HoB1aXYdAqsWIQ3/yDvu2UsMmbYLDNXY
 +cnc0Op4WL0hHVICVBUQIx3gOC9JmDxJuT7Xub2qa9BTDg+lxkJtyk3p2HW7mXUXS5uz
 Wo0fufHuAiWbzEdNWhKTGxEZSayvhggVnWXj2OSqyomfR/QtWeoMWCARa/bmC7Kbt2+k
 K1KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdNhMjnbEGCI9Ng5SuuQfjBcMbavbsGcsPM/lP0+g1bC35hlIUxPgUfgJ1fnh7H6Gv5v0Ski7Z5w==@nongnu.org
X-Gm-Message-State: AOJu0YySuTArBpFBRFvIeqQIm9cBUotXapt4D8BmgPoIIGG68/D1PZLl
 5VcHy4H1mRhPpCKJiaTKCEsYZdGrso4CCiCSrYP+rWgs7QPBSFf9M9edLc9zGoyv
X-Gm-Gg: ASbGncvgFyuES/E+qdwh0wOU4qFrblqqYx1FaO9kOsLzmK7MzQbmP8Ytv1E5ZaVs4zx
 GmoYyink/1YOHr/4fehyJOHEakV9IdX91hUpc9jfHRfNXyNVaUrjv20cIXtq1TkZAVuZBl+69zD
 OCDhUGOj7Z7GV/undw1TRmD9nxSjvdZ15sd9S01Ia2CQw3yYIhHbxCPz0UvWNzmxeInhJjTUVdJ
 gLdDl/44ynyx16lGtqQrxaMvFq34qXaAUjKfd2ojtu7GhuFL6s7AB0lDeEiwm4eUrQuUwDKSnEF
 cWm53ECJpibvvIa/tStf5FEMOX93vpdKOoHXz8sUuj4u4akbtESqQdzbQzEjZ/Xq+6Y8uS5PQCv
 22nE/BzPk0O8OQ2ZC3QRw3RpOHEE/kYjsiGhsqJIIDca/R32SkrDcABAwT8B3TQNwrub9Ei8mTP
 Nmt7I+bMl+mMrH91Y67J2+YGkPcBV6O7DHrk3i0ypZD915cnZLq8DwgQ==
X-Google-Smtp-Source: AGHT+IFQHGKeaSYft7dH2jM93EepuEEFy+w+oXiIrjA+tRB5gAMmAJWgGYHJVXOLPqfDf4YZDO3dVA==
X-Received: by 2002:a05:6402:23d8:b0:618:6615:30df with SMTP id
 4fb4d7f45d1cf-61bf86efce5mr122543a12.15.1755724793200; 
 Wed, 20 Aug 2025 14:19:53 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-249c-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:249c:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a755d9cfasm4161182a12.9.2025.08.20.14.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 14:19:52 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 05/10] hw/pci-host/designware: Implement I/O space
Date: Wed, 20 Aug 2025 23:19:27 +0200
Message-ID: <20250820211932.27302-6-shentey@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820211932.27302-1-shentey@gmail.com>
References: <20250820211932.27302-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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

Mapping I/O space works via viewports in this device but isn't
implemented in the model. Fix that.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/designware.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 5ad7574924..7342207eb3 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -283,6 +283,7 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
     if (enabled) {
         switch (iatu_type) {
         case DESIGNWARE_PCIE_ATU_TYPE_MEM:
+        case DESIGNWARE_PCIE_ATU_TYPE_IO:
             if (viewport->inbound) {
                 /*
                  * Configure MemoryRegion implementing PCI -> CPU memory
@@ -298,9 +299,12 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
                  * Configure MemoryRegion implementing CPU -> PCI memory
                  * access
                  */
+                MemoryRegion *mr = iatu_type == DESIGNWARE_PCIE_ATU_TYPE_IO
+                                       ? &host->pci.io
+                                       : &host->pci.memory;
+
                 memory_region_init_alias(&viewport->mem, OBJECT(root),
-                                         viewport->name, &host->pci.memory,
-                                         target, size);
+                                         viewport->name, mr, target, size);
                 memory_region_add_subregion(get_system_memory(), base,
                                             &viewport->mem);
             }
@@ -332,7 +336,6 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
             }
             break;
 
-        case DESIGNWARE_PCIE_ATU_TYPE_IO:
         case DESIGNWARE_PCIE_ATU_TYPE_MSG:
             qemu_log_mask(LOG_UNIMP, "%s: Unimplemented iATU type %d", __func__,
                           iatu_type);
-- 
2.50.1


