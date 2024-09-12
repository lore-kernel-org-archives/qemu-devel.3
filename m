Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D733EEE271
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 23:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sotd7-0004yI-Ke; Thu, 12 Sep 2024 19:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotd5-0004qX-P3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:39 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotd4-00089u-4z
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:39 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-719270b7c94so285052b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 16:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726185217; x=1726790017;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhLU431wzLJ+L96jZIVSfco4No4B8gvVcyEMQe0t1zo=;
 b=g9vfbSIIJksA3rW2cSPFqLuWVyfIm1S2dBzFLX+cg/c/60wmMsmv8DX0MOF3zo7UOb
 1vwk71TN7mLuvNt5bAEFPC/hTc4ZYIgr5hVDpkTTjQDRqbS1ti5UWeuvY2PETyI9AYsa
 V/0sIXrqz7jgk+u+LyBcm4clZuFsfwyezM0Z74jWcogRQNh1IECRU/mzIdtq47Ky8hnV
 HBWBNF4K+aYzk+h9qfgbCQ8wJkTCVwKORQBZlv7ab+rLUJ8Dds8OFdw8aJPvoCVX/Qav
 FTArG8kJTBmjHqVJoEB9Lg/Bw9PHWYd0YymIbYuiFhK6c49nhfUEjUkBa1y7RNyVL8d4
 HLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726185217; x=1726790017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhLU431wzLJ+L96jZIVSfco4No4B8gvVcyEMQe0t1zo=;
 b=A4YoYKjMYD0Eniadcg56ogl2kSochCQ3f1F88tZH064e+qP+SJ/vkshaYtv9EfhcUP
 f0eDNaY3x4qhUPJLHTGkpbdWwIixHHqxDR5RNg8mKEYVwGB9iPFxShD8fMCOGj9SXoY2
 zZGpBL7Vg7Xuc7jEm3leq3zv10+aMxNh8FjYtFn42J4jRn+UtORY856O0lof8CH8t2kV
 F5gT8ZnWC72PB6ZVnsGDIPtDrnWMWLqI5kCllRRnOtvBbDr5QvYDaZvfT9sToA4lUHq/
 TqzN+AlxytNojI+SV9NorRS3gg2ywkg2Y5V9R6mJ46n6eKMuhMG+UGNEjPWN6RkDovEs
 QoMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqeWR8zfAvbV2aVEFmiCTgT6RVjfFdFk+JEFHp+wsADJaWhMaQIJ02LdV/u4oe7WrbDnwB+SqUhzYl@nongnu.org
X-Gm-Message-State: AOJu0YyWGmihaM4z6odjiBjt6NcxzSFVd4dW7Xu6BJ7pUt3u/lex4jWV
 KD6OIn8cVt6wHDjZKpQEX/tpgC3iN0TfpDE1yR/VHaSj9PAWJslK8iBRnfZQ5Rc=
X-Google-Smtp-Source: AGHT+IE6WKVZPmnHjtufG0J/4yDM5hZm77TSjY5NJol8s2967xefmWPypCa33VQJjcjZFLItMMiN1g==
X-Received: by 2002:a05:6a00:23c3:b0:70d:3337:7820 with SMTP id
 d2e1a72fcca58-71936a4d269mr1535066b3a.8.1726185216657; 
 Thu, 12 Sep 2024 16:53:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe22e6sm5102229b3a.66.2024.09.12.16.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 16:53:36 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 09/20] target/riscv: Expose zicfilp extension as a cpu
 property
Date: Thu, 12 Sep 2024 16:53:09 -0700
Message-ID: <20240912235320.3768582-10-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912235320.3768582-1-debug@rivosinc.com>
References: <20240912235320.3768582-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x435.google.com
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a0490e29f9..b4b578003f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1495,6 +1495,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
+    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.45.0


