Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BC4D10F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqO9-00018H-Fe; Sun, 17 Nov 2024 20:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqO5-00016j-7A
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:09 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqO3-0006TM-8p
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:08 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e681bc315so2492911b3a.0
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 17:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731892625; x=1732497425;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SEyv/JMi1h0in8ejfM1kkgKutMVZo5JCMdeeMywtp8c=;
 b=ZB90m6PDeYelcHRyRakR7n5QpQeGexwr7S2EshMcZijN+UAC/+D/ITYXyX+QjxFshJ
 2eLi+nZQ/8GzxrhfsbIlJIdOIGE/m1qsV/LihHywCsZWQAMIfdNA+pP6GOwgW6SsOf4s
 mEEd4MfU1g7Yc5AtTNpZ5pGugiKkDJhDHAugkIPQl9MujYeo4jvUWfG4K7i483o4Oyqk
 mIAS6cCf0xZyKxSw8DCCa4sJgZj6OV0HMAfGmh67lVAXJNIe+sYhjvG/d9710jL+bQqk
 EfMMl7G0nhjpdIIS84gXztZKiGHw6O5x3NYcZy0xJVuH+Oj81sGGMrsU2G8mVdH8Wu3P
 RSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731892625; x=1732497425;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SEyv/JMi1h0in8ejfM1kkgKutMVZo5JCMdeeMywtp8c=;
 b=Dfuai/TKgrfdti5PQ/KvjqlPTUGW7f9FTRvfw/Y8P1j2mPhh8p1oE71eBrujlWsUHo
 V7sswuvzTKZOC3EMdIJZyfkItW7pwStgffUx4N8HfqcQXycxMlIwt301YwGv83Ay8wMp
 rfuZhFmMupBuR2x7neNpJK0QFlta1fnX8W4rakwXdjbG6qDqQdpF/YXVhqIC0l/yfYqA
 6xvoDhxUtJI4QfnKvyXUTvykkVjb8yYJJ4Tjfvk/4m28F4xdFeGhdHPHA6M+XSPEOkVX
 D8HzWol68UJEYV52faqZAmH+Lw6wMqja1OLFjdlxWv9ykGgWdqxk+h/+2kBhmL9jauN4
 5r/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXISGo2et2hf8doMngcZq9RTrHoI03ue2UrqB9IFsj1V2yrRKppTOjBUAN72gPSHNstpifUzRAFM2OO@nongnu.org
X-Gm-Message-State: AOJu0Yw95Lo+U71NSATtaEG+3yJRmETGCgXmLLBvc+BAjMxsXUyqZAQJ
 xqc2Tl8dPraaR5Lca5NI19kZRDQ9Ttbfqxyqori3TTd6Hdj6joqtpVW+Mk+bRsK/kAGjg1brZp/
 F
X-Google-Smtp-Source: AGHT+IHiGvopjh8ap5uF2MeEehXd+gFOzW5stRQNg5GamEVC4fjVVY1EXhLbuEaDvU/YDOeY0SGF7A==
X-Received: by 2002:a05:6a00:3bf4:b0:724:6804:d663 with SMTP id
 d2e1a72fcca58-7246804d6ddmr20017440b3a.1.1731892625309; 
 Sun, 17 Nov 2024 17:17:05 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771e8b75sm5134024b3a.147.2024.11.17.17.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 17:17:05 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Sun, 17 Nov 2024 17:15:59 -0800
Subject: [PATCH v3 11/11] target/riscv: Add configuration for S[m|s]csrind,
 Smcdeleg/Ssccfg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241117-counter_delegation-v3-11-476d6f36e3c8@rivosinc.com>
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
In-Reply-To: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42c.google.com
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

Add configuration options so that they can be enabled/disabld from
qemu commandline.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 410ca2e3a666..2a4f285a974f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1477,6 +1477,10 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
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
2.34.1


