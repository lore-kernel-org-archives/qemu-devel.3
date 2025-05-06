Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C756FC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJQ6-0000hR-4L; Tue, 06 May 2025 10:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPK-0008JA-C8
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPG-00017f-V9
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a0af41faa5so397121f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542181; x=1747146981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6e78c8ZcocuFrQtn8xqZmXaT+QiLbHh1PX/rxHWttU=;
 b=sQ/ry7WUdK8IeBIoDAzGdcC3cPtQCrWJtEU7Vj3kv6b8tFuiGAqpA38mXTdUA2XJyW
 KDO6P5ESWizRKAViRMF5+qjnqOyoF7v/z+CqZlVro7lYb0j1ypaHcjQNyBj1xMO9D7b5
 2uSSUX67CFgRj9YmmN38QhALW20hyMUsSI71+9qeRQiIUm9Nyyrf3/CXroBDYsGinIxc
 bHFvRAqh3KDeLfhheIRG7ds9Mj9zYC9ni/SNXgSjB6qzgLN7RGXS0sf2nkYHhqD3yx5q
 U68kb+0KM+bez8MxAul/7JkEI/1gLI3DrQXG6GfAJnumQ+JTeW6nC2qTDnBZprppVFzg
 gOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542181; x=1747146981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6e78c8ZcocuFrQtn8xqZmXaT+QiLbHh1PX/rxHWttU=;
 b=XUIoiEg2dI9iZJVMUs0O27maydcBRtkV9pEbk9Y7H8ErVsOLE5M5KnOadp4IeI1euE
 zvWSeghi7iu3en056gOLreAjNWJROf0TpQwmqSwJxz1lk2f+GgnV3ny1FPY1+JRtEVJP
 E0a0mn5Muqg9IxtuRmBFFUyNjOG2BkzTYxahy+GGcE6fDqDUi1n6mO5qYw+SU8ALK7Oj
 P/kHIqYvJn+2v24YpLyxwPB3zG8cjImkgDeBjSzneebwhMc154dys0n/2iA+jxZOOjUp
 6VnWS61/BGfG7blrmpRF2wFnwAbHB9/na2Nk0gVnFilUcCqfeoohRz4ATVsyThQ6+C04
 7gYA==
X-Gm-Message-State: AOJu0YxUktw666aNfkQ0PujBT14SHnw2GKw9i6GCzheMwCQiiN8wd9c5
 v3811M2cjhIDYy/+PA3QB0rO/rDrRhga/+wV8nR1pQwE327zlJ99LFkaMxaYsau6CVSj9qa1XLz
 +
X-Gm-Gg: ASbGnctkE38bRs6vrL+Ee3RL/lVeWUFbRgTt0dPoOrC4ifAgL9j5z7MwG8kYBLsQgot
 gptV+RNPxpsBg5178g41RNp+hkmTmSP2bifgZZSiy3bSd5XTt8mGTRKFo6gZURKeX64erzyVHrZ
 b0rCZWyLTaiLjMTOIC17LzCyinTySBaFDKMQcMT6AUKyFC3fvLnQWht5Yui2HTwCVdVnPUAkSH+
 OhXlWRM1nBgmeq+JEm3gM4EVymYRVj+fQXIvb+P36x7M0zTFcOQAkd5wypdMTI1l4Y++/Fua23o
 BissMwxHUMHjBno+t7N28KxQUuq8YmlSyI+tTRmaVgr+kkgav+WAErtzzHL8ADT7Vu+sEdKU+1P
 1MFbybZfvJgXuotOl5q1i
X-Google-Smtp-Source: AGHT+IFlJbT6tpWrxWx/zNf7Bx6ChyEHZcKA57OqwMPl5B4X+VRfTLzIs+xEmAjthcN/SzRiquG8UQ==
X-Received: by 2002:a05:6000:1869:b0:3a0:9f24:7748 with SMTP id
 ffacd0b85a97d-3a09fd7a70fmr7947697f8f.23.1746542181496; 
 Tue, 06 May 2025 07:36:21 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b2449dsm13784985f8f.101.2025.05.06.07.36.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:36:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/22] hw/hyperv/hyperv: common compilation unit
Date: Tue,  6 May 2025 16:35:03 +0200
Message-ID: <20250506143512.4315-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250424232829.141163-9-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hyperv/hyperv.c    | 3 ++-
 hw/hyperv/meson.build | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 0271cfd2719..e4d0688dbfa 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -13,6 +13,8 @@
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
+#include "exec/target_page.h"
+#include "linux/kvm.h"
 #include "system/kvm.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
@@ -23,7 +25,6 @@
 #include "hw/hyperv/hyperv.h"
 #include "qom/object.h"
 #include "target/i386/kvm/hyperv-proto.h"
-#include "target/i386/cpu.h"
 #include "exec/target_page.h"
 
 struct SynICState {
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index ef5a596c8ab..d1cf781f049 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,4 +1,4 @@
-specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
+system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 system_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-- 
2.47.1


