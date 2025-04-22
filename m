Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD98C369DF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPd-0006pp-Ct; Tue, 22 Apr 2025 15:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOv-0005AH-Rm
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOt-00072q-QY
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:25 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224100e9a5cso66580385ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350521; x=1745955321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyO3H/jvct9185BjfASAXhlbdjAHZIvWqk2wIAaPbys=;
 b=o6nkNGPDqK7rh9FLy/MtBPOXoFR5oEOHEuSjFCXjhhX0HrWtUE7wvfmXrdEVfz2I3c
 pXrEJIosZxHLq4bWwOMAnVZ3yj2hFeWa3WURPeoeaYZXy5kCZD4BdBqCwc8zGRZHAEz7
 x1SIAmaEN4NlCTHBAwJR7Y9vT3QgIVireQk/3/gNG59nlYNscgnIb3PO/O7CrG11PlLC
 uv2uYB8YxXYmpX4/Hb0qgxCsHCPLIq2XogdbPXsZESCbEpHoPJ27r3oidNKiDegu0K8V
 FUoH+277CcexwlQguos7ig3VCethCoJuVb55RauMOAqmTYbS+3g5zkm42uPJAdOewrmi
 hoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350521; x=1745955321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MyO3H/jvct9185BjfASAXhlbdjAHZIvWqk2wIAaPbys=;
 b=fQSsYpseg+xI2zIPOVVb/96n0B0RGaE6TNx4ZKgIRZarQxwjJuaLCn/HL6P3XVyTec
 7tfVcNCcja4DlENvdriNWESoMvKH93OYSed7jRzh9kdr+mU7w8dnoHQf455VsPt6ZM3n
 aO+07nDiEflhtNRp1hCP42BghGCcNNicTwJR1qZzl4ZR4J6/ccafmUMeMgUy79pobVAk
 RlEJxtBjyqZej3tB0e308GoFVu110kjtxba7hedSrD9pSK4JfngOpkvXHtNFU0D8RKLs
 h5U6mXcvQ/FPkDrR+rk0ooXxa8DUEgI9+lyKkgBfR8YcbR1FgEdBx+Q+TJBSkf/kUGBK
 iYBw==
X-Gm-Message-State: AOJu0YwBmDWb+pFSH/SZ8d0sELvnO5Z3WlNLzxzPLNtBGhZIJM3EUkRd
 Q7HtQtnfdqomCwNWQceZC9B4HibO5OiyOlmHM3s/QiKMC+aYvSw1i5IcJRotBUq+LnfVAkAkEW2
 I
X-Gm-Gg: ASbGnctzYU23dy25pD9trXcSKzi2zKvxa6ypO8g+ss+jDE1nL7JmuGoHAYZi/KXZR7d
 9X6P/hSIr10SqUTlQxWPeNvyXSBXWbbKFutpl6xmKrg1ZSXiz4KGG7hrnvgMjrddKX3ESZRAPLS
 9u4I0pBIYHV6I7esspCjvA/+yNglhEq3oiPbMyCEjumVLqvb7fhlnWE/gXsabnFHckUueQZ0ftX
 nyfVN5EvazXLzwooOohPwtJG/1JaFFkdq/fuO+YVSztaGWYfFVGSkpCRLTUDOp63p81qB+lkwIs
 R5zV1FHj/MXIH1s+TrT73O9j8yhZW/IUG7Oqlv9gTx5ZeuYizJzq9l65S1QQzpCcQGoackpadiQ
 =
X-Google-Smtp-Source: AGHT+IEkCUnA8w6+lqxVUbkZYR/rh38+l1DxVImQfNcVuP5yqJssqQMC65TlJ0Kd1j5MzM3qgCPTtA==
X-Received: by 2002:a17:903:98f:b0:224:1935:fb7e with SMTP id
 d9443c01a7336-22c535a82f3mr294392725ad.24.1745350521011; 
 Tue, 22 Apr 2025 12:35:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 092/147] target/tricore: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:21 -0700
Message-ID: <20250422192819.302784-93-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-22-philmd@linaro.org>
---
 target/tricore/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 16acc4ecb9..833a93d37a 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -176,6 +176,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .translate_code = tricore_translate_code,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
+    .mmu_index = tricore_cpu_mmu_index,
     .tlb_fill = tricore_cpu_tlb_fill,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
@@ -194,7 +195,6 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     resettable_class_set_parent_phases(rc, NULL, tricore_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
     cc->class_by_name = tricore_cpu_class_by_name;
-    cc->mmu_index = tricore_cpu_mmu_index;
 
     cc->gdb_read_register = tricore_cpu_gdb_read_register;
     cc->gdb_write_register = tricore_cpu_gdb_write_register;
-- 
2.43.0


