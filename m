Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF10C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 15:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlV6d-0006DG-6H; Fri, 21 Feb 2025 10:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlV6a-0006C3-1S
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:38:20 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlV6Y-0001WP-B2
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:38:19 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so3717416a91.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 07:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740152296; x=1740757096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRPV5pMQqeuIeYHTl+TnsXZt99QM6n1GWtO9C1Zj3A8=;
 b=YnAcvc39IK4gqEqNSTQExSo7VO8Ez03Q+dkqHX4JpNNBIlueSGO/fxqzg8pcEmwzc7
 +rl0YoUGKhpFIud98kAm7YGEW8q9hQlxSk7CO4wMbUBoQdw2D5XhhsyVccXvuF2IBcu5
 1nCCxj4pPFRJsUPC5OaXJcBbSovpVCBOKIxsNfqny3fTO+hw9JCBNZT9Pu7XsAg/JAbk
 44Rl0Wcb1SsTCSufykps5yQVLpacpTReHiCTMeEY9r7JeydtwSqDZcAqkIu/FAdJUGEp
 T3VVOulEIG44ByhegsDlZeoZw2q1DoXYxytG5OY+NQUuHlmVTRAs/GE63ihaMZqydNqq
 f/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740152296; x=1740757096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRPV5pMQqeuIeYHTl+TnsXZt99QM6n1GWtO9C1Zj3A8=;
 b=bKOrWWZrebRO4aF4+wTFeyuPYBtXKiUsEPRklX7/xc/LdO7IgwPVMa+f7T92uDlWHI
 jvzXA651Aq6cu+QeAApfrkwrIx4XH1NxDH9/QxEEJfh4nc6CF9vp1RdsGHqrx66ALZCv
 InlbNfVW/x0RC3i+ZuyVs8Q+r2JnPyAFZXGxIEDe9POLYJK4XngYedJr9Ame+Hk7BU6Q
 kFEuac90cieHcbDfqTkaCBLzSaEY1XFQDOfWY2kDJ22d3n+YpFeocOGDsLqseWQDePbz
 KP0ZNRGuuUlzMdUpSRRDKJjbJFGBLtIa4yAKxU5Wi1BEZ7XnjWg/Z3c0RGJEi+zqwVw0
 2pdA==
X-Gm-Message-State: AOJu0YydBZ43SNUpGzvFvXWMJgEMQxZxe8n5/4Tbh7W2cKsGpLF7XAy/
 5WExU188YNPMOsWLnW6NxeKL0WWjbSgC/7bPdPNy1033ib4jtKPOxxXvWBQjVxlLzE+4rqxUNAW
 b
X-Gm-Gg: ASbGncu4bEqQ63XEJxwXwOhM81XjKncGFhYkThoo0LeLvJ9CWMvKCr6SmT54O7uABlh
 rIpZjxY5avk4pQng694CXfzGfKuQJ/zpnYK3aWOxGOyKZqCZ6pQZ/NgkuhNIDp60NzHr78ZlXkp
 2LSZH4WnFVtXNrDP+moBq3ySQT+mJ7B4WD1TbW6yuN0rvpoIqwfPznBSVcCAynTb8t6a6M4S07j
 MSOlyYmORkCIzda+0w+YBP+/z/h8Q/m9qxaurqmAHZSQcGX8gAlM60MWkJtbnn6qDlNTqXrHgAh
 k1zEAPI0/++iw/+SXcJw67s1FuKl8Fkj2VgSyvALf2GEa56asOPraQ==
X-Google-Smtp-Source: AGHT+IGFPV4yOv0zcBXAtpcOht3D9Ksh2TqZcjs5DaVRm1wHhQIoF36D9Kq1WGe/nDtW4VpYfdL9Yw==
X-Received: by 2002:a17:90b:2710:b0:2f4:49d8:e718 with SMTP id
 98e67ed59e1d1-2fce78ae79fmr6730961a91.9.1740152294661; 
 Fri, 21 Feb 2025 07:38:14 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb04bedbsm1538081a91.18.2025.02.21.07.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 07:38:14 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 3/3] target/riscv/kvm: add extensions after 6.14-rc3 update
Date: Fri, 21 Feb 2025 12:37:58 -0300
Message-ID: <20250221153758.652078-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221153758.652078-1-dbarboza@ventanamicro.com>
References: <20250221153758.652078-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1030.google.com
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

Expose ziccrse, zabha and svvptc.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 23ce779359..471fd554b3 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -274,6 +274,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
     KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
+    KVM_EXT_CFG("ziccrse", ext_ziccrse, KVM_RISCV_ISA_EXT_ZICCRSE),
     KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
     KVM_EXT_CFG("zicond", ext_zicond, KVM_RISCV_ISA_EXT_ZICOND),
     KVM_EXT_CFG("zicsr", ext_zicsr, KVM_RISCV_ISA_EXT_ZICSR),
@@ -283,6 +284,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
     KVM_EXT_CFG("zimop", ext_zimop, KVM_RISCV_ISA_EXT_ZIMOP),
     KVM_EXT_CFG("zcmop", ext_zcmop, KVM_RISCV_ISA_EXT_ZCMOP),
+    KVM_EXT_CFG("zabha", ext_zabha, KVM_RISCV_ISA_EXT_ZABHA),
     KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
     KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
     KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
@@ -325,6 +327,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("svinval", ext_svinval, KVM_RISCV_ISA_EXT_SVINVAL),
     KVM_EXT_CFG("svnapot", ext_svnapot, KVM_RISCV_ISA_EXT_SVNAPOT),
     KVM_EXT_CFG("svpbmt", ext_svpbmt, KVM_RISCV_ISA_EXT_SVPBMT),
+    KVM_EXT_CFG("svvptc", ext_svvptc, KVM_RISCV_ISA_EXT_SVVPTC),
 };
 
 static void *kvmconfig_get_cfg_addr(RISCVCPU *cpu, KVMCPUConfig *kvmcfg)
-- 
2.48.1


