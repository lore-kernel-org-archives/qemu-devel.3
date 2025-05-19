Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16367C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3W-0000ri-F8; Mon, 19 May 2025 00:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroX-0007xb-2P; Mon, 19 May 2025 00:09:25 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroU-0004Kb-A8; Mon, 19 May 2025 00:09:19 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b1a1930a922so2633673a12.3; 
 Sun, 18 May 2025 21:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627756; x=1748232556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nw6AXVPueGRjb2BbB22TeSRK74hAQ7nSEki4/SFL6oU=;
 b=cI1h3KbrffPZC9AFT6jnjq6aEnd//WhvVkRLNWh4kvslVNDrS9oWIbBfAaj68/tDYG
 bi5nVI18mQgWw7SMGAmvQX4hyvonMb/YaEbn3syQ5VTkC3e5mfFpuOG1C01gPVj2YIu7
 wzL3VQqhy23opVsUeGMsurUalr4lOOKCmBDizeUnEgcjAPRG92gBAt6YZ+GOkmR7Ogaf
 A5fU2sbeLbp4Ni+D11YLBnP6HUOp4NBGv55kd9s8suyctcTEDwkj1B5oMbaNl3AfU8Gk
 p1us8mGTisjgwC/5uqrYg4kqEyWDu8LAu5yk2N72+zy8SfkjmQGPeJcrsgOSppUrBTUF
 bZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627756; x=1748232556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nw6AXVPueGRjb2BbB22TeSRK74hAQ7nSEki4/SFL6oU=;
 b=X/kfmL/uCW8q0rabCRCMCAsUJiJLCGMENihe/mZmZwcLuzlVL/KQe7mEHb0Q1i5wrF
 bwz2QUhYRotDcZka+hOWo+QXxo4s3zA+xE2sFKuVsCrTmh2Sp41Hc1RVPIlqljzEJjUE
 WdeFgMrTqVsU1L/yZX/aBMTUQVZAEP/lqct5OiaKtUtk1mmCw4a8+Yc4g8TSymzu2Zqe
 s6ivIYUg2qBmihTwQ8mMWYasMY0ZEFX7E0Y4ELl1k1l016rY6kam24hdtzPGvwAlFUkI
 0ITz2BPQk3/b1gXlmeUEOvAR2lllqa9tP99mku29qhauVIa92UT/aYNtv7FqPiZzZYGc
 aM6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkQgHivraeW0xgAJfOMLDiKjW2S7Lrw0XevRwPGMiDBVaov+d7cRivnprQQMYeSY3/zuy0frkUCGHc6w==@nongnu.org
X-Gm-Message-State: AOJu0Yy7Kclyc5FkGGNTtC+e0fpk4M2WTmBBZlajTufp0E9KWi46WiC3
 wghCtlVkmIPbf3Shs6DnBAVyV54hK1T0xK3qvSvYtdF0l+JOMphxZKtBuBdoNw==
X-Gm-Gg: ASbGnct9aXuhIJ9OBh/RHQcgQmfgawW4c9V15SoAdKL5sKbYAnXzxNmGu2cXwjG+ews
 c1b8aIkvg8bq4poErjVIxyBzI/EWDuu3vPpAzzIVZkNe4JzeLxYDDssSr60yYHAjX1whjvXZb5v
 MZlPKcd6rC8FY8+ts4iv8adzJLT9EGJCm+YH5DoJUTM6YYzEa0Hpkag7GX3WFmM7n9Ds6QPIbu/
 Vja/D9tzW5glhfkjbXgnPuQsKBbFkcYp/s3wYhTXlCjEOzqMq4dwR/T7wy1TCsaAcGS7JgzfVXW
 ++qjBJ/IzTrlhNS+Qc9EeXIrPLC9y5qUkvlNBdQ/2b0nDshpMOtxtre0LuQqMTcapdrBn9zFLux
 ygCUqi8yvPOL6SQOOw0EVpA3fUaiMIh/liLNSBj6Cw2yy+/84Pb1gJ+6A
X-Google-Smtp-Source: AGHT+IFEH8biJ8t/vxLfxoK62E2b3oZiWcbEH4gxiVnFkUO7YR72cxzUbSsT4YtcHweZpT/v0QrVbA==
X-Received: by 2002:a17:902:da86:b0:22e:50f2:1451 with SMTP id
 d9443c01a7336-231d459a6f7mr154117735ad.37.1747627756218; 
 Sun, 18 May 2025 21:09:16 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 40/56] target/riscv/kvm: fix leak in
 kvm_riscv_init_multiext_cfg()
Date: Mon, 19 May 2025 14:05:37 +1000
Message-ID: <20250519040555.3797167-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

'reglist' is being g-malloc'ed but never freed.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429124421.223883-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index cad54b720a..86eb3c2e3b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1119,10 +1119,10 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
 
 static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
+    g_autofree struct kvm_reg_list *reglist = NULL;
     KVMCPUConfig *multi_ext_cfg;
     struct kvm_one_reg reg;
     struct kvm_reg_list rl_struct;
-    struct kvm_reg_list *reglist;
     uint64_t val, reg_id, *reg_search;
     int i, ret;
 
-- 
2.49.0


