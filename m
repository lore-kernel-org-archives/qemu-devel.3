Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB7CCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcjw-0001Yw-NO; Wed, 06 May 2026 09:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjn-0001HD-Sn
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:33 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjm-0007yf-9J
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d75312379so643601f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075787; x=1778680587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uBH0BeCe+lQ7Mvc8z0l30R+U8uJCkVCOQv4KB51mStE=;
 b=qQGGezWROSm9V3LJqPUHleWJokCNr76kA/oZbCPvvCnCujLuzwhc5xWt3vxAh1wQk8
 A1ORfBPkxkvWd6umsWAiIFMP37SRh9AL7C+piz10TV1lzJU9+WDgSDJtIKsILvP91WkH
 go98Wsa0ukcn/nnGpsf1K0GTZa8Ln5x32w3xxfHKoOn8oXerOrsDu9xnajd9wtm5oix2
 VlR5evcjTVfVaJ1OSGjKh2PDG/p23JmE586Rbe2+JQL36v17PvKDteqLM1VeE7k4/H6x
 KrgVQ2RuhR2xIsQCfwJb93uVqu8z9cy92EGVezsKlgEklX899hw1zsZqbWwzldunKtfS
 VtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075787; x=1778680587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uBH0BeCe+lQ7Mvc8z0l30R+U8uJCkVCOQv4KB51mStE=;
 b=jiY6PeGTzaMUXUL0BdduICJ+Aqw1kzOgT6xNzuYEW/0bgVFpaTh086asiSip7r4BPJ
 XERS7TKd1ZdY14WVMD/ChKiBOKZQI+AqlRlF+F0RBQvOsUvcPoo7o6G2kLsrN97mQ6NG
 2GczdNhzlft1Eos2ldbqbP51ND29y2Bt0dX7Iuy+fTt1U2CYnJLKiSNMvDs/YMvX0ps2
 /Qs17jGaLcRBdfAALT93gaAPqbEnBAgcQxJ8owUw0BAas8MOIJYhO2U57wamth6Y8o+F
 u2ms2nniyqDyFzTISpuzG+4IG6l+xBEkfxZc6l4oWjwACGzCfAQMt4gSgCHLrAnJzdbV
 dZgQ==
X-Gm-Message-State: AOJu0Yzgtbe/NEGX/+nao6EWcAI1IckvyRyY1sMrdQghNetTmaNyNsSa
 UqHvDLBcB8QXIJSsCvKuzqq8zo5o1i+nWp94xoylil5RthgrVR3Pkyesh/ioEFBkprZwAC7zflE
 g06Wa6gI=
X-Gm-Gg: AeBDievyl8U4jOLl5pL7/aw5kDwiZG0uZCYdvcaCVs2Xn0FvQuk3oHrbr2mHMmy9/mf
 WYIi0ezOFfTvJfqcx5r4DioLgiwPu8E9Kg+t9oRc5hq8mDYmAPp4VmVT7XzOVXvKKzuevFEok5M
 lwtaSH8KYSpUclvcSPonaEHUPoq2gQri0PZtm+sVN7Wzz9HcoA28aREXfRqrVPz15k8lmCuKMhC
 FXyFJoOLApcY/VOVdgY/vRKx/2idJ2uMIy7C74tXkfz1C+c0pnaZNqCkDrrEkeS9h+wisNdV+Je
 jxH77oxhx8O8J4AoAByzd39aVAjdMMlF5TtsUvRiMCzuIs+rTZVnN4OLIwtibSL1gTJoM+JOCqQ
 f/lfANefnG+TqhzUfjPToJ3JZnuend6/mpH1pEL9lphSlAggeXm5xYaVcHUwstn+ZQJk5WNzFB5
 IX2bIF2RlDrprZcUk7F8LicoKAm8DU1QmLZU3k6cA2zeL5YMKh3STNvW2kwVW0qbQ8jEGT+Zr1U
 WGBENMqZLE=
X-Received: by 2002:a5d:6e48:0:b0:43e:a8d8:f3dc with SMTP id
 ffacd0b85a97d-44fdc8d3f3dmr9407990f8f.13.1778075787097; 
 Wed, 06 May 2026 06:56:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960902sm14179599f8f.28.2026.05.06.06.56.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:56:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 008/110] target/mips: Include missing 'exec/target_long.h'
 header
Date: Wed,  6 May 2026 15:53:40 +0200
Message-ID: <20260506135524.20617-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  target/mips/cpu.h:462:5: error: unknown type name 'target_ulong'
    462 |     target_ulong gpr[32];
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-12-philmd@linaro.org>
---
 target/mips/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ed662135cb0..3517d2d42cf 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -5,6 +5,7 @@
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
+#include "exec/target_long.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/memory.h"
 #endif
-- 
2.53.0


