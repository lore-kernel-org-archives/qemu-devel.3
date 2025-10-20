Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59EDCCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyAa-00008v-Q6; Mon, 20 Oct 2025 18:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyAY-00005u-Vn
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:15:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyAW-0006rc-J7
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:15:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so38520225e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998555; x=1761603355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eo3UgtAdEdwyjKyHbEK//0VcKmTQS/OavLgbol+Y870=;
 b=R/EuSD+dqIwCjULXCZ0WqbForVywPU25ys8jsh8FlJXqS9V8zzaKIhEligmnn50v0N
 2sdmxFSBnkByfN0GifzJrG/RLTH4pUcDNjx9YGsY1f5iVksKAGkPTnhoBhjpNe9bUbn0
 Eskp5Zz5+AQwCfD84F36L46/r70CJ8gATW2qi0ka03XTGAzpb2hagaJi2QXnBC7L+bnL
 b810/UGlgpiB2qMdhdXI1J/VRsHbnpTmz4NHYY5DuYoYEoJaYmfHaFmFtDcAn2KWv+7I
 pKhOEQ4INm+JcwS8TOv5+a7awU8eAPP9d9SKFzcjdFI4Pa+B2HAFh3tM3Z3kbJwnLI/k
 UimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998555; x=1761603355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eo3UgtAdEdwyjKyHbEK//0VcKmTQS/OavLgbol+Y870=;
 b=bgxONnN4Ksqf/o9dD+SdvZSq0RPrSQFg0ZGW7Re8F63C06YPOKD8no0YtmwMSw6KeH
 UisK2YO4Cd4Ex9uNPE+TDlfXkezhatPhUp54EnS7zw9m2Yt9WpChfLFzkqzBgNLyssYH
 +OQczL15lbVqTv1bqW+RcZR/YFeAUpJ8gscR/8QfQotHTDrSCvUmBf4CbslKX8+YyqMp
 9UW+f7MzqTDm2JlwZiYsHq0cMTnMWokD/EWaAyUaNYGBjKfCmWW/ttLC7AogV9iZ5MNn
 pn2xbDwSiUbfAlGkIzkfRu5uvDANVaaeSPUSnOrzcaU1DwsrHVKye78yJILc/VzqJwsF
 wCbg==
X-Gm-Message-State: AOJu0YyqBjoxaMVtDOhLnaIhtOU7RVxXFwd8B5AwewhSiCKUsLSmKhzS
 m6slgAW3hSr8+VJBizmOixMM7dHvPRqvkTbA1CLSmGE1Mg7s+UJMD9Tti1BegLhvNl3K51Vg1BQ
 E+QrhWhw=
X-Gm-Gg: ASbGncvyCjPLq9Z2Ky1WrN9aNQDt7aCsBogv7Soz4QyV6HsjmQ+lN0mjm3JwrKh59b6
 okC3/l8+asyyPoodbo2hjm0+zsLLX+Ik4EPOUXvj9AWaG9C6AtEjOuH/mp5jqjmxiFJi+ZgERnS
 C2rMk++6/dhCOyZFUVlmCfiyQff9tVFRf8nlI7BN8eOrtylEZmlX/myAp5eqJ6oEezXFVtk7ySP
 e/o6trgZWOwuiQpJmOvdskqjxpYyD5TJbeveftlLjBGvb/PIw2u7/FRwHsyNC9vWU3N+i26F1u+
 jlIBVJZVrSpYswNjpa4D+BJEJIFNnPXd+m/sf65xIAxnpZqH4XYzE5PuJ6b7L59nWncBhHTQDU/
 bRiAL17qQp1R7vNLIHObb88Dsf8ldd1784cPHddL1b9qjDV6rR4czQfSy9fJhKy46+NmigCbM1O
 Cvd5cycV7sORqUGJQD4dIQKt4ZhDTkskZ7vrRDglz+Q2qtB6DktB+xfZ55UDvK
X-Google-Smtp-Source: AGHT+IGK7h/o1pZ/D+WCHruL3RMbEn2pOzxxEMW5kyzhfZ3E/SNwhZ1IAYXYYyqtsP4hVXEC+jWqaA==
X-Received: by 2002:a05:600c:34d0:b0:470:fe41:a93d with SMTP id
 5b1f17b1804b1-47117874cffmr107922985e9.4.1760998554809; 
 Mon, 20 Oct 2025 15:15:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9f71sm17264792f8f.37.2025.10.20.15.15.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:15:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Subject: [PATCH v6 24/30] hw/arm/sbsa-ref: Include missing 'cpu.h' header
Date: Tue, 21 Oct 2025 00:15:02 +0200
Message-ID: <20251020221508.67413-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

"cpu.h" is indirectly pulled in by another header. Include
it explicitly in order to avoid when changing default CPPFLAGS path:

  hw/arm/sbsa-ref.c:162:25: error: use of undeclared identifier 'ARM_DEFAULT_CPUS_PER_CLUSTER'
    162 |     uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
        |                         ^
  hw/arm/sbsa-ref.c:163:12: error: call to undeclared function 'arm_build_mp_affinity'
    163 |     return arm_build_mp_affinity(idx, clustersz);
        |            ^
  hw/arm/sbsa-ref.c:746:25: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_DISABLED'
    746 |     sms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
        |                         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/sbsa-ref.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index cf6e6eb208a..2205500a8da 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -52,6 +52,7 @@
 #include "net/net.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
+#include "target/arm/cpu.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-- 
2.51.0


