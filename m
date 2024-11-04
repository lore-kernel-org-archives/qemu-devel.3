Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE3FD1CA00
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8510-0007y1-3f; Mon, 04 Nov 2024 16:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t850y-0007wm-Dy
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:53:36 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t850w-00011b-I3
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:53:36 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-431688d5127so37872125e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730757213; x=1731362013;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDLRcwzr6VXqmP37s1Pho6urX1riE8cy6cAg2/tgJpY=;
 b=RAjzHsusYMoy27fDB4VD7bhSIk6cUMKF4bi5HZeyEAdu3MaZy228oQ7uy+PMXpb0hK
 2v6b5Xg2EFUxiGxeuEc2N19cDNHw4kR40t+NY+YpUKoX/7QGfUX62KGJDrssjHByav3p
 HcVNcnlTT11OgasmAD3/ODHP6a5pWRFaYY5NixinoIAnBymwC6Dfyg3yN4poy6SxaGSV
 dn9gNIvMwlGs5fry0pLk8pdB92wk9wEm3PmQjBoUP03l2iYKpYrRcBVKLat9TGuB/Uay
 G30If5mVn6qKWDChss4j1S3B1y8+kwgN9C83lFksrRUkvFVpIdzDH9Kkt8tP6JsUWniX
 Q48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730757213; x=1731362013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDLRcwzr6VXqmP37s1Pho6urX1riE8cy6cAg2/tgJpY=;
 b=t8vXa1fPVYYNwQDPZGaqLYgopKK4r/gK1Hhxdrx0Wm3VrOOa7j83N7wI/2OtwVJOtf
 W4z8A6jzWMh807WoqJokoz/OidVGO+pGuVkEiYSDkv/Sb0OQHD/EskXKCn9Nk5ruo+7i
 h4EJdzmWffASQth3MI7ls4ZJOO5LVXfkii/Zt8i/ZMvbFF2UVtLXt8cXTi9gHMS7clwV
 7wdB5GoqkxkZR5u4CAdLgh+t7hd1N9+yy+cKZ5VvWKyJLsqLcOvTXHaUf7NnibkPZ08I
 qIyZs0UIqRzt0hnobLFcGBPSe9tFtVrR6ApXPqJycUvex3YHJeBO+UwBtya4hJ2vjYaw
 piGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpRd68x6yVfM1Y/ZRC5SXwA9AG1UL8GyoRIhT7H3AJmq3J3WBnf0S427h6Xgo1QfLZBi9enulN2mSY@nongnu.org
X-Gm-Message-State: AOJu0YwihdTgxL4ghIA/RwNqsp1399eEWqU/8dNiGGG+ZQXe2lpuUrZX
 Cg9O1+/1rguOyxIbxbAXA6nZkFdFRCzXfSmqHSlT2iQJbkhojdADAUBsPtR4voA=
X-Google-Smtp-Source: AGHT+IH0j0Vi/qSiZDgsGcDbn5IlYo5sOrt8UbtrpyIgIwHrsHwPZPKcF0o3GMUeKh+VCsI9D526Uw==
X-Received: by 2002:a05:600c:19c8:b0:430:54a4:5b03 with SMTP id
 5b1f17b1804b1-4319ac6fad6mr265297895e9.6.1730757212883; 
 Mon, 04 Nov 2024 13:53:32 -0800 (PST)
