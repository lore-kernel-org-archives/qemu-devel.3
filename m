Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38DCCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoK4-0005At-Vg; Tue, 28 Oct 2025 14:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoK1-00057q-RF
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:21:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoJy-0002hl-2p
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:21:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475dbc3c9efso27207985e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761675682; x=1762280482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNxVM5WlfMGkdiBkQUKUIDFWTm7wwHT2PE47Xc1PuFg=;
 b=KoLmBxvjni58P3I/OQ5aT+my8uWkJEZkfW6mDilqMOHKizGej9pakEWC8DXH9Z6BQZ
 6IueRWyctihuPHNVNI9Gk5FzyX5M5pfP5G0gY/MAfYi3DmxzdiTg2xLAfvM/MGg//Vj3
 uBfcJeYZ3rS50B/Az0qi61vt8/Nhrbd5fTBsgNcdIo7QWYHokLUoccjy+y7vkkF2+QjW
 R5eFUuyuxBaF/DRsHFxoGzobE0ap4Ar2Yg46b+ixZJigr3VVHzIyNL9PWJUlAbjyltG0
 E8Wqa6SG2Um5qu0UuCG9dKrZZrUB7Xub3ZdtrjvXHUm8xUANKlPXbPQQpHcbs5gVcILb
 tgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761675682; x=1762280482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNxVM5WlfMGkdiBkQUKUIDFWTm7wwHT2PE47Xc1PuFg=;
 b=SkQMypR7JjlOgsNxt1r334Ca3Nzw5t39tjxUCy1Ali7AhA2w+NANwt0+NXHIWQT/J/
 oxF+DDXfNUtbAijT7QpoUpBybAxbcm6vO8GTxiDYqhy6wCix5v0LQltWRH9MbDOSAk7v
 JK48PxbJI95Y1O9iX3fzcO3Ivtjegl2jm+4C/T3c8u/Iv0eFIXePuwiNu9tCjhvazrno
 IiPslL4bV6mfPHPXFeZf+GQ1mTA+T5Fj5i5mlIbXCwEnFCQOS6TNZR0mEcBvIQnvQRQa
 tVdVdvlinzQyGba8jyaEqsydmnL3YfY1kXkPmOgJgvbNJM/QjHY7n5l55H1QeNHLvWK2
 CoXw==
X-Gm-Message-State: AOJu0YyrJHzNDrhsaPXNVuzXmWFPK1tw0mYhxc8L4XWSQMQ7WzpZe3Bk
 LWTvKBBWTegnH/m6xWf6GlI0CdBrkivRJgil8Aun9YB/pvTty7zY93U7ICCKA3QcDRKKr6O8Sep
 13uPpcMk=
X-Gm-Gg: ASbGncvC1jdUOJh2zS03TILCX8QPYEjtHxzC7lEC3wbWx4UkB1PaNvZabXJv/4yjQOo
 SpyrMMBlHgALj75wKXy4akE99FjwCzG9Yo+j+sFKShENcXL6OCRuSyJD92X3S1MrcdfyH9wP3y0
 hmRITRM65Tqz09Dk7IJLN0uF31kt+RT4Vqqnt51TD4CbsEvHN3pQ1gYaOuu7oLPmgrsYUchPl5o
 jlSyb3mPvDfrytaGteHnkAlI44jIuYlfZcKxUlRkHTNdaVjcjV44hNCkTfJCZnWIpAxCjfsaOgK
 G70re55iXIKQuOheE52TiAkSKA+gndo0M8OGKSIr2yetnVR4fwJz4Lrtp2tI7k13qVyDhsMfUeX
 kWyD84IF1qkgPjOcZwMTNhx/n4jiTM9HRgkvEAz92t/DdFiMXRZPUF4Mb8LfFXC+Wh1l3u9zGQk
 pI9uAikXmsb8gw84mS9/9n/SCwaCBCx+u+TziDqS5iJm26p2bv3Q==
X-Google-Smtp-Source: AGHT+IGPvvSboRVK4jDOdh6s27u0FTr4UC3OsgbP4owA92aeWHz0dL+KCqlvt2kB6S2acByZkxFTfg==
X-Received: by 2002:a05:600c:46ca:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-4771e235900mr4315395e9.28.1761675682354; 
 Tue, 28 Oct 2025 11:21:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e196a22sm5526535e9.5.2025.10.28.11.21.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:21:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Subject: [PATCH v3 08/25] hw/nvme/ctrl: Use memory_region_size()
Date: Tue, 28 Oct 2025 19:12:42 +0100
Message-ID: <20251028181300.41475-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

MemoryRegion::size is private data of MemoryRegion,
use the proper memory_region_size() getter to get it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvme/ctrl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cd81f739975..9505f291f62 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -514,14 +514,16 @@ static bool nvme_update_ruh(NvmeCtrl *n, NvmeNamespace *ns, uint16_t pid)
 
 static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 {
+    MemoryRegion *mr;
     hwaddr hi, lo;
 
     if (!n->cmb.cmse) {
         return false;
     }
 
+    mr = &n->cmb.mem;
     lo = n->params.legacy_cmb ? n->cmb.mem.addr : n->cmb.cba;
-    hi = lo + int128_get64(n->cmb.mem.size);
+    hi = lo + memory_region_size(mr);
 
     return addr >= lo && addr < hi;
 }
@@ -540,7 +542,7 @@ static bool nvme_addr_is_pmr(NvmeCtrl *n, hwaddr addr)
         return false;
     }
 
-    hi = n->pmr.cba + int128_get64(n->pmr.dev->mr.size);
+    hi = n->pmr.cba + memory_region_size(&n->pmr.dev->mr);
 
     return addr >= n->pmr.cba && addr < hi;
 }
@@ -563,7 +565,7 @@ static inline bool nvme_addr_is_iomem(NvmeCtrl *n, hwaddr addr)
      * in BAR0 as well, then this must be changed.
      */
     lo = n->bar0.addr;
-    hi = lo + int128_get64(n->bar0.size);
+    hi = lo + memory_region_size(&n->bar0);
 
     return addr >= lo && addr < hi;
 }
-- 
2.51.0


