Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F6FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytTy-0004Sf-Cs; Mon, 22 Apr 2024 09:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rytTm-0004Q9-F5
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:13:10 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rytTk-0002Dk-4r
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:13:05 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f00f24f761so3601272b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713791581; x=1714396381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s0uOuYuzumfoJBLjCu3eBZ4K9wNhu1mAl0QjtYH6GRg=;
 b=P71QoKeucE7Na1+/q2Z/Qwewxz/eCT23UEk9w8N7CpjVKzMO+schA9x4q/VLhaiVog
 MjC5/U3w1DySwh/dccB2ZjZMvIxw/9kDlc2V8bMk9b6sopeAPqmQwdFE8buq+kXYT6Gb
 uG+oxTVzJoY+UgccH2GTK9KBbzZwONr3XD6nZdLVaV4wlLROQEeC+oqZPRARWaIWR60/
 Ec530gHiPb+wzV+hEIbyNkodnFSv/oPWEzdcI3Tq8vPTHhxvvW3oDjKnEpw0bDDX1pLj
 MU14a5Y4UR9MLoj2iIcukFYd/Hjk8GQkO7v7oW/8EARarnSPCnW8+ediDYSgD3IiswPy
 FNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713791581; x=1714396381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s0uOuYuzumfoJBLjCu3eBZ4K9wNhu1mAl0QjtYH6GRg=;
 b=ERJdnBz438seD4uDIOVFqa7AHMWKKjJYPeG5WR0Tt58oPCSNRIItgbizU5oUjc6rW6
 PrO1tXchlMVxoI5i/ZYHtIYj9xVKcuSC5qJOXQUWNcrY4kuAoKYz2nJ6juefnd/GPQAv
 EXRKPMaCH15XfK5hq0lT81WI0/m8RNQn14Hlx93qvxHOXOJBIztxEVYLlbqrpyZsLQNo
 hYwObsDyM/9jhAxauZi5tmw0zBAsRgKB0m72zM7UJJjNiwFHLBMZ4MZHryXnjDUWN8rS
 i1wK4DxnZb9jpa4HD1kW8lPJz+kNIbN5R2u5pJHhCejckNhpxMr898ydsS5tGmwBmw54
 GFFw==
X-Gm-Message-State: AOJu0YyewbxiARouyFmysYX7CuJdPijjzexGdC01uvGaR8kdl3Gu5iru
 lsua0aZs5/IWfhAKR/L1I8dzAIFrdR2GT2MkBc0nAIEDRg8RYt2BcxTPUvK7ncVZw+xGi/g4ONi
 7
X-Google-Smtp-Source: AGHT+IF32DzN57RJyd67E8B8rlguZLvjwtnbPmhNc6CuNtLdJlH9L6ko36QBfQ92fb8izotZ3CbC6Q==
X-Received: by 2002:a05:6a00:6616:b0:6ed:4223:5b47 with SMTP id
 he22-20020a056a00661600b006ed42235b47mr8131740pfb.33.1713791580779; 
 Mon, 22 Apr 2024 06:13:00 -0700 (PDT)
Received: from grind.. ([191.255.35.121]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b006ea918dab9csm7744128pfb.157.2024.04.22.06.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 06:13:00 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] target/riscv/kvm: tolerate KVM disable ext errors
Date: Mon, 22 Apr 2024 10:12:53 -0300
Message-ID: <20240422131253.313869-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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

Running a KVM guest using a 6.9-rc3 kernel, in a 6.8 host that has zkr
enabled, will fail with a kernel oops SIGILL right at the start. The
reason is that we can't expose zkr without implementing the SEED CSR.
Disabling zkr in the guest would be a workaround, but if the KVM doesn't
allow it we'll error out and never boot.

In hindsight this is too strict. If we keep proceeding, despite not
disabling the extension in the KVM vcpu, we'll not add extension in
riscv,isa. The guest kernel will be unaware of the extension, i.e. it
doesn't matter if the KVM vcpu has it enabled underneath or not. So it's
ok to keep booting in this case.

Change our current logic to not error out if we fail to disable an
extension in kvm_set_one_reg(): throw an warning instead and keep
booting.  We'll keep the existing behavior when we fail to enable an
extension in KVM, since adding the extension in riscv,isa at this point
will cause a guest malfunction because the extension isn't enabled in
the vcpu.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6a6c6cae80..261ca24504 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -427,10 +427,14 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
         reg = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
         ret = kvm_set_one_reg(cs, id, &reg);
         if (ret != 0) {
-            error_report("Unable to %s extension %s in KVM, error %d",
-                         reg ? "enable" : "disable",
-                         multi_ext_cfg->name, ret);
-            exit(EXIT_FAILURE);
+            if (reg) {
+                error_report("Unable to enable extension %s in KVM, error %d",
+                             multi_ext_cfg->name, ret);
+                exit(EXIT_FAILURE);
+            } else {
+                warn_report("KVM did not disable extension %s (error %d)",
+                            multi_ext_cfg->name, ret);
+            }
         }
     }
 }
-- 
2.44.0


