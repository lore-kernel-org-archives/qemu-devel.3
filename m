Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9072E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTYF-0008Ts-Qb; Tue, 17 Dec 2024 04:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNTY1-0008M1-Q8
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:07:21 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNTXz-0001Xr-PN
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:07:21 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so3275859f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 01:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734426438; x=1735031238;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeWDWcKhmjqqXIRstj58bXoYdtGc+tASiZ8vjREnW3c=;
 b=ZFRLIB9acRizTgyV069oTWb+fbR18HoapHvRj3wv+jITgiYxSCz6yqtlZFqtC5uHIB
 1QSMivKk5LodQ6TMG57QE34VL2Uo1pyAdNEtayQe1MTYDGXxsJgHcPuHRNxt3Hv8qq/a
 lzvIFoJtKlqSLtLl9lwjczcWoc87boFbyfJlCy5fVCH/Jo2FWiOCmU7bgwiW8nZ6z4ts
 BgBPL+c4bqA3yUGc2Sta79hs89FV1ie73b5o5ReVOOORbLjxX+ebaQiFyvBRhVHSBfso
 FaRg7nj37YEZq6jhrIKjK+ardW3x2VsaO5CPhv1n3NMBmhYe/+4a//yTpdNtsOIZnywi
 UomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734426438; x=1735031238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeWDWcKhmjqqXIRstj58bXoYdtGc+tASiZ8vjREnW3c=;
 b=icHM9KWFUer2VuvGa0KQqk1+G0gTrl3cC205EQaotD3D6rUf4dR3McwbOICMG9tEVH
 u3r+DA+hH8Xogg36Lgb5LsD4YnZY+NWWutxHYwqIbCPi5YGJVSO43YCRjtd9SUV+tTrm
 VwyjeVjPYYFrKCCV4xeyKZIVE8ncEfq+6lQ9GX1mHF8+9wLdRpCAJZdzlMJK2sgO0q3Q
 piz0jn6LP2a5U8o+ARlPtMNKGQTZ0KhB9Q6VPQLxOFISDZg96mQvZI6L6d1poBSvyPc1
 27FhMvauHSfr14B5Z2d1f3penmiVXpkKEnpu8R9p8JRHmJ5DiGfy1cX1HAqMniEa+FGI
 Raqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEDUFU5pAtkUfF8R9JzuL6ciBv1yfYdpwTjEELmvrm+UMKXcGBvxEKpxBPjWBB0hn0lOLF2eC3oHaj@nongnu.org
X-Gm-Message-State: AOJu0YzXjXl4am2PxKoIo5bihn5uSWHlykiEhPhWdwOJBl3oYDWPkTQH
 Mf2KTuihITIyL215Ld4K18Exy3WeRXq+sXpjvfFgQNc2AkughhHXEOZ4ZLyv9bA=
X-Gm-Gg: ASbGncsxKv0US0X+EFLExoNEXgBCyjudYtgTRnceGqf58vCqLxT+qblY3J2x/hIPtxU
 vsChavEMpYYQKRFqQ0WbsS2AToCItQdVIuQsH4yJPY8GY5NfZief/oYTa9F9AeNYV/MW9VCb+n1
 4nyKKawERgrzsKgsJb+C7NovWClu6HwP00cbEsVu30OHObwS5k17Ho2fPdSZzv0CvAlMAnGuQXw
 6OA4mhjRGholv+RDkNBXX6wM4ld7elHOss60TzAqpeQa5KaSt6SA8QmJA==
X-Google-Smtp-Source: AGHT+IF+X+xGyFgBL95dJYw22VXGuZe8LhlTZMDy95RNbEoD7OBvYROCLlj5G96W7Z5jaHf5TInkQA==
X-Received: by 2002:a5d:5f90:0:b0:386:3327:4f21 with SMTP id
 ffacd0b85a97d-388db260b4emr2453464f8f.27.1734426437751; 
 Tue, 17 Dec 2024 01:07:17 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046c46sm10704122f8f.71.2024.12.17.01.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 01:07:17 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 6/9] target/riscv: Add Smdbltrp CSRs handling
Date: Tue, 17 Dec 2024 10:07:02 +0100
Message-ID: <20241217090707.3511160-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217090707.3511160-1-cleger@rivosinc.com>
References: <20241217090707.3511160-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add `ext_smdbltrp`in RISCVCPUConfig and implement MSTATUS.MDT behavior.
Also set MDT to 1 at reset according to the specification.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c      |  3 +++
 target/riscv/cpu_bits.h |  1 +
 target/riscv/cpu_cfg.h  |  1 +
 target/riscv/csr.c      | 13 +++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c856a95593..1b883db0cc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1064,6 +1064,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
             env->mstatus_hs = set_field(env->mstatus_hs,
                                         MSTATUS64_UXL, env->misa_mxl);
         }
+        if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 1);
+        }
     }
     env->mcause = 0;
     env->miclaim = MIP_SGEIP;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e1244004b2..e584b6251f 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -566,6 +566,7 @@
 #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
+#define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 7638660651..f12e57d6d4 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -80,6 +80,7 @@ struct RISCVCPUConfig {
     bool ext_sstc;
     bool ext_smcntrpmf;
     bool ext_ssdbltrp;
+    bool ext_smdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index db87fd8726..4fc02b9838 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1649,6 +1649,13 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         }
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((val & MSTATUS_MDT) != 0) {
+            val &= ~MSTATUS_MIE;
+        }
+    }
+
     if (xl != MXL_RV32 || env->debugger) {
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
@@ -1692,6 +1699,12 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
     uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((valh & MSTATUS_MDT) != 0) {
+            mask |= MSTATUS_MIE;
+        }
+    }
     env->mstatus = (env->mstatus & ~mask) | (valh & mask);
 
     return RISCV_EXCP_NONE;
-- 
2.45.2


