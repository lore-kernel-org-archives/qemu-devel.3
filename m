Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE67EFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwte-0008CU-8e; Wed, 29 Apr 2026 00:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtH-0007gG-Qz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:16 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtG-0000xE-5h
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:15 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c76bde70ec9so4924084a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438272; x=1778043072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ef1rMVpVBp+rw2rikkviwoFRO0mK/WpG+jCM+MhO/3k=;
 b=GMV8BAXxmOD5D6NOpWOPDsBSqM72hDupdo83IettYBLw7d/fAcQSuo2yKZ4Z1kYtfz
 l91ov1knUQkD33Ngg6sPnYwLfJSxMkK96P9bt2j1qdFwuku3YcysIdAwDyJVr8l2TkTP
 inUEq0Hn7H0ppdzyj42xzqngxQB87JcQrBLFvy9xHRjhbYygrjE/JAOKVJdRMIv7MttY
 aPVh3f5TxlHAWb+hsQK2FHCiQ8KV9cyJ5lTF9WdYf3V38MQ6wwtc56EG2CkvAgu9bQeW
 e20fS6xsOj7ftCHi7NdftsM7KkGmDEjcDmjRO590ZvHDQq+89H8yWcHSv+gYNeeZNkmb
 WnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438272; x=1778043072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ef1rMVpVBp+rw2rikkviwoFRO0mK/WpG+jCM+MhO/3k=;
 b=YAmbOOwHmqQm6dQOrq6CTapId9tXlz8+P2B2bVlGWb3wy1yWSH1znNQEOTUj0eou51
 Z0p3+cIZa1Yh9Lb4JTpSMRGhfSdlZHfGbOUJFsvBKtkbAe3ugmoVIne27WLEXisY1Ozl
 stwKUC8pItUoVr1dpl8W5RniS+0eyLOekTnlGupIpML0+diuKJ5iB4dMMJZR1+k4yvrW
 9xD6E6PwmJ2tkYlUuPqK2LtGUrEkgpN1BReYYZ8plaKOTrsg2JgWhfVwjk2s47qolEHH
 68vCWfrESGKqDoXS5WqYSYwronap5dw2G2KaOHf2nrq7CvmGXsy0D4K4OFaVzwu+HqKt
 SJvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ//1s8fOiI03+IU2e0ewOypWmQ/nbhtLdsoC+LwVRMz8eSW+OB6y3O9UAwQawRwNQtw/nqfQP92jhFX@nongnu.org
X-Gm-Message-State: AOJu0YxqGkPeoGzOoCf7JRwgkzWi4y7slPLym04nmjNsSgX0gR5Zv+l2
 rm25jpLr6gENXnmy8+taxyzyT+86hd23j2f5xfsL5lN0gEjLn2lcs+7DRdQRQA==
X-Gm-Gg: AeBDievYy4kG6VhcVyW7ibwwBIk8vwZ2P4FRv96c/Fmm1aSrTgIV7B+VlWkR0DcMlmD
 1LFlIBHYxfxavjLo2HpcQo6oEOhoIz02TKz8CP+QaF1pC7eVyJABF4YiTrf2UUB4oa+gGJhlg1y
 SwS+hZan6AX3aJbw4wQ+dqX7GMytygw6gBoymIYIhHulCkRCJUneB8WCHIHOJXcvo4nlp4MsAg5
 qbok5G9EluSisFNCnJRiZ8Ynq6MDHX2wLXI+naDjSHtAy8ere+eary9L9zzdWTr5vYhlvYyhj+9
 /VB60A08cNNHcvaCD4pj2NoepcfxriPds11B26CAo/OlDb5n/4uIC/dFjpL0+ApzRipYUZZ/kFC
 0BinjHJyXYxG8fwQqrn5aXz7LDkKc8bJZRvadaoiHjvgVcHJ8wJsfALkT6JoAMYFB5FhksT3C9B
 wdhLETkQ50PotGr4w7CxMYAsSAcqd2k5EW9mnKqAA3pAUL0KOkAHzQ
X-Received: by 2002:a17:903:2ed0:b0:2ae:cb0e:fd59 with SMTP id
 d9443c01a7336-2b97c4120bdmr60186075ad.8.1777438271678; 
 Tue, 28 Apr 2026 21:51:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:51:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Blanchard <antonb@tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/51] target/riscv: rvv: Allow fractional LMUL on vector SHA
 instructions
Date: Wed, 29 Apr 2026 14:47:37 +1000
Message-ID: <20260429044752.4176397-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
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

Vector SHA instructions incorrectly raise an illegal instruction exception
when LMUL < 1. The ISA only states that LMUL*VLEN >= EGW:

  For element-group instructions, LMUL*VLEN must always be at least as
  large as EGW, otherwise an illegal-instruction exception is raised, even
  if vl=0.

There is already a check for this:

  MAXSZ(s) >= egw_bytes

so just remove the check for a fractional LMUL.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260104233724.192886-1-antonb@tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvvk.c.inc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index 27bf3f0b68..32255d3aa0 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -426,8 +426,7 @@ static bool vsha_check(DisasContext *s, arg_rmrr *a)
            vsha_check_sew(s) &&
            MAXSZ(s) >= egw_bytes &&
            !is_overlapped(a->rd, mult, a->rs1, mult) &&
-           !is_overlapped(a->rd, mult, a->rs2, mult) &&
-           s->lmul >= 0;
+           !is_overlapped(a->rd, mult, a->rs2, mult);
 }
 
 GEN_VV_UNMASKED_TRANS(vsha2ms_vv, vsha_check, ZVKNH_EGS)
-- 
2.53.0


