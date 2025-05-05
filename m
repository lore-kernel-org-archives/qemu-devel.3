Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E898C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5Bc-0000RD-Rw; Mon, 05 May 2025 19:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AX-0006yu-9g
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:21 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AU-0003xO-2l
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-227b828de00so57607215ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487452; x=1747092252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11Q55+gMF5u6Eo9NyNW4V+s1ceVG/+YyEcTpuHMGI4c=;
 b=FIJwNYRYwTBj3Q/gTyW8pNGmSnwYytqtF09qQ30ZNDw49SHzmEF6drBFpC5EkHxOv2
 6B3fDUVaZygYSFHsTC5EXfHftK9hVl1a+6JOivrrNBw82YuiWj0RQElGuOWjiWUWSImr
 R0hTNHBKmCPVQuxtWjidwUGjc6XFfO6F97ATNMLI12sXn+5jHbei2kuZr9uOeGJjXoA5
 d1sujtVqj+4YLarzLkD43n7E51LU2NcEo3MR367c5I19HPZG6B+NqHtEdWZnvhePMmf9
 y7svRFeTxjYTZEMznYxOrIgYley3dVmZg8E7AFifTNEtaZW9N0mP4i8grtVvASmOZts8
 vipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487452; x=1747092252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11Q55+gMF5u6Eo9NyNW4V+s1ceVG/+YyEcTpuHMGI4c=;
 b=gjn2BKF0t7rN8FtLpFmmQKv/vL4c3LUlCcLie1zS4ydpwvnr1uABOax5ytgJHU0nZa
 tMvFOokcvbUYCGVlIk8mphaZMDUxFbiayYr+/N0v4B/z9yNBIGPYWs5fV9Y6QGWH2e+G
 CeXuV4JnoqJxXSM54Z2as/sjYMK+9RiERZeDBmp4zYuPfszI9xPWdaZctlVbSwOllRyy
 +vZUtJppNXWCBdCNJJi4CrSJEZ8cavpsjhUDNed4nRQ+VX1qMbi2JyWoREELryvefQo/
 GFtdLGDQ58HEMWuNENSldxW/HMoZqwy0Kp/ZXjBFFR7+SmJ+kmGQqalRYygkGdyRzTMY
 MJ3A==
X-Gm-Message-State: AOJu0YxFYCFwEYJBHr1F2NcR6B9NNgFXhbNoIaZ9U0wcAb+aLLaWxlid
 lvNv1MyA2dA8gW84anMD30Rl0hTXNGQnxcOEwd80GYc5/wrrvQ8IBSYiOvdaD4Y6jjptAqee9uh
 6Bdg=
X-Gm-Gg: ASbGncu/EDCYMg9JdVVlVV23nIC44s/Ii+ddNWi8rC6vbQSRZSJ/tPEjaRs18T+qD+m
 Ju4MfK4Rwyo6G2s1eM61UaGc+QRf4W68n+IrCuhhDXCZMChBFmUYwYlJcMLm4KVtMNcL2jBvsrV
 avhoTY31rX3sZHZrBDCCzhJVk13JHn+8ImKJYE4hJA+W0S6av4YB6mQjbw2Hkuc09wL3Agsk+qF
 AdtPh//3qQA67z1i1U/faS0xkx6Hyu9+yyxuz88bKErx5GAmfhz1USVKWHM0cRCIQcRqPC38e/F
 C05iXbjrY/QVkwZ6agF52mOWvq20me4AEdDLeZ+UuOBsDUXcoVE=
X-Google-Smtp-Source: AGHT+IHEfEn8enc/UUEJkyenE0/ZzWHcJwnmTdVTyMTIF5jEMniI55M6dBRUpyvPtgQEw4fn++nWVg==
X-Received: by 2002:a17:902:c412:b0:220:cd9f:a180 with SMTP id
 d9443c01a7336-22e365b89d7mr13254335ad.53.1746487452569; 
 Mon, 05 May 2025 16:24:12 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e16348edasm58705265ad.28.2025.05.05.16.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:24:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 45/50] target/arm/tcg/neon_helper: compile file twice
 (system, user)
Date: Mon,  5 May 2025 16:20:10 -0700
Message-ID: <20250505232015.130990-46-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/neon_helper.c | 4 +++-
 target/arm/tcg/meson.build   | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index e2cc7cf4ee6..2cc8241f1e4 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -9,11 +9,13 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 02dfe768c5d..af786196d2f 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -32,7 +32,6 @@ arm_ss.add(files(
   'translate-vfp.c',
   'm_helper.c',
   'mve_helper.c',
-  'neon_helper.c',
   'op_helper.c',
   'tlb_helper.c',
   'vec_helper.c',
@@ -68,8 +67,10 @@ arm_common_ss.add(files(
 arm_common_system_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
+  'neon_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
+  'neon_helper.c',
 ))
-- 
2.47.2


