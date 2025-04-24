Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4119AC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7knj-00065q-6h; Wed, 23 Apr 2025 20:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmy-0005TN-LI
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:04 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmt-0004N6-J6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:01 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso329273b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455798; x=1746060598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oR/Buc0tAK+dwpT4/jUuGVtANFEG+DcYq0rCH3hrxCg=;
 b=soCXyifFB+c+muVUxgWTp/MzChF5JEh2+cItVgci4Zb7cj9QaqQrFE7oZrG6fqTWDe
 mQmG2WddzAGjU6KUmgrAkH3ZwixmIZi16p9GBCs4c7LJbzarJM1xb6ZSYPC1BXWCCW4O
 3UQh43cMPGYatSZKPxmVY8ZI9aB1cp1S1zpifkQmGVnGjwI9Wxhw+RlAJKb1i3eISZps
 x1mjl5SD+0dP1IQqHrLETTb8150dmhKORbDgt8IlXnVz+gQXFp9oBeSoULPqpZ69wMow
 73SAwbP+9A5NOUDnD9bQbcH4ojyCvMS2ed8MKWT8Y/uJ4S9YHxY+USWod7gnXHG610tL
 OU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455798; x=1746060598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oR/Buc0tAK+dwpT4/jUuGVtANFEG+DcYq0rCH3hrxCg=;
 b=HuSQFDDoxmMj8kUvpt9sM3+V+SlLR0PYzxKIZeCE3yikhgSZps5/VRFp9Zlk0N8hHe
 6zbQm4mr9j+8uZbUCwP8ivIP3bWIlBsPqmKucqb8/z3fg7Zuxe3NolMyirLY1KFct2YU
 9WDXbBD2Ps0pxXVqsdHCkiLUPgIy654uJ325588P9mk6MGfPN9QbvB9LMHB0NiIdoRPu
 7eO5i7ajaBaYUcWJn0h4K8kIyWG6WLUvEHTmQMVa/dP6VJvNW6pdYZvhqTpbeHgZff5s
 yl7qSa/ZHGIrPHnDsxTab7tKswAFupIKPhU120lbEseIaCjd7yEdVcgGyKSv4wKZIQZx
 dkVg==
X-Gm-Message-State: AOJu0YwptVBc56HPTWKm/qGqIZES0TfaQ+u/jPlk9VhCdGHoHuXrAo9a
 /oyUplGgoNTJnM5MePQsNUCZLFNNQDlPWfroI6ND5siHFcikVOeldQY0u2vpjNaT/r3z/KZ2668
 w
X-Gm-Gg: ASbGncvhbVyOGAJHDrhio0mBYUnyaBuhOn41EMxHBnkReURd+3PopBAZ6x+lWlpwDvv
 ghKEFUenh0gDDdFyXD0jjTfJ5IyWS/vG223TGMJTUDOl6ZRbIlOv1eF2csG3ou1thtUYxPRzstz
 pDzbhSDX8ufA5MIoSmdVP4RU8sdOTeQA39tIIxyOpmZEFgkfo6PebZwaUh/jtRY0b8zcN3a83MS
 yZ2kKSeuDnkQrCyRdgF3BP8VX0g9OBPQcAM3Ilm5z0CsY55qZmbKCihUh7OyCg3z8Kpqx6dITLn
 NvNMtS8S282MYsBDI7Q28lSgNb+OiOAozgaoo9VjAF3MyRgA0H++DW0rM6tACQij11tgj4G0AcM
 =
X-Google-Smtp-Source: AGHT+IEGLTRWalqVdVSEecsOzM1MvvjY3IXihYufL2Ni6/tkNZO3Ztu3fFf4+RxY7lszpFth5Y4aPg==
X-Received: by 2002:a05:6a21:3284:b0:201:8a13:f224 with SMTP id
 adf61e73a8af0-20444ebef3amr857163637.22.1745455797428; 
 Wed, 23 Apr 2025 17:49:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 029/148] accel/tcg: Perform aligned atomic reads in
 translator_ld
Date: Wed, 23 Apr 2025 17:47:34 -0700
Message-ID: <20250424004934.598783-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Perform aligned atomic reads in translator_ld, if possible.
According to

https://lore.kernel.org/qemu-devel/20240607101403.1109-1-jim.shu@sifive.com/

this is required for RISC-V Ziccif.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index ef1538b4fc..157be33bf6 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -265,12 +265,14 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
 
     if (likely(((base ^ last) & TARGET_PAGE_MASK) == 0)) {
         /* Entire read is from the first page. */
-        memcpy(dest, host + (pc - base), len);
-        return true;
+        goto do_read;
     }
 
     if (unlikely(((base ^ pc) & TARGET_PAGE_MASK) == 0)) {
-        /* Read begins on the first page and extends to the second. */
+        /*
+         * Read begins on the first page and extends to the second.
+         * The unaligned read is never atomic.
+         */
         size_t len0 = -(pc | TARGET_PAGE_MASK);
         memcpy(dest, host + (pc - base), len0);
         pc += len0;
@@ -329,7 +331,39 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
         host = db->host_addr[1];
     }
 
-    memcpy(dest, host + (pc - base), len);
+ do_read:
+    /*
+     * Assume aligned reads should be atomic, if possible.
+     * We're not in a position to jump out with EXCP_ATOMIC.
+     */
+    host += pc - base;
+    switch (len) {
+    case 2:
+        if (QEMU_IS_ALIGNED(pc, 2)) {
+            uint16_t t = qatomic_read((uint16_t *)host);
+            stw_he_p(dest, t);
+            return true;
+        }
+        break;
+    case 4:
+        if (QEMU_IS_ALIGNED(pc, 4)) {
+            uint32_t t = qatomic_read((uint32_t *)host);
+            stl_he_p(dest, t);
+            return true;
+        }
+        break;
+#ifdef CONFIG_ATOMIC64
+    case 8:
+        if (QEMU_IS_ALIGNED(pc, 8)) {
+            uint64_t t = qatomic_read__nocheck((uint64_t *)host);
+            stq_he_p(dest, t);
+            return true;
+        }
+        break;
+#endif
+    }
+    /* Unaligned or partial read from the second page is not atomic. */
+    memcpy(dest, host, len);
     return true;
 }
 
-- 
2.43.0


