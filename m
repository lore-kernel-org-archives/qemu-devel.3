Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E52ECED270
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 06:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy46f-00053S-Mk; Tue, 08 Oct 2024 02:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sy46d-000532-T4
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 02:54:03 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sy46b-0006jX-05
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 02:54:02 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e10ae746aso487916b3a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 23:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370439; x=1728975239;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eoKeg070ISHJdTi0tJlsnTrJcindlp2xNxO1qtraMEs=;
 b=awaL+wCdMi9x6XWtd4u/qiqVXaURvA43ToikPgd48A8IOJQs4aBtEc3pZM33R9np/1
 n8Wxaxknr2ejL1/ECZPalwDNYjj5eQLzDTWqMPJAc5m7ojalAkNooEfxI+c9PJF3+j3X
 sGnyHWGeQDeKBJ6uCfHbZnP/vinUB9tnXNSwpRztmDWKc3Z3R0/pxfyvHC3s8f3xjmVv
 qah9vkwj0fOkiZKSM5DQmznmqQcrkhZaEMZLpVU/O0UtZ6Jlg4cVFVXTgVneTp2ZXv/9
 F4rhM6hWa6IRGsNIjEBpv9/DECYbEbiV3MhXt3Y0GLbjxwvHj9EkigQm4zUooe4IIKGj
 q6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728370439; x=1728975239;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eoKeg070ISHJdTi0tJlsnTrJcindlp2xNxO1qtraMEs=;
 b=pI+HuGcQLd1BG/5x3ws5/RYdlW+jJAxsWm0oOh4VjUyg1oY3FLBA2IGpaua/pFU3Jv
 4+ZKBSMeYpYRnDjMXZb8eFmerDihuXwiwJjS6ZUVkUxxRo/cN4P80RoH5hO+kUlLXkgc
 Scz3MHwbxPtLjCIxQXToXR4kvfi020+XmU5Jk2dkAR2qPuIImSZ8a4ygKftiIlso/ih6
 ZPhHiXhozst+PITSoz8l5Q//4vGPe71QWWbUCb5AX3Sg0VZIR/50xU5zDm5AA2bgjVNN
 oouIFaJD8MBpxNcvfWf82no0yrG7+q7PFK/55skwUhi8kczjufr7oxPFL+i0TT+Y1UEq
 Cq3Q==
X-Gm-Message-State: AOJu0Yx0yZEslNzBnP4wn535LF5jqPyutGOvz77TGODl0NRd1kpGYzme
 /IbxsG05sKIZHjtG0Cl8cfOz3p9NOP5xI4++YbWuDBVjZCqDYc2NSQh/OhFR5VI=
X-Google-Smtp-Source: AGHT+IFkg7LM3GtggujQctyGN5nmDTCn5B5yK6X34+qMOMPtcTihDN+HDDxKypnaacYuWFvfzYJOKQ==
X-Received: by 2002:a05:6a00:1149:b0:70e:a42e:3417 with SMTP id
 d2e1a72fcca58-71de23c7d54mr23334480b3a.10.1728370439445; 
 Mon, 07 Oct 2024 23:53:59 -0700 (PDT)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71df0cccab2sm5459218b3a.58.2024.10.07.23.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 23:53:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:53:55 +0900
Subject: [PATCH] dma: Fix dma_memory_map/dma_memory_unmap documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-dma-v1-1-c439c0fc5f3a@daynix.com>
X-B4-Tracking: v=1; b=H4sIAALXBGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwML3ZTcRF0DIyPDNMvkVAsLSwsloMqCotS0zAqwKdGxtbUAUeTpy1U
 AAAA=
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Ensure the function names match.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/sysemu/dma.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index a1ac5bc1b543..e132ece4510d 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -189,7 +189,7 @@ MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
                            uint8_t c, dma_addr_t len, MemTxAttrs attrs);
 
 /**
- * address_space_map: Map a physical memory region into a host virtual address.
+ * dma_space_map: Map a physical memory region into a host virtual address.
  *
  * May map a subset of the requested range, given by and returned in @plen.
  * May return %NULL and set *@plen to zero(0), if resources needed to perform
@@ -216,8 +216,7 @@ static inline void *dma_memory_map(AddressSpace *as,
 }
 
 /**
- * address_space_unmap: Unmaps a memory region previously mapped
- *                      by dma_memory_map()
+ * dma_space_unmap: Unmaps a memory region previously mapped by dma_memory_map()
  *
  * Will also mark the memory as dirty if @dir == %DMA_DIRECTION_FROM_DEVICE.
  * @access_len gives the amount of memory that was actually read or written

---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20241008-dma-0221f9ce8898

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


