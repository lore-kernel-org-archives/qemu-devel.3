Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C8EC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 21:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CP9-0002zr-6Y; Sun, 28 Apr 2024 17:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CP7-0002zQ-7u
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:49:49 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1COx-00015O-Nk
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:49:41 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2dd7e56009cso49990471fa.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 14:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714340976; x=1714945776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k1ZHl3KtBDD8F5IDAshvr2j1UwCpx77YSs6aZ7LDCz8=;
 b=eSsCoJgtJrrbbaCiobU/F+gaM1SxeSHnOubz9LwuzdxLe58P8NSbIJocJFGjdT/F2P
 JblTEaVJ7WK+r9qudqstgUZ5etE29zMH5X0bpQFGSjE/ewCVBTn2/4Q5s9peTFA8mZxk
 eq5otZ0vvsHi07KEIkRMHix9vxePga8eJcIZ9K2ZZhf/pPKIOH4Li1KKtcdQ11gAalaz
 ybGi9sd1UWfP5DKe30uYPUQ4BMdk7yuwixaSpdR8HYplzOa01x6BfjxWZBFKr8T/rtD7
 3X6mrn+wiVdujBH73K68FgKBQo411Xv0XJ9k9gOATyk+tQ9118uHYiph7ad+DlpTMBML
 l/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714340976; x=1714945776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k1ZHl3KtBDD8F5IDAshvr2j1UwCpx77YSs6aZ7LDCz8=;
 b=gvBw+dxaek1HVGqAAsJBNAOe5vQyilGzKHtG4qA6knYXEHe9+2L6JBGOQEWd17NsOW
 xkLfMzJgf/EFGV+vgNsiph1Oa1gtnwWRTmQVrFoGuUCx9/Qo3ykwStyL4jmiH3nMduv/
 h0wqdLh1Bl/EQ23+37b5RAEF5J4FCqqn6Bg3AA8iboRIpN7TbvuzsrSrno2Hm70j13xx
 3CDwVv51hxhvMeQihjSgK8ZnUDnaQUJIdFbmA+qEpJNRUeBezfg9xGGl5/2adGDmrXKe
 9BcaU1ZAyiKfpvPj6X/gEJM06QlF9F8THtCUdyCZhs+XpMWClS0LdhVIS4PbRkXvuL6s
 DGwQ==
X-Gm-Message-State: AOJu0Yybi2rVUz4jtYfqRTvfjOsC8009pHdCAInyDE8Ly53rTJdvt8Iv
 i/Ayn26olrvs9ZPQxKeHO44Tm/BKGamK/4GLyoEbaR9w41s1/Ti+TkgZfocOM73Q9MNjrRsVh//
 q
X-Google-Smtp-Source: AGHT+IEEiPdLLqp4VDqxPvm2+eEmueoWGf0uXMTr9KYFMjNMi0dw3NJHQjI6MMwYmshDVNeRjPGPrA==
X-Received: by 2002:a2e:b8cb:0:b0:2df:f11f:cf79 with SMTP id
 s11-20020a2eb8cb000000b002dff11fcf79mr2482741ljp.51.1714340976175; 
 Sun, 28 Apr 2024 14:49:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 ek17-20020a056402371100b0057266474cd2sm2330638edb.15.2024.04.28.14.49.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 14:49:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/12] exec: Include missing license in 'exec/cpu-common.h'
Date: Sun, 28 Apr 2024 23:49:06 +0200
Message-ID: <20240428214915.10339-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428214915.10339-1-philmd@linaro.org>
References: <20240428214915.10339-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

Commit 1ad2134f91 ("Hardware convenience library") extracted
"cpu-common.h" from "cpu-all.h", which uses the LGPL-2.1+ license.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-5-philmd@linaro.org>
---
 include/exec/cpu-common.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6d5318895a..8812ba744d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -1,8 +1,13 @@
+/*
+ * CPU interfaces that are target independent.
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1+
+ */
 #ifndef CPU_COMMON_H
 #define CPU_COMMON_H
 
-/* CPU interfaces that are target independent.  */
-
 #include "exec/vaddr.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
-- 
2.41.0


