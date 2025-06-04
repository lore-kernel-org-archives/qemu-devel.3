Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE11C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMs9f-0005aC-7b; Wed, 04 Jun 2025 13:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs9Y-0005Xd-9Q
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:43:53 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs9W-0004FY-Eu
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:43:51 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-742c27df0daso200160b3a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749059028; x=1749663828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/inJLdqRw7rg486G2EiAHTU/fa/iBHR1d8alEest9FU=;
 b=V48+30xliuls4bZ6FgkYR6NUuh1HC8Sm/WKQ1t3bN0BzTg+EX48b90x8KRJNArF57I
 JgghiiZX/KHY65avlBcNP77b3gwUfyNzLMRPZ2BkmkdUpBeJZgDR+xQ6zKjA8BS/hfof
 b0KeYIFRv8wEvXDWTlS8dC+UosUgjeIPB569tCIhVm16X3pGQjfJhbhmiyU7DCjjNDeq
 29ddH1k5woseDE0SSfa0XhfyfQ7Jz3lKW2AZzKxoRCQl61HI+4snFd+cM40pXWcliZUn
 RVh6/rxL4/lF4W30dABBaPgzXoPSnk6lChb0o9FB1IFwLbBgTWdAi3wqRT0YMi6cwwaQ
 u86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749059028; x=1749663828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/inJLdqRw7rg486G2EiAHTU/fa/iBHR1d8alEest9FU=;
 b=BdKV3MdpilsWTQhq8jc98yoIVjogsU8lhavQrSCZNf50R+TOaNcRjnMfgx/H1P7ogz
 9mcPlAECa32f7qaUWsRvp6kZslsNn2Kr6YIIFZdIeRB5sbw1C5HInTKM6t2L1U6MMSp5
 DhcyMkpmmoyWbT2vJCJAh/u21NjepQbfUmbFZwMN254Bs6YxGDKj5OR3UotglrBxWEcs
 hNdyHpk3boujlNe1t0J5uFY0ohH0GuWuqGR9EcXVb+55lPPPwlAwGlK7R9mMV/1CUKdA
 azM0pDmnI3Btklp+owEsJONuUgOHw1QUcT89q9Fnl77MQe7l+G7mN3HnmX6n9cgrCa0F
 28Eg==
X-Gm-Message-State: AOJu0YyAkJbKDqXjdvvAen1+75vk1iG3Z6UKa70qq38ShDq37P/nUhOf
 bTEMOu7x8WpUZojQuzAOpEeayI0V/WGhL+ZtY/nJbQ0frLZAUT0yUjkwmrfezxsTvV++IVttt94
 KLvsV61Q=
X-Gm-Gg: ASbGncvkua7BoniBlkC7FD/IFiL3EQz/0yw6S4e1+5y5dsEJvnfYI8YNK4DTZ7MOtEu
 jicsUcU2vkCl8nGDEtLFuXRRNLzakjMFqzpWAm3vR6rMDPhAY+xLGDmCWw6wL9llGT1nmgCgnco
 fmP1alFq5lEqyC3H+Wm1lN9+b8w6CtTVyslc7qhc0sPJZBYQ/OHLQURcLEEoOcEtGYRQsvXhziB
 vtcdUZIdHSEtX59ic5ixhXehzeYQF6dREUZ8BPZhNjlgXzz+KyJagliclL18KHZEmErYgQew64J
 obXpsG+FyYxHluKAQ8CmGMUwwlHBgFwloV92HJ76OeDeVOZFei1GGIwCyODON9yirLaeCJI6jET
 BZyLmWBDWrD4FAarpgVPYkhK6Mg==
X-Google-Smtp-Source: AGHT+IFnJynlLRjucGg0uJY4PgKu3AEvCaIcqYCwgCuPssD8y4IYlXCtmmhgdzwmAXKA7AgsJ8rHJA==
X-Received: by 2002:a05:6a00:4b4a:b0:747:b043:41e5 with SMTP id
 d2e1a72fcca58-7480b4b34c7mr5103931b3a.16.1749059028457; 
 Wed, 04 Jun 2025 10:43:48 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeab109sm11418482b3a.40.2025.06.04.10.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 10:43:47 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v2 3/3] target/riscv/cpu.c: do better with 'named
 features' doc
Date: Wed,  4 Jun 2025 14:43:29 -0300
Message-ID: <20250604174329.1147549-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604174329.1147549-1-dbarboza@ventanamicro.com>
References: <20250604174329.1147549-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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

Most of the named features are added directly in isa_edata_arr[], some
of them are also added in riscv_cpu_named_features(). There is a reason
for that, and the existing docs can do better explaining it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250529202315.1684198-4-dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c1bcf60988..758f254c15 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1378,13 +1378,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
  * 'Named features' is the name we give to extensions that we
  * don't want to expose to users. They are either immutable
  * (always enabled/disable) or they'll vary depending on
- * the resulting CPU state. They have riscv,isa strings
- * and priv_ver like regular extensions.
+ * the resulting CPU state.
+ *
+ * Some of them are always enabled depending on priv version
+ * of the CPU and are declared directly in isa_edata_arr[].
+ * The ones listed here have special checks during finalize()
+ * time and require their own flags like regular extensions.
+ * See riscv_cpu_update_named_features() for more info.
  */
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
     MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
     MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
+
+    /*
+     * 'ziccrse' has its own flag because the KVM driver
+     * wants to enable/disable it on its own accord.
+     */
     MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
 
     { },
-- 
2.49.0


