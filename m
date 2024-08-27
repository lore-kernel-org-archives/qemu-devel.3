Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2491C54743
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5TG-0003Lp-To; Tue, 27 Aug 2024 19:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5T3-0002Xz-1D
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:17 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5Sz-0000pQ-ML
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2020e83eca1so58261155ad.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800752; x=1725405552;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKicxsSUoIM+Q8CHwfOLtvkXELhMGHcyX8ahibvlzBY=;
 b=jHTh+ilkAqpg7OCZ9Uf3C5Z2fdHnjwYPlS1gWVbI4hpFjJDB8x7PeqVnTOtOWck6G0
 BdAV8CyPtu6JTVp89g+oP7FALly56PnvTJZ7SiCYJ1EQYYmj6oQeot419NNpE+Ij1MX/
 ZoU246oNU45mUKbmpcCZJXwpY69rJKUCPcDETxXYoJwq59QRyv9cytW87w28CDHqsNWX
 trCqjdBFZDDc8c8vaMu2mDnaxq+UuVMQLc+gJsmyTIYWY4SqiAH1LiRtJQgNP8MQufK4
 SJRhj02+EZ2zLjpY0SGPvAAXksZseSIB0tkoQdyFERBUEVEe7iEM0RDU3AlcKSHGgZZf
 AADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800752; x=1725405552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wKicxsSUoIM+Q8CHwfOLtvkXELhMGHcyX8ahibvlzBY=;
 b=Kwbz6KTSVfZpr1YqMWeKroahGTO3RNJgHygLCRF/xwvsnea1zg/i2Bc8n1y8hfBuBw
 z8YeSI4a87BzLQIHKRNzmMl5UHdxt5Jf1N9QIKcbkG9JANN3z5udOPZUjQs1ncQfUteq
 k4njTjm2re9KLxdRbMWAfOVa8KU1CdDCE90B7nySnBYhY0Rb/bUI1ITMJqVkw0Exac/h
 gxO1ZeLPDpkMQMTMV7noF8Drczv9akiHgq4qj7RJdVel2kDpm2qquZi7pophRJ2yg61l
 z3LBSA2Y12t0s2ylmyiERv0cLZIZL/ppoDBoxwKIT2rT/a/own/j5brBrZsuaxej2idi
 UoUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWscLKjrZQ9HKiNfuFabMWHWnSpYXXnaCPqM9P59P5f6Y2wD0bITuvVBM2VST9tfZ5PLEb67jmaJMXb@nongnu.org
X-Gm-Message-State: AOJu0YxtOMSagx6tVhBq9CTZKaLx2a7Zih8s/o/DBh1m9VmnS35Uha92
 lBXGMecSqrSYW40ejTvHmpAZIE8I3BUFNKTLJfUuxIirAtU9iPUe6BuaYIkVI1s=
X-Google-Smtp-Source: AGHT+IGoSmGtqr0bomgMNgtLvy1Ru6xPoeXR3NDWuR5yaozgIOyu7/y1XFZ2wQ7HtXFitcLL8xPsLA==
X-Received: by 2002:a17:903:230b:b0:200:aa31:dc8d with SMTP id
 d9443c01a7336-2039e52cb0fmr163637595ad.63.1724800752148; 
 Tue, 27 Aug 2024 16:19:12 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0ee6179sm57785155ad.92.2024.08.27.16.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:19:11 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v10 01/21] target/riscv: expose *envcfg csr and priv to
 qemu-user as well
Date: Tue, 27 Aug 2024 16:18:45 -0700
Message-ID: <20240827231906.553327-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Execution environment config CSR controlling user env and current
privilege state shouldn't be limited to qemu-system only. *envcfg
CSRs control enabling of features in next lesser mode. In some cases
bits *envcfg CSR can be lit up by kernel as part of kernel policy or
software (user app) can choose to opt-in by issuing a system call
(e.g. prctl). In case of qemu-user, it should be no different because
qemu is providing underlying execution environment facility and thus
either should provide some default value in *envcfg CSRs or react to
system calls (prctls) initiated from application.

`henvcfg` has been left for qemu-system only because it is not expected
that someone will use qemu-user where application is expected to have
hypervisor underneath which is controlling its execution environment. If
such a need arises then `henvcfg` could be exposed as well.

Relevant discussion:
https://lore.kernel.org/all/CAKmqyKOTVWPFep2msTQVdUmJErkH+bqCcKEQ4hAnyDFPdWKe0Q@mail.gmail.com/

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 87742047ce..270a2a031c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -226,8 +226,12 @@ struct CPUArchState {
     uint32_t elf_flags;
 #endif
 
-#ifndef CONFIG_USER_ONLY
     target_ulong priv;
+    /* CSRs for execution environment configuration */
+    uint64_t menvcfg;
+    target_ulong senvcfg;
+
+#ifndef CONFIG_USER_ONLY
     /* This contains QEMU specific information about the virt state. */
     bool virt_enabled;
     target_ulong geilen;
@@ -429,12 +433,9 @@ struct CPUArchState {
     target_ulong upmmask;
     target_ulong upmbase;
 
-    /* CSRs for execution environment configuration */
-    uint64_t menvcfg;
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
     uint64_t sstateen[SMSTATEEN_MAX_COUNT];
-    target_ulong senvcfg;
     uint64_t henvcfg;
 #endif
     target_ulong cur_pmmask;
-- 
2.44.0


