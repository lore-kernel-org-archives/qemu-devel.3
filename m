Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2592D106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vtd-0000hb-FH; Fri, 13 Mar 2026 02:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vta-0000h9-Ng
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:14 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vtZ-0006sL-6O
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439bc14dcf4so2148810f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382871; x=1773987671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTAi1FenfZMeGsCLz6pitX6jAfUO4AK+im1zqFEeNiE=;
 b=gAV7hdChzts2GLJ01RIvUhyS+Ll9V2tAfjOLDI2qdg9D23mO6DD+h0f31fzfxHKo7n
 CaOyV6GKGEytKWldFmVpnM/nZzcqmywbQQHSvLttB17NSIdp3KUOFwKJmatKpaamARnN
 VzRl1mvqv6v4b/cQpu5Ai42btntD1OPjGCE2+Ni9HnZo4yWtEcu1pK6bxtmcNntF4ndW
 kDzMw+WSecY8Q3JCoXt9P/8fGpF8LMMh2dv7boc1VHC9z4ypJfoUaHmdKhlhNlEqWjZ4
 NEIpyYT2JM1SUBS+uVka9OLErmjApkVF6nPFhtSvP2ssPouQlNGELJyL1joBITstRG0O
 lDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382871; x=1773987671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OTAi1FenfZMeGsCLz6pitX6jAfUO4AK+im1zqFEeNiE=;
 b=I/BxLEUcASbK8gLS5x5Xa9Fzm8G28RpTj5ibGIMXuG2Oy9A4LA19GAgNS1ilz3aT87
 Nj/AK/+RmSd4R4TaMd28C44j5tUE21zyK6GNw0IX8fC46Epsce6PzeMrDaVv4VDyYJ2X
 BY6BxabzTU+WcBF3UoepxKwm8nDFNOW7N0pA/v7vjVZxjwaEN56kOSjmvRfUMvdd200I
 0UGiEl78owbllNGn7mUL/twmLW/9cZJZ1/Eo+Cf7YurRes8si09tflUCgd8SSJ28cwwA
 OwFtwV/EShDeRbr3IV+BSiKthT7+71rpfs4hxbIUefBSF3LtzyS9YoXrnSP6Aalecfn4
 5acg==
X-Gm-Message-State: AOJu0YzQgqdoDcDHxjfB+B8y+28lZ4agYMBb1AtVwxTT2Adr/Z9WSIBG
 KdPUmHObsu17+HqZkcKpD6Cyy/l2FlgXMo1t4/C2AxefJrL3WDsKym8Pw9OrCGbSM5m0uCYcO3P
 bX8ezcvg=
X-Gm-Gg: ATEYQzxpmftQpKmhGmllKEkJPuubDzGzS7vXzaWUVKrcPKz1N2pFp2I4v1S+7SK3h/S
 FZ1bswqu+RhDyeTqvUht+eFpOOzBN0auUOyNhsvLikdbST3jOck6ltIg6VqaWL2umK+xUyUuVLN
 kXsiLGhWVYjCq/4zjrKeN9CaQOU9MtTrrvVOKRcsJ9ezGLACXvKPIWhVG/uKb6A0fQdHQlvIiE4
 JiIhKTnqsJahP50ejAWJVBeM+M2WoiRH5vt5+iChYJ92EDZPMZJtiTmBf3fuFKEMdU7i2Q2/uCp
 RC2bHupQSolwJYBwmwPSwXvKniVPZOyXpRmN8miLSQ0VLaw7JpAVuzM6T78RdwwqOU3EYGfxYhy
 ZpcWwtwPtJaasWBLE+wLaiilYaQEhu8O0aA1bytvLe9cedGt4sp2YV37nv5oTI587ZJGtCWGLIs
 4+mHO1DS6ujd+gXfhqdQJy5B9hBvDqZiXddl3z5jQ+QMZxBLtGCw2qadhRIyBSR4aETD3pmHmBj
 gzvCw==
X-Received: by 2002:a05:6000:200d:b0:436:3761:583b with SMTP id
 ffacd0b85a97d-439fe1ae114mr11181066f8f.27.1773382871379; 
 Thu, 12 Mar 2026 23:21:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20b544sm15695195f8f.20.2026.03.12.23.21.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:21:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 02/38] target/ppc: Replace TARGET_PAGE_BITS ->
 qemu_target_page_bits()
Date: Fri, 13 Mar 2026 07:20:18 +0100
Message-ID: <20260313062055.2188-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Get the target page bits at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mmu-booke.c   | 3 ++-
 target/ppc/mmu-hash64.c  | 3 ++-
 target/ppc/mmu-radix64.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu-booke.c b/target/ppc/mmu-booke.c
index 55e5dd7c6b0..9cc66c613b7 100644
--- a/target/ppc/mmu-booke.c
+++ b/target/ppc/mmu-booke.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "exec/log.h"
 #include "cpu.h"
 #include "internal.h"
@@ -492,7 +493,7 @@ bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     if (ret == 0) {
         *raddrp = raddr;
         *protp = prot;
-        *psizep = TARGET_PAGE_BITS;
+        *psizep = qemu_target_page_bits();
         return true;
     } else if (!guest_visible) {
         return false;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index d026abadd11..2c33d98001d 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -21,6 +21,7 @@
 #include "qemu/units.h"
 #include "cpu.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "system/hw_accel.h"
@@ -1065,7 +1066,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 
         *raddrp = raddr;
         *protp = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        *psizep = TARGET_PAGE_BITS;
+        *psizep = qemu_target_page_bits();
         return true;
     }
 
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 33ac3412901..a09ba2b8d1a 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/memory.h"
@@ -717,7 +718,7 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, vaddr eaddr,
            }
         }
         *protp = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        *psizep = TARGET_PAGE_BITS;
+        *psizep = qemu_target_page_bits();
         return true;
     }
 
-- 
2.53.0


