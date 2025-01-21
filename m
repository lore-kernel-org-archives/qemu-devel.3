Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D51C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJJB-0004K4-NU; Tue, 21 Jan 2025 13:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJJ8-0004De-DZ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:49:02 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJJ6-0005Ku-Eb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:49:02 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2156e078563so79622775ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737485337; x=1738090137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwNZlRoqWyY0SU1aH3L8QCTZcSYByfezJsd2zpb077c=;
 b=NkmqG7FytJyuq5TqE22RQpo7umxkpjAluo4Xlx5rvMaVaFARAKNxLyYxN80o8gobsO
 HojZLV5/aDOZp2tUj1maUHZ/UXhXjPJsrGZznMxv7DYG8UFVQ+OpAu5Txa9UF19RvBaY
 LGo0NEcYt+wJktfBk/pBpw9xEecW8a4e8CwJaM7i4t9WciVoR33DRAfjqNS3Ne8vL6pN
 HAhSAKP8XlH0Tp8f4i++PEogSMPiqlcmv/19bXPM55Os6AWaTBAfOTUSGGFSuhvTfAae
 k64l/XDQPv1vdLw634zbLZAvUYqM3BrkykqL1v21NTIvqSquzGIlQRzZJN7KTyJ4n4gw
 7Ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737485337; x=1738090137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jwNZlRoqWyY0SU1aH3L8QCTZcSYByfezJsd2zpb077c=;
 b=p2/4/X4M88g49GrcPISO/5asJGrQ5z2+UYOz7WXH69XzntcEQPNn357Q/Uh1PCkZu1
 x1CnCQsts4cO4Nkmb6HgP+cSb+f7+RM0sEbY19Pzk9MGP5heFIuFZKaTDlUD9hAvjyot
 LZVPTIr14PCap3futtsEQ5T0kv7QWhXL0YSlsKhSFlLGkYN8RaoxzEmzbBMiajLT4duN
 67mDAAF9TUxsSS5XvkLw+WuRHp5ygljk5bBDhbQSl02OkeQEl5xiAPi7l4gT7a+1oV0+
 Sp2SMEyYP9V1WFFVy3Cj0TL/s/v8MQbQqY0/ab2z5NAVgqyL1S6RfDv/PKZwSeQ+D2Cx
 6uOg==
X-Gm-Message-State: AOJu0Yy/BaOayu6QhgzSZb4oD8Yp+OpAoCtou+tzt2XuAalPiwhSNuZn
 YBg15iPhvMTvTBuFFs+2DXlo0ZYeTv983Y6ZuNgAtrowsoZryFeWfYqvDOGEB+6j5y6vpklQMf3
 I
X-Gm-Gg: ASbGncu+lVKjNDY/gz9+LgjG+q/yH5S7kmI6A7Oefa0C9bzGDsUFozpjJYYju/9QuNy
 TMIlqdCQTaxVoMgrDmanPvgGw7uCxTrvg/ZgYQ9PUI1zsxvYIg6dCZqgS5JPHk3c39wWabLWG5X
 bHPiLitgDv0BquPqmA1N7rYdsv3EksMwGOllcq7UdcPQ9107aeZX7qSpTw0QFJwuJCTN9NIeDDt
 OBLswK/PlEyIoZ2CSgraWVJXQTWh1NnPXIzD8U0btMDa89UHYIw4xj59kZsDLfSint3eTF1
X-Google-Smtp-Source: AGHT+IES+x/bOnHhe+f7tnLZ4Vm12kVcBrWDBsxY62avdwz7s7sHRLU2wB1OQTetrXulnmxObeO32A==
X-Received: by 2002:a17:902:d511:b0:215:75ca:6a0 with SMTP id
 d9443c01a7336-21c3555b09emr318630425ad.29.1737485335959; 
 Tue, 21 Jan 2025 10:48:55 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ceba56asm81121865ad.98.2025.01.21.10.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 10:48:55 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/5] target/riscv/csr.c: fix deadcode in rmw_xireg()
Date: Tue, 21 Jan 2025 15:48:43 -0300
Message-ID: <20250121184847.2109128-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
References: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

Coverity found a DEADCODE issue in rmw_xireg() claiming that we can't
reach 'RISCV_EXCP_VIRT_INSTRUCTION_FAULT' at the 'done' label:

done:
    if (ret) {
        return (env->virt_enabled && virt) ?
               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
    }
    return RISCV_EXCP_NONE;

This happens because the 'virt' flag, which is only used by 'done', is
set to 'false' and it will always remain 'false' in any condition where
we'll jump to 'done':

    switch (csrno) {
    (...)
    case CSR_VSIREG:
        isel = env->vsiselect;
        virt = true;
        break;
    default:
        goto done;
    };

'virt = true' will never reach 'done' because we have a if/else-if/else
block right before the label that will always return:

    if (xiselect_aia_range(isel)) {
        return ...
    } else if (...) {
        return ...
    } else {
        return RISCV_EXCP_ILLEGAL_INST;
    }

All this means that we can preserve the current logic by reducing the
'done' label to:

done:
    if (ret) {
        return RISCV_EXCP_ILLEGAL_INST;
    }
    return RISCV_EXCP_NONE;

The flag 'virt' is now unused. Remove it.

Fix the 'goto done' identation while we're at it.

Resolves: Coverity CID 1590359
Fixes: dc0280723d ("target/riscv: Decouple AIA processing from xiselect and xireg")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/csr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index afb7544f07..ab209d0cda 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2658,7 +2658,6 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
                                 target_ulong *val, target_ulong new_val,
                                 target_ulong wr_mask)
 {
-    bool virt = false;
     int ret = -EINVAL;
     target_ulong isel;
 
@@ -2680,10 +2679,9 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
         break;
     case CSR_VSIREG:
         isel = env->vsiselect;
-        virt = true;
         break;
     default:
-         goto done;
+        goto done;
     };
 
     /*
@@ -2705,8 +2703,7 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
 
 done:
     if (ret) {
-        return (env->virt_enabled && virt) ?
-               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
+        return RISCV_EXCP_ILLEGAL_INST;
     }
     return RISCV_EXCP_NONE;
 }
-- 
2.47.1


