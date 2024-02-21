Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C20C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctxr-0002io-0e; Wed, 21 Feb 2024 16:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctxU-0002Jd-AZ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:16:53 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctxS-0000nt-2Q
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:16:51 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33d754746c3so904255f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550208; x=1709155008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TRvCQivHf+BGM6I7nL2pwFghFnMYw5aVlLSb0J/9JI=;
 b=qsM2Tz+ldd3LESpb8XP0unrIoiDe02oSiS82cEthbN3bIOm2BDEdguOyOG5NGF/Uoj
 ewL2t/sU8008nHPzSPb951RnpGsGqR/HCQ+1dIXsDn3NLat/0X9XCphhUkj5mcM3VIqe
 CBvkllWdlxVcNufvPBAfjOtenFYy81ESfie9jTSIX5u9k3aV3/MU+eKof5PhyNlBtmC8
 DDqwqTBC4/6bLSsdHURy50y/Df1HfepHYPtgjpOr04chg3hfF2QS2Jn7A2RQLVwe3obs
 NYAaIa/gnx/p2astKirRsbREcmmmlv9A4e3PhTSefmDDqzu93JrObr22V8MP0Wg8RAAZ
 NZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550208; x=1709155008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TRvCQivHf+BGM6I7nL2pwFghFnMYw5aVlLSb0J/9JI=;
 b=KLLv/IBvWKFAa6NMO1sT7AXLZOdDqc+RxlMPgYdwe31awNC/FYT5nkGIRBBYJndwL9
 52NbGeFHa1qUMFHLL5vIFMMjPP07kSB95XiQmbeQz4Crw3PUk2h1JjvtM16EPqOMLvkb
 Ak5Fykp44KlAZie4rQWIxhM2XyswxcHkH27jaatyCOJCVBI9zLajtb2MbTHlq+iVtV8D
 WuNokUMXWvRsF9RJdFoJCMqStHOuRlZ6EEgB2PmQuqxCXTuoppHZicRQmSZEnJdhcspv
 iApGu7UqF26KMDuctabfFF/2jsFNJQzFiXRGwvnKCzGZ0sZwgzqj8IZ26ce+KbeMN3d2
 nKQg==
X-Gm-Message-State: AOJu0YzNJTdrIvFa33M+msRD3q304EXrLZfhh0INNbE3rqqnHxmaCzVy
 nLImWJ+L+CcOntQRs1/OCNRMOpg8vRYXeTysfxYpgFPXJfb+7Qs6JDQd7JrdhGdJVApYM2y/+b3
 M9ZM=
X-Google-Smtp-Source: AGHT+IGn40VISz0MoY5N54dub6kmN0052LjSmpVsUYPBoY/I1KpXQoVxJlZwtR3JDddHrS+mN6yAxw==
X-Received: by 2002:a5d:64c8:0:b0:33d:545b:a74 with SMTP id
 f8-20020a5d64c8000000b0033d545b0a74mr10313634wri.33.1708550208078; 
 Wed, 21 Feb 2024 13:16:48 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 ba20-20020a0560001c1400b0033d640c8942sm7735486wrb.10.2024.02.21.13.16.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:16:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 03/25] hw/ppc/ppc4xx_pci: Remove unused "hw/ppc/ppc.h" header
Date: Wed, 21 Feb 2024 22:16:03 +0100
Message-ID: <20240221211626.48190-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240215105017.57748-2-philmd@linaro.org>
---
 hw/ppc/ppc440_pcix.c | 1 -
 hw/ppc/ppc4xx_pci.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index df4ee374d0..d84418cb7b 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -25,7 +25,6 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 0a07aab5d1..e4101398c9 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-- 
2.41.0


