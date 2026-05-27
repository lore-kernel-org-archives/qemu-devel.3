Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078DCCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKeN-0006NL-Ns; Wed, 27 May 2026 16:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKeK-0006I7-Cl
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKeI-0005Ld-6r
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso65535515e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912880; x=1780517680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iH62ufHtz7j9HYbBqPOwH+CwObJzaFz/XebFGOq8UJ4=;
 b=ir3l39y45Tv6OqsbjjsrUCu4EiM0/8ukuJDi5RUKKm+0PiDw3qyAFcuJANf3nrU56s
 +1JWxIh/bYyL1f/8VTiHigc1F5mYyruWmck6UIiN61AP1q4HyH0PL97tXwBCm1hvZwgT
 3yaf7nANnh4W7nU5wMFk4tFKHn6cfOyRWpNe+kjnd0YG+kNXxGg+p7HriNvyAdkdJ5Ce
 MoNRAhZRElP1OQL08BYdD0HjtCRTUWJsodwTvfMGFT1yKEtQMBO7Ue725IIDChpBjH1k
 NlJ3zjkf7nhJsxN+A1MZmH0fy5jiVvoZp2u4qxXjoR7eruT5gRZZ5vyIocOM8DS2gLAr
 bd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912880; x=1780517680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iH62ufHtz7j9HYbBqPOwH+CwObJzaFz/XebFGOq8UJ4=;
 b=SJHioNn+Al6QG5UzLYVHwuLNLrZxvBMl3cNbD58+YZL0v8f9HJ0KYOv3JFORAmhFD8
 QMWI7XwGz0MkBtaTIzbwG+OZF2uTKwmlhQ+jVzCZmSJNuTRUNQKKHZkRJbGPesDVcwTo
 JaJg41shWjkNE7dMrZ68Uz1rF6+CigvYLpUvs3/E1OhDFpcB2DkA7pNd7wPjFvcQg95h
 tnzH1odg+uhQlzkQBEgGpl8jIS0Vbkj9toYM65mOhKUi/qd+DgJFahqYteVDp1fIUqt4
 /HJGoQenT8u7ql1Yl6U9XMnvVlvGcdA94Lw3LyssrqcYr/FGmRsGmTxjcGIKvWPVdD6H
 Au/w==
X-Gm-Message-State: AOJu0Yy1oJ/BrNYKRxfZjVsB4yKYdHvrPQSJ9uMsGdOAR9/37mxL1QBc
 omDin4ffQKzFScNvCqlw4lSxffE7sRV6sUpV7VlcaUj6WL7NvVJJiA8AjFybPiIpS3oxkuuk/U+
 2HQaxFZo/zA==
X-Gm-Gg: Acq92OHo4LQBnyS9R+wzfLIWnDiXBZK2y83Le2cUbkrXqObHmVkEykNiGVDs4OlkKPg
 pSaHJj189EEqmxPNo9uRKAkPU4yQdV4OsHDNZHxTsmAUAbylbzY6G8BGbebC40xVyEXfOprSJh0
 8X/15RY20gfqTV9d40jySG6ymfwDun6RhHdphdWtvC7X33d9ED6a0HBB0NYctqde17+ClWi8loX
 1tkb2+22NY8ivjG3sDJnVku1cj3iYIOiGNor3cthziL19kO+uZH3iOJzH7+2tv5e1Oc3+Xd6raC
 IuOdN3r3sA4JHxXdLKKocndMHU5fCZmWSDy8ChpNPsEzIvszg+vgu6euMOE6B3g15dFXy1aifXn
 miCw9QCDRlgGm7wfxYr8WlaHOAoY69Xj6CYOydLJh/NtLYYvpQKfAilVhxBjt5xeBGiENWZd0FL
 Mb3wgu40H0KZ2dhUl/a4b7bUick7OpYylVXs0CByvH7rTg0z9NNj+QincqDcxO21Gglw==
X-Received: by 2002:a05:600c:4510:b0:490:3d2e:b67d with SMTP id
 5b1f17b1804b1-490428eb9aamr380924625e9.30.1779912880153; 
 Wed, 27 May 2026 13:14:40 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490452765f5sm435518395e9.5.2026.05.27.13.14.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:14:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 06/12] target/riscv: Fix page table walk endianness for
 big-endian harts
Date: Wed, 27 May 2026 22:13:42 +0200
Message-ID: <20260527201348.29511-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
References: <20260527201348.29511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

The page table walker reads PTEs using address_space_ldl/ldq which use
compile-time native endianness (always LE for RISC-V). However, when a
big-endian kernel writes PTEs via normal store instructions, they are
stored in big-endian byte order. The walker then misinterprets the PTE
values, causing page faults and a hang when the kernel enables the MMU.

The RISC-V privileged specification states that implicit data memory
accesses to supervisor-level memory management data structures follow
the hart's endianness setting (MSTATUS SBE/MBE bits).

Fix both PTE reads and atomic A/D bit updates to use the explicit _le
or _be memory access variants based on the hart's runtime endianness.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu_helper.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index fd7c6ac1b23..9ec15fdf46f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1370,6 +1370,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     target_ulong pte;
     hwaddr pte_addr;
     const hwaddr base_root = base;
+    const bool be = mo_endian_env(env) == MO_BE;
     int i;
 
  restart:
@@ -1418,9 +1419,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
 
         if (riscv_cpu_mxl(env) == MXL_RV32) {
-            pte = address_space_ldl_le(cs->as, pte_addr, attrs, &res);
+            pte = be ? address_space_ldl_be(cs->as, pte_addr, attrs, &res)
+                     : address_space_ldl_le(cs->as, pte_addr, attrs, &res);
         } else {
-            pte = address_space_ldq_le(cs->as, pte_addr, attrs, &res);
+            pte = be ? address_space_ldq_be(cs->as, pte_addr, attrs, &res)
+                     : address_space_ldq_le(cs->as, pte_addr, attrs, &res);
         }
 
         if (res != MEMTX_OK) {
@@ -1629,15 +1632,15 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         uint64_t old_pte;
 
         if (riscv_cpu_sxl(env) == MXL_RV32) {
-            uint32_t cmp = cpu_to_le32(pte);
-            uint32_t val = cpu_to_le32(updated_pte);
+            uint32_t cmp = be ? cpu_to_be32(pte) : cpu_to_le32(pte);
+            uint32_t val = be ? cpu_to_be32(updated_pte) : cpu_to_le32(updated_pte);
             old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cmp, val);
-            old_pte = le32_to_cpu(old_pte);
+            old_pte = be ? be32_to_cpu(old_pte) : le32_to_cpu(old_pte);
         } else {
-            uint64_t cmp = cpu_to_le64(pte);
-            uint64_t val = cpu_to_le64(updated_pte);
+            uint64_t cmp = be ? cpu_to_be64(pte) : cpu_to_le64(pte);
+            uint64_t val = be ? cpu_to_be64(updated_pte) : cpu_to_le64(updated_pte);
             old_pte = qatomic_cmpxchg((uint64_t *)pte_pa, cmp, val);
-            old_pte = le64_to_cpu(old_pte);
+            old_pte = be ? be64_to_cpu(old_pte) : le64_to_cpu(old_pte);
         }
         if (old_pte != pte) {
             goto restart;
-- 
2.53.0


