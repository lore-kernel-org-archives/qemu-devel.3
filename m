Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21F7C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKML-00033C-Ul; Wed, 12 Feb 2025 16:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMG-00031V-NM
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMF-0000Vw-2A
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:24 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so949645e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739396001; x=1740000801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5ZardDRY5uFFdKZhZV+6eAW2H8HO/6VhBaUOEC8cY8=;
 b=F0dwIX3aj380c+FCpVqVapBRhSoIp9gHtlh7OjBpCeQLtLDoPjcvyM4TZ0sDj8hYDq
 FkzC6hef07DCu55j1hD2aD5Dqk8rxKS37RBbvLFm1LcPLZfALxJ9OnChuoU0O90be79T
 XksR2Cwnb4p6pZhflLe07qT43hPsY2T7Hm4ulUmtJPLS/wgllt+h5AWdoQPRBJzrpGgK
 VfRkWmp0HXjq/stXSWHuaexklQXZ1BISfYc2xSGHO5uRqN7rj/a3tuPybwwLenVldh4Z
 IwWzkPhbWqKDXjnd33O4HAtVesmHg3+KWgGEBbeED1UuxsVwXh+C8bLAhrigJhIlEuwD
 sfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396001; x=1740000801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c5ZardDRY5uFFdKZhZV+6eAW2H8HO/6VhBaUOEC8cY8=;
 b=Fkp0DbFjTzZBrpZSiKT/Fop0sfYSu5MZdmpnzldIcQ0lnB+8IfIIHTbn2E29D/QcAI
 ubeHgz6z3Ek9ciMLjX8+Sn41lu4VLN0YQfl3hBvnWpP/mtQFQJTV393ANf/s0V5386P/
 QNl3RBI8lJoer80v9rd13Ycz+ztruZjlFR4bt9UGl48lAOVzRm1m9QSlYuXuNtlYjjeo
 V6g3323GxA9barPg3D5rkQ88Tju00VZTA9aKik/emgj9GWs6oqUKLW0ArLGOgKynizOc
 7Hgr2pigehMtGru1lZyTTiqTOWl3ngNDKkFh5KX1/YxDmlabgS9QGgupzrgJ86klobms
 KIdQ==
X-Gm-Message-State: AOJu0Ywp7fICts3cH6a4mwHQ+u3Ae6BsmFeSHtscJi95CANV7inpqTdY
 +pbVawUPpi7g07Nnv1V1ejFip3aG0+/lMBJq9Yk0WiuEa4ToCptirB+LtTxkpBUKMYjf9hMOVdn
 6jug=
X-Gm-Gg: ASbGncu31AEXB7LOwHZ0czFmmkhLsrxX18JrMt54QaM+wwqcmZv8au7NFn77xNS1g3P
 OjZBiUTd8DpZ8Idli7Xv2CDxifVQBaaazNpsRoEGVciwL7TFA+aRyaq3hXGopnRvaS3UgNSgVgA
 SLgVTBe4kNDpMX+m8FWE5NgbbKiLG6k/IG229ymJYmb4O6mZs3qg2799ON4wt0E5N5bQAdK6eaC
 aYjyGebOQ3EcaE+acor54NR7qv6mEM/4fvHOwvv1RSmL0fNtns1YUPw2eDThu1LhRThbcSYfJl0
 IAXnkWYY5F/bra6heorexFZYZT3hU1xBEL3PR9EnofavBB25vI6DBkLpu/11MLPzBQ==
X-Google-Smtp-Source: AGHT+IGeNRZCV5y8645k2W6HrR773i8Kad5BFmKCsZ/+le/1+MFrTk1ujGEGItA8nUt5IiJI2B8Nhg==
X-Received: by 2002:a05:600c:45d1:b0:434:a529:3b87 with SMTP id
 5b1f17b1804b1-43959a2ac8cmr42334305e9.10.1739396001233; 
 Wed, 12 Feb 2025 13:33:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43959d3d5f3sm31622955e9.0.2025.02.12.13.33.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:33:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/19] target/riscv: Declare RISCVCPUClass::misa_mxl_max as
 RISCVMXL
Date: Wed, 12 Feb 2025 22:32:36 +0100
Message-ID: <20250212213249.45574-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 97713681cbe..fbe5548cf5a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -529,7 +529,7 @@ struct RISCVCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
-    uint32_t misa_mxl_max;  /* max mxl for this cpu */
+    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
 };
 
 static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3d4bd157d2c..f3ad7f88f0e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2955,7 +2955,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
-    mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+    mcc->misa_mxl_max = (RISCVMXL)(uintptr_t)data;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
-- 
2.47.1


