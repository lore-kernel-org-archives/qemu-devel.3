Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FADDD65C60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 09:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVw0-0000Ov-Qh; Thu, 14 Nov 2024 04:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvI-0008Jx-Rr
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:57 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvE-0007hU-KQ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:55 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431481433bdso3421735e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 01:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731575630; x=1732180430;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WxMvHkEFShTB/KP6SbLDpruZLu+ZNC+8yWnih7w6xQ=;
 b=k21UX+FMQLeeXO/IYEF7pbgcSckAkUiM0IWCPeYO2MrGlzwRiuQ9bgCLWor3yAn1La
 M6g5k2rywzo1iuDmTFs9O0jD6cXGWk9X75P3Fzb7tMgQQQxsy7bMeCZCNdH6Yc1CwwNI
 P+xRQHToZ3QVq3lrekPnAmPIyfWMWVf4ktMpZ0CZPnxusyqkkvKhnd2JRKjIH5i6DZrs
 9SBInX7DaMqsOIuL3nkf98behTr6iwtz2/nMExkGQ1XfeV95WaRqmlSusfHb5oEp3HAH
 p3XNJtgpfcwTsXsAPWKtUl3N6eoQfHpFBv0TWEUA4+ZzIUa/2QvODmS7ei7o9jxH6Q0t
 BxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731575630; x=1732180430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WxMvHkEFShTB/KP6SbLDpruZLu+ZNC+8yWnih7w6xQ=;
 b=HCpdBNHCfOSLdDlDgCqclNIw/XFzlWDKpGSRXbH/8RCpuP7/wdcJMcTgAok4zq7H+d
 QgjOvuzMicEdjUcs9wr+aouOe/uTWbu7N8346trzyrrb6fo/d+sGGxax6y9EAz1WWeMq
 boblaThqfUJdM/qjCd+6Gw523g2YDZ9ZwmRLENfQbhqsnyN6DlljTYXvj0OkDsU/dSUR
 J3G9a9yx6edNjBfoIG8jSRt0WtP+bC6x3eimqdOhUBwvh9l9EEo1Jl3ML17ZQfM5P4FF
 b0a+blRFkmme1EyyC+LfmLJ3HRXHHyHXVzddEqF6bthwsQw+7Uo22Bj0GFec8KGj1rUD
 PnAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYzt/hzsuLao1Nw2CRNrdaqFayP8nX0mE3hctLTzRzHC7jc550n6PlsiX0Hwl+01Or2Ib1lzRCLKhw@nongnu.org
X-Gm-Message-State: AOJu0YwAZSJ9eJGbEfxIzfVb58wmQ6mvQFOaVmWpIfsdS7bafNGAA94j
 nHwu/OWIoOAODyAvwOUn7AqJb2dmweVC6TUEulTJ9oymO7FB7tbursMet1PVEYA=
X-Google-Smtp-Source: AGHT+IG8EGC9kzhwVnju/Dw0QWh3j2+EFMCeXpE1qe0U8y1wqdn7A4TAutIRujqEZdoNC1uyzUPf2A==
X-Received: by 2002:a05:6000:42c2:b0:382:1478:1a04 with SMTP id
 ffacd0b85a97d-38214781a12mr1468626f8f.35.1731575630322; 
 Thu, 14 Nov 2024 01:13:50 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae313e3sm899050f8f.94.2024.11.14.01.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 01:13:49 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 6/9] target/riscv: Add Smdbltrp CSRs handling
Date: Thu, 14 Nov 2024 10:13:27 +0100
Message-ID: <20241114091332.108811-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114091332.108811-1-cleger@rivosinc.com>
References: <20241114091332.108811-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x331.google.com
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
index 39555364bf..15b21e4f7d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -959,6 +959,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
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
index 0d0f253fcb..b368e27ca0 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -561,6 +561,7 @@
 #define MSTATUS_SDT         0x01000000
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
+#define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 518102d748..8ac1e7fce3 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -78,6 +78,7 @@ struct RISCVCPUConfig {
     bool ext_sstc;
     bool ext_smcntrpmf;
     bool ext_ssdbltrp;
+    bool ext_smdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 054418ff54..1ac5731d32 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1616,6 +1616,13 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
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
@@ -1654,6 +1661,12 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
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


