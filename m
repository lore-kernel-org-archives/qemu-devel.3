Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872E9C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjs-0001xk-51; Wed, 19 Aug 2026 23:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjn-0001mD-SS
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:43 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjm-00045l-E5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:43 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so1645756a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197601; x=1787802401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2/TGr75vkp0br2SHR4F1+UQxBkhDhZrz6IHZEj1QXJE=;
 b=YdJ4ABe2hYfvrnw7kCYEj49Aos3vlA4+nUXKRnMmU00oAJMOFZ+kPCFdUKFYDMWsr+
 CtLuPF4whgr0G9WmmTU5EKm44P0bKxIY/1PfVuYW1WtkI6ExYg68D11fkjkVOjqcv+4h
 eWhRYxRdrjbfBSgh4GVG444gXrTYa/C9WdssZURIcxAT9t/DTCKCUYifEm0VtruLK9iW
 I1KLMkh5E/R2sXDdT2ihzc8VgOvPXFACuCTYVvpD/GzXm7/hlUu89o8rLUFrIT7na+AY
 ekAHbDWRKGK2XI2xTp915l6TMB6xKMpIdPnRXeyWwG5VfeYTd3wGcvPkdwEcY2S77BQv
 1o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197601; x=1787802401;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2/TGr75vkp0br2SHR4F1+UQxBkhDhZrz6IHZEj1QXJE=;
 b=qR9PdhWvF2etzX/r58uAQ+g4gVGt634K5Na15e7UKVVkQljakKXbgjkFys6G6nyZcJ
 Jx8qmQ5FFIulX8yqXqAw5Dy/eZzp+XJa8FoQYlEKu3cti/T47J4S4rpt0w+C+TXhQPBi
 eJXBSDR+pOHt7UKMSNfQNXOfU+zjPz5i8u5e7BCRxVAfJPB1MguM0tCDii0oNEYsCVV4
 T3XEJNQp1Uo4wXmmOvgusXnZPF04v9YlQHJTfgNdn5VGG8H3j9f3u4usG3g2ol8ITkYL
 atI6ODuPoacMsd8egxGHdHNQK3p2NX6upAuHH6h/3f7jG+yC+RKouFp0jDMjI4iF/6rR
 W8eQ==
X-Gm-Message-State: AFuF++nuj97ofobCbLrjzTmc6iwcjnt8fORcXkj2yNyF8xgsASLAudpD
 TbsKafHxyfZoU+1XyOJhL1xfthqX/G6paTaoLfathj7kBckLk1iwUgZ9yOeFKw==
X-Gm-Gg: AR+sD12qRyFAegVXC0vGSotVmMnjKCqWxmiREqhbUCER5qn7RlJ/nn75T6sZvjHRqRt
 9Pu3qHhZ5Hx3fEGH3hCUGUFxFQ6XGnwH++5FQNj5Ddc/yXXgfQtfFuw5vAuL7z4O+TRFBvYlvyO
 jKJaj3/ISVN3Sg1OQb+WJO4ldxk+L0OKM6WVnSBWq6x6ZJKlaLIpocJkyv6Myu0qVe0P1e0m1qf
 c6QDJ8R8ETdTqlS3+DUqoykiLijFg31gwRi1N7aq//3HX6yBhWrVoJb49WTV23L2jiw5bC7J6C+
 jvHGSkksNBl+El52lWn014hx+kdtgV2yvMNORnANFT0s1JpS7vExyqner+XTjgZfS+xopsYRQ3x
 CDjhND9ic2F5iRmeG0TwCV2kKPjYl3S2NMAqB7a4eoN1roW5uDUfD9W6s/SjoN3rEEbreGG6FeY
 4FeeYMRR4oAmuPHE0gYH8URCsbnhdvrFNJiLGP4S+AIgJl+Q5LDqtpL1/hE4B2FFJs7TC7zyq8p
 w3jpw==
X-Received: by 2002:a17:90b:1f82:b0:38e:2524:724f with SMTP id
 98e67ed59e1d1-3958108a4c6mr17821854a91.12.1787197601157; 
 Wed, 19 Aug 2026 20:46:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 39/93] disas/riscv: Tidy dec initialization in disasm_inst
Date: Thu, 20 Aug 2026 13:43:36 +1000
Message-ID: <20260820034430.1186695-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-4-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 012f90fce6..986dc6b752 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5441,10 +5441,11 @@ static void decode_inst_decompress(rv_decode *dec, rv_isa isa)
 static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
                             const RISCVCPUConfig *cfg)
 {
-    rv_decode dec = { 0 };
-    dec.pc = pc;
-    dec.inst = inst;
-    dec.cfg = cfg;
+    rv_decode dec = {
+        .pc = pc,
+        .inst = inst,
+        .cfg = cfg,
+    };
 
     static const struct {
         bool (*guard_func)(const RISCVCPUConfig *);
-- 
2.54.0


