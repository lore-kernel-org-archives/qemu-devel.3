Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DE8C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtfu-0003WR-Ok; Tue, 13 May 2025 13:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbt-0000B5-3T
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:09 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbr-0003MG-2m
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a108684f90so3622659f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747158005; x=1747762805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/lGVjd8P+mmHimB41hBIfndruizKSfZ7N3NnHpeffY=;
 b=njWLMuxO+4sD9GurbFKevQDfEvqow/KgyTXQdILXrVE8P2mLN7E+57M6cGQGUVPT6K
 ddRSxijVudA/l4jXCfO+Uz7173r5h1Z+kWEAgEV53JLd93bTfUwCpnkwSM4U9Z0Fkm4n
 3ePAVI7gSILFr3qLJybp/1sNbwJRijWatJgNEn7LQWAROukNr4x2tlfZnLAgchQPMyMR
 3teQwyxRg7nkIfKIRsV+iVKQTsFnDNJyOh24FHh2i2T1tGD51XyeAxHWu56kc5KvwtsK
 7+3v4LU2fUjzJeX3Fi9vOK5XTE0aZ7550kqAY/6RCZNdLgD6okEG4UhAfXK9LAqZWoth
 HWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158005; x=1747762805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j/lGVjd8P+mmHimB41hBIfndruizKSfZ7N3NnHpeffY=;
 b=XDYhIyzoBozNSAjZVlfR7pZr9+zh1xTIdiNzdOfql80QxjH7aGO6yrujPbQW5WQONY
 8dqNRxDI61UpNGr0Qv3z6JvfqkwhFV9+ISGLtSoEC7DJL1YNbr9ITyzWv/Cyv4JdrOxn
 r6442pq3LSDSMxX5b0YB5SYYPc8v3HXhZqYurCmb0C1r0gEhwuXwNOo01LvTZ02kH1s+
 XaQPc7oCHxema+pO2Rx5ZqfP1tqoxzUjsAmMYqBY6B/6uHcnVnP4HZj+06h6EXrlwSVB
 bAYZCKFb/qokmRxtvlnn4dSPBUUzecxvWuFyJm2RgnyV3EZkoh89ZXlygqZ6DoW/sROq
 pQdA==
X-Gm-Message-State: AOJu0Yx4Iaam3ZADWjatkiuSgFq6mbtk71jSpqRECf66GEnjXo8f2xR5
 9gIJNL45y4VS43cxQ5MixNLBDBYcqgIwIolHSeeVIXQ1k3DwUPMGaC9oeKcw64qZdlfxILHfxwb
 erOw=
X-Gm-Gg: ASbGncuiKgOeoANy8DVf/TpdfRB6qLHwDplbD8FCLCcDxOIHg7z5sEZwP3NZ/Zlj0M/
 e8dGesO/Cnxvx263tZizhgKm6cMZa/mFKwFSKN/uPAciuebL+YMacfP9hyXJMhk7af6DNHCxpqX
 CDHDY+V1Dmk0lHqlmGv1zJneQ2pv9KgxQyA+3Vbme++6Dc+GMTGwZPewmV7mibBQs6ZQJ7/YZ75
 pW7dyWkr7ffj3SnRZKWPMPXDwlLgtSNM5z4XnGlByifssP3giqnFM5/lflCLOjdthKhlcq+gEJO
 DmQey/X7pJpVQhhBHDiVGhCULaesmd1MVT3ged5669xHFwb5v2R8Qi0tizU+5u8lh17gJEV2WYy
 yBzQV7oRklM+y8+LaDKTjsaHHEKg/
X-Google-Smtp-Source: AGHT+IG9y8FnZ4DTIwP5cv7o0bemgUVC+qrov40VGxMdsOYpK3LQnzpYsbkjEf5uY/e+8hZJ3o9UwQ==
X-Received: by 2002:a5d:59ae:0:b0:3a0:8495:cb75 with SMTP id
 ffacd0b85a97d-3a3496997d7mr196089f8f.9.1747158005233; 
 Tue, 13 May 2025 10:40:05 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ee95asm17105644f8f.11.2025.05.13.10.40.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:40:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/19] target/arm/qmp: Include missing 'cpu.h' header
Date: Tue, 13 May 2025 18:39:16 +0100
Message-ID: <20250513173928.77376-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

arm-qmp-cmds.c uses ARM_MAX_VQ, which is defined in "cpu.h".
Include the latter to avoid when refactoring unrelated headers:

  target/arm/arm-qmp-cmds.c:83:19: error: use of undeclared identifier 'ARM_MAX_VQ'
     83 | QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
        |                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/arm-qmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index a1a944adb43..930ec37413d 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -30,6 +30,7 @@
 #include "qapi/qapi-commands-misc-target.h"
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
+#include "cpu.h"
 
 static GICCapability *gic_cap_new(int version)
 {
-- 
2.47.1


