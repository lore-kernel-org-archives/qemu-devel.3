Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C408D107BCF5
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oCt-0002Hu-Ji; Wed, 18 Mar 2026 06:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCR-0001mL-BP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCP-0002S8-NX
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48534237460so71648395e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829943; x=1774434743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4X8QUwZ5Pf3fdspvylPT4Qw/iKJaj1fEYrwcUzYJwqY=;
 b=FTZjA0GFcu66bdx2hNkfPyFGy/SAuChcxMPn/vA34jATnhBMypPjErg/l8p4jEFdKs
 hNbqWlReaVXxlY9uabLKC5p7nhy4EtL5wb413U9uYzdWPGis2eA3YrL08oyNK4mvToN2
 FUUVGcesxWV2XELhutIZB26cJaVU6xdprt3JbhToMTIU6HmhV6X0jVXCs/mPKcLzI/IE
 0AqjfrQtE1rJ0KZ/WqwOev3aLuKi6r+mXZ58iteytkwmbv9YeSCREyvFW8uJVeTZNCzx
 4eAw/VDULE9uZD9rmhebrsiwtK3LgDszMs6DSU6NYIcdjuzNbnbZoQldEITxlktCYSIA
 sXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829943; x=1774434743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4X8QUwZ5Pf3fdspvylPT4Qw/iKJaj1fEYrwcUzYJwqY=;
 b=HTMwFx+3vQE5okCskNQRNbGeTwe14mnHn8A8Aw+FBaBGq1gl9bt3easkHOtZeAGbCu
 Q1Fvq270DkRdukGotkKDqa+OwDTWNBZuyz/xFviL3H7SxxUt3WlJeO8M4sxjCop3PzMX
 VbOnibTzhMOg2RvivPGFnxDksA6MQ1yUEWFRgqjqYi+Jf4upRkrB59dB194olXfohkHw
 WAvY1JEkUf4Bpr8ygQUPPg35JHQoudDBpiLnePVDy8zlKl5T9YGlKRvhX4uMbEHNF5LJ
 Aa5wJZrWNYMKUKd6mDL4vLwzRM7vlkDD0cuhlAZrypEzwzlWe41OXp7xd+MOm9po5bNZ
 X1fA==
X-Gm-Message-State: AOJu0YxdsUYFRqoNP6vsKZUv887f+xoa7TcCZQeHcPpjdS9IHswROniz
 d+JhDlmj7cDYSLSl4FQ9B/z3x4lBJDDtZDY2VTpDRFjqViB4oQAcJE3dA4Sh5RjeXbgvpgNZdv7
 KaUlI3iY=
X-Gm-Gg: ATEYQzyI6PW8X5IM3WOChf0TC6BurxET99QGGbx/NAXFazGPyuxmcFTw5Fh0APxJeLT
 hgNFT8MNiM1zYfaqagAiwEfESnOpgVKmPWksRhWPAgtoewmwH/a0p8ubLntLTo0SqQtmmt3NiTY
 p5pDgVhayjq68HOCdgv2IQRbfzjtLOU/bPtt/T2vQf//szmTPxma6hBwxu+rcgaqwp+vDaKKmFr
 yzAZZwDpjrxXepxxyhp6tbXPuUQgdIaCHOOaktCWfIasgxl79P0LDAA1Pzfv59Cfw4L8va01DVp
 /gZ69frhVq6Zxv/IN5u+a+Gaqo3NbUAoXPJRayyvfdtCWVAd0FBFuLTB5g2r8ikmE75TNeHmnq3
 kZs2uDPNGqvCiEH4+xAVpeHyi7+G00ru7bbu7OUpWTSG69OikzOP7tEpu0Dnc2+5akKR94GkHsi
 lc/T+b6PTwGg3FxKpVT+FqQq1teNeX+EjH0HC7jfsHkJyEalGOH3U5xLdUsA0nv2ohehgQAujc
X-Received: by 2002:a05:600c:450c:b0:486:c4f0:1a37 with SMTP id
 5b1f17b1804b1-486f4457a6fmr47173145e9.24.1773829943293; 
 Wed, 18 Mar 2026 03:32:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518a3e3csm6259754f8f.35.2026.03.18.03.32.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:32:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 08/16] target/riscv: Simplify
 riscv_cpu_gdb_write_register()
Date: Wed, 18 Mar 2026 11:31:13 +0100
Message-ID: <20260318103122.97244-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Use a single ldn() call, sign-extend once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Note I'm skeptical about 128-bit registers path, but this
would be a pre-existing issue.
---
 target/riscv/gdbstub.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index be42566bcc8..a5c12638782 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -84,33 +84,20 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    int length = 0;
-    uint64_t tmp;
+    const size_t regsize = mcc->def->misa_mxl_max == MXL_RV32 ? 4 : 8;
+    uint64_t tmp = ldn(env, mem_buf, regsize);
 
-    switch (mcc->def->misa_mxl_max) {
-    case MXL_RV32:
-        tmp = (int32_t)ldn(env, mem_buf, 4);
-        length = 4;
-        break;
-    case MXL_RV64:
-    case MXL_RV128:
-        if (env->xl < MXL_RV64) {
-            tmp = (int32_t)ldn(env, mem_buf, 8);
-        } else {
-            tmp = ldn(env, mem_buf, 8);
-        }
-        length = 8;
-        break;
-    default:
-        g_assert_not_reached();
+    if (env->xl < MXL_RV64) {
+        tmp = (int32_t)tmp;
     }
+
     if (n > 0 && n < 32) {
         env->gpr[n] = tmp;
     } else if (n == 32) {
         env->pc = tmp;
     }
 
-    return length;
+    return regsize;
 }
 
 static int riscv_gdb_get_fpu(CPUState *cs, GByteArray *buf, int n)
-- 
2.53.0


