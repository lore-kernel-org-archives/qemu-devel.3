Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FD8C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQzo-0001BG-Bs; Mon, 10 Feb 2025 05:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thQzl-00018A-Rq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:26:29 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thQzk-0001ka-2J
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:26:29 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4368a293339so46694305e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739183186; x=1739787986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZ1fgmbr6UR57aQyXOIyNIPPA+qrJvYb0dDxQG0PMFQ=;
 b=YOj/gxdeCTgggDrSyojcYwPe1bwC9uehCGvIslLKMeXzeefyIcBOOZDWVcdsfW2NCR
 W0LH15UgADyzWYXJ7gCV4wEVjefq3DI3p6lcRRP9a1J/srP3HfdojoDnM0djzFLsmHV4
 HmkupWavTp448uxAMyHRUZ0Ln4ib5SoAf42vDx+7T8X4hAfdyGmowxf4/tW9iLnBdjjW
 hJLjKgWWq7Su90gI48aDMjEuXQ6jxJ+ySdXPzbIkONYgbeVkzLEqF1pLPxWOqVmT3CvP
 4D2LmgGKiqe48HwBW3+c3gm0C/tNwbtYOgcWiBiUILi0v30k2xTrsVHpWSsECjgS0Wza
 yvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739183186; x=1739787986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZ1fgmbr6UR57aQyXOIyNIPPA+qrJvYb0dDxQG0PMFQ=;
 b=JugH3JdkJjFqC+a4+LfYS0zomJbS/OIc8DeQ8+eQLh0GCJtQFgNvbG3ls8PMKNkDbE
 DMBUKiKJ6EEi2xbo8Gq3tqmxUt2vwQv9gEKjvzA5rgPhv3ln/q9mrDm2YTPxkHZko51o
 P2+OobYnh+Oid0+slIwbj9X1G4HUBxh2uHiCKo6GGcW82yZxrG2hI6FNQjybKGVZKBLw
 Z0OdxXme2OOeydMCMGsg/tpcjNnuqRFe6gYHcgQqnnB+qzLAE5LBIDIWcO+OGg11FL0d
 SK4oVnu++kDWi7Rd1x6XnMbwMy9Vz1YDOd/1AGxGQ5relA1DLT6PI9eryVx6+AKPqmD/
 0xJQ==
X-Gm-Message-State: AOJu0YwQcNOE3BEfrE95gUlsSGhX0VXEj/JBOr438kuRb0Za4G9zS0FK
 8Xu/Bluo93ta/DuTGaHDpgZhHKDRMqXRiB//LVuJh/RzfmXDu2pS3JossMRC3EoqrVsD/VEruYU
 rNok=
X-Gm-Gg: ASbGncurn0BPyhCAPDuQWIKa+ZI6HP2XI5Z0/ZfEp3+2At7ctON/hcQB635SOgY2oTQ
 zsslpIjUUu7f6Nwf3B5AgbLD3KlhC2ICmqkni2xct3KRe5xziUSgIzEEntHIbbKCghRWYz8e6o7
 Obb/oiQHRr/DtCkCXzZS5I5Q3VWIO5KlMvW5N8aIpcW5igQBI03Mm9nii6v5jwB2urvhoTeohDa
 Sf+REgzfwbaUzRSy133/oLVtyIs3K+4qYtHi6poB/YPW00xr06hkgh4+ifp8YjHYifbWXKcCINv
 EMCtYMBWq8STSvZ3p3au6l2UBA8KferlVneUileU3uTMLgoXMc/hjdYmK/lDQ6IQrngzOp4=
X-Google-Smtp-Source: AGHT+IF8YzpKZLGjHS4ok2TrSBGEWx7W1lWRfYmFewnlMdq+Cw/FaTKqr2s0y+9c5O5oeC7ftG+FnQ==
X-Received: by 2002:a05:600c:502b:b0:439:3d0e:f10e with SMTP id
 5b1f17b1804b1-4393d0ef265mr37718925e9.28.1739183185839; 
 Mon, 10 Feb 2025 02:26:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf7dbcsm178043805e9.30.2025.02.10.02.26.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 02:26:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org
Subject: [PATCH 04/10] target/riscv: Declare RISCVCPUClass::misa_mxl_max as
 RISCVMXL
Date: Mon, 10 Feb 2025 11:25:58 +0100
Message-ID: <20250210102604.34284-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210102604.34284-1-philmd@linaro.org>
References: <20250210102604.34284-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: qemu-riscv@nongnu.org
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


