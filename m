Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E407C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJrv-000135-Hs; Sat, 18 Jan 2025 20:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJrt-00012Z-NG
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:12:49 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJrs-00038m-9Y
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:12:49 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ee76befe58so5795436a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249166; x=1737853966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPHsueaOT0a7n8Avkp+AlyLkA7DW96RFcdAuFjHGVlc=;
 b=kNAc8yJS0oYGpqD5NxJ0CWar7Q4UD4BzFmmcKjkyTtUCsSzqU3bZqBtb5vFZx6mV1o
 /wgX4l7PEA+VSxEwymYe0PjROABEWj4INJku2pB+roxmAOohPuTf0IGhOi0x3C7PFhE3
 1MKs3F6Dob2a1b+hv6RhSKYgUhGXArA5hMIPOkmnt9VGkdSH0E1VSS9MYxzpjdS7hKa7
 JMlKHkkr+LxYqCKLdaxzsUs1Nh38odsE6p0k+FbI9rW1tEn2pgQ5U7bDkr1ehb/7sp51
 FO4SRuQTBhVQhoqqNmB4VQHCuufu1HCL/yr1PpPFDqQEcqucbHOx4EQOZw9vwAOvkW6r
 CCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249166; x=1737853966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MPHsueaOT0a7n8Avkp+AlyLkA7DW96RFcdAuFjHGVlc=;
 b=lNXqLBjfh7ivxFc3GvKzhzpzyTX5HlAlvJ0p0uupyySaVjzXbjnZMBvacKuaP+U49P
 SOTMeXNeLPKsISTCfMyWK4Qd66essrQLIJeft1D8oMSZhD179B9w/8Hg2Nya+YVZ3n/s
 lFel//OqIlnFlBqzmZYAx9016lyYbhHADhaUMvQYBYletjzW2JnGX5hXRLOhZQ7Elq3f
 Jcc2ykCnoGrLCZNq6etyomrPvLs38HiGloNk3PF3qIlvqojJpYjKp6ZFLFX3S9cvpCKa
 WrKpSgpUYzcw6M7844FCV/vX3xUwakHg14yAgxVX77Cpdy+WaEvbgpFb/awgBxFoWaeh
 AGcw==
X-Gm-Message-State: AOJu0YxpWjVIyTR+7C9xlxJgmRelim2okvKtjYSJhwLvgR0h6hb2eXfT
 F9WdQTPSIsm0h1EuODNiI2Tr6qc6LKWde1fduQ1lIW3G6+7HjPduqzrz8QBn
X-Gm-Gg: ASbGncsaHz8QBfEfLzX/PiTak7djdouZ32dLBC+gaLyGWwgmk3haEERw2CRbFkmEEut
 vKypCTIB2cmdk2DJAT+LrqaPXxn+q29nssDS8VS/JIKLhHZiCdG40zptvbPyb6HSmg/VMatSJ5o
 V8ltE+ReGhRMpYQXYI6rmDJhrDJyy6W7rM5AJ39jdTeKMVZRW1iF60HmNhUJzys6TLKSEHdw2lD
 wldRZgsGI2/opluCP7R0ewQc4DeTZ6wjwIYAXj5x2U/pBcohLBv+szmtUHm8WxL5IOcveUyjvTQ
 uxaJEDPV+SuHWar7qrFcknfA/iZCPtN1Oz3e82vdnlkD/7vzavc/Pq+peOHveucPkFaoFqhf3A=
 =
X-Google-Smtp-Source: AGHT+IHBP/Xc75bkcu5rtG2Nt8FrC2E4ClVMbluMI2t+G4INTe4U2n9sscaCgT/zXuWGt5eoYoRd3w==
X-Received: by 2002:a17:90b:2c83:b0:2ee:c918:cd42 with SMTP id
 98e67ed59e1d1-2f782d4eea7mr10295572a91.22.1737249166639; 
 Sat, 18 Jan 2025 17:12:46 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:12:46 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yanfeng Liu <yfliu2008@qq.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 03/50] riscv/gdbstub: add V bit to priv reg
Date: Sun, 19 Jan 2025 11:11:38 +1000
Message-ID: <20250119011225.11452-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Yanfeng Liu <yfliu2008@qq.com>

This adds virtualization mode (V bit) as bit(2) of register `priv`
per RiscV debug spec v1.0.0-rc4. Checked with gdb-multiarch v12.1.

Note that GDB may display `INVALID` tag for `priv` reg when V bit
is set, this doesn't affect actual access to the bit though.

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <tencent_1993B55C24DE7979BF34B200F78287002907@qq.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/gdbstub.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index c07df972f1..18e88f416a 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -213,7 +213,10 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
 
-        return gdb_get_regl(buf, env->priv);
+        /* Per RiscV debug spec v1.0.0 rc4 */
+        target_ulong vbit = (env->virt_enabled) ? BIT(2) : 0;
+
+        return gdb_get_regl(buf, env->priv | vbit);
 #endif
     }
     return 0;
@@ -226,10 +229,22 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
 
-        env->priv = ldtul_p(mem_buf) & 0x3;
-        if (env->priv == PRV_RESERVED) {
-            env->priv = PRV_S;
+        target_ulong new_priv = ldtul_p(mem_buf) & 0x3;
+        bool new_virt = 0;
+
+        if (new_priv == PRV_RESERVED) {
+            new_priv = PRV_S;
+        }
+
+        if (new_priv != PRV_M) {
+            new_virt = (ldtul_p(mem_buf) & BIT(2)) >> 2;
         }
+
+        if (riscv_has_ext(env, RVH) && new_virt != env->virt_enabled) {
+            riscv_cpu_swap_hypervisor_regs(env);
+        }
+
+        riscv_cpu_set_mode(env, new_priv, new_virt);
 #endif
         return sizeof(target_ulong);
     }
-- 
2.48.1


