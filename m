Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D109CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2f-0006Ns-7D; Sat, 05 Oct 2024 16:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2c-0006MM-V9
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:15 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2b-0001ll-GV
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:14 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b0b5cdb57so31579105ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158772; x=1728763572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZFSB9ZUy/VXACo96L3HUXARpyVU9ywq9XNxX+p9inM=;
 b=q8PjW6IzI6J5qSFAcwUsV+z/0WbaX+3XpAU/L8uimhuEJ8JoZDc0komF8RnXmxv/Xk
 gdsWO0XLA4dOgS7guvwoADKjZPEo5+JKXtoXqLBAYDAoA0dxj2qjiT76hrIMANPodPSx
 nGA/JiYU80MjLs7nALKLQzGeMJxv84ubIyzvQwYEuxTPk67hXoJ0e0k+xjWIBRxe7JXZ
 lef3upSuj2Id1hmWWVNWH7gaYgIm4L/yRsTNqHn45Hncd4VCz/TOsG4N9S3dYXJG0Bof
 NOsVg+qP9cLzGAAfdXhDBgD2s136NwPosYTBnutUWvVs4IXbO4dtl6yFseE3P0/2AUd0
 fDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158772; x=1728763572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TZFSB9ZUy/VXACo96L3HUXARpyVU9ywq9XNxX+p9inM=;
 b=Znx1GKBWCH7AqDILUT2movPHJQfqlbobJU4yflEQhDcBrEDJYP0TryKz2ohg4KH/Lh
 q2za77MFfB4rQ5H64By6U6A7XccyP3HGlbUSNtfSdfHU4UzRmqeIVGv5gUEj+cZpnacv
 LZsAeNHFP8X5CWJE4HsOSianie4ZOcUiLsqmKsqBkqse3uDfSJjz8p5C0jZqzDWwtPzH
 tc12VvwbiWz3r/haq/ohyzicBJUNHpEFBgS6Dzj/GABrbsPZ5/qfcJYOXIGyWaQ8nvEA
 kEErk7MOGUR1mGEQP+hnuvwnY+C/WrO9ux6X0Y6xUKzVDGjn3KjbLdXws6DX7DAWwLic
 6sJA==
X-Gm-Message-State: AOJu0YwJ3UYMuk7xINITFH81KackfsETI5O657/UoP3DqGJDNQAN4S4n
 5SWSGJ++QFlwan7DXsQgkb3gryx0z0d9UdwDU74TRS76BtemPMVg7bExtw0vR6DOZDhIbm8EDZz
 h
X-Google-Smtp-Source: AGHT+IEnSEOUIrHMqhl+2wC7MJEt2x3LJD6slbQirH4WqyRvisJVw+9UvtZb97XvweZZ36AVIQ0gZA==
X-Received: by 2002:a17:902:ecca:b0:20b:805d:bfe5 with SMTP id
 d9443c01a7336-20be19c0fb0mr135947635ad.30.1728158771892; 
 Sat, 05 Oct 2024 13:06:11 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 11/21] target/hppa: Handle alignment faults in
 hppa_get_physical_address
Date: Sat,  5 Oct 2024 13:05:50 -0700
Message-ID: <20241005200600.493604-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

In Chapter 5, Interruptions, the group 3 exceptions lists
"Unaligned data reference trap" has higher priority than
"Data memory break trap".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f71cedd7a9..d38054da8a 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -221,7 +221,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
             g_assert_not_reached();
         }
         prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        goto egress;
+        goto egress_align;
     }
 
     /* Find a valid tlb entry that matches the virtual address.  */
@@ -323,6 +323,11 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         }
     }
 
+ egress_align:
+    if (addr & ((1u << memop_alignment_bits(mop)) - 1)) {
+        ret = EXCP_UNALIGN;
+    }
+
  egress:
     *pphys = phys;
     *pprot = prot;
-- 
2.43.0


