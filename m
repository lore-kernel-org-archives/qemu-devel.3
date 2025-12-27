Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DD4E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQI-0002ZE-4P; Sat, 27 Dec 2025 04:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQF-0002XT-Hd
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQD-0002T7-Vq
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWrHJCMeB68IQkNuStswZsduDLDnLKkS5nzviqg04gA=;
 b=c8BvZFn7a2bOgfVSIjfH2CGIHVUL6Z09MMXT8UCx21/W8RX6vLLfOTfOB08+TmDB5Jbumw
 KGxTb0KawNvWRLsDyKV1Dl6gQO27CY/Ix6tQmTI/62wgnEZoNToTZz0GfH6KVsRu8z8EPw
 gx6+N2HiB7XiraiabtfSup8FmFn2YTo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-aCubD4NFOn6iDTsvuKMteA-1; Sat, 27 Dec 2025 04:17:11 -0500
X-MC-Unique: aCubD4NFOn6iDTsvuKMteA-1
X-Mimecast-MFC-AGG-ID: aCubD4NFOn6iDTsvuKMteA_1766827030
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47775585257so54465125e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827029; x=1767431829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NWrHJCMeB68IQkNuStswZsduDLDnLKkS5nzviqg04gA=;
 b=qPkALXX+Z2/u1HHEsI/E3ow6rX6i+D5UnEvDwHh++hKgQYnSFJi6T08q4rw8KNdIgW
 PMbxHyfvuo0Kez9+AN1wWyb4+2HKLjgvLX0xVq1mnlC2AQp6rXGVog11YwnUwIhlHePH
 LqIKLMPF6ZyBA8Lzi6m51diuL8E7qML+PIBnymGq3/NvP1ly7Fprr5eEbpw/QW0/9yuM
 36Vge9SVKnvViJDbQcZLT2j4IQCHrvRT43GsaLOkIJ45a4qSEor0z195FXOPoevMvX1R
 ztQmR7PowwqMPnwRsjdUHz3KRriz0HT4FUhcp5d7ttxuBX0Bqx4g4iCPQ6I9pArFN7yS
 5axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827029; x=1767431829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NWrHJCMeB68IQkNuStswZsduDLDnLKkS5nzviqg04gA=;
 b=LFT5NWKlfG+zpf5nFcfHx1m4RE6bQrYf35alADgJyZdym5+Re2ZogJLB8OtB5vrRj8
 xu5TMstWY2PeLzv8deY4ECKnBNPG7eCbzl88kEUyOeM2qCF9mPoenZEbIH4cZNrNqCkQ
 XvA7pHywkq8pHoq1C8HPXWvei1DqtmtgesfzR5ZHMCVTUHe/8/9GElv2zUaJXP+LaWF6
 BwgogaozseF3lFsJMjm2d2dw3jasknmfmP+B6yljnxFVs++i8vNVK1I+wVmC+ZFIijqE
 4cQDvb9sN8FHcJO2lJPWJ+K8Vg9xh1N3cV+2OpwSbsbcxSOavJCxTYQbqIC5FdEoxrY/
 bwCQ==
X-Gm-Message-State: AOJu0YyQ2N2ErCEyGJgAAT3yrJ4PDtddazDqecPnJMpYCHSa2mVR+FPJ
 ijFNy3fgGpgIE4NBJMvCHKXHzAVx1AhsmVgpycumnlZEXspbP9K1rbN90ZMghZQGaFjlybAq7IK
 p10aVrgnyQ32bLaRmtY/02huuTXactmV3ojFKcaP6HMy5sPDEJ0XH8y0rsXHR3orLLPcKkFS5MD
 DdxFizofthq+XCVKQ5/8Co25AZIYnYw+8MfF4yDzui
X-Gm-Gg: AY/fxX5GkPOqmHPMYiUN3phwqKjKjkfcN8IR6gQ0CS7a845owrTC/d+Z++6b5xFHriH
 HWax8W88TFZCuvquxAs63xO3yuRGjo7n457YAQh7UTelc4KHMxWW2hQbaP8LMwvVuUOaLNKIuba
 QwId6eUmMUda7iCCOU6RZHiCY7Vt6qHaLhXvMNSnfAMJiaLCgHwZ8O9x27iNbvGTOUpDz8l3IzN
 Ri/w56OZxhmoaV9FQ/HZIXoI9oeVxBGHETgV92k6g0PUqGGx/45kKjreRLk2Gvn2ruX6JE8fRzR
 CREwglxqDOvGtnBdrcz/FV8pJbY7E7uxlbuEtxxPledWfTo1PMbX1mh6ik01ReYF7FUWbuQkEcs
 BOKAdQYE5Ybm6kFmGcm/BwxNwV+AYtkaMfBwjnGH6tBcqBocyei97NmAHYZqConDTe12WaE8UaS
 CH3wfRBFIM9PlsmOk=
