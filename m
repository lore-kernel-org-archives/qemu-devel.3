Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714E3C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUG-00078n-PR; Wed, 12 Aug 2026 18:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUF-000774-1g
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:51 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUC-0000sp-8H
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:50 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so1829913a12.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573907; x=1787178707; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5H3dS6eK0R1hQKtnqZU8IILtlkBrVMAi0I3A2QXrcD8=;
 b=qFmevy8I8/cuvwW52Hp1CPVJSox2eiNv2JjpvfxCY/V4h17Wvf1warqozRA+iD4fqS
 YGfN2qQmPrRpXTBwA4Gnu5QiT1Npyesgew/+Vp1A2xS2WRrWKJN+SUBKhqe+VUUXdThO
 cXazdAeNlPclYLBdvmwUOhteXt764YCJ7XxGcMtCULkh7LsSxqk/Q6+m4udo3MZJ3KO+
 X9BEbD0Oag2hnOmEoOfELItiFist+emdIVeAGcHxqd86Di8v/f/gFLrS1skrqj4bfizb
 yQYyqSSuQe6pPr837CaXZ7hj5XL7PYwxriuW5CgHZxUC6ic0hu+ecVP1nPSd/zn9P8LG
 9UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573907; x=1787178707;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5H3dS6eK0R1hQKtnqZU8IILtlkBrVMAi0I3A2QXrcD8=;
 b=I9g3QoqHYJnFJb4yHe8Ci9xEEsr9abYoGE8WO55T4lYiGvqtoKcNb+rpJxzB0WpsyK
 laCfzcDRi9Ac8O0b3oAti/fW9NBlzqd9VKLiSoMz3bHe2JAo9obXPk/b/4AAQQYfvH+4
 IY2DThP0t16C3WHSmVnobxtcwCqDE2Gt40ecObGp90MzRElXhyNLdZjeUm3+7Cv8QRTW
 ZJWnMXq1d0HUKrlwSq24I4oFJfVEDcIQGHVYRO6DAnCSsyL1THTdZo8vzRe3qes/7qAV
 j/bRu+V9rGz85FflkhQ3V/tHblvABJtNanucm+JslkboKMWKX4aeg2eO0SSwZg/hWVl6
 wX2A==
X-Gm-Message-State: AOJu0YwLkPjafTfY2a76LruvCjyBXna0tLmG/nw44zrRrv1/colkMJBX
 /HcepjoQR63UsGsidpkApk7N6fI9gHWMbqodrd156g5fd3bHal2RvgAGPWB++FOif8RAA/uUB5y
 GDyUl
X-Gm-Gg: AR+sD11tWvJM6QCZCWUGrBR44VqXm9cls9+2iX5sIZbhByLKwNPa0T6yhIIWOB81XlW
 9nt2OM3l9YCg+Ne3jJP2shxz+elO1O1GBJOIWT7cRpaYAhYbYFMuWFmNCyqPrxdhckq0Ii7VINB
 DRy14J5vYYpfFpLpFFwY7+FC1VrEnNlt+KE07nycq8e5krHQ7G0TGEppVXUKVM/Jxcala3Q3uqa
 700+evquUDsHM+YmosRVbAgI2yYtWKXgT6n1kC7zjWnE0ZcokYvEJYJvnI+z3VyhMJeFTU4RD7c
 qNHpmto0pOyz8U47aV8HVpsJbq2qfjtL18MSnKzP6txfuHQWWalhMZ3d1y5IeoXr6UNySRxWv41
 en8Fj5Y6Mn9vXya6snOJATmBlqVAq/ElsBQHef291ouAqY9wB3A82I8WzUX/NXZ6uvRUzuBisvM
 bFfdKcvrbavZbM0z+b/3h8Qxcs/c5AZUM0o0V0ht+piiXL2OlNgGLr+i3LsejrInkPgrPAuOShD
 CgPgS3ltL/M3sXbEbBR
X-Received: by 2002:a05:6a00:bb0f:b0:848:51b3:f3c2 with SMTP id
 d2e1a72fcca58-84fc7505093mr849893b3a.33.1786573906793; 
 Wed, 12 Aug 2026 15:31:46 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:31:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 03/52] disas/riscv: Tidy dec initialization in disasm_inst
Date: Wed, 12 Aug 2026 15:30:53 -0700
Message-ID: <20260812223142.349142-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.43.0


