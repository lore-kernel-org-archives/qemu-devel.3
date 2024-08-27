Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65D7C5473F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5T8-0002qI-Rl; Tue, 27 Aug 2024 19:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5T4-0002Zp-KC
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5T2-0000pr-5w
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-201df0b2df4so49646265ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800755; x=1725405555;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3yfBKYZ/gUZE6VcdiduLzbILXUVJYc5iBQsuzG29WA=;
 b=zAKBDz/4rH3HVGAMvUKMyl+bcIzZ6eZeSWjUVvFLwYgTM4HtY+CLY3ZKfGZxKCkkRK
 2pEb5G8zYWz/EnfGZTXGOnK5b0T+B6vZVH7cMfn092zG+fW8HMu+ZS0bQMja1Gp5/alD
 pbJyw8GcmVaXX59DoDQ4eamjjv1W0w7aqd0840eKFMH+1crl+3d6rHa4dXd/YVNmYUA1
 GtZrIvR6wu5AtCQxN5U5nRo8suLki/eeC+ScyZF7ZQYT203diKRm+9fyQEeUBwwCEo7O
 73iyUObMLWkx+6rj+p4DABFV4SYZrOE0uo0+qCZSohZxawNaOe6RkA8TxfRAd0qSlJZj
 YLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800755; x=1725405555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3yfBKYZ/gUZE6VcdiduLzbILXUVJYc5iBQsuzG29WA=;
 b=OebGOhv6MH/yFYcrqoxh5K70BJhcPPzxT9ha2O16w0JZQ+2dfWtpeCGAzCYioMlHtD
 TBe12itEdu5tS0fcT8Dultci0kqYbr6nSZvC2u7SDq5s90EQlW60MtAVrH1xK5DWLmdC
 BsteLNan6UqsiE920SUGbegzQgU8HLacDq8CwG5pWI0ODer5T1dXm+ALwUEhMQkneZPf
 4JSXUTOQAEqxJyAkjNYSC7zYnIjv1cU/EcSgO6EaYKRMV1Tzi1GZzmQORSQiQ6D2Zdt2
 bzISuk4L+f0MZARAN6f2Tz81jSLr48m6O6meUAJkZ9HQL+HTaLPJ/upmHpQVF/PgONr8
 /QlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXztZVzvJFr5KWZ5kWrz0JhSK19W0+933t2CdYQC2U3lkhMoIJ0tf9o5dFQDWhPMCpR+saS5vkAk5qL@nongnu.org
X-Gm-Message-State: AOJu0YxlZB5o3HxIugA1k1kdiaoj6zckxzrAYNIhWEMCtAK9HL/5Vkln
 T22ZIQVoRRbFF/qGLuSDdKjHVRT/eiZ1F/tORpXvUFqgF3MNHQHChOJv+bLHMro=
X-Google-Smtp-Source: AGHT+IFqi1k8fzudJ+wJLFva2WaXpTcmaWyaxiOnZwv66fCh3gemhdqEYSLShLaBH1AziHfEtQlnrg==
X-Received: by 2002:a17:902:dacc:b0:202:cbf:2d4e with SMTP id
 d9443c01a7336-2039e554fe8mr166193425ad.64.1724800754525; 
 Tue, 27 Aug 2024 16:19:14 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0ee6179sm57785155ad.92.2024.08.27.16.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:19:14 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v10 03/21] target/riscv: Add zicfilp extension
Date: Tue, 27 Aug 2024 16:18:47 -0700
Message-ID: <20240827231906.553327-4-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x633.google.com
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
---
 target/riscv/cpu.c         | 1 +
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 33ef4eb795..43156ebb92 100644
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


