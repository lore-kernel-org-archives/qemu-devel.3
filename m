Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AD0EEE270
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 23:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sotdN-00061V-2J; Thu, 12 Sep 2024 19:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotdL-0005tl-5E
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:55 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotdJ-0008E1-Nd
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:54 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-718e56d7469so327289b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 16:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726185232; x=1726790032;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFWVRWsANXTqcHXOvM2OwmQgl5qrgw/0uXyC/jmwSHI=;
 b=cLefDXWM0FcYR8raI/2tWD9FCMNGSJEitVU8vMwIchpgiZjDY8Crt1l/FjkDc5V3qi
 uYE/hHjAqZC8vchvZzF3Th8qu+JHqTU1WzOLqfnW2B+7iBR6o4r9QA9HjEo3Nu+Rczo7
 Aztv3za+TPAPmvHhn22xrw4JANsz1bnLkfV8NnaRzhcJB5529N2QLEAu1oW275FGv27f
 r/bJ2bzIRItCt/mgSkbsq/+FL6cOIssZY0LAKl2EePZxMsOKSGdQp9Rb/v6DnWxpe7z+
 8qpldJ7f4SQWJjp0xaJ+CHjfma9aLlJIx3b3n1ov4oM025+8KWF6nuOjv5tWgucASPKK
 JrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726185232; x=1726790032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFWVRWsANXTqcHXOvM2OwmQgl5qrgw/0uXyC/jmwSHI=;
 b=WFLjtPKSV7MgA5G2E74lyumd6FyxwkZ4lI4+xzAOeXrl6ICMiiiolS3d10zu9XNA1V
 g326SWWeiBrurOJHy8aVLBqn/BxbZSbi11yiKbykDFRigpsSU5igBdlwZY1hP4IU//0F
 RrurRYmTdL4mx+VU21fifiAvhbWB0Xl4ibSsgLA4Z9/O1Lhvq4d6CXtV7Xty5XojO7Mc
 wl0DiTA0nuL1glKWLAUHmiscycXWD3rrgHxuQG4IW2cL4ulyqw1kyj3uwRVBDbfWqqL/
 naV8wzbSx9WTkqpzZgQWVCOtESqFDySX2FPTGyeUU62wRCxvpuKGM+4Af6Ma9stc/31D
 SExw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3uXgIklddClx8e7kWsEsupxPaaQ28R1Kq48eqM6Z15otCJuNj7EEs3jvcoE5BfSf4zGHp5X8Rqtw5@nongnu.org
X-Gm-Message-State: AOJu0Yy2tcxqO+if03RrIbH9q03M/QunNznmGzTi/DK+uSi6ntt5nG31
 9qbNUTjVD/aBAcEpsW0OfRmnFMgpD/Bj8N4rk3lGGKImLk97H4QAWk/pRZZLlm8MuX2P3wiRo4U
 l
X-Google-Smtp-Source: AGHT+IHH5lsfZWsWqR2Ve8GHcDs8nwISMVUb6vxVEvvprHbeVx9E0fa0LZOs291N0KbESFBmQSXjDQ==
X-Received: by 2002:a05:6a00:1706:b0:719:1f10:d1c9 with SMTP id
 d2e1a72fcca58-71936a2f82bmr1477352b3a.2.1726185232295; 
 Thu, 12 Sep 2024 16:53:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe22e6sm5102229b3a.66.2024.09.12.16.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 16:53:51 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 20/20] target/riscv: Expose zicfiss extension as a cpu
 property
Date: Thu, 12 Sep 2024 16:53:20 -0700
Message-ID: <20240912235320.3768582-21-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912235320.3768582-1-debug@rivosinc.com>
References: <20240912235320.3768582-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4172774087..3e72df6ef8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1499,6 +1499,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
+    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.45.0


