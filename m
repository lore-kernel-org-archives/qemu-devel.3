Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AEBF99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqxd-0005gC-AQ; Thu, 23 Apr 2026 06:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxa-0005Vg-D4
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:07:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxX-00046J-77
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:07:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so83017165e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938817; x=1777543617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fe+VSVu95XnWPy3WfOSgnd08QZbH6FgPjO6YfwbZwsk=;
 b=jfjTid7aPo0nW1tNFgMoWcACOR3dfjPUN57lnT+yIHb4lkOu6avAUqsrSBR3ruE7NH
 9FUJndkgdy1qd73+q4FhPvxyy4I6vlo3U+bbhbsmmcTJ5y32N+9BCFDOFwaF16+1GGCO
 l4FYvCFU3ZqzwuGBteMlL5FoABQENkm0bIY6zDOFmzIjuYhy5mtQUihmj2OKZwu9w1fl
 Q+dICxaQu7bVsupbNi059BnF79DT4ubD+zzwf4cNbdVsVOR/7q9zotW/eBDQtCR8T7WI
 mEh2tYQFl2LvVStxIB9yGLG32AfCRqh0H7RNhFq2mInxC9Nufctyt0+9qunJIfmFsRTg
 ZeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938817; x=1777543617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fe+VSVu95XnWPy3WfOSgnd08QZbH6FgPjO6YfwbZwsk=;
 b=ea/9CQipIrv5449I7xSxJD+sQ4+rSk8Dri/cGVJsUHVloulcBqvMput/SG/qlHqYVN
 2v7gHD5gMUvX1MFB+XqbGeGaS62U3vtx+vWZPoXyNqf9ujO3AJ903FX5YJi7iOFLTaoO
 L1D/rZzSGdDKB8ZnIbCS1Yx9joCIQh23nNLdubcjp7HC/oi++i/pyFa8Hn0aC+uD64Hx
 HP9j58VBqQ7XWKTsMTzZEDaUitwFsUxB3Mzgvw3VOr+cr8aZuJLFvFaqroyq/nv3rcrv
 YX9fHvQZvD388CNg10ZPRnnGXOGS9mUkXR4YDs9AqeGsf+7iPH+iYpfODQ7iImboH9en
 Gcjg==
X-Gm-Message-State: AOJu0YzZ5eC01K3zF27MxRPzWB5XhAeROgqMVI+ospecm0okNWXbn1bT
 Fp7wHphIsO6oYw/cCeIs+IyFQTUPe+J4axWnArOPFc75RKaghAbTdiJdE6LEho9mM9qB/ZXIvr6
 Rc7KqR6I=
X-Gm-Gg: AeBDievptfko84NlIL+VQbVphDsu75yVqzxY8YHKdsgR4sNXI6YW4QK/oehWlRfvRvc
 2umR3GnukO+K5Suf6OdxGxiUjzvRb6pfWNP7YzlA88v/9/9BUBgDlQPDTtCuaExD7gFAniNOQSQ
 MQ8X2dAgGPCFmLR1e/2QfHcQjDLWnYsD7W8dZKr1u20FowyfV/BCScrb4mJel7SWOK50wGkdIt3
 f5xSqQgUSejdQ9s5a6k31ECTZQXdhzxZ42CP7fUV7cvjLc9caEdVeWU4iPKWAMqMkwkt1KSP9ox
 ihyqKHmXp1aX8xkPESC6Hk/MnWEdBYU/r8blMeg6HXgKcjaldh+a+BqKw+VpqDP8T6SiGoJJ3gS
 B5vQtgTPezkMwfcgGLzTd9GvElwyRQFiHmB2Tnwz5fzDuNoJhvTK+T3phj4SpGiK27joKwpqt4Y
 IRJme85A0ukX0mW7M+9ARGlP9WoQQIm1yJBX+2vc0wFYoxZiXkvfNHkOuWYR00HZl+fzkbv73iU
 ztvG1u4dhI=
X-Received: by 2002:a05:600c:6297:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-488fb77155dmr350784735e9.17.1776938816813; 
 Thu, 23 Apr 2026 03:06:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5e52b2c0sm17148295e9.4.2026.04.23.03.06.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 03:06:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/9] target/microblaze: Compile op_helper.c as common unit
Date: Thu, 23 Apr 2026 12:06:09 +0200
Message-ID: <20260423100612.27278-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423100612.27278-1-philmd@linaro.org>
References: <20260423100612.27278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

In order do build op_helper.c as a common unit we simply
need to use the common version of "accel/tcg/cpu-ldst.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/op_helper.c | 2 +-
 target/microblaze/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 31da2c7c3ae..84c60c2636e 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -23,7 +23,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "fpu/softfloat.h"
 
 void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 94c76de39bd..add3e6ca9f9 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -4,13 +4,13 @@ microblaze_common_ss = ss.source_set()
 microblaze_common_ss.add(files(
   'gdbstub.c',
   'helper.c',
+  'op_helper.c',
 ))
 
 microblaze_ss = ss.source_set()
 microblaze_ss.add(gen)
 microblaze_ss.add(files(
   'cpu.c',
-  'op_helper.c',
   'translate.c',
 ))
 
-- 
2.53.0


