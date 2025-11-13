Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53B6CD8CA4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 17:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJawi-0001Q2-8X; Thu, 13 Nov 2025 12:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vJavj-0000Sw-PF
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:16:22 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vJavh-0006Zr-Dd
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:16:18 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7aae5f2633dso1289481b3a.3
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 09:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763054176; x=1763658976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSZeOBRdaJtR4VSZeBosQBp8vrblOwFu5a8eIkNfB8Y=;
 b=m7CIWtr30j5cCa/UEm2u/pD7xFPxej8G9DT3hUIOOQ0q28DuP5XOQh6IthcimVL0aj
 aqmiZYkqbV8sr1x6QPD3gE0Cax/C/ODz6WFqokKC5KM4HC+BYt+Z4WF61ngLjGBthAm5
 HQZNN7uNq74xRysvapOTMysR6Gt9+VQ8La1i3l4E5qHPYZH/ZtHaRvlk4UvxJEHe6xoY
 PVz8afIuFIUolbx+QNlhAUxyb8RQB7PQm+GCeRV3fyN/2WsRR/jTfVwPGrawd9xxkqIE
 dVdub3UBXTK7jNhHHvi7/V4lbDT9dv3EgD1+IekWQBbgt37GJABRE1cscu2EAOrrhZxa
 WF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763054176; x=1763658976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CSZeOBRdaJtR4VSZeBosQBp8vrblOwFu5a8eIkNfB8Y=;
 b=s3VQ689KSRRe6apj4+fywjRTgfJnpfyhjfEmIvQRJxEORVa3EGb2M+cep8tgGdsIaj
 c1d/rjBAIZ6M/OqtXiUTpCiO4NxW0lG786ZV7PG3jlbVj1KilnIU08LguUR3du6vR7UD
 CEb5VT6w2iDv37Xx/5TkpUf9IN29pMJGyZFAsH/b7R+RTY8nolYOHu6eidsVk++Hxjzn
 nc5+lBvMhWoodvYqU68eVSc2g+dk4xL1W1PJBXbKDAFTQ0FuBWTcEg3BRksOFCuqMHh/
 L5j0ppf5KHUHsxQOR/9ob5nkdkvDV1c7dKo6dB4h+Mm43WleqO9DbSdgtjCVh2BgYPQd
 0T6g==
X-Gm-Message-State: AOJu0YzQJmWo/v1QH6FjBeoQVNV1F1TzX0lglBxmqYeulnBQM8oy1QLs
 nSEpmc/pb7lZPgrg3v+Uz97J0SG4H0sbPDmmakWcAE8Fg1K/J0H1WyGyh3LN2n2XXAJ7363U8JX
 cMb53yVseZ0pn9btYESKT5xem0xmHveyaau09Gz3Jrc/QYCd8HCJBZy8+ZBC+iUnCS/RAKofVHV
 7JM5chgBckwroc81p6rsVpqNNLIM/IjOhHJKjtR700RQ==
X-Gm-Gg: ASbGncskvE220gdT3VlWNJr+ZrN8ED23VHHtUjqclkebUyt8PVN50q81OuH9u4g2BnG
 0YRxUKUqPBd0YflYsBeUKolRZcQLvSm1J/8LjoBpMYk8A+76gmy86SqvdxIGys8Tjam6NAyDo7S
 muwtS+BbsK23XImrousG9hLw/huinmEK4NMX7YcjQnV8WXG+EQDga48m6yvlfSMaQ5HR6q6pYg4
 u5ekMzd50QDV/XW6+t0FHNNTTuqJz5+I/07MAo2SYbVWxOVbVNfw/IOJdNPesHidsfgcvo1tinQ
 m19a5ClBS+O6gedlVGmn6RbuZ9QZyLMTGqOddb1/tw12EBqhCaoTP6FYcEfVUMVpIXPDYOoLTOl
 zjlu8wV8Vkx1nM1FE8haB2h6dS+Q8aF8bXWkKaFht0n9NyzOz+3uXR0sO4VKdzekhGmMpDpuNvA
 BAun6P/TlHP0Jaj0RMlG1tRnZLjHGASaSdupoVjWf2TAMdVdrHjpCC/JY=
X-Google-Smtp-Source: AGHT+IHOQO+2owWcCKWIyQ3fBALgs8pKDWv/mNb1FtumrHARR+2+DKcMOHjAytEjVM3Teu7qEPdOpQ==
X-Received: by 2002:a05:6a20:72ab:b0:334:a784:3046 with SMTP id
 adf61e73a8af0-35ba17aa0e5mr367978637.38.1763054175723; 
 Thu, 13 Nov 2025 09:16:15 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bc375081023sm2712992a12.21.2025.11.13.09.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:16:15 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 2/3] target/riscv: rvv: Apply vext_check_input_eew to
 vector reduction instructions
Date: Fri, 14 Nov 2025 01:16:03 +0800
Message-ID: <20251113171604.3034161-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113171604.3034161-1-max.chou@sifive.com>
References: <20251113171604.3034161-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x434.google.com
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

From: Anton Blanchard <antonb@tenstorrent.com>

Handle the overlap of source registers with different EEWs for vector
reduction instructions.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 422e1a21185..2d9cf27ef76 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3076,6 +3076,7 @@ static bool reduction_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew, a->vm) &&
            vext_check_reduction(s, a->rs2);
 }
 
@@ -3092,7 +3093,8 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
 static bool reduction_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return reduction_check(s, a) && (s->sew < MO_64) &&
-           ((s->sew + 1) <= (s->cfg_ptr->elen >> 4));
+           ((s->sew + 1) <= (s->cfg_ptr->elen >> 4)) &&
+           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew + 1, a->vm);
 }
 
 GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_widen_check)
-- 
2.43.0


