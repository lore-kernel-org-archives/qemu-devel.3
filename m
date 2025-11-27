Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E994CD11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObrq-0003BS-IZ; Thu, 27 Nov 2025 08:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObr4-0002jw-Qs
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqy-0001IO-PY
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xgDAhhijifto90Oxu+cfsrCTAQGrn52zMBiEFLdoonA=;
 b=RiB3SYwfkVP/OqFg7G7hZeh6kPNYnkpjh96ODbuviD0Vn7hKC4kQVbapAjtvtzmeGAjJWH
 IfmBi2aSM4k+KnyQe0nV273iR+tUL4J6JGE0hZYxaSDOexZECwt5Q+jJa3qaRc1WZZQgNo
 X6ekeDpK+WZ5QPpjbczxfF6T/meX0tU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-78d88uXQO7yxPBGS0s2NyA-1; Thu, 27 Nov 2025 08:16:01 -0500
X-MC-Unique: 78d88uXQO7yxPBGS0s2NyA-1
X-Mimecast-MFC-AGG-ID: 78d88uXQO7yxPBGS0s2NyA_1764249361
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6411e349b73so976453a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249360; x=1764854160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xgDAhhijifto90Oxu+cfsrCTAQGrn52zMBiEFLdoonA=;
 b=JI1g8vkiotvo5to1izkCJ/p5zRV5SNVzqHlMHFPlaHMMDMWGZnAi2fMIpjLNlzrKzk
 sojqa5RYfVrmJ61tU/OADyg41foMHLRJ9YgNz+zSf01gfxW5yqgxhFuakdCExRucjVwO
 EyUl+kfzs9TNOcCdltpyH1yLtpmeGAilszED8w7/ONrJiCFY8i5pkWBohZlJmXtzMY7F
 oWy7wpGbh7S9FoYnee3wNMMHANJtvXLNP6gbBYHKyLzP63WFLYUX5IcZKv1TSN4VQ8p4
 XVR43WPmICvnTvZdD1TE1GvOO92mVX3U+Sk4H+VTG2wI3enbAhEQRgH0QnvjGeyvPwwH
 y95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249360; x=1764854160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xgDAhhijifto90Oxu+cfsrCTAQGrn52zMBiEFLdoonA=;
 b=rEXaT+VCYKWyYkyo66p13BB9obz4KYOxUBGdSObLPqrMYZxUy5f42Htu9/yM7hvebI
 QmG0gsCkMEwjAisVCHKt2awieASTBUqvR9eyEJUVs49CfbKy2BEBANnV7v/aYlUYCpDT
 ALr4pidDMGwNnfTA8cUXV+5+7BQ5hLlZW7o8x3xypUr82W3WR7x+SQg9atWZdLkTL9hc
 EN/PslS0MSjtRqqhjMeoXdgTZVOsQLf0FT7MiN5JPnZauZXTCsyGuP8xBC3d6a0meAWB
 HWXUUYAE52xUzm+VoX4QIdi7BTwNljEoWETWFVrj02ILFPPNbtk7XLyxQ7FKglwvjT1y
 qgOw==
X-Gm-Message-State: AOJu0YzE7rgU8tpY5LRbrhee5z5IRSB1KWId9TJDTHYZJ8wZVlt9ysId
 U38V/reyLwcSyZprL5Mr+4xLjs9ZJ81Dk2cXIkFtH4SguSEDNLTIcRT8z2mUNaP6x0RYlbJagnn
 26rCwcqq6SM9UCoeVTXY2aDRQkhVm7ZytwVT7/G5wdP3t7mjkod0HzyOdADZ6zRpqusVS+E4zN6
 5TGB2MABgBgdl9MmrjwXUSrldvUqJUIGj5fjEI9u4U
X-Gm-Gg: ASbGnct3ULUrhl03OmLzwRJjT0OSlsKnXy+C5xRJvazLmTUhts5Y5tMI3vA3IYX+W3+
 YxOd2Wui4CC1ILPKBye9J7cqFMn8QxtwLZBVDtuWkKzsgMCCQYfS7nm4ojr04AGDMaVpaK9Jpfc
 ZkhjArKUv+38lff3+n3iZvr9rZrNLbLkMvvFvx/+3AkHJsrwD9pz4wTri7QIUQAxOoh3WpS9BS9
 Rs5BPp9m7foAuDkMyVu4f5Sa3MuDPLPNvCP0eGv80B6SLF1xw+2HOKd7N8MuzNFnTS4yV9t0szm
 y9mu6nvNQGH0rS6Bgpna9+VqaCvvfV7K72UVrl8SA6M/XQmx2lw+Z4cG/66ZBpyMkPlQeo0t25F
 zUH3DinqJGfofD4v2rIwtccY/PdJCdEXdlP/NEZNTURgRZ9bQ+1uQq6BiA51dmYybrPX/F9e7lr
 qE+OAV0esBObKqUcQ=
X-Received: by 2002:a05:6402:2714:b0:641:3a92:7e6f with SMTP id
 4fb4d7f45d1cf-645559fcb28mr20760812a12.0.1764249360131; 
 Thu, 27 Nov 2025 05:16:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2ytSeuDOZSRwcw0SAST/YJR+190SVxILIQmAC47bve/p6q1HfaAtZXs2xqCYREErud09jkA==
X-Received: by 2002:a05:6402:2714:b0:641:3a92:7e6f with SMTP id
 4fb4d7f45d1cf-645559fcb28mr20760776a12.0.1764249359655; 
 Thu, 27 Nov 2025 05:15:59 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64750a90d73sm1549460a12.13.2025.11.27.05.15.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/28] include: move hw/stream.h to hw/core/
Date: Thu, 27 Nov 2025 14:15:11 +0100
Message-ID: <20251127131516.80807-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index e34c3e6dac2..72c70a46553 100644
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
2.51.1


