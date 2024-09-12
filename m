Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C247EE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPn-0001Zp-BF; Thu, 12 Sep 2024 01:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPh-0001Iz-TX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:41 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPd-00030n-VS
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:39 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7d4f85766f0so540805a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119036; x=1726723836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQLh5favEwPC3T5JVQV5e7WmeMzusKhuamksZ0+89Yw=;
 b=ELnY/SiWY4mDP3e5v58iwVw5P/xV9xMwCy/lVT0FguNJk99xswxzmd1BK2FGL7P0f4
 ObKPtbPC8O/y87bx+bX8JT1NKdGQIJjrRWqLxvCvmiqALrmc3VLDPpJzWGmh1J75eYBt
 //AwHuybbPajPF1254ExTaFBemgO4AUPF6pKvUngtB9jtJkd6b6aEBoRgjSg/l7ujuxh
 CQGgsRMQsh7D8PPVZF9PveZo516JmuysglO4E/1IAUD3KoSocd1Mpm466fjgGsce3f/y
 aByIzig9kuVxqTITSS/z16QIpjZcsSa5/E9a6/aG9DB5jwo7cfEVFCtxaRcB/WnlYdga
 3RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119036; x=1726723836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQLh5favEwPC3T5JVQV5e7WmeMzusKhuamksZ0+89Yw=;
 b=bCcoVPQVP0+UVllnf88yeQLSm/8bJXNY2cHqKU/u7iHTyRPG0OUbVvGPG8Pime5p3a
 +xAnuv2b/XaNAbhhGM4PDHfEYf/FI2VCHh1on/w1tIOA3zd2ORHuZipQ8PJPc7w9avpb
 ECxwZDmLumGBeM+NcWOuYaP0YQHNs65S4IbCVme/ArH++N7jtt7YVtjBvXtcPiQM01CI
 5dBinK/ZXQcpS4Pt9GX7JzS6ksIOav2FNAy6+k6vwgLar7YIFz4NHiJke9mtGgdxQl3t
 25Y+OnQCGxjF50rjkJ14wDpcJTwc98XnAeYs+uF2l8OS7gk5JmwUX6WkwDMxq6581W/C
 Cvjw==
X-Gm-Message-State: AOJu0YzwH85ha+Ls7PeNwl+OzdPnhih3MCiwU22sssmRk2Sc7gwnf/MX
 uUI4dQEdrYF1adm68EyGVrhSjbkAqlAb+p5Vrdpz9e3guXpDw5W6R9yFsQ==
X-Google-Smtp-Source: AGHT+IHkdPninia+JpeDUTA0AB+bTY2tK2QTJswS4S2pThfaKSTVVAKti3adEheJ+5g/6Ld9AkQS9w==
X-Received: by 2002:a05:6a20:e609:b0:1cf:2ad4:3083 with SMTP id
 adf61e73a8af0-1cf75f2a5cfmr2599793637.23.1726119035861; 
 Wed, 11 Sep 2024 22:30:35 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:35 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/47] target/riscv: Preliminary textra trigger CSR writting
 support
Date: Thu, 12 Sep 2024 15:29:17 +1000
Message-ID: <20240912052953.2552501-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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

From: Alvin Chang <alvinga@andestech.com>

This commit allows program to write textra trigger CSR for type 2, 3, 6
triggers. In this preliminary patch, the textra.MHVALUE and the
textra.MHSELECT fields are allowed to be configured. Other fields, such
as textra.SBYTEMASK, textra.SVALUE, and textra.SSELECT, are hardwired to
zero for now.

