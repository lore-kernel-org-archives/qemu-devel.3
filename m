Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D10C3ABB6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvU-0002YO-Ci; Sun, 04 May 2025 01:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvG-0002Mq-So
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:54 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvF-0004TB-16
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:54 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so3043451b3a.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336591; x=1746941391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KjypDvOEyLd05aeE7s1LeHvssR3Eurt4FNPjX1WjXo=;
 b=GYMfaXbiEGFSxocfsh2bfD3JMSw1f5wIaArjwIP2Aqdu/Czhv5cGgKpbaJVec9RpJW
 YOFVsGlvoG9b273PUWyiVxGdZ8LAXVGYO6YmYgvs1SFH9UuxonMMcia3GtOEl3VEMwac
 KuQdsO9vbniX8YP6MnGMZyKVe2lTTV9HVWF5yZfOzHTYMqjN2XDesIhLhr7Korz9EAFv
 TyLGUurm95aUwgZS9hVfs6aNsUSTXa1d8hJzahOrjWOhKhkUMW1d/8i5VsLeih5BeRrV
 fUpPQ6uiZPPCusv6sUOfI9/FtfSZl4K+IfXAkTjHyzgt+VgcJ8ZDJ0xt07xK1CNM0hzx
 7nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336591; x=1746941391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KjypDvOEyLd05aeE7s1LeHvssR3Eurt4FNPjX1WjXo=;
 b=bnFu//mwzScXdJtKS1vgop5C/bJTz6XEZ7S+JqdVQXxXBNPErIlq0CPo22H1gneBAU
 KTQXNTA18J3G2aXJgbqYrS1pz32OBuXmjXpiGB/D3eptPZv5TpUKPHN3XZlIdRQKScHr
 oKcnMl7+aa+yiGs/0sXN/53craLe3nz8sms+1YW9obmYbJliNoU8OX63h8ReAo1s6JOv
 NLYBeXhWlwBmKha99aT6T7RnELD7yVLvNL9KilsdywK2q4LVdvUZBhKUd1Xb7TNO85dU
 +7SnqJst9gM9Ok3pTfgrm+cmDm+mhCwHSkCZWVzo934o0wBU07F9ghgPfBxPnF+smRIN
 8rNQ==
X-Gm-Message-State: AOJu0Yyuy+My/+dTRcRc5et/JZQeK2GnwvIaIzwpSZ4M6csahCM2V4Mn
 1euVKc5KMYxRDDcUFMLLmY1mWnoXldRv1Nnmfhvl4tdIlQadRlW+HvLvcWW/lODIbzaddZSyR9p
 1Ca0=
X-Gm-Gg: ASbGncueqE7r+AIklSNQu2wFVn9plpRgYS1QiAPaKnv035IImCsjmZeqNHlB2T9AkYY
 P8xNKDDUr4HB8GP2lny7UdXWyTkN6w75g6ggb2Q/WE+PgFcE9MI70gxoze178qt8XPJ1VjTbQ40
 Pkg7SIblX+gdGNtYEiYYT55Qqisw+lSVa/uGgCcC5e3OHJdtPdCtqRJPUYXKekDnhK7jwG3i8oM
 2ZZx1sw8NWlDQvbWbSm7FYecSILjNFfQOt8Ilb+X17hHJ+rfR+ZjUphA+oMPtKF3Tlg5kydH/49
 IbwT3+9ko/9OpzkoJtxDAj9HOj/iZStpXyzxJs4V
X-Google-Smtp-Source: AGHT+IEHFx3XlGD3TXNpfIJs6MWCdr6hv+E8rDZjKYKBFe/d1SiWDCfxWojjHKMrjf9s3puH1FQGBQ==
X-Received: by 2002:a05:6a00:ab86:b0:736:ab1d:83c4 with SMTP id
 d2e1a72fcca58-740587626dbmr11929604b3a.0.1746336591648; 
 Sat, 03 May 2025 22:29:51 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 36/40] target/arm/machine: reduce migration include to
 avoid target specific definitions
Date: Sat,  3 May 2025 22:29:10 -0700
Message-ID: <20250504052914.3525365-37-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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
2.47.2


