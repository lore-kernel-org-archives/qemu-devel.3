Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592ECC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmp5-0002Ok-Pt; Mon, 27 May 2024 22:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmp4-0002Io-7b
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmp1-0003jD-Dt
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:21 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f47db642c2so2861425ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 19:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864257; x=1717469057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPlluaU0uKur6NZ6KKIaWWCj2wxgWKV0EN/SjQ103ro=;
 b=inzHFm5PgjvUzerxpCyEqauZStu/LYIrBDqQAh46HWxXehZGmw8m0B5tUELjlr3BDP
 K7F+andVXGbi3xKDDfV0Qb4JqWV3fMcbtEBBvy7O6nmKMJU7Zf1HOQdjG9UOKgVKgRt2
 1BUAAB2iOivCa1uo/3xIHCoLisw4ugs5BWJMB0QTUQcgulsMyb+YJLSx32tVZpF/WOvV
 WFPUNvaJ6sm9Wg63nUXrGj99FUQhyDBSrgx0eF309UEzXvNHZ3hht0rAdIR6FdpA238a
 2lSICcXrx7hW6HNRa7g4OgaJ4UUhRsRRVRSHXHSlm6l14A5llLAA32NOD59hn5DOLP1t
 ez5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864257; x=1717469057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPlluaU0uKur6NZ6KKIaWWCj2wxgWKV0EN/SjQ103ro=;
 b=uN+QjuF6CKaI3skHBqF+N2kP8Hiui0ArgCHdjRGaghaO1ZINmScbZm6fzP8i8MB0c2
 T33a5dUZlCWcmf8W/wg3HZOjA9zN/RujlAZwh2afA4h24O2K0Nm8Zh/ystju3za48Ibn
 efB+S7muQ21ifhjrLz2aiOJyIWJDI+sQE5lCTvWQZ8fO2nmZbqyT7eKUc1gh+giptFLs
 UbxJn4YbL0Uj4Y7ssGzmH0vg1V62cgTDttSgWA6FknaarUchR6ssxdqQ3Avyhosj8CC1
 lEFfDGybfLkacwC9ltduZSPS2BhsktRr2Nal6pwqi/L8hSThXjdY01qbLuN7WZm/5xXX
 6jAg==
X-Gm-Message-State: AOJu0YwKrN9W4zbyjEV8GpiuSR2E7IMUcrjWZbDc+RiiEhbrTlHTM66t
 BbLStZNh3x/uVdCOFWqS2H5ttQjHhXtVsDE71bBdi5sYADSspQBrzaKrxw==
X-Google-Smtp-Source: AGHT+IE4BqkIkrCf0+yByLcMM3G781L4+L0Arn895+9fyiOkh+ZS0lOrX5+CNQXxuQSS17/5Xmy1LA==
X-Received: by 2002:a17:902:f791:b0:1f4:6b1b:9439 with SMTP id
 d9443c01a7336-1f46b1b987bmr90892575ad.53.1716864257432; 
 Mon, 27 May 2024 19:44:17 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:16 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/28] target/riscv: change RISCV_EXCP_SEMIHOST exception
 number to 63
Date: Tue, 28 May 2024 12:43:06 +1000
Message-ID: <20240528024328.246965-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Clément Léger <cleger@rivosinc.com>

The current semihost exception number (16) is a reserved number (range
[16-17]). The upcoming double trap specification uses that number for
the double trap exception. Since the privileged spec (Table 22) defines
ranges for custom uses change the semihosting exception number to 63
which belongs to the range [48-63] in order to avoid any future
collisions with reserved exception.

Signed-off-by: Clément Léger <cleger@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240422135840.1959967-1-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index fc2068ee4d..74318a925c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -670,11 +670,11 @@ typedef enum RISCVException {
     RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
     RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
     RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
-    RISCV_EXCP_SEMIHOST = 0x10,
     RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
     RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT = 0x15,
     RISCV_EXCP_VIRT_INSTRUCTION_FAULT = 0x16,
     RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT = 0x17,
+    RISCV_EXCP_SEMIHOST = 0x3f,
 } RISCVException;
 
 #define RISCV_EXCP_INT_FLAG                0x80000000
-- 
2.45.1


