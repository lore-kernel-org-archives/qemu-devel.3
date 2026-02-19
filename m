Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C53E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7fY-0005TU-QH; Thu, 19 Feb 2026 12:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fS-0005PA-JY
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:22 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fR-0000SW-46
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:22 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-65a11e565a9so1345833a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521499; x=1772126299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmOkyNB6zbICeYWYgNzTd6FhytcB3LOA5y9a/vnPkW0=;
 b=C9+w79Mt2oSFiUA2FLjfbpip+eOywc0L1ITI2/J9cUri7F3hnAxAIom/7yGth2/fzP
 WGtHJ3PCgmYfl3dtjucrEVS4Vi8BrpvTYXvkPfkgARHx2huCEjPtCuKx+qc2ITH83ArN
 i9sckLIkPbnjlXoLBgAvAGwSlBqP6xCdRq12SdYZ9BlMydeRaIKhFEW1F2Owc70QhbqF
 dn7WBs14I0czJlQaLCk1+u64TFNUuZVan3pUbobcjQ8A5p6AeIahGuB2CwA6WhHytBCX
 f3XsXVsUcAKyOJL1N+y3YDDKwho0k92gB1dhmYec4giIvqb3umkKWW1YQqYA1Vqpibyw
 ZSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521499; x=1772126299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dmOkyNB6zbICeYWYgNzTd6FhytcB3LOA5y9a/vnPkW0=;
 b=iZPUzGEIxsf8fXscmVirMARSmeuQE6ISfkXCL84g2oFLaVlNlN5AaLPKGb5S/a5jpp
 dkzCYlsmOuzvcPUD2xxDvlKcQo1k22anHUikmGJdrJkLwU41NoQmnuUaAtqcHv9dUBFE
 Ey/dc+ylrIHm+3UJalIvPM+UdkYpfs7T7rNHlOG6bw7cl3tKyQ5pNnaOzYmF6/A3pRmx
 URjp/odZ2lmO7nWXD4M/tNBObcDdmLXnQlTmoy9VwpRkqPDYiIdeL/P2ow16r6HJ+zHW
 ZJ2/NBtNHZY1OA9Xe0mUIbEQRET/KLnAU3+kc5/PMleKaauR71H8lxa+SndLaLGxNMXF
 LJsw==
X-Gm-Message-State: AOJu0Yw8UEbwRG4a+auuHiEAThzNbfWyBHHJZ5kX02A/4TaCnegTNkin
 P1xE2qBWyOi6uDZmgGkyDXl9BY/bCgK26ZsKG2dEBO7zXcfv/yGSrBh/bNUes4D0plo=
X-Gm-Gg: AZuq6aImTslp69y6iSa2iCWmEFe7jyZG58h4Gb/+RqXixsJkDnOigTZk4zJEZ0ruG+1
 apNbb4EqLSGtgIjyAJ8VXP4pKdX+qOniJSFVNHCbqUsnjPzwy5U3fDBt5dT4FFTdDICyvMmDN8A
 ud83YTPolB08XPkDbW7tVxBdfbw0/QO6xsNtuG1jYHsrO/sMvWsQMf8C0UPNFdPkItO9XKl5NPz
 FfLy+c8UXMqlVgEeWBECAzZ4QIE8bxyrGpd3MwNJ1+5fDu9JeiulRcpBX/zx3c8lNKeewYj1SNP
 QtXwPJ1fNNz40kPLFcCANefWwR9S2J+kMPQ2ZYQIEF4/KfR/nH8XD79PiZwnoM+YQGFJpXcCDni
 gFKGznt+iiaitTKtbgnjvEnEoTJoKIkFoADedXZZ2jvboGkWuHfCb6EHsdZQlIvj6iDYK0zdjqT
 V/YJ/C5xZrW7Pf6MJAfzFmIPi0XjFkJnTnVQ==
X-Received: by 2002:a17:906:7304:b0:b87:2abc:4a23 with SMTP id
 a640c23a62f3a-b903da90fccmr330924466b.2.1771521499273; 
 Thu, 19 Feb 2026 09:18:19 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc73f7c24sm599234866b.30.2026.02.19.09.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:18:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7BFCE5F8D7;
 Thu, 19 Feb 2026 17:18:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 11/14] hw/alpha: remove unused includes
Date: Thu, 19 Feb 2026 17:18:07 +0000
Message-ID: <20260219171810.602667-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219171810.602667-1-alex.bennee@linaro.org>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/alpha/dp264.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 5e64528431e..98219f04569 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -16,8 +16,6 @@
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/ide/pci.h"
 #include "hw/isa/superio.h"
-#include "net/net.h"
-#include "qemu/cutils.h"
 #include "qemu/datadir.h"
 
 static uint64_t cpu_alpha_superpage_to_phys(void *opaque, uint64_t addr)
-- 
2.47.3


