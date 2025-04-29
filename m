Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897DDC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eDL-0001pY-9V; Tue, 29 Apr 2025 02:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDG-0001gY-EX; Tue, 29 Apr 2025 02:13:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDE-0005Ol-Ld; Tue, 29 Apr 2025 02:13:02 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso48848665ad.1; 
 Mon, 28 Apr 2025 23:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907179; x=1746511979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yS6YbrLorHrCaUTeh9OJZjVOXeAFgXyyBbtgx5XvM4=;
 b=RYq6OyYiwd+kzjIsqai9CtYjoJ1sTSr0JYbBKB0gNVFqYOq9rF3ftM1OAViTPWsgfs
 Nr6vYBZSvL3jYEVvPvj5AYKEHrco60EE05VdAMbYiRtz7YXp5lNWEk0vt4UX1bRNF7Aw
 K17qqHl5vkSzCwn3Ge0Sv8GdBn1MUv9l/utAV1e6fbBZ0sxDvq3aamVC13VY5ASx7OE8
 x7XWtIS85gn8CbQTZHpC9BeRK0YKYqQ4YX3V21aUOqKrqKuoKeh2M7BXhyt7EqfMhKf2
 UCS62EXTiWDILSsh2BrazcolgAVYOYl1qcZQs0s+3EKxCuURnosrLUhmZIIzaMQ6UMSh
 xUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907179; x=1746511979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+yS6YbrLorHrCaUTeh9OJZjVOXeAFgXyyBbtgx5XvM4=;
 b=Uat2/sBT8BcMmKnIZXM6o7mFIOya4Wqa589qcsdjmi6L5ZnJox+f11MG1Eti3lvrxE
 5O7jHVkJie6ktx9awT8hLk1z9jcur/Ng15iGxD1nEL4jUWDkJwJVisjdjEr6uAp1sZAk
 vYCm0K5kkL1k0Mu1yp4APd5FFcz+9LdhjCYXibjAjUbdbULWY5XQ+Mwt6iz6P2XRPADF
 uhd0ldUsEN4fNmnkBFYf2WHCLms65hnqU1A3eOv6C6kQA4qh9ZhxkpQowEJ3zerpMTbn
 xS3Y29tViUrnDWCOVaPatQQvFqZ8oCHi4kGy4yKYPZStsjhvzh7dgOTGsFIuzDuFRq10
 A+qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNvv3Fhvkos1lvSwI43gDuCQrKsZ7GSadhOv2RyCgKhSyr4+ZB7CT2FTiGuRzgnzjhiS0i9T6C5H5d@nongnu.org
X-Gm-Message-State: AOJu0YxgCAvtGGf4ZvEmHo18dWIvoxypatXKC/qAi52tmups+XPsY34t
 PDiNhVGMvwT84Cy6o46qkOl3vHzkplkITEtYAC4nk0ogdV5GPymvbm92mQ==
X-Gm-Gg: ASbGncuSJ54Epd45jZ4beMb66HwUGNTD+47zfr3dhweULPrSE7Kl3AqL6vim3eb8IRG
 P4DxOh/jSDmYLblMGVBCi+y5ia99oM2ICWMPuvLPB1jUBWfyy4V0w5zxQ8ZKlzPdt5jXt5YCj5E
 I/U6HDvYvoJcya6ZX3PCu5UDSDBZ8+zWR4TXWUTi9SU/K7TC3APunN8YVdZ8uJtJpv4huOd92u3
 UdY9yeCU3qELnn4hB46N428ubOQf/FMyPFh8u65rvL8c44IZ8Tz6DcxdWUzPBNriBsdjAKba4OV
 O4ViPJqU2fqj4ZEgH87W2eU9lLjMtvGqMt4Q8TA2/g6ttXU74RE=
X-Google-Smtp-Source: AGHT+IEcHm1sl87iHDAdswCnM7GtQsW4fAAzhdKdkiKyH4aehnm26l1gyqYNT6Uz4vPKpJOZzd0cIA==
X-Received: by 2002:a17:903:1983:b0:221:89e6:ccb6 with SMTP id
 d9443c01a7336-22de6c7629amr32550135ad.25.1745907178833; 
 Mon, 28 Apr 2025 23:12:58 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:12:58 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/13] riscv/virt: Fix address type in create_fdt_socket_clint
Date: Tue, 29 Apr 2025 15:42:10 +0930
Message-ID: <20250429061223.1457166-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x629.google.com
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


