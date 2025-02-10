Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10BEC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thc7W-0002Tx-UJ; Mon, 10 Feb 2025 17:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thc7U-0002QZ-Vb
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:19:13 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thc7S-0002ye-DX
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:19:12 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso11261995e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225948; x=1739830748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bm3IwAVfo/Moh0xAEaNpxkkhaYnZBCTmolWG6ZgnfJI=;
 b=NQY8n0fAcPUsZWMlPL08uL8vC1BZ1e7DzvKbStUaZb+0v1E5ZABuvHiWFtwB/cIC1V
 tg6Rsv/Cw4Xsf8VoXKKpytj1uGXVvC/l1rBtn8yXKh/H+ObagNgzBfNglh5FzSu5W5aO
 BGLwjxb17w9ZTU1r2xK0STDPN8MBj8GS5+ptx8PWp5mrkSIhTy5+TowLw4N+TKVRG+N5
 gW2piE3/OG4yf2jW/9AMbm3txYZrYiLM03Na0VJdeGTO0VPgsDK1bAhQG7mFcazZgWtK
 9CYMi9N27L2Ask8gXXfvn4OzKBi8qP44vBYkpznl5v0MZUoSwzMZ/BQ2dt4N+sASi6r2
 w2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225948; x=1739830748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bm3IwAVfo/Moh0xAEaNpxkkhaYnZBCTmolWG6ZgnfJI=;
 b=g9Eck2VVtoXODzUlCnVj4pGKyfdeHdMPEbi1FReeuIsJNRyY25FiUwDhZ162gBzSIQ
 QJykUJ1TOQ58QwmiUQikj6o4NxZn7zK8aKSywrV8C4ISLlu1DInd++UInF9KczwaWyh7
 WTGJSwTtXKcjFAKxA9UIOm8plSnKWFwsOmBJXnwsmNVQYz7n0BQRVr47crr4q1LDTktn
 iTEsbdrZaPjv6mRua+YB81ORau1rSmCwYzDbwEfy689Y6+S/rqc/ASc1q2pQcrQRsDjW
 zPL0XZ9qS8pWySEbbjY8VrAeq1l9HbHMcuBAARabJc0Al12icuqgxyatLTkrB4ocH3qb
 f52Q==
X-Gm-Message-State: AOJu0YxIeni1roSn1tfMZBKhzahRS3FDTLOwrkbJ2GDyNUzA+16B8PMg
 inpEmOLoCsMOiSfQXlhgzgTGmlcvOFeMWXxKu4qai3ZX++zadZiKDFTwqT4W46IbgwkkzI9rLhS
 EGLU=
X-Gm-Gg: ASbGncskCARQHXHAckLC5ZqfqNvohhrez1HSzVLd8NVkXV3IvmVc8BloVvk6+OArylQ
 ixeKUz3+uETy3EzpPMJvM+Yolv76fxEYKUgSatQPNzPanMxQeqPdQgStspfN/FCx+hJxLIZUP6f
 5D2/4v6w4jizhKGqZbSroYi1VzesCmp8cNKL0dFfn/L2dTai+att0U1q4QtsHRMY2cJSrkz44/n
 6mXsxvrxVZFmkXLacYqKClNwO0TOEoXcjc+OEjCqDw5UwhCDsg21MLVz7/vMtYLS4SCAGJMNjt7
 LunEYs5cKuLYQD9boPpZAvvdTNxT+CUTlxOiTju1+6LT7fBaQD/N7IxGR0tKhubKPg==
X-Google-Smtp-Source: AGHT+IF2LzLQBt39nyq5MTdT7uiohp8s32bwoXI45SnHWredDHFc00IwtYxb2b5mPVtU3JrvGHaWFQ==
X-Received: by 2002:a05:600c:691:b0:439:350a:ab57 with SMTP id
 5b1f17b1804b1-439350aad3cmr71255845e9.26.1739225948449; 
 Mon, 10 Feb 2025 14:19:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd5930aabsm7579434f8f.56.2025.02.10.14.19.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 14:19:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/10] target/riscv: Set disassemble_info::endian value in
 disas_set_info()
Date: Mon, 10 Feb 2025 23:18:27 +0100
Message-ID: <20250210221830.69129-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210221830.69129-1-philmd@linaro.org>
References: <20250210221830.69129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3d4bd157d2c..b39a701d751 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1156,6 +1156,15 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     CPURISCVState *env = &cpu->env;
     info->target_info = &cpu->cfg;
 
+    /*
+     * A couple of bits in MSTATUS set the endianness:
+     *  - MSTATUS_UBE (User-mode),
+     *  - MSTATUS_SBE (Supervisor-mode),
+     *  - MSTATUS_MBE (Machine-mode)
+     * but we don't implement that yet.
+     */
+    info->endian = BFD_ENDIAN_LITTLE;
+
     switch (env->xl) {
     case MXL_RV32:
         info->print_insn = print_insn_riscv32;
-- 
2.47.1


