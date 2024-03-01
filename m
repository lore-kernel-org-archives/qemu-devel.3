Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8DFC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByT-00063y-9r; Fri, 01 Mar 2024 18:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy4-000584-9a
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:04 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy2-0004J7-Cv
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:03 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dcafff3c50so23002275ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334420; x=1709939220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqsG1I779d9YjbXcffYW5wImE5mXquA1bGyFgIG+R5A=;
 b=ikvwTk5y0KRuD4wIwHa1ztsD8rcdsNzvoErFQECKfbaIbr2ev/oFgMfIcK/KKJjDck
 QmiH/Ke085/ObIJPytUowPI6vZgGPTARI0wGY7jyBgFwZq234ttCq9RvFdc4bYdxHKDg
 Ne8UtE3DjIq0wrVPaE8FjyIWhm288yoiEAUDk8BRgwhNDx2BDqSJ4+MiWLRMAOpX6ndk
 o1ObqvwDRpnZmVk9gGYC2/DvY0p2Ca242qx6oWatVs5LSsrRJ2Drg2wkihuU9fDuS/0j
 ceB72HFqHUMH53zlRHZuHsmegK/S3UcvYhyVZSRM0d/khyM/rZHp2RUG6EXyVcsuGD0x
 7T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334420; x=1709939220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqsG1I779d9YjbXcffYW5wImE5mXquA1bGyFgIG+R5A=;
 b=oJZXM+IqFcEAtSdKLYMJbP+jUktGjFyZdXXuXPxTzbrvGbPvIe51pooN4IXWOMof1q
 MGXQywUhbwHJEC5dmkoMqba8RDQlCIJbqBjxFojrLUZb2IT77EcalRGDnwDYqZqR1Vmq
 2iLoYvf6LIay0qvy4UxsgchBv0ZuQ+r2o7Q1MNU6j1C88T0eJiU38L7x/eip51YKNShE
 KVDh6sCyizfHSsNtrED8eTijzAKaCJKh5KKd3JgcEBBMAZ+yLfjWoouEanzUipvorBYT
 ms6H+WuX9sm2vNLvtBTpoHaEDa/GZmOmVefZch7qblhyA9buystc59guIN8o/ezDhtnF
 VqJw==
X-Gm-Message-State: AOJu0Yz2H0Ze4qVm1oiUOkfEO1p4zYNxig/NzP03L/p2cm4lZs9Q03Vy
 uMIn+kIvaGUUWzLWkSqeUyY7EAAz9OxOm8ysrJ4C6K7A1zY0jXH2QNa2eWmFZAkgivudFwHUDdv
 c
X-Google-Smtp-Source: AGHT+IFbhdP7dm/ccRLU/pns/cTUwzSrtw7yEQ/oTxmqkuwfR0S58tcFGRZuBhmVxj3Andl2DhQdXw==
X-Received: by 2002:a17:902:6b02:b0:1db:7181:c5ba with SMTP id
 o2-20020a1709026b0200b001db7181c5bamr2773290plk.62.1709334420287; 
 Fri, 01 Mar 2024 15:07:00 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 27/60] linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
Date: Fri,  1 Mar 2024 13:05:46 -1000
Message-Id: <20240301230619.661008-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

We already have qemu_real_host_page_size() in a local variable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-10-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4d3c8717b9..53e5486cc8 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -585,7 +585,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
              * the hosts real pagesize. Additional anonymous maps
              * will be created beyond EOF.
              */
-            len = REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
+            len = ROUND_UP(sb.st_size - offset, host_page_size);
         }
     }
 
-- 
2.34.1


