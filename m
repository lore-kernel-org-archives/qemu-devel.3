Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32873C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eDN-0001yR-I9; Tue, 29 Apr 2025 02:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDE-0001bt-EH; Tue, 29 Apr 2025 02:13:00 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDC-0005OW-J3; Tue, 29 Apr 2025 02:13:00 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224341bbc1dso59993045ad.3; 
 Mon, 28 Apr 2025 23:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907176; x=1746511976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yS6YbrLorHrCaUTeh9OJZjVOXeAFgXyyBbtgx5XvM4=;
 b=DyYnRI4TlLyokwN36vw7F8atzmSUOG/g+XhIkcwd2hjsYyNK+l24HIoLVvrgHC3f7u
 rjlwpMISueUIiHvFCXEr7hdiEtrJBbRunzBFKfS66u8o/releDKNEnoFDXRROVGUKZk4
 4MSnyhsj9/bB8re7Oe1g0STdqX0nkPYEw+vlUyP9wqnKk8oROB+KvWCjRysdHEVbWAUI
 1IUbET4BVdCKAd6e4Olgv4ko1vJ3iEc12d6FUcTHN4b7TDRBHeHlnVQNjHfwMKg8fcPb
 ECkDptt+LWIh0KblXo8KOI9sbPPNEJo60xMtPPa+/hXCvceUhXZWoMLGZr7NDG2LfruW
 7jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907176; x=1746511976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+yS6YbrLorHrCaUTeh9OJZjVOXeAFgXyyBbtgx5XvM4=;
 b=EOAWBOlk4Y8+Gbrr3uKpXMCsTV8Tm1V3Dp1dADeV5li2IfHulB5A2bpvDAIbnniyqr
 0JMej473cfkziVsmcOLDbpCuufvpN3eotgcuPfsBCClITOpNFKJXxtF5enpPDvwBLpPw
 FNzPYDtiz5vLlhrl9oxGSwF6QfHeqgl46AYLPDO2Ak5XWZWrwiZ+oosSKj1cD6U+mBhG
 QjZVw1kxPNv8/dzBnzorYbSiSX4sH9l0dBuFIlZGzks05PAbVC9gkpj+awL/Leu/fbxk
 SULNNpqcWIJ9SWksuCG6zMKCc248gtLvoWANmn9Q1TvMrsQ0d2nuTPlTCLEsEiiXRE3g
 R49g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDg9h11hVQT74VsEcFWQowRC3cJYzDGr/abIGxIOiwmjxxNf/mXsl7Y5X+/En7iUJrkFVCtNXCw/aE@nongnu.org
X-Gm-Message-State: AOJu0YwKIKzQEEOL6GXP0Tp4u2Q2a2jbO/VPz2gBlkfxV9PT/R9XJMua
 Xrp+w41KnaSrgZYaLjix5NcVg9z9owssAnVWVyLMadM1k2iE8+l6f4GlMA==
X-Gm-Gg: ASbGncstx7/ywXgm50xfd8TjPTHLfSM9R9FO4CD6RfZ14AsodMcn2J8nhzsdplwe04D
 4hlZPZjO62u90F06yGougvE2Ngs/JktCuncX9EwjzXoAF4RpHyoYad08yqyMpr/WkHvgZ7Ijn/c
 jL0Wu2yWdXCSZO8s/mYwqdLDxnA/KZwqc8l9fJJZ2VEI9vL82oDRTH2Y6xEBR+aPzu0pI0T+vk3
 Y5h3nsCtDIOzthKyfyz6JjumhYPxZLsfuJ5f/Nt8Vg/kGswthE2JV8waiJN7A2dff3dCL5Jh9Rm
 e77BXkHLMqotxXWDGLRaaA5AqJth3xci/zVaRpiZ/W05ogo6q1c=
X-Google-Smtp-Source: AGHT+IGi4wHvI+5MNpS9XCi5oOHUyyU01BumluF6/rcaW1uKWw4ZtRQaZRSZMdZ5WPnXg4F9V3KjuA==
X-Received: by 2002:a17:902:ef0b:b0:220:cd9f:a180 with SMTP id
 d9443c01a7336-22de70a316fmr28815085ad.53.1745907176291; 
 Mon, 28 Apr 2025 23:12:56 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:12:55 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/13] hw/riscv/virt: Fix clint base address type
Date: Tue, 29 Apr 2025 15:42:09 +0930
Message-ID: <20250429061223.1457166-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62a.google.com
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

The address is a hardware address, so use hwaddr for consistency with
the rest of the machine.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 17a790821484..e4c0ac8a2a9a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -324,7 +324,7 @@ static void create_fdt_socket_clint(RISCVVirtState *s,
     int cpu;
     g_autofree char *clint_name = NULL;
     g_autofree uint32_t *clint_cells = NULL;
-    unsigned long clint_addr;
+    hwaddr clint_addr;
     MachineState *ms = MACHINE(s);
     static const char * const clint_compat[2] = {
         "sifive,clint0", "riscv,clint0"
@@ -340,8 +340,8 @@ static void create_fdt_socket_clint(RISCVVirtState *s,
     }
 
     clint_addr = s->memmap[VIRT_CLINT].base +
-                 (s->memmap[VIRT_CLINT].size * socket);
-    clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
+                 s->memmap[VIRT_CLINT].size * socket;
+    clint_name = g_strdup_printf("/soc/clint@%"HWADDR_PRIx, clint_addr);
     qemu_fdt_add_subnode(ms->fdt, clint_name);
     qemu_fdt_setprop_string_array(ms->fdt, clint_name, "compatible",
                                   (char **)&clint_compat,
-- 
2.47.2


