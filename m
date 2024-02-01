Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CBCC48291
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 14:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXdC-0000Z4-C5; Thu, 01 Feb 2024 09:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVXcy-0000RQ-FL; Thu, 01 Feb 2024 09:01:20 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVXcv-0005Lf-LC; Thu, 01 Feb 2024 09:01:15 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a359446b57dso115338666b.3; 
 Thu, 01 Feb 2024 06:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706796071; x=1707400871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L72jtWav+wlpWsiMwJ1pzhRe8oFDo7kH+C8pFJwOQzM=;
 b=WrftWV2+DGxEbiSXLry2IITOgTpWMqOWbtHK1sOugS4WFaViaUYlXG5mpYGRzNfs+W
 /GEa1rSNQJuQBJggmCaMPzxae+Sl4aJrMjr90+O6lUem/VdOuUlV6LNp26gbItzCqmAa
 3qnwFDNKmePR0twuCapON8oxyi1jqDoCnTX4e1RMoZOc2RUaDmd+Ud0Y5ki+aA3DnIXV
 RGSk2rpAJ4HG1WOo6jtUIok951G1WBfRdaJsTXxeQTcjSPHPTQ26LHRypW3s3eGSnJ5y
 N+AFXGY9rgk7ncIpwjwsjT+4oIOvG47DJrQYdoZSxGYVaMfEsZnBfheHg4pHjSvjONnk
 DhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706796071; x=1707400871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L72jtWav+wlpWsiMwJ1pzhRe8oFDo7kH+C8pFJwOQzM=;
 b=ZgwOp8chMRhVnpQ5WDVGAE1CI+vIuzOLxI/qIJHfwr/8Yxqlgzz1cjqXgGNKM57YKC
 MXLA4zOwoMP9vSv8JoEKpZUxCzJsojrOoATD1biJRdlT7cCC9um4SVY5YZ8xMOcwVGk7
 OH0ZOYhe/bDSVcG+bMob1Yrqw39NU1C0DfLrsf/o/noEQ/VYSG7a5hZ6N7SsT6/mNA1Y
 lKlMLimkw8z8mwY1Fd5Hl0XuWnBuouX9qlqj0l2Blv/KFgft1X3YMzifxS87UQyCIssg
 Q7/hC0PezsijFcFW9a9HUr8E8BonWwOicAeGRfBWnyS8wbkF1seXbDgrI+bTPHi5aTME
 kr3w==
X-Gm-Message-State: AOJu0Yzul9mI+QxA2YJGaK72iJDlENNuB1zm4UGQQxTYrHmtUlHNhBYS
 F9xjEyitB+DBYUXJw89B99aDgAs9Qno0WpIgI/OIIgXu13gVqpZBYHmBCc3YUpDLRw==
X-Google-Smtp-Source: AGHT+IH15wTSz1XG2n6/AnShru5iO5mLayIBszyxW75lo6JYOa6sQ+21keh2r6V0SHeqnge6rrbOoQ==
X-Received: by 2002:a17:906:3b0e:b0:a35:fea3:c35a with SMTP id
 g14-20020a1709063b0e00b00a35fea3c35amr1884117ejf.17.1706796070888; 
 Thu, 01 Feb 2024 06:01:10 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU88Tqi1G1Cnjst29D10lBYVKP+BhsCnH6oy9yd0BMvS/QTMBId2IrjV1SJIk62jlikNf0rTazm1e0RbNAtls8M8DC792AsuqeNya2xss6yAvcMcz5F4vdJ2tz1lEna9pW8TDY+OM4rnKY/1P6uL6p4n1eEnX/zgSRTs2WPdMrQgxRHIMyC9lflAhDVd+Vqybqz+hl63wl/sx1C5K0u0Mc8uUaS567texsFbfulBAr6I3cW0UNzvog5z/UcbHagqo394eNRqq9eIAjmNGGUcZ5EryK3x0dVTVAhL0bu2eppdtVOYZ8xjiPI3YOl6tacUumJQ8FBdSLxpuZRcost0uX+FoewbnqpFzi4iC6Fk8/eQ1nRsG8y9/O5U8A=
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 un6-20020a170907cb8600b00a36a7f0f087sm902728ejc.222.2024.02.01.06.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 06:01:09 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 6/6] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Thu,  1 Feb 2024 14:00:47 +0000
Message-Id: <20240201140047.3456114-7-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201140047.3456114-1-me@deliversmonkey.space>
References: <20240201140047.3456114-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ded84f2e09..23d1692b59 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -175,6 +175,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_12_0, ext_ssnpm),
+    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_12_0, ext_smnpm),
+    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_12_0, ext_smmpm),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1496,6 +1499,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-zvfbfmin", ext_zvfbfmin, false),
     MULTI_EXT_CFG_BOOL("x-zvfbfwma", ext_zvfbfwma, false),
 
+    /* Zjpm v0.8 extensions */
+    MULTI_EXT_CFG_BOOL("x-ssnpm", ext_ssnpm, false),
+    MULTI_EXT_CFG_BOOL("x-smnpm", ext_smnpm, false),
+    MULTI_EXT_CFG_BOOL("x-smmpm", ext_smmpm, false),
+
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