For textra.MHSELECT field, the only legal values are 0 (ignore) and 4
(mcontext). Writing 1~3 into textra.MHSELECT will be changed to 0, and
writing 5~7 into textra.MHSELECT will be changed to 4. This behavior is
aligned to RISC-V SPIKE simulator.

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240826024657.262553-2-alvinga@andestech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 10 ++++++
 target/riscv/debug.c    | 69 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 32b068f18a..7e3f629356 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -947,6 +947,16 @@ typedef enum RISCVException {
 #define JVT_BASE                           (~0x3F)
 
 /* Debug Sdtrig CSR masks */
+#define TEXTRA32_MHVALUE                   0xFC000000
+#define TEXTRA32_MHSELECT                  0x03800000
+#define TEXTRA32_SBYTEMASK                 0x000C0000
+#define TEXTRA32_SVALUE                    0x0003FFFC
+#define TEXTRA32_SSELECT                   0x00000003
+#define TEXTRA64_MHVALUE                   0xFFF8000000000000ULL
+#define TEXTRA64_MHSELECT                  0x0007000000000000ULL
+#define TEXTRA64_SBYTEMASK                 0x000000F000000000ULL
+#define TEXTRA64_SVALUE                    0x00000003FFFFFFFCULL
+#define TEXTRA64_SSELECT                   0x0000000000000003ULL
 #define MCONTEXT32                         0x0000003F
 #define MCONTEXT64                         0x0000000000001FFFULL
 #define MCONTEXT32_HCONTEXT                0x0000007F
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 0b5099ff9a..d6b4a06144 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -217,6 +217,66 @@ static inline void warn_always_zero_bit(target_ulong val, target_ulong mask,
     }
 }
 
+static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
+{
+    target_ulong mhvalue, mhselect;
+    target_ulong mhselect_new;
+    target_ulong textra;
+    const uint32_t mhselect_no_rvh[8] = { 0, 0, 0, 0, 4, 4, 4, 4 };
+
+    switch (riscv_cpu_mxl(env)) {
+    case MXL_RV32:
+        mhvalue  = get_field(tdata3, TEXTRA32_MHVALUE);
+        mhselect = get_field(tdata3, TEXTRA32_MHSELECT);
+        /* Validate unimplemented (always zero) bits */
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SBYTEMASK,
+                             "sbytemask");
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SVALUE,
+                             "svalue");
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SSELECT,
+                             "sselect");
+        break;
+    case MXL_RV64:
+    case MXL_RV128:
+        mhvalue  = get_field(tdata3, TEXTRA64_MHVALUE);
+        mhselect = get_field(tdata3, TEXTRA64_MHSELECT);
+        /* Validate unimplemented (always zero) bits */
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SBYTEMASK,
+                             "sbytemask");
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SVALUE,
+                             "svalue");
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SSELECT,
+                             "sselect");
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* Validate mhselect. */
+    mhselect_new = mhselect_no_rvh[mhselect];
+    if (mhselect != mhselect_new) {
+        qemu_log_mask(LOG_UNIMP, "mhselect only supports 0 or 4 for now\n");
+    }
+
+    /* Write legal values into textra */
+    textra = 0;
+    switch (riscv_cpu_mxl(env)) {
+    case MXL_RV32:
+        textra = set_field(textra, TEXTRA32_MHVALUE,  mhvalue);
+        textra = set_field(textra, TEXTRA32_MHSELECT, mhselect_new);
+        break;
+    case MXL_RV64:
+    case MXL_RV128:
+        textra = set_field(textra, TEXTRA64_MHVALUE,  mhvalue);
+        textra = set_field(textra, TEXTRA64_MHSELECT, mhselect_new);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return textra;
+}
+
 static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
 {
     trigger_action_t action = get_trigger_action(env, trigger_index);
@@ -441,8 +501,7 @@ static void type2_reg_write(CPURISCVState *env, target_ulong index,
         }
         break;
     case TDATA3:
-        qemu_log_mask(LOG_UNIMP,
-                      "tdata3 is not supported for type 2 trigger\n");
+        env->tdata3[index] = textra_validate(env, val);
         break;
     default:
         g_assert_not_reached();
@@ -558,8 +617,7 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
         }
         break;
     case TDATA3:
-        qemu_log_mask(LOG_UNIMP,
-                      "tdata3 is not supported for type 6 trigger\n");
+        env->tdata3[index] = textra_validate(env, val);
         break;
     default:
         g_assert_not_reached();
@@ -741,8 +799,7 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
                       "tdata2 is not supported for icount trigger\n");
         break;
     case TDATA3:
-        qemu_log_mask(LOG_UNIMP,
-                      "tdata3 is not supported for icount trigger\n");
+        env->tdata3[index] = textra_validate(env, val);
         break;
     default:
         g_assert_not_reached();
-- 
2.46.0


