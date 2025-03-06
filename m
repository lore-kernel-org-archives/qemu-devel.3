Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA843C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVs-00050a-DW; Thu, 06 Mar 2025 10:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVd-0004Y1-Mm
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:41 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVJ-0006lq-MH
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:23 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bc4b16135so5232945e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276280; x=1741881080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MMBWRuSyGswvYNYlsgr7kSCVcGseu6BMoO5K2Fo6R7M=;
 b=Tzlg1UvGkehYDQ8JxM8NFQ0h8013J0mKw7RWby+BlP6eIIGnlPLJZusjyvoyhOyw1K
 MKMkfLzD5b6nWMGIr8FzL08QalHrksBLhW6eoKMmo8/V+mQmCEruIhxoYpQehV49CBTT
 Z90C9v6K6htnlv/B2dnIsaJGAKtqodzWJCFVRWuMfrjNlWEo2a8zmzcRbehdw/h9WSOa
 GF0BjP2UqTu9F5O11Xh32bhcS0YUZGbmfzPhvRpTlEVLyO8dyP01M0z5/AdhjEQfwlqF
 wxe0qyECluNqctYPT9XuYMfGzGv6pqSf2I06VxftzqLnYjyGCk7Ek27FslZZd6oL76yc
 LCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276280; x=1741881080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMBWRuSyGswvYNYlsgr7kSCVcGseu6BMoO5K2Fo6R7M=;
 b=aDj8zeMQ4VlfGaeJYvE8Jm5G/0XlojyYz3kSUHy14tx4rLZ2aa4CsGef7nZ6K7/sI1
 StCGblrN526Z/Ax/Pg65mlFaKPWfGP6c9ZEoGctw6KLnF6zzjeSHZVPEsjmv49QjyGa0
 JtQjd0Nh4/MozqVoe43vEaz3rxEPI6itwy+WeqLGxwDGNkgWceG/9q24JQneN1eJwEBc
 CrFCZMz+t3q91jmJWMmM3PObEBMJVMGD/X/t70t0Ri3E/VJzGWGkuSGYwK32xfHaS53a
 xNIM0zsvmPjwwcHsozYJweq2x+Vsmo9LSizfhhzRceafp7M5gEMAkYReodoziVpCYLXr
 c+jQ==
X-Gm-Message-State: AOJu0YyOeiWUqJTpP384dUBvlDWAtAiwMgBo+neslxkINy4IKCR9T+RQ
 7k8MKrBmHL1xKBzqnHei3K+xRQlw6DT8go/RzjmFlofLTAY+G7ctiMbA++ms02w/qnHNyJGqZZc
 fBW4=
X-Gm-Gg: ASbGnctbzD1JZSXy2al+V22D/cWZtPZ0G+E0OBN+P5jRGdp0y2vK0c2tA1ShEJefD7g
 +FwUyOcxrCQ9RFUWPVh38DmvfYHvGtAbzmgvfqKT3QXD9y4NWJ0Pdr/YYkA35CL8V3Dr0kHD14T
 KmOtPXPWNzuLoAL++ebEJwzocXHv/vOWrNsn7VCpckMzKlvYb5RF3mdOkN7MTX6+JGOA8OCD0Fm
 AKL0I72OZWkpJwbZgpvOgQopcbfQxq9Yt1an6jTWfT7ZO3aawvfVJeyXjWyhSzMQEIqCy65TfX8
 NuNkZGkEmI0NxKzcRSijXbU7KCizH6hVgsAtc+9oXrtMyDdGhYHQX4Ncug27NDbyZSan0aH7LoT
 uBOHc1O+iLtePf1X7zlM=
X-Google-Smtp-Source: AGHT+IGw2gTQleg7DigYl3YSXxike3ld0/4r28imU1bdl08i1jUWfU8qqauNQfNSYvrA6oR+Wj5//Q==
X-Received: by 2002:a05:6000:156d:b0:391:10c5:d1a9 with SMTP id
 ffacd0b85a97d-3911f76e3a4mr8100116f8f.31.1741276279952; 
 Thu, 06 Mar 2025 07:51:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb79adsm2400486f8f.7.2025.03.06.07.51.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:51:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/54] target/riscv: Declare RISCVCPUClass::misa_mxl_max as
 RISCVMXL
Date: Thu,  6 Mar 2025 16:47:31 +0100
Message-ID: <20250306154737.70886-50-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
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
Message-Id: <20250210133134.90879-5-philmd@linaro.org>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 616c3bdc1c2..7de19b41836 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -539,7 +539,7 @@ struct RISCVCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
-    uint32_t misa_mxl_max;  /* max mxl for this cpu */
+    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
 };
 
 static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6da391738f3..d4f01965dfa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3056,7 +3056,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
-    mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+    mcc->misa_mxl_max = (RISCVMXL)(uintptr_t)data;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
-- 
2.47.1


