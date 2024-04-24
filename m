Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60297C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 09:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzZDj-00083o-7r; Wed, 24 Apr 2024 05:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rzZDi-00083L-E1
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:47:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rzZDg-0006Jc-Tu
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:47:18 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e2b1cd446fso54706815ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 02:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713952035; x=1714556835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVBbFgwhs4vkIs/l2c0xyQFfBRuV3ZIfacWshc9YUlc=;
 b=kDpjwkSrWo87MJvBELJDsfFKPzVdp1kjqGPpZsnJGZK3k3buWBsmAxbtcaDERU/vgh
 Np4LsgASJuJYD/UQFEAfCNIyTidCaw2pIoigqAXREum19+f1MWROL3Rhkmva/meTqKXg
 8Z01ZrbfAg5P1s2JJPKX0LF7mlRtbPZiJiD8OB8B6Qtx5LAbB0BOlK5LZtDM0b59zHmM
 AgvjaSavXMp1Ha5NVj39O+6Qq6Xvg4WeKQAcRDI6+3JexeZL1NIhK1MuXAWbMcsahCfG
 1XWTsQS29dMpG060ZJnEVK5ussiLlK/GuBXuAVRt+pI5j18BjuU42NJBhzMWZOoMj3Ht
 fjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713952035; x=1714556835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVBbFgwhs4vkIs/l2c0xyQFfBRuV3ZIfacWshc9YUlc=;
 b=UDGYxVLI5qwLW9aySON+pvBUlN7qHAvnG7B8HF+95G1b1hM/IQFx5Cuc/I5G0zm3g2
 p/ITzBRUv3i95LdLHQL+90KxNhd+BUAeMNKIH0+gO5uBHTlLX721P4SqC0KHsJnPyyZ6
 gT0AnrTCgOlc5K2y6Bhd4C79+CZ6JXANpWkgOfB+lCpzTMizEkPwvlG6XwKtAAcg5+Au
 xPCkhGCMs3mhZKM6/Fq4uEsEDwOQUv9Xrj0hBnKAuufOcQhGC0ra37SrOj8lKoNoWIYq
 JyNBCdgoKu8H893WQP7vBD1tzWJJEcCjPn7CnhK1C63SxCtTkamwZ2dvs7LNg8dXF3No
 +Nbw==
X-Gm-Message-State: AOJu0Yz3/TbHtxm82ePK2RreYqjQnd+QOmfaOMGR0s5aaVBD9p+KSsGY
 JDcH+OUkDg+OqB2BuQVMe/DfpYaJaKUbmuAf8QCXtnCbylQT8TkS+KOu7VfWtcetISo8Zj8liIx
 3
X-Google-Smtp-Source: AGHT+IGksjfH2PSsjZu3hL+vKxpz3NOjkrzikzVM0bJVgA/p652BaE4aJkS/4wK1s7QW8znQ4+wrEA==
X-Received: by 2002:a17:902:ea08:b0:1e3:d8ae:df34 with SMTP id
 s8-20020a170902ea0800b001e3d8aedf34mr2394352plg.11.1713952035345; 
 Wed, 24 Apr 2024 02:47:15 -0700 (PDT)
Received: from grind.. ([191.255.35.121]) by smtp.gmail.com with ESMTPSA id
 y24-20020a1709027c9800b001e0d62e077esm11513389pll.247.2024.04.24.02.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 02:47:15 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, alex.bennee@linaro.org, philmd@linaro.org,
 mjt@tls.msk.ru, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/2] target/riscv/kvm: remove sneaky strerrorname_np() instance
Date: Wed, 24 Apr 2024 06:46:59 -0300
Message-ID: <20240424094700.453356-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424094700.453356-1-dbarboza@ventanamicro.com>
References: <20240424094700.453356-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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

Commit d424db2354 excluded some strerrorname_np() instances because they
break musl libc builds. Another instance happened to slip by via commit
d4ff3da8f4.

Remove it before it causes trouble again.

Fixes: d4ff3da8f4 (target/riscv/kvm: initialize 'vlenb' via get-reg-list)
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6a6c6cae80..ee69ea9785 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1054,8 +1054,8 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
 
         ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
         if (ret != 0) {
-            error_report("Unable to read vlenb register, error code: %s",
-                         strerrorname_np(errno));
+            error_report("Unable to read vlenb register, error code: %d",
+                         errno);
             exit(EXIT_FAILURE);
         }
 
-- 
2.44.0


