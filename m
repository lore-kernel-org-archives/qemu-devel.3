Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CE1C36008
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 07:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzVvj-0005I2-8C; Tue, 01 Apr 2025 03:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzVvf-0005Ha-Iw
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 03:20:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzVvd-000056-Pm
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 03:20:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so87275f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 00:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743492054; x=1744096854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=59x6vNvLsKAT/IxMI6FzfkqIiXL3jLpaLHobfpnQ9uI=;
 b=VLUOSGG53chC6MkPfcFSiu+MiGAI69LP9o65fKXxISCbSSjcNiCFdioHsdejiUbTNZ
 TFcjR81K9jD56/NjZK2E/OTNtlJaBHJdvWcl5J9/aVQq3RAzC3cG0/hGBMX+1sU9ygfS
 60O9abMM15r3JZmcmFJYi4Onj/lfPUXrbPU8PgRy5Qnt22G2IOveLdHUHu/ubMZfMcSI
 gxS+WaKvbT+PKC4h56GXxFzZg+duF4QMz4MIynbMd1tftMkX94GptXpRYq5jttvp2DHb
 THtBx0lghY07gII9jch+j3spXArcDF+ryPhrY3KCziH9L9tsq6Kq2SSMkRbd22MZ22AT
 WsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743492054; x=1744096854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=59x6vNvLsKAT/IxMI6FzfkqIiXL3jLpaLHobfpnQ9uI=;
 b=lR3NYXfneo1kMbSh7J0L+pC812+ruWkfULvSqOn6Q8SnDbBEYo2DB4z9nLws08h6oi
 LEvMc6Mbu092+LvQ2FffqDLbM6LrBpnNl5XALpvbZSfppK0/Ms9iUtDnir2uyz8pifLf
 gdzVLWfQhbbBlmpGkUIotY1GvK2d5BhYtEFAjHDpnKu2fCWh5SvE8dsu0cl3327aNn6D
 WViiodtqqKTpnRLcnGRzhJqvkOAyURMjmayAnJPXIZgTX82oge2XoM+HwGAlt/S39qZt
 x8Azi7Q6stFz7AleC33JNYOnUhSK4q7q3q7ArHDdejnbeFL50gIo9M1E5/UU8veUEDBN
 VtAQ==
X-Gm-Message-State: AOJu0YxaPZydcfTutOrGBsF7QfBA2SPzIayVAX7/h8FEzxrquLPFIBP4
 Z0lNRmBtuKC7OqfzZOKM6oZ1v7AZv0+Idtp9Pnt25/3e3QWvUfQB8lEIkG97p1XV1lBbBELeuOi
 1
X-Gm-Gg: ASbGnctQSOmeL60LCK0A5Qjo8U9FWT8x6gyGwNPioR5/1HhRTXCz8ZQbXZ36y3zqwxa
 q0v06u8fkHYrh29wlBJzOcsZgZe6v1ouPOX8CXuaFMs847ce8fyp34dJmLE0GtN76RyXEyKGtPg
 gsmFfdBGpR0TVxveLVs8qwH5uqKjWMaUqneJXTRVwo4RxGq1kRZpdFFLAH0cGT4NbNaXkOFOUVT
 /I29Lv9ayLQDMYpgqSYJbTJlHXP4m8ENLc0KyY1Sd9Qmp9jrMvktYTX+MXcnWVTnBvwbLFp74OZ
 uFE2bH2RMzhzIAg+m0GmT1orPmJNqz8ohgF+NTnZX4SbmW5owGe4gV3nW35huVCGEq85jkZfdIs
 4KztYJhGTF1bFAcICX1p7mCAdKAh/Tw==
X-Google-Smtp-Source: AGHT+IH54BsPAKoWSWRWHAFmBM0e2h2WzBr45wxZggSrRku018tG5EIAqlI9FfOOfezqdr5vpDs0cQ==
X-Received: by 2002:a05:6000:18a6:b0:391:2db0:2961 with SMTP id
 ffacd0b85a97d-39c12115cf6mr9816977f8f.38.1743492054325; 
 Tue, 01 Apr 2025 00:20:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66b015sm13744209f8f.54.2025.04.01.00.20.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 00:20:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/rx: Fix copy/paste typo (riscv -> rx)
Date: Tue,  1 Apr 2025 09:20:52 +0200
Message-ID: <20250401072052.25892-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Rename riscv_cpu_mmu_index() -> rx_cpu_mmu_index().

Fixes: ef5cc166da1 ("target/rx: Populate CPUClass.mmu_index")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 65e26e7a6b6..723262f4b54 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -67,7 +67,7 @@ static bool rx_cpu_has_work(CPUState *cs)
         (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
 }
 
-static int riscv_cpu_mmu_index(CPUState *cs, bool ifunc)
+static int rx_cpu_mmu_index(CPUState *cs, bool ifunc)
 {
     return 0;
 }
@@ -228,7 +228,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
-    cc->mmu_index = riscv_cpu_mmu_index;
+    cc->mmu_index = rx_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
-- 
2.47.1


