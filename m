Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EC6CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmk9-0001FG-5E; Thu, 23 Oct 2025 00:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmk7-0001DX-Cd
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:16:03 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmk5-0007PC-B5
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:16:02 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-339d7c403b6so403811a91.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192959; x=1761797759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVyDchnpaufAUdHDG07+zr6M8RudbX2zXfefYnIk4O4=;
 b=IfgehgX0KSQ1iFa29Vi7wrhls3RSdd43UQz+Y4rBDhB1CONZKzSmfe2f26XVf/YuXk
 8h+KfAdalm+miUeWAUS5lZl9bJqOrQBXK0EuZm0EcVOinaOO28nLFD7Rg7hg8jxforyG
 xsfITPgkQUkByf6+FcsVkMziamrTgDSsE6iOqJ78mK9reYV9ShdqzJLlDvfamqjhjz/9
 W5ZaRmKqYpwOVi/e5r4i2vMAvV61O+SyusI4SKqvkSP71J1B02UTY8xkAlhaKPfrl6LR
 N1q54HUa3hCxOK3cb3vXyymWWtJue23stX3pfc3nv1GlK3qCtnOsaSfTETJgvpCOEf0u
 IyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192959; x=1761797759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVyDchnpaufAUdHDG07+zr6M8RudbX2zXfefYnIk4O4=;
 b=BsHXG1DPsK0Ik1wdzj4ZbyeEEtDLImpSQyFJ5g6qwniQuc3YCaEGI2Q/PDsM/BNGJG
 axGUXhR5V+ao7YL3GmRppNUsIi3oNqso0TnvRVDRhmkSRgbiR3v6nPol3VRQ7zQ66Qo2
 X0xk5zFjKbFchfzyf8F8bhkR6ZOlZdU3nB3uHBrZ5Z3QT0gLycaK/io0epwRH41/MXs0
 pjjNe+bUmn/a8FQOdSD1TG7FgxpYM8pFAFMP0/MggVHeFUMuiiC8xWQnEVhUOsF98xxR
 aOvGs3j4GgfRt6D5cgwfEDwp2rs/4ihcAbS/hRozKG8c0uyjZjHZCpNSi1EPPX8PU2xW
 ocYg==
X-Gm-Message-State: AOJu0YwbtiJyfXsCgRaKwNoQMlnqyr7IFjUQiURFMTYRc5h9z15Agwq7
 I8O59jvsLdVx7yPkb501FNU8YnOJL23C/ESgmbsvm7mgaFXNxJ8gENW/3gVycw==
X-Gm-Gg: ASbGncvfaDjDdhiljnsryeYlGIdEu9DAklS1vmOHHt201kNsO0ZISLPPfxQJWC1A7Nb
 HpYIEqr17Yuyi4zOrZHVb48zoE5hx1uRba58PpktT3++53psy+USEF/UAikGqusxmHbaTB6dDlN
 UvXB5FqP7HyjJV2lQ/MhUr9yBV47X+HUKUIE28k8THGOrf4yjH/GsHQ5BiuBYyBxCPho4GSGnNP
 X9VPufO0TVhD5nHOgykW0tOmgMPaeQ5rNq0MbDkZXqDAR5RQlguXnNSlcCXwMOkmbeIf8dyaZok
 xCTd3dIG2wousnOwIIJJgjzOomoFpfJc0h/K07o2uBpJvekWHJkzt8PJH/2QiXVN4TjSWhZegfv
 IWYbtI+AVUwv7c3/e82lcNVhsyj7RJrRxGP3t6sqjSBqDMteEhYQhVCsDNxQKO25oKdxS2uZNT9
 gYaDji+O3WaSQblJcP7P6Y2OWlqEwoRPesvZiYW9gAerzy9uXuUOuaO1a4uokPc5xlRS0RSRw+J
 VlT1msmaRpiOcKEvNMJ6Mq8CZYEVuw=
X-Google-Smtp-Source: AGHT+IHbQzmMWZzoLn/sI4wf8UENA15dSRgO5BC6HV+wiGbATeoOFYpNT+h0aGU48lBOkPLLsR5JgQ==
X-Received: by 2002:a17:90b:2ec7:b0:32d:d4fa:4c3 with SMTP id
 98e67ed59e1d1-33bcf90f957mr25767302a91.31.1761192959067; 
 Wed, 22 Oct 2025 21:15:59 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:58 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/37] target/riscv: Add MIPS P8700 CPU
Date: Thu, 23 Oct 2025 14:14:19 +1000
Message-ID: <20251023041435.1775208-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251018154522.745788-4-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu_vendorid.h |  1 +
 target/riscv/cpu.c          | 16 ++++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..30dcdcfaae 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -56,6 +56,7 @@
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..28f0ce9370 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
 
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x722
 
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2b655371ad..f05747a2d2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3283,6 +3283,22 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV48,
     ),
 
+    /* https://mips.com/products/hardware/p8700/ */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode = VM_1_10_SV48,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.mmu = true,
+        .cfg.pmp = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.marchid = 0x8000000000000201,
+        .cfg.mvendorid = MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.51.0


