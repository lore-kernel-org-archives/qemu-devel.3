Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B79CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Pdf-0001L7-Oh; Thu, 16 Oct 2025 11:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Pdb-0001Ka-Ez
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:11:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9PdZ-0002Ik-6v
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:11:31 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42701f2ad61so377766f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627484; x=1761232284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qgp0sP7L+ekri60tZzxWtWUZiYLKC8O37wWkMZnnI/o=;
 b=KCQLFpuEUxk0nE37XTSOD5YFibImT41tg6CM7zSauAYoqZfY4mgoRH94qhRhAi4vUD
 SaYp3yThsTU9KnJ0qsM1XHgJ6pPQghzGRHsLdT1wTaFkza4Q+0dDhUZwDwIS/mbRS7tR
 LrSYxSbxp40yN5014C5hjIRaLSB0Wsa0mu07H070PgNaZjLZUYqkGPCxRZCI7c6Wog4N
 IVYRwkVB4PirfO+5VJVieKJm3sW06sftwaH3EODK/dpGelTPTj4XVRC5k8bzK4b9kidH
 OiOtJ7nn8uu/gEHwnWiCRdUnxzm+EwLvAMUW5qZ0JW8vnsrKayxXbSDyRJScNF7d40mz
 /vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627484; x=1761232284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qgp0sP7L+ekri60tZzxWtWUZiYLKC8O37wWkMZnnI/o=;
 b=M/veUpWkS04X55rTs4AZSC+0ABOjaMwY59TKAHh6ONBC8zR3yfWRTB9mrIk2bRrSQF
 2B/e5ahYRsgKEJhD8o5jtlIDQb9Q9NHr53hbndXy3AetvkAbJfA/dw80an8llaoG6UUj
 T53TGpEiVfpr4v/+P7VASEjLXe3JCitixo8ZACGI020+9qez+W2nh8EyTHJWppCEumjY
 ThUGFBN4NoCXUH0E7YbH5nWzk+UFGXNp5PBLQfP5F49WPfac/EnuDWvUngnGbdy/VFpA
 2F75yIOHg0YzPJONXHOstUdGgjR/QWRAgM/MHcIxuuIMfzUoQRjeOeCVZvWiXUFoGQd4
 PvVg==
X-Gm-Message-State: AOJu0YyJFJMySfoVrLhPKgORNXCbMmXdUXOo49RhL3hX5vj0AceS0rdu
 InOX8SQ/0ZL+G/ED0ewJqKuYOCHH/GwkpXOLsX7aB2Rij8j8rCkm02uHlbNXWrZr2I68vHFB/ni
 yfsDrGoY=
X-Gm-Gg: ASbGncsPZISKgfQHvLUhdOOeXJn+iHO1CNcN3nis8SA3A29shl+KMDhCbDN8ewdBSiB
 w+p0L7V8lyrIqCFQ1aFEw7vSKVFIrCdP7sq5nh1HHPLK3ZZuRzvPJh1k/uv+Yls8/98cYA3eaoq
 XMKPmqTJjatYwMu1qY1lzI9M1pUGmb+vu+rrF3GZPWHHDyR4Gz6+1CDLYkHx1pmi+5p56Zxy23q
 66L6KPXCerGbXGJeuxhcC/HafmUrhQ8Is1LPwX4EYWFmD0jEWS3GWswzeZKVmZvqFH25OZmcew3
 95S2L5hdBUl3MOwRDrVXzuZBqG4rrTae0JGYjLVJr3c0JRBuBl3QRB4cG/432h4KwriokVMEU+N
 Lna5gQZhEyd9el1ldIDfvh2HJCpFjQMtGPyOTgD1vOs2FVM99PBaHFGOidvKntPIwXlCl+zKYuw
 2bmItWBtwh81u8sh9nKMVH1bSQ54jyPdaJ6yBlYkei3+qUwNsoYSLbKtZ9OzQ2
X-Google-Smtp-Source: AGHT+IHBIYSFbEC81ljofFF05azxb1c2vYo6//drieVcWFW31xWJHjjr25E8fxojFGTu3HHM93pFoQ==
X-Received: by 2002:a5d:5f82:0:b0:425:8133:8a89 with SMTP id
 ffacd0b85a97d-42704d75729mr424375f8f.22.1760627484157; 
 Thu, 16 Oct 2025 08:11:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426dac8691fsm26627823f8f.50.2025.10.16.08.11.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 08:11:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 42/79] target/riscv/kvm: Replace legacy
 cpu_physical_memory_read/write() calls
Date: Thu, 16 Oct 2025 17:11:06 +0200
Message-ID: <20251016151108.18442-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016151108.18442-1-philmd@linaro.org>
References: <20251016151108.18442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Commit b7ecba0f6f6 ("docs/devel/loads-stores.rst: Document our
various load and store APIs") mentioned cpu_physical_memory_*()
methods are legacy, the replacement being address_space_*().

Since the SBI DBCN is handled within a vCPU context, use its
default address space. Replace using the address space API.
As with the previous implementation, ignore whether the memory
accesses succeeded or failed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20251002145742.75624-4-philmd@linaro.org>
---
 target/riscv/kvm/kvm-cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 75ca3fb9fd9..0dd0d59d41a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -36,6 +36,7 @@
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
+#include "system/memory.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
 #include "hw/intc/riscv_imsic.h"
@@ -1564,6 +1565,7 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
 
 static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     g_autofree uint8_t *buf = NULL;
     RISCVCPU *cpu = RISCV_CPU(cs);
     target_ulong num_bytes;
@@ -1602,9 +1604,9 @@ static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
                 exit(1);
             }
 
-            cpu_physical_memory_write(addr, buf, ret);
+            address_space_write(cs->as, addr, attrs, buf, ret);
         } else {
-            cpu_physical_memory_read(addr, buf, num_bytes);
+            address_space_read(cs->as, addr, attrs, buf, num_bytes);
 
             ret = qemu_chr_fe_write_all(serial_hd(0)->be, buf, num_bytes);
             if (ret < 0) {
-- 
2.51.0


