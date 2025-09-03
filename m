Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2949CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkR5-0004zg-2O; Wed, 03 Sep 2025 06:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkR2-0004iP-TR
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkR1-0008TV-4N
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45cb5e1adf7so4372445e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894185; x=1757498985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgrvAPRPeMpRVzKH2lCQLrXhLFRC0uspct1gvGRvd5o=;
 b=adLAPqUGBweiWFPbxy0KrtGhUNoAUE9EnJ2CsOR/GiaaY9tjtx7NzIoHovBuey5JQA
 HOnsTjp3AfQhFI5wPrzHYWrYS6MS5qr6mbxRK+mjv3OKktVztdDRzaJH12u3vR8sT9xL
 r7U48jykutpf/OtOitSv4MrqfSZmqex44QPOtbW/uCbNQ3G2gxv5zU63yqjoySv4DQJ5
 opJ6/uhI5niQqd3v8OOnR5lLgAMyS008tKtw+c1BK8GwNYhrUw+JjoQpTWrrirT7ahW3
 D56RcvgSlcDyLzJXsZE58xAuL4y4bFpDQWSGhkHSnBB9tb7x/Z2fhFxkNhBtvdG6Y0FM
 P3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894185; x=1757498985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgrvAPRPeMpRVzKH2lCQLrXhLFRC0uspct1gvGRvd5o=;
 b=HebsZMcZJeJdVR7IH/U4l9XFTwLXZe7viowAfJwu66wPmxBNlLq+EJaC5ybmVqI75E
 5hUJa0JbrbY6o2ggd7XGRmtl88JLm73FR2SSyFtGQht94cvZKNudHSWBtooMcNITj/OG
 YrTj92Hl1t1nfnjRfLR5O0y82HNOFvtR35xawIi4dPYxFbpurmcSS1e6/S09UaI0htZp
 xk7aGJnJccqQarLL9go9PJvVLqIxe8WKVJvxPiophcUpUhD5Eum0+gA6PuE1SH0J76LS
 nfFfpDjewGR50OjD2a8DcopvGZ9zHi/LCTVxuODZ3v0nnRz4aBhpmbVW97pzzNhMmizm
 tH7Q==
X-Gm-Message-State: AOJu0YyCzaSsoEwCHHeyVlNP6poAluJUxUL0RlPKebn3biVfHwOhPay1
 uIRk3ad2CA2M73AcEc6p1BXe9AsmsPzYxnm6r2rkWJbwV5N5IbeJusvGI/2r6MemfFqzB09JgMp
 l1EfBS86hEQ==
X-Gm-Gg: ASbGncvTXAL92wYitZqfFdqqcVS8Z4vg/7Yf727emRE9Zy9PLacQ+ICrd3UzoTeU3Zx
 tRfpjKgl3fYuhil3loSGsB0F63k+8+E+I1NczUQqfTOCQauLibUXD0csJ3uifr/ln4GDAa0uZ8s
 0/DZgOR/9THDN8d3npUbcG0Mcy/E26Yq43l7j6lLdRwNdSaQM46UkyBj2aUl/O2MmkidhZ5tEQI
 IN0yvT+HNaz63SjGMmsIAJHBSdhTNxeSN21oLKvj2mHFjwot31sLuC7nPdzprMa44KAhIsSdnyH
 Vta56iv09SIWQ86Flv87ZNSDFrXw2owFAjBATw817ZlwtC7lBgXHSCMqIjHvhHfyTlZ+ozuv1Pw
 uc4dMFT3vXoT3zhbPo3oLsIiTZgNdVjzqT7EASx6cBC06Znw3ZTk1EfivA45pLvMj5Iv33ZnhT+
 s73SjP7A==
X-Google-Smtp-Source: AGHT+IGpAYTJvKczYgPz502O2hrnnyGSytgRVzbTcMu5SGbXAQoimSXFtd6+tdyLFjun6Wvu9GpRfg==
X-Received: by 2002:a05:6000:2681:b0:3df:1a8b:ff40 with SMTP id
 ffacd0b85a97d-3df1a8c028amr755192f8f.43.1756894181967; 
 Wed, 03 Sep 2025 03:09:41 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d53fda847dsm13940922f8f.0.2025.09.03.03.09.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:09:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 18/24] target/arm/hvf: Keep calling hv_vcpu_run() in loop
Date: Wed,  3 Sep 2025 12:06:54 +0200
Message-ID: <20250903100702.16726-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0cfe3066c23..b60efdc1769 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2141,30 +2141,32 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     int ret;
     hv_return_t r;
 
-    if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
-        hvf_inject_interrupts(cpu)) {
-        return EXCP_INTERRUPT;
-    }
-
     if (cpu->halted) {
         return EXCP_HLT;
     }
 
-    flush_cpu_state(cpu);
+    do {
+        if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
+            hvf_inject_interrupts(cpu)) {
+            return EXCP_INTERRUPT;
+        }
 
-    bql_unlock();
-    r = hv_vcpu_run(cpu->accel->fd);
-    bql_lock();
-    switch (r) {
-    case HV_SUCCESS:
-        ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
-        break;
-    case HV_ILLEGAL_GUEST_STATE:
-        trace_hvf_illegal_guest_state();
-        /* fall through */
-    default:
-        g_assert_not_reached();
-    }
+        flush_cpu_state(cpu);
+
+        bql_unlock();
+        r = hv_vcpu_run(cpu->accel->fd);
+        bql_lock();
+        switch (r) {
+        case HV_SUCCESS:
+            ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
+            break;
+        case HV_ILLEGAL_GUEST_STATE:
+            trace_hvf_illegal_guest_state();
+            /* fall through */
+        default:
+            g_assert_not_reached();
+        }
+    } while (ret == 0);
 
     return ret;
 }
-- 
2.51.0


