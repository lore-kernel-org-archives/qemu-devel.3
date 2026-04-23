Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FD6FDEE2B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxTi-00028A-Uv; Thu, 23 Apr 2026 13:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSt-0001Dx-6p
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSo-0005fk-To
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso42239765e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963821; x=1777568621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLkHfU6gnGPNuMZLmMU3QVfExHc0Hln8v5Rj1pdI6b4=;
 b=YADR1bWN1GJeDhY8UzbsTdhSEo3TXY2YQCRYgWe+mS9TXKsz7hIKbiG5/XSSBShJ7U
 Xhhl9eX3cy3L0ey0/0VrSPFfHFRY/CJ3xxOWGfLIc4MXRNDS3ZC4i/ZUzsdGgveuYwmD
 9Z3Zop/H4ZtPRRZ3eGrdsLsnHFWKHmO5Nwhf3Nv6nuCrctCkB+FgRhOQdXNnJ1RtJhue
 WLlHFQ7QYlRTwcBonlZ5g9XP2sxVV2WiLPug5hoaRxtCoods/mHWMYSgvy2w6gnPsxbP
 kU6nY8ayD7+vcM63ArsB32j7nuQgNOLnMOZQlWWaoBTSIr9Yc3o1WPv3cp42pgH75zq7
 g6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963821; x=1777568621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PLkHfU6gnGPNuMZLmMU3QVfExHc0Hln8v5Rj1pdI6b4=;
 b=AchJo6BB2EeN+Rer+2pCzggNXXw2rg5UaY0KHRQUgVAOZhMTGCyWlPmcKhVUGTqlXt
 umL8SoPpSfPHxE0oTgQGuultxiouUD/V4i4kntq2VyyG0cnMsGQkPw+wFZEuWA3Lt2Tw
 jtylQNqu7RaRDHVruxtkJcbQzOY3t5B+IM0nlsC9tTCv1Tbte2JkJv16M2nDCaEUcBXf
 rtAeC9/t4x4m01iELo+/RuEfXshk+tbh1YLXkmYku2C5SY8ylFpN6QNVWdqTX9BQIGmU
 HWd2VjxbNmCZzulZozmguGcZeNTUfpsjbz6OssCa7R/iK6RJwHABPgZOSlurcJur6TA+
 wGBA==
X-Gm-Message-State: AOJu0YwHcS2m6ykG6D6MFirGUW7lM7z/Jrk6nvyqI+ZaQb3TjRwJMrgo
 1gEwQNZP6E8Inm2xqDbKFZRS9kCSSFtvuHE+fK7LgT3Pg1RbZs1hsZPNXKRng0YGIRlEzJ/0BhH
 EkZjB/NU=
X-Gm-Gg: AeBDiesjetGFA4GTe/YaYZ8lZ8JRRFMZgWDsFDO5h5mN92Pi2wi59RyaG0YyNaRW98P
 rGb5gMeJ1O5DnbiLaUYtBYSVgpBk4dmbI3AFk68BViTvjSI4zbltr0D294os4qxsUVacdinFk+4
 wHONaI/vnD8gntgxgd7j7Rcy3F0pw/Ihz/j5X8+50dwYk2ypJBwKHGK7R07mjIJDSf3RVGUArb+
 JJb48eP3qNfoowF7iRXSLAB+jrE66AuxO1MEUEQChTyn4pp2FCil4U38wAa9IeE2HAjSYnPeJzR
 uyXB1vPlJ70DvdpJDSHbH4ieDFOx5Xy9qJ2825JbjFs+6nIoM/ruLtFPSu+o6rgHjqC6EDyJAM3
 9JU3e74EwT+CZgxX0doDdOZsfBujo4CB3g41da0tKc016js3kmM16QB/hq7bn22hDpFhgrP1zqL
 JS0dkAB+6LmWfgYJhK0uq7lLpwDyrmalO4WeN8fCf+Gpap8xYhp1/Zl5ri/2bEk0jmsI13zzaDk
 rBAdvtF7fI=
X-Received: by 2002:a05:600c:a404:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-488fb73b2a3mr333100145e9.5.1776963820706; 
 Thu, 23 Apr 2026 10:03:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412150a071sm19367663f8f.21.2026.04.23.10.03.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:03:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 "Scott J. Goldman" <scottjgo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 09/16] accel/hvf: avoid executable mappings for RAM-device
 memory
Date: Thu, 23 Apr 2026 19:02:21 +0200
Message-ID: <20260423170229.64655-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
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

From: "Scott J. Goldman" <scottjgo@gmail.com>

On macOS, HVF can panic the host kernel if a guest accesses device-backed
memory through an executable mapping. Leave RAM-device/MMIO regions
mapped read/write only and keep EXEC for ordinary guest RAM.

This works around the immediate crash seen with passthrough BAR
mappings. There are still platform-specific performance issues with
guest write-combining mappings, but uncached mappings behave much more
like the host-side mapping and this at least avoids the panic.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260405072857.66484-3-scottjgo@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 82cb3717750..0b431fab72a 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -116,7 +116,15 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
         return;
     }
 
-    flags = HV_MEMORY_READ | HV_MEMORY_EXEC | (writable ? HV_MEMORY_WRITE : 0);
+    flags = HV_MEMORY_READ | (writable ? HV_MEMORY_WRITE : 0);
+    /*
+     * Leave RAM-device/MMIO mappings RW-only: on macOS, accessing them through
+     * executable HVF mappings can panic the host kernel. Ordinary guest RAM
+     * still needs EXEC.
+     */
+    if (!memory_region_is_ram_device(area)) {
+        flags |= HV_MEMORY_EXEC;
+    }
     mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
 
     trace_hvf_vm_map(gpa, size, mem, flags,
-- 
2.53.0


