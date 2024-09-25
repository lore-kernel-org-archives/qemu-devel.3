Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EF1C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stQfL-0006TD-HL; Wed, 25 Sep 2024 07:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1stQez-0004x7-KK
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:58:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1stQex-0000hM-Sg
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:58:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cc8782869so63360945e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727265498; x=1727870298;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLp4r6f6llKlFkIQR3exhrK8GnjMUvUuiR9NnPTHniw=;
 b=tr9Ll2K+UIe7W+r4zlwxL/8997NPGEKHcTlpQTQ9bXfQrZzZsNeRbH1I2suTSQ+SbM
 RGzh0ZeWeMe/xZL2OZC+HuGv9DUGF/HiDgnkFwoRfc2pJbWqSxp2SiqST1pD3dJjv1FU
 WAfQ/iBmkaWCTJnIjl3f7yf83KbPCrmnkeT70q4LTxSVKO0uaA6UqCxSBds2mNq9EaTc
 j31I3JnlBOwhWsE+UJdA/m3GYNig7N0yKuPayVGzIROaF0HyrVQt0dRxiieHKQPqNAeP
 0nTYm4EzGGsTfvGWtiUOeQ/8D+kFdaMZog+6CrHrbQ8XKpmld3UUDVbzxL2r5vZtz/kO
 2TqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727265498; x=1727870298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLp4r6f6llKlFkIQR3exhrK8GnjMUvUuiR9NnPTHniw=;
 b=mh2/tiPuBG3KQWo+i1oV/ray+yDswE5Lcbr6dTB93sBWTQUxsPRP/MyBp8qcTWo9ai
 O+MVuPWq/oGWftZ9Gb/dJJ53OP/+SmMgzm6h85j0REeHFEF8XZ/6hFv/Xja9C+CUpsC1
 bSxERxUqC5/kYN6mlzbyu/X3+4EZwD3Wy7hpX+c5cPGA4TOX5ETo9s8JUmT2QURIATCg
 3Ua5oJLRHSyMbCUYlrAubc/P26LNRV+t3BhH0ogdBZPG+owSeC5A/hAtbpJgRn73HPtq
 inV+MrzxP7WY8ikfxxg26fwIBikdvsno93dGUnTS44k1DIfliJHt6tfb1f9+O14dqm1M
 R/fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWbGb1fyqGJbFcJC4Duf0q1V1jyjyo6CsgtpuGxDC+eVdAdNUC6SKwISdQ5x5JvHMMWuauCS4gi2vh@nongnu.org
X-Gm-Message-State: AOJu0YyNGQw0ydHOyiqVVIr2dRkPaaMby/QcQByU4hUVCNCJ6QUkucZU
 hN4iRxTYfskLyVtuLMRIKV4f2YqjGmK6LumC+kZ72s5Uo4DrYH054lJo0k8ufTU=
X-Google-Smtp-Source: AGHT+IHKqPc9p2/O584BuP3ebW5u3ErBbdh9i5quopYR0uBvuPQkalMvzpc9XtGPQyh3L+bndD2CeQ==
X-Received: by 2002:a05:600c:1c0d:b0:42c:b220:4778 with SMTP id
 5b1f17b1804b1-42e9624123dmr18250875e9.33.1727265498424; 
 Wed, 25 Sep 2024 04:58:18 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2ab52fsm3770612f8f.13.2024.09.25.04.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 04:58:17 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 6/8] target/riscv: Implement Smdbltrp sret,
 mret and mnret behavior
Date: Wed, 25 Sep 2024 13:58:04 +0200
Message-ID: <20240925115808.77874-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925115808.77874-1-cleger@rivosinc.com>
References: <20240925115808.77874-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

When the Ssdbltrp extension is enabled, SSTATUS.MDT field is cleared
when executing sret if executed in M-mode. When executing mret/mnret,
SSTATUS.MDT is cleared.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/op_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 00b6f75102..9d0911f697 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -299,6 +299,9 @@ target_ulong helper_sret(CPURISCVState *env)
         }
         mstatus = set_field(mstatus, MSTATUS_SDT, 0);
     }
+    if (riscv_cpu_cfg(env)->ext_smdbltrp && env->priv >= PRV_M) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if (env->priv_ver >= PRIV_VERSION_1_12_0) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -375,6 +378,9 @@ target_ulong helper_mret(CPURISCVState *env)
     if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
         mstatus = ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
     }
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -416,6 +422,12 @@ target_ulong helper_mnret(CPURISCVState *env)
         env->mstatus = ssdbltrp_mxret(env, env->mstatus, prev_priv, prev_virt);
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        if (prev_priv < PRV_M) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, false);
+        }
+    }
+
     if (riscv_has_ext(env, RVH) && prev_virt) {
         riscv_cpu_swap_hypervisor_regs(env);
     }
-- 
2.45.2


