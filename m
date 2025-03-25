Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08044C3ABA1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwQe-0007Ra-RF; Tue, 25 Mar 2025 01:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwOE-00043s-U5
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:50 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwOC-0005zo-W2
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:50 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22398e09e39so103657585ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878787; x=1743483587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSiomrkJehve/L+8sWorbqlbLNaYCEo3w/Nkej8WFsU=;
 b=Cw+E+607MIzPDPX+py2OuemTddAf88SPktnBytia09ew8OFGG0mwzi6XEOz2Q0h+Jt
 yyaQZHtREx+egFa9JmKy84c58TcHr2KjUiKa2B3X9kDspebYc7jfslF3RI5SHcc7dVrP
 7OdEJPJ3QbVaIsZbCeTIWliaCCWKmbPy/SRIIXo87GtaxQvFM8oisVIhwIaXhmR3LmW6
 YbslbLceU6mt4cDpHrsDQBEndmlwuzot83gxnPElNi8+rl5h6grBj/ixZgpDmCKgOo37
 66MaEtyBoIy9M6MtlZsT1Rq8EI1OldGR72ixAUSMKZXQIAFdUWgu11A+KO1U9qaeDM0w
 LHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878787; x=1743483587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSiomrkJehve/L+8sWorbqlbLNaYCEo3w/Nkej8WFsU=;
 b=UTjr+gvjKnkuujOa8+VSe6C80LkzAZtfdVAYHBKTlsg5BrxgRoDvtst3zsRYkTXVF/
 EHdRvxgYooNCbKxGhFdLZ+hwbP2ejRJwdWda0Hlvcj+bTbq+a5TEpuvYQ0syk2/wCtJ5
 6aO7ZI1mltiyMluQQqSJ29Iedji03/7tPX1Zm0zGTpuh8Y4R93g0EcUS6pJW56LqD05M
 y0ytjZq2pgR2DoPsJUa1w0BQhpn0pofOeQQHTEHsMn4SAFbGleWH/pPd04cBKjCxAIC9
 W4Ez/dDwnQd3iTfAzJWRUchnXJvaXMfWDoj5jgByIKUUJ1co1k7GGGAkzQoOYQVxbXgn
 qmig==
X-Gm-Message-State: AOJu0YzJ1o2tnF/DtBgLTtK8iB3t0dvtJtpI5OGiEQYN23GWmU9U5NFE
 RUlsShJg8vVq8FMlZ+jTEN45vQzvWIC+WAauVhqpV4is3Uo3NyKIGHIn6XuZvrYCg3gL986SBWV
 w
X-Gm-Gg: ASbGncsswgxsCtG9wZz5vEMq3u+uNw5DKF/q9is0sdEcg+Y0argMg87imE6ZuGtndV8
 vUY19DBh48aYjc9dZgu+mj1RR32pN2M2G92XoQh/SgwdKTURMxTPmZ0VZns4qRJOozPUCk+A7n3
 RIZ18hcNpnTmhPaExQ7VDooJ6tGore+UAn7K/uqi5IfJvvg9BCbFHKYGmJE6SvYaQZtda4aIkKU
 95ecxowYrvfx1APTpkXE+wkuucEv7YtsX2B8b8KFXKkqeHqITFGTMTOFVb0sj7PQHL06JVCMI11
 wN02EQ7M6sqfifx2im2cHtJVPHUmTMyMJga/IOryMYad
X-Google-Smtp-Source: AGHT+IE+CatLymkvFC6uB6GAY5APi0WQOW6EQGEeUyVT2LFSOsFWDTpOfPwIrlpBqEe5gBdtrM10Ow==
X-Received: by 2002:a17:902:e846:b0:223:5c33:56a2 with SMTP id
 d9443c01a7336-22780da6237mr279448325ad.28.1742878787203; 
 Mon, 24 Mar 2025 21:59:47 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 27/29] hw/arm/xlnx-zynqmp: prepare compilation unit to be
 common
Date: Mon, 24 Mar 2025 21:59:12 -0700
Message-Id: <20250325045915.994760-28-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Remove kvm unused headers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/xlnx-zynqmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index d6022ff2d3d..ec2b3a41eda 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -22,9 +22,7 @@
 #include "hw/intc/arm_gic_common.h"
 #include "hw/misc/unimp.h"
 #include "hw/boards.h"
-#include "system/kvm.h"
 #include "system/system.h"
-#include "kvm_arm.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-- 
2.39.5


