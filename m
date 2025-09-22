Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8253CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d0u-0004o6-O8; Mon, 22 Sep 2025 05:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0czw-0002Z6-Gr
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:38:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0czE-0000h0-3Z
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:38:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46d25f99d5aso5249715e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533847; x=1759138647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HhK8fyrcFTNAXAyMAUB3RJqIdZ7kdSjQMi97UpXe69Y=;
 b=X7LpoajZW+Rw2cWLMTTqy4HXpPLkYIY3ypSaeEMiTr7H4vKai4EZ/bU5aNVxOhFKCq
 pRqYGmaSY0JPhKgBbVEoEMJS2MiuDa0I8yj+8fKGCpAbdEKa++QRD6cCeAM0+52hfGv3
 eYwcWgIq/8vx9rl35SrM5OPGbgllYReg2l9hth5U0kA1G06BYpwb2ePsl3cUf2FiEbSd
 h0nsgObv2V0gCY7xHzzkdUZB61hCiFI1OsAGFWk1duaB5oo35Yx9YKZHWux8/gj8+nZ2
 /tDGCJyTKbPlm3ZhSjBLcEQE6S1zH+YI7QgVZiyjQAFhiVVx5RA+4r62D2SJFgDeKv1K
 S1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533847; x=1759138647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HhK8fyrcFTNAXAyMAUB3RJqIdZ7kdSjQMi97UpXe69Y=;
 b=oeaBLhqjI9oUax42WAZyw9GGMhRNALjbOYsYEuQSopzCRO4aaBpLdfw/nQh6X15LeS
 rU6APEQGKsQYL88oTw1DybYBxa/bJp8BMX34QMAx4gEQ7IAIRA7Wz32yS/BsiV7eHtYl
 LY/f5TtrqIrMDmdxcTW2IraYAWTS9RRftVX89ydBuKYieshdDJJvEgdPzZmCo8deBS2v
 UnI8hmckesPMTjCAf8nP/t0VVn3YdmKWJGmBbfAUShfddpjdnP164YTHmeANxyjJSE/M
 +AHExhFaxDWEH+bYC29Bxlv0/TimSzfLkgJ0pv6C8R+eg7LRRsNcvqS6aHn+ytfWIaS3
 8wqw==
X-Gm-Message-State: AOJu0YziPCpEDHSBMmMGYyva6eUvNhoibB6M0tfp/W0EH23gd9E2yHVO
 5uvj3casP3tXu+FkBan54FfRXzSiE8GzpBD6tXRzaWLRmpnOrv7fCSAlT4D4MkU6PBA=
X-Gm-Gg: ASbGnctmk9jpd3ZRAGLjYHVPQ7+Xx124YPknKnZ1pVyU30WYyOeBKKEl9trcrkjoo2Q
 pbefHX14BKfyY770/2CJ5wFvfR7fQkwzmY/QyO4Po/jSRnpkVZ/SUdsDbh8aXiSpB6k4CnYpok8
 js3ctt/40ABavWkMWSmEBVaTmgVgd+LAN6xLw9LxZB7y/SFpyfY084xk/gweilHfrgVaAH8cmyF
 MAy4MhBHKc3yNvb8zPJpsXIU/5yCxTOXUDKceAeBuqXCPcmYTWgxBDy8usfp/egG7Rj0Xv8+pl2
 Ub0izj74kd8awMJBP98rdAR6Cvy7XRdFiQJbTDYrP+TMURYoi5tXquCRanicqbJeDWNXjiTvbry
 5dVvJNh2cDt66GK89vv9pSV4=
X-Google-Smtp-Source: AGHT+IGvQykugjERs1DlA2LnPsomQf1DGNlnVD8bMHEgKSQkEZejic/RFQxHWt2Vc5BbiDz5w/FJrg==
X-Received: by 2002:a05:600c:a415:b0:45b:92a6:63e3 with SMTP id
 5b1f17b1804b1-4652c9ee679mr123352865e9.9.1758533847227; 
 Mon, 22 Sep 2025 02:37:27 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee074121b2sm19130261f8f.27.2025.09.22.02.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:37:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D9C655FA16;
 Mon, 22 Sep 2025 10:37:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 14/25] semihosting/arm-compat-semi: remove dependency on cpu.h
Date: Mon, 22 Sep 2025 10:36:59 +0100
Message-ID: <20250922093711.2768983-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, TVD_SPACE_RATIO=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-12-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/arm-compat-semi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 3c9192d8684..61001267965 100644
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
2.47.3


