Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBE4CA0EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4nG-0000Wm-UJ; Fri, 30 Aug 2024 12:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nF-0000Qy-AJ
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:13 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nC-0006vT-M3
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:13 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d86f713557so638884a91.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725036489; x=1725641289;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQlN6mRQYQMm3WaHae2L8fMCjTsHQwJwE4wK5R8vZWg=;
 b=eBMnNjTbr7IwdhH6AobSOlk8rMj+tY3bfYV+IuS8vjs6GNQIhrB7DSZKZF2NxnRgNV
 Sn1KJ8B/EE/kwkl/XA9TgZIqKxDb+ct54Q4fiZ0yvnh6bsdORvk009OthubMKbpMmGmE
 ewBIeVgfScD94dEHaEA6uX+k4TNGJL33VYxkEQww1ON9i8/9QNMmXKnaP4GUesYtHhRT
 EpRDR8A0RmaBFiY/v9LbTOoZEOQvhnpg2TKrD4/AJW63+oy3hWlyRrv83iXtG4YqSFJW
 oAJa/QWpEs3WMR+VkLVclK3GziZ2jdEVJB6f6ulYFPFil1/WqEKVIZTfH5uJixAh4igt
 Z1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725036489; x=1725641289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQlN6mRQYQMm3WaHae2L8fMCjTsHQwJwE4wK5R8vZWg=;
 b=ZcycTGPXNm2xgPhwYN8ediVRzVc5u07/Z1e+BjSzCH1OFBHiM7cWBW1mGPV2QWA2FK
 nwFWSbAOfl47trtmeX5XlJfai1NFMXPbLSsWCUnsjP6yfmgZwiKoqFCjjDKQuv3iPh95
 5yu4r8ue58G0AqQi3x98ecJPb7m0rhEzCrvyvia8y4ZPDlPzycg6S3rcfgsJud07idby
 mqG2iq5QzUwynpQXQ/hNfHmqh5eSNMl1xahtbH9Bu1x3xo/J98uEvMuJQPTcg/UyUBUA
 4wXMSBfA9cK0UP3ik13NeFMABBIjA+wmjHd9bEyV6rJbFTDC5YaFtj6h3JqQgqdT95MF
 UofA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ4VEv6YHpiIux3lA7m1HMUMHwhs7eDncxssZ6cABMyyXJWT6y9VGlCQE255sp9veoQI/+xQSclZ15@nongnu.org
X-Gm-Message-State: AOJu0Yw1YE9wY0LFFbU2lHVxrSzoewN+0p66TLIrYqDQ+I9Wk65gIP2V
 U+SqCXQL1ReUiHn3KZSsxX4KBg5VCNysOBnOdBWMB8IPJmgsSDwNKX1Psz5X5As=
X-Google-Smtp-Source: AGHT+IHI1QVSJGFcswzyHUcVMqOxiD1SOKVneQDjyypc+0hVX9hBKpRUtyz7abk8G9C4SmPOcbRKyw==
X-Received: by 2002:a17:90a:7802:b0:2cb:4c25:f941 with SMTP id
 98e67ed59e1d1-2d8561a7107mr6946464a91.17.1725036489095; 
 Fri, 30 Aug 2024 09:48:09 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445e813dsm6591257a91.17.2024.08.30.09.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 09:48:08 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 02/20] target/riscv: Add zicfilp extension
Date: Fri, 30 Aug 2024 09:47:38 -0700
Message-ID: <20240830164756.1154517-3-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240830164756.1154517-1-debug@rivosinc.com>
References: <20240830164756.1154517-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

zicfilp [1] riscv cpu extension enables forward control flow integrity.
If enabled, all indirect calls must land on a landing pad instruction.

This patch sets up space for zicfilp extension in cpuconfig. zicfilp
is dependend on zicsr.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 1 +
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c4ea1d4038..e3f0bd9242 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -106,6 +106,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 120905a254..88d5defbb5 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -67,6 +67,7 @@ struct RISCVCPUConfig {
     bool ext_zicbom;
     bool ext_zicbop;
     bool ext_zicboz;
+    bool ext_zicfilp;
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b8814ab753..ed19586c9d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -623,6 +623,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->pmu_avail_ctrs = 0;
     }
 
+    if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
+        error_setg(errp, "zicfilp extension requires zicsr extension");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.44.0


