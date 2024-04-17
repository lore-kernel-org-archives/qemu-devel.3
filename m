Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE114C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA2V-0003bE-FL; Wed, 17 Apr 2024 14:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2R-0003UT-ND
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:43 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2P-0003gd-Ty
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:43 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-571b1434592so25440a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378580; x=1713983380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksGtnbhVlkkzbu1KHQ/46hqlmcPyNdFy0jfCVGKxgOI=;
 b=tedQrk27GJnZiElldQ0Kl7ShTmWk9A6VKz61Xg5pHp7s2JJKlpT1Kz37Pwmz75IHQF
 LtW1LuezB4uIEv0Jbt0g07yvE8cNQnKlOVCZUnTV413aDr0cLPLw2/K9UFLQkZ8Hwuuc
 VFgnlaTMOEA0B8A9QLF8kpzfbk2d4znSscjm3hlzJudAQs+JnDtzqI973yqajLVSyBQo
 ypjQjgF02vkwPGKo9Rz1JC9Zxp0bm0kLVwfC09WglS+WeuUmYjEyip/xv97Sv+S54qQK
 ZfNceJyUUaqGmRpVS5sRy3nacSaOrXNDx+Er5RZxFEpEXxdfLM2Xq5l/1vrZUK7Xv/xi
 RKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378580; x=1713983380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ksGtnbhVlkkzbu1KHQ/46hqlmcPyNdFy0jfCVGKxgOI=;
 b=G5UDGFNWtDKdTt2hYCSSvXGEuzUe9z7cCbgk/ypTJGnqIBDBZxaPjPvzXCdhbH4/Re
 0yjmkX7p+rfBaq58qPBlmn4GEBqVshH/4OZsgXUE9Qj7G0MNn47EIa7utWBubABrI64C
 k2j7fqZRzaZVVE+SMMCtL+WfwG9/iaaLDJp/lpJ3Oog/CAmjsYGuwTe4y6LDiZf+1X2+
 JfX+yUOgM+C9UPeqOU86cNSy0TxaE0g8tDgeP5mS9RWmW9X767+x69fDFAXzts4qZAnb
 +DhaIBggcamkSR79dFRcTdgyODXVmTzwfrIfy7HI8SNoLdIhyDAwizP29G6sCHXcaSGa
 ENpQ==
X-Gm-Message-State: AOJu0Yz0Hy+pIGH7CCgXrdbV1kyac84VuxaZOg6bSMT7AvrIo5TTVksU
 GDVizqsoZLt+9DY+Z6Wc65L2K19rd/R3X5QMxXj5QGVye/wXiDh1WqytqjH7kXAmcYMfSy2PqwI
 M
X-Google-Smtp-Source: AGHT+IHIzCzepga96ak97IGhu63EH7tHHuEds0s/CDY9YCUJF2OWBF8l4ROsD8aNLo+Eyybg0PAO+Q==
X-Received: by 2002:a17:906:f0c8:b0:a4d:fc83:70e1 with SMTP id
 dk8-20020a170906f0c800b00a4dfc8370e1mr191938ejb.56.1713378579838; 
 Wed, 17 Apr 2024 11:29:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 la12-20020a170907780c00b00a5561456fa8sm724253ejc.21.2024.04.17.11.29.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:29:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 16/21] exec/cpu-all: Remove unused 'qemu/thread.h' header
Date: Wed, 17 Apr 2024 20:28:01 +0200
Message-ID: <20240417182806.69446-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

Nothing is required from "qemu/thread.h" in "exec/cpu-all.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20231212123401.37493-13-philmd@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 586dc56d9e..4de0d5a0d7 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -22,7 +22,6 @@
 #include "exec/cpu-common.h"
 #include "exec/memory.h"
 #include "exec/tswap.h"
-#include "qemu/thread.h"
 #include "hw/core/cpu.h"
 
 /* some important defines:
-- 
2.41.0


