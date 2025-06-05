Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F81C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6Sa-00039H-01; Thu, 05 Jun 2025 05:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uN6SY-00038w-C7
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:00:26 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uN6SS-0005ZB-Pi
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:00:25 -0400
Received: by mail-vs1-xe41.google.com with SMTP id
 ada2fe7eead31-4c9cea30173so238206137.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749114019; x=1749718819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jHTTv6qaPjg9mjTN+H6fpzOa+vA+iw+s8NFNFON67iA=;
 b=BWBgDDJcFNDYUGrtlOUoNq2xSpFme0mv6GQ+JnHoYLdcf/BcogKBibCiUUD/sDe/ZF
 XCQv7Q06F0ijgnIGTqKmkWTzWUZ2E+2I6Sgb7nHoyNS44AjWRMkkIJ8nxq9o2MszsvBj
 ymRKYL6QLPQfknC2gzvAPl1Wc2+LNUojEjF4h7x3HEErA3O+DhkT7BSsH5V8N5BcNtyt
 mpPD91AshCnTrt2YGS7VmkA01o7vWfa2RRNSW+bKXFs/FkTLih9tuAMbuitLORx4bSe0
 cAWrUqU2US2UH/1O5qCmCmtqGXNn+WxvuL/KkXBjSib8MhzXVavtOgnR3cPFAknEkEzF
 Crxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749114019; x=1749718819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jHTTv6qaPjg9mjTN+H6fpzOa+vA+iw+s8NFNFON67iA=;
 b=jn7Gzv3c14fkEPvEFqNuFtRUqEmQTxbsRj7G/ezSGec6aa8gv6+cQjRcq18n2DmSxJ
 5cY438P520kYGexK+N79cJZQ0xGOEP9EYyhhtke6cy+s9HPVrs03fsvmZZBEBxHETpZ+
 mKeMZIhyKrPrdGB7QZrjBR5YKceKSQYEqjnpES4OuumJmOJ1YMCSW7P8W5P3u8iyrX8l
 Y3ekNngKMzlHMGNX3uV40VmZwTGmprv8+qqOsnMzXlHD1/WmFmRAqopZNrhCjUNKPs4F
 xEUmr2Mb3m6EZ1zCSXuYDlgY0YcO1+ZcOhHZZIB7u4daf0mCdMblFIBbhsKYbE4sfvtX
 YkCA==
X-Gm-Message-State: AOJu0YzDiPteY6nRTtyRhYhdTOcpKYKDODQzUkc3pxDC8gd+SGMmPh6g
 XDYmzMlwskwuPYit14WTsjRY0med1Se8SSjCaydfAvgwb1RdHJlAdRx7jA57zl+P5KQNXRBlSSZ
 FP61rmwlo+g==
X-Gm-Gg: ASbGncsUoBHdW26sHhoxuhDcG9Vv3ykerYqs8yrYm5jfiNx3APvwjE+LD1M+EqpQZne
 aEQqUR/y5pkPHReg+aUzcYluJb8CXqOqpiq+HtnSVBtuqApeyP9k8yl1qV3VAlpeTvLVToq6ZuH
 sIzDL/r1r+or+Xv9/v5EMwheWvQU739dG00KC4qILJlW5WMDbvX+ZMorkM0FuAoBW2oqsaOBUop
 46D+U0wgrScIQBQUA4oIAcIcP6dfYPFJdSytWEr4qEHYS93YtkSd53wXM7wvoT7NCbM+g/Np+ly
 raKcSDGXXHl5WCwXOt/anJA3Z0WrRHODs5hJodhffPz4MNBQA2uP+qqONIsutaB3LS3g/xUGFqg
 /oI/8GkxKCyx337c=
X-Google-Smtp-Source: AGHT+IHS9BWgKA2/DTEfD7xIQqdPXHgWBPHxHyc2LkOP8z9a3ZaTccBpxPZNfGhy7ArAG9P0zafjLQ==
X-Received: by 2002:a05:6102:534f:b0:4de:81a:7d42 with SMTP id
 ada2fe7eead31-4e746d11581mr4674544137.1.1749114019150; 
 Thu, 05 Jun 2025 02:00:19 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87e2a27de8fsm10370670241.7.2025.06.05.02.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 02:00:17 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] target/riscv/kvm: use qemu_chr_fe_write_all() in
 SBI_EXT_DBCN_CONSOLE_WRITE_BYTE
Date: Thu,  5 Jun 2025 06:00:12 -0300
Message-ID: <20250605090012.1268809-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e41;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vs1-xe41.google.com
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

The SBI spec states, for console write byte:

"This is a blocking SBI call and it will only return after writing the
specified byte to the debug console. It will also return, with
SBI_ERR_FAILED, if there are I/O errors."

Being a blocker call will either succeed writing the byte or error out,
it's feasible to use the blocking qemu_chr_fe_write_all() instead of
qemu_chr_fe_write(). This is also how SBI_EXT_DBCN_CONSOLE_WRITE is
implemented, so we're also being more consistent.

Last but not the least, we will duck possible changes in
qemu_chr_fe_write() where ret = 0 will have a 'zero byte written'
semantic [1] - something that we're not ready to deal in this current
state.

[1] https://lore.kernel.org/qemu-devel/ CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index e1a04be20f..86724e5c44 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1605,7 +1605,7 @@ static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
         break;
     case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
         ch = run->riscv_sbi.args[0];
-        ret = qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
+        ret = qemu_chr_fe_write_all(serial_hd(0)->be, &ch, sizeof(ch));
 
         if (ret < 0) {
             error_report("SBI_EXT_DBCN_CONSOLE_WRITE_BYTE: error when "
-- 
2.49.0


