Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DA1CCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTc-0007Iz-DP; Thu, 02 Oct 2025 23:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTW-0007GU-3Z
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:54 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTC-0001FU-2w
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:53 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-781db5068b8so1537190b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462104; x=1760066904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKRPPU4A+nxrYrp6xl+CtDnJu5H7vR07oXy0I+YQ5Oo=;
 b=RCu2RRoIfCJKfr6rIO7UxkIYppyrDXC+MT2uATY3NGJHAGg1HiMDhWRuSVX8jAREri
 2qKccHSNaJ+dqcFql7QTY40gmLJrWp7K7eeHce3f6+/hwMLiGyzWMnk6ljtOloZO3g3t
 dEMubiJLiNODRMfEBhNk7KxeIqdRhVbUOsst2FrGuLnO9qYaUlCW2Jfq0AobyGDYZRp6
 kapAci7QpfCPhR3+OxeZw4fNZw4OAJTZx7fY3z9c8b9tBJCyhRMpEs8V/EvL5T8SgybC
 6m2B9qxkxUrv2OB+6iC2pNIctIwZ/o4Qb2YDpH0No86sDuF8PO8G0Dg0+HoH7I60OM+Q
 vx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462104; x=1760066904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKRPPU4A+nxrYrp6xl+CtDnJu5H7vR07oXy0I+YQ5Oo=;
 b=Gfs0cDliip+Aaead9aQZB0ARjeGbuDSRIshgzoge9iBTXVaWiWlKdM28Z23yF9clc9
 NMrccY77yv8qHYELQUHD8GrVjM6dcRR1giUN4Q3Emj6hVSNqkzt6noOTLLn3CXyUGkgX
 fBjlYPpfzoAPbvRoQIxIVBbGnkjozkFf16lu83bvMyAtZRpSmIJgOVoWJFKM8mf4dFfx
 44/fKXJOvgHjazQTF3X6NnjdNzFkD8ey5dS50CqtorFDU/rBrMdJKhvF1D55mHC+B1xs
 +16CrjmQv5PvoZM3YmjioZBx8n8ABvV12X85bhmxGtqzVKuYkI33Kdtpkbdt5S+JBsGC
 B9gg==
X-Gm-Message-State: AOJu0YxIqJU7Eo4C2CQI7e/b1IlwYpdLCagDfotr2bZ8PDzKSZw8OLWh
 6cs6MeZAfPbluffBDMxdIavlXPZzncfthlpS6GuHtewWsHPUeL12iezsfq/0ZA==
X-Gm-Gg: ASbGnctLss1u0AUze/thF10ZECx3ViERxEhK2+XFdF79ZCEiALP3KqpC0oFdISDJ4bE
 AtM9fvI/OgG0iCuRGVTiipO8Z5AXnXiAmPDcg1YZEBrij3GP3T7qaoTbdOn9VtldXrNSlizbTWr
 bgE2eAdhbENyCwEGwNxCmGGhYI0GBnDZCXBzyj6WUlUhdyW8NiISa9WwsjG86BuFQRYJmw19gtz
 U1MgAzDoJSG23jcJBWEd0mkGUoXSQCasu7cMPZs4bbuVwDfZiyheK/z+3pXcaShzlMB8BREMHVY
 +RKsZUcZB+Q0wAv0kPMoM8YdVRhtLUVaUApm+sxiX8FdqeIv896vVda/w6vL/cCS3VrjRA5Wt/x
 mwLuPdeEdYl+8win9nyBDcq9ZbMoVgq8ScyDAJtBEbLPVoUvRmXlK90/XGa64QW5FTXPkANLPVW
 IIDtzBVKwZl0q8Cmp9aYDkXM1lnlTkdJsqxB6ahSbt9PnzjRwySKGu
X-Google-Smtp-Source: AGHT+IFKu+zwCUpMpv7zt3jMrJOjGKE0AHRYl4MXftXzn/oWw9L3V9oOWDhoJzJr4TbZ2pga4OwQkw==
X-Received: by 2002:a05:6a20:7354:b0:2e2:3e68:6e59 with SMTP id
 adf61e73a8af0-32b61e6cfe0mr2159191637.15.1759462104544; 
 Thu, 02 Oct 2025 20:28:24 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 14/26] target/riscv/kvm: Use riscv_cpu_is_32bit() when handling
 SBI_DBCN reg
Date: Fri,  3 Oct 2025 13:27:06 +1000
Message-ID: <20251003032718.1324734-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Use the existing riscv_cpu_is_32bit() helper to check for 32-bit CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20250924164515.51782-1-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5c19062c19..187c2c9501 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1588,7 +1588,7 @@ static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
          * Handle the case where a 32 bit CPU is running in a
          * 64 bit addressing env.
          */
-        if (riscv_cpu_mxl(&cpu->env) == MXL_RV32) {
+        if (riscv_cpu_is_32bit(cpu)) {
             addr |= (uint64_t)run->riscv_sbi.args[2] << 32;
         }
 
-- 
2.51.0


