Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D253C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvE-0007Ot-QW; Thu, 22 Feb 2024 15:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFv9-0007IX-SW
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:56 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFv7-0002hZ-Ky
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:55 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d71cb97937so2312355ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634632; x=1709239432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dE6xy9+D6Je1Etl+ajN+bavVnxpk9B7ygAyJhkrFQtk=;
 b=ZPcjilfwiB9pFaFEHttDEb2Zqa4XhyG/2l8moqjrSCn/w9R25x7xGFDkWu0w/kw1YI
 WEyxXOLWded6ejm55hxcbttaXTUOS+nYyj/LuKHA5AP7/lednII02b2YT1PECRiZv+DV
 nj65aUd9YtRwB7efmyKgT1eAjfmrqeqoRtwB9tdV3aU/49DehUz9oN4WbsgwNX8nv/a4
 tcb+fl9XDTnoe3XZDteo0cd1hhttqaRMB3x3IlWIQNuWGqMILH2V4xuJJDcbxmPl81k8
 54dWUX3dAQiZuT2Ek9R1ObdDBz72EnFoOUmnO6coEWQAQ5dCjexwLnllugQp87VN62f/
 8aSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634632; x=1709239432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dE6xy9+D6Je1Etl+ajN+bavVnxpk9B7ygAyJhkrFQtk=;
 b=NNncZmAyFlsaDs8khgXNbEkEYq53ZB3/wVWgvnUUcTbYzRet4Zrn4qVLhjM7Jux/fM
 fhLkwJnfzaEPvKhhoyedxje5pfkTPOtb3elUuzGugSffxsOtxTJTcPzpiFZvRGX7TCF3
 zg8KHG3xkLMqd2ztsRXHtEA8yPNNca4msc5aVgdLtcfb/Rh5YqLkwElR/mYvxz06YUFZ
 OcAEDp89SMpZMhXREn4RrPpVyd0iMwMZZIfviO5owA1eiv1ZlWeSlxTaO+IdTX9hshHx
 XmFTXUjKxH9+vemYdSXUvBY9JQF2xtBODk+rsLZMC0ORughHHIz4L4nVi3M9wh8RccOY
 06nQ==
X-Gm-Message-State: AOJu0Ywn+jxUxEYQ+4sM5tbzJCwe+AfFXK3lI9CklmMlfSYd+sZITyBn
 /hQrtidS5Qma/9eFLSdoj38Vu3sYKELx9PTho/37ROVGFzpY71jpRT82X28CV/JhGTtfflzzFAO
 g
X-Google-Smtp-Source: AGHT+IG9+60t4gx+wBn0FPSNh0kEcv84Q0jrmCfcpRCHkWKGRJM2X453l6ukGYgTwNvpEz3GCpy3KA==
X-Received: by 2002:a17:903:2442:b0:1db:fc18:2db9 with SMTP id
 l2-20020a170903244200b001dbfc182db9mr12395566pls.64.1708634632438; 
 Thu, 22 Feb 2024 12:43:52 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 17/39] softmmu/physmem: Remove HOST_PAGE_ALIGN
Date: Thu, 22 Feb 2024 10:43:01 -1000
Message-Id: <20240222204323.268539-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Align allocation sizes to the maximum of host and target page sizes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-15-richard.henderson@linaro.org>
---
 system/physmem.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 3b08e064ff..3adda08ebf 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1680,7 +1680,8 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 
     assert(block);
 
-    newsize = HOST_PAGE_ALIGN(newsize);
+    newsize = TARGET_PAGE_ALIGN(newsize);
+    newsize = REAL_HOST_PAGE_ALIGN(newsize);
 
     if (block->used_length == newsize) {
         /*
@@ -1916,7 +1917,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    size = HOST_PAGE_ALIGN(size);
+    size = TARGET_PAGE_ALIGN(size);
+    size = REAL_HOST_PAGE_ALIGN(size);
+
     file_size = get_file_size(fd);
     if (file_size > offset && file_size < (offset + size)) {
         error_setg(errp, "backing store size 0x%" PRIx64
@@ -2014,13 +2017,17 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
+    int align;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
                           RAM_NORESERVE)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
 
-    size = HOST_PAGE_ALIGN(size);
-    max_size = HOST_PAGE_ALIGN(max_size);
+    align = qemu_real_host_page_size();
+    align = MAX(align, TARGET_PAGE_SIZE);
+    size = ROUND_UP(size, align);
+    max_size = ROUND_UP(max_size, align);
+
     new_block = g_malloc0(sizeof(*new_block));
     new_block->mr = mr;
     new_block->resized = resized;
-- 
2.34.1


