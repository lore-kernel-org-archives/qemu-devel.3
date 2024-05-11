Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0300AC25B5F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 10:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5jhH-0005V0-Vt; Sat, 11 May 2024 06:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jhD-0005SK-Ub; Sat, 11 May 2024 06:11:15 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jhB-0002Ah-Mo; Sat, 11 May 2024 06:11:15 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a599a298990so681352466b.2; 
 Sat, 11 May 2024 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715422272; x=1716027072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcjfiQqdszD/zdWCJfe58zMToJNsLVZqVDYZoGGq41I=;
 b=I3GX4H4Q5zewIu3Os11Gz9VLZ3eS6wBbEYvF4ysfFg2QJ6vKPE+9ClskxaA25WcCKa
 ozr6jFm5f7VllDiyzfILh5FoTp2u9mNi2QNytEce1J2vWBNAc9kfH7ZceaFwquMph/DO
 P63UoMfmXjMAfle7nE4Mxj0euimcGLtLLZcLBYVJFxkIlVFe2dxg00DcrwkdMYP/zP9H
 Ddjr4ahmVUmPjR7G5IFPwXxHIlHALRhE7o5eS/xcegxQvuRpjbzhzC5DZmsOYaht3VvZ
 gKAXJSgh4RnhSXtWTgo92NPmguKWt8H2BOWOMTXX1Bo4770kV9JrghGQfw4x9TFnGIDg
 3vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715422272; x=1716027072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JcjfiQqdszD/zdWCJfe58zMToJNsLVZqVDYZoGGq41I=;
 b=LVWQHcIffTMIL/9DR/ylIjvtLdZFixMX9DskcDKk6vslqoxB7IWH7ARYxzLcw+8wC5
 LehfkoQbtqAWoVXuvyX43DyJriWGChIvcCK56Rc+A02G+Tle3neyfkDuxzdk23zVFcXB
 mN1kI0mrVbiMkT5l3Rub00eDOHMZRIIVT5DPmFVBAIR4DJcuJ9rjis+4rzYCxdbCUb1x
 eWqN3wzZd3M8GNXfHBhAcHw57W/znWa6AzlVuBYHCIvPOlSDKmHTmgyC2ZEQiYyoOUco
 y3+GmzcxHNCmTbAz6xPjRrYIOGxvchImCqGzNEn1SGRdsWfZMjP70IXCb07TgbLow3Ic
 u76w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCXFngu5sXvOXsN/kbHfowT0roGjHjjdQkFER14l8tcWxG1C7b22Q3sE2Psi56zfLqBpoO5eVlNZBfiLuxto3oQ2LBRe3mureBS9pXQjAZmVV80zpJ+Fy8kDDBCw==
X-Gm-Message-State: AOJu0YwnVQCw1lboI+/PmvT3i40zKHM+PtIpzRMCFMum4kmSxlF7HPKh
 acfMcM5Ysk724WbkNmHQd1+hlbnic6uX+8l2xfW5Zx/1Pwj1jjJ4
X-Google-Smtp-Source: AGHT+IHug6BV5TDF5TUi77yCbX10LzsD5H9oymYIOhNHlZu++vmMVp/oemS4IBT0Q8dOtR80+4hc5w==
X-Received: by 2002:a17:906:d9d9:b0:a59:b807:330a with SMTP id
 a640c23a62f3a-a5a2d55e4b8mr343451166b.32.1715422271976; 
 Sat, 11 May 2024 03:11:11 -0700 (PDT)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d27bsm301687166b.21.2024.05.11.03.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 03:11:11 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 space.monkey.delivers@gmail.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v9 6/6] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Sat, 11 May 2024 13:10:53 +0300
Message-Id: <20240511101053.1875596-7-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511101053.1875596-1-me@deliversmonkey.space>
References: <20240511101053.1875596-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1e350e9bd8..b3b3a6275f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -192,6 +192,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_12_0, ext_ssnpm),
+    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_12_0, ext_smnpm),
+    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_12_0, ext_smmpm),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1565,6 +1568,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+    /* Zjpm v0.8 extensions */
+    MULTI_EXT_CFG_BOOL("x-ssnpm", ext_ssnpm, false),
+    MULTI_EXT_CFG_BOOL("x-smnpm", ext_smnpm, false),
+    MULTI_EXT_CFG_BOOL("x-smmpm", ext_smmpm, false),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


