Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF538CF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pc-0007BF-FJ; Sun, 13 Oct 2024 18:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pV-00079L-0u
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:50 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pT-0000ul-8D
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:48 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e2e050b1c3so2089454a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857566; x=1729462366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9DVukvxY0Nz2lbOkkF1UGxIJ0HiyrlwFe+DiEN47Z4=;
 b=iH5rXdJdPcYE0sn47jHeQjTuRFOOkDgVYZksCmJyz/8TpMj7e2+LPU6sYKJSscyUWl
 dK3+tg4coulBYnAHJRzGdmXcJFqne5ngK9EaaPTRopNSD9lixYlLSVtwRXFukGLLLdEv
 GnSXbwWIX+kiCKd8fuRegVC5aTNOw9uQ70ujrFA81r0WidjEQGFoLnI5/7BzKOuPj1tt
 IrstylEzK9LbVoLTeHgWftXM+XbLvYc5LhTxo6HOFux/nGmjpHPCRiIkSGQtpzfSRkjQ
 WC7rkkpv/OsZ2FyLwJP2CQA+ikM8cpWYmxDIrPKXEB8IT41QQ0s3XWSsHMDQWv4fYFF3
 aH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857566; x=1729462366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9DVukvxY0Nz2lbOkkF1UGxIJ0HiyrlwFe+DiEN47Z4=;
 b=lHxL2V/0+UoSQEL7MFjU6VSlq+/HVt1aUMrhfVeYglWnzwAgQqyksdmNUVIG0eCiHK
 X4OcxzOEMTwHx2L+fSgxrFFgS17N3ENX7AE/ZSorzpr5xIEM5hqb/rtGzi+J0xIobw33
 G+BjYtkxSar3rKMo4tZrtx7DRk8e5BHBUtav0zzuHX437rQPmPw4idiJHF1662EMf+/s
 5MnkrC92Lwf9LAn0Wrs3Q9YEsB2XBlxHxCamQAOV8ildMyJtKFMop1FYzweG3+Xmd6kp
 HXlnw4spaVaZua78f9bk07jgrH5ogE/7niVL7IwbkYDoTJlYhG3z3Wew/va2JhH4tTxf
 x6Qw==
X-Gm-Message-State: AOJu0YxQGP7lQADbdTC+uUN4mcNPtaFUOZmEpc0GrWEQIJLJ9UuKcTA+
 S5EPLl79fAyuGB2af4/DpQjeQZYkOgrqDI67gGLsEGwXa9/TBaWEvzPLUQl8c/yFNmZiRhWr8yJ
 R
X-Google-Smtp-Source: AGHT+IGuiRjze4lqFtkMzr14k0zGiTnL2C1SICBCRKuMTrZX29aBstFP5CkdurapsUxG1UQfHPpiUw==
X-Received: by 2002:a17:90b:3844:b0:2da:88b3:cff8 with SMTP id
 98e67ed59e1d1-2e2f0aa5610mr14952048a91.6.1728857565706; 
 Sun, 13 Oct 2024 15:12:45 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/27] include/exec/memop: Move get_alignment_bits from tcg.h
Date: Sun, 13 Oct 2024 15:12:17 -0700
Message-ID: <20241013221235.1585193-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

This function is specific to MemOp, not TCG in general.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h | 23 +++++++++++++++++++++++
 include/tcg/tcg.h    | 23 -----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index f881fe7af4..97720a8ee7 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -170,4 +170,27 @@ static inline bool memop_big_endian(MemOp op)
     return (op & MO_BSWAP) == MO_BE;
 }
 
+/**
+ * get_alignment_bits
+ * @memop: MemOp value
+ *
+ * Extract the alignment size from the memop.
+ */
+static inline unsigned get_alignment_bits(MemOp memop)
+{
+    unsigned a = memop & MO_AMASK;
+
+    if (a == MO_UNALN) {
+        /* No alignment required.  */
+        a = 0;
+    } else if (a == MO_ALIGN) {
+        /* A natural alignment requirement.  */
+        a = memop & MO_SIZE;
+    } else {
+        /* A specific alignment requirement.  */
+        a = a >> MO_ASHIFT;
+    }
+    return a;
+}
+
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 21d5884741..824fb3560d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -281,29 +281,6 @@ static inline int tcg_type_size(TCGType t)
     return 4 << i;
 }
 
-/**
- * get_alignment_bits
- * @memop: MemOp value
- *
- * Extract the alignment size from the memop.
- */
-static inline unsigned get_alignment_bits(MemOp memop)
-{
-    unsigned a = memop & MO_AMASK;
-
-    if (a == MO_UNALN) {
-        /* No alignment required.  */
-        a = 0;
-    } else if (a == MO_ALIGN) {
-        /* A natural alignment requirement.  */
-        a = memop & MO_SIZE;
-    } else {
-        /* A specific alignment requirement.  */
-        a = a >> MO_ASHIFT;
-    }
-    return a;
-}
-
 typedef tcg_target_ulong TCGArg;
 
 /* Define type and accessor macros for TCG variables.
-- 
2.43.0


