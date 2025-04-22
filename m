Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E44C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F35-00088p-5h; Tue, 22 Apr 2025 10:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2t-0007eZ-RJ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2s-0005GR-5Z
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so39627605e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333780; x=1745938580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cV3mM0ENqcZ01CB1iRk+m5MtZMh95fPFHAPIzsRChqE=;
 b=q5IyOefQx08fA64F7R3y+xuNwcI4Qp77rviYIqkQNEOKZWS3Dq818GZNFqZD9zMXPX
 5SsCkpgilkRc2kdMr77KGoXDekxYEgbJFKCfH52UxtJ+wRuuW1fSE2KYYj4n6bwrnjbi
 bz/hJRHxhMyDwWDh/kPXq2kK+KAds0g0nE+AcIdp03oQA/DNUuhBLUPQ8iNtDCqEUI1L
 khg1pxg/vQzEyngGkvGUf3Bz1uhvaagRC85KvviixMbxdSYuTQ5zDjdhXINBjJa/mKfb
 7lODHs0OMkaxI1Rrz46AD2+xugyulhnVN/svFI+oo0TPFkOiIYyLRXQI3xe3Wj5WRFGB
 0E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333780; x=1745938580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cV3mM0ENqcZ01CB1iRk+m5MtZMh95fPFHAPIzsRChqE=;
 b=AF6RB25L+v8Hlu0fRbwJjXVYfgxHBW9vYLc+MkkBnuX440hC8HOplDCKc8WgHEA4eF
 3c0/ypTnxrWHX/1nWdbTa2GCapgDOM40aMzxxnMBY0NS0yGDHRw7nWkPcsG8l1t1NZNp
 HHP/kTVnMjEOUWmsdyvSjjyGn7Jc2wck9Q7wEX4heiZp4Dsl8UXkJE9idE9g84dD/PKm
 6Tk/vzJqF/TfTvtzAv2vP9PPe1LkTrjxkk5iNmtKgpiFyB+yOPTLl9zphnZVuW5P21z1
 PRaWH0Trnp8dkWwDrs3bjQd9j1As3067OzXZzlEVLC+YpS4IGqwFc7gPBtxEPWTZHJYH
 HiXA==
X-Gm-Message-State: AOJu0Yz8vgKnGTr2awcpyp5EzeH2sPe60ul0Wtz9gHXKcVGnFlXStbMI
 moQDSZSb/S2to0V4V8FCLyfZyqIZZcarv4Ke/jnWvHOcoOSghHewA/AMZMFsw80=
X-Gm-Gg: ASbGncsEZyp90OPdFu63fovDlfcU+JU5MGaZ1Vnor7+1YvfmT9UPonr3tF/KkdPKIxl
 VcdcOkbCZlQO1qfp0+azXQmohKKC0Ig4Ermx1ivKHOp/6kSXx48GQrI8AkEwaJizZJzy0Qp0m6D
 NnNzAK3WT+HsdbZIgfp/nuPvK4CiDnz17uOX+Zl9ySW4yC9O9SpqQRDS6s7SWZmQJWNKUbva1R0
 FwQ7QNIu2+UOgJDkkuMi8gIm63B2+8FzkN1P91rMl19dr7yGKVAMCGbfdGh37w17Vr+NVMSRmId
 Bvihaswy6tm9ohFd3ry2JwOG6ghnN6L6glx8n6pm+Qr0Yg==
X-Google-Smtp-Source: AGHT+IHUSLcTWdpWOd/p75pogB/VKkuSAcWZMKgWqy0LuEtxR9/vO1NQDWqbwDwf2Z8/TAlyJ/QB/Q==
X-Received: by 2002:a05:600c:4706:b0:43d:79:ae1b with SMTP id
 5b1f17b1804b1-4406ab96b35mr145085575e9.14.1745333778309; 
 Tue, 22 Apr 2025 07:56:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6dfe2esm179084965e9.34.2025.04.22.07.56.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:56:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 16/19] hw/arm/virt: Replace TARGET_AARCH64 ->
 target_aarch64()
Date: Tue, 22 Apr 2025 16:54:58 +0200
Message-ID: <20250422145502.70770-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Replace the target-specific TARGET_AARCH64 definition
by a call to the generic target_aarch64() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
This removes the last TARGET_AARCH64 in hw/arm/.
---
 hw/arm/virt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d7197958f7c..4e11272a3ac 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -32,6 +32,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/option.h"
+#include "qemu/target-info.h"
 #include "monitor/qdev.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
@@ -3137,7 +3138,8 @@ static GSList *virt_get_valid_cpu_types(const MachineState *ms)
     if (tcg_enabled()) {
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
-#ifdef TARGET_AARCH64
+    }
+    if (tcg_enabled() && target_aarch64()) {
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a55")));
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a72")));
@@ -3147,15 +3149,14 @@ static GSList *virt_get_valid_cpu_types(const MachineState *ms)
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n1")));
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
-#endif /* TARGET_AARCH64 */
     }
-#ifdef TARGET_AARCH64
+    if (target_aarch64()) {
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
         vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
         if (kvm_enabled() || hvf_enabled()) {
             vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
         }
-#endif /* TARGET_AARCH64 */
+    }
     vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("max")));
 
     return vct;
-- 
2.47.1


