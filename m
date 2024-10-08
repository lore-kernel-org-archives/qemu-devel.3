Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11678CF042B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 22:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syJ27-0000BS-JG; Tue, 08 Oct 2024 18:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ24-000099-Pq
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:20 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ22-0003tW-Bu
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:20 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20ba8d92af9so47261965ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 15:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427817; x=1729032617;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAmFNgO6MN8uMyYd2N3W1c951PV1oQBhf1Qm4FKEhUY=;
 b=qe2MqT4X391lItD04MRIMz1oXgvWicclSEBD2dksfz5uAVhxrwMXNkCDVRVLzqGCvi
 kqXSt+kytMZsAbvoPbsOEW8vDYLk6Eee06oOUnvUET8/N/R50Ll6wJYUrP5nYIbzuHBF
 zupyitckRsYq474cN7yqytZu2/NsWrlViLiD06D7Pm4LgXapHaRFi06fB8AMUmRCHyPY
 ayuINmooHnoqv2QxQm81H9kz+IFVjqhwDhyLT2YB5NArAC1hzMsrFKLyxPgJ+/vjvpKx
 lTRIhgDCBY6GjeLCW+E/UR0UdvwPbuoPKB/Z3NoC7Y26wQgnExuWfnYSNQX5Mdsd/CrC
 N+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728427817; x=1729032617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AAmFNgO6MN8uMyYd2N3W1c951PV1oQBhf1Qm4FKEhUY=;
 b=YMIwBi/HS3vOz7kehh0Y6n1uHIanyBpRQlY+pmOTgnrermbBgyjQ9hM2QVwsCH/LhW
 7QkBfEcELT2pKJThOusN9AaVRK8BWAwn6PJzH6HqC//oVo4Jl6/0HuxPVkuQAXDGH4gb
 aJ6AkuUYRZADLrH2b98QLhv1VJkxy8xkBEB7gIDgn9kge2mRccvyikFzP/65Ll/vMFrC
 uwcBymnV2QK7yEAmSTqrvgJMqgBEezGd2uIHYMEf/6sNYr/PjyN6TjY8N2ik1JP4F5d3
 W2U/ks2iwIW2wSAee2wH3kpQnUrqk7O23YDy8kJrzjQKvJuiVHMjhYz3iNGoNmNQQ0Qm
 g8sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDmJHHcNQGqG/CZeYRQFCsAoD8hNed+RiFwgQQMSBj4AdNvUqBespLBRwBdDgnZ1pMXpc6jz07WtNM@nongnu.org
X-Gm-Message-State: AOJu0YzLTupZHvV4IWvOiqo8zt8PHjPSUgjOJ5VaZn+OVlqAwWpOmGvw
 ZfxrRKpTqDryVnnEPbL7P/+TESbZIWw2olE2EZW8FzKXtRQ+cAXp/61DAkKUHyc=
X-Google-Smtp-Source: AGHT+IFhs6BG4FoBv+kIQ+AzxyBrkdBv04LvbrJLbF/iK7Leb/it6wHus/0MDHIZGgmBOD5zlKJOsQ==
X-Received: by 2002:a17:902:fc44:b0:20b:b21e:db21 with SMTP id
 d9443c01a7336-20c6377fd21mr8194515ad.47.1728427816761; 
 Tue, 08 Oct 2024 15:50:16 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af962sm60006105ad.26.2024.10.08.15.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 15:50:16 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v16 02/20] target/riscv: Add zicfilp extension
Date: Tue,  8 Oct 2024 15:49:52 -0700
Message-ID: <20241008225010.1861630-3-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008225010.1861630-1-debug@rivosinc.com>
References: <20241008225010.1861630-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62a.google.com
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
index 24ca0bfcaa..b7201a69df 100644
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
index 355afedfd3..fe7ad85b66 100644
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
index dea8ab7a43..963c1c604a 100644
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
2.45.0


