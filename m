Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BE2C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1q-0005DT-O1; Fri, 25 Apr 2025 11:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1F-0002v6-3h
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1D-00041k-CR
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso19520685e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595069; x=1746199869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAwKCszrwhoJ0+d1w9IlzmQBxd3Zr8DxCtpHtOvRE80=;
 b=nzMQ1WRyQIjd0NjOUrgtRpYzPXlK+CDXO5rb6NsofA5zakLPdOZeyyBAm+2uPXD7fd
 hRta9MH9q0EAaDmPrZdxLcHFl0R7k1Sp+/PHDJTocugtmsYhnixdqbqhqP96MS1r7gkU
 18FJA7r0dC5uQBpsuliM6fkBU7UbzDtHb5dBa3e5NFPtjecTI44qUuQ0xZ/07Uq2qbSA
 XrmoOUL1R6JjqNYMMdi3G9Uz6R77eqQMPR1YE3m5dlSEIc9YDUsOQt80RAxXscIEfNac
 tNF71VgWqgCt0weN6ddoKscbralDDU2g5vuLo1xF2GyAX5unTuL6vXnBe2OS5Z6CB9xk
 v3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595069; x=1746199869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAwKCszrwhoJ0+d1w9IlzmQBxd3Zr8DxCtpHtOvRE80=;
 b=Onta9pFU+vvL1wTrZiFvPhZzJ0wWIm5NbWlebH0Qx+xdeNQc3I7eWGKR2M4iHvUjBY
 0g3QqEExmUuQvv2k4IHQh2eH6iq19nMs/ERiUZvSokjTO8+zoU5Gtiwng6eVjYNwtM9Q
 9V7ZrXKxjUsrZTfr5I85pLagXfgzs+pzVzuyDO3mFWnZqH478dFf+Jc3bFLhXrtOJCtj
 rUdjOmMM83CixEhAfrp6rUd2nU29jMOnCB16PdJPS0GwWzkcTKjSnskOL/e01NXAIRkC
 usXT0xv0luftFNkTEXhY88x7/A73GxJ4FPGze5vnhp6+3j1UIQV2w9WSepcrMz+M56wM
 6J2g==
X-Gm-Message-State: AOJu0YwwXFx9CMnKjmjU3FAma0hjyjuV/7S4f/yxQl6pubYepeAJEmls
 7AX64AbeRAl/gwIBUku5BkGPtsMv5v4U88oJSzCsRK5mxbB0VfHr0dPpSNDSevrdRwD/djWjfP1
 H
X-Gm-Gg: ASbGnct02WsErCjXndZ3wuMUnYq82uP8bm3Z7qOfFJhcTaPnLZmVo9G4i+8jdrOQv1l
 g14u+FwY1nhET++RkszwUp121VNlFvp9g54y57ecApm5ao5Srh3Deoo7HqfW5thNdxmOvkFz01N
 D5gY7o6ZKqpJY2vUn6BDQqNIJqE5qyefr93YTnYvjwB5Ob7veMuj0JJfput6NYUwiSPTYysW9Is
 vDj9Ci2ic5MSP9PzUf9ZTZ/thF+qAIn7NPd1snrrYFZckzqCdEZwZKWGNPImw2Flb3UpDblppBy
 e9sfbHhY8twi5kxaPj1PR9Nt1LO/Ur3ksjSPTfpOvLSaoo424wLQWzMrcXwrPCo7Hcu3x1JIpjn
 sX1GplqagHkWvAtg=
X-Google-Smtp-Source: AGHT+IHckEEJ8x5KnwDpfxVPaBuWCR8bWZGdnLYZivPKsLjOthmS4uMTfVFeAw95EreQ/Y6mntzHvg==
X-Received: by 2002:a05:6000:1867:b0:39e:f9e8:d07d with SMTP id
 ffacd0b85a97d-3a074e2ef27mr2578486f8f.20.1745595069394; 
 Fri, 25 Apr 2025 08:31:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca556bsm2686953f8f.37.2025.04.25.08.31.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:31:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 29/58] hw/intc/i8259: Remove unused DEBUG_PIC define
Date: Fri, 25 Apr 2025 17:28:13 +0200
Message-ID: <20250425152843.69638-30-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The debug printfs were converted to traces so this define is now unused.

Fixes: 0880a87300 (i8259: convert DPRINTFs into trace)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Message-ID: <20250423101125.B243A55C592@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/i8259.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 2359dd82534..b6f96bf208c 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -32,10 +32,7 @@
 #include "trace.h"
 #include "qom/object.h"
 
-/* debug PIC */
-//#define DEBUG_PIC
-
-//#define DEBUG_IRQ_LATENCY
+/*#define DEBUG_IRQ_LATENCY*/
 
 #define TYPE_I8259 "isa-i8259"
 typedef struct PICClass PICClass;
-- 
2.47.1


