Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B76CEACC9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK05J-0001BI-M0; Fri, 14 Nov 2025 15:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK02H-0006mf-Fw
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:04:46 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK02E-0004kX-Uz
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:04:45 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso25428485e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763150681; x=1763755481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvdpQqu+6tXXSi2BeJVnKSBoAv9PMGvcr8JslOxrI6M=;
 b=KiU904us8oftspXA1TTMuy/gWi46WZ1tqQL5Prex/xC4QMT4hPrRX9O4AIxDXoNftd
 pbqVb9THp0EuYTqKYaAngJCPKDv+dB6U2e7I/fmjW6FcCYDAYsLEEcNFhzZwTsD8q4fE
 KKWAX8fjUtRbucGWayJVJGEbqAR2UljwtdDUcN+7rChSVYmBmpgzeCzR6tnQciF8ZGnr
 ApbEMH0vXztrdnzTi5OTnKVTYcZCErgu7qjQudSNvzTF3QXpo1AkWIaccnp58t3Kl5JB
 sE5m8Zn/r4Kkk9eHgSp8JQKQNAb4VvYvOQILFLP45IKP4BC9A2E4KhfGLgiP3K2Sjjid
 Koig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763150681; x=1763755481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rvdpQqu+6tXXSi2BeJVnKSBoAv9PMGvcr8JslOxrI6M=;
 b=XgbM1wGBkj2G5TngF55q2xJNpXaMzYqMeYOftM3Fpk5ksDqfo492LFLV6bPjxspprt
 whOu5BDOCD7p28TliysiZC46WKxEFE3tlxXBn2zxJttjeDOAZp56PM+Ftgqco9tQNCTX
 z1bV51o2frluvPumJZ0WOYeCy/TtDE82JEmqX6KM4UCbzx8q3okwbwX6S2kkWxhUpF+s
 d2QqyKJwj2nsTTKnN7VgzkalqZ6DOI4pAzDXY5ZW16+OUYHJw+EFKUCaYPYJtysifCZj
 1PaTTAt98XZoA8GY9Pp6SaRUSuuyyTuEV4EsLXhEIGu0gfWcrxEJbn7sYoylc/fvawVh
 9l1w==
X-Gm-Message-State: AOJu0YwZLZAijLcnuIrg0aCkd1mmjj97eQDdF7jXH+FM4Yyi2M9483CT
 sq5FC0hwMB06mN/IQvtxUB3k0bwATs3YKm9bUSqzXIlSRHu1Upxj+6sgrkuQb8QgIS8eHa9BmmU
 ObSImH6dhXA==
X-Gm-Gg: ASbGncuhZVxU4NIjXYwjcClf0tuzDRyXqyau+nG4qTApS6s/VNhyKQ4ce3+W0KmQH+5
 AI/k4eBcHeuvsnuZMAbXkHQ/Dau/v9lopDikqAJqkc23GDUoroL9wpXhwmm+p5z9ynOzD6OXYTE
 A8L3ho/pVTcEiwjs1qg2HtiT397ZlNxxAjHXTn0xsaAm5w79Wp+cPGSpfyiBguuCEliA2JKRvyp
 hB48hmGzU4B2vH++7xjhgFALPFfa2ORXUWd+Y/DzxbrXhBZihkS7uKloo5BmDeaXXaZezrHk3a/
 XiNYvS2eVzKtwC6D0bSTdQxG3J5g0te1WgwAUBmtBXimgThb+kNuX8wKjIE2BPkeuF7yPvvw9/S
 UxgeR7bAdfZXth1QcHFIQZWgZiBurw+OmjbXpC8Em/PYJq4KqdDmpDXVnqfTqImFS/BC63JFJkp
 +hq9p478KIBFrzRJKSmULzq8Aj+E9ffwDyq3K5wVgZGw+5ZwcDnQ==
X-Google-Smtp-Source: AGHT+IHTprch3yTnnz5rhGFgAVG2lRMB+7nzu9YU92Wc1HgHwxaGUWze/hAC3poy65AAfi6+3zy4Xg==
X-Received: by 2002:a05:600c:1f92:b0:477:73cc:82c3 with SMTP id
 5b1f17b1804b1-4778fe9b3c4mr41368145e9.26.1763150680804; 
 Fri, 14 Nov 2025 12:04:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bb30e3asm54161735e9.1.2025.11.14.12.04.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Nov 2025 12:04:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 02/19] target/i386/hvf: Use host page alignment in
 ept_emulation_fault()
Date: Fri, 14 Nov 2025 21:04:04 +0100
Message-ID: <20251114200422.4280-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114200422.4280-1-philmd@linaro.org>
References: <20251114200422.4280-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

While on x86 the host page size is fixed to 4KB, it is
better to call qemu_real_host_page_size() for consistency.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hvf/hvf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 16febbac48f..9a1bf026a4a 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -76,7 +76,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/accel.h"
 #include "target/i386/cpu.h"
-#include "exec/target_page.h"
+#include "exec/cpu-common.h"
 
 static Error *invtsc_mig_blocker;
 
@@ -137,9 +137,12 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
 
     if (write && slot) {
         if (slot->flags & HVF_SLOT_LOG) {
-            uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
+            uintptr_t page_size = qemu_real_host_page_size();
+            intptr_t page_mask = -(intptr_t)page_size;
+            uint64_t dirty_page_start = gpa & page_mask;
+
             memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
+            hv_vm_protect(dirty_page_start, page_size,
                           HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
         }
     }
-- 
2.51.0


