Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3DCC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8LVW-00065N-P9; Fri, 25 Apr 2025 12:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVL-0005rp-87
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:22 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVJ-0008LQ-FB
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:18 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30863b48553so3340262a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745596934; x=1746201734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ab0hxCGBF3pfbaX98DmfHee2+O+PPD2JzKONPAU5M6Q=;
 b=c/wFqwj3yRu1ojEQxGEcuqvY4BJujlPaXZ+mHMotK9PQn7hzCJKD8U1J6IMZY52sec
 CpifM41jLy4Ke86nrZVIukQL+GQt76oSJ4PvLF9Ld3YS0lFR4E4An4DJ9+m1G2upvKzt
 DvcoQ+7vcR5BlW9K3ZoTfPvipAzOpYjuPFmbLE73cw1wWReFmtOdSmYWY65pulvRI/bX
 VRcHFR/+JKtvDaz7M+ld6gvYMcx41NNGXnkN0wUcltKVftOF6B8xUOkJDJfq4NHGrUCh
 IUkSMnYWaSgBoVaVYbZ+CkQZfYEziMQvjjQeNKEWHxUK3ytHv1IpYejt7UHnU3MZCdtc
 N7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745596934; x=1746201734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ab0hxCGBF3pfbaX98DmfHee2+O+PPD2JzKONPAU5M6Q=;
 b=dGD4CtQLSgec+0w/IEh/7qq4sEYkNZxwj9WvwWIWx8/7dgoGBs65/4MSs1/Rswzug/
 IbFKcuwXdfdNViUDry0XeF3014HuLF3zryoNjuj1Fk0tNGuti87pMTkjuyP2lxNp2Znh
 cciVP+Fst26j3O0mqS5Wiaby/CQ5xq34YBXWWvNSgAv1CchtkytIcucHt6UruexHKNdy
 sQSKLJPTLzXOTdXPwqD71d8XwyuKmFkbMG9oJfXngkPTJdJaKF3yfAUUEk7DpVceeI7K
 0nTM59T+Oer6EPniAqaVGRjK7fmJJuU3B2XAGRpMn3OzK3NgZaiR2bltD0F2BM/RsTDp
 oxXQ==
X-Gm-Message-State: AOJu0Yz7a+vRZHXvOwYENrl5lCNTJneDKQienpOiMImlCInBSb9NHo8R
 ZHOgKBEJwTsVNdupXsJi0zxwXIBGGPCJqgkbJpS9tfkgZrOtm2dYS7ZLkt9QbocZcvCSqf7OkaM
 p
X-Gm-Gg: ASbGncsUTmEMJPfl/8XJVN/TqZL0BC5dxYUvusBlo+7/m1iDI2kMPDXoWV94dMdvnJx
 zTND8Ix3VJeJMlT2OBQ/+F6m3NkWSc+7tylNbD/ykBRHls8AvGCBLTC52fK8YbaFNNEyIZ8Kc8/
 X94ndqPZ0qhwMHjvdjjRAlL2SecmmVEsjz/LMv/gzJiC/uJtrjlBO6yZrJuDUaZY7rTPZQ9eSyk
 3p4wvV2cgrbxwDZygpL5CZHWz4j8/Qs0kclPgtaCMyY4WteWzU8Lr6u6EB8obqisFLBYyrYgmZD
 ButNnbPise6GS9ff3TbLOt9cUR/BNoEAH2aY3ONFU42Rt1wmfXCl2TqcHYmOOjKmRCxU
X-Google-Smtp-Source: AGHT+IEuNTH+uwZZaJHeVoNRdiW7w8HwcKcfZphEgB0v8Bh/ansYim3xn3jpCrDFb6hu6Nl1yBOydw==
X-Received: by 2002:a17:90b:37c4:b0:2fa:21d3:4332 with SMTP id
 98e67ed59e1d1-309ee3f8c4fmr9797093a91.12.1745596934364; 
 Fri, 25 Apr 2025 09:02:14 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f774e534sm1820005a91.17.2025.04.25.09.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 09:02:13 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 2/9] target/riscv/kvm: fix leak in
 kvm_riscv_init_multiext_cfg()
Date: Fri, 25 Apr 2025 13:01:56 -0300
Message-ID: <20250425160203.2774835-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

'reglist' is being g-malloc'ed but never freed.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index accad4c28e..6ba122f360 100644
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


