Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45027CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNnS-0002Ug-GI; Sat, 30 Aug 2025 11:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fh-00063D-G1
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:13 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7ff-0004pF-K8
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:13 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7722d6cc437so1104233b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506850; x=1757111650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mz6bnQ9hxSSK9MxglRgob/YBCdo1CFs/IVNS4H+kiuE=;
 b=OvHKxGx962cfI9kU/3nt0ifAn7WQVVPfRQx1AcIwtI6pjemKbNR2aSFVnbPG+7efXN
 JXG09kqfO+197lgBmWVe/diK5xzq3xxGUjjK+Dn7j6Ob7fvCegkRJipLZ1QvuzkXgVaN
 k5MkX1Mp/2HlPi0jyoPOurmBx3Hep62ky6NWQ/EViVu/e/gEBsWrieXag2Zis/vxiBKO
 xdA69Ani3ARys3snztfkGUYhRI6H9zFhKjiF/xHbXtvIy9N1rU1ksOkDtIH7moXYyIlP
 jw/JBVmSRnuLF+6gx3b1kA+M8Wrzu7YiIVaksxkdULFHf7GKnMbsTFK3nZZBYpLZsEqG
 ajAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506850; x=1757111650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mz6bnQ9hxSSK9MxglRgob/YBCdo1CFs/IVNS4H+kiuE=;
 b=El3xV0091S2CI1k11RT1wLdV+Pxv/OgANA7fPe0c+rzr3/hQ1KHVTQ9mL78nGDFHPy
 5S8Xb+5JzU60D4h8dITY9zIO1y05UCWROEw5b76Qb0qoQ3f+/RIsSG58e1suSediJaPY
 wmf/94+lp8affuKmNiOkiWpLoATKSn7bWi/AmlBD5T8ZAVHtXy3y2wSnhe/GAhS7UFxQ
 XSWAdDny21xBYvqWe9h+/0V+fNqqXD4EYSEO93+Khkgp1GZZozSkxfL4SnaHaariArxT
 rAeQYOz8RB+xIbdtsy3E7torw8QD2zfcuk71sYrjoeeQWXfG5doqrB0QvQeAFf5jMgr3
 E61w==
X-Gm-Message-State: AOJu0Yzg7dIJ5asNvftN2gcvneAYnqvv2z/5XgxJZHx1iqS/nJ+OYf4g
 oi9c0cVxAAA64aIE2Ick4i8zY///BrfC4Y9hScL1ldGBhS74CWURH2jX1d74z62Uz2ava8+2LKg
 vD+Q7cys=
X-Gm-Gg: ASbGncs0c2pPOWLliypcoEq7BF92kZt5QIq5xJPRmJtmLkxvNaqQPsS45/TpEZr/InV
 QaWu1tesyVXaK005bKqD4ggrdkRHe2f0CV3P6iCedyj4kPRTsnaFqt7n3hQakIA9cSwJ1CjZSFt
 Mts/FU2w0eooMItlL2pkhIfweI3aAz36zUrkpsqRXYf3YVle16unDpGU7b7MD2Ya3jyaLLkPAtF
 QfK5lWUowPppHMWrQARWy8W16/OpPX05sxTfneyTV7Dl9WXU1f2UzXqbGt0D9kolOJYA08rhVqo
 Z2x2GfPIMifX5gZPd+pOoTHPrgXpJFpPlxZXtdTEHXKIHgr///TfuKNtogDGL7KQ3JWwgGeKsvx
 6qUVL135m0+tbeQ+Nh97Oif6pkp9/yS/hVgNpiKYO3xcNgKS45ly5oUAyUe6JwPrQGuaH6sE=
X-Google-Smtp-Source: AGHT+IFyTby7rDMCWFrZ4CTvBphHkAfAL9urxPF+TjYZQzecC8KWGyV16+vbC1BAY9ngBtP7NweZHQ==
X-Received: by 2002:a05:6a00:4709:b0:76e:277c:32f7 with SMTP id
 d2e1a72fcca58-7723c504870mr649732b3a.9.1756506850167; 
 Fri, 29 Aug 2025 15:34:10 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a269f27sm3449728b3a.12.2025.08.29.15.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:34:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 89/91] linux-user: Remove a.out declarations from elfload.c
Date: Sat, 30 Aug 2025 08:24:25 +1000
Message-ID: <20250829222427.289668-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
index 12d4873212..26c090c95d 100644
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


