Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6B2C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uyP-0003w3-JQ; Fri, 03 May 2024 11:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uy2-0003GC-Du
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:02 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uy0-0002kJ-K2
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:58 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a58fbbcd77aso928460066b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750615; x=1715355415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qe6fMxQCClP86U2E4tekhsNK+cCefDglZXDii44rTHQ=;
 b=uoRWvZfTrcY0Jzo24OcaiCjg/aFvAPvrjoxhkmaGdd37t02biBesK0JO0SN1ZkG4Cx
 Cjm388aC/cxejf/ujRWeQPzJzW891cg1AZcAMdvJOPuZzC1+vuJJ3PNVccDFk4J2ZWdV
 rZn5eZdpvYhZxyxWoDyb7NDFUV4uLBKVJBhMPsS+c8JHzU0ACHaid+O0cum+MDNuVQ/8
 m4WNEjYSfHAsBgm8SRxfauf4q3jtXPC2IXfmwdUy70FrFamCJv6DCx+3BZ4KaQOAi4nE
 r88q6ISDZUJCtVlbZL+WUQIvn+my2OxCZBmu3F8sC8vsvCGDxytIGDcUgk9jV+JD7EbD
 vDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750615; x=1715355415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qe6fMxQCClP86U2E4tekhsNK+cCefDglZXDii44rTHQ=;
 b=k/Hluz5JrD5dqIrgfFcCtYE2AL1uGFRmtB4x3vXVCnlm5tsAAA4iUqKWhzhudcCPVl
 Ii0syfGSF3E8oztVsiVmk0c1r/zu01jNQGWCnxjkGLVVkTSWjC7YtSguJfWdE4esmXv0
 viSFZat3A8xp8h+zpIiCunQR+pSWIyRpiJFN9fuli1Ct+S+QksD+4NtanecwLokRj4qx
 Tqv5BiBRFkFcz+Q0PseRDzkSkWZveqH5Mt7KDPK1C18mWIp5kU5ZPtbFBpXRAAbbawV8
 qFjbaMrvDiVTQ4QZkNCkSHfXWBVGKTehm8ewrOfF/5KoqQ3i0FA7HJ319xjqQoIjUvE3
 lijw==
X-Gm-Message-State: AOJu0Yy/5B/OT6V6dQVly2bqEkB2PYcA8TPcni9P40SYToYQuAEoru2R
 VmWQPSHGdM0Mlxq/zVcONd48J0TrImUhJeYK9t3k2aI8+tkRpQrsNGFXnBmH5wDmvyaNd1lz/qR
 z
X-Google-Smtp-Source: AGHT+IHzWTPeIp70O/MyKEPSlDUt8I6o9Zj0C/l5s7nwXqgEDN47Vo2rRt5ykIEacCBM/mv/eUiwqw==
X-Received: by 2002:a17:907:9952:b0:a52:13ff:5317 with SMTP id
 kl18-20020a170907995200b00a5213ff5317mr2144965ejc.38.1714750614889; 
 Fri, 03 May 2024 08:36:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a170906560f00b00a599ec633cfsm200108ejq.104.2024.05.03.08.36.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:36:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/14] plugins/api: Only include 'exec/ram_addr.h' with system
 emulation
Date: Fri,  3 May 2024 17:36:06 +0200
Message-ID: <20240503153613.38709-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

"exec/ram_addr.h" shouldn't be used with user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-4-philmd@linaro.org>
---
 plugins/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/api.c b/plugins/api.c
index 8fa5a600ac..eaee344d8e 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -42,10 +42,10 @@
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
-#include "exec/ram_addr.h"
 #include "disas/disas.h"
 #include "plugin.h"
 #ifndef CONFIG_USER_ONLY
+#include "exec/ram_addr.h"
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
 #else
-- 
2.41.0


