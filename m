Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6A7C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEF-0006bA-1Q; Thu, 28 Aug 2025 13:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbb3-0007Da-JU
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:18 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbb0-0000rI-UX
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:16 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7720f231174so781779b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383553; x=1756988353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mz6bnQ9hxSSK9MxglRgob/YBCdo1CFs/IVNS4H+kiuE=;
 b=qLd9NS021GpUQ/zWUvS9JxtP+Ut/3RD8WGvhg8HlDW/vUF2MqBz+orBvbIHHqH9BoR
 cFVVR4zGzM/fj+h2pQ9airQl41ED0xyux6EzHfCu5lWMlpmoSh8nYdwRcB4TsBGtZw6b
 Tje0g63dlJq9OBAIExjSOSG/rqTYWggrfiqXL2LLaY+UYNeqUTGdepw4qdQuEGwTxnmD
 yqqBfzwCF7QAt8cg8FOeubuaB9LTKKDv4PxClb0mBPjOsyDdmJ8OBFhYfp5kGYzAXmNZ
 YDWCFx/4riuZ+E1xzTrBYHpz2AxHBbrl1vf8IpPFCdKRGIlvhxkZqKpHcHqCrzq8qVUj
 ab+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383553; x=1756988353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mz6bnQ9hxSSK9MxglRgob/YBCdo1CFs/IVNS4H+kiuE=;
 b=E5ZGqvCMpfXsU9crucEE+jrJekQvWewUww0PuYxNUJtiVionuzfQvQoilYYzlxkecr
 kws+0rH1f5FOXW9eId36Vo+gEY/ygLM1ZN6osOL/0VVx0NMATUAnPf+e7MpeSLOrfYuG
 l58AArTaHhYgO9IWSu1VzcqB3Kw2BQu5fV29s6wZ245rLfl6On+L3m2ItDZaVTmn/k/i
 1dnBLePa5aJB5WrNdYAKA+YwcNI0+N87qt+ZD3ozSPK4wejo5Bkd+q8lgWGZL7j7VXlG
 rAIKvkkn1GsdNBPJQKQy0uqUwAqNOmcmLTeKMiZtN0BvQvUMWxS8cZXuxPjFys6izy4F
 CFmQ==
X-Gm-Message-State: AOJu0YyT4rjMbmbyX6q1CeqjEyj9xJIBfVpAkJieXcxzblD/xJuIhFTX
 nw5/DBKuXEpM0IiFedfyrro6QG2ijm9msK9VM+F/hOetGsYCffpJzN30rj6RvUXDPDPioUK9ORF
 Y2dMobDY=
X-Gm-Gg: ASbGncuZxZrZSm6ljWcF4eftYzooC28T3aRKPND24jBMSmkV47PSX5rtJ67gb0FGlcm
 0+CXFQNcgbuxS2O53F57fQspNxtpJivMaiWv7OOQepJQ3kQlrZY2OX6KChXnGZUhPv2H9fxDWHp
 xJbsTCUCRFvv2davE3Sa58EocSV3sQhrsURW4gMqlyr/EQRxP7UmEcXnbKkHwiahoHRzpnjFOLT
 FlPFhFbpkhMAGHtbUPCyY58iLm+s3Gy3jmZ8C1zAnnRf5pL39VV2ON0C1paCwyuwtetZTgDxTFj
 kVQySQZnWRdSLKEJBv+D6P9leGzjxG37YF+39CBs08+4FZCUhxuD7xFBAVTc0HUwkb7e8jm8261
 czhapmT6qAuLbYSPz4DdZzuZypthUNVOYNE4ifEogxB/71Rg=
X-Google-Smtp-Source: AGHT+IEBqcxH8eukIiTh8LxhzI3gnllu2d6+OxkMf7BE97Re8RcWB/cadrT1/jxB28yNhNyvTrX6wA==
X-Received: by 2002:a17:902:dac5:b0:248:d4d5:8428 with SMTP id
 d9443c01a7336-248d4d58c57mr31584245ad.22.1756383553494; 
 Thu, 28 Aug 2025 05:19:13 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248953dc1f4sm48898735ad.30.2025.08.28.05.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:19:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 85/87] linux-user: Remove a.out declarations from elfload.c
Date: Thu, 28 Aug 2025 22:08:34 +1000
Message-ID: <20250828120836.195358-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


