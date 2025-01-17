Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C25C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfNc-0001HZ-2h; Fri, 17 Jan 2025 00:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfN1-0008Do-0t
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:15 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMz-00069C-J2
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:14 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2165448243fso39104815ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093491; x=1737698291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RI/ru8YhNHcXrqt5iwCxMSMw5uflH2KZwh/aSZthUJY=;
 b=F8kjNqn0ZTDvviYFMbZlsM8Iyg+ntZh8hHz+BZVybGRn0ANuKU8xn3AEEn6Kyis2Ar
 G+PSZWW/SAYjXKAcn55Zk83k9hJ8U+R9/gbp98H4ZOzwmxdU0mCAH+loTzdVHlNpK4/p
 kBYtAzfCDdsEHs5Pdzab2EVq6gKraGMh2EtafpcK8LhzkYZyAb4HOQLh5IbL8Xl+xLIV
 topsj+QwjzLS9yrgNDza4WPcb1O8ivhdTX5tOB2s0vxb8Df2SzFug+8Xq2yFgbIFYmMq
 +AgjwngBpZ5bq0Pj55klCLIdYhH6MHrS3dhU5XMcFXQyYD11aoUK3FtursTeHz5bS4/F
 Cp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093491; x=1737698291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RI/ru8YhNHcXrqt5iwCxMSMw5uflH2KZwh/aSZthUJY=;
 b=eLIunW6i272GguuHi77zfj11wQxrOoHwYoGQeOJ8NOl7yHmBwuCk5ueU3bTFUvCOTp
 yrmEjg59nc7B6qwQLQX9eKzmR3AqV4wy2mW3L/vwMYyygNfIZw8I6jcNmi/on5HsGsLW
 PSFX+xvZYw6IXjFEqfanOvvTvsQyfz835aA1BJZTZsd8Eo7gQ1zr4MIKsvZm8v7oPM6d
 f2P4MBx8X4XzjgDz3iMFMkI8/pnJk4pS8eD53f5mAmwhuz73JLLgNpndadNW5IZL6Hu8
 V1AcLw73Q7o8/ROXMN0ZUj3OeFtUCZ3fj3NnlGZ6NIs6fvH7M0/yOtuHtEe1Z2xlH/F+
 UbTw==
X-Gm-Message-State: AOJu0YyKX08epkWQQaF526YpLYD75khfT9tiMb/fMXnwuXTfua/mpKgb
 JZ38UQVRPXG9Oy+Cla1ki/cbaIomwe6y+X856e1L0EvRRIF17kJfJbmxTg==
X-Gm-Gg: ASbGnct6QffVQDsWTct0UrJHkCRLJq04cENMpI5FjdizANV10IZ0hpr7M/KyA4QxgLM
 WQs2NVYfc5tnwOJsjX0WRiQFEccxjAXXdqekL3MyLZFCQKKBJa4sNSnxY8ehMWfXsAaV2XXtxM+
 +3JQTgO0A6mlY9jzVhUfRtIbQ8jUNoeIFybCA6Wuc+tYkspZnST3eTuf4w2Az5Mk05Cl9vFBJNb
 WxuBaG4Y1ebeTXrCmZ/iWpHSqSddMuoe0ZElgQU9Fr8ugFj1e/ibbhw6C8nSAF0PYe7nEaDOu4M
 F8rg5zV1zUoRCQSoMxm+uHmrF7bMHsAVPqrhyLdOgb0UOu6lMPh7FYy0mNZZ
X-Google-Smtp-Source: AGHT+IHCx+CTQPycrYb/GvruboZt8YkZxO73F/9D3giP/x+JAkdIMBniP1VHryTtm4KZfclP+/LbqA==
X-Received: by 2002:a17:902:ccc8:b0:216:45b9:439b with SMTP id
 d9443c01a7336-21c3563c530mr22698055ad.50.1737093491361; 
 Thu, 16 Jan 2025 21:58:11 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:10 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 38/50] target/riscv: Add configuration for S[m|s]csrind,
 Smcdeleg/Ssccfg
Date: Fri, 17 Jan 2025 15:55:40 +1000
Message-ID: <20250117055552.108376-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Atish Patra <atishp@rivosinc.com>

Add configuration options so that they can be enabled/disabld from
qemu commandline.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-11-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 671fc3d1c1..fe470f646d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1587,6 +1587,10 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
+    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
+    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
+    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
+    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
-- 
2.47.1


