Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71D5C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV6n-0002I0-13; Thu, 15 Feb 2024 01:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6j-0002FT-Jt
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:29 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6h-0005Kv-VT
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:29 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d9b2400910so4240035ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978027; x=1708582827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bhq/S13VfihOVnnYi8cdcfrHcq4G1EwJdAWP437jNUw=;
 b=PoZHd75WBc6LC2ahvP1zKctqUDqlM0VsZrH1A84+kemCZRB1g8khlO934k9XwgkzjK
 nOmeKsZm+NNxKsodDpKTbHjCaZbzgC0HZWlNwuL92/tPIHrSNIzkKufJ81CxPWHxRQZ7
 eWZR12OfdrF5PK5NvcnYfwXv1WLw60Q0k7+JzsNoYRyGv3Y7Tf0QzRPA3IyeFLSzOEUB
 2ZEVQFLJ8c0L1Jy/wolIK0VsJeCbtakOzGshEZgtycTDcckzZbZfWutTu9IH/cubGIw0
 mI/Okzz2Sm7uOZNSM7afHYLHIbnE3HCt3CKzqlAz/asaTOwO68WgwfVbapRsOqPqx9TH
 2eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978027; x=1708582827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bhq/S13VfihOVnnYi8cdcfrHcq4G1EwJdAWP437jNUw=;
 b=fIH1ths7PoO4pAt3puGuSPGJrKqIcfCMP4F6Yw3FIrVztewwBqPkbCG93E2nAi/nK9
 r//+zPf+HsTjduWiLGU+DKU653/MNXmsWeia+FJ+feSdpX9KJQeS2Q8t7RHMGo2VQtSq
 iWVtkqXm6cW/ReDJeTKxFUkbUV1Oq4rFyWWZutkjBMKq9eHvJLJN5OXWjK5vVDUTJmCY
 vvSRcxWWoPfTO1mTl20B9+2ZKFbaG3DHq2OBka/pkODI4ZjCSwi6UomumFCoa6rZLclo
 lDVUV85A0ikEtGqD4b019jgSHPqIupqKOo0p2y5IjHAHRMXOvaGYcQBkUc5FQZUb7lDe
 UQNA==
X-Gm-Message-State: AOJu0Yym2N8XVAPRMR4EWxyHK0lrrSYWAZn0nBgl72Bi4oItT7ihwSv1
 vsb9W6wjaUXXPGVNOiLp2l/iPssQEU5kb2x/ziBqVFKv0Iy1DEXgxeqxyTJo0X7SyTd8nts6vQG
 X
X-Google-Smtp-Source: AGHT+IG4OP7mLyna24I5e8M75C9kuI7rLRM+dOa/w42lqDzRMcJSp+DYydicdPpXTHNdtGEKxqjX1w==
X-Received: by 2002:a17:902:d549:b0:1da:2b5e:6728 with SMTP id
 z9-20020a170902d54900b001da2b5e6728mr1600826plf.21.1707978026750; 
 Wed, 14 Feb 2024 22:20:26 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 04/36] linux-user: Remove qemu_host_page_size from
 create_elf_tables
Date: Wed, 14 Feb 2024 20:19:46 -1000
Message-Id: <20240215062018.795056-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

AT_PAGESZ is supposed to advertise the guest page size.
The random adjustment made here using qemu_host_page_size
does not match anything else within linux-user.

The idea here is good, but should be done more systemically
via adjustment to TARGET_PAGE_SIZE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-5-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e84a201448..dfb152bfcb 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2679,13 +2679,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
     NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
     NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
-    if ((info->alignment & ~qemu_host_page_mask) != 0) {
-        /* Target doesn't support host page size alignment */
-        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
-    } else {
-        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(MAX(TARGET_PAGE_SIZE,
-                                               qemu_host_page_size)));
-    }
+    NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
     NEW_AUX_ENT(AT_BASE, (abi_ulong)(interp_info ? interp_info->load_addr : 0));
     NEW_AUX_ENT(AT_FLAGS, (abi_ulong)0);
     NEW_AUX_ENT(AT_ENTRY, info->entry);
-- 
2.34.1


