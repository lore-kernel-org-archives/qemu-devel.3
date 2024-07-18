Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639F8C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGd4-000422-LS; Wed, 17 Jul 2024 22:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcc-0001WE-I1
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:55 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGca-0003gB-KL
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:54 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fbda48631cso10510785ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268711; x=1721873511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlNSgnVZ4HEEVn2121aI1NCT2/j02sjH6kZ9iFY5oL4=;
 b=QwNdppPEzT/HqzGzxrZKzt85MurMwGi0djYwaU5NVKJXb4p5rAAgUCp5aMJyhl3GcH
 zV0d6yWAxQsQO8QkQ2rJxGaAO9AJaG/XD98UfWb38i5RDYQUw1APs2uJWJWKKD+X7Uls
 DqIDbGIVBZx7OgE3tHqzPEmRvLpeuxCyKOo4cv7kPGFDFhcYqYc4Albv0YZIV98wl674
 bdD59yYfHtt0XSOHoRiegFbCFIi1aGTpQT+8I1mvrl32869DZ09Nl639ODdRprNg8ArU
 wEW+MpwwWig002dVecbJWaPI/wt95YoAsl4ecwrdjjBOE+Ndzq8q9nU6AFYxsFDkrfPE
 glOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268711; x=1721873511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlNSgnVZ4HEEVn2121aI1NCT2/j02sjH6kZ9iFY5oL4=;
 b=BYTlOBwLROgFXVaJL0pNeu/ga0GRw3phq8Axc7lrHG8Oi5pjEOeaCjNyPmMd7u4aAH
 k2yhBmA6n4a4NE+4TE43Mg4ff0VMvz0+ClSxoZAnJznZiK1CDB9EjARrAdLZ4RuNH97f
 dF5x39E7TBJmeHG0uvnIuCivX6o59hgV87gcWZ7KN0Ga7WoFGhs+hZ2UnImaoT6b5lev
 7XSXxTY1Fc6QVZAkkLGGX4s7zkasUTpBUMaH+XxOEJEjagIZGx4aBtuNQWefBWA2U6MZ
 DZ3y3waLM0Vf1wiWJwjDXMJtPJQuYC4MwwuZqEy8OIOO11/RqpbCQjkq7e1CMnlT+uei
 6TVw==
X-Gm-Message-State: AOJu0YxdM6RypaU4CbOS8EtUFK8ucncmR3h2KTzc1ZnGhy01233TDavz
 ojBnF1HHnvYRWnQFwQRkzirUSoKsNtvjXJUP2LkyHRfXmgRO08ul/taadTJc
X-Google-Smtp-Source: AGHT+IHJyN/ElwxSILR/gr97mjo2ja2gSSkpsotPzAWT/AfeFvN7U+KLTrNSmEbxjj9E3XXO7qMyww==
X-Received: by 2002:a17:902:cec2:b0:1fb:24ea:fe29 with SMTP id
 d9443c01a7336-1fc5b62125emr23484105ad.15.1721268710800; 
 Wed, 17 Jul 2024 19:11:50 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:50 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>, Anup Patel <apatel@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/30] hw/riscv/virt.c: re-insert and deprecate 'riscv,
 delegate'
Date: Thu, 18 Jul 2024 12:10:11 +1000
Message-ID: <20240718021012.2057986-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit b1f1e9dcfa renamed 'riscv,delegate' to 'riscv,delegation' since
it is the correct name as per dt-bindings, and the absence of the
correct name will result in validation fails when dumping the dtb and
using dt-validate.

But this change has a side-effect: every other firmware available that
is AIA capable is using 'riscv,delegate', and it will fault/misbehave if
this property isn't present. The property was added back in QEMU 7.0,
meaning we have 2 years of firmware development using the wrong
property.

Re-introducing 'riscv,delegate' while keeping 'riscv,delegation' allows
older firmwares to keep booting with the 'virt' machine.
'riscv,delegate' is then marked for future deprecation with its use
being discouraged from now on.

Cc: Conor Dooley <conor@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>
Fixes: b1f1e9dcfa ("hw/riscv/virt.c: aplic DT: rename prop to 'riscv, delegation'")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240715090455.145888-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/deprecated.rst | 11 +++++++++++
 hw/riscv/virt.c           |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 20b7a17cf0..88f0f03786 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -479,6 +479,17 @@ versions, aliases will point to newer CPU model versions
 depending on the machine type, so management software must
 resolve CPU model aliases before starting a virtual machine.
 
+RISC-V "virt" board "riscv,delegate" DT property (since 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The "riscv,delegate" DT property was added in QEMU 7.0 as part of
+the AIA APLIC support.  The property changed name during the review
+process in Linux and the correct name ended up being
+"riscv,delegation".  Changing the DT property name will break all
+available firmwares that are using the current (wrong) name.  The
+property is kept as is in 9.1, together with "riscv,delegation", to
+give more time for firmware developers to change their code.
+
 Migration
 ---------
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bc0893e087..9981e0f6c9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -651,6 +651,15 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
         qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
                                aplic_child_phandle, 0x1,
                                VIRT_IRQCHIP_NUM_SOURCES);
+        /*
+         * DEPRECATED_9.1: Compat property kept temporarily
+         * to allow old firmwares to work with AIA. Do *not*
+         * use 'riscv,delegate' in new code: use
+         * 'riscv,delegation' instead.
+         */
+        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
+                               aplic_child_phandle, 0x1,
+                               VIRT_IRQCHIP_NUM_SOURCES);
     }
 
     riscv_socket_fdt_write_id(ms, aplic_name, socket);
-- 
2.45.2


