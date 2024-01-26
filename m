Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D244C4828A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHN-0002Tg-8P; Fri, 26 Jan 2024 09:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHH-0002Km-KD
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:55 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHF-0007xB-DN
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:55 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33921b95dddso1153424f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279632; x=1706884432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=STnpdxdBqg+D7O0t/DW+hSCI5CBTAErw95dM/Zpjin0=;
 b=A4CZHqLJRxtChmNlg5Blxgr3R9SYqdZAi/b3s4/d6TCgdcujBWHX4Zf3A6WNDh60jy
 5Z6VHhW9ZZgWFypOMrKcvKk078UwlRPpSmiWkHln7U6LcHtluFLvX7Rd+X8DVAqbTZtr
 Tl0rw3c8yskquAu/LrVZcOCCLlN7VwCbOV3DQzoi9Wue97A2bCDyMm762BcOEGmdDN6w
 mgVgO6K9oecWLPCBt2pZUXjc/MeGTu/n2TgD58OmF/XCqNrZ5MSV6pColJhgx9Wy4OxC
 6nV5HXO9OUlVZPrm8oEgs4aSfahzUA4DB+NoTUekTpgYzpl1MMLXGZk8EAVAmf5SFxOu
 up2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279632; x=1706884432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=STnpdxdBqg+D7O0t/DW+hSCI5CBTAErw95dM/Zpjin0=;
 b=U2P6Lmw1dMmlfnmQNqnVzmrVlSH0To+7MvssXbdFsPmJ0Lb1oKOiD7gO7W82ctwwNg
 HQHfk2DEk82P9CiZFnjt1qNfFSdFgR5m5/+7giaOIY39n3/I0dvLRBKHfAyN9aVxUu4g
 3c1mF5U06eJubeOVNO3U8sUImL6zPBRywhdjFwaawJ4j3JvkuQbtIINqJztmgs0aLBqg
 0l+QE6WZVHiyQqxxGNvX+lGShI3/ZVEFJs04bicG6LYTIMPJZaIS8Ei74Bpw6bvRsMlg
 VmQWyY8b79MMHNUGnq4i0ctQrq93uqS1VTX7u711KFyTLHOfT+RbnNMQUsopofjzN8F8
 WmtA==
X-Gm-Message-State: AOJu0YzLahPD1rDv180ZfAUzQPdRR9GW6c7xEJbeNeqzBPiaFNVn/hyU
 3xhuSmDkYFR6k37/RoP9fVeAd5eG0b91BypTHJOMmYhuQgNUtmemngLKgit7skUEu/43T+JwH9T
 7
X-Google-Smtp-Source: AGHT+IEozrV2gn/h4yKWScmgLGPMd1nC9i3lak6xrEo/I20bmEpJ+Dx4cU+YLvY+/u2vZJDii/lkMg==
X-Received: by 2002:adf:ea44:0:b0:33a:c656:b26c with SMTP id
 j4-20020adfea44000000b0033ac656b26cmr757908wrn.14.1706279632087; 
 Fri, 26 Jan 2024 06:33:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/36] hw/misc/xlnx-versal-crl: Include generic 'cpu-qom.h'
 instead of 'cpu.h'
Date: Fri, 26 Jan 2024 14:33:27 +0000
Message-Id: <20240126143341.2101237-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"target/arm/cpu.h" is target specific, any file including it
becomes target specific too, thus this is the same for any file
including "hw/misc/xlnx-versal-crl.h".

"hw/misc/xlnx-versal-crl.h" doesn't require any target specific
definition however, only the target-agnostic QOM definitions
from "target/arm/cpu-qom.h". Include the latter header to avoid
tainting unnecessary objects as target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-14-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/xlnx-versal-crl.h | 2 +-
 hw/misc/xlnx-versal-crl.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index dfb8dff197d..dba6d3585d1 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -11,7 +11,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/register.h"
-#include "target/arm/cpu.h"
+#include "target/arm/cpu-qom.h"
 
 #define TYPE_XLNX_VERSAL_CRL "xlnx-versal-crl"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCRL, XLNX_VERSAL_CRL)
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 1f1762ef163..1a596f1cf57 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -18,6 +18,7 @@
 #include "hw/register.h"
 #include "hw/resettable.h"
 
+#include "target/arm/cpu.h"
 #include "target/arm/arm-powerctl.h"
 #include "target/arm/multiprocessing.h"
 #include "hw/misc/xlnx-versal-crl.h"
-- 
2.34.1


