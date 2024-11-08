Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E83D5E140
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 06:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9I3w-0003qU-VM; Fri, 08 Nov 2024 01:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t9I3v-0003q7-0b; Fri, 08 Nov 2024 01:01:39 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t9I3t-00084m-D8; Fri, 08 Nov 2024 01:01:38 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fb3ce15172so27411501fa.0; 
 Thu, 07 Nov 2024 22:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731045695; x=1731650495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dd0VDD1HZh5UbKFP/cfgtDIoe/mhfV0hpPqnnnrq4pA=;
 b=iOM99mU0Mjs5EYg0JzLFC7AcZ9rzF7CSBTGW6T+NExtq5yhZw7WNLOGVpAxj2jb5g6
 uJbOd35T8dpwVsbI66WS8jMUYtD1/sAokH3cygTMFMgQTZcGO2Qcq0UyQt/+RfAA0z1f
 95npINx9sPESWiKnxv6EQ9YGwhOTGolU4vEsJjT81cV7TUIsmKlurmUW9B7GD+SxzTG5
 pB72mqVXcPBurs+VUDe0g8f0Za+j24MJTxx21Ehz2c0nn5CFLwE1oBVqSEKncKDEny67
 pt5ojBR/L5qUMpTbMe4bJQrEcBxMHMrZMFm8E22klOwrmyCoRr/ULsuEgYSFfVrrhHJa
 VevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731045695; x=1731650495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dd0VDD1HZh5UbKFP/cfgtDIoe/mhfV0hpPqnnnrq4pA=;
 b=ZbDVfhJvYs66IZY8cmw5SZQCS7SrLo2RGpjKq9xFf60I7bWhP7up12HdPx2zxP93zj
 k1vWjW3KSXnSFr6q09iBCMxtlXX/Lom91pitn+Jnj/lq/K+S9PTVGnWXG8IJQWiQZi5p
 Oz/4RVPUCO61/Rz+ETp9/qwAGL0ugcXch0XvuNcSbAruiL/vt+8VYhxlsZYl8C9Gqn1p
 otcMWW1freo7bXv2qFsR3qeGnaP1EhJv06yRkLQBAALAia68TFDS9AxLlqNEnE3/3Sza
 wkeC9ifsuutNMNiZCEWYTA8PwnSQ2DyiX+Txzx/uVuWrsA4a+Pb/pDmrFbiWcHewqa+E
 6yYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULp4bXVkDhoYDn65tcqWciArBhLR4AwXRgtlAxPDbWAcSzvDdI3+hmr0wMXcFhMzL8QfIbg4dgB2uMrQ==@nongnu.org,
 AJvYcCWxEZxiBtG80iWFZcUgC/O51rl988W33LceraIZK8KXx8W5/1izbFQG2GG/9xScyFR1zp/LIV32/lAp@nongnu.org
X-Gm-Message-State: AOJu0YyrWGh0naAkjlgqIQEOUPu+/+L2JTU//wzjwpxW47GjA/FiPRFj
 KIDyHdJ3NvkRUpwJz0uGvZCTfE4TqqA3JGEUlG6RpkP/vAl5TcRY
X-Google-Smtp-Source: AGHT+IE2vSsHMA8B6CqSov/t+6QFwZBr7LqoYJOMCGqMJtQRjeTAVfBmmA6rOsS1xguCviG6Eu+XPQ==
X-Received: by 2002:a05:651c:1553:b0:2fb:55b0:82b8 with SMTP id
 38308e7fff4ca-2ff1f4187f3mr6537821fa.4.1731045695232; 
 Thu, 07 Nov 2024 22:01:35 -0800 (PST)
Received: from hades.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ff178ee325sm5159001fa.27.2024.11.07.22.01.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Nov 2024 22:01:34 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 7/7] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Fri,  8 Nov 2024 09:01:16 +0300
Message-Id: <20241108060116.37397-8-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241108060116.37397-1-baturo.alexey@gmail.com>
References: <20241108060116.37397-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x232.google.com
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
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4e80dcd2e6..13b2c56a72 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -200,6 +200,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
+    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
+    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1490,9 +1493,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
     MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
+    MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
+    MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
+    MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
-- 
2.39.5


