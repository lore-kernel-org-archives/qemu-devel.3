Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A7BC47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPDN-0006FE-3R; Tue, 23 Jan 2024 17:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPDL-0006Cm-59
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:25:51 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPDJ-00010G-Fu
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:25:50 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2cddf596321so52184871fa.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706048747; x=1706653547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39OP9EE9lF2EcfOzamU8x35qcADjGnzDFDx/nFOBMLk=;
 b=XpXdfJ8WOaiDi43sRQvx8su0uIO3TVGYPOOgR1DC2a7OXxg1ap426IsUNRaGiFs03l
 xXdEBrXN9rGr0kJTlqdbmhQ2BzHoQQMpYEDpHgrT+IIgzhUzDQ0OzWlrcMhoDmiWuFPC
 lCx7GQV1/qDKgZdXx+ZZAhXre/IwmkED4kU9lEoAT5bVWXbMxnaWWQTQ4jpHk9pQwoLs
 Doy3URRljeMvcXpQimDiABfNqEKUuXRBklyxGAKVYuw65X+zdLRjgopkTszMR5FvoIsH
 cxu27L7T205npJjGajkHHqYcZNrbk/DE9UPwFuBJeaemiUwe47lLA7LRmXCBPMyiYxhQ
 sMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706048747; x=1706653547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39OP9EE9lF2EcfOzamU8x35qcADjGnzDFDx/nFOBMLk=;
 b=BHl7aficVGB3Yp/uZaKVjJqKlTb75og6KxzjgpY3ssG7ZK33RQGcW2Jqs6atR6nIBh
 MGGRTpedBUOYbjeRQcreNOowlG6QcsNnqDRfR6JG+gQm5f1/4d/f3bhJTjf7kxnDQmmC
 KUx7rlSWMux6c+cUsn+lYm1meniH07LtO//4zVBIkrNeehOBDbKV4hFWjZs7nDWhnXyz
 r0N6yTNUohxux15+TnTjAeX7Zo6eLhO7euVjw4PpHCxHS4QFo6kKKBKdOyEG8C1tvJEd
 vUYhELVzWTsFA0jCQTur985AxNJtwUjYasnedGtZdnx+EmqlJz2brH3TXV0c6E5cOfrb
 a4cA==
X-Gm-Message-State: AOJu0YziZodey8xCbVF/BzVlcBU9/33QddpfRkUIK3JlllzqbBUYwy+C
 ErVEhiTQlSY0uSErNDzx01iB+7ajWgwmWff3mNf9tKoclNG0rQbtjgvZvHHbBKSGVw9O5uqj4yk
 9
X-Google-Smtp-Source: AGHT+IGGL9aDF1iXuPV3F+90sviFPEeOwjpvSnLOoTYFIN3lXSAKmz9Iups9xwTir/FoEtPzP73Fww==
X-Received: by 2002:a2e:964b:0:b0:2cd:cfd7:2ee9 with SMTP id
 z11-20020a2e964b000000b002cdcfd72ee9mr250403ljh.38.1706048747067; 
 Tue, 23 Jan 2024 14:25:47 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 ef5-20020a05640228c500b00557d839727esm15820192edb.7.2024.01.23.14.25.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 14:25:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Gavin Shan <gshan@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/6] hw/arm/zynq: Check for CPU types in
 machine_run_board_init()
Date: Tue, 23 Jan 2024 23:25:08 +0100
Message-ID: <20240123222508.13826-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123222508.13826-1-philmd@linaro.org>
References: <20240123222508.13826-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Restrict MachineClass::valid_cpu_types[] to the single
valid CPU type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xilinx_zynq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 66d0de139f..6ec65d4780 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -355,6 +355,10 @@ static void zynq_init(MachineState *machine)
 
 static void zynq_machine_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
@@ -362,6 +366,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->no_sdcard = 1;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
 }
 
-- 
2.41.0


