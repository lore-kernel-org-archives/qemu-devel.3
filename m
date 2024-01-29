Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D54C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTQ3-0008G2-7I; Mon, 29 Jan 2024 10:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTQ2-0008CC-57
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:19:30 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTQ0-0007YN-8d
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:19:29 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e76109cdeso39230965e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706541566; x=1707146366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOazw+OwEfzfL7xWrU1RcBd6XD/48I1cQP0Tkf0Wbm4=;
 b=UDWTdALggpM2iCvaYqzk6Kv1P5G+PdJ6kcRtnJOJMwCzwDDUqFmfYNULYbqDAVEEkR
 +9YqQhUOdkKCKuWtiG9yndeJ7SpQe2IjN9qTeIr9gnKeGFKVUQzn95vcHWZJ7dZVm1T0
 bucK6N3bXeZBVV69UimJKcc7aKbzZdKnfZB50txdofVMk8TUSSBzEcxJNchxJy9bhB45
 wgm+5F713+b+CLptNkGlas1rEhAND8eMIW9Q8g/9FsfPI1na9G86WijyvIDlVnz0pgP5
 G0U2uQxk/4WCTflqbgUcNUnA6Eta0959SjBs1UGV56ycT/RQB0ZY+p5NgC5oUkqCMoTP
 GzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706541566; x=1707146366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOazw+OwEfzfL7xWrU1RcBd6XD/48I1cQP0Tkf0Wbm4=;
 b=qtf32cLDxgvANWr3iJThKYivaXvUtJNXCyMV75FNke3k05cTkZb/b96AvMMyhk+lp+
 2rzBmS2J2roZaOGgypv5OvoC0RbGu1iEecfhF2gNQOALRfW351RowH/qJXIdpG/aZNJ2
 Vxllyw3hC3cIQ6QOdZeY5w1aMRvanavWsH7x++co+cWIvicu4JLtZYQgXV0JlC1thEOi
 fP4TE1Wemv6FvBUCCcNxNK9FlcOWyattiy4ZvDEhR0JKDp/OpFyBd7bjKD0tyqJUUtlF
 3m1O3DZ8Ijsyb6DzsasaixNlM/hHawQo2hiL4ggGPbXpdwAOalDtShL6nBpBG1Z6v+wf
 lSng==
X-Gm-Message-State: AOJu0YxBbs2RWGddFk/Nop/jq9nejYfDJGZZ1ujJUzcMiAv/sgBH8zna
 UtUtFQLulAn/oNffwevlYMkoqSF/diedUWj8SYbYoZFBJhLKvJfNsk3cclkeNjRa6wCY4vXb5jP
 g
X-Google-Smtp-Source: AGHT+IEHf9d5LSynB12HJo6vM6DnllTlOTsYfNxBWoqzJ+0qTcNk76R5+7OGYe8WgFoxKcHG0DlVFQ==
X-Received: by 2002:a05:600c:4745:b0:40e:701f:d452 with SMTP id
 w5-20020a05600c474500b0040e701fd452mr5391400wmo.7.1706541566703; 
 Mon, 29 Jan 2024 07:19:26 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a05600c138700b0040d8ff79fd8sm10495450wmf.7.2024.01.29.07.19.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 07:19:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3 9/9] hw/arm/zynq: Check for CPU types in
 machine_run_board_init()
Date: Mon, 29 Jan 2024 16:18:28 +0100
Message-ID: <20240129151828.59544-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129151828.59544-1-philmd@linaro.org>
References: <20240129151828.59544-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Leverage the common code introduced in commit c9cf636d48 ("machine:
Add a valid_cpu_types property") to check for the single valid CPU
type. Remove the now unused MachineClass::default_cpu_type field.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xilinx_zynq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 66d0de139f..c57bbccb70 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -355,13 +355,17 @@ static void zynq_init(MachineState *machine)
 
 static void zynq_machine_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = 1;
     mc->no_sdcard = 1;
     mc->ignore_memory_transaction_failures = true;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
 }
 
-- 
2.41.0


