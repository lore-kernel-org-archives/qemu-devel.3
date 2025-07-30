Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF521C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEze-0001Qo-35; Wed, 30 Jul 2025 18:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEwd-0001e1-18
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:06:43 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEwY-0002dj-3R
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:06:42 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-23ffa7b3b30so3937145ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753913196; x=1754517996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkgXPOtfTDdRhmtR7+6K9lh3sJBO3AG78sxoSa7xDFE=;
 b=Sia224/M9UDwNG/Gs8RYRY5ZdRjtRM/6CvvC5gTgImuvS+nGiPpvriWBk49jgMRPaa
 eDHNyfNTh3Vyr3UdbQ6hJxjWbl63OnmkGXw1QUjqUn9DScOTJc63jy9yDWZ5o1zmVkIw
 2E3pR6Ibz2zCLeRmqpVgVbfJ66Akzb/LWMR1yk8WtuOHQC/C9S1hK6mwxVlwmDAMDfhA
 SOup/o9ac+Ru5Cjb5AzpaIAZtOflHKeCvtvMtd+uO1SA6hTCixwCFgjPcrd0UWCbfHM8
 KA8mMCivXEUGEYityQ+O6bE2APwmNPeQ4/n60INsMLN8AEs/Y3XrLk5lOgSqNV2GRn1a
 ueNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913196; x=1754517996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HkgXPOtfTDdRhmtR7+6K9lh3sJBO3AG78sxoSa7xDFE=;
 b=dHawKrc+FmK5SgD3VsGAUZZJ9alng0SkJs7Pr2EQc4dGIhVarY38aM6JN6WS9EevO8
 vhMyj6/Ve/3P65/nsB3BjhdcrcmQ/4hnWZ4qAZkxAz32G8+NYSjiGqDcLyOp9USkZ0Ot
 OsaxFTWkeE0UVG6biDVbMy2DQng3w/mBiwsktd2Z0HLZLdOKREUd88I4i3GA757quUXq
 JIgHja5sJQoXqEmzC/nDkx4ZnECpORdxmTJRwHkqoXwaNBhFuISCwfUraXGE0wamczdV
 9MPSpb5Lm+VtA90INlUXBrL5Wnb97PsoWkkZaTafsu+CaHF7U2mjTtFx0kCJB3SrbvSN
 AOAg==
X-Gm-Message-State: AOJu0Yz50QhGebgNJxQ+9vrG9RXt61aSBYpDXG120jWD9HmZQIDt8nr5
 KRfqHWXr86TbGpxy2R/qy9Unq57nyKCQPqUYv0fFSsop1Bl3e7D2DwB11a1V/aVcJrbVC21xvSL
 pKtjd
X-Gm-Gg: ASbGncvbGXlKi10wbqqBnmpfByTalkswn5acl0RdRO/oSI8Cq5IS8jJJ7+qgetTNuZP
 RQ5oAGpntUVN1zZt8rmUCTThs9EztZhRmgBLoYGKUMt+HUpiIRQkDiRY4SjkftNehsRAtvpzW4j
 vaFOSJuItZ3Zpuhkkz89qhw5K6eu39MlzFVzK3sbRMT1tgwIe3o9ocTFSakIGxJhxYUkoKE5Z26
 CTPxSO0GUZgtxM768XLxZrE2lprAm1QxGgZQz7C7Ni/czu8542wxIEaBQo8R0LwTDG7FPgs6v12
 g4JZ0/BLGZiZlNepgbc9KugAi/Fs1ndLE5TsP5F/p9cYeLjQY/pPAC2bLN1iVb4N4Tg+baYu9sG
 xLbkJVxHjtWvGHXnqoSA7rQ==
X-Google-Smtp-Source: AGHT+IEwidS7gyMXA5LeWThiCer8JwrvnZNz44DvSfCO/Ty70yonQ3n3aS69EaIJU+bGs8fnXBZJIQ==
X-Received: by 2002:a17:902:e54a:b0:240:3c0e:e8c3 with SMTP id
 d9443c01a7336-24096b587b5mr69293715ad.51.1753913196205; 
 Wed, 30 Jul 2025 15:06:36 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d272sm981535ad.135.2025.07.30.15.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:06:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 09/10] semihosting/arm-compat-semi: remove dependency on cpu.h
Date: Wed, 30 Jul 2025 15:06:20 -0700
Message-ID: <20250730220621.1142496-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/arm-compat-semi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 715a22528ab..703db038a4e 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -34,7 +34,6 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "exec/gdbstub.h"
-#include "cpu.h"
 #include "gdbstub/syscalls.h"
 #include "semihosting/semihost.h"
 #include "semihosting/console.h"
-- 
2.47.2


