Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174BECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s6s-0000nm-KO; Wed, 01 Oct 2025 04:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s6W-0000fN-6X
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:22:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s6B-0005Zv-NW
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:22:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so6467675e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306922; x=1759911722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmMYrzZ4D+COFB5SMLmnCIFwzyfRzy/9G7uraFCWXGE=;
 b=hD0OG2sLRpMn6mx4O5hk07YQXLxRruSjzSUFo/JK3mApKOVbLBfrss+aoCyDEcuSd6
 GSzSXQ8IdW/x4If1pwFrAGFksnJ+WSFPBggy0qvDoITaeWC2YUX5i9iDkmWTPlyXLOKO
 ebJuV6kHEqzswsCm18ywBxCMxzPZyDEIM0Sk0ep8jz/RkYn33TA7209Le1cmofb+YLSs
 zb1YyxKb4bLLx/gYmVhi9AxzdyJj5vnq0NiFZbwSj/bzaDWUiEkNE+jqWo+cEc7EWNBx
 PB/zq7U3h0A4PlkHtrcIPWBx8bls0XnW/vn0lym/xcMwsU8xudSynaawCWkCmoyyZk3Y
 DDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306922; x=1759911722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmMYrzZ4D+COFB5SMLmnCIFwzyfRzy/9G7uraFCWXGE=;
 b=rRKPA1Pk2SrVXISFYIuNvYFWmBRkinDp6aTz9mvJA0Yg4TsnzCwyEbSnCu5SMz1Sqn
 LcyS2dP5H2a0aq2bTzZbO/VdbCYV5nXYBn/MEJyHv+Cz9F/nQ+VDHlNsHoD3amn7X2wM
 kGx5+9hcKQL5A3o6CWZVCvZwcjwUUjv3hWRVsB35Iaqdhw+Id+scE6LLJRWhDgaFahzW
 yJ5lhL2o50/tGLVSQKK8Xy/g0OUTDn2rlRggzS+yEPdZK0L3he+Wvb8nV5cZn+brODup
 2cZlAbC15kB1uLC+Mu1jZ6i3i3cY/KMPv87SYAKZYNrvVd16MbIMftBMFN2aOEi1JLf9
 w8QA==
X-Gm-Message-State: AOJu0YxBIbDH6y+rv7mTDwazSeLikhWlbRAyw/+BAlBqptquCW8gebS/
 4A8qasIVAiQ5PhiZWLQH+tSMtLez++Q9+zdPzVS2SlOCNLedwitARDJH/hjvXWDmylTwU03GJ+o
 JHVh1t8oZfA==
X-Gm-Gg: ASbGncsuiKBvzYsZ8WMDCkfWVR3eQKlNjDaUAXxc0EXComsu5OXzu3+VLsfvpfO6zP5
 URlllai8z1qZYkZbVoJanfmrU9kfY3gEui66Xno+viARQK09t6s2MbsXfFME4/YMAXFU1A/etG5
 6TTXIX80qZmbpGZOOkhys+9AScUbE3a8apNfoH8SAOwff+lftrB+mJFmVTHJu80qWknNMYiyIry
 XCwbEmbro6tiiWbCs5UJeI3ikaxHSRjGb4Jc/tcjP+ZLEXNmh5ZwShWCv15afd6Dnko7z8ThzOB
 hhCDyUw9cQCFFQ15BvnfomavTF42n0ooZbTSsZMdCK5iZDjTdH+eTgOqQUCIjFCcrfD4rGmjAhk
 sci/PT3mWmA47i4TIOXdXJ2CpukosgpM80/wI20gM2sRRF/LAQMTWV+tCvUWkzyhhCeQgwiGUDR
 BKJ0WwH4IJGeWpdNkLj6p4
X-Google-Smtp-Source: AGHT+IHO1xSfq3+2eBPBriOScyM58WZ+3hjUuJsBi94Lwh6mBwAPJdjI/1LMjxcK+JWGn/tb5utZZw==
X-Received: by 2002:a05:600c:468e:b0:46e:36ba:9253 with SMTP id
 5b1f17b1804b1-46e6127b93cmr20886795e9.15.1759306922129; 
 Wed, 01 Oct 2025 01:22:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c3b75sm27136995e9.7.2025.10.01.01.22.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:22:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 06/25] hw: Remove unnecessary 'system/ram_addr.h' header
Date: Wed,  1 Oct 2025 10:21:06 +0200
Message-ID: <20251001082127.65741-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
index eb22333404d..15d09ef9618 100644
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


