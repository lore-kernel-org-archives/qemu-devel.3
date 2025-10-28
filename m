Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F5DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcqg-00066B-8m; Tue, 28 Oct 2025 02:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcqc-00064v-Tg
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:06:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcqY-00063h-6H
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:06:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4770c34ca8eso19389795e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631575; x=1762236375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00VoYdC8InBsegxgwoexYjYht16HaFBR+CXcPMHb2Dg=;
 b=z2KFfQiOam4XtzZqW9316dSt6oBV9/R20QEhEaq0ZJavEAv4eun8owDXxBxq3B1oro
 TQ8H0Kj+4fZNqgfs5nJmiimnrhPfQz3F8bgb19Y3FGIkE0KUx0CtLEvq3X/8D0KPSyM0
 dP61GHfKM0lOHPOHmLR13sUIfHrmwEbRE+RD29OnDgM/E9ofs9ud/lSZhCrJ/dFA20X9
 OH2vCSyRiDmP8GS8USHwW2+1lyvevGXJNqDUTTlswCbj6MPFyhssRVMfds9cER2CFFCV
 2CHboe5vTiznJ95uKqgcX07CwHNhf9DCVRqfdypALB/YVzjkUZ3Innd5FyeKAeGKPiKm
 9B3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631575; x=1762236375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00VoYdC8InBsegxgwoexYjYht16HaFBR+CXcPMHb2Dg=;
 b=nQXKeK4sCxsQ8d5WGjsvRI2f+aLtj9RXJJK4QJQG/oYBmNuyVoKkcxQERI0/WD2qpZ
 JlWuGeci/vfum8m++a/nZIAK10CbrKrhSWN12/CNNfJVo1Cn4cdqzJE1k9bIQySJQtES
 0s4HdDO74hMo/vC+dKTTOFMpRapKKrcTMJSboC6wc/IMWhc7WIe1KhYs48RQxVkJ2+Sf
 MUb2nfMYRXd59ZIx6DSMtkJDEfPPEyBAbAKMcG0Z5QhNLLb339sf1+AVPn7VwqAca9N1
 u394e9V5VOl+NmvsZN1PnCTMkfTgJikvQe5yVMIDdvwPhbeRaZZPZlpmNq8F7tZ++V2U
 kN8A==
X-Gm-Message-State: AOJu0Yw7pSYl0ssiAQs9GZgbNLL/crvnH278Sn7SFUD26bPtlgvwX42M
 USJdUUXwhKewDY7MEFTymhBtII5dMRhAAqPmN2dhCwdJmGI33yfejkjx0aDPDizbXKn8xgqlRk7
 Qs5JPmBg=
X-Gm-Gg: ASbGncv80t0X23l0+KQR/Fr2iKkZcwRFXyLBIeUHiK0qS2AgS7Lp1YbO0EkNxpKOluD
 oReWRtBZoBE+c6QEmWADbyiAVXDAmbrwjr3RfzNcuwFAHdQzb8A+vgUkCw+6oFPGtXV9VySCDd3
 Zk85XJ+tM0L5naMI/wuW7M1tLlXLachpRSNwrb9RaF4FKgOpycZRf3L8JuJd1DXCzLcYdfFVB6U
 1DyVewsMUjUnKf+Qa1T/NTigjuGUCTMGqEhULCmq2QmmLNXk+lCedwYtHaxZM/fEZRtgpFXMY/0
 6ANg5GLAfuj+t6GqhzALqxnyNsyrZpFra+9r9tJQLDexzE3ITwMoVPWa0a5tkRzNv07UyKftAY8
 wSIT8Tp71E3qyWnRXzxZdRHUFyeev5rrPE7Szz9BLT957fezn9Qitc+7FpQ9cg5WR62oT9NowmW
 CypJ3x4o2JJqi78hDeP+kPetCQrFPHhSI7Iy8DKEmBAFZIB8xH3f3G5sw=
X-Google-Smtp-Source: AGHT+IFJkB0BTUKzJ3G9O0QOasNRl83wrQ1f3eP0Qvm5iWg0pZrjqRykw9M69F2Fr0HkNzsz2v+wcA==
X-Received: by 2002:a05:600c:45c5:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-47717df5366mr17887055e9.1.1761631574837; 
 Mon, 27 Oct 2025 23:06:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5678sm18098843f8f.22.2025.10.27.23.06.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:06:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 33/59] target/i386/hvf: Use host page alignment in
 ept_emulation_fault()
Date: Tue, 28 Oct 2025 06:42:09 +0100
Message-ID: <20251028054238.14949-34-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
 target/i386/hvf/hvf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 16febbac48f..c0b2352b988 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -76,7 +76,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/accel.h"
 #include "target/i386/cpu.h"
-#include "exec/target_page.h"
+#include "exec/cpu-common.h"
 
 static Error *invtsc_mig_blocker;
 
@@ -137,9 +137,9 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
 
     if (write && slot) {
         if (slot->flags & HVF_SLOT_LOG) {
-            uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
+            uint64_t dirty_page_start = gpa & qemu_real_host_page_mask();
             memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
+            hv_vm_protect(dirty_page_start, qemu_real_host_page_size(),
                           HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
         }
     }
-- 
2.51.0


