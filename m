Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DC6C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeMj-0003Hk-A6; Fri, 04 Jul 2025 07:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMB-0002k0-Va
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMA-0003dI-9A
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:27 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23636167b30so8770375ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627605; x=1752232405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5v7HpHr7Qhk2U0fWT9R+9pp4SWemWrxnWXMn5hfBww=;
 b=JQdj8xbPze9dIijsnabnd9T86CQttDa/gPrH8u3sc0I0J/3D4oVTImMQf8wF8jJznq
 pXkJJ1EbSqOq8APYrN+OoCAgpTcyynYi1aZl0kX7Cefp+BhGIC4ccjZLzwxpYHj/Agbl
 wSvszIqr9FPd+GrQ8eJpqvuDjX5k+ZxIj4mWiKKfmgJI9CKzZNEgWF4X4wOuVpAMdq2C
 Flmlkg8wo2Wav0sILacBUCrU9XnIO/ylCENFM7Ugq5x8Px4QwZ7Nnf+OSB10T1Rx9Xnl
 P/XzJ3W3uVAse5IYw9w0saVyBa8YarH3djnESu7N6qbQ7qncE1LIVndSgf4jhlZIoR1e
 MJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627605; x=1752232405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5v7HpHr7Qhk2U0fWT9R+9pp4SWemWrxnWXMn5hfBww=;
 b=OzzRSk8T+VJLRSxuk7QpzPWtwUGMPcfgcBgEJ5MXUE+ZnNPuJYx9Pvi7ydlQmxJUHT
 hhGUQ2cGTPR7IoaShE1nXuokXuHUq/xJaEyaSZbOVG3ZLbv+WbBCNkhIHGkP/mnlV0a8
 /GjQuljRS4y0cnbGvMbrtgohCHs+XGXwsvcerrnrV1aadmHQXQxVXwyEyXRaxaNR/Out
 oOn8kCK2foCAqRud6eqcHNYYgD6pfx1CUD4zBRMx2eAUbTDuVzSCAOUuVKDkAEQImHzM
 LtCLbOtTWEC9Oh21RwuDQjmmvn4hgRSKArgd1BpF8ANFBOMpt31/xz0CVoJcJYtvKNlQ
 Nh3w==
X-Gm-Message-State: AOJu0YxaUwQ0BKXG456udy3ibXLqWgbkMHCrmchoEQHlr0LEXVOINWH+
 OxoxHLihSt/ty6sL/b2FHJwEeDXXrjHSxe3JNB7wCcBxbGoEghx/Ej20CpPXPw==
X-Gm-Gg: ASbGncuocYSld1Qpz6LnWNMXfLnIvcgPSzVPsZYIK0Zs1jfqhopwkwUDjFjsT4UcuSc
 K9z/hb7agtADu+b39V9vibNW4xusSlj4ZrGMArE8+cIpr18SDWX5M/3RMoGzGcLJtqWcEVFk+ru
 +s/+y16q5tZfjs2/FEDZ8nuGMODS/2QWhqQ08Zd2suMd3cPNRdeo+UzFiNWkwcENTvhnJ8djlUp
 BRS95ZBBCkrGdUlKFqPzd8gI6AC5y0Bg3Jpod2FlTApwyYqZUMOB0abkrAS7OmURPFRbiu2+cN6
 1Rv6K9BHuuqzS8j5OOcaLniGXXnvtp+eK7mLUDYq4fqs3of6jvB9n4a9pyiJ9hxpufssXsmbCwh
 20EOx+xbzyl0S2GHINv8LjsoqcF2uSSOO0ZQny/8cERlAUGUMtzNUwFzsAqCPkrrAqX8=
X-Google-Smtp-Source: AGHT+IF95knaZe5x/9LvJxfMHtXFh6QIoPGDLqXa4nktwphCDnt21foNz24y5sscCc/IU8SyRU+D7g==
X-Received: by 2002:a17:902:c404:b0:234:a139:1203 with SMTP id
 d9443c01a7336-23c85e7459amr34316635ad.32.1751627604703; 
 Fri, 04 Jul 2025 04:13:24 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:24 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/40] target/riscv: use qemu_chr_fe_write_all() in
 DBCN_CONSOLE_WRITE_BYTE
Date: Fri,  4 Jul 2025 21:11:45 +1000
Message-ID: <20250704111207.591994-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The SBI spec states, for console write byte:

"This is a blocking SBI call and it will only return after writing the
specified byte to the debug console. It will also return, with
SBI_ERR_FAILED, if there are I/O errors."

Being a blocker call will either succeed writing the byte or error out,
it's feasible to use the blocking qemu_chr_fe_write_all() instead of
qemu_chr_fe_write().

Last but not the least, we will duck possible changes in
qemu_chr_fe_write() where ret = 0 will have a 'zero byte written'
semantic [1] - something that we're not ready to deal in this current
state.

[1] https://lore.kernel.org/qemu-devel/CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250605094456.1385105-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 502d33f404..5c19062c19 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1619,7 +1619,7 @@ static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
         break;
     case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
         ch = run->riscv_sbi.args[0];
-        ret = qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
+        ret = qemu_chr_fe_write_all(serial_hd(0)->be, &ch, sizeof(ch));
 
         if (ret < 0) {
             error_report("SBI_EXT_DBCN_CONSOLE_WRITE_BYTE: error when "
-- 
2.50.0


