Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB74EE77160
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 23:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIc6d-0001Lj-GA; Tue, 03 Dec 2024 18:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6Z-0001IP-Eo
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:56 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6X-0001Jv-M4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:55 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-215b0582aaeso16568785ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 15:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733267692; x=1733872492;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LMnKYE8WPdvKl7s3HVfAdc/3hWY0P2i17ofoTw5jOGw=;
 b=N6nvTfJm4dkJQHfcWF2jlj6wT/l7YnNWXbx+02kjm42lVIjR9Bde2oywvuYu58z+om
 P1+ks3K2v3gyI0rtvhY1gb1OftrEbTIOHDnE0c/FxJFeJLkwbRMfFJSi3si4Q7aM7EzX
 YIFoxycE/1aDlhMBN8GvDatJ7JMS4iTlz3HtykekVMrylslO1Rzz7BF+Kfwk0rSkR9nm
 B7Io24uteT52ovXvWTqtRM3pm2Krf9h0uCdtDJW1ES2MWm8Bgumhu0WCu6oEKy1i26hZ
 tPHM1H/2JTYLpDZXOqT9wUDInZ7sVv8fRLymCbHH621K1k2yHSNU6Qz1BR9v3VSjoWIV
 Pukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733267692; x=1733872492;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMnKYE8WPdvKl7s3HVfAdc/3hWY0P2i17ofoTw5jOGw=;
 b=Ip28u+0njedD2hbzgobaSuBUJIzdclUAw0pz3PYREn/0YH8ApqNe6noQJd5WSCisSl
 Ew1H8xnwBWgaJJMpFbaKRzm1fDMU+vx03EVmCxPMfkVjd4N1OGFeioLKY3zodpY7/4xR
 A8lZcdp7+szFIQ+grCjP0kNNIdRxFgM76jpH9E06waKNrqWNXCEpXYO10jhFUGJRsJLN
 df+pH9/jaA97y7fSiDCPwkPKJbIMcpQg0T+DaOWlBnSZUCdKAu9V7OCIwbZArIByZDXk
 /Xj6yqg4aHnsEHKRqbJNnGrZnLsdhvbq8NHc4ET9/GBf1WuNfiiAAHfcbpCDHnM8P5Rw
 S70w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX69dbdG8vJDBtq/VfmF6aBUB5Xt4zRl8fI5HqZhCLpKO+oVo95drIpBdcZTFbIIZRGpqIdWNBNdw4w@nongnu.org
X-Gm-Message-State: AOJu0Yx3R4Fadc29o3PACZ4j7rV6nsQqD1T6Xq8r+BYUmOv5N0Sn1VjN
 8KfV07f5Lfh4g4aMYaEZfAb1OfwCsWYlYPARKI7ugNowgqdginGqb61nFuYxyEU=
X-Gm-Gg: ASbGncvrbD2bHpNC8IDHcpHMpq1v5sK+EzHuwtDXvXmQawGp2GccjBiDlWq+tynRKMN
 +MgNHITHqEkzfxEuBAp1TFn8tBs+JRmOCATZgWzXfuK0k35qsVtt14nDv1m0/zeO5BflbVGicsU
 XXO444hfHo6FzpJlNF95ttmFByl1ggLv/yo1uQa8xAeDiMfgM8uDTvhKvsqabwz/txI/bTakTZi
 tH6q9Inur2wpXjV8GMFPeZzrD1fYiZh59nvdUII+X4zalNXqotv7TfCxNomDn0=
X-Google-Smtp-Source: AGHT+IFTgjURCicqPJ47SCN5f1t5Kdxv4N9lllPghpOB6pd05/fucO0zpFKBOtq9qx0M2KK7LA/tYQ==
X-Received: by 2002:a17:903:32ce:b0:215:7742:73d6 with SMTP id
 d9443c01a7336-215bd0c4b00mr48972105ad.20.1733267692201; 
 Tue, 03 Dec 2024 15:14:52 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f78asm11032133b3a.133.2024.12.03.15.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:14:51 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 03 Dec 2024 15:14:44 -0800
Subject: [PATCH v4 06/11] target/riscv: Add counter delegation definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-counter_delegation-v4-6-c12a89baed86@rivosinc.com>
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds definitions for counter delegation, including the new
scountinhibit register and the mstateen.CD bit.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h      | 1 +
 target/riscv/cpu_bits.h | 8 +++++++-
 target/riscv/machine.c  | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 284b11282197..903268626374 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -385,6 +385,7 @@ struct CPUArchState {
     uint32_t scounteren;
     uint32_t mcounteren;
 
+    uint32_t scountinhibit;
     uint32_t mcountinhibit;
 
     /* PMU cycle & instret privilege mode filtering */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e13c5420a251..4ac065ac5e5a 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -210,6 +210,9 @@
 #define CSR_SSTATEEN2       0x10E
 #define CSR_SSTATEEN3       0x10F
 
+/* Supervisor Counter Delegation */
+#define CSR_SCOUNTINHIBIT   0x120
+
 /* Supervisor Trap Handling */
 #define CSR_SSCRATCH        0x140
 #define CSR_SEPC            0x141
@@ -791,6 +794,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_CDE                        (1ULL << 60)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -886,7 +890,9 @@ typedef enum RISCVException {
 #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
 #define ISELECT_MASK_AIA                   0x1ff
 
-/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
+/* [M|S|VS]SELCT value for Indirect CSR Access Extension */
+#define ISELECT_CD_FIRST                   0x40
+#define ISELECT_CD_LAST                    0x5f
 #define ISELECT_MASK_SXCSRIND              0xfff
 
 /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 99f0af507717..e1bdc31c7c53 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -434,6 +434,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
         VMSTATE_UINT32(env.scounteren, RISCVCPU),
         VMSTATE_UINT32(env.mcounteren, RISCVCPU),
+        VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
         VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
         VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
                              vmstate_pmu_ctr_state, PMUCTRState),

-- 
2.34.1


