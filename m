Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B1BCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 19:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUqtf-0005X6-Q0; Wed, 03 Jun 2026 15:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.barry@usp.br>)
 id 1wUqtd-0005WJ-E0
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 15:04:57 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christian.barry@usp.br>)
 id 1wUqta-0001Qe-TK
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 15:04:57 -0400
Received: by mail-vs1-xe41.google.com with SMTP id
 ada2fe7eead31-6efdb57db0cso329396137.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1780513492; x=1781118292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6/G/uqHfwL0zUCXsViLqL5ougH2I2Vk7WD45s454m9g=;
 b=B7wO5S3+YUpBXsZxsGJ5tAGkA1epFeMlf1AGSVoXvIOoxWNndWSvMZAh9KniwPxCcF
 rx+P9A8JCqJqsirPMvIR+ny7alrvHfBzzZkBdfueolTElXiiUfcWsYpi8YzbHPpyTM7c
 IXMu2v1CG/fIjIWUOqC56ErV7scHXLSjTm0NGqCBPzK5zjwZ4pHH8Ovdg+bXVPgDNOdW
 LE7wI/UaA1XmLz1rNgG0IqaPIKzkiJVfMlAvW9v1TqzaFGaq/vpib/XBZ982sHZI+T+a
 xWnP1q8IjplX5M+baIUaCa/sv1dCdQ2XcvCoNPd1AuwW8I38BobFO7PBqLp7iwKuXXyx
 hgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780513492; x=1781118292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/G/uqHfwL0zUCXsViLqL5ougH2I2Vk7WD45s454m9g=;
 b=TneDqy1rQjrbCEnt3etMQ+4CUUVvdzY6zwZjSvb8JtoKzUY/VQaBlQoiMVGwjTZW2x
 zb96h+Nh7r83RHNf9rjgfbKkbWTkOnrUHuodEL4TkLspz6Oo9EtDtK1bv4ZHKaeA1YyI
 yIa8oTElbto84C0Guy2UgvAA41euhvgvazl3QKt+EwBlVIfaVlvvV1RNGPPREYElTPd0
 DNdx2O3feH4ekMGYayzdGbLO93bVkn8ZikQdsQZPjv0kH65DABUktrk++eAr8pmJlYfN
 r/6Eu10ot7MNmZKkDdmbey8ZCtTna+HZ6GyMENu/KGzjC6uivWsDoqURWaMTkryUS5ma
 NHBw==
X-Gm-Message-State: AOJu0Yyi7m1CHpac6NASM4nM8PwHrJS2dW3Z6tddin4WEmsMZyHeQXoc
 qbEEp+FTi3KQdshSt0T4nJESWSPJ+4nu/3QafVQ6TEYgzILI5JqL/6b4dJtjC3xsFfNxXh0Xcy0
 TOuYY2gU=
X-Gm-Gg: Acq92OFA/ByEPQbjal/qYB3Z++mBUW5vuLT5mTQK+1Y/YhVOSnoe8Qcr20NX56ilABI
 oVR/C78GxnMaE1DNVSFX6gXDAigGZcwOcR+urbTHFXXaz0AlKJgu+PyMTQzxkzXc7y6f6EXTLQa
 /pyiLt8x/Y4c94mjmjZyf6Lc9JULV3sfO9NrS0k4MjpDD9aCKLsuGIqCFrqeW/mhNhgYJwb7/K0
 UA72jMRb4GtRPr1eogTiLRvFKD4C4+Tqm2v/fRI+NeuGokfemqghI1Vf47gv16AMJq4qVQePaRu
 HLAY5RABi8zvOYVUDRaF1B9qaqVU/L7al8kc8g7NvBL69/pZAGdKdyc1NDejMPUmweSBj8VKXaA
 OsT24zqYPgDO3nJ6eAPMc0m9Hk/Oi+Vcudgj3qO7Q3sKhbH8zMEhRel5cg+lFShJ8UxFUwnwYYh
 KP79MtmoMohHDmrFQpiPMLqRHCO9WR2ljhQ79nJeK3ZN12+sNKsWAXSMhpqxb9sO4Mj5yX97fP
X-Received: by 2002:a05:6102:41a4:b0:607:5cd7:d7c0 with SMTP id
 ada2fe7eead31-6ec460bc68emr3093161137.19.1780513492027; 
 Wed, 03 Jun 2026 12:04:52 -0700 (PDT)
Received: from christian-barry-IdeaPad-Gaming-3-15IHU6.semfio.usp.br
 (nat.ime.usp.br. [143.107.45.1]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-6eb649b54e0sm3100574137.9.2026.06.03.12.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 12:04:51 -0700 (PDT)
From: Christian Barry <christian.barry@usp.br>
X-Google-Original-From: Christian Barry
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-trivial@nongnu.org,
 Christian Barry <christian.barry@usp.br>,
 Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
Subject: [PATCH v2] disas: sparc: Fix integer overflow in compare_opcodes()
 for loop
Date: Wed,  3 Jun 2026 16:04:46 -0300
Message-ID: <20260603190446.10319-1-christian.barry@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e41;
 envelope-from=christian.barry@usp.br; helo=mail-vs1-xe41.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Christian Barry <christian.barry@usp.br>

Replaced left-shift of a literal 1 by i inside of two for loops in compare_opcodes() with 1ul type qualifier. This makes it so 1 is explicitly interpreted as an unsigned long int, preventing overflows.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2618

Signed-off-by: Christian Barry <christian.barry@usp.br>
Co-developed-by: Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
Signed-off-by: Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
---
 disas/sparc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/sparc.c b/disas/sparc.c
index 5689533ce1..40c1164554 100644
--- a/disas/sparc.c
+++ b/disas/sparc.c
@@ -2515,7 +2515,7 @@ compare_opcodes (const void * a, const void * b)
      another, it is important to order the opcodes in the right order.  */
   for (i = 0; i < 32; ++i)
     {
-      unsigned long int x = 1 << i;
+      unsigned long int x = 1ul << i;
       int x0 = (match0 & x) != 0;
       int x1 = (match1 & x) != 0;
 
@@ -2525,7 +2525,7 @@ compare_opcodes (const void * a, const void * b)
 
   for (i = 0; i < 32; ++i)
     {
-      unsigned long int x = 1 << i;
+      unsigned long int x = 1ul << i;
       int x0 = (lose0 & x) != 0;
       int x1 = (lose1 & x) != 0;
 
-- 
2.43.0


