Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE52C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV75-0002NH-7n; Thu, 15 Feb 2024 01:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6x-0002KX-VU
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6w-0005UT-CK
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:43 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1db5212e2f6so3915055ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978041; x=1708582841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xf7vdSAvh/ZeTBRvXJBUTE4ih7Lx/NEC7LNkf984wzI=;
 b=b5/s+50jnCvU47HaumMDOWrixy55mYqUwuR/6/oF8ZQh98ljwurwbGyaUJpWEeBiQI
 zJezHEtpBOsPxXYxLtr+vX4OOvMok2YfDATUmCLrdm0OBK4frbaQlykTQuBlRjWSweu2
 9ZR3U82t7EJkjTadc+hfBFjOr9b+20MMPwMTqQ3HROvo8MYClsIZVFOaIKYFUCQiE4CI
 yPKJ7JMENxmklh6Hm5IhJaypXHHMMPphmCWGx58g5DP4+QrrsUruxOkOB1nFOgpYm/bn
 c26MCpjMBQ0wX3NAKttexun9VrCuldaixBOYQ9l8tttNS1Fyn8TcXTAzqyNehQFaV4yU
 JqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978041; x=1708582841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xf7vdSAvh/ZeTBRvXJBUTE4ih7Lx/NEC7LNkf984wzI=;
 b=NQB30TGLvCnykAgZOXOpmMrURX03AFVn0M2KfIdbH/J9t1Bv1EPp3ebvOnj+ZW+59H
 wj3Csa55aycXYbpj5KSXIachBABKlY/RXywxWNiK/0gWCoE4+AsXHFW2JrxnnB+KgC0G
 nccYHmT4LXQNlxj26HGgfPl7wua7/tjy3N3B606kIXjeAR6Lyk+FkN+t1ZBtlGqmeOxA
 Iqu8EXhumNFOksD5lX33MkkDTPIEn6tXYq86amRHeILJ+74PPcVzloSJ2WlB2qZMLWJZ
 0bbO/OWC5U4XIhB4c3ZDN7vIk37bUguh7fKRiBn2TrXgJWFAAH5p9h9Q1IUaPG2GBg8c
 c4gA==
X-Gm-Message-State: AOJu0Yx8XCyOQrIo991lrBuLB+es6dG/cgo1gLuktYXNVSPxXMb5Q8T6
 HNHJWiCySRqQOn6GGsHBRzeIP1k0xyg2Q9lnwMwUXDMrJTExKxguaSbF+0kfUKkSd4Sw2x7ZK+u
 G
X-Google-Smtp-Source: AGHT+IEdH6d01RJl0y/+qBoK/94nPayho6ADeqOQKWLhTi3fS0C5Ud+YeaSabt8VQzwESczyTzbiTQ==
X-Received: by 2002:a17:902:d2d2:b0:1da:2128:eb3b with SMTP id
 n18-20020a170902d2d200b001da2128eb3bmr6822345plc.28.1707978041161; 
 Wed, 14 Feb 2024 22:20:41 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 14/36] softmmu/physmem: Remove HOST_PAGE_ALIGN
Date: Wed, 14 Feb 2024 20:19:56 -1000
Message-Id: <20240215062018.795056-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
index 508dcb7494..6b7c5747da 100644
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


