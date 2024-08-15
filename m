Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D78C52D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 21:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sei5M-00079Y-2B; Thu, 15 Aug 2024 17:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sei5K-00077e-C9
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 17:32:42 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sei5I-0002N9-Nb
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 17:32:42 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7c3d9a5e050so997247a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723757559; x=1724362359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LhIEls3+aao5NH/WyIPh/wrRQxUecE2kgRFP7AbP+eo=;
 b=MMF1P3mfslwF8BZcTqD6vtiABBhr/RXWMJ1iiF6/uYXFhYOItUVNbiYtPjGTI0611U
 EaVK2TSK35x0UAUUuaptoDD6tsr/WfhlVb4IH8hy7pCXS9LyGvqNtASK+4vqQGrEl/aK
 ENwb742kivX9KXyjsS+lbc38U8mLcAbayvCV2iAxYfl6N+V13nk98JkB9aEiQH6C7tbz
 2GI/9shzwO49QLtntGzwzu39qimy9H+Jo5JiI8ovAg2m6eyqZl44ia3AvlsIGywUpTQk
 ODavMtxmb5naR8rfs0kN7BPr7LSchfbkNM+37zCyJRs2YBkJUbLGSoE1oLT72tuJEDYh
 tESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723757559; x=1724362359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LhIEls3+aao5NH/WyIPh/wrRQxUecE2kgRFP7AbP+eo=;
 b=ABiLH1E30amaBzxHitEb/FqI9o980ucnONBEMR/D8RTfX4ieHzVwAwgt/Zl4Gk481/
 VIC2ohtXHRhlKhK0beG63MM0zFEIO2eNrdJohrrDMkjH7WPSU6TId29nIU1BEisiINgr
 DuFDol3o26p7TQc8Y+KSmG9jOfxfUIPDy/mGy+FEYnEa83KDyDQW5IfHs54bbXu/OYpT
 20gppovGdPj+4dMI69yaAnJ+1WjMCz+cmsuGplkBJCSoLb/jccJOFnj5X75hb3XM9iqy
 HUbEtKl6UlO5SYO0gstqwH+9Tv0gDK/ux+4LZSmC4mpwJYird2zgwZvs8j59zOFu6mvB
 XQmg==
X-Gm-Message-State: AOJu0YxQcMzdeGngYCW6F16olhDGMMDUMIzN+4hApcGKLxxGHdvAv6W9
 LxlXr6ieDsiqVX9CvpjtoApQkyiWcUc2rOJG2F9XEYBnaZBCChbxOAX6TkYg1SMBBjVs2nxke3e
 Sqng=
X-Google-Smtp-Source: AGHT+IF4mI08MsW8UTtDzL20PadbTFhUj++SXMrg10T9n+Ru4x/pULLkzc1JlhxMr2LYm3AD0eVP1g==
X-Received: by 2002:a17:90a:d804:b0:2d3:cc7e:c418 with SMTP id
 98e67ed59e1d1-2d3dffc6b6emr1010946a91.15.1723757558544; 
 Thu, 15 Aug 2024 14:32:38 -0700 (PDT)
Received: from stoup.. ([203.30.4.109]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e3d97f4dsm277648a91.54.2024.08.15.14.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 14:32:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn,
	qemu-stable@nongnu.org
Subject: [PATCH for-9.1] linux-user: Handle short reads in mmap_h_gt_g
Date: Fri, 16 Aug 2024 07:32:31 +1000
Message-ID: <20240815213231.303424-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

In particular, if an image has a large bss, we can hit
EOF before reading all host_len bytes of the mapping.

Cc: qemu-stable@nongnu.org
Fixes: eb5027ac618 ("linux-user: Split out mmap_h_gt_g")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2504
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 6418e811f6..de9ab13754 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -853,10 +853,21 @@ static abi_long mmap_h_gt_g(abi_ulong start, abi_ulong len,
     }
 
     if (misaligned_offset) {
-        /* TODO: The read could be short. */
-        if (pread(fd, p, host_len, offset + real_start - start) != host_len) {
-            do_munmap(p, host_len);
-            return -1;
+        size_t o = 0;
+        while (1) {
+            ssize_t r = pread(fd, p + o, host_len - o,
+                              o + offset + real_start - start);
+            if (likely(r == host_len - o) || r == 0) {
+                /* Complete or EOF */
+                break;
+            }
+            if (unlikely(r == -1)) {
+                /* Error */
+                do_munmap(p, host_len);
+                return -1;
+            }
+            /* Short read -- iterate */
+            o += r;
         }
         if (!(host_prot & PROT_WRITE)) {
             mprotect(p, host_len, host_prot);
-- 
2.43.0


