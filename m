Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DE8CCD180
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yQZ-0001V1-9E; Wed, 01 Oct 2025 11:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yQW-0001P2-Hv
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:07:32 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yPS-0000iA-AN
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:07:32 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso8995605e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331173; x=1759935973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlF0EsBCoNK14XGfky/iWN9CIlAKTNYjEeycOlfIXIg=;
 b=dXr/95V0xfA5Vn28niOQYMma0oQ4EVePsCqhH+dKWk8Zx7RuuTllI1VS/eIK5fVu9d
 UQF1R+P8P4MMwD9yVxxYMmuCh05J7gLJoMes+hYf7LeMH1XwL+8u5CtMlyaRbtAWDfq9
 /vS+gdYYQ/k2lz0cQMNt6rxXZnSoFHlJWDkDWMQEthAa9r4+9H/UEM/UwxMVELFQguVH
 8fQVtJrTNXke53Tsys9ZeLjRXPA8Ho5bmOpmbNnktDUbPZa9k5bfgDTNh2Czf/ygKXXa
 VYMLHZvxlRUro5d4FiejwsKg2SPYDDiob3ploSKN+qmc/Ahj3YrncL0k9Y2fzw6Q1X4B
 ka+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331173; x=1759935973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HlF0EsBCoNK14XGfky/iWN9CIlAKTNYjEeycOlfIXIg=;
 b=M3HfASfwKnzCaDPujeOJoujbM5YO/ZY1Up1DzssqbTBYFFxtLlCOB8yTUTB7vZSLGz
 kjuFI3fDY9iH06ASQhUMp8/m7MCwJyGrgAjk2svEczzwXPkCYqFvDzoFsl+Zgf1+BumH
 BvHbDHIgltZ+4P0J7nUislwoqcpjcVa+c/k/0myb0JRi1GJDewOLn5dItHfLmzvVXsDL
 pDS1zATiQDjNKdKOz13FGGGJ0aRuFDfkZ5uQE6+agOjTy8jLGiUtDxqYRF0WEYDd6Aan
 dnb5walvbO23u8x6kNPqyoL/4KwTIcqWWlqaRZ98BMgwxae6lyDmTZadm5TYoCP4tNdO
 B33A==
X-Gm-Message-State: AOJu0YztI+mBJGytYIQ7XipwSiTl2ycUK5edim8YJHvYthK5RoQY2pYS
 5DBfKeIGrbFSPYitU10xbPXL+DAxs94o5D/Y571rQjpreW5s175P7245PjyXLbmwF3/XZzNcDQb
 CDG03aYavTg==
X-Gm-Gg: ASbGncvk19koiLDeJSz2fAvbXIAB0MjzqnJ1N0NOnV9kaM21kpT453z+dWoSAru5q3S
 WDPLoLI9TShZJ+dg+8kuCWnPa2RPiCD+l8IebAXL97bABK4AOe58DRlUNObxHpzKuEqI2R1SSvx
 j6BN+bzPff+u8t8YWqVOMBdVtjegRnapyf9Pj8n9xVaps6VNJdsk1QiIq/KOMBA7+iJf4OtttjB
 2fcc71JKbr3k7UOlcMmHkFKmAlv0b6HMOawC+S3jOVRdYuv9ELyaFsAqEy2oQvcxnNrFpu6W9Ci
 rEpvL7RL08MW99twL13ROJokSCx1wKcp62Y3IOpTg0bHWqK/Pz2zU/MMJmyIxoeTg7hoGYQK0jv
 YmoyBiVLpuoPeH0oKdROTEQq2rRe9mMbV5BoyA7LjlVh8flUKQGEwCO8zuqzE4zoT3MYSpGUkEl
 1LBYqXmYWCR5tNvM9GtxS3
X-Google-Smtp-Source: AGHT+IFTNHfjgnNa+RWfDs8UzIIDSSUm0wBbmygGptOGYKsRpIMIBY+62JNxNRiOmnEMBtsmysqGsA==
X-Received: by 2002:a05:600c:c117:b0:46e:6339:79c5 with SMTP id
 5b1f17b1804b1-46e63397a8bmr19297135e9.5.1759331172869; 
 Wed, 01 Oct 2025 08:06:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6199f589sm43899835e9.10.2025.10.01.08.06.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:06:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 08/22] target/riscv: Get cpu first addr space with
 cpu_get_address_space()
Date: Wed,  1 Oct 2025 17:05:13 +0200
Message-ID: <20251001150529.14122-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

In order to remove the convenient CPUState::as field, access
the vcpu first address space using the cpu_get_address_space()
helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3479a62cc7f..d28230d12ea 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1282,6 +1282,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     }
 
     CPUState *cs = env_cpu(env);
+    AddressSpace *as = cpu_get_address_space(cs, 0);
     int va_bits = PGSHIFT + levels * ptidxbits + widened;
     int sxlen = 16 << riscv_cpu_sxl(env);
     int sxlen_bytes = sxlen / 8;
@@ -1365,9 +1366,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
 
         if (riscv_cpu_mxl(env) == MXL_RV32) {
-            pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
+            pte = address_space_ldl(as, pte_addr, attrs, &res);
         } else {
-            pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
+            pte = address_space_ldq(as, pte_addr, attrs, &res);
         }
 
         if (res != MEMTX_OK) {
@@ -1561,7 +1562,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
          */
         MemoryRegion *mr;
         hwaddr l = sxlen_bytes, addr1;
-        mr = address_space_translate(cs->as, pte_addr, &addr1, &l,
+        mr = address_space_translate(as, pte_addr, &addr1, &l,
                                      false, MEMTXATTRS_UNSPECIFIED);
         if (memory_region_is_ram(mr)) {
             target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
-- 
2.51.0


