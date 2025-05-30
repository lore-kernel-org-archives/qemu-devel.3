Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C5CC5B552
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBj-00027P-Ef; Fri, 30 May 2025 08:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBf-00023K-Aq
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBd-0001rp-M6
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so16862655e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609412; x=1749214212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x3kKI4mM/p5JRRckZQFndvpPTi2rdSmL7olGnoCn2ok=;
 b=iRO8YMUybiokN4eQbfUdoNZ+xEn6LaVdoN+721KzGe7Dlzue9cq7DNTzTnnzoMyZqU
 W3nWDoCIjqehOgleFSjXhqkgzOruwObrp359rZmTgk45Aah6ocFmgnfEJ0CcJb9hZz+g
 pIja0Z3GD5bPLWisf2/BjiJY4FUWMQ5fGVorLltK6NcXk7kLUmYIPcnobp9SWibO9JQj
 IUgVkeCDiy90GjAxJVH9UCMWYkp3KQBrCAHz6l3T0Ii0LEdo9ImqZrIpfu9u480cUTpc
 Z1gQFrvll2yC8r8jo+iyHZR6WRe8VLZn1yRfn04HsdmdGiODZU2C6pKxpwwsqIc7sPwY
 S0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609412; x=1749214212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3kKI4mM/p5JRRckZQFndvpPTi2rdSmL7olGnoCn2ok=;
 b=Pat/J63aQ3Ln7/4L6V5yCNJ+pM/bMQk5rZeSiiLrofM4VspjnegOxXutMPxWeYU1rm
 Ak2QvOR7cXKYVhdOOdpinFtI3EDWGz46cfJef9FQ7VKO0092G0CpszUPbZWzL4zut/1H
 bDS3hgHOnu1I5psXGPdz4J40rQEyZq/5m3iYNzGRhWeS117zkW4gKQW24jQeKTrnLfbm
 OYSpiN0CrmGTLNdyptD4RiCeV9UQFo/FfPUPKT1JsC3nYp0LUv12ev80UNYIxETM131b
 zoYYF9uMjEMHEAhKo6N7MygzkwtB//AJzvDsyz3UkQmXVUwZa42BYlIqwu8W8cVbctg9
 uTOg==
X-Gm-Message-State: AOJu0YxcwH/CK/RdBplHSbaI9YqcCnL9xxKcBXTcSy465EcwxPgq9QMM
 yie0iGDxhA9QkjlLiFZbKT38ptKl4r1kmxFNcUq/ZmCvNb9XMizovJucOQeiUQesjoIx0kfOmaq
 QpISF
X-Gm-Gg: ASbGnctwHeCzDc/vCYVK+12RawJ6f4gXskn7Tr+8vX2L4CaX82C/JrN+/TIsCPl38K2
 VmUJ0ouLZVaK7iEhEoST+uXFZ3dBQKIbjQzgmJHmIESahHaZOermH1gURep6n/ctw50C8ypWa/T
 Gg3mA6KIBF7co3huB2jFLMLxQfjM3F6bgocBJM/quwJRalXeejd75ZjG/X3KlXr1huQz1PCRohU
 GldvHAb8abZ01mWS8iutjFtZk2w5Pgs1mknh4lD0K1ngLEljA6A05zeiIUp0UF3EW8rzWnFWs+S
 I2nT/wl9ZgfyHnrSKb4AeruIjNX1dlsPjeVyAiFALwrW1mgTFYYGm3Pi1YjCss8NXHMG
X-Google-Smtp-Source: AGHT+IFNhGXiYkRYJ5vBlhiO3gKU/jJoHz+7BiS1wBS5N6ickdqZPB5HVSs39h/U7hkUbhC8TqDXvg==
X-Received: by 2002:a05:600c:8183:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-450d65518ebmr25102095e9.20.1748609412180; 
 Fri, 30 May 2025 05:50:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.50.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:50:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/15] target/arm/qmp: Include missing 'cpu.h' header
Date: Fri, 30 May 2025 13:49:48 +0100
Message-ID: <20250530124953.383687-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

arm-qmp-cmds.c uses ARM_MAX_VQ, which is defined in "cpu.h".
Include the latter to avoid when refactoring unrelated headers:

  target/arm/arm-qmp-cmds.c:83:19: error: use of undeclared identifier 'ARM_MAX_VQ'
     83 | QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
        |                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250513173928.77376-8-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-qmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index cca6b9722b2..cefd2352638 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -30,6 +30,7 @@
 #include "qapi/qapi-commands-misc-arm.h"
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
+#include "cpu.h"
 
 static GICCapability *gic_cap_new(int version)
 {
-- 
2.43.0


