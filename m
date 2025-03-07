Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A173C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqX65-00013h-AK; Fri, 07 Mar 2025 07:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tqX5f-0000pX-Cd
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:46:17 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tqX5d-0007EU-Ks
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:46:11 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22185cddbffso55022395ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 04:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741351568; x=1741956368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zn5zdOLWrlPYSatPXhjUavXi3a/YRl3Hwq7GCOD2Vmg=;
 b=RoQ4a5MuMzlZQcexTDq0DAphvQSf93ADBA3h5wHMqkXC/aj9sIQBdl2Xp+MiA8Ziqv
 qeWsH0KRnhMblE6d3ysaPwrtwDnRtjB+VY6re1WbjbkKQW6NtAOD9N2Ru8b64yWRBJ8G
 +6T2zgIWTbQNARY2eV2B5sO09uPXaBeCbSjvPnvOgWYqax8tSJ8LfTljGycJTvsXZZfY
 ecexO0VugaiVDlg66QRqVQJvAb3F5Gam4b3Rsx+9+yJURIi0FU6gkxKuOsT0Zdv/6WHT
 i/Ibtr3XDq95LPLhlhUiBBkabeDOREfyc5zvHD9VfSgb0IZG0HRcb5uOGio6oUCFUsoV
 NBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741351568; x=1741956368;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zn5zdOLWrlPYSatPXhjUavXi3a/YRl3Hwq7GCOD2Vmg=;
 b=QiIzgyZCQiXtRGMiaXIsgqXQTnr5ko9OOtMcWAZde8ucR77acJOq8NK4iSOGfhNBP6
 qmuom95SSOmqIgOtSf2ngsQX7Q8lFcFK2yEf2OKUED2pzt6U4GcoAm4PnOSVdcz2yGfZ
 s98LTQlmntBjPUctu3LMBA9GwnQ5Sq8vlVc3C9t2Chx2j0gFr9PPci5NNmUpLIEcnl0R
 ha/BPzSvye/BRIX7rytobCmhS1foLg7UtI4qg88+DuiMSX2oZCk0zVfg+hdoRZ8/oA5f
 GB8mD92WNuVFn/lZZcj6G8i+lqKVq3PtQiK9qMlU4IqDqt+5Myxmogi0vD+MDMiwrNMY
 N7Sg==
X-Gm-Message-State: AOJu0Yw8MEf77j6rZh3Q1/B/9HLbZGA1k2B+elDoh2F4bZiVYOetza1v
 CZiAp5RUWbMfFl5ozgN7sPmIAmXB8rDU5s4/gffgteb+/ZxzSJm7QmORC2keJ4VMncToTsZZLy/
 g
X-Gm-Gg: ASbGnctbkn54Iwp/ez0ys6XjSFGZdXgsI4nXT8VwGx8kONTslFVXo0geKhoffVJA84v
 a5iajpRiN8MkWQQ/r5ZH7um1HPwKOkQ3LxIt5Z9v+UQPa8aABpugIzrE28NWQC9m1iKV8D7mpqe
 8yPO+l4rZLQCPqGE1DIe64kTtO7/HXaS4SF5r54YNcGcnfcZAhDoeBlPbMJSC+AKQPLa4/pNWi5
 mWLq95YlY35/JA8qsidINkhnAJjrVoqxVOpLTcjf8mfxqElOcu2Xynzc9/D3aQ7/3w1nnMTZjLe
 Tw0IsjofTgWDh0lqm4NB+5E8Ddmd3xibg2YXJdN50+gaxapwrDyLlbDaFO5GMikzaCki9ZcA
X-Google-Smtp-Source: AGHT+IFVmg8qFh8I9aVtKBGgeKF6O5b5bJmIaCvp6KJncWlKmNT3DDnHFcWCdLcdayXfHq3/Rwfjxw==
X-Received: by 2002:a05:6a21:6d96:b0:1f3:20be:c18a with SMTP id
 adf61e73a8af0-1f544b185aamr4721978637.10.1741351567806; 
 Fri, 07 Mar 2025 04:46:07 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.170.118.40])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7369844cfeesm3123588b3a.77.2025.03.07.04.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 04:46:07 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] target/riscv/csr.c: fix OVERFLOW_BEFORE_WIDEN in
 rmw_sctrdepth()
Date: Fri,  7 Mar 2025 09:46:02 -0300
Message-ID: <20250307124602.1905754-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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

Coverity found the following issue:

  >>>     CID 1593156:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
  >>>     Potentially overflowing expression "0x10 << depth" with type
  "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then
  used in a context that expects an expression of type "uint64_t" (64
  bits, unsigned).
  4299             depth = 16 << depth;

Fix it by forcing the expression to be 64 bits wide by using '16ULL'.

Resolves: Coverity CID 1593156
Fixes: c48bd18eae ("target/riscv: Add support for Control Transfer Records extension CSRs.")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0ebcca4597..e832ff3ca9 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -4296,7 +4296,7 @@ static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
         }
 
         /* Update sctrstatus.WRPTR with a legal value */
-        depth = 16 << depth;
+        depth = 16ULL << depth;
         env->sctrstatus =
             env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
     }
-- 
2.48.1


