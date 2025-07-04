Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAACEC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeNU-0005wr-HJ; Fri, 04 Jul 2025 07:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMV-0002wf-Pr
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMQ-0003st-64
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:45 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-234f17910d8so7520915ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627619; x=1752232419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1np2O4QduAgtc6LsZvxZtIu1Z0IP/TYxN+sp5bkK7E=;
 b=coOur4hJQvAonsd2ZvTfBbUAN6NA0fpHs6KJw4/VKGxWc6g54aMxz4lVm1sQ9IFoPE
 JKfqxjEh7myoIQ/8Xp2gt/QAavJT6eTBHSZ1QBWjmGfOcvsLsN4BBDJAkecCOIW4gxkA
 YKd+xTtV4+MxYo9WZGe2ZsXeMt4oniyG9P21uxGEyHwhCThwW7ATCwvvgKTonAzSJ6z9
 xFbAyeSbV29WoNt7loiJyUR5uFGn06G5eLWqPToUpGpkzIzwZuolcg3lFno8QZEJh0cd
 SqlkePHH5V8TY1RbQU1+i2IdqwDjpKDhD0L6Tw1im7WxVc0vAB0IeyF4mT7vYmbOF32N
 FfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627619; x=1752232419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1np2O4QduAgtc6LsZvxZtIu1Z0IP/TYxN+sp5bkK7E=;
 b=L3sAQFVsMGUWHlLSJ0mNd8UoslKKW8ggY+RMqsNt0nFbgb8dwCpJKaTigYa6tLmshW
 EGJ6RYw7DGHgAaKNmfgINj4DZy7FzbWwKIgmFmZ37SLRBaN2NzubCFu0wJH7AI5OtE4F
 lxc7Xl24ArMUPjIH9okjqWjzCu7EalkIlkffAMQBRzkqQp9oi46yq0540giODlfO0bMd
 BTJQGdKTF++SWF6Zdm8D5lOApSOfIyFvnSWCvq8bHQZJvL/T6io9z6jUJhabVW8VZatg
 kcyg4JrbD2WDewBBYEQWZw92x0GRR6z0PjYRKBnqOjrrxk/CQj2/YPG9zEDF0/pJSnF+
 ZljA==
X-Gm-Message-State: AOJu0Yx0WdgzJ3QUeei3ZvYEELSU60zkHrfdB6hXVS6R1wVZL+bo0L6P
 haX4ZmU/2pcTbKNzOaoqq0rWz6rerkppZlcJNoVFFXaQolwWxVdLM3WnY+Sdcg==
X-Gm-Gg: ASbGncs36M3nST6x3MBvxjdUG1jBQGT07qzOA93t8W/0+9xQUBZw+MII/8ZseiwfVPT
 bJepFejBmEsWznGEAhNtUV/x2lNse3xGMZi04AxttBSFIOGCoRUNqkbdQpemAcasb/BpTip4ywL
 h8Lj6uHng98fOEDjkDqcVyZi5oDV5z+Wp7vLNLXOBL9W3ILlyEGfPDtozWtPss9FZK/VMg8Gd1e
 ONJ8AdGGdwkJVkrS1vyyJeo+DENc1NTQheB4i8s1rL96O/6z4zJaKrzM5cCo37EHEjILMvsEjhN
 FlqFBt0O/PvFlW6tDU0KZ+VgjZdRwko5aw1cjWbGOhhFF2s+3eay1GrU0PgPsbdy/spzenVPRPg
 lBv51QEv1FVEOMzKrOIa1lVJkBUc7UU/gTE+MblZh0WEhXPY2/VUAB+Xb+KJ8Zo7spe0=
X-Google-Smtp-Source: AGHT+IEIuFO25vd4giaO7E8gpd2gOvlQ6whhJewg20yUYhCUVmWjpXtZYuYBP8vwo5IvSMgPOO49yA==
X-Received: by 2002:a17:903:13ce:b0:234:f6ba:e681 with SMTP id
 d9443c01a7336-23c8606b87emr37687905ad.5.1751627618959; 
 Fri, 04 Jul 2025 04:13:38 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:38 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/40] hw/riscv/virt: Use setprop_sized_cells for memory
Date: Fri,  4 Jul 2025 21:11:50 +1000
Message-ID: <20250704111207.591994-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Joel Stanley <joel@jms.id.au>

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20250604025450.85327-4-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5143a46555..e074a29675 100644
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
2.50.0


