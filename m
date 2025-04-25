Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B7AC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HNP-0001FO-7V; Fri, 25 Apr 2025 07:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8HNL-0001D4-1W
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:37:47 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8HNH-0006YM-Ex
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:37:46 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-309fac646adso292936a91.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745581060; x=1746185860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3BrB04qgYNqKfjSryNKQ6LiS7/AW8R3CaBfrk1SZh+A=;
 b=Lyt3KnoczpBDBQTZn+A6cOXWoyvugPPrEs9hGiNAUGCVATkqKDc6GjWJG43tSrHEPz
 fRl7BrybtBlWcHPu82SG6LKXRgG9eoccWMtdwS2EIikIxqYeEWsyRQ82QqIN9YZIACuH
 QPU2kGWmNw1mn6Fa8NNvfmBkcJbX0JnW9+oMJu3cQPvAo9rqbTwE6KBC4QWcfBOy/c8F
 DAsXwE15WHh+Kgmnp7EDXtsDV6H7FFI/T4jSRzqqnTj4afTHjeH6+zH4hS5PxbCUZGjm
 At855Rkelodh4JQsUyCr1Cn1M2gYjLRY32lbUp6eETlDYHEYq9AQzIH5LTRepX7IlLA+
 YiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745581060; x=1746185860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3BrB04qgYNqKfjSryNKQ6LiS7/AW8R3CaBfrk1SZh+A=;
 b=K6JdVbfZcfBxZlS8v20k2dmflpWflzf8ttxjl7DxeINNkHveJ8vEPfg4uyTYKY9TM4
 I1Tw6KKuV+4RszzKdT3qHy/Y718tvrIcyBfe9y06B5JN+eu6aVaC8/8mD8zTLAWM8CXW
 1LP2AailypUWq8w7O6OkT2kjKsCbv8Tu8zUvQFHiDkUWEagLIfuDjqVvZqWnSY3OD4gU
 c0bYMxqUdsqIyT3+sA4Fu1Ol287t3ReXCqoaNivq8LwgYv/FAK8Q03sfcWdecE7jcTqw
 3WPiFSxXeMQYrT0gWF0NmqhmRgrgx6sUNVoDltlfCIb8QDEQEnmVNcSQHENE22/25ftZ
 sqhw==
X-Gm-Message-State: AOJu0YzVYTTsMoBYZ73aNw3zOjjinUMklQIvxKwW5bfMXCSZK4PikOJf
 0v9zSq1u/Uns/3TBI3oygwjfoSOGlYLd7CGI9F131r9CK538kUzs9PIybaDQxS/gEHxfjQUjbIk
 s
X-Gm-Gg: ASbGnctVGbcjB0BhcF34bMQSoPC7y/PTreJ98y99178m3avkabwxSrQeSXayceqxU7K
 QxplL/8kPptGPG3IbMbeBHl8YaCULv4J76ZJyFYyZJXazyhViFJJa/Q36e9jT29GCVIFCcNfx2f
 PDPf5+TkzPlJximlEM4VKGLYlnY+u79CZ/HmCyidwVlnEWFRYzDphomSDb56vj+kpvdaWHoiZml
 ZOMvs0vbzW7Z2X/T9tvMpvVGPBh/eXYqtxbohwGldOFSpC7Nc7YK+Z2t8Eb5YRUUnu79OU0gCHh
 loUDijVRZlJfkWVMeZtrVud8LnIw0+GQIwRHrGKY6PGg5A+0352zPIG7e1xiXCUlX5U/598Tta3
 OvUQ=
X-Google-Smtp-Source: AGHT+IHjcK8IhIJ7Lo8b4E1ujd1NxeRt7hzev3Jng7Nw3EMKfClhu0xFTXgargc8vR7xTS0uNn9M3w==
X-Received: by 2002:a17:90b:2e42:b0:2ff:5267:e7da with SMTP id
 98e67ed59e1d1-309f895d406mr2454031a91.3.1745581060411; 
 Fri, 25 Apr 2025 04:37:40 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e7a40sm29881055ad.147.2025.04.25.04.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 04:37:40 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 7/9] target/riscv/kvm: add senvcfg CSR
Date: Fri, 25 Apr 2025 08:37:03 -0300
Message-ID: <20250425113705.2741457-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
References: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1029.google.com
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

We're missing the senvcfg CSRs which is already present in the
KVM UAPI.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f341085ba1..e37fa38c07 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -249,6 +249,7 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
     KVM_CSR_CFG("stval", stval, RISCV_CSR_REG(stval)),
     KVM_CSR_CFG("sip", mip, RISCV_CSR_REG(sip)),
     KVM_CSR_CFG("satp", satp, RISCV_CSR_REG(satp)),
+    KVM_CSR_CFG("senvcfg", senvcfg, RISCV_CSR_REG(senvcfg)),
 };
 
 static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
@@ -698,6 +699,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->stval = 0;
     env->mip = 0;
     env->satp = 0;
+    env->senvcfg = 0;
 }
 
 static int kvm_riscv_get_regs_fp(CPUState *cs)
-- 
2.49.0


