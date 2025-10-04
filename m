Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02082CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wUs-0001ug-Cy; Sat, 04 Oct 2025 03:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUL-0001G5-6r
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUJ-0005L2-4Z
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso24495065e9.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562125; x=1760166925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7S2h4CcSSUNF/Kbr6xAuWXkdgK7luzPuydLNP0syMy8=;
 b=nLGzUsQvWHBbX4G8CXF6Elhja5OkNu75PCWBHv1keqi/OHpZUckStc5lgtD3iMlECQ
 mUTqxl80VUioQ/qWMWa5ylptoHujUefQZQIXa49HD5U9GUOWPOC5YgqQ907GfkwhBv+S
 2ROPkvZ9+PH9Rk7Zd7NwymGZ6Iyp/ahfoekNHcgQXaAiRYLs9jRnqHqerMy1z4tce1Br
 jYXoYXEOGLiMy7/dvp+pU0pZ6vh9J87qonacZflrgj3EA7mOIGFQKJsQvtk2qTSeHFuC
 duuOh72RSZh6IhIUXnikwtIYOGC0I+A6ipsptFC6O66MTCnnjwSA9H2tgu80cZPplk1/
 5DTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562125; x=1760166925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7S2h4CcSSUNF/Kbr6xAuWXkdgK7luzPuydLNP0syMy8=;
 b=ZXaqcIeBpEt1fnNcTFA+ij4jZK6mqY2lbSVyZNv0ZCZdRrOb/1+Q4A7tiWVDnb+XKf
 4YacaLv8kluNXDXOrzUFTzdiM8Rhi3cCRCTDa3vIt8Ci7g22cR74tGKudEHC6zwZoGfh
 yOksadiHw/ZY3Zbibsf3YHNiajz30g/8u86krwgiCPdl21Z1IubSlIlAC5uG/DmdE24X
 7R/BDmWGruZXiABKvvAjoldhRvVOLjwYW8Tmz5GRqkel2PtChZl7XR0heU+cH3OnNhpH
 tCRzblHq19nVMsDANuq0KOPTXsm0xQopZ9QBFx1wmVd34U1GIb7oV/3BW+KecbrMV75A
 J3cw==
X-Gm-Message-State: AOJu0YwGR2C1WBVv2776Lep1Ta1xLL2/HMm0plzaI+Ww5T0ieTZRKFLd
 NfxRtp1iAGfGqK4OwoSsed+XT6RLxdPYM8CnBqo9h3LOC4nTDDBKxr4XAmR6ofTxJWEM8fe7Fyu
 bjRzvvmQdZg==
X-Gm-Gg: ASbGncsHZGmlHZGQFaDmNACFt73PNWXyNWBffhlf9W8RsyUVij1eBQRB0RGJxUXEY3Z
 SUAxFg1laSdFXWVcpnYni2x8CEbl0W5LptCVHUlf5CB0vLLlHAKAXZJi1lpXz7n+Fha11DpJtEu
 X9H8vquURJ6sCkUpvuv5D/vVWFEvhNiiv851F7EIoXRjjqW5BH25fO/oOi1dYli1iukioFCph+x
 wyUOGEF6ExYRB+cQCEsiRZWl1m9fENJnVtGgLh0u6EIWVOt16x3jYAmbTrQxMzP+5E+U2n9rtHq
 /u2j6US1qLT3osptwrKEWvPf3ojZuHqq+E1yU8LGPabG2oqhhyJjZXme1iRZfG3xK8Jch+0nbdB
 7mefmKQMSnAoRAZDpJ7FzWVfNPbril4IFFHUl4U/CjniQ4xdD2D3CGrw20gEpWXZ7JfkatRcQSV
 /9q049H76keSXZzQ81RZvOUEmw
X-Google-Smtp-Source: AGHT+IEVX67uU3FpW4nxzjvfU0oenQ6NQBjeE6BIgWaK4SXfI8zsKMTPwXpkGGDPzcPayEUNxdHj5w==
X-Received: by 2002:a05:600c:3b08:b0:46e:396b:f5ae with SMTP id
 5b1f17b1804b1-46e7110cf6fmr42051875e9.16.1759562125089; 
 Sat, 04 Oct 2025 00:15:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723432c9sm61114855e9.1.2025.10.04.00.15.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/41] hw: Remove unnecessary 'system/ram_addr.h' header
Date: Sat,  4 Oct 2025 09:12:55 +0200
Message-ID: <20251004071307.37521-30-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

None of these files require definition exposed by "system/ram_addr.h",
remove its inclusion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20251001175448.18933-7-philmd@linaro.org>
---
 hw/ppc/spapr.c                    | 1 -
 hw/ppc/spapr_caps.c               | 1 -
 hw/ppc/spapr_pci.c                | 1 -
 hw/remote/memory.c                | 1 -
 hw/remote/proxy-memory-listener.c | 1 -
 hw/s390x/s390-virtio-ccw.c        | 1 -
 hw/vfio/spapr.c                   | 1 -
 hw/virtio/virtio-mem.c            | 1 -
 8 files changed, 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 82fb23beaa8..97ab6bebd25 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -77,7 +77,6 @@
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost-scsi-common.h"
 
-#include "system/ram_addr.h"
 #include "system/confidential-guest-support.h"
 #include "hw/usb.h"
 #include "qemu/config-file.h"
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index f2f5722d8ad..0f94c192fd4 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -27,7 +27,6 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "system/hw_accel.h"
-#include "system/ram_addr.h"
 #include "target/ppc/cpu.h"
 #include "target/ppc/mmu-hash64.h"
 #include "cpu-models.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 1ac1185825e..f9095552e86 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -34,7 +34,6 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
-#include "system/ram_addr.h"
 #include <libfdt.h>
 #include "trace.h"
 #include "qemu/error-report.h"
diff --git a/hw/remote/memory.c b/hw/remote/memory.c
index 00193a552fa..8195aa5fb83 100644
--- a/hw/remote/memory.c
+++ b/hw/remote/memory.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 
 #include "hw/remote/memory.h"
-#include "system/ram_addr.h"
 #include "qapi/error.h"
 
 static void remote_sysmem_reset(void)
diff --git a/hw/remote/proxy-memory-listener.c b/hw/remote/proxy-memory-listener.c
index 30ac74961dd..e1a52d24f0b 100644
--- a/hw/remote/proxy-memory-listener.c
+++ b/hw/remote/proxy-memory-listener.c
@@ -12,7 +12,6 @@
 #include "qemu/range.h"
 #include "system/memory.h"
 #include "exec/cpu-common.h"
-#include "system/ram_addr.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/remote/mpqemu-link.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d0c6e80cb05..ad2c48188a8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "system/ram_addr.h"
 #include "system/confidential-guest-support.h"
 #include "hw/boards.h"
 #include "hw/s390x/sclp.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 8d9d68da4ec..0f23681a3f9 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -17,7 +17,6 @@
 
 #include "hw/vfio/vfio-container-legacy.h"
 #include "hw/hw.h"
-#include "system/ram_addr.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 1de2d3de521..15ba6799f22 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -25,7 +25,6 @@
 #include "hw/virtio/virtio-mem.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "system/ram_addr.h"
 #include "migration/misc.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-- 
2.51.0


