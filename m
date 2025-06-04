Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E558C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeIQ-00024t-NB; Tue, 03 Jun 2025 22:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIO-00023t-Rp; Tue, 03 Jun 2025 22:56:04 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIN-0000Nu-BB; Tue, 03 Jun 2025 22:56:04 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-235d6de331fso11862145ad.3; 
 Tue, 03 Jun 2025 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005762; x=1749610562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/RDXCfB4a2xfexhBzBRYa2uyDwDEGd0jWyYIoveQVk=;
 b=ELJ5YPTU/CKixuJUjWYY+28bZsjtx83+hOUa3O41fFih8mvk2G/F91plBZaufMUcqj
 NtWpw0aghBtyLdteds74WMeXImEYrQZjy1B70nshRpxE4zlJAcShKnUh2TcXYHeHVvzV
 j3PlNXshqCV8rHS+heNr7+FogLfISFxDI14n8xRwSBRfXxgjaFx5raabbJuJcVWYeK4+
 jfyhikn7uNf5SO6+Ggi1cFvhFvW5pDfZltzSbh0vtcNDalALoPWZbvYobJybAZ15X281
 3PSJlcwJx+jbOAd6Sjq6xcEB5ws6JSaaxBghEF/eYCLEGuWdDYy3U0KvDNGtQ2AxCFGD
 FdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005762; x=1749610562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S/RDXCfB4a2xfexhBzBRYa2uyDwDEGd0jWyYIoveQVk=;
 b=kAarHrhjHaWaPddoqc1WBDgggL1QjLMfN8JAShIVLqd9/BBpijQ2aceQUVT06ln0e2
 YXUqQ1rAqWaRFXGhg6Inh63lZFuGok4GS8m3vPJGTH0CaTSqhlis44JCDXlk4vdnoyAD
 tACqkeNK6iivoQ6sj93tiG75o5r+bQE3EEHA5Sb3HNIqY19FmwQ9i5svQCOrwIqh+g7z
 35C7k+KuGJ4vpW8YUJ00Tw/DnCFxQumPhXw+Ji3lRYwXR4/zNhZEZtfIj4c48vJVC04g
 eQOByqfRg9Lns0kE8dFmvCANfDD2gBz9tOM/q6zy5nfeD42W1Ov0y2+0boKghsltc32K
 ffgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFq++TQKLRpetRJczEXLl7ifCOIo3R7PxBUHNna9gNTccT+kJsLu11zgV1IH5QYIXM1CW8jDATCHyv@nongnu.org
X-Gm-Message-State: AOJu0YyLoig8EZ11RmmtLiWR9anDhwnnqGUXieVzjiHkqyOS/Ofszuk9
 94ZESMM5+pzYfv2TevsP4kWmkIfh7quvrJjKrZVoBQy5PFBpStiGygkO
X-Gm-Gg: ASbGnctpAijm7k8I393P9isw20GO8AScSR5XJ01CLCHiXer5XMu8rrHysCAW3IApp/6
 y5WdyCCOsW3Nt6KEXp09C6NcCSs1XZdmpzz38N8N2jStq5Q/ZOEDffW3Y+Y4Hy9pNf8jW/Ds8WN
 zATD6uKWud6UFON4bigtCCQUrt4+anERje3hOkYC+Jom42Xvldyw/5+S9gW4tKy1zb4Mmiw0c4F
 pPRgQI7GexbJWwcTA5wmzTwn45i7btdwhNjrtlhQUGlmOOIbSXTashlheSqZnM0raFRAqUyttzk
 6bFRE2VhRRsuItW+MaOD7+gs9hpniJfloo2DRY0szsaIpSxsWTs3pnj0H3ypGg==
X-Google-Smtp-Source: AGHT+IGAdxBQZMz5grysvELBTC2zbk6QXJeyOtKHe9wS8ho/h5zL+YdHimnRThABew+ItGAvG1PKkQ==
X-Received: by 2002:a17:902:ea0b:b0:234:986c:66c6 with SMTP id
 d9443c01a7336-235e1129230mr14361835ad.2.1749005761598; 
 Tue, 03 Jun 2025 19:56:01 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:56:00 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 03/12] hw/riscv/virt: Use setprop_sized_cells for memory
Date: Wed,  4 Jun 2025 12:24:39 +0930
Message-ID: <20250604025450.85327-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
References: <20250604025450.85327-1-joel@jms.id.au>
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

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5143a465555a..e074a296751a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -311,8 +311,7 @@ static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
     size = riscv_socket_mem_size(ms, socket);
     mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
     qemu_fdt_add_subnode(ms->fdt, mem_name);
-    qemu_fdt_setprop_cells(ms->fdt, mem_name, "reg",
-        addr >> 32, addr, size >> 32, size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, mem_name, "reg", 2, addr, 2, size);
     qemu_fdt_setprop_string(ms->fdt, mem_name, "device_type", "memory");
     riscv_socket_fdt_write_id(ms, mem_name, socket);
 }
-- 
2.47.2


