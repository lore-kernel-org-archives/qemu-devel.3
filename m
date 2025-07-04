Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FBEC83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeNN-0005s3-GO; Fri, 04 Jul 2025 07:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMk-0003SF-SP
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:03 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMj-0004IS-9d
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:02 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2352400344aso8743905ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627639; x=1752232439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnzEW12vhAcfjuXrY8palHUuRWe0HeGpgVCqDoIpXPk=;
 b=BdoACXof3Udd2V8EltL//FI4QRtNLRPpG2TCqhg7DfJESJAoZyBe4qO/WwYqGNw+Ns
 SaTtX8E1+IabgxoQgiVcfjlPqH0c6B6UmSNEssoVIVMdu9mHpbme0k4bQvn/wQkdbz28
 CB9BO20Pq8wWAAYdObuNBh5Dnye8TgAP01uxfhfrsNbtyPYag8j37W09IYf2R6YboQAr
 +ecUAn6IhwA2/9M77S4S0yAkespdpUoWVAp0x9402V7Bk2jvzZ45s1P0Y29pc92NkPId
 w4zeljtSpM/LR5AnxP/mxXWBX5x0I6LOvu3s3Q6+GzEFlvlrOHLqDpEBcM7sf9QfQBTw
 qqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627639; x=1752232439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnzEW12vhAcfjuXrY8palHUuRWe0HeGpgVCqDoIpXPk=;
 b=nIhzjaXzmCA8PlhpgnL/CVcLO3QG4y4EFF+H4ouCDRtv/HJ2bm+S47fCIpHcQSVDM8
 SsbweYmdTq2+X8Di4IHMU1SZguPXJesytFDPMB/Z+qe3TXEdpFJoH79pgrj2k4QGYlsQ
 jWX4pLue0Vfr5Sobuq4NiyJEDBYq8vxQ/sU6up0vCDe506hO7Bu7cVyipXI3NkMxyLBY
 1ANo7DR+vdjJJf1iXi68bgaSun/OpGLudQXNhswpCKwiiKAc/xxV8QNrS0L0VUih+2vi
 Xh1cEgvpvlC1pDEkkRHHNBsWAYEcAf9GrKB1SxiNl1L4mTerlOs7V49m+HRxgvHQyW6o
 rxiA==
X-Gm-Message-State: AOJu0YyztUAZGodeyv1oF9PDKVeuM+39wqppBC/cQ8haVJc0H9HhwBZA
 +yM7apLAPzBRt7y7iTJOrPJDZyC9wbeATU4I63OkqWLUS8QPwZbputA7XvFA3A==
X-Gm-Gg: ASbGncua//iTMqgxi4YYYeAG7TsyJWQ8LY9ENSN5SQLgNvim1AdkBXF0bdC/A5qRO69
 GIvMf1Mg4cY8bK+SrnOnhGr19mHuW60Q1gqWr8NBtxBfCNaL9+A69Pj3lUjJ4AjQIiT7DNZAtxm
 s/Qq1mwVwdKmlyaCZDiY4EJ41Z0J0YslzaoBfCA82V5OzzXSAhS9vTkPm7kmOQs4zcmPJKDeJQ6
 gzKzKaG5qcebxM28o6KYiot0qVsP0Qo8vjjXTocVqeaBuhZGYSakFe6k5FcgZJKzXniC7uF55I0
 rnX0AOsZWi+ORtJZRYBLtZxPUS3SaPp4f/wqKKObFERRDbJpR9TNddT5UhEdBEs1cPAWcST4/SL
 rQSjvqZe65yOTsZ/t3pYWaKsWf7FzgAp5XVY7gq5ALIdlwuWXKHFPd05hae5haqixFqI=
X-Google-Smtp-Source: AGHT+IERWKhU9g3ubqhFr/t/gafquFNu7a1AOLo/ViI5BFdCSzsVOa/+h9xbEtKJleNAS3AOiANhug==
X-Received: by 2002:a17:902:ebc6:b0:231:e331:b7df with SMTP id
 d9443c01a7336-23c8624cbeemr43605145ad.29.1751627639627; 
 Fri, 04 Jul 2025 04:13:59 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/40] hw/riscv/virt: Use setprop_sized_cells for rtc
Date: Fri,  4 Jul 2025 21:11:57 +1000
Message-ID: <20250704111207.591994-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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
Message-ID: <20250604025450.85327-11-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 7c38a90480..4fa2bad248 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -992,8 +992,9 @@ static void create_fdt_rtc(RISCVVirtState *s,
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible",
         "google,goldfish-rtc");
-    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, s->memmap[VIRT_RTC].base, 0x0, s->memmap[VIRT_RTC].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+                                 2, s->memmap[VIRT_RTC].base,
+                                 2, s->memmap[VIRT_RTC].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
         irq_mmio_phandle);
     if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-- 
2.50.0


