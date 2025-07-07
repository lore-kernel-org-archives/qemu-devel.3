Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AAAC83F0D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpY2-0003kC-Pc; Mon, 07 Jul 2025 13:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpWq-00011q-Sm
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:21:21 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpWn-0005Ev-QC
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:21:20 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso1801167f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751908873; x=1752513673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Cwq/mg6mG+kk7LlFctkSmffhOYT5MXBLjyGm0TM8y0=;
 b=UT9tdmB517MI2DDfz8iVRjG5Cqv2YVG0rnP7pQShEal8heuN1Hguug4kMYD6ftVCev
 C1vDBUP4Sc1avE0/JWFkOTwsGM13Uzq4AhFcJwtY2pCiMFy3qT3gyvpxyhdk9RWgZtf9
 Jlr3DNt5InvCJ1S/XTkpr7G5VjlOYEL8M6oEbskaCl0d9v272yv1/bWRKYbGVomNtPoI
 3TWNayRzvsj/Nk8tamU/fPr3i6imzTwwdaRdEpzYn4QjPeKDVzuTMYMxsmg/2Opsztcm
 75YPIQT+O0yeeMVuis6YyRG8oi/8DHYsnrv4qt5qv0i8M7JOygffc7lqMBhldnKy1ht3
 QQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908873; x=1752513673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Cwq/mg6mG+kk7LlFctkSmffhOYT5MXBLjyGm0TM8y0=;
 b=TM9INxsDLBRLABMWoZ9XZprm7O1z1sItZrYZgudFH/AWl6FTyvHdaChzq2QG/9ADxE
 +oYj2heaGL8SrMdSQTYhHwSp/NJo4WHHKKjkPIhyVzdfP78WZAHzYbBicW9chn2Tv7SA
 Qm26ctcyXioguxDR3nmCDmywZUpSFxkeESCtVeS2nY81AqholwZ5GtdXjGQxGokzLlSE
 iYdpCQCIWPkBEa0YeoeA0XXyEuD4G7moVNjjLC0V25J1SjSvJj0SVk6NLtD/qXAWDOAG
 D4z/hqTM9GpVhbyLBs7dHd+EURTwg6OqHxM6Abqf4Q8R/EZvzuGbQwsNWdPiwuRryNTC
 YrCw==
X-Gm-Message-State: AOJu0YxcEwx2spvGMD238YZ0CGw/c1A+UxkisjD5u+xSDYOAKCNwWNXK
 hMRvInlhmLac85Qw448tH328YwulC5aNxDW89TWLpjnmXIn9LHWPWTr5YNCHnNnZNEnksbKIr4r
 oHMjz6cA=
X-Gm-Gg: ASbGncuHfR3T+szF8fNdQVgbzZdH5VI9CQG5OmT9RH88s3VHuxoOMRVpM4Jys5WsgfJ
 ySyd01Ip70xlyDilOAEyMVIpfBTsRDZnbvrqJEJSqu9/AN72Gxhpy1a/5ajH8YhrjwvfomoyNvN
 WSWkpkw5odBsEy36IVJPCwSi9H46uBGDfn7brDIyVVfl/CMhK0dWkvkPVP/XhdDbFXQwmurbYNT
 IDLhwNu6kZYOmlqUxpy0lKyjpMkWxROSyEH+0ooAbs09a1WM6qK1YSxGuUiVGpR9NeGE8kjnVki
 RyTVk+aNBDwBmDZcsnAiM+jS2E9YSs+uhuDIt5EvKHr5M+PCp5cnJKVjqyWReZVKt83/NgpqeD3
 x4lql5uq4/snStVfumIIvGgTIgn3W7yjfDLY0
X-Google-Smtp-Source: AGHT+IHXaaojgFflZHFVgx/9YZwYL4Ew/vAuJGo1fV1TzYAtliJIJA45khGxb2ny/B0r5JZXVjiorg==
X-Received: by 2002:a05:6000:98e:b0:3a4:e387:c0bb with SMTP id
 ffacd0b85a97d-3b49aabdc06mr7102985f8f.59.1751908873206; 
 Mon, 07 Jul 2025 10:21:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030cdf5sm10626615f8f.1.2025.07.07.10.21.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 07 Jul 2025 10:21:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-10.1 v6 12/14] hw/core: Allow ARM/Aarch64 binaries to use
 the 'none' machine
Date: Mon,  7 Jul 2025 19:20:06 +0200
Message-ID: <20250707172009.3884-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707172009.3884-1-philmd@linaro.org>
References: <20250707172009.3884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

When we'll start to use target_machine_typename() to filter
machines for the ARM/Aarch64 binaries, the 'none' machine
would be filtered out. Register the proper interfaces to keep
it available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/core/null-machine.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 3e03771d570..bd3ca6c7719 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -16,6 +16,7 @@
 #include "hw/boards.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
+#include "hw/arm/machines-qom.h"
 
 static void machine_none_init(MachineState *mch)
 {
@@ -62,6 +63,11 @@ static const TypeInfo null_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("none"),
         .parent         = TYPE_MACHINE,
         .class_init     = null_machine_class_init,
+        .interfaces     = (const InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { TYPE_TARGET_ARM_MACHINE },
+            { },
+        },
     },
 };
 
-- 
2.49.0


