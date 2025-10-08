Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF46ACCD185
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 07:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6P2L-0002WD-4G; Wed, 08 Oct 2025 03:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P2K-0002W5-CG
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P2I-0004qj-NO
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso85373075e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759910193; x=1760514993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDPJ9NMkrkMnN+43ENz4d72wyrt5ktAzoMMM2GegBFU=;
 b=uOp3IOvaeAnlLBhNf2uSKvfuOlvr4wzc44aONuQRK0gXwqKuvBFnR8UH0o8o+2/d6e
 ePTGjrJIdgVajkhnFb9h3stCHdxzAPVuJ2J68IjwegLbWJz+Vmw4hwWrffNm7cVluAoN
 a6n9c04pWisLK8Qfom24mn/ga7vJCYxAj8su0ifH9GWFXXbAamhEH7mTim3CHB8jodW1
 UBdvdQ8nxFVcnYegyxftiPe21W3F4ITfhrI5IaMX1q6gDnFdTbE1tr4AtsRGAT/IExqJ
 Mtfy6Zrudg61ox5RJRSbCuCrsGb2K7jt2TAx+dy1dY+CfNREUVe8dwI47Za9UOAMbN9r
 oLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759910193; x=1760514993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDPJ9NMkrkMnN+43ENz4d72wyrt5ktAzoMMM2GegBFU=;
 b=CPyv94Hd6Jz1qTgwJ9qo2qUgZo35m0phEi7Lh7+41+qoj2nIYQHp9WH7m4y7vb2vg+
 0jvLqdf+9vyqYa1Li1tf49GS2zp5KXmqy5mqj12ok5FJAQ1sC3uoROCp8vG5eTs3f6UF
 zn0KaDcOCVVXgdL85GfTiJRb3jQ7MSuobtHxBP0kjxEzGDk/Z1Zlc3mmHNw2k4ZbbYHK
 W9CxcSFlBWoIbqsrcHHReewl5biF7wJhAtv9dq9ofT6jTHFtQpHA2tAKK6BieUkPZPJk
 33wrzgVz/FnqzbJb9++uPnTX8x5wiTajMZgULJV37V134EBqJ9wE6xMFxYJfhNFZkdqI
 mFRA==
X-Gm-Message-State: AOJu0YyWmc39QuS+rEz1alhbgn+JSxUGuq/HDKMSUDSrhb/AJmzwi2hH
 sAGRLaRC/f38KZIVLzWjFghi4khZw9Zm6RPQMpT6+hAe9Fp4NnE8Xep2AbCoXRNAw0erOOHP9nd
 EQx6BfLz6MA==
X-Gm-Gg: ASbGncu9rTPmk4M782M8veUyWra7SEqmDOLt1AYOwW/x8lgLeKzaU3thvkrzZZ9p5an
 2NXtGt5VcZzuAC62bXpaXo6faA5s72tFCFfQKkd/F9EOkUwC5BpqI9+ZDTw+u5HyoCmxCn3m7uG
 OkDcnBpguqCuc2oY9UaiTrszoM4FrJCbk4LVlAmOksZMhKKgdoAmAfWDIhszA1cttDcsePnhgu/
 /5CrBFKp0707Ui8nT+zr0kyY3XHG+DAw9SKMU+ApvKV/HFYkW1IAXyxpeMCeHXOjkms++JBMmVw
 kBFsD5/kczMLahfX0tviMSrNNqXz49EsCVbBd2fMuOAu4o4uVfSow97D2Q/JWwtMJswZNTa6tNS
 ur2yEXf5P/3ZW9DvKR08BDrdizIrBI83iuYe0aY0Ifh1wx+/kw2Jii2dJIkxb9PnE72fCH+r8/g
 cFbTaUQ/1ffvCWXgvn03fjwVUR
X-Google-Smtp-Source: AGHT+IH02xtMykIHrW+26wyLUtNTNlJcBbCdK9T3u96OJ93OXKsp9BQP3ifBAFQWJHf4J5VSvwXBVw==
X-Received: by 2002:a05:600c:6285:b0:46d:996b:828c with SMTP id
 5b1f17b1804b1-46fa9aa1cfbmr19992795e9.10.1759910192846; 
 Wed, 08 Oct 2025 00:56:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9bf953esm26123095e9.1.2025.10.08.00.56.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Oct 2025 00:56:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] target/openrisc: Remove target_ulong use in
 raise_mmu_exception()
Date: Wed,  8 Oct 2025 09:56:08 +0200
Message-ID: <20251008075612.94193-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008075612.94193-1-philmd@linaro.org>
References: <20251008075612.94193-1-philmd@linaro.org>
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

TCGCPUOps::tlb_fill() handler provides a vaddr type (since commit
7510454e3e7 "cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/mmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index acea50c41eb..6fb3f6318a1 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -28,15 +28,14 @@
 #include "qemu/host-utils.h"
 #include "hw/loader.h"
 
-static inline void get_phys_nommu(hwaddr *phys_addr, int *prot,
-                                  target_ulong address)
+static inline void get_phys_nommu(hwaddr *phys_addr, int *prot, vaddr address)
 {
     *phys_addr = address;
     *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
 }
 
 static int get_phys_mmu(OpenRISCCPU *cpu, hwaddr *phys_addr, int *prot,
-                        target_ulong addr, int need, bool super)
+                        vaddr addr, int need, bool super)
 {
     int idx = (addr >> TARGET_PAGE_BITS) & TLB_MASK;
     uint32_t imr = cpu->env.tlb.itlb[idx].mr;
@@ -95,7 +94,7 @@ static int get_phys_mmu(OpenRISCCPU *cpu, hwaddr *phys_addr, int *prot,
     }
 }
 
-static void raise_mmu_exception(OpenRISCCPU *cpu, target_ulong address,
+static void raise_mmu_exception(OpenRISCCPU *cpu, vaddr address,
                                 int exception)
 {
     CPUState *cs = CPU(cpu);
-- 
2.51.0


