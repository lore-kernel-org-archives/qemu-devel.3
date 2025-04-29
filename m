Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA875C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eDn-0002lU-Rg; Tue, 29 Apr 2025 02:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDT-0002K3-B7; Tue, 29 Apr 2025 02:13:15 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDR-0005QH-FX; Tue, 29 Apr 2025 02:13:14 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22423adf751so56127105ad.2; 
 Mon, 28 Apr 2025 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907192; x=1746511992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuk0Y1xOfJSfD3ObHIwg74fuvfC9MUqNk4U7Yn8ZUG0=;
 b=Z3LUPpiWBbwTSfo1CkpLup0vFI/qAmwSzwuJPvGbhow1g+MwyomZ1nPpesbaFrKlFy
 SI2sM/7Op8KGHOqdHPTFuldJiR7DvpFnBV+0dAl8l/ikRwOKK222bCx2P/I89RcfwdBr
 e/c5fAk/zWFo3zRSN6g1ni2pT52WvC4IhLV3zf2ei0vZnoztARn1FH1o9aSuPpJXn1Ah
 eUo9neZaAi0ENyPuCKVaoITSrYjFEQdNY5ciCc0pPqeTDANzaqphvWG7oszCF1j83Kad
 MA7cooBfmDi3NU3r1GbLywTpgQ08iqR+eMtMoCG/YPT2YMD6agaQWU4B4fB2//Xn7r/B
 9PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907192; x=1746511992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fuk0Y1xOfJSfD3ObHIwg74fuvfC9MUqNk4U7Yn8ZUG0=;
 b=m8tqPJDFDuh9nY1ycUhQBkpbTumANQbGjP6Wmlptg4GDikp3SD7qevkoY/sSYMw+Hp
 pEM9+bJqTcX2bjB/yrHSQHp/1DLTcNaofcAyCIcX6D2VxdII30cia7tZUunDQmOB6A8R
 UgPtKvG4o7XGe21dXsUhXSPkfS6bweJRQX+qs3pCOXxGSPgbXcG2X1mkiTIEIxS1NBNV
 Sb0ZYt49/XzPE6vOsPr13l/10TUe/OTJoC11nPgaGKRlRbDhZRWzN72Wq45+AoEaxyh8
 lvwPDoOPntYohskceFZDk+qE/oJrujfaLOKpWPHmqfd4YpLLgEQ/W087hn6tnyz4ozl0
 HpNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2XpWBfzR3+DLNecko35Ire4QnxzEXBWu2kZal1nYhr35wW6zxJGnvTDAVa+fQxAgFFLh/LJYqjB34@nongnu.org
X-Gm-Message-State: AOJu0YxpnXzIte5OABvEf/HX/kdrGRe9THPhvj7X5BHik1pdCJKpFcb6
 vWdc8H4uDtrqA25CcoJNz04/yKvH4wV5BpSwWOqhwIM/NWGMbqwNhPun3g==
X-Gm-Gg: ASbGncv86/DxuNqr4SiAmV8/rM8WjRsl8jzrM7AUWI5t4piAj2xVl8NY8pp7jUmzwRn
 TtW/frd/M3+D5qq7TTfCkP/sK4ytn5GdjvuBo2xkBgi80ETsnibK68ZzuftnOz1FEP53wYrOEKd
 zNUd6BKPTuQzC+ZCMqYxE9ZJwlGSMYUbN0QngLPC57mMrj1JVQxyGMBxykEjnF7Ri8Ioe2cZGoW
 /bx4PCACgWDnS4TQU0Z1gR8BpnBZgdCn+pXkl3iOr6wkXBK/wQZ0IHClettUaTgFHwYeHe5FE9x
 hkdqT9hUx0SPAGV6wbxk2NGyQuE1IoynkutUWfXbh4fr+Wb4AaQ=
X-Google-Smtp-Source: AGHT+IHDrE+Vh6uTV5OaRMnSgadyvWRs9pbiTqFOaSVo5KVnWZts1LEhlLGmff1k+FV/DkMbP7Vv1Q==
X-Received: by 2002:a17:902:e948:b0:223:517c:bfa1 with SMTP id
 d9443c01a7336-22de6f1175bmr30619885ad.38.1745907191563; 
 Mon, 28 Apr 2025 23:13:11 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:13:10 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/13] hw/riscv/virt: Use setprop_sized_cells for plic
Date: Tue, 29 Apr 2025 15:42:15 +0930
Message-ID: <20250429061223.1457166-8-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0141ea4795e5..3b4c3d6b2683 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -493,8 +493,8 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
                          s->soc[socket].num_harts * sizeof(uint32_t) * 4);
     }
 
-    qemu_fdt_setprop_cells(ms->fdt, plic_name, "reg",
-        0x0, plic_addr, 0x0, s->memmap[VIRT_PLIC].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, plic_name, "reg",
+                                 2, plic_addr, 2, s->memmap[VIRT_PLIC].size);
     qemu_fdt_setprop_cell(ms->fdt, plic_name, "riscv,ndev",
                           VIRT_IRQCHIP_NUM_SOURCES - 1);
     riscv_socket_fdt_write_id(ms, plic_name, socket);
-- 
2.47.2


