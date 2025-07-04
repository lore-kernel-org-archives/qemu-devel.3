Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB41C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeMo-0003oG-TS; Fri, 04 Jul 2025 07:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMS-0002tE-1w
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:46 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMM-0003o5-8e
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23602481460so9195155ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627616; x=1752232416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkXTAF5RCQS+GqZ4d/g2zMqXNejGjj+dNtOpEx2fPrc=;
 b=fXBRj1+Jwz38qQti0HQmZAlWyvayjUvi1PQkbi+amK827RHLTiAvqVhjqvd5mBtS5e
 i9ms7gczVGnQN6NzMzBi7jRfsoIKBc11pqRSqyKuMDCB39Vw7+EufC1G/aniy96cjRQ3
 57q0ubb80yzPuv09+MVe+M44fIFj54RVxfc6rTcmCNC46am0Di+1xZIGEE2kJacGE5qn
 pr1HqJNesUNFYpbvd9ovwyJ+eJB5O8l9tsNzRP2wNEN2v6BFPwRYjAPHmnZueNPOf5qm
 X+8TjSSs/vHYPYPgtWjb8pncRygxhFzFoGo+14w8wQ53ftluTHEd+ml/lzbBtjpUQDXC
 g8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627616; x=1752232416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkXTAF5RCQS+GqZ4d/g2zMqXNejGjj+dNtOpEx2fPrc=;
 b=BokeJqJfH5OyMZkgCT/r2EfLL9o+HqeVH/j3DOVOx/195cxC2WTAkkWhKq6zsaEETR
 wjdxeJt59TPR5Acxgh+hGr/pEw7XfaHtK4N75z9zHyoIjKGVJMh75zXoVDYXafz1YbpB
 z2DoTi1AR9wqCB3JoSRBSQxYsY35oHRE54+AV9iyELJzbHRCGumVrJukRmTlg+Ct1A/Q
 4TZPdObWLj5XKXtvkNGUVGz6mPsVpfpBFzDp174ejCQb/EK3H71MHHjr5VTSV/FmxY7y
 +iB+V8YJRRj5ScGwXbjklHYXkXFw4bZ8ySy5pmhxSLfwBVKEUAn1qJgCY8K+p283WNEe
 wvdQ==
X-Gm-Message-State: AOJu0Yzdd0a5iEoyKJHMTjyLoMILsbi520hLxPkK9XBmKqsaUzZl1dwu
 RSkJyp5GjbUo9r5X3gnVvhjrA39ueRHUJmcvf0fc8+VoL53J2ZVuKrg9lFSpdA==
X-Gm-Gg: ASbGncsxVO2jNUbVP6m7c2YFXRrgCHka0OpDkOHsRvM7JINpIsYDizsIZvciuX6J/Kb
 PpUncvc4gK1voNZuWsieBDK86TufzEwmWbdVlHmqQCKgI39VMEsPZucbvhhTmtD4woPBg0zI2YU
 +9Ymhddm8HuOVtU3DjmUbIXiqH1Tl9sZdZEWid1duyIqjpCL2WsbUs0JhqyNALdLBl3PIoa703X
 uFdqbu+7TTU0yNwiJHnOwxaB6/IQ6ci4JDRfKJkVHgS6fsCJ6JDHkgIMPjNKRakpwzHLZ/5lrkx
 7GqNLNhXCajzBNWr0RZPAQJ7jjm/mOb8d14MQhuadHY6hdXUl2uHASYmVG/3ioE2Cm/rRg0vSnf
 N/FSqRNfz9Ymsf/IFrZO7ch6jkioJ2k1Z1IuUDOi7Z29nkglgG2Vg1yig4QczF9CLumzLlgccVw
 UWSQ==
X-Google-Smtp-Source: AGHT+IEk2hLw6Clz6m68XYFerMMXfp7ARRCSPAaB6bQdV5a7QKkicwYzdq5MHjNSs4qaB02epXW/kg==
X-Received: by 2002:a17:902:ce01:b0:237:e696:3d56 with SMTP id
 d9443c01a7336-23c8624b992mr35068495ad.32.1751627616006; 
 Fri, 04 Jul 2025 04:13:36 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:35 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/40] hw/riscv/virt: Use setprop_sized_cells for clint
Date: Fri,  4 Jul 2025 21:11:49 +1000
Message-ID: <20250704111207.591994-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20250604025450.85327-3-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 875eb7155a..5143a46555 100644
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
2.50.0


