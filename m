Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BEEC3ABA9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eDP-00021y-9E; Tue, 29 Apr 2025 02:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDL-0001wh-Pf; Tue, 29 Apr 2025 02:13:08 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDJ-0005PI-N5; Tue, 29 Apr 2025 02:13:07 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-224341bbc1dso59993775ad.3; 
 Mon, 28 Apr 2025 23:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907184; x=1746511984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHG4jLuYhT3/O7GxrAmGctXYqSe38jPl85SUA9rHDRg=;
 b=GjRAysQSP2eBTengQDZFym+Wm0RxO7X7z4C0TOeJoK/RIhOT6X64XetP1KukA2EgOz
 cMNuLVoH4MZSNMnBUT/Q6q1zOM9QXLZhsEm4fqT2/oKY/HIHpJpFJFn4OWmLjbnoPAWp
 nuxKZ9HplK0MvIHCLHA544RsqisaQcr1i6RjcmAyP8yyUX3xYp2RLx67DLhgq5tkJNmG
 UUy+O0ACK4s26Ve6w7+CG4SWq+2sebo112GTdI7WZwE0cFGQs0Lbt93jRDEg27DMQ5v9
 bV+yJjrSpnNA/Mlf9J7z2E0h3V+YaPGBK2tRVHvH3Q1zqBlwKXBJ9jzZ0Fydj66T8MSy
 E0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907184; x=1746511984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GHG4jLuYhT3/O7GxrAmGctXYqSe38jPl85SUA9rHDRg=;
 b=e8HjvhLa4ygwwQDgOICXVxjfZiXvmvkanYknf75URCH5Ovx1VuetB7fOtgbtiDmkwL
 56FSQU8ReNB3UlSW3ITTWp88aLcEZrDMgj0TxcolQiNawchyqI2VmD7b0KvM8wEaXuOc
 CuT5+q/Ziy1p/IKwa7O7QfvyMRbUGB9jgohAnwKVUs3EPqtKXD9+/tdKlsCLuLFR+sJb
 8uRTYKzjjYiMAaBwXYmaWpN495QqKEiKBzCv6OKcJ27sW3No/dbn9EaZevFyjWOUTsLp
 kY/1yKu5IE1IhAfCLbhH5qthe7HgniaO52IYe/jwM3SJx5CfkD7hsdX8ff0vKD7bwLnS
 jQYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuApIszcYFUZASyUMcZguUVaEAAGSCa2fwWw3QkIiUFEKbUPv1oT+4w/XHJ5rM1CgcWvAgXt1EOWZi@nongnu.org
X-Gm-Message-State: AOJu0YxZUlaaDbidHTpz6Wueg9Yif3wC4DplfXDWHO4B9yvsDxpXipMj
 9rn1Xze+Uzqo15Mk03Y1BsChhz3tmfVeKnLDrIBfwWXlKCoVPGS0uh0p2Q==
X-Gm-Gg: ASbGncttoosoAKIwrq/+1MsYNJ9P4jEfXwEoHP6ezc/LBNrLAYWQNPygfmn4IDpbm9M
 9fB8Rk3V2i6NClOifjgQXmoF0vGhUR3Hyjd5xSJmxFpZp42x7IHRUvHaK1TaewUGMP4iz868Ilk
 hHFWsYd1BQYVxy2oIH2Eoq2uzDzUNd8cX+TgmbFABB1AUCDByEt8NMo/DwXzy6ndYjdC1Ti3prH
 yXk5gpGAXoDd0ECAUf7aTMOQR/4hCAV/eDu//wK9Q6p44XCVJ2Eczo+rEWtUBcUMayNySUQnx3d
 csrCCKEioCzzhXnXAyVfoey34KUZeCNpYjOWKoo/Tw+mR3polT0=
X-Google-Smtp-Source: AGHT+IFRIgQQcLTE4Un4Y6VTqQ9+6U8Q8YbyuVlMMyqjpBhQ5shLzRN4Od7pYApP3apHxSOCFAtNkw==
X-Received: by 2002:a17:902:ef4d:b0:22d:e57a:279b with SMTP id
 d9443c01a7336-22de7027fb8mr28213145ad.24.1745907183766; 
 Mon, 28 Apr 2025 23:13:03 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:13:03 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/13] hw/riscv/virt: Use setprop_sized_cells for memory
Date: Tue, 29 Apr 2025 15:42:12 +0930
Message-ID: <20250429061223.1457166-5-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x636.google.com
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

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 873d41d10c70..ed28bc06114a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -311,8 +311,7 @@ static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
     size = riscv_socket_mem_size(ms, socket);
     mem_name = g_strdup_printf("/memory@%"PRIx64, addr);
     qemu_fdt_add_subnode(ms->fdt, mem_name);
-    qemu_fdt_setprop_cells(ms->fdt, mem_name, "reg",
-        addr >> 32, addr, size >> 32, size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, mem_name, "reg", 2, addr, 2, size);
     qemu_fdt_setprop_string(ms->fdt, mem_name, "device_type", "memory");
     riscv_socket_fdt_write_id(ms, mem_name, socket);
 }
-- 
2.47.2


