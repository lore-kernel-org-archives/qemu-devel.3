Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40174C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9B6-0008Lk-Om; Thu, 20 Feb 2025 11:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tl9B4-0008Kr-Rw
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:13:30 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tl9B2-0007HK-Jt
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:13:30 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220c665ef4cso18540515ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740068006; x=1740672806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2VTiue3zdQb2l8bI0P0GLPoVCeHbENvgfswjU/R/0A=;
 b=eLGAkTn5xoFhVhBQLa5gQLHaT2XsT8d3mO6xTjG/yibMvxcxPexyj0dYyBGXK4YNHM
 rI9nFEDsNWWKMWsrMwVQfwHfGs/nsoiOp39QclKsb9hVJlWJOai6RMvA1iwQhC2q7eTu
 JQG4MGOqCvMQtnezw9TZ15GVuvLFQxt5qYl8Tdx00amJxMB25Z13F4inKy9u+v3w3/eS
 efx2tv5Pv3s9fbTyH+mXNEVA1vk3jQUvMKALQhe9iWGXrrDTD0pfEVnt93Vf8XFeaMIo
 fBOtkdEV8qKu7URk9fe2rcw+ZalXe6pOvwxOtZ9DGFO4apJKu5GCXJwv4ZX+qm/dChR6
 +OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068006; x=1740672806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2VTiue3zdQb2l8bI0P0GLPoVCeHbENvgfswjU/R/0A=;
 b=wCfgAahUeL6T+DW4jS4YLnMpWPRi7SOEo1Xf+OipzcBWJYVFk9MX26gEFg1VlkuPBT
 ozY7Xke8udcIst4+T3rNeQ9kvsPFvjVFdblDuSNRJwzLfFG0r20PILGoZN8JwSrSUt9x
 aTczH5+tmiBXJKdTYpo2ybizaL48g/lEgpRzl/nTrsqEKk9H2Tx964BGvrma6HeC3UlV
 EkvlCVrElQ7iCkknMgHrg224j3eUFox5idBrxUEdz4VV6ea0olLY3F+mWtnoOlSwu99o
 LEMntZ3qmC1hqk7dKM8TFk8nT+sx5xLbg3buTifrVLuyGWN+eOUFSlSXHaU233jTUmKu
 IkBg==
X-Gm-Message-State: AOJu0YzUc/2PDw+Blg3RskjgZydULaCOgyeg9ZDhKNtnb4dh/nBeVhy1
 /Z85JIteinKv52GzaCpjy28z6uLFl9pahXn3j8Z1rc27nN3IgojVD7o8keaSSU9B/1GOEhXL62T
 9
X-Gm-Gg: ASbGncuyJ5E9M4/HB+XeA0/ECk5O4IthsriKU3xecmZ4Rw3QJBfTLADk2oPGqVCDtRe
 fQmiyDbhb5ssMpHI/4vDQqOABZiTseRT3hi/iF1pNNhmW2xthrXtF8SwRiK3Yt+1Dqlj9aSyj0W
 9GfcMhQCXGUrLeKwu8SVFhjEMA9OqJfyzxRqnGwDeutJimCePuenSyTG9kI9LeirU6ncF1xSCz/
 3/rdQePjEQLwFENQIG+l9Kp8AFwFeQrCoJJJai5fPsXtSwlMBaFqA4OEqnaWlbAGpmqq84ORqb6
 mWJQVYoQJOjtve1cSA==
X-Google-Smtp-Source: AGHT+IGvpfESrKSiN8xmfsUV8xyDJytgPDwBN1a7WhR3MFgyEtzPHv7MvFk818kJh0AcPH3fEDMsgw==
X-Received: by 2002:a05:6a00:3d0c:b0:730:75b1:720a with SMTP id
 d2e1a72fcca58-7341737d88fmr4756149b3a.23.1740068006233; 
 Thu, 20 Feb 2025 08:13:26 -0800 (PST)
Received: from grind.. ([187.11.154.120]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254618dsm14074072b3a.26.2025.02.20.08.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:13:25 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/3] target/riscv/kvm: use env->sie to read/write 'sie' CSR
Date: Thu, 20 Feb 2025 13:13:12 -0300
Message-ID: <20250220161313.127376-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220161313.127376-1-dbarboza@ventanamicro.com>
References: <20250220161313.127376-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Using env->sie is clearer than using env->mie.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 484b6afe7c..fea03f3657 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -610,7 +610,7 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
     KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
-    KVM_RISCV_GET_CSR(cs, env, sie, env->mie);
+    KVM_RISCV_GET_CSR(cs, env, sie, env->sie);
     KVM_RISCV_GET_CSR(cs, env, stvec, env->stvec);
     KVM_RISCV_GET_CSR(cs, env, sscratch, env->sscratch);
     KVM_RISCV_GET_CSR(cs, env, sepc, env->sepc);
@@ -627,7 +627,7 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
     KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
-    KVM_RISCV_SET_CSR(cs, env, sie, env->mie);
+    KVM_RISCV_SET_CSR(cs, env, sie, env->sie);
     KVM_RISCV_SET_CSR(cs, env, stvec, env->stvec);
     KVM_RISCV_SET_CSR(cs, env, sscratch, env->sscratch);
     KVM_RISCV_SET_CSR(cs, env, sepc, env->sepc);
-- 
2.48.1


