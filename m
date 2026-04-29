Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DA2FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwua-0001sp-Ii; Wed, 29 Apr 2026 00:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwuY-0001s2-4w
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:34 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwuW-0001Q9-Mi
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:33 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ad9a9be502so75844985ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438346; x=1778043146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjLJBh/2sBoiBZVwNSZgEPrK8yCfqynQ2ATHihNmoyY=;
 b=R7aG7bGtYlMtfeWQQWfQmMhCwTtvaVgOri3Tos1C9ueSbWneZUbLe9Q40LzK0/vLs8
 R2gDPfOIGF2+V3ovDDI5LOgkBOKXfO1e6k0oTAphGD4ovNOidSqQWOjjZYVNLnJBTAmI
 rtUC4Mctzlzg/SV+poVs5gTrz0mXqqLy88denXsDh9zcWr19d7TTgvEgg/5gynTrMUIw
 OF19yZuXQuNqSWEKbY9lfo0+nW7wA1D6BJPKKeOKt8V2UFFEmO0QYAOpNQFFdwoGplmY
 e3g55VIDMp5Arzkf9gM9JYZXT9CY9Sx8yhGIQKGhtPN2sqFmpG4YhBlYl9aUKSW0r/Lb
 eG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438346; x=1778043146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OjLJBh/2sBoiBZVwNSZgEPrK8yCfqynQ2ATHihNmoyY=;
 b=eGl1pVtXjZquyfOMI3ULSquaXxEcNbtJOsJZ/Dsn5E9mzNH5udIS8UiPkxSYgU+m/I
 0ix/QFkyuTsLO7nmq3hiM2iiP6+BSCnyCRMPlUpNqWAE66RWAIdtvyiBzk/LD5PYs5yV
 hViWUx6siK1AO3IGIyljjH8tfF0kpnjOvTjRigPplg41e4si5Qz7VV6P3ArnC55kfsl+
 t6VnmyX1aVnJr3RdlxOUFwrSdOG7NsaCEbgYu7oP3yaLDq4qxYfj6KSNKaMcY1MHj+YY
 a7bEYLJCqkkNytGrs2QZY25o5LTeU30AYNLv+jhmEmTWmVNWA0Iq9Vwt7YPCaS5vDuYS
 72qA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8snbiW0mwZAn9iKTNZOTjNKttwVxMW5mEMiEErkpSN0pZB2xVOb00OaXylo9LgGhvD+Z3gga9cLSnw@nongnu.org
X-Gm-Message-State: AOJu0YyEE0UpCuKLB+t5D9DhhoRYDOBXqcwyZEoryy7qcbi6vqJRFOf3
 JDh7KGAfDyu4wbjTfDy1tzmL5NfiPiJSLm9o/pwS2gyxcqVaDEF6F5M1
X-Gm-Gg: AeBDietbiIiJimtHpMWeE1acGmtWHiBpijO45QDgW5cu6MBCRsOr5iWxiNx5pu+HaBm
 jd6foL7UkoNK5rms0HqOyEH15UheUyBfXVdkvc5WuNThRSlHMdbuTACtXrph1ZX61UZMVxSMQ/v
 QJYpysUV2DuR68wQXLAyeAVcpNu+BdoXwBYUi0F+u+Q402HAHXqdhJWFkf+jiGzBnsFKtdL9cL7
 y14mjnouuvX2qT8dl7YIyWnENtiUfW83s8Y9rrIFOVCB4nJMn6BLFBnGdL0AfWqfi68a/xrBd5W
 tEDH6X61M86cw0yDlA1KEFsHYH0unl8art2U05dKVDPW8efioaq0NZUCkjMFaw5PKTXIIUc1Qgz
 YnB5w2XOWdD/mIRhAgWwD/AbgWi2eVKWv0EtABWPvgkVCR0wYGyB2fFIEO2aATP4ztF/fjQb+5K
 RsVzFZMR02edw6HVztXW0dZGqC8Tsi245jGRP/Kb1oaHDhD6EtB0yo
X-Received: by 2002:a17:902:db0a:b0:2b0:6e60:9586 with SMTP id
 d9443c01a7336-2b97c41380amr62436105ad.17.1777438346439; 
 Tue, 28 Apr 2026 21:52:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:52:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Blanchard <antonb@tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 51/51] target/riscv: rvv: Handle mask/source overlap of vector
 reduction instructions
Date: Wed, 29 Apr 2026 14:47:52 +1000
Message-ID: <20260429044752.4176397-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anton Blanchard <antonb@tenstorrent.com>

Masked vector reduction instructions must not use v0 as a source register.
Check rs1 and rs2 against the mask register when vm=0.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260417120626.77415-1-antonb@tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 5b72926b3c..e65356eb7c 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3265,6 +3265,8 @@ static bool reduction_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           require_vm(a->vm, a->rs1) &&
+           require_vm(a->vm, a->rs2) &&
            vext_check_reduction(s, a->rs2);
 }
 
-- 
2.53.0


