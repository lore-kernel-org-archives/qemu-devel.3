Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351D6C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXDR-0005nu-2O; Mon, 29 Jan 2024 14:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rUXDL-0005l6-Ri; Mon, 29 Jan 2024 14:22:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rUXDK-0002fC-4g; Mon, 29 Jan 2024 14:22:39 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e8fec0968so39742295e9.1; 
 Mon, 29 Jan 2024 11:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706556156; x=1707160956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lw9TI/Ae+cyW1jq8FTuL8KIiV6KsV63MMSeud1r46yo=;
 b=mOzfnjhMbjy0mHmigXqyBX04OUbQr+eE++DZMBJVROvZ92s7qlIfm/dAvlxfbhBQ1P
 VpLW7gBEMBGpAfDrj+qlPJq5LkdjpJqh8XmNnH0GCJ6zvplnzz4jkpSpicIjLrRca8VQ
 sGQ93GoD7NASXQg4HU/JNRxRJVwSH8cKsf+2ysLLBYNWRjr7HpST3ZnQGlm039jVK77i
 +n8zi/6B3T+nOC1e575SYQhnBVzTRGftDj6qd1YIfjPnPuScRpGCLGZQVhjP44DO2p52
 5iEK1ElDB5LFs2A9rNSV5Xb4qQLmYxBsclgbd57/xv+6E19In3CGl9Y/VPQUgtLPtyBX
 MayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706556156; x=1707160956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lw9TI/Ae+cyW1jq8FTuL8KIiV6KsV63MMSeud1r46yo=;
 b=N+b0kA1TA41SrYzBFE3/gXFNc6dJ+Sxmewtrbc72EdLfZj+4Y2uNBp6fULSDkvGSKV
 lxRWQRyYO/GvraMFLhf3NpHIr8WIKH+qcUfVVp/X1QKUukrbvrxzCiZdbY0X6dhsvWNy
 22MQ7ld+0tAWjRmcD4p7wQ76eeIm3YTAInLu6TA2DyjeFmo46r3f7jjMbHQxCGhYaB+Q
 QssZY9Xy706bEGDxrOM2bwao6kjwHooF5pNc3MtJDZKeDwYDWOpJ9RE0KRZ/2mIdDUQA
 J4RWOjWrQe36v3htRFigqeWRCCg/E9bKN+26mriyAmHv0OsLZVH1FA5VVsN5kY8ZlPlZ
 O+Uw==
X-Gm-Message-State: AOJu0YxdH3DpBTHPpZHtIQLmv8Qs58tuc1FQI/gjZpSt0+cN54Nqe4JJ
 /qNJEktidstB/29FLbtNr/sVR1BCIZBhYdI/oU3+ccIrHMDuEARR
X-Google-Smtp-Source: AGHT+IEe5X/4U7BP9sVjhAR0PD6pMOb+bjpioQ8zB+Q7jlXg0YscbRmh70xeFWOYhq3wAW+0OH7SSg==
X-Received: by 2002:a05:600c:4f15:b0:40e:f989:e6ab with SMTP id
 l21-20020a05600c4f1500b0040ef989e6abmr2103016wmq.34.1706556156244; 
 Mon, 29 Jan 2024 11:22:36 -0800 (PST)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 co28-20020a0560000a1c00b0033af0cb2a35sm2577206wrb.108.2024.01.29.11.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 11:22:35 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v5 6/6] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Mon, 29 Jan 2024 19:22:07 +0000
Message-Id: <20240129192207.2946870-7-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192207.2946870-1-me@deliversmonkey.space>
References: <20240129192207.2946870-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=baturo.alexey@gmail.com; helo=mail-wm1-x332.google.com
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
---
 target/riscv/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d8de1f1890..bf431ab728 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -153,6 +153,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_12_0, ext_ssnpm),
+    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_12_0, ext_smnpm),
+    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_12_0, ext_smmpm),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1395,6 +1398,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
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