X-Received: by 2002:a05:600c:468f:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-47d269c7019mr240035435e9.18.1766827029578; 
 Sat, 27 Dec 2025 01:17:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9dswpvgCIolYnjB86n/pnqocL7MKEhYaz7HM3uXOuaru81+qOZM51CHDu3xbpHy2HLw0BIw==
X-Received: by 2002:a05:600c:468f:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-47d269c7019mr240035285e9.18.1766827029156; 
 Sat, 27 Dec 2025 01:17:09 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193e329asm436417255e9.15.2025.12.27.01.17.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 025/153] include: move hw/stream.h to hw/core/
Date: Sat, 27 Dec 2025 10:14:12 +0100
Message-ID: <20251227091622.20725-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                         | 2 +-
 include/hw/{ => core}/stream.h      | 0
 include/hw/dma/xlnx_csu_dma.h       | 2 +-
 include/hw/ssi/xilinx_spips.h       | 2 +-
 hw/core/stream.c                    | 2 +-
 hw/dma/xilinx_axidma.c              | 2 +-
 hw/dma/xlnx_csu_dma.c               | 2 +-
 hw/microblaze/petalogix_ml605_mmu.c | 2 +-
 hw/net/xilinx_axienet.c             | 2 +-
 9 files changed, 8 insertions(+), 8 deletions(-)
 rename include/hw/{ => core}/stream.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e241690bdce..44d84aa243a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3600,7 +3600,7 @@ Streams
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: hw/core/stream.c
-F: include/hw/stream.h
+F: include/hw/core/stream.h
 
 Stubs
 M: Paolo Bonzini <pbonzini@redhat.com>
diff --git a/include/hw/stream.h b/include/hw/core/stream.h
similarity index 100%
rename from include/hw/stream.h
rename to include/hw/core/stream.h
diff --git a/include/hw/dma/xlnx_csu_dma.h b/include/hw/dma/xlnx_csu_dma.h
index 63af4586dd9..4d6d18fb9b5 100644
--- a/include/hw/dma/xlnx_csu_dma.h
+++ b/include/hw/dma/xlnx_csu_dma.h
@@ -24,7 +24,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/register.h"
 #include "hw/core/ptimer.h"
-#include "hw/stream.h"
+#include "hw/core/stream.h"
 
 #define TYPE_XLNX_CSU_DMA "xlnx.csu_dma"
 
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index 7a754bf67a2..56cf69a37d2 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -27,7 +27,7 @@
 
 #include "hw/ssi/ssi.h"
 #include "qemu/fifo32.h"
-#include "hw/stream.h"
+#include "hw/core/stream.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
diff --git a/hw/core/stream.c b/hw/core/stream.c
index 19477d0f2df..bfcac938802 100644
--- a/hw/core/stream.c
+++ b/hw/core/stream.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "hw/stream.h"
+#include "hw/core/stream.h"
 #include "qemu/module.h"
 
 size_t
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 7cdd76330f3..90ba7bf0573 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -34,7 +34,7 @@
 #include "qemu/module.h"
 
 #include "system/dma.h"
-#include "hw/stream.h"
+#include "hw/core/stream.h"
 #include "qom/object.h"
 #include "trace.h"
 
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index ffe258cf31a..b390d092699 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -27,7 +27,7 @@
 #include "migration/vmstate.h"
 #include "system/dma.h"
 #include "hw/core/ptimer.h"
-#include "hw/stream.h"
+#include "hw/core/stream.h"
 #include "hw/core/register.h"
 #include "hw/dma/xlnx_csu_dma.h"
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 9c2b0ff0b37..51ee237d584 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -41,7 +41,7 @@
 
 #include "boot.h"
 
-#include "hw/stream.h"
+#include "hw/core/stream.h"
 
 #define LMB_BRAM_SIZE  (128 * KiB)
 #define FLASH_SIZE     (32 * MiB)
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 36047a51c00..451f8da2122 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -33,7 +33,7 @@
 
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/stream.h"
+#include "hw/core/stream.h"
 #include "qom/object.h"
 
 #define DPHY(x)
-- 
2.52.0


