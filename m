Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C5CFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwrH-0001M6-1s; Wed, 29 Apr 2026 00:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrF-0001Kt-E6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrD-0008Lz-Qf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b9705613ddso16498695ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438146; x=1778042946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvgZDDVcfV8DLmoSwqxj+6lV+VN16zkZ0t0yAAk4yH4=;
 b=R2uXS83b7aVfhSyZLH/hmDazZiuLInWzeWuedNA8PS3NxjRERE3pI9V2fkHl/Qom4l
 1Tcv/PN5yYV5NAPnyVHg7pAimUtQ6NToOIxK4OLVU0LzuMxW8qIfWaJUH/SWm4IiNjhT
 HG+deM9YpjXk5LrYubl+wB5MwiPY4+PXboAgtDYxJES0F/31Hv0OuYhN52yAxGSm5U+U
 JVNeIpSoDlFwV5S2GmTwix6mQZfM5VTkgCpvkW3XlUyYrJHTx4Q2lWDsZa8vIZp2pOcT
 yaWg9gkIgC6XsKUY1+0F8dIxuoYTkzZZGaxnTT1R1KVhhD2QgeSg7oEGskBFnNsh1MRx
 PNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438146; x=1778042946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CvgZDDVcfV8DLmoSwqxj+6lV+VN16zkZ0t0yAAk4yH4=;
 b=JibmKz2P4le6Jcdv9Yc7fvWzyndNPER+pJoiqn4YN02LPTuiwxh5QJ1ToavZkF8KUb
 fZ7FVifr/3bE5w337Gw7ZZwWM9jPlRRW1RDXt1OzhOF+e/n1eeulx02R0CRMtXbRnhbG
 rEE2+d03fpPtW4As5ByArWdJ3VJwe79FX3U4b0t9LmGpeKHCXGCH3lPQJc1SteBSNLwW
 PIGF/xXzPqZHDMdX0eJY1bK8U2l/pE/YjJ9LyrqDQjwC0dV862GiraLdcdvXZHBO3t7o
 E+Wy7zjALbYQIyxAPK+73XCchYxhWG/SiCdLzLNrGsxjIN7Niia7ak6n+ht/zHDkUfil
 yRVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+hkydnOXpUa5dxsZZull3IOHdQcKZCq8pZ3yzoyrwVIsNolCt0pZu1P6mslAdR2sjB3eF7ggr4y+L@nongnu.org
X-Gm-Message-State: AOJu0Yzbiotu8ZPP12yssWo4TDRPXTqygd7V4GSSVRwP38azu2fDE9PW
 1mAdHaiRHHqbwX3LIFU8ONDwHQ35OKgwE54EXf0bcVnzCUaglwwQBV6i
X-Gm-Gg: AeBDieuyWMd6MIQcCQ7TRWhXlwFMz/OYdUKUsS0NSRHaFJ65n9K8Rs4cG/Xaro3yZ27
 4Bp9PoYoSwYqNVtoWs+gTCmksKEIeW/6gXFjNVxNr1u5SrbBJUvj2p/d997TJzgBDTcdKtO8Ezl
 nUUS+4iF/BkmZwyYmkxStA0Y0nLqhP9+0VGtESv31Q1IISa/u5x4u4fNgyHDDpd4A9KEJXn103k
 Kw+4295A4p5GwhF2kF2obTgtjEPHTAfWG0KfHnq8ykTBS8M52hmQ9Au3l8WUXGUL1jhB8Jt3oyW
 AmgWrEGAtrSdmZYvFD0QATKNeatnz9/ZC5ShUuo7UI2ygm6aAdFc0gSD5aCfnHPmP9Kf+nNGFI0
 RxZKsxC4yRX/WmOBRHPLiDRYuSGLmHsECEoqzugmQwG+H2M01NsS9fxKaiER1LM2eO9ut55PqvY
 QTJnyOIFDaaPr+3iGMnt5HFmndMb60JmCbtCSevxM/hfSAHB7VXcSq
X-Received: by 2002:a17:902:eec2:b0:2b4:5f67:5914 with SMTP id
 d9443c01a7336-2b987442b4fmr16318365ad.33.1777438146530; 
 Tue, 28 Apr 2026 21:49:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:49:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/51] target/riscv: Simplify riscv_cpu_gdb_write_register()
Date: Wed, 29 Apr 2026 14:47:12 +1000
Message-ID: <20260429044752.4176397-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Use a single ldn() call, sign-extend once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-9-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/gdbstub.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index be42566bcc..a5c1263878 100644
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


