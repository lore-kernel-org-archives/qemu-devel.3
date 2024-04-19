Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F840C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 11:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxm3X-0003Ah-5y; Fri, 19 Apr 2024 07:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxm3U-00039G-QC
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 07:05:20 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxm3T-00017n-23
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 07:05:20 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3481bb34e7dso1068299f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 04:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713524717; x=1714129517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KdTZXTwvt7Tibj/dR564Jrh2V5NCXVN+EQdPOip61Ds=;
 b=Mzq06ahm+tSV8vLYUKsmHYnTvan1asKQaU20iU7wQC02nvrD+9xiVepS1baLLcMZJs
 I1O2ATu0iTP5l5faz00JqlgPfy0JsyuOXAgLPZGTpvjnUQhYj61ZhtPVBpQIqRsi0M/a
 MpoipAOEbGnN4umKFmyaoqxBc8Efm1QPIxS5+EACDiqQXOf9rsHZFszisQFdBeFlCj7p
 QALekJx8I6YsKlPzqjWiZ3wzYa58/z6hYF4m8XfaCNTkjUjrXzfyR0MmWs+MQY99JcaV
 U5YCFl6NJjudz5k1ZA7a9HNXI+O4nqnTYkeC3aGauTfSRU9Is2/gChFpsuYl7DRmtBkh
 JHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713524717; x=1714129517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KdTZXTwvt7Tibj/dR564Jrh2V5NCXVN+EQdPOip61Ds=;
 b=RbV+0fwBvKH7dTQ8yKrZ2BWcYaC2TlMumPhQ+e0kzb07tSKr6daByl7DJQpGGNyN+6
 27bmUMVOh5bkkymupafHPorKYYRynDJXzBoJSDy/hCyyEy2XHjClrYD+uT9xHCEP35Ee
 Qu/f72ItewSwk6iO4+HmuQ4KHRHgmYMithTfIE92PYBM7V50j0AoWdWIt143ZR7ZXTXi
 Fzi+qkVlVWblJ5gkTAzy5QXj5W9zC+qIew1RGRfTvg99xnLvkc6CGicHwcXQSLC/sjId
 vRXuLRjy/bHYyHYMgxtrBqbTbmuWi8mCzJC87JWVhaynCNfKhPNjc7OJ82GrgwmPZPcT
 AZ9g==
X-Gm-Message-State: AOJu0YyjZ8TIdqHzSbPLZUV7iIC1JQQmIAnvwV7tXEg8MEpeoCG6Jv9h
 ksHaZbq4mFzVZTWkgyuyN/0FZt8fiWmVVKwzBaMfg04akuScVATF0hY01xcHZT9Ykfvinma5NgU
 Aok8=
X-Google-Smtp-Source: AGHT+IGiy1TVh0xMAzDpaojJeppcBKmnVT0SZZgiwJRz+atx2xE9SH+bPfDcRcRLgcjUcVJhTk8oRA==
X-Received: by 2002:a5d:64a6:0:b0:34a:65c8:7413 with SMTP id
 m6-20020a5d64a6000000b0034a65c87413mr1048059wrp.30.1713524716913; 
 Fri, 19 Apr 2024 04:05:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.143.233])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a5d6383000000b00341b451a31asm4159105wru.36.2024.04.19.04.05.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Apr 2024 04:05:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <cmuellner@linux.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhiwei Jiang <jiangzw@tecorigin.com>
Subject: [PATCH] target/riscv: Use get_address() to get address with Zicbom
 extensions
Date: Fri, 19 Apr 2024 13:05:13 +0200
Message-ID: <20240419110514.69697-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

We need to use get_address() to get an address from cpu_gpr[],
since $zero is "special" (NULL).

Fixes: e05da09b7c ("target/riscv: implement Zicbom extension")
Reported-by: Zhiwei Jiang (姜智伟) <jiangzw@tecorigin.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_rvzicbo.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/insn_trans/trans_rvzicbo.c.inc
index d5d7095903..6f6b29598d 100644
--- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
@@ -31,27 +31,27 @@
 static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
 {
     REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
+    gen_helper_cbo_clean_flush(tcg_env, get_address(ctx, a->rs1, 0));
     return true;
 }
 
 static bool trans_cbo_flush(DisasContext *ctx, arg_cbo_flush *a)
 {
     REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
+    gen_helper_cbo_clean_flush(tcg_env, get_address(ctx, a->rs1, 0));
     return true;
 }
 
 static bool trans_cbo_inval(DisasContext *ctx, arg_cbo_inval *a)
 {
     REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_inval(tcg_env, cpu_gpr[a->rs1]);
+    gen_helper_cbo_inval(tcg_env, get_address(ctx, a->rs1, 0));
     return true;
 }
 
 static bool trans_cbo_zero(DisasContext *ctx, arg_cbo_zero *a)
 {
     REQUIRE_ZICBOZ(ctx);
-    gen_helper_cbo_zero(tcg_env, cpu_gpr[a->rs1]);
+    gen_helper_cbo_zero(tcg_env, get_address(ctx, a->rs1, 0));
     return true;
 }
-- 
2.41.0


