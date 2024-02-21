Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74615C54787
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 02:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rccGT-00036H-Dy; Tue, 20 Feb 2024 21:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rccGR-00035K-H5
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:23:15 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rccGQ-0001HE-3F
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:23:15 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dc6d9a8815fso6036410276.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 18:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708482192; x=1709086992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDRRjl8baD1zhonbGfZ2uzFp+8Ennf/3eSbAbTQ7I2Q=;
 b=FohFBFcRrO4V4hd/EziU259YHJB2hrDOfnce4f5PJeNqURK6RVkJooNe6z/GYIUiOe
 Y9dADwu/caBLZZ3cl0Um3yqbP7WQmW87AFQ0a/NXH5+dxI/YcM0D/vV/dvxX1PqhRFXh
 n1+n5rn5NSsGs9kbtjpM9SdGsyTPvydtjQ6KjRC0XX2dogHhs4t4o+t74J8beabfNjN5
 m7zYJ951x3sottnQKHl3vqhQphnLP0hFQYl3wAxQnhMSaL5H0+6gFLo1CunG0eSJg/G/
 xhbPttZQp+3lfC4QLD582F3QAzt/ru9sMenIVeL7Ca3KN7wnw9/Mw9BbNk3QhH2sIncz
 J6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708482192; x=1709086992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDRRjl8baD1zhonbGfZ2uzFp+8Ennf/3eSbAbTQ7I2Q=;
 b=BXYo0AOreXb7lO2yWoD9HzExzJVLSyj/ZB6kY1WAW11yfB7aRLGlAcLZAf0nZeEcal
 NAiCojP8bRLzeT1jG2AhZKPvyM+s72fCv4elwJSU3o8pODX8Ggj6MvlMV6g+UY7SRo8q
 ZLRme2qPU2J1F1JHf3zWlJkUwrzvOLyUVo/ucfrNGK8GbIZWacT3jOLjkCUTLE3d9fEP
 pUg9Wrdzl9FZxAyaZ0l4g+qGr2o6mTP6H/T6vV5Z1U5GZdWFLQv0tOeiqcPXpYOlVvS1
 OLazprKtzbuDFSRLj3FWifNKV4tBxPPsycfiZulJwLlRpj4rsMyUDJ8f9JMNw5UKCr9J
 YNew==
X-Gm-Message-State: AOJu0YxOKW3gEdZCIaGG41BHVSh9Xib3oVxh8z6JZ+HBXIHHmda7Uhec
 hiGhueonya03i8NcQOQ2PH0XWnZbtAR5ZQnlCjYAlUXBmcxYtPROH2p4rJYNWVS/7tbtJbHkjMz
 Z
X-Google-Smtp-Source: AGHT+IEI5RAsmJ/3SjrVg09kfwdlsaHlMet061nKahxeRoLMD/nVkluxeVJ30Za7WCvAhyq3yxdfew==
X-Received: by 2002:a25:8046:0:b0:dc7:4692:c29 with SMTP id
 a6-20020a258046000000b00dc746920c29mr16318993ybn.33.1708482192459; 
 Tue, 20 Feb 2024 18:23:12 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a634945000000b005dc48e56191sm7183355pgk.11.2024.02.20.18.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 18:23:12 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 4/7] target/riscv/translate.c: remove 'cpu_vstart' global
Date: Tue, 20 Feb 2024 23:22:49 -0300
Message-ID: <20240221022252.252872-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221022252.252872-1-dbarboza@ventanamicro.com>
References: <20240221022252.252872-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The global is unused after recent changes.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 177418b2b9..f2f0593830 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -38,7 +38,7 @@
 #undef  HELPER_H
 
 /* global register indices */
-static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
+static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv load_res;
 static TCGv load_val;
@@ -1321,8 +1321,6 @@ void riscv_translate_init(void)
 
     cpu_pc = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, pc), "pc");
     cpu_vl = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vl), "vl");
-    cpu_vstart = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vstart),
-                            "vstart");
     load_res = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_res),
                              "load_res");
     load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
-- 
2.43.2


