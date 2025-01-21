Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9626BC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJJR-0005qu-AS; Tue, 21 Jan 2025 13:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJJJ-00055j-Nc
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:49:13 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJJG-0005No-Dx
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:49:13 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso102557235ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737485348; x=1738090148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvLXXAKDH9ahcunPLK9b2L9XTGiX+9XTb+WMW9ld36E=;
 b=eEiEz7aw4F43SF5blxeSRRixrmMbLpfGf+qbRExr9jvY4AjdicL6Q9DghtQVij9FaP
 B9WUpQAUVG9eBwy8QjO2IOfGXJvYa7q7BlTaWl+Ew8E/gcFFxsqdWZnFDOic9BjFX5Us
 hkgcfu/Se/kk+Iw2QCgfUylc22+Dg42SV/OmrcXwf6pJbQiZqYr5WcNaorHwLu3qjSnM
 xQexYo9yr+Y7j+QExt0GLnkIJy3yLEFOFm+SLxQniIlM2gNRbkJQYJiykcb/i3iI8ZGK
 YO2ci2O0xEA5hS4Om5+PmkY29PX2Qds7mEjRrJmCh7nZgZYSZOLDhACwMc/n6JNHb9fK
 oS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737485348; x=1738090148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvLXXAKDH9ahcunPLK9b2L9XTGiX+9XTb+WMW9ld36E=;
 b=Zt9XTvdZFfeGS7fke97AM8lcN+IDem3CgAAh/Qifioa1xZ0e4sA4xC2zZ098wrQYDa
 +RmCLxHpfZVSf4K3qrYi5VlT0LK3Zy8VFGYCMROhi379xusF8esaPiGv+k+pSbGv+TzI
 QfvfCrK7m0391kecOx187Uo5YWbVXEVo+RzGXbgjZ2+7JnHQckmox9xvQokses20USh/
 ClF9ahlX9pbBxzBWcGgbDdElJ6zgSg7qFTjsDTovveZfvLHH+LBQG7UPWk0QsQioMboA
 LOrsOoCjJ9aINcVeVClaFf1dnLmyMbb1QyiR8M5Lxy2sYb9rwp0wX9cyR3NATLAwIPjX
 x1Jw==
X-Gm-Message-State: AOJu0Yxz2LY7Rr8XqEGlp0WbqHeVUjMbfVjMW1LXOwIx9EZyIsOjHj0l
 /SbOfkN/eUDhUuy+/yoKgYBInmouNwt+vqFx6LoBYOJOE+drIS7IfH9PPtTMT0pfY0ouQxW3plK
 Q
X-Gm-Gg: ASbGncuu2sEfAABfDupjiN8U6Bk8AHRB6wZyjUuhzNDPnQy7HFzc+E525TpHNKiToZN
 5s/b1qMNIDIX65dq1WHf65gCb50x2zI5eEOIkaPuw0MT8LbjaASPZv/3OyL2EOiXjbjaJRViryT
 QkM1JHRumEvNi+G5Ts6NG7RFpQAAhCZtz2pfpdT/DWkw0zoJ6VFjcbjBjHdAQyzrwoGeijGN+5C
 YwMnlxfVl2p49lgcb+f14jWI3krrVSexju1RndRwv7a1HrEuQf00BULeDZ71vHzEckddwRk
X-Google-Smtp-Source: AGHT+IGemy6A+esvt/sUQ6h7P7vlMAEZgDNh/xiJfGyHmsLHZ1zQ/nDOezuNTESLT+1COu1kWoIy3Q==
X-Received: by 2002:a17:903:32c1:b0:21b:d126:6d30 with SMTP id
 d9443c01a7336-21c355c433amr246020075ad.33.1737485348333; 
 Tue, 21 Jan 2025 10:49:08 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ceba56asm81121865ad.98.2025.01.21.10.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 10:49:07 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 5/5] target/riscv/cpu_helper.c: fix bad_shift in
 riscv_cpu_interrupt()
Date: Tue, 21 Jan 2025 15:48:47 -0300
Message-ID: <20250121184847.2109128-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
References: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

Coverity reported a BAD_SHIFT issue in the following code:

 > 2097
 >>>>      CID 1590355:  Integer handling issues  (BAD_SHIFT)
 >>>>      In expression "hdeleg >> cause", right shifting by more than 63
       bits has undefined behavior.  The shift amount, "cause", is at least 64.
 > 2098         vsmode_exc = env->virt_enabled && (((hdeleg >> cause) & 1) || vs_injected);
 > 2099         /*

It is not clear to me how the tool guarantees that '"cause" is at least
64', but indeed there's no guarantees that it would be < 64 in the
'async = true' code path.

A simple fix to avoid a potential UB is to add a 'cause < 64' guard like
'mode' is already doing right before 'vsmode_exc'.

Resolves: Coverity CID 1590355
Fixes: 967760f62c ("target/riscv: Implement Ssdbltrp exception handling")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e1dfc4ecbf..64d1d68550 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2095,7 +2095,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     mode = env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : PRV_M;
 
-    vsmode_exc = env->virt_enabled && (((hdeleg >> cause) & 1) || vs_injected);
+    vsmode_exc = env->virt_enabled && cause < 64 &&
+        (((hdeleg >> cause) & 1) || vs_injected);
+
     /*
      * Check double trap condition only if already in S-mode and targeting
      * S-mode
-- 
2.47.1


