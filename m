Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90C8C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eDs-00038t-Al; Tue, 29 Apr 2025 02:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDX-0002RU-Ez; Tue, 29 Apr 2025 02:13:21 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDU-0005Qh-9R; Tue, 29 Apr 2025 02:13:17 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22435603572so63643115ad.1; 
 Mon, 28 Apr 2025 23:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907194; x=1746511994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dc4XVi0/KGrlG+96P+rusziL4/yPHrqiH7rbpSSJBU8=;
 b=S8C60NhGI39fOx4wFLWpr1WckXvWbofvGzOQnq+T2nKFi8pCywLE2I0uEtp0ZYB8JV
 JmGVsy2uEKmkRiIWslSky36qPAyBBQM1cel3duuYOhjQ4h1OKqCm4I/PZO+ydxoZM33E
 7UcCqoYeFpeeEuKLenJICb+9DK810qulDopvP7nrwrjpcwudGyl+38hOPO1ZwEVEI28g
 WRJ7yMJbtzNPGjCSZDk8sasUWAqW5igb035pB9Nbm/YYcJshM58BaoMcNKrJrlElE41a
 j4iOtNXiFzlbTrbLNxVWPsA633wZ12nm6Cwa/0LCgKFy3TZA7K4AA4X9xDwUpexTM8YI
 b9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907194; x=1746511994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dc4XVi0/KGrlG+96P+rusziL4/yPHrqiH7rbpSSJBU8=;
 b=O2LsEh3SFIJSwcW6VQpOxkXppvff4DNMctTgqDgHPrmH08weFjshSxO6P1JalBYOa8
 OGAXKfqK7715vF6uV2EeWrHjR+Ul80q2Jgsr0u3wj+Bcy5+S6oq+tJrAhNIhJC1KYHAz
 2LtQ1dCZxMYKQbb+HINwcfD/YKmT590pZ12wf3X3JTk+3QTXgmjyY+s9Oos/mUYzw1Pc
 RSv8BcxkG+qpvETYonqgOfrvo6lIa6X0BAfzxeOvBdaIxzHoHoi6EtYp9vQt8MLb6F1Z
 Vh6z3BNpIAhqvWGL2ByKjUgEIzznroyk5dbMIawa8W/ilTXj8APuUQbp09l4kKV5Hx5B
 cFWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2nWzR+ZurWJCInJMhr+k0Wc0n2AX+FClLoVWniff7gC6TPD05sAceHvZfQ6ZsqaQC3ANSphx6vTD0@nongnu.org
X-Gm-Message-State: AOJu0Yw7zykihokkSYbLKSr71jVagfsvzcwTYlgroMIhSHRO5ViJh30x
 BdqAuUWQ4GbC7GFsV7d7okcSAsImb9ejhli/cb/KtCpjqhmi4A7Q
X-Gm-Gg: ASbGnctFmfNxDxAAy/WVRY5SDCP2KnORXpqXV7ewIoAKXV6xMuyoA/LilOr0TC7TF+p
 Mt79zQWlYw3BHOhK6Jtbg/iBfvNJuro4y5KQJ3lDs6fvBHmzb8UKKSy7XaRVud9IPYuIhDEnDDf
 i0IC7jtBIh6j71MtvQnlEK24Zp2T2JTJ9CMXPe6BI8ahAyHkFSb9i8NWmjGCHW56DqH7YVyS3lq
 l6L46UPI+TtRJq9IEohlPrrKtFGD/CHoZRNd0bU+R8KqHHgbAoqSCsqpix3Q7kQJIVcuebwALYC
 NU2j22gwOauMf4jAMjcCWeF3zvxgXyVKbdOj1MG+K3r4s0qEk4o=
X-Google-Smtp-Source: AGHT+IEn0tI2Dt17oe8tmFebUIV6dIPihdYcphwr1B1CnfisH1rW75ikcwEaDctV9ZI3yyVatbGzjw==
X-Received: by 2002:a17:902:f544:b0:223:44c5:4eb8 with SMTP id
 d9443c01a7336-22de6062474mr33847135ad.32.1745907194008; 
 Mon, 28 Apr 2025 23:13:14 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:13:13 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/13] hw/riscv/virt: Use setprop_sized_cells for virtio
Date: Tue, 29 Apr 2025 15:42:16 +0930
Message-ID: <20250429061223.1457166-9-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x635.google.com
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
 hw/riscv/virt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 3b4c3d6b2683..cf7e16cc6678 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -856,9 +856,7 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
 
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmio");
-        qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-                               0x0, addr,
-                               0x0, size);
+        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2, addr, 2, size);
         qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
             irq_virtio_phandle);
         if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-- 
2.47.2


