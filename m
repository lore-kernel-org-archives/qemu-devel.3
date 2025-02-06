Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582B2C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyf5-00006q-PD; Thu, 06 Feb 2025 04:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tfyf4-000052-Id
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:59:06 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tfyf2-0006JQ-Aw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:59:06 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2165448243fso18061045ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738835943; x=1739440743;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t1C/LLoDY7PT/SZxUEWz8CrpNaX4xZDyuv/Vp2mDkdM=;
 b=IGIFmtudtxlDwA0T4YztDbQprky3NabdH3aT3HUS1g1S5t3iICX1q7X6+Xm7RKRZSr
 fwEJ6oL6i51YbS+UwZ1sbyBUwE3CVJRPiLMWEZbeSAmXYR41FenVZSgmnuA565iGgIZT
 ErnImE7/hhtTLFwEAxA+8B3Cmr9FPHjBVf8d5Muof7aWX2ovoozu1iyPnUUEi+RZiMFZ
 fvxXh7dUonaGSUQNYA6W8102Ij6Xq+TIVZT4tCrm+n3pKO/f7hOjfqO99nPq0K/vBP5C
 +ZZtF3gVe/Lyk6+vcQ+rHhH+Yzj3u+ckcaptGSRFwPfkO+NItMueLWdJdbjVlTozvruh
 YKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738835943; x=1739440743;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1C/LLoDY7PT/SZxUEWz8CrpNaX4xZDyuv/Vp2mDkdM=;
 b=lNcnh2QYFGhMz5fMHBlyAnU/8VSh0yWX2O0H4bWeOuu+/m9rHDMbp66H74x9ffwPmh
 sfjHp6MMXhWUuUDp6APgQEKPeTPDlraz8IRYGqcciA1t12CWsz/MiBQSN3YbGjlyAosc
 Vx9B3ANbMleCrHIr9Ioet3SRBni8WCNRL/57IBk+9OMJ28eTJx9xPPM+jzaUTzavxoh+
 kavAAvpLWXIUldNsoGZimzeEt4R7ILNFxcFIi43JBfZJbLAHaHs6c6z+2eEE6LenGJJI
 /6R9fcYYjgO9jonUuckrAj9hkyrf+AiYFzP4eepbM2BJ5qM3DfdVpa+7e6TP8j0pA9d8
 I6jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV29XwiRKvrZWIFEVj5er4kp59J951X+vHx+4nSLwGxGzc23x8+PgnVevDXquDQUvT5JFzQtppQe5Fq@nongnu.org
X-Gm-Message-State: AOJu0Yzyy3XjwBfcFW/fqxysrKa2Nmpoz/jHG3I8mey7OpRohFEQsm0j
 P0Z0YeXWpBpcpfQR0EPN50eZ7g0IbBsXUCmc2lQKBG6Y972oTUuCGyj/EcA/k54=
X-Gm-Gg: ASbGncsAfSoKC8nYeziGJT+iSzDdwuS9w0zNm+IoVvh885qrhkBYcrkSgaBcU5+KRvh
 ZEwuusPkBu9aQ1BfERZRGMOQqaxnWXk2qm6j/glLCVPYLCDZ5+zVF5QTz40Ck0tG5zP/NDbN+RS
 jbINtUEuTDX2CGUs0b17wSQL/jkFVbnOYQSbcLfyIxuuU20ptFmaznaYzl6xIUdxoCRROFL+U7b
 a1cyPj3d1T1WEDMRx2RPjj6BLMapRdFTzqVxWgb7C0R3EzMLZNYj7+Yl/dVEZ8cx9p6CsU7NaO9
 CgMdE6712nKYZSmjVe6cNxW5XSO1
X-Google-Smtp-Source: AGHT+IF3dVvLGGY5f9+ZhBKoa7HxVm/fdb0Zg94lzB2z8wJpxVV/WrCbI5S8gyJmJbPMMmvRNB3HAg==
X-Received: by 2002:a17:902:ce0c:b0:219:d28a:ca23 with SMTP id
 d9443c01a7336-21f17ebef80mr109367805ad.36.1738835942984; 
 Thu, 06 Feb 2025 01:59:02 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f365616ecsm8768815ad.100.2025.02.06.01.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 01:59:02 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 06 Feb 2025 01:58:46 -0800
Subject: [PATCH v2 1/2] target/riscv: Fix the hpmevent mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pmu_minor_fixes-v2-1-1bb0f4aeb8b4@rivosinc.com>
References: <20250206-pmu_minor_fixes-v2-0-1bb0f4aeb8b4@rivosinc.com>
In-Reply-To: <20250206-pmu_minor_fixes-v2-0-1bb0f4aeb8b4@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x632.google.com
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

As per the latest privilege specification v1.13[1], the sscofpmf
only reserves first 8 bits of hpmeventX. Update the corresponding
masks accordingly.

[1]https://github.com/riscv/riscv-isa-manual/issues/1578

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu_bits.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index f97c48a3943f..74859c4bc8ff 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -933,9 +933,8 @@ typedef enum RISCVException {
                                             MHPMEVENTH_BIT_VSINH | \
                                             MHPMEVENTH_BIT_VUINH)
 
-#define MHPMEVENT_SSCOF_MASK               _ULL(0xFFFF000000000000)
-#define MHPMEVENT_IDX_MASK                 0xFFFFF
-#define MHPMEVENT_SSCOF_RESVD              16
+#define MHPMEVENT_SSCOF_MASK               MAKE_64BIT_MASK(63, 56)
+#define MHPMEVENT_IDX_MASK                 (~MHPMEVENT_SSCOF_MASK)
 
 /* RISC-V-specific interrupt pending bits. */
 #define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0

-- 
2.43.0


