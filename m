Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972C2C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVov-0008CK-4h; Thu, 15 May 2025 06:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnf-0005R2-6U
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVna-0008GY-Ry
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:50 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so6076055e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304803; x=1747909603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8z7jucKXgGdp5W+emuDqDob6i60dnbQ608/2CuYQdU0=;
 b=bYaLmkyxcwwI0W8DNiwcXrzgMKCOeMW/DGX1h/o9P8VlgN6wqx9KMZ+plTQTH5tp2M
 dPKFXxJbFAR7g7cTn92IWxexo2LK/T0pEkvR3m3C8ce2J+F6GHYBc2kWlk9u6rpmRUtp
 Nq2nUUBQNSgdH7hB0sjgls52xTK1ZLsV82P0LpPpo5grsa0EXGaUVOhZ1zo3UFjoWn46
 Oi64uQSc6HMOUu4G45V6wfumpVSfuymlrQhdyQdfjMO5macB5UwZC5A7H+MMZElNIF+s
 EO8knZ0f2E4ssVwKb3uQmTvfEc2GtSt768GhIi4uS1z9mo2SQnraqxsg8ZlpUMIyBJPc
 w0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304803; x=1747909603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8z7jucKXgGdp5W+emuDqDob6i60dnbQ608/2CuYQdU0=;
 b=ezUEhnlPoFr+GGIr1vd4BA8SzS98hjIoN5LjLuJyLhUzvBs9mDa6f6dpkzzMXmMN0H
 fsd27ziJ59MBZOvPMhlpPNf2IZVB1Dns0LIN2CWkVujIiLGsKD00GEOK8KVP0JvdycyC
 BVDI3JjG+H0R1ReeM07jA7S4b+9gu6vWVoNyX2DE14nbxqLfZzcrFjpS8iDynz7mxxSt
 2/qksoISYtOL7j1mZVwMnE113dfyhkP4MQPyRaKzfMlJVWVJ5Jf7DhD3n3c+IMzxIidB
 NS7kwchk89vkyLR386DA8o4sQIStIxP1fRPkBcV4ZDUf+esJwTgtrV089eVAIwT4XLRd
 zceA==
X-Gm-Message-State: AOJu0YzgWExoDhrisMC7xnSxOooWh5En2XRI/V4YrR/TTMWK+IeLRUuz
 Ps5QzhEBV1hefingLMxxy5gWVJ7WaLEF1GrxH8loAYDjL0j8RKPOCghL5B3WQYKgxK2mwpyJvjo
 hoJI=
X-Gm-Gg: ASbGncvjQWAcfn+2ygiIIjYjtH7Iv0duP+avUYeF9+OdwpNo+702tPM/kMwaoOL1Fur
 EsyvhIzlh6WPWyTuvZyfKPLNwEwAFS3vXdTlayqbfszlowJP/CggP/QC/UKudjT/sbHNJuqmi1T
 5rqYlhen/V64yeyTHp5L4s8xlqPt4WLjrCBuZchW20EGyLE3qhctvvXF/b5Pypv7Mbh8mCzkHp4
 etjAEhEjIS2Mp9JS8ZLIZZUdBZBEdShQDnEwiNsq79FTsn0I0Mamk+AOhgdsV57EOi//NY4R8xO
 weK4HnMlu8i4jo6Cduw6kCVI207Udtx6n3VPBawDqKNJlOi/wrzhXHZYrw==
X-Google-Smtp-Source: AGHT+IFCJ/S9Oycq1lKL8spbaB3qttDvIoxTnHwe8TdaMnKGjv1LpOYvWv6EQmjLQmA2/RiPdEMCVw==
X-Received: by 2002:a05:600c:c87:b0:43d:934:ea97 with SMTP id
 5b1f17b1804b1-442f9714ba1mr15179315e9.27.1747304803439; 
 Thu, 15 May 2025 03:26:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/58] target/arm/machine: reduce migration include to avoid
 target specific definitions
Date: Thu, 15 May 2025 11:25:32 +0100
Message-ID: <20250515102546.2149601-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-35-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 978249fb71b..f7956898fa1 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -6,7 +6,8 @@
 #include "kvm_arm.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
 
 static bool vfp_needed(void *opaque)
-- 
2.43.0


