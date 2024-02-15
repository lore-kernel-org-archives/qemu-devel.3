Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D2FC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV79-0002Pj-VC; Thu, 15 Feb 2024 01:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV77-0002No-CH
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:53 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV75-0005X5-MD
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:53 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so479237a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978050; x=1708582850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZykOOhGWRLaDSZ6ojBtzy1ZtPjktUdeyK8bHHdP5Cx0=;
 b=t03gNKuXKadnS+julro7m84XhQpYQKueLooIhn09u8b9wHv2uWVtGqzQFpWVgREywF
 pNyWAeZAv76g7Zua+Iw+GPWdz1Bfw28htCubvzLGxk4L4qMesezHaWOHE1UQax3vdRS/
 ntiTUJutmlzWagt2DVHYuJZ2o827pQUCxOho4p9o6pZcV1bfpMUN0w0FhJ+PoBkXy2fw
 H8DNfmHQUnRJjtgNBpavJT02DHmbvwACJX/X+kvfavjgX+o39TcY8iNnWy5XjuOsIYnq
 AL72/l2C1h5u7uW0MfOKm8R1F/OeRU0lk3/qKDUoZJ2VdFtvBIC0vXMOmzUqbpdHHZDv
 trtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978050; x=1708582850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZykOOhGWRLaDSZ6ojBtzy1ZtPjktUdeyK8bHHdP5Cx0=;
 b=WL+S5rlLRRnndFl4pjmXC3liKprjTfannbDg8GSkDP8w2gm8pN45UFDXi9SnBg6ZgL
 cF2EM2ETX/29eA4HK+r6BwS2ypLDAhER3gH08vnFR8nIiZiBEgUFcaJVzgI+Fhaq7PRH
 YQ5upW/R1xnEtT7buF5qmIyr3OZB3K6de35+uU4afqWkbtNvS+VknTB+KVsQMaTJKlxW
 Wnww5WQQHb/0/sBq8shXTb6v1rmMZBa2xM/pppigsmri/iqq3vpfa9oHaeejgQnKt9u2
 /KR40kh9zyCS5EslRcFdC0oj/yg75OshpHSmbUZ50/uX40Dv8DIa7JXHf7RbtroNPnl2
 llhg==
X-Gm-Message-State: AOJu0YwB5Dwn6a2bcgYctNjMgc5TOf/o/JfMvVdQ8fwjR0TIBfTFGksF
 wgKpR2vEg0pRXVsDQ86WsBl7m48O+/38lRDNqiH+QO4jUMHiXcg6aeA9XiwriO4bKFFxr9xNf0H
 Y
X-Google-Smtp-Source: AGHT+IGrYJV5jp1+2Ki1lBXgTtC84cxUTZmb6qr7mH7kxEnioyyFQwFQ8oiw3I8A8hjp7Qb40/RcMQ==
X-Received: by 2002:a17:90a:8c13:b0:298:b523:1c7f with SMTP id
 a19-20020a17090a8c1300b00298b5231c7fmr797175pjo.40.1707978050262; 
 Wed, 14 Feb 2024 22:20:50 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 20/36] linux-user: Do early mmap placement only for
 reserved_va
Date: Wed, 14 Feb 2024 20:20:02 -1000
Message-Id: <20240215062018.795056-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

For reserved_va, place all non-fixed maps then proceed
as for MAP_FIXED.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-21-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index cc983bedbd..1bbfeb25b1 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -540,17 +540,19 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     host_offset = offset & -host_page_size;
 
     /*
-     * If the user is asking for the kernel to find a location, do that
-     * before we truncate the length for mapping files below.
+     * For reserved_va, we are in full control of the allocation.
+     * Find a suitable hole and convert to MAP_FIXED.
      */
-    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+    if (reserved_va && !(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         host_len = len + offset - host_offset;
-        host_len = ROUND_UP(host_len, host_page_size);
-        start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
+        start = mmap_find_vma(real_start, host_len,
+                              MAX(host_page_size, TARGET_PAGE_SIZE));
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             return -1;
         }
+        start += offset - host_offset;
+        flags |= MAP_FIXED;
     }
 
     /*
-- 
2.34.1


