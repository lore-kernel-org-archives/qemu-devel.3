Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15692D374A5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rss-0004DQ-TF; Thu, 17 Oct 2024 10:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1Rsr-0004BB-Fb
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:53:49 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1Rsp-00071q-MC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:53:49 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so1068993a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729176826; x=1729781626;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/aVyMnXdTRBWVSjAEfUa2Caje605EjZCHN82s+bGH8=;
 b=Pk2h5t4del7HPshKoly1vmQEicR5s/XzyCVf2ur5kajN/HADYrm3BKfCMQosZGKbHH
 JOxwd7iDxu9Zj26qXB2ru23EXML4b1w84/NE9UyzMBwPvWWd86VvsG9i/3mHynzTFFU6
 AXG6O1Qp2gszrsriymOzXLLM5+papLkCSkOlA9obKQVSD3S9mz1fPc8p5BjyExvdhKaY
 FbbY8+bACfpOO5/9QeZ5TLnDPF0mPCcCyfvjpHCmW7oRpE4ZgZtEvhYHwboPTq1wVkuH
 Tv+hJHWSkviX0tjmBQPZRHymcW7SPvNYPAQvg64/Kb3l8LDdNufROhy3esI7MV6+Nlg0
 383A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176826; x=1729781626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/aVyMnXdTRBWVSjAEfUa2Caje605EjZCHN82s+bGH8=;
 b=DenRdaqfikpa8CYBF3LaSfZSw0wNoWBs3yU36y3u46V3tdN4A73XJvzIB0rjk0W5WT
 Meyl40wu9H66j6acEMdH5mn4jSNRlEd1Keka5/LpFcCWJhOAeGVjXeJwRucimFavBWhZ
 IR0U5P4kQgprASqRl4QReyaTCBcBUQwhkyManzGYSgsdCCdjDPaAxGVlq6czWwLd5qIt
 KX3FyRVZGqy1//yxvjvWIHQpVLSp9z4oz3N5zb1k/hdcusCW2mJ1R3WAbyL6uhXfJRWS
 YOdihE2E+5xbj4nFyV/6Y+A2VYmXnDpkoQTsXkODMuzM1zYGC+mcBUdfuCNcKzHyImno
 J2aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCtocywk/Pd+/qlAWN5JHKvO+3AP/0KRSNti+d1XxrK2ff6eAxKXY3LCWvFMXukEL1bm+UvEO20Pmh@nongnu.org
X-Gm-Message-State: AOJu0Yx1WhV9ovsP5PwlWy69DAqTfjS0L1tQ3yIOKcdSNIsrb8N6UM8s
 BR6VoZEDrif8wDgxwWuPiRwSOEahDM88Lt0Fj+agwj7j2UU7/3M2QWJqlZMLgHdxtIQrbkrLOgY
 eFrM=
X-Google-Smtp-Source: AGHT+IEGZQLhhL1sezwP/RgOgJ2xmO9WLzC888lPWAChxfFjcffL3yLxXvdD1DMP8jibDDsAiSqu/g==
X-Received: by 2002:a05:6a20:e613:b0:1cf:4679:9b97 with SMTP id
 adf61e73a8af0-1d8c969991cmr24502398637.37.1729176826253; 
 Thu, 17 Oct 2024 07:53:46 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77371193sm4859580b3a.21.2024.10.17.07.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:53:45 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 9/9] target/riscv: Add Smdbltrp ISA extension enable switch
Date: Thu, 17 Oct 2024 16:52:20 +0200
Message-ID: <20241017145226.365825-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017145226.365825-1-cleger@rivosinc.com>
References: <20241017145226.365825-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=cleger@rivosinc.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add the switch to enable the Smdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 15b21e4f7d..1323effdae 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -183,6 +183,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
+    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
@@ -1506,6 +1507,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
+    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
-- 
2.45.2


