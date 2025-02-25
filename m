Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E213C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 16:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxOc-0008FW-98; Tue, 25 Feb 2025 11:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tmxN0-0007GC-8S
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:01:18 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tmxMs-0001x6-OY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:01:17 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f378498b0so4818316f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 08:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740499259; x=1741104059;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+TDZqvkgY5ij9r5M1+7oHx+8x9yD312lxwT4tfm9xs=;
 b=g1gWvKoLoF3LrzWYtMRWXtvDwqn2+uDWG7OZIf4VQbAPwRow8z4V4ZAtbTT/O/bLq4
 XkJZCo5fBjWYkBQU4NSFgOWXJglWcnGh0FgCx9KFLUAroZf64vSFJM90wNhgrv8OD8CJ
 MDwfvF1xdus6bk6erII0dBs+Bgyo3qhidwqrHfSquJWVkMkZML08hd+Q6wrP2UGpFMG4
 Zh1nR76L+56vcVraCH57I4AUP29lhucbUpxADgnfUbwcjvBAPdJjON37n8qU7jIcurFo
 NhUHW412ndoJsue6qwCmGXKWB2NZQI5VnveitVj/v7c7cmSIsbIQo2AW8XT1JyfnmtCa
 8Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740499259; x=1741104059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+TDZqvkgY5ij9r5M1+7oHx+8x9yD312lxwT4tfm9xs=;
 b=wrdESecqgl0wtCxLVzNNYU8zQ8OgmGuvbbUtXrO3KXpFdXUF2JMUMS5JwIX56NC4iz
 pwYwD/wU1c4JK7h9h6xjIIQFhVPEiurOGdGBzel1GAf6J9BUxYpnKhJY2Zm6SDZZ84Gx
 n9Y1+M2B+zdJXECbN80VmQLwANYPMRtx446rdLml09q26JLcp6uiUXhJUlYx0LjsiJJd
 7TqqK2ItQGW2MIOjvvHQPhZsHH4eGRXGol/dNMjtdD5qk3XXNpriKPrOf0ntRfZuovzp
 MJxLNr/RhWeMjA2mSUkLwRDT9NvpD2Kbj1ad+nWsoO5paBBzK9UjW8hw81qwLbsFDfFp
 DdZQ==
X-Gm-Message-State: AOJu0Ywvqq9RXh/hSkmz0JgA7mMXkLJsy1lxII0fP+uVp6bGFTBdhNiC
 3LPbEsQNwav3BpzVAx4PfPtTPr1wRBdpO/QF7oJ1OjNU08RtgnNGto8z4+dvUpGCE0jWaoaJQR2
 oI2JpaZbQ
X-Gm-Gg: ASbGnctOCJhkNuIbN0nG52q2VBQ4LIBEDkOOdBqd5v6/oVl6vbBlVJRU60T67XCst5K
 7Q/p560ukYGYh6J2r4y/hH+CuCvMSm1rqVSfXSm1b82CcXjCaWLFrZWsRSd/kl4c6jZZM+cu42y
 7ZVnWJRuKSuAlwLV15JNb3FPGYe4brjoYRDrV0YnlS38zZ+0mWUuXr+wWEXIQa2iDig4lGk/lmO
 jAo9byUY/INlVmveTUynrNH7taZLLYDKLXOyUs7CzI8LliJiV3UNaWhikghCrWzIq+92lBi0lIl
 zh1PPLX5+sQmJ4uuwzuXIZyWnLIdSsYF4wNfQgEgJaWzhvsRE7cYtP9m54Bq8iFlWCNZhq+J3A=
 =
X-Google-Smtp-Source: AGHT+IHuIaJbWn54WqI7K/p5z1g0TwWQC/jpTrAVwCWtLU3+79KsYmrITHDvEGCsbZgdBCDLL7WoLA==
X-Received: by 2002:a5d:59a5:0:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-38f6f0c3b6fmr15386446f8f.51.1740499259008; 
 Tue, 25 Feb 2025 08:00:59 -0800 (PST)
Received: from llx1.cad.pilog.net (lfbn-mar-1-50-94.w86-229.abo.wanadoo.fr.
 [86.229.28.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab1546df4sm30530755e9.17.2025.02.25.08.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:00:58 -0800 (PST)
From: =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
Subject: [PATCH 4/5] target/riscv: pmp: exit csr writes early if value was not
 changed
Date: Tue, 25 Feb 2025 17:00:51 +0100
Message-ID: <20250225160052.39564-5-loic@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250225160052.39564-1-loic@rivosinc.com>
References: <20250225160052.39564-1-loic@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=loic@rivosinc.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
---
 target/riscv/pmp.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index e0ea436f8e..e4fee10d93 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -141,6 +141,11 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 {
     if (pmp_index < MAX_RISCV_PMPS) {
+        if (env->pmp_state.pmp[pmp_index].cfg_reg == val) {
+            /* no change */
+            return false;
+        }
+
         if (pmp_is_readonly(env, pmp_index)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ignoring pmpcfg write - read only\n");
@@ -528,6 +533,11 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
     bool is_next_cfg_tor = false;
 
     if (addr_index < MAX_RISCV_PMPS) {
+        if (env->pmp_state.pmp[addr_index].addr_reg == val) {
+            /* no change */
+            return;
+        }
+
         /*
          * In TOR mode, need to check the lock bit of the next pmp
          * (if there is a next).
@@ -544,14 +554,12 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
         }
 
         if (!pmp_is_readonly(env, addr_index)) {
-            if (env->pmp_state.pmp[addr_index].addr_reg != val) {
-                env->pmp_state.pmp[addr_index].addr_reg = val;
-                pmp_update_rule_addr(env, addr_index);
-                if (is_next_cfg_tor) {
-                    pmp_update_rule_addr(env, addr_index + 1);
-                }
-                tlb_flush(env_cpu(env));
+            env->pmp_state.pmp[addr_index].addr_reg = val;
+            pmp_update_rule_addr(env, addr_index);
+            if (is_next_cfg_tor) {
+                pmp_update_rule_addr(env, addr_index + 1);
             }
+            tlb_flush(env_cpu(env));
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ignoring pmpaddr write - read only\n");
-- 
2.47.2


