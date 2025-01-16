Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128CAC02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSLb-0003yJ-Uj; Thu, 16 Jan 2025 11:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL0-0003VK-Pz
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:19 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKv-0001EP-3F
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:18 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so10587815e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043392; x=1737648192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8J/ApKgPVXOVC7MF+COAj1wGpBADeRQ/mLFnBALjiW0=;
 b=Yb4wTeudy8Yguz3WYswrxs4fWhuRLKfRBMjTr9OCWkCggf1qZrfYUhimEeM+8Md3p0
 hMBdzk16DzCyZHRg1XbQv3ByebLYqaeRbQp8zCtACDx3sxHMq0QxtFQEjNouhdH9CEMK
 YVUeZKcNwrbX4Se64HXKXknC6J7SbWJRJYzvPJ56+1NWpNdcjFUVGPY3ZInybZAvJc+a
 apRvw9EliqFFJRIK0WczUKuZu/9+4URo0IhG/GfymX9CZZVvMp0EWWzIg6AaVE1i0KtE
 cQe6oxb8WLbUxeYwIvEcJ6UF1BgmMhgLm495FNdEqUaujY4BExIElmFvsU6jLHA02u98
 5gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043392; x=1737648192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8J/ApKgPVXOVC7MF+COAj1wGpBADeRQ/mLFnBALjiW0=;
 b=nSV4SC7+TxAKMZshe7cxHze7wwn5HumFWZ73fBkIOmSY6q9fUWsOGWBI1hv8NbCh+l
 1mzJhdTmjg9BDqpOHAJo1kVOaMKuLrcn9F/xuYAV/hM2nIJlOwwbhUgI8JsHV9veHITq
 FoVmgF21k0Lfb+7Incop/1KeuqX5QSqLHKoIkO0OApzM8EVf88RCphiuQYLJVrHMHfMm
 4/oKou2t7viPwcoqnpbWriBBgTT/3pYFInMDhE11z2Kbo4/1+T/XIV2geBBl3vVtPBUe
 cYrzRJBOQpnqSCuEEavLa1rkGXt0J/I0ZGFoPJI6fphiZZno8Lo+hiADuWPvZ+OLyU3c
 HDfQ==
X-Gm-Message-State: AOJu0YwhjY7BbGH280Gv4IcO/8vo3bTX09H9/5lwjrojGBG7gXFF5bF8
 NcG7b/ZRqSQRGA0eTvV5PfhKAqbQowSJYAadP3Ur9zS4LLBvUh8MwJ5HfdXAsjI=
X-Gm-Gg: ASbGncuKO0+MIGcKtdx1MPcKE/XhjOtWo54ZdXo0CSVrInkVMONt2f4CWiuodhPCnVk
 Zcc5QII9zOelQLWaMBsGpVkrV0pFEwtW4NKnrvv/7jJbbeb5lYWY+49yGOFl+EIkmxrIuwDvK3L
 meTdOje/revLtORMWUDjtp36arFI4csN/m6TTENDW03bICxABz5Vk2fx2orZOqdN6yu3cGygKZ7
 74yZc61V0NNxCF5f3xQbvmF9nQtTwullB8UEilGuVB4TOd3djg8H5Q=
X-Google-Smtp-Source: AGHT+IEXJP6WhKfmybODFvpPZ5nbovV5U/4AcpMTKNofhBEKP5Y/me8/u1USe1Q1sa7TbY0gPCvRmg==
X-Received: by 2002:a05:600c:4e8c:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-436e271d355mr314178435e9.29.1737043391368; 
 Thu, 16 Jan 2025 08:03:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327dee3sm195087f8f.86.2025.01.16.08.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DDCD960858;
 Thu, 16 Jan 2025 16:03:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 05/37] semihosting/arm-compat: Include missing 'cpu.h'
 header
Date: Thu, 16 Jan 2025 16:02:34 +0000
Message-Id: <20250116160306.1709518-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

ARM semihosting implementations in "common-semi-target.h"
must de-reference the target CPUArchState, which is declared
in each target "cpu.h" header. Include it in order to avoid
when refactoring:

  In file included from ../../semihosting/arm-compat-semi.c:169:
  ../target/riscv/common-semi-target.h:16:5: error: use of undeclared identifier 'RISCVCPU'
     16 |     RISCVCPU *cpu = RISCV_CPU(cs);
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-4-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/arm-compat-semi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index d78c6428b9..86e5260e50 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -166,6 +166,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
 
 #endif
 
+#include "cpu.h"
 #include "common-semi-target.h"
 
 /*
-- 
2.39.5


