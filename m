Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4C8C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeIP-000240-Li; Tue, 03 Jun 2025 22:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIN-00023V-IV; Tue, 03 Jun 2025 22:56:03 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIL-0000Ne-09; Tue, 03 Jun 2025 22:56:03 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-234f17910d8so60377195ad.3; 
 Tue, 03 Jun 2025 19:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005759; x=1749610559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeGvg6cXzrjav0ZzmPvxc+8/oL/HaY6cVk0CyPTtjB0=;
 b=R3cIwhlJRiFUKsEnpoEUfeUxdBcc4bd167Z7iT0Prew/bceTV3b3ysvfRrXZtpwen2
 s4DjpzeMFcSfJtymjemcQ84gjBjwfAyoV2WXu1mSx3MRMP9tUZawsCKwjUuIhunfxKZU
 749Eg/VtIKEqZjC/0nNjomaGyHAMX4jQK7hlE39+rxnMQzs4F37W7mE/GFfz2GTgrt5f
 hCpH7l7aaQnCLIHP+MBjrF64o8Yb4QZIFfNqDtIu7dsVGldxb67NnoShZr6MTVA//rdj
 lTyE18gskbOQDfq83e/Z80L+uhD6cAzXFHCuY+akAMa4ilhX+2Z5GwpYI/BTCAF/UTaS
 1U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005759; x=1749610559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MeGvg6cXzrjav0ZzmPvxc+8/oL/HaY6cVk0CyPTtjB0=;
 b=Cj7CHGDqyYW4+UU+huX2HCwn5CEIpFqZEsNt/ufgI01O+91Rl/VFQJnRKB0t4NbhGL
 AlRqNP0gExncUWgct3BTCVhWZ3TJWN3MV5bMXAqiwuSaZO9ExG+feO+mavGt0llDoaNe
 tP5eddShs1dEq2ZJzk6mjyc9mtwOWEB8RGfmv20z7j1EBU73kPAyJiPIUMKlpgGF7/V5
 oouRZ8QHBW/pa4xm5mHVsQyYT09lGOViVk5WyrgxaQHW5SbiZUn8IHqV+JOXHOzHwTpK
 QAOzfEOquYomyjN41nZcRFvbw7A2nMx7PQKixXFnKO5IPO3w43XnDzjhtBa4P4dQPZo9
 P9cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoGMEtOnKRVy1dPQi8OCWeW7PxxMQKbUuvjo4LT44nM50Yk1zndEqiTqEKy0OxRvYSKEKUELfnsv/+@nongnu.org
X-Gm-Message-State: AOJu0YyvPyaK2H/fUPNbDuYaWXyVfb1FbHBuCTSPThJ4QUJm/hBm/iWG
 8ByI69R7UioS1Qc3CgKFcrd7OV7BGh0MqgswwU2hVpGDepgtsHGlJoizGNtk5gkM
X-Gm-Gg: ASbGncujPt/puvOj+XbaDaZBO9Y37/EejUQDouaPWP0s5+PtFsvrwSD9l0eGRPsZDr7
 6jm9uc7hejY0zR/x5B1vK0m4TD+im+Z2Brd2VXsMeQWGz6Xupf+PVNfseDrzmX5B63YDxGPBHxu
 EabutmszXJqWvgwRvbkIX0/JL5DwecTY7/AV2mLq3cGR+a6zAMEYCrhewVrcX1c9+1wNm49fEna
 SvzAYmcBuRNcmRswKQ1nO9RC0x5EaJr2xvMhMHxuBjnENw+reodTeV94fpbX8uxcj8/aAslW1b2
 HdVNtjm6Sc3VIrJwZAv0P5dF+lusligVAEJsX8Eu0jXpmT/jCGwdl80eGpdW1xGP6APPUPu/
X-Google-Smtp-Source: AGHT+IGztwzy+wmA/FPmfesj5ESIRD6lYa5Ve7BhTJqGGT/8mSsYDFphkpRee7b6SRCXokRcGsRioA==
X-Received: by 2002:a17:902:e74b:b0:234:a3d2:78fd with SMTP id
 d9443c01a7336-235e11fe5d9mr17537235ad.36.1749005758822; 
 Tue, 03 Jun 2025 19:55:58 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:55:58 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/12] hw/riscv/virt: Use setprop_sized_cells for clint
Date: Wed,  4 Jun 2025 12:24:38 +0930
Message-ID: <20250604025450.85327-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
References: <20250604025450.85327-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 875eb7155a30..5143a465555a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -346,8 +346,8 @@ static void create_fdt_socket_clint(RISCVVirtState *s,
     qemu_fdt_setprop_string_array(ms->fdt, clint_name, "compatible",
                                   (char **)&clint_compat,
                                   ARRAY_SIZE(clint_compat));
-    qemu_fdt_setprop_cells(ms->fdt, clint_name, "reg",
-        0x0, clint_addr, 0x0, s->memmap[VIRT_CLINT].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, clint_name, "reg",
+        2, clint_addr, 2, s->memmap[VIRT_CLINT].size);
     qemu_fdt_setprop(ms->fdt, clint_name, "interrupts-extended",
         clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
     riscv_socket_fdt_write_id(ms, clint_name, socket);
-- 
2.47.2