Received: from rkanwal-XPS-15-9520.Home
 ([2a02:c7c:7527:ee00:8a3a:7719:aa26:21cb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a26a6da1sm1537595e9.0.2024.11.04.13.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:53:32 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com
Subject: [PATCH v3 2/6] target/riscv: Add Control Transfer Records CSR
 definitions.
Date: Mon,  4 Nov 2024 21:51:06 +0000
Message-Id: <20241104-b4-ctr_upstream_v3-v3-2-32fd3c48205f@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104-b4-ctr_upstream_v3-v3-0-32fd3c48205f@rivosinc.com>
References: <20241104-b4-ctr_upstream_v3-v3-0-32fd3c48205f@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

The Control Transfer Records (CTR) extension provides a method to
record a limited branch history in register-accessible internal chip
storage.

This extension is similar to Arch LBR in x86 and BRBE in ARM.
The Extension has been stable and the latest release can be found here
https://github.com/riscv/riscv-control-transfer-records/releases/tag/v1.0_rc5

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index d20468412dca8fef9623dd968bb93e1e6dddc529..0d7571c61de9c49d9c6581fe956ba28beb59bdc5 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -244,6 +244,17 @@
 #define CSR_SIEH            0x114
 #define CSR_SIPH            0x154
 
+/* Machine-Level Control transfer records CSRs */
+#define CSR_MCTRCTL         0x34e
+
+/* Supervisor-Level Control transfer records CSRs */
+#define CSR_SCTRCTL         0x14e
+#define CSR_SCTRSTATUS      0x14f
+#define CSR_SCTRDEPTH       0x15f
+
+/* VS-Level Control transfer records CSRs */
+#define CSR_VSCTRCTL        0x24e
+
 /* Hpervisor CSRs */
 #define CSR_HSTATUS         0x600
 #define CSR_HEDELEG         0x602
@@ -341,6 +352,7 @@
 #define SMSTATEEN0_CS       (1ULL << 0)
 #define SMSTATEEN0_FCSR     (1ULL << 1)
 #define SMSTATEEN0_JVT      (1ULL << 2)
+#define SMSTATEEN0_CTR      (1ULL << 54)
 #define SMSTATEEN0_P1P13    (1ULL << 56)
 #define SMSTATEEN0_HSCONTXT (1ULL << 57)
 #define SMSTATEEN0_IMSIC    (1ULL << 58)
@@ -860,6 +872,88 @@ typedef enum RISCVException {
 #define UMTE_U_PM_INSN      U_PM_INSN
 #define UMTE_MASK     (UMTE_U_PM_ENABLE | MMTE_U_PM_CURRENT | UMTE_U_PM_INSN)
 
+/* CTR control register commom fields */
+#define XCTRCTL_U              BIT_ULL(0)
+#define XCTRCTL_S              BIT_ULL(1)
+#define XCTRCTL_RASEMU         BIT_ULL(7)
+#define XCTRCTL_STE            BIT_ULL(8)
+#define XCTRCTL_BPFRZ          BIT_ULL(11)
+#define XCTRCTL_LCOFIFRZ       BIT_ULL(12)
+#define XCTRCTL_EXCINH         BIT_ULL(33)
+#define XCTRCTL_INTRINH        BIT_ULL(34)
+#define XCTRCTL_TRETINH        BIT_ULL(35)
+#define XCTRCTL_NTBREN         BIT_ULL(36)
+#define XCTRCTL_TKBRINH        BIT_ULL(37)
+#define XCTRCTL_INDCALLINH     BIT_ULL(40)
+#define XCTRCTL_DIRCALLINH     BIT_ULL(41)
+#define XCTRCTL_INDJMPINH      BIT_ULL(42)
+#define XCTRCTL_DIRJMPINH      BIT_ULL(43)
+#define XCTRCTL_CORSWAPINH     BIT_ULL(44)
+#define XCTRCTL_RETINH         BIT_ULL(45)
+#define XCTRCTL_INDLJMPINH     BIT_ULL(46)
+#define XCTRCTL_DIRLJMPINH     BIT_ULL(47)
+
+#define XCTRCTL_MASK (XCTRCTL_U | XCTRCTL_S | XCTRCTL_RASEMU |                \
+                      XCTRCTL_STE | XCTRCTL_BPFRZ | XCTRCTL_LCOFIFRZ |        \
+                      XCTRCTL_EXCINH | XCTRCTL_INTRINH | XCTRCTL_TRETINH |    \
+                      XCTRCTL_NTBREN | XCTRCTL_TKBRINH | XCTRCTL_INDCALLINH | \
+                      XCTRCTL_DIRCALLINH | XCTRCTL_INDJMPINH |                \
+                      XCTRCTL_DIRJMPINH | XCTRCTL_CORSWAPINH |                \
+                      XCTRCTL_RETINH | XCTRCTL_INDLJMPINH | XCTRCTL_DIRLJMPINH)
+
+#define XCTRCTL_INH_START         32U
+
+/* CTR mctrctl bits */
+#define MCTRCTL_M                 BIT_ULL(2)
+#define MCTRCTL_MTE               BIT_ULL(9)
+
+#define MCTRCTL_MASK              (XCTRCTL_MASK | MCTRCTL_M | MCTRCTL_MTE)
+#define SCTRCTL_MASK              XCTRCTL_MASK
+#define VSCTRCTL_MASK             XCTRCTL_MASK
+
+/* sctrstatus CSR bits. */
+#define SCTRSTATUS_WRPTR_MASK       0xFF
+#define SCTRSTATUS_FROZEN           BIT(31)
+#define SCTRSTATUS_MASK             (SCTRSTATUS_WRPTR_MASK | SCTRSTATUS_FROZEN)
+
+/* sctrdepth CSR bits. */
+#define SCTRDEPTH_MASK              0x7
+#define SCTRDEPTH_MIN               0U  /* 16 Entries. */
+#define SCTRDEPTH_MAX               4U  /* 256 Entries. */
+
+#define CTR_ENTRIES_FIRST           0x200
+#define CTR_ENTRIES_LAST            0x2ff
+
+#define CTRSOURCE_VALID             BIT(0)
+#define CTRTARGET_MISP              BIT(0)
+
+#define CTRDATA_TYPE_MASK           0xF
+#define CTRDATA_CCV                 BIT(15)
+#define CTRDATA_CCM_MASK            0xFFF0000
+#define CTRDATA_CCE_MASK            0xF0000000
+
+#define CTRDATA_MASK            (CTRDATA_TYPE_MASK | CTRDATA_CCV |  \
+                                 CTRDATA_CCM_MASK | CTRDATA_CCE_MASK)
+
+typedef enum CTRType {
+    CTRDATA_TYPE_NONE                   = 0,
+    CTRDATA_TYPE_EXCEPTION              = 1,
+    CTRDATA_TYPE_INTERRUPT              = 2,
+    CTRDATA_TYPE_EXCEP_INT_RET          = 3,
+    CTRDATA_TYPE_NONTAKEN_BRANCH        = 4,
+    CTRDATA_TYPE_TAKEN_BRANCH           = 5,
+    CTRDATA_TYPE_RESERVED_0             = 6,
+    CTRDATA_TYPE_RESERVED_1             = 7,
+    CTRDATA_TYPE_INDIRECT_CALL          = 8,
+    CTRDATA_TYPE_DIRECT_CALL            = 9,
+    CTRDATA_TYPE_INDIRECT_JUMP          = 10,
+    CTRDATA_TYPE_DIRECT_JUMP            = 11,
+    CTRDATA_TYPE_CO_ROUTINE_SWAP        = 12,
+    CTRDATA_TYPE_RETURN                 = 13,
+    CTRDATA_TYPE_OTHER_INDIRECT_JUMP    = 14,
+    CTRDATA_TYPE_OTHER_DIRECT_JUMP      = 15,
+} CTRType;
+
 /* MISELECT, SISELECT, and VSISELECT bits (AIA) */
 #define ISELECT_IPRIO0                     0x30
 #define ISELECT_IPRIO15                    0x3f

-- 
2.34.1


