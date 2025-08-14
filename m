Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D55CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 07:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umS3H-0007kl-S3; Thu, 14 Aug 2025 03:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umS3F-0007kI-4c
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:07:05 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umS3C-00040m-LJ
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:07:04 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b9e415a68eso279931f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 00:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755155217; x=1755760017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roJhrLABrYMM3hT1Qlu1BPFfo21rWtltlN3F1VmKs60=;
 b=wfUIyUoTZY4Ch5ORw+aoEK0WjeZhJBJQAr3THji0Cz9VAjzWn27gUyD/2+SyHJCku5
 Wsm8s/8++1nJEMNei5T5AM/6hJ7hlxHHGZTAtmSdjNtjiNBJj/LcQS9ZB24IaXcQUEDm
 jWhi8dHyTD0sBGoOlSWOtT5sQoPnaQdPEnkLa3OgyM1Rc0pNsFi2PZB1VohCi4Gp2WZN
 ozMkKUfyxmpcjU5oii/slQBoa5gLUA/4Shgx+kqnbqkUvYXdI5/4y58BKdhOGgyocDP0
 LqFbyk1KnsRP9/xJes9cphO34+blGLjDblEN5l6Hv86TsbwjvB2Bfrp/d/ygWT8m8kmX
 wn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755155217; x=1755760017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=roJhrLABrYMM3hT1Qlu1BPFfo21rWtltlN3F1VmKs60=;
 b=LselyOmmNOmRxEP0tnDbPuC6Ne/aSwRweBG+wGB5nOmu4uKruvVVHBcLdmbHjL40Rx
 K57k8Gst00KWDWCKRPssEGOcuhRJG3xE5im3O7QAoRsak3yXG4RRZlELmXO0baOt4kIr
 pFUifpC1wJZQ+w0SocDhMXTs4Kt5rqu6SZ87m5jFBlQRyhgkUf/NrdFNstitNlr4n6Bp
 RhCdWZxjTncFTa0UmjstioBMnrXucSZpjbtgl1z0DJ4/k8rR3iyy+L/RfbKVfsOWq1K7
 n9u8zVMFL9Y1Spdljncql9FPqtWIfoJDzqhnD89ZILkaChtskCbY1Otq/5xleK+pdFcS
 uAVg==
X-Gm-Message-State: AOJu0YyhDW5kk1KGDKCZS9tqqmF87QF1gZsz5z3AFR/j0SXywgnIRM1Q
 QkpDnh2phPsOwF/9G75a/F7wIuaGoAOjYr8roJnfsf4kWpB2dku7ePziOnayDCbzKpzACWMPZfd
 Q+PRg
X-Gm-Gg: ASbGncsKfnVWFWUvVL5ubcRqeelI5RMY9Puo5ZQNSPFQ4ybsymXQBYpY9G1/a37kwGy
 k1sp/x2E0xlH53MGD3gfmxVTLPhcNZH5XGP+SIJSDjFyTR3jg9PIYh/knZFoZAqGrgoiFjNiA/T
 LjPr+EoqmZVTtmiJBn78u5Is+WZGeMoMqe2MgZ3wQjy84oyru3yJ8oPbAu1FVCLq5LRlaqBjHvY
 XAZNp3MMslYt3rGvAc14iheGoBRVpKxcBMdMNVyvhT+LFe/9NJ3fPmFoSR+Phjv3nLwWbK3+Y+N
 ZyYOaYywdDWOojnM1DrR148P39C3DAfKpdE8Ucq+5Xo12MAlU4vny2v5jzC4MAt8opdNJlPgTLs
 01YrlCpUKE+VX0u0IsbY/MfXlNuXUmGFjnutYSfTHhPVDMhYmb4MUcuWoHqCa6+U/DlZiVxjU/v
 0yaQ==
X-Google-Smtp-Source: AGHT+IHoYuta4w6XKVGSYZTDITw2WNNCDcU7iRZHrorEqnx0IgXHqhjuxm3hUq4zwvBY8zJfL2n3Fw==
X-Received: by 2002:a05:6000:290d:b0:3a4:eb80:762d with SMTP id
 ffacd0b85a97d-3b9edf7ddb4mr1504720f8f.56.1755155216707; 
 Thu, 14 Aug 2025 00:06:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c47c516sm50277956f8f.62.2025.08.14.00.06.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Aug 2025 00:06:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-10.1? 1/3] elf: Add EF_MIPS_ARCH_ASE definitions
Date: Thu, 14 Aug 2025 09:06:48 +0200
Message-ID: <20250814070650.78657-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814070650.78657-1-philmd@linaro.org>
References: <20250814070650.78657-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Include MIPS ASE ELF definitions from binutils:
https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=include/elf/mips.h;h=4fc190f404d828ded84e621bfcece5fa9f9c23c8;hb=HEAD#l210

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/elf.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index e7259ec366f..bbfac055de4 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -56,6 +56,13 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_ARCH_32R6     0x90000000      /* MIPS32r6 code.  */
 #define EF_MIPS_ARCH_64R6     0xa0000000      /* MIPS64r6 code.  */
 
+/* MIPS Architectural Extensions. */
+#define EF_MIPS_ARCH_ASE      0x0f000000
+
+#define EF_MIPS_ARCH_ASE_MICROMIPS 0x02000000
+#define EF_MIPS_ARCH_ASE_M16  0x04000000
+#define EF_MIPS_ARCH_ASE_MDMX 0x08000000
+
 /* The ABI of a file. */
 #define EF_MIPS_ABI_O32       0x00001000      /* O32 ABI.  */
 #define EF_MIPS_ABI_O64       0x00002000      /* O32 extended for 64 bit.  */
-- 
2.49.0


