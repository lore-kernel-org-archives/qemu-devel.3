Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D39CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 17:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVzz-0005PV-1J; Mon, 11 Aug 2025 13:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVzf-00055l-LS
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:07:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVzS-0001tb-Vt
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:07:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a11078618so72645e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754932033; x=1755536833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kpYoiyGaNwP9QeQLj/6KulYrhyYzjmCLEuykA1SH0I=;
 b=bj4dpKzRuDJ2ATnqsKN173uTtTqetauLwEaprycqgSaazZGpiCgCeuaGkY7e3uUUuq
 /9hvCWzG/YXoaF6mzghGvutHv0e22fN9MFe28D8dkXL9svaUBL9H2HBjKndvvHQoG7FV
 HwYvFhVs/AQ9b2B27WWjasbPuCncKwuGiMrpRRHrvfnL0c9xzIupAr9+3h9Jl60W2ltn
 89aYLOYRXIVgLd5c6Vf6HYIjNpX/AwQJahPyR3rj83scGXA/DmGQDqHTGv4GE1Djc/m8
 XqwPTxt5L2h8Vxxf6y8Gb9KBTZ9si2Ek/hhc4wtPtDzxnOFsZo6RzEEoKnGnrevSylis
 Md2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754932033; x=1755536833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/kpYoiyGaNwP9QeQLj/6KulYrhyYzjmCLEuykA1SH0I=;
 b=vAidn/ONQxkoy3RVaDEbp6JZTCXdEMKpeHuotTwjzO5ou2EVqqtOotw9F+vL7EQ7mU
 V1VOHBxBwPQZ5o/DFlyrj9n6pbVPiRR5V6d7cWElHs905bNIkl0CEhP5LLvHuGi22nAx
 +DEtJz8yuigTLOIcXuRWfU2IXR5b3XU7n1FKx2S/hXW7IFuZffWSD9raGygYKW/1LwoP
 jrYcnEfIWmeugAkXz4XCsoWg7sLex01k5UtZsNvRzrjJM0U21XI0Yj33StiIgGfRvbNR
 DvK/CWa21ejpkbhzTyVvmUh6r8O3N634YEfGKibbv/VGPXnkmPTpmoXAjEZLiCv9e1xV
 HELQ==
X-Gm-Message-State: AOJu0YxElkGR0Rj6pRJfBX2PxRTt+fg5vZD6lPtTzmZiR4Dr9nWJk4ev
 2nWb8U4x9NlOma9XP/TEd8uyr1B16Ah8XOTCNpkiLHSMS6WmbbJBPa6XwJsqxPwAMr1PR0elXhu
 XWBms
X-Gm-Gg: ASbGncvBbLkp3P8QZVTBWph9KZXsP5BNXzUdhRs7My19rbIP0Y+78nbcFI0PXUbVWz4
 BSUwiszv6fBALJd4BhQGUPdAKunoSb8LGmPJq4tH9G+3srsjNKkuQuEGDQYVfFJ7vE4TVmZjLt0
 a1fJIq8xRCYaDV75NaXwaVdh6hqOP02EydcMlXFx37Qe9kw5sKHkkLrQ5ySMKJ3L1yDThZmxD7k
 YB8QcAcLGK8+UjxapS+iG3WXmDy2pz0Vgc0SFuJZnjr+yURlScVeoz6bdioJVGEiUxDcsnSH5Y7
 SJ9OXPUT0TNpb57Jk5eiuPjUdPWtvtdO1XF2rJYl183TNv/R41vbxuWqS6KnYFuSdBA7m8voQ/P
 js1KnD7QbMVCZvYq82n1S4BFSitKeyPo0cPstlRRVA0xHy1wolR0MeY2VTOtqeqBLxotpf0bl
X-Google-Smtp-Source: AGHT+IGPNlPGCtPBypS+3QH5V8BmL3guma48smLhKJ8u6uzLKRJHeGM33dI4w+1pFfja9aZ7mD/1ew==
X-Received: by 2002:a05:600c:35c5:b0:458:bfe1:4a91 with SMTP id
 5b1f17b1804b1-45a10be7b42mr4144935e9.20.1754932033011; 
 Mon, 11 Aug 2025 10:07:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e58553f8sm279207095e9.14.2025.08.11.10.07.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 10:07:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Miguel Luis <miguel.luis@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Haibo Xu <haibo.xu@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Mark Burton <mburton@qti.qualcomm.com>, Alexander Graf <agraf@csgraf.de>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 11/11] target/arm/hvf: Allow EL2/EL3 emulation on Silicon
 M1 / M2
Date: Mon, 11 Aug 2025 19:06:11 +0200
Message-ID: <20250811170611.37482-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811170611.37482-1-philmd@linaro.org>
References: <20250811170611.37482-1-philmd@linaro.org>
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
---
Another API PoC.
---
 target/arm/hvf/hvf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d74f576b103..0519903c928 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -17,6 +17,7 @@
 #include "system/hvf.h"
 #include "system/hvf_int.h"
 #include "system/hw_accel.h"
+#include "system/tcg.h"
 #include "hvf_arm.h"
 #include "cpregs.h"
 #include "cpu-sysregs.h"
@@ -1014,11 +1015,14 @@ bool arm_hw_accel_cpu_feature_supported(enum arm_features feat, bool can_emulate
     case ARM_FEATURE_GENERIC_TIMER:
         return true;
     case ARM_FEATURE_EL2:
+        if (can_emulate) {
+            return true;
+        }
         ret = hv_vm_config_get_el2_supported(&supported);
         assert_hvf_ok(ret);
         return supported;
     case ARM_FEATURE_EL3:
-        return false;
+        return can_emulate && tcg_enabled();
     default:
         g_assert_not_reached();
     }
-- 
2.49.0


