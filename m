Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEE8E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVl9-0003KH-KK; Wed, 11 Dec 2024 18:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVl2-0003Fu-2M
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:40 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVl0-0002BF-Fx
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:39 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436249df846so70595e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733958277; x=1734563077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5TDVgq/CwukR+NJEtHbkNKroUN70sGumVux+smwBCQ=;
 b=Ub7ilO+7J0750n7OF58vshIkm3AV+78t9nLKtlDukYpRCpPARfq/Wl3LqXEL8h7zQL
 Z+7b57wnVSRjPIj55Zo6aJjCYjDTFoTCmUR2flLDU6NTOd09KmRzPLgc0+D1cSvy0YGC
 lbrz0ihNzV+wYN32slUeDPyoYLmMWSKX7JzTSHG3X56LyEM0c1g3GnxIoywT34Rhj2Cy
 aDgQpNa3PZbLfNuCDNOCsJpCN8br+R6d1NHxgXrGueCzBjLQtQApSgosGOXkY41e45xm
 LnxTedqgzFjlOSnW2GVWlH3rWWJm0eefKNULxpeoqzADWhLUybTrLFtjrrOyoPdJHPcl
 PHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733958277; x=1734563077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5TDVgq/CwukR+NJEtHbkNKroUN70sGumVux+smwBCQ=;
 b=FbqQGGUtt8FTzLXNHETrsXbiERq1QhcwUbD1jocmZt+c/h/u9dS6ILRavQng+ay20Q
 dl3vguOXOxfnltAJZBYfj+Z34RY/ZnKwcld4fdhgsH4rQuSAdj+xUkPseyOmY+suF1n7
 6vrwLjewtJ827x/qCxz5qycADZVGt0B1Tdmuz+PRKtI/y3miQIimBkKSVAHes2k6HojU
 RMlLK0kDiO2VZr6RJO1o/7vlddbgcuH6vnn6nQsCDxOb9BpvmedHQ+sUg4a2kk/5qgX1
 ppGXjSZCCBvbN/iOsMvkWoyncAO1hQRvXKf7wbs/srev3h4HdM7VDmjBHh/1G3VHpp5K
 ZHHw==
X-Gm-Message-State: AOJu0Ywrzjj7kKMiFOAS2BhreV3j08FWzYhrDBN/KBYHPlj2fb7/bcrm
 LCDe/FMx9AGKWVUScmb67xfwW3F5ixGT8Nip9sxOhFlUfBBO2vLtTlPizQBwNGqzy0CaXJtxEdy
 O
X-Gm-Gg: ASbGncuDZtCrYXVSQ1NSoHDmOXV6Xe+u0/UlzBMy1I0eUYOyEIUxS2KuspB/LTnz6GR
 vIWeBNfCDindjYbQcm0fg9eL7ibgSpWuuBwCS9wiculUhbFcyfWOws/17MgvEjg3a8dosLeH4ZX
 98B2WkuuFOaS1wUyckH8R6X5dgGsuYZEmhkaHar5NDEx4OIx4XRLxusKXibvi70I/M6AlTj6Gb1
 +hWxO1gsd2h/JO9QytRlLJmGSY/Bx/J9lCzrOdBb8+V7pNy1WeMtvIYhkQydD54nefusSibOZPn
 9uDQj+bPgImNf/W5F5iTvNZe1Jr0sbfrOQ==
X-Google-Smtp-Source: AGHT+IEhm6oddSIUhSNEWiz9LFRT/gvZfGHNmjndFdBk7CFLy2+kvYb3ZuIpawuLW7nNHrcK5WzsAg==
X-Received: by 2002:a05:600c:1f0d:b0:434:a923:9310 with SMTP id
 5b1f17b1804b1-4361c3c5015mr37873435e9.15.1733958276747; 
 Wed, 11 Dec 2024 15:04:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514c06sm2341763f8f.73.2024.12.11.15.04.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:04:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/9] hw/sh4/r2d: Include missing 'exec/tswap.h' header
Date: Thu, 12 Dec 2024 00:03:55 +0100
Message-ID: <20241211230357.97036-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211230357.97036-1-philmd@linaro.org>
References: <20241211230357.97036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

r2d.c indirectly get "exec/tswap.h" declarations via
"exec/cpu-all.h". Include it directly to be able to
remove the former from the latter, otherwise we get:

  hw/sh4/r2d.c:357:35: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    357 |         boot_params.loader_type = tswap32(1);
        |                                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 7eecd79fcc1..e6cc156c238 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -43,6 +43,7 @@
 #include "hw/loader.h"
 #include "hw/usb.h"
 #include "hw/block/flash.h"
+#include "exec/tswap.h"
 
 #define FLASH_BASE 0x00000000
 #define FLASH_SIZE (16 * MiB)
-- 
2.45.2


