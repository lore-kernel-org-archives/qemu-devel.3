Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E3AC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 06:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty3b7-0004OP-5Z; Fri, 28 Mar 2025 02:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ty3b0-0004Mq-I5
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 02:53:38 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ty3ay-0005Ln-TQ
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 02:53:38 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2279915e06eso40266695ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743144815; x=1743749615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IT1ob+oVVHNmCb9rLnPe9cCt40MLH5r5ys2O5Wne8FI=;
 b=F1v73rhZOhr4HsVCbIgLVVHXuAWBmsz14+E5vUNox2gL7nLku4ei1yvK2G9wPxcxFU
 gG44ROOStFdfbhdMyVxUJIat0yGMaeKkWBcY5AUVTh+4+AMGWLzwvDBvnHghqHDjrYFm
 P+0FYaMGf7xQ9PJThUJpReNGDuPJ2uKY/UDyNKQhsZMYHYFNJBoTPLZxg8mzgj7kPxZI
 TteNRgZZedrDzl/97A3uQEIXfQCNwJf+C8PrT9Dlgkde1nMdNQHuYtepEgkMfgYOMv+Z
 pP+QLVgvhSehLiWvkBoriLPYCucgtpKjR2nQLbzD+q9fKkPBm5BXLs/vrILfyEjqyk5l
 BObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743144815; x=1743749615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IT1ob+oVVHNmCb9rLnPe9cCt40MLH5r5ys2O5Wne8FI=;
 b=hRErjyNjv6o7/KByH6a+zouv61OP0RdjlCIIb29Qi8ptE/9tr7sw2KhtptcwjVGgbn
 FWbguik9boivoTY5rBX9NsDbgElSWq6BiT0hJ4vD7PPsD5eAC3iimgK5swx5SuMZL///
 seg1Euwld1AQSjBqaYS98+AJBV2ZWMqHhqvlvtQRvrfILL4UFaRAZH+5Da3uu6RKpuoQ
 HZsHYBHH9yP7TRLIJzp2yPtcivqKv1v9SmXU85s0naghjV/fpWGwUMN9+3F7B2hO0HSm
 DVh8Ta2aqebJzXtnpqS3xJGTkHpGZhYJghuqkJayarqTwuuD9zq2NEESNBVsn//zmReP
 +eQA==
X-Gm-Message-State: AOJu0YxDVAFDIZ9n3/b0ZoYA7IgVhKyWDIhjgYRrLm7uDbenzYjHThTs
 pJRjMaimoeMEObq2G6nywfarKTqY5OeaV5pkGEp8Re/i0TlqT/1BuZP3qQ==
X-Gm-Gg: ASbGncuuHzkPb9aV2k/UxE5wXc+JYM9PCc22Wub7WX/uS+qMiYpjKlhDNvYOGeeETRv
 LqkpWWcKARbSYc8bApHPWsOuf2rR7IGZ9wRXeck6O3s4OoeLDqCARRia+onWPcMta2tO1OS4PPw
 3tMLsL87ah27BEiUKHE1XpZO7ZAQtoH9mcmCX0HK3PtW6dB4unO6dLJnrmfvlbMqqAkpZIX3X3u
 2FJACpged45evF7fC8yXrMw0MV4Y5ohhpomPjwhbWQWhBLb046Ir1d/OTFoqMl36tQmAttNtj5l
 kPoAhgFSG3EnaDxS9LkCsC7v2q6X+y91afjM3UeMh3LX6WXbwSnPIrJ+rbS8jx20ahYKr69NUa/
 1jjKPcQ8gz5UYOFtWcexsD6si2gjtgnZFzVcPn/aT49D6CF89c48=
X-Google-Smtp-Source: AGHT+IFbH2sgTOLp+gjjFLuf3vptBDaJAnlyXboP1rYs2VsujiMe/2McQdiDc1YfF3LZk5x1+mCHYQ==
X-Received: by 2002:a17:902:d50a:b0:220:d909:1734 with SMTP id
 d9443c01a7336-22804851d85mr92835975ad.14.1743144815177; 
 Thu, 27 Mar 2025 23:53:35 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1cf8fesm10633025ad.110.2025.03.27.23.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 23:53:34 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 3/3] Revert "target/riscv/kvm: add missing KVM CSRs"
Date: Fri, 28 Mar 2025 16:53:18 +1000
Message-ID: <20250328065318.1990698-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250328065318.1990698-1-alistair.francis@wdc.com>
References: <20250328065318.1990698-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

This commit breaks KVM boot on older kernels, like reported in [1], due
to senvcfg not being available in them.

There's also another problem related to scounteren. Using a recent
enough guest buildroot, 'ping' will be build with rdtime support. In
this case, doing a ping in a KVM guest while exposing scounteren will
result in an error. The root cause relates to how KVM handles
scounteren, but QEMU can work around it by initializing scounteren with
the host value during init().

Fixing these issues in a non-rushed-bandaid manner results in an amount
of design changes that I don't feel comfortable pushing during code
freeze, so for 10.0 we'll remove the CSRs and re-introduce them in 10.1
with the adequate support.

This reverts commit 4db19d5b21e058e6eb3474b6be470d1184afaa9e.

[1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com/

Reported-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250327152052.707657-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 4ffeeaa1c9..0f4997a918 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -624,8 +624,6 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->stval = 0;
     env->mip = 0;
     env->satp = 0;
-    env->scounteren = 0;
-    env->senvcfg = 0;
 }
 
 static int kvm_riscv_get_regs_csr(CPUState *cs)
@@ -641,8 +639,6 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
     KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
     KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
     KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
-    KVM_RISCV_GET_CSR(cs, env, scounteren, env->scounteren);
-    KVM_RISCV_GET_CSR(cs, env, senvcfg, env->senvcfg);
 
     return 0;
 }
@@ -660,8 +656,6 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
     KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
     KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
-    KVM_RISCV_SET_CSR(cs, env, scounteren, env->scounteren);
-    KVM_RISCV_SET_CSR(cs, env, senvcfg, env->senvcfg);
 
     return 0;
 }
-- 
2.48.1


