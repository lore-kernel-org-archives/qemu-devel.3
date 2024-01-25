Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137A4C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2gF-0006rI-5l; Thu, 25 Jan 2024 11:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2gD-0006pe-HE
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2g9-00028S-3I
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e72a567eeso82647545e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706200451; x=1706805251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFd2PHs04WAsVFPzXYILuTHvIcBM7o5Jl0UfF56ciXM=;
 b=iNXgz+VD2sE5uEk8nagwImqcml5Korc/70Y4/Vh6zYT3ow9crtIlhiHAGSbd/LTTrN
 AzXmkmVht1w11TGa8QXeBytbXM8h4C+ny804/33NSz764tPKKgq/MRK2t+PFAdX1Hsia
 TBwK4031PqosdEKxJvw3pXcUwcb60LdnaCoT5srsCWUqLyB66LAqhGFi6flNVXjJtSIF
 CSldTdOEXPw307T3QYUKO4K1nJJZo6nuXAssCGSRGGb427NFrvc7WQhfUe5DSxf2H7LF
 i0bs+vdJBUFL912PbgwLO/fQ0RyWNvcLYvccpaD/DIn/aI7Z3Ai1WVlGpYq6ezanFzwO
 hesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706200451; x=1706805251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFd2PHs04WAsVFPzXYILuTHvIcBM7o5Jl0UfF56ciXM=;
 b=Ut2Tnf7j5R+X4Vd0Q8OB5jaAn4FBqRlPTONgUUpZa1V1R8IsIucgmfD9DMytuHZUT1
 naPvSGZ0nq/InTsgxaBcjPlYx0KeWpUCRt/jyKT5L6G9nhHhjvej6MtEy+0FU+nqa8tS
 hYV4tLd0Mqe9iZQDtc1ohXUV30rcQWFEx1R98dT8liD4NOFzUyhywowIiMHGhotQ6xyv
 V0cF+8qjsRvRcGr/Rm+uxVpcUw/zTXhQE3e3AkzIlTW8LydKCQ6vjuEaXDCsqB1a2UkY
 WsIfHqcTuKwovN/nYL5WYsSBh6XTpoauyPT/NHkBW5nzFKiIOyAn2yIs+lt53y2rhsqA
 iIrA==
X-Gm-Message-State: AOJu0Yzlgo//EmIcXc3R7nnR+/gm7A5HcF7O63Ssx9RVCK7e/cBEfdk5
 18J6K12HNhIYH9lxHtu3pfE2mX6u628vrV2w5WvguhRYCoYlzfedSDu1QDr2pCnajhmzU4v6ymf
 t
X-Google-Smtp-Source: AGHT+IEfTxv3Ir3Fd9NiUMR/z46aC4vFiGRGgIpiqDizGFN+UrRFPsUfPveqhIhTlAdnGknmwpEE1A==
X-Received: by 2002:a05:600c:470f:b0:40e:d435:b877 with SMTP id
 v15-20020a05600c470f00b0040ed435b877mr2173wmo.112.1706200451794; 
 Thu, 25 Jan 2024 08:34:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a05600c358d00b0040ea875a527sm3122208wmq.26.2024.01.25.08.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:34:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH 05/10] acpi: Clean up includes
Date: Thu, 25 Jan 2024 16:34:03 +0000
Message-Id: <20240125163408.1595135-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125163408.1595135-1-peter.maydell@linaro.org>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes --git acpi include/hw/*/*acpi.h hw/*/*acpi.c

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/nvram/fw_cfg_acpi.h  | 1 -
 include/hw/virtio/virtio-acpi.h | 1 -
 hw/nvram/fw_cfg-acpi.c          | 1 +
 hw/virtio/virtio-acpi.c         | 1 +
 4 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/nvram/fw_cfg_acpi.h b/include/hw/nvram/fw_cfg_acpi.h
index b6553d86fcb..b39eb0490ff 100644
--- a/include/hw/nvram/fw_cfg_acpi.h
+++ b/include/hw/nvram/fw_cfg_acpi.h
@@ -7,7 +7,6 @@
 #ifndef FW_CFG_ACPI_H
 #define FW_CFG_ACPI_H
 
-#include "qemu/osdep.h"
 #include "exec/hwaddr.h"
 
 void fw_cfg_acpi_dsdt_add(Aml *scope, const MemMapEntry *fw_cfg_memmap);
diff --git a/include/hw/virtio/virtio-acpi.h b/include/hw/virtio/virtio-acpi.h
index 844e102569e..cace2a315f4 100644
--- a/include/hw/virtio/virtio-acpi.h
+++ b/include/hw/virtio/virtio-acpi.h
@@ -6,7 +6,6 @@
 #ifndef VIRTIO_ACPI_H
 #define VIRTIO_ACPI_H
 
-#include "qemu/osdep.h"
 #include "exec/hwaddr.h"
 
 void virtio_acpi_dsdt_add(Aml *scope, const hwaddr virtio_mmio_base,
diff --git a/hw/nvram/fw_cfg-acpi.c b/hw/nvram/fw_cfg-acpi.c
index 4e48baeaa01..58cdcd3121c 100644
--- a/hw/nvram/fw_cfg-acpi.c
+++ b/hw/nvram/fw_cfg-acpi.c
@@ -4,6 +4,7 @@
  *
  */
 
+#include "qemu/osdep.h"
 #include "hw/nvram/fw_cfg_acpi.h"
 #include "hw/acpi/aml-build.h"
 
diff --git a/hw/virtio/virtio-acpi.c b/hw/virtio/virtio-acpi.c
index e18cb38bdbe..230a6695001 100644
--- a/hw/virtio/virtio-acpi.c
+++ b/hw/virtio/virtio-acpi.c
@@ -4,6 +4,7 @@
  *
  */
 
+#include "qemu/osdep.h"
 #include "hw/virtio/virtio-acpi.h"
 #include "hw/acpi/aml-build.h"
 
-- 
2.34.1


