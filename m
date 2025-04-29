Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE85C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eDn-0002iM-52; Tue, 29 Apr 2025 02:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDP-00024C-Br; Tue, 29 Apr 2025 02:13:11 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDN-0005Pp-Mr; Tue, 29 Apr 2025 02:13:11 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af6a315b491so5477069a12.1; 
 Mon, 28 Apr 2025 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907187; x=1746511987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZJUjjM9v300ojzMKIAlTuxDEZlUpQCQVvYHl95EgTw=;
 b=bxweW6QZcI86vjhpbb6H+nLFHeaw61HdzKy4UCIi7Qna5HRDAB8iXIjqVSoHcZAM6G
 lAhvppw4rBMZcQDtBWL57TjGZK8pkKPlMiL36xUZvsNxrSUlBo3FVAIKfK8vCKU5qmCG
 JUOAQmEqJI22yT2oSlOA31nwBNGnp0ehBcbfHZogiXCdOD29mNzz5UAOEFlLyWSt6m2r
 NSbRdPuYe7wFXPLoZWHBQK9USc+plpT9xQiLAlRIXGkOKQxvAXbyVa8M0LyfA0anY/Ai
 8/xHsHMwlR6JOAO30kQV90Xpwb5tLsqneNm6IuyI8wZu2Ft1Vski1Qyfz95f7pm9F+1I
 mX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907187; x=1746511987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uZJUjjM9v300ojzMKIAlTuxDEZlUpQCQVvYHl95EgTw=;
 b=DS+9kldammToNZra+n4OXQVZjTPbAq55mlJ7eB4/UZl+5Ynuk2u8uQJ2aWTE7500Lh
 QR56r6lsMT5LxOvde074672jx+LQVY7x9eGQEOc4roeRsKFUa+IJRWBdgktf8ZyxUNm7
 80vxs2cCaqakVkNvDnxI08kNsJJVwV2dXVC1P+0T/KlUzjSCpdDAzX9cAI+oa/X1uceH
 6gtCT54AiznOUQM0MD6/Z2rqtGiUyCO6E4terTbaNZBaYEJ2TggQucXYR9B8czBBqKn/
 XZyLzmc8SK9oEC6DrmJPvH+SIel9ycU2w6J3oZUDXymtpWzi4k6n51AjjXHw5VFqf7RX
 2VMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8karXkqHudR98rTV7mDRUaUnQ0o9rTPLf+x26Cp/l98TLofNOxKTOR76MiWDjjHbIdEMuP5MQddaK@nongnu.org
X-Gm-Message-State: AOJu0Yz60da6GrExtJUdP2rX+yHlXrxkbH6L/ZwHY0QCuWmhZobJ4ynY
 O0icLx1xjPbO2oRhMzTHR0mQOVY/e2nI2whSN3/3YmWJbi6dl449
X-Gm-Gg: ASbGnctstCu6TKVy8y4bpq4Tmrigwp5xn3RjL6BtJcjwXwHpSs14uLJZ9qvXSCQpiHr
 tC+4Tlydl9UvL03sc0shYUZb+Bq4xngSqL6mx22JEGwi8LanKRlMyG+82rvGeMFMVmAfloUZ0wy
 Qwl+5wMnsBW+I4isUyRngLRd020ehXlNwaWi30/AOrD19uvrNa51vqrOTHEKjTrA2FGM0xS5d5b
 R05BrCe7i7sj1hfr/UULHlRPMGDNgzs5iheqRGpQjva8wpfLXkUUV1fOQLMXlsVQ2abhNgPvaj/
 ONUQzvVW7in5IH5Kfnot5f2ao66H4jJeWEGuq5lDXKk6D1Gezhs=
X-Google-Smtp-Source: AGHT+IFUldUabu4A8pWfAFTjl45zk+MhnBYpjna4w7aLyBH0QbQ8LuLSnTtri6Q8ryI3AQc+a0HeQQ==
X-Received: by 2002:a17:90b:4f:b0:2ff:72f8:3708 with SMTP id
 98e67ed59e1d1-30a0133b154mr20181743a91.17.1745907186495; 
 Mon, 28 Apr 2025 23:13:06 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:13:05 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/13] hw/riscv/virt: Use setprop_sized_cells for aplic
Date: Tue, 29 Apr 2025 15:42:13 +0930
Message-ID: <20250429061223.1457166-6-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52b.google.com
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
index ed28bc06114a..62200ea39d07 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -655,8 +655,8 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
         qemu_fdt_setprop_cell(ms->fdt, aplic_name, "msi-parent", msi_phandle);
     }
 
-    qemu_fdt_setprop_cells(ms->fdt, aplic_name, "reg",
-                           0x0, aplic_addr, 0x0, aplic_size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, aplic_name, "reg",
+                                 2, aplic_addr, 2, aplic_size);
     qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,num-sources",
                           VIRT_IRQCHIP_NUM_SOURCES);
 
-- 
2.47.2


