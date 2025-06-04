Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8546C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeIO-00023s-Iq; Tue, 03 Jun 2025 22:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIK-00022K-KF; Tue, 03 Jun 2025 22:56:00 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeII-0000NP-GR; Tue, 03 Jun 2025 22:55:59 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b1396171fb1so3433956a12.2; 
 Tue, 03 Jun 2025 19:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005756; x=1749610556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjYjBnl7oiMU6MAiENEsoNhEbfMSMae5CUiyc7OESQ0=;
 b=IE7CnmQ4Q4Ni0N0DIk6nPqyWuOnx7GXvcl8X80NjQqW+jhmpxdx+iwLZVvv4X4Y2cJ
 ppT2w1/vSWvjkvAp9JLZ2WdlqewW6r7gSusOUIcECCQTQ9rrzTjsI9nJ2lPnqQmV03uq
 gpSNaYItydxEUP3rPb7ZXU2zDm1gD4WvmAfhc1aHoDhvwYxmirzwDMV0wUF9kNvrYhTC
 xIKCQK6GNPIxHh7InA4zL40D0sI2N657pzsVRcVkkGZ7X4KL2KSgvkmrLedwZV6stLxs
 Hfdr7TbiKbwSAC50M7zF5BVKBKySxEovcVZhKDU+tisoO77hbhuwj3RT9k+7Zb4oN7wM
 daCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005756; x=1749610556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SjYjBnl7oiMU6MAiENEsoNhEbfMSMae5CUiyc7OESQ0=;
 b=BBcTb7yoXIob53Vq0p+CrDMUTLl4xOEb1j8NSVjlVP+iXCp2ecmr4oXrt33wf/ebTz
 BGFK6rudfzWKbWFl9Sagop1mTWZns5YUESjEEhXvicosiE/bMaUcn5iGeTUlH+dFMUXG
 jtOi8LYIh9Nx2f5kI3B49Dqtr6xPAIu8xQ/2f3RoZKI+kYWByqs3J+VH0StOsK92nKYG
 x/4fGOCqW/UT6hiC8KmDkPK+IKp3WQ8DiSCOjDwSdQ/ROZAIEz10xBAVOayWbj8fsz0U
 5jYm6hnI8sSuzQd6OhGYT1JoW6WF0Za1a4A5aZ3ggemsOwjztUiEBKJ8DvEIvCzKuzda
 uvwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyqcWYI8xMQ2CrWCd/DGe6amrUaeWVp2KHu7CXCJrxJgt0ndOlJe35Tlo4tLLIrFLYswKQlRffv/Cu@nongnu.org
X-Gm-Message-State: AOJu0YyZYWxD4Z+8tsRLVYegbA8bHTvkYHRVYI8HzRH5lWROZK2j8jjz
 jXiAI7mTuaCZVe3mf/2yWWNICW9tuM3lGHElmRGa4GC2AHY/tOSvURzh
X-Gm-Gg: ASbGncs99S4woTg+o/YLhu0MOTiUnuJllQS8r7838bWHDKkfe4WuNIu5Es32AdbAvMd
 mPuGK8zkL9h9BmX0GuWhw1yDjHDJw+KBSiuU6XirGTmZK/a1z92RvujQif/eujP7FQEhLiZnFlK
 jAgPG5UnSg5e9fxj1FYV7b24i98KEBABGDJ+Z/o7L28YbnWoVPJ2qrfZm7AcdzLf8By51krEXhv
 Y1JaoDSUz1KxaBNcVx2b9C4C1pkw1VxMKJkPtqVxi5+QQxkzTIwCmJeb474LOJRGQZib7P2lxYd
 rDbv2ov5n/9Gpum1jmbciI8LGvcT8iJEoanZIIvPQ2Ls/RVn/EdfrCtcyQzBbQfUgHvDSq5s
X-Google-Smtp-Source: AGHT+IHoOnyBGFkmT24X4VBKpFjytF3X2SNvD9JPwNb3xRK/hmk8C/cf5yXB7kBBoI7IyiRS6EZkvw==
X-Received: by 2002:a17:903:1110:b0:234:9375:e081 with SMTP id
 d9443c01a7336-235e11eca33mr15549195ad.42.1749005755994; 
 Tue, 03 Jun 2025 19:55:55 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:55:53 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 01/12] hw/riscv/virt: Fix clint base address type
Date: Wed,  4 Jun 2025 12:24:37 +0930
Message-ID: <20250604025450.85327-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
References: <20250604025450.85327-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x534.google.com
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

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cf280a92e5ac..875eb7155a30 100644
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


