Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7072DCFC286
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0eww-0006lz-0e; Tue, 15 Oct 2024 06:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewd-0006hX-1O
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewb-000609-Ge
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43057f4a16eso45357135e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988703; x=1729593503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wkuQG2KTedUFhwN2ENhcCvd0nQ0K3RXT8cJBNOsNYGA=;
 b=Qag8AGa+L7wC82DDWzGQzvh8kqTS3huYVr7Nu2gzpqjmfu6jcyXrMtcrl+jSdYQLrs
 2x+NhziPYB0ck8W4Gen086uw0SlroCiSc6DjIosUvVqO6GV30AmJCAR5fGHcwnrKLq/P
 M1iKx+RbWEAWaYQdseeg1F059Mh2wWnUu+SW6Kmf2iZUfvr8I/c0ATcvQKlKpNobN+y7
 Q3/S3zFal2zwfUB57HGn+6ZuErNyUzOth0KFutuGl+OJYWFnAWj6eEsSNWZeF+cTUyNM
 as5xfLcKrkv5hxZtqmLCmG9xmsrXo2hUUizYADgYnkMZNVB+u3kZ95EX+6DCzIA1bxYF
 RObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988703; x=1729593503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wkuQG2KTedUFhwN2ENhcCvd0nQ0K3RXT8cJBNOsNYGA=;
 b=W56IDk3iwkX0SdShxZ+bB7gY3pnH6OQli1p1EMATjKBAf826vF9vQfmjLMQEny1TZx
 1bNOqdSKf6hUhmH2R5zgCOY3hD0IKJkDoOlH7+nKhpNmPIsxFNdJvAvpd4FnlFiM5sHS
 GnjxPqYY5Jpi4YttS/0zcalDl49l5HRwySc/uSs6SEfsriBmrHCgLfvYeCxJ7IAbGg4i
 uSHEzBWEvglZrPSjyRr0x5NYKhcRlUi59SEfE0g4L7jxbozhaPrXns7Ql12+RydwnQ1k
 F0mb9J3Uelh8iiky+Pgn5BLOwEOy5IvzyXy50ZyW/rN4tcbuwCRtYd+Eg2vTPFEA3UnJ
 LAJA==
X-Gm-Message-State: AOJu0Yy2RDRUv658+nHvHh+m7cOvtHPYWauXu0IBFuYE8Lz/rkhcZRcU
 OaeHgtTDDgvSiZWhYIXYJc5LFtEIJJuuYv0Dc0ZUwplqT34v4YeRRxs5OpzFKrcpcfKMmf6tBRM
 1
X-Google-Smtp-Source: AGHT+IGekR1bIUaPIBIG4OUfKJWHvCOqkdqFwSXTpRKUj9VTUHODJzZQezUhNmPaqlSbL+Dn/QAwew==
X-Received: by 2002:a05:600c:4f88:b0:431:416e:25f4 with SMTP id
 5b1f17b1804b1-431416e28cemr12122215e9.34.1728988703044; 
 Tue, 15 Oct 2024 03:38:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/28] dma: Fix function names in documentation
Date: Tue, 15 Oct 2024 11:38:07 +0100
Message-Id: <20241015103808.133024-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Ensure the function names match.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20241012-dma-v2-1-6afddf5f3c8d@daynix.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/dma.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index a1ac5bc1b54..5a49a306284 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -152,7 +152,7 @@ static inline MemTxResult dma_memory_read(AddressSpace *as, dma_addr_t addr,
 }
 
 /**
- * address_space_write: Write to address space from DMA controller.
+ * dma_memory_write: Write to address space from DMA controller.
  *
  * Return a MemTxResult indicating whether the operation succeeded
  * or failed (eg unassigned memory, device rejected the transaction,
@@ -189,7 +189,7 @@ MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
                            uint8_t c, dma_addr_t len, MemTxAttrs attrs);
 
 /**
- * address_space_map: Map a physical memory region into a host virtual address.
+ * dma_memory_map: Map a physical memory region into a host virtual address.
  *
  * May map a subset of the requested range, given by and returned in @plen.
  * May return %NULL and set *@plen to zero(0), if resources needed to perform
@@ -216,16 +216,15 @@ static inline void *dma_memory_map(AddressSpace *as,
 }
 
 /**
- * address_space_unmap: Unmaps a memory region previously mapped
- *                      by dma_memory_map()
+ * dma_memory_unmap: Unmaps a memory region previously mapped by dma_memory_map()
  *
  * Will also mark the memory as dirty if @dir == %DMA_DIRECTION_FROM_DEVICE.
  * @access_len gives the amount of memory that was actually read or written
  * by the caller.
  *
  * @as: #AddressSpace used
- * @buffer: host pointer as returned by address_space_map()
- * @len: buffer length as returned by address_space_map()
+ * @buffer: host pointer as returned by dma_memory_map()
+ * @len: buffer length as returned by dma_memory_map()
  * @dir: indicates the transfer direction
  * @access_len: amount of data actually transferred
  */
-- 
2.34.1


