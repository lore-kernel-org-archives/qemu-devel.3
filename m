Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDDDE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 05:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUfuG-0003mi-LP; Mon, 06 Jan 2025 00:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tUfuE-0003lu-Dm
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:44:02 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tUfuC-0004KO-Pp
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:44:02 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so254013375ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 21:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736142238; x=1736747038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8m78Xl46ptOhKZOofTQdhh1EfKppuOWG2YufccK/Go=;
 b=W7CEnJuLZ7cGPPKoyWRvdWRIrPA6Oi8kOkCnUByQ3HuAc7+pBhw5He7qq3A+vFxUVY
 lIx72Dfa44DqJDUNw+ob2F9uuhtmP3SGhbHHPnkv7pKfKUW6QKL46HrCFiHFkvquxq9w
 Lj/33M41eym1KMRBkhM1gzfFcY1nrgx2D55YJcmqL8lTSJgP/bkI3rIQVf62lW9wSS53
 3Ec59t52vN8UxMn7snASlialy73tde/GesDXrJFsW9PNCYFCrIzfQT+fNRDcrJRcoJXr
 H35d9NH7zxQb0gb2jhwOxZrggEl1V3G0d9tfvcYy1MPpPYJ0ECm0LCVWZ4hexQy6l90N
 Zyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736142238; x=1736747038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8m78Xl46ptOhKZOofTQdhh1EfKppuOWG2YufccK/Go=;
 b=SjXrI7AyQJOguz8fk15j339PTog4J8srPiIiC+940yPPJ622wt53l26P68h+2ryxfz
 IRWH8ORc4KzyL5Tm/kjaMONPNClfN0mtuxsb2Vo/HJ/Q0vCiscQJq5gk9W58cluWa3Ky
 WP02/UuHfUBLRqIcyGSHJfOjzxWtveP8FtHm89o8NJQdO9NkzVGQ29cESjIWZGBEYAlm
 Mpbn+GJTyT2TyO4PtKFUVTHm7Uh/63hulzs2dh9zlvuwU4mW/e2KIMQ1jVPXeQeoPveL
 eajW95QOhZQUvkN2uo5YDKWxguaDPHuVpFxsnP1uZHhmWSvnW6nmi/zi8W+xNJezm0sf
 wxdQ==
X-Gm-Message-State: AOJu0YwEubSDlnRKZAm8JSRiZRLptcrhqYDaFTJME0vpESQ6GZhHZWcL
 VUf4YqkR1GCGkgkj2R2kGcjOnt7s4fnxyAv5FMWLNabU7CqIv2Q9SFGrovwNVMWnfglISVP09gZ
 JnoNKXjNlqeO1yDNn/6Z37nx/Zm/3PLiZ9XGe1HDPHNvEw4/Vvo7gudFLlTPC+xmdWV5QnjFglW
 lRMWSbWmIrnfLriSOuwdNqlcuz7WqAdHat5KffMaiR0g==
X-Gm-Gg: ASbGncuWCZWVBPeGX4yAK+LSoz54b4nfKtuGj7r8pRrtfGkmq7vPJjG/L5OfNXDc/eY
 ZdTioFn9Uat3HYNNTcpdS3ITj12RxIIOIuAiyYNX9lxxnWxBRnNo39QfEHcInTtus9+TZ68OjG9
 GVkhxZ7yv2zRMw13q5ispLXpOeqgwgSovycY0XdJzCvaXruOnYkjn+3bv5kqfxCKPs6Q6jyH+OE
 PfQ1tO+7ZFaQa5JDKMzSG9zcEs0vKBzXNPwXDuD/k5K3qylEZGHRfX5wyBvMcbx6EeGWMVxzIPV
 JCXZC2D9Md8=
X-Google-Smtp-Source: AGHT+IGdsUM0by9JB8swIeXcXINa9alfU+PpMt1KUpX4njEQWM3cyOwD6Y0UtVVurjuq7zAvIknuZA==
X-Received: by 2002:a17:902:ea11:b0:216:4016:5aea with SMTP id
 d9443c01a7336-219e6ebaf1amr850553345ad.29.1736142238328; 
 Sun, 05 Jan 2025 21:43:58 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([210.176.154.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eac6sm285722215ad.80.2025.01.05.21.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2025 21:43:57 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v12 6/6] target/riscv: Add Zicfilp support for Smrnmi
Date: Mon,  6 Jan 2025 13:43:36 +0800
Message-Id: <20250106054336.1878291-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106054336.1878291-1-frank.chang@sifive.com>
References: <20250106054336.1878291-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x632.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Zicfilp extension introduces the MNPELP (bit 9) in mnstatus.
The MNPELP field holds the previous ELP.

When a RNMI trap is delivered, the MNPELP is set to ELP and ELP set
to NO_LP_EXPECTED. Upon a mnret, if the mnstatus.MNPP holds the
value y, then ELP is set to the value of MNPELP if yLPE is 1;
otherwise, it is set to NO_LP_EXPECTED.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 11 ++++++++++-
 target/riscv/op_helper.c  |  9 +++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 17787fd693..be9d0f5c05 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -643,6 +643,7 @@ typedef enum {
 /* RNMI mnstatus CSR mask */
 #define MNSTATUS_NMIE       0x00000008
 #define MNSTATUS_MNPV       0x00000080
+#define MNSTATUS_MNPELP     0x00000200
 #define MNSTATUS_MNPP       0x00001800
 
 /* VM modes (satp.mode) privileged ISA 1.10 */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e90b85f2cd..8a31b9fe7b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1918,6 +1918,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mnepc = env->pc;
         env->pc = env->rnmi_irqvec;
 
+        if (cpu_get_fcfien(env)) {
+            env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, env->elp);
+        }
+
         /* Trapping to M mode, virt is disabled */
         riscv_cpu_set_mode(env, PRV_M, false);
 
@@ -2085,7 +2089,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         /* handle the trap in M-mode */
         /* save elp status */
         if (cpu_get_fcfien(env)) {
-            env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
+            if (nnmi_excep) {
+                env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP,
+                                          env->elp);
+            } else {
+                env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
+            }
         }
 
         if (riscv_has_ext(env, RVH)) {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 63ec53e992..a4b625fcd9 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -402,6 +402,15 @@ target_ulong helper_mnret(CPURISCVState *env)
 
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear mnpelp in mnstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mnstatus, MNSTATUS_MNPELP);
+    }
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, 0);
+
     return retpc;
 }
 
-- 
2.34.1


