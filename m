Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C36C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeNI-00056P-9O; Fri, 04 Jul 2025 07:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMj-0003OS-Ti
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMh-0004Hv-ST
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-236470b2dceso7788555ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627637; x=1752232437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNXnV5rdf+l7pomRW4kQYmLNHJT+StTp6Iut77cYXow=;
 b=PC8NlnSIVxZYyOJg33HVbAaed2fGYpTX3TvYTKGNXQLjhr0Nniwot7R10ORdTLmZwp
 JtLYJWUuLi72ug/LdXH6phxvQOKCpFM2F+pspkCjNdPUu7wPb5jA0Mylj/hKWy3fbCbv
 LS8PUSEPXf4vuuCHXWU2qSB2wMsmL7tOK/PUHJ6heP/BsEcLzaa9e7maV13DTFcmx0Te
 4CNzEn/UGjzz3A0CYo6YpsRui7i5c0LKLOAr8uAyTAgZzyeWJPzpphBU9FzolwJoySMO
 1jMKRcjd2ej4ITfbQJiDXDc0dE5SjWQzOFg+/QvR8t9j7M7ZCqKG3ttynjUa3/uhf1Q/
 o+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627637; x=1752232437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNXnV5rdf+l7pomRW4kQYmLNHJT+StTp6Iut77cYXow=;
 b=R8PJ4XYtPdjr2voEI062Bu3TqZKIWRKEqtITkjOrNVsMYPW2oA8pL6bBD1ikUu7BZ4
 VoiKcVpg82vcShaE61n499otK+DoQVscq1n2KuvcPoscDzegu5uiyNavLRGMpOn4LO/E
 aysoi4IkaNlx1ekfXuxHNa33aSWDpmczkJtiyoX1P9rufUtn0s0zjks11QOjcTBn1o84
 SSVKFok5PmzO0rzOeVjUe+Hiymt62VZuiy77EVHRw511expl2VlprJ69lunQSVYBE7M3
 Fc88Xx96QEWVJ8hLldzxtbJykukxB2fJUTEf/khopVb083gtmI/6zK+auIGAatYNmUqc
 jdlw==
X-Gm-Message-State: AOJu0YyJFEH5D/zCBD8W1dRjPWDd80s/NoJSEaiLEKFDRP9gb8foxKho
 8FtYQ3LYrnDwmP0XbR6Du87fpGa6PtrePQbMGC10IG2cOngBPpuAGk7d+oRHxA==
X-Gm-Gg: ASbGncvHb2DvyzuIyhJt9GozE3Uvp2nFxtKlvHpC01OAzcZG9BzNah/7uPfxOnxtU31
 KNUbm/2gHNwxPBwqlpTKEi386ku6iHNmH9DtYHVxnFZBg5s9O+uM+GE05OxFBAV4w7KxNSyJByz
 Cb3NwSdUksEQEVZpZYxJ1I0EfPz/8mtRI1SlBXd2rW8jMOYZBFBi19I/lMpAqtRj1zLImLP13e4
 oHW62vaae+5ezk8EVUTRb0a2sHPAks1Ro41CgCTO/f6rir55Cfdgspt3Z1WTRXpbQYZOWWkiU8H
 3j+xy+AXfsLX+qPfoWB4xofPcyFTebETSIh+zpN6fkZpqSUPlYo8/cwZVLNyAjfUgKd8q486Vdm
 /s7hUmvVSZs0rszDk/SGdJYSzjWPP9ZPEspUWzH1veX1OnnbP29KsVL8kxWCUkzN7Or4=
X-Google-Smtp-Source: AGHT+IGvaz4UDJ/+n1wh6wf4sVoIkq1lY690OkB8fHZ/fqtTao4xZNAIFxeJxC1zTN14wtJXS71gHQ==
X-Received: by 2002:a17:903:244e:b0:235:60e:3704 with SMTP id
 d9443c01a7336-23c874719d1mr29339395ad.12.1751627636626; 
 Fri, 04 Jul 2025 04:13:56 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/40] hw/riscv/virt: Use setprop_sized_cells for uart
Date: Fri,  4 Jul 2025 21:11:56 +1000
Message-ID: <20250704111207.591994-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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
Message-ID: <20250604025450.85327-10-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b59f10dabe..7c38a90480 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -966,9 +966,9 @@ static void create_fdt_uart(RISCVVirtState *s,
                            s->memmap[VIRT_UART0].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
-    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, s->memmap[VIRT_UART0].base,
-        0x0, s->memmap[VIRT_UART0].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+                                 2, s->memmap[VIRT_UART0].base,
+                                 2, s->memmap[VIRT_UART0].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
     qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
     if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-- 
2.50.0


