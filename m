Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC70C54744
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5TM-0003Xo-AX; Tue, 27 Aug 2024 19:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TF-0003FD-2u
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:30 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TC-0000t6-6e
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:28 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-201df0b2df4so49647495ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800765; x=1725405565;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0CJdxvDGa9NA73ICq+2YegGu+s3jbuadw3iL7vsbu4=;
 b=mA7vKSw3fA8GWg2kzHhzhJdMEHdfoaCKayDBrG0nTWoExDDagFgrIATwKxUKug3+DD
 it9krSVl8LiR+Q5jJ5SOuhDFQjDXE0DDt2I51FqfaTcXYZxtT3cw9kxZnZZLJmXLuZt5
 dIx1X5Fp3PWsU/jWDQkA5BVLrVKi0FVpHI+bJ1sSQyJn6uWnmZBaBIYUiqJq48trKkOb
 2Bfs+JsbJc32ca8nWwKC3NokfJFlX/HobMiYny4c5y0E42TX91G6CXdp7mtI4DO1axfw
 1k+azkWtfqI+JTiV0E2Q+SjNt+LMQQq9Pn8TU4OOVVN4AVadM38tfV/2UH2ze276nVgk
 Ee7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800765; x=1725405565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0CJdxvDGa9NA73ICq+2YegGu+s3jbuadw3iL7vsbu4=;
 b=ZCd2fdsSiuXIghrI1YnVnrv6CZvzKP5U4hDjxDj4WSZRaKw2pgMFdPqPrhnlX9X8sj
 m4gPDXxlef7S6j+d07Ti1HjqENE8kXq68Ob2UKxMPyP/GuhrbkTBghxrzw74hydwwrtj
 A2HJ9Q7067n0WfQWbjCW/iPZrY4/KBS4GSQeiQSkacgVczoyw0mPpVaxrTVbnfk9t/E0
 bdV3kp2DJkaAbfO5R3IWt+vfHOmV9FVfyspIt4JvxxrNqVXpykBfU9hUVfAcUnSAWqiC
 7wNCSIsFIACK8pTM0slrrZKTmBtie+uLV+l4AIuG/1wCuaWRB8lVaBvTtgYMCfRn6j8/
 Yt0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8jdsGGhvh8pG0msyuIEJtsioRMqG88Kr/+WJTYPVFc4O0tj515EOqQScNFp1Xzs0uD1mFD13jQJaG@nongnu.org
X-Gm-Message-State: AOJu0YwVJeSIhYWEskpex32wW5cmcvrvHzb5sVWCJW24YZLHMa2VF2UH
 Sv3I0OLgGYR3cJGh9KIRXnZJmROgoYlr+6QbGLRo0KOIW5ocV3DDADFReX0pi4A=
X-Google-Smtp-Source: AGHT+IFSZq/rbYzeW85lPDBmJIQSJKx5QRaQ2i4fbbjymHckbPA60ScMDdG82KjxTw5tbhdwuyH1Kg==
X-Received: by 2002:a17:903:2445:b0:1fc:327a:1f42 with SMTP id
 d9443c01a7336-2039e44f7demr163597675ad.6.1724800764579; 
 Tue, 27 Aug 2024 16:19:24 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0ee6179sm57785155ad.92.2024.08.27.16.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:19:24 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v10 11/21] target/riscv: Add zicfiss extension
Date: Tue, 27 Aug 2024 16:18:55 -0700
Message-ID: <20240827231906.553327-12-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62a.google.com
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

zicfiss [1] riscv cpu extension enables backward control flow integrity.

This patch sets up space for zicfiss extension in cpuconfig. And imple-
ments dependency on A, zicsr, zimop and zcmop extensions.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c         |  1 +
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8e1f05e5b1..0dab110a3f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -107,6 +107,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
+    ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 88d5defbb5..2499f38407 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -68,6 +68,7 @@ struct RISCVCPUConfig {
     bool ext_zicbop;
     bool ext_zicboz;
     bool ext_zicfilp;
+    bool ext_zicfiss;
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ed19586c9d..4da26cb926 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -618,6 +618,25 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_zihpm = false;
     }
 
+    if (cpu->cfg.ext_zicfiss) {
+        if (!cpu->cfg.ext_zicsr) {
+            error_setg(errp, "zicfiss extension requires zicsr extension");
+            return;
+        }
+        if (!riscv_has_ext(env, RVA)) {
+            error_setg(errp, "zicfiss extension requires A extension");
+            return;
+        }
+        if (!cpu->cfg.ext_zimop) {
+            error_setg(errp, "zicfiss extension requires zimop extension");
+            return;
+        }
+        if (cpu->cfg.ext_zca && !cpu->cfg.ext_zcmop) {
+            error_setg(errp, "zicfiss with zca requires zcmop extension");
+            return;
+        }
+    }
+
     if (!cpu->cfg.ext_zihpm) {
         cpu->cfg.pmu_mask = 0;
         cpu->pmu_avail_ctrs = 0;
-- 
2.44.0


