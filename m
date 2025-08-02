Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F18C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLTW-0005LK-BQ; Sat, 02 Aug 2025 19:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLT2-0003zs-6T
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:44 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLT0-0002fD-Eu
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:43 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6199e7dea23so312433eaf.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176601; x=1754781401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSMexr9apaJrbmSV1XOD/8MxlgL1dJOMi/qxEPNLCeE=;
 b=JdM+UQIt7EdC/SB9/+NK/2YISHnRZExflHGXREjvNYL6b7vBRIF10HUGjsHSAJke8o
 R7+cskOLOWS28rXoQeTZiSbL4BPPESmRxy6vQ+Q8D7pZa/7oGiKP4B9LUUVQa9CJv8Fx
 JZvRZOgo7FHlnubqHWXI6zycMy2LmEAfSGRo6AgtWb6wyjJ24y7h74gfdAAz6KY8HM6y
 uQ9nwE061UUSvBlwYuyAAWw0nPhJVZz4F1XZDz3ek011Yov+jsM0SxVYnZ/N8+ms3ebD
 4+ZRjQt3RG/+PImRhR7YL/Qw0hGWcaftNFQrd2y63GYhca80KF4IMgmwb89hNFNOBSSR
 Xcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176601; x=1754781401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HSMexr9apaJrbmSV1XOD/8MxlgL1dJOMi/qxEPNLCeE=;
 b=SVh2Qn+426LIgBoOKEyaoeIFDKS8iH/dbPAIoCyksmdqQ5WFlG97+KdI9Mz/4hOM8d
 ae4a6HrmcAtngQAGrTVa9pnYGXjdbILSlCraOgto2cBGU8NudKpYjGW0xehxfKEmggEe
 Lcr2B8VADDmDXrCcRp01i3mZU0QX4f2g62a//8xH37T96+79S8jiU847lsZ+1STrfAIf
 B941USFKUPL/0RTmkNBfwSGs5ksAv0hjF31WUUebZIrPA3JZkKGZsJi9aWaZ3naoX82D
 FR1p27kWP7S6YpZzllwrAJQfmsMuQobfkM2rKwnq0dpDT2/hzAmPcuKLztXoHHKz3zfk
 d6fw==
X-Gm-Message-State: AOJu0YysaRgETJI82fyUFbaZZtAMTL66aYoVVIbXydu+6ikHCjtg4NMc
 eTFY2wCqJADeWSX11WOatk0Z7HttuMoEm7yNYMCX1sP2GfSVN5qafIrZNpm6T+VLQkD2F8WsGve
 c5xOwrPk=
X-Gm-Gg: ASbGncsok+Gyo3HtBFmN1TmpBeX2x7wk2ol2bxpyjVzY8RMbZ4KUcz8EJk/26d5qXZ9
 AzkHBIm7wQS1gIJ14oqQehTasvP148y6nPdKohJpwIhRcmAiEueUBMCyQMYdV2nJUghmGcSiH0c
 3AaLdi6JHOVJc9rRq5Y9G+2ys9hJHSFenvWuAH7wJ81d3q8iWh3fYbQexF/T9Y0SAKd7BsxGu9o
 rLFD/SCxSWUCqLSzbtXPxpJDanqhDkzfNO95bfAxlAiLQlD3YKUzZplWefPDiqED3uHdKo2jC1T
 1avqY72Os+jG4ySO76YRpi9pWnAJjzppa8qByXBmnAKOXcESN5weRQz5mZ9Q4MtbRUUF0z95RnG
 v8i62Pz7/IlvC1LC+J19Np5lT5sU9cBE78L0LZJoxqm6aTT9aqWZ8
X-Google-Smtp-Source: AGHT+IHGf1s2QynMJgt+a8LDBwQ38jEAnBQNx8OM3ylort+fu+ivwCmA/DVE3TLQtQKikQnnRa0+sw==
X-Received: by 2002:a05:6820:1e10:b0:619:a6c0:b4b with SMTP id
 006d021491bc7-619a6c013f8mr293299eaf.5.1754176601216; 
 Sat, 02 Aug 2025 16:16:41 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 90/95] linux-user: Remove a.out declarations from elfload.c
Date: Sun,  3 Aug 2025 09:04:54 +1000
Message-ID: <20250802230459.412251-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

These should have been removed with the rest of the stub a.out
support in b9329d4b5321, though they were not in use even then.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 422414ad1d..4931b4a9b5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -178,25 +178,6 @@ bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
 
 #include "elf.h"
 
-struct exec
-{
-    unsigned int a_info;   /* Use macros N_MAGIC, etc for access */
-    unsigned int a_text;   /* length of text, in bytes */
-    unsigned int a_data;   /* length of data, in bytes */
-    unsigned int a_bss;    /* length of uninitialized data area, in bytes */
-    unsigned int a_syms;   /* length of symbol table data in file, in bytes */
-    unsigned int a_entry;  /* start address */
-    unsigned int a_trsize; /* length of relocation info for text, in bytes */
-    unsigned int a_drsize; /* length of relocation info for data, in bytes */
-};
-
-
-#define N_MAGIC(exec) ((exec).a_info & 0xffff)
-#define OMAGIC 0407
-#define NMAGIC 0410
-#define ZMAGIC 0413
-#define QMAGIC 0314
-
 #define DLINFO_ITEMS 16
 
 static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
-- 
2.43.0


