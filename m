Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B7BC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugulV-0007c7-55; Tue, 29 Jul 2025 20:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMZ-0006qw-D4
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:08 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMX-00058T-DK
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:06 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-31329098ae8so384027a91.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753834084; x=1754438884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dXnqA+NzaQFwXgBV+sYKikVPl172tw4EYkes2gL+wwk=;
 b=Urt+xYNZY11xUEQ2pB40GokdveGWCSVzDB88yZ5jW3Qkl/9MOVTqu1ZjATAkcNyyqG
 zGjdC1al/Am/RUSn35CyJGdNvUhhFCU4dv7KGEQdWEkkIIp8OUxPUP6kqr/hNXkWKtZX
 t5uc1ncC0MwMRBN1dYx3ZfAU9r/GTRixZLjygjRGJInw1chgBsadjZeeO/ZhforzYzwy
 1pXbhcGt9QIzPki96Vj1lzK3TqssKmEcCBzexr34Xmt5J9Q1kL9hOCihx2YqA3P08LfQ
 sgcrMNRmNzlfdU7vAIKtW7v6jeFfYBd/WVV8bfmNHnZ6ivhoTnzqYSuPOYLx/sajBZRH
 GMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753834084; x=1754438884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dXnqA+NzaQFwXgBV+sYKikVPl172tw4EYkes2gL+wwk=;
 b=bT/Mose2uzRLb9KLglnQxNwcFzkqD30QthMBVkZQ8hTBDQQbmmcPf04Xehlmu+G1Sn
 q7AnopM3F22A//JL+uhSOsfEtulnC7qmEn1Ib6pAY0BHkn9dUBxAY2ah776u1/Eh3vgx
 fp4JXp91pNG1zOKQmKdyS+9r0MiiddoGm+Lj/0i+/p3eU50LB/Os3mPHJ+Zs9IbCZiHU
 0gXM9WRE1ts/nj0jDD4AVyYPww3sFnN4uMimMG4ROuR30yl+qE5vGwm8BHADDbnyEK9u
 D+tFElgwg8Sr+WkbkL2Ip0DFJi1F7UKyCl1nyfVXOkZdW97Y8Ne5pUOutuGGtoOJwbov
 EWRQ==
X-Gm-Message-State: AOJu0YxpgwIuZhfcaR7Eg5xNNNOys6yif1HbIGDA3iatWoWn1QjT+QcT
 q+zy5RXFdWqwI+osRZSCC6ozK69oIn0jud39d0BlORj7TTo0LbzKP2pXSeeXB4IAaHOSe0sjqjs
 6zoQA
X-Gm-Gg: ASbGncuzRCW7rzNxE1noJpBBCiakpQ3YcPBBlvSz94iszIJVFEE8JGOortT2v+V09RX
 plH83LrkGGgYVGONkCUP/VCO4D4gUQjufvCocloeI4Q+sa5mWndpq706vZSSvqj61ERryI7TnZi
 1Yv+MjhrOWzSPo0P3++2MRyeWz9Pnl7A3opDTQ5RixlJGcELwt3nFtfa2LiXH3vSjsFO8wMjCB1
 flav5Dl9foogfcQxJ2R9WJb28od1x62u9CeNDarkIB0CjezWhJpB2EcGbvIOT96cpjAX3uWC3H2
 0nsktidJUJkcAhANPaOD1ARsXvHrdJgBiCziDlTWvIbMecLQ3hP+9Mc9qZe6JgdHyKNf88nO1Bo
 TDkxgNUjMKHQ7nmW8vXpz6B/qJnv3R698ptr//U3MgUePJpLy6WQfPDoAMjFaWKlGoLjPPaYbiA
 ffnT+kglMXSQ==
X-Google-Smtp-Source: AGHT+IFW4iEYu/r0V2YpsKLjyRDcgAE3jaFXnt1iff1bOp/xt5KevOCzT8dAVAlTjsvEgLE6OwYHvg==
X-Received: by 2002:a17:90b:4b0b:b0:31e:f30f:6d3b with SMTP id
 98e67ed59e1d1-31f28c7a951mr7080830a91.2.1753834083730; 
 Tue, 29 Jul 2025 17:08:03 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ddfb2asm281868a91.22.2025.07.29.17.08.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:08:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 84/89] linux-user: Remove a.out declarations from elfload.c
Date: Tue, 29 Jul 2025 13:59:57 -1000
Message-ID: <20250730000003.599084-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 54ea9221d9..e8d5b56cfb 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -196,25 +196,6 @@ bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
 
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


