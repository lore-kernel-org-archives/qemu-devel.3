Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53929C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFux-00070K-G6; Thu, 22 Feb 2024 15:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFuu-0006zU-4m
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:40 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFus-0002cL-J6
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:39 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5dc20645871so143271a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634617; x=1709239417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bhq/S13VfihOVnnYi8cdcfrHcq4G1EwJdAWP437jNUw=;
 b=aPLPVX+N+7Whu647T+22YnYcLbBdXxwug5fBZiGehhqN5DuNOjRK+MyvykEdy2PV9Y
 dYWiv1JhnRSnSC/OWfYL/uyDDaIDfVJ9psY32YAr+amyXyOk82qORTgOD3LI6l6s8pDa
 p9cCI1MY/3J3zQ9KRdI0upMjbIr2uX7gIYfCj8FduObfqxXZxi6dWsa58cvtVnj5pKRT
 KetRwCj0MmVfTywSc0fI/QbzPI/k4nYqAYLAa9GbV48ZAUfRBxINgXvhwTofaTxXlZeq
 e74Deu8r2mtweCyEtZ99IhjAjjUAs8ic6cEcHMKCzAOU+UcOr0QmOU5NYiHOSn47mQfz
 i7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634617; x=1709239417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bhq/S13VfihOVnnYi8cdcfrHcq4G1EwJdAWP437jNUw=;
 b=PKH7l34bl7+siozkVQy2vJkDXoXc2GJ3uG1L40jN58VzFo6JwepYOnSwhdLreO0tSA
 qN7ieEUcIjKNNJ8A96jxxFWvcdEx/RgqTfhmZVG6DetZDWmi58pQL8lQCg5R3hdnBz+y
 BxW2UaJgduWgmoiDUaqi3/3a96TUnmCJPuNxGzqIuIcWWg49L1kCidjqP28XAuM+C86N
 annuS8WecZqj8YqPLLO76Pv2haW47NO5ACKM91bC61ExRW0w9C1PBpBtVE5JdqegDZ2x
 htkml6o+vYgeaeFRHC52Z900fbduIcrtXgTq6DLx7i6vj/4F4LWj+7qN7w/zBdUUkitQ
 r2OA==
X-Gm-Message-State: AOJu0Yxqh6W6aLK6ORe18+32v01TBrBIeKTzzmVUH5QYS6/a0oGf7/Op
 zHUvFlzt2rwWl9lzBLIGqbU3H/kZxyWi51debBlBwvyA0jajLPvJsMMpEkMqqkN6VATAf5ogqvj
 B
X-Google-Smtp-Source: AGHT+IEjNSpaWRAUWmDhTwQS+MrN9qDrAUGuGYUCtX+eV8vSgKmG1IFuf1p4BYJbRNu7AJuYQVjxCQ==
X-Received: by 2002:a17:903:1cd:b0:1db:beac:61af with SMTP id
 e13-20020a17090301cd00b001dbbeac61afmr270755plh.0.1708634617006; 
 Thu, 22 Feb 2024 12:43:37 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 07/39] linux-user: Remove qemu_host_page_size from
 create_elf_tables
Date: Thu, 22 Feb 2024 10:42:51 -1000
Message-Id: <20240222204323.268539-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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


