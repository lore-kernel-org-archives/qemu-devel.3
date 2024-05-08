Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220E3C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 14:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4i3H-0001Dl-BY; Wed, 08 May 2024 10:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4i3D-0001DL-Vt
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:13:44 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4i38-0004NL-Bd
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:13:43 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34da35cd01cso4078367f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 07:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715177616; x=1715782416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bPs0zsG9VK2wQ8xgMVPcc5ZG9na1Q66b8plpnDmTE4Q=;
 b=kNstpwFXfFa0JcEjWS3AuJQMfdll8UMKEVXLc6z8T6KehKhDCd5kqf/MDPsVisArYK
 HkK734C8+67MmF7TbFP9nXlzF53WBy42x7iYiwpLWepHxy7C56G3SMyFyBjMMLYaij5q
 AwTTQ12Sub4cUdxxt3SLUif8EQDekrJgJw0wxXykpcNcTh2O4WsK0BFsOFm0nK0RwXTx
 5TPVrJwJtnuXAbmTmJft06VqDkCfqn7DHc4FWQwlxOQZLLca8PznU4CNzyBRDfMx+bl1
 jb4AKkZMd5mHPl0kW+ncEwJDJu3LkeGB4UBqUDSlCJGHBa/L9Xe8K5FSK3q47pLitIyO
 Na/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715177616; x=1715782416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPs0zsG9VK2wQ8xgMVPcc5ZG9na1Q66b8plpnDmTE4Q=;
 b=eXMkoqrHn+1l+2GjNekESazq4RSyIY7NmWz5TgN+gaGx6uioIc2PTKe7Z/r3wWKr8+
 q9GyZBZfxYFzWHcchIAfAIGY+91MpHDEXkHwRtdB6zlCMOf0FlO+ce0eI9RunjY3JsRo
 4uP96IzmDVDrBxDJ3NGzMBnXmYiy8iTBQsZ8SNieIZ2iMf1dq7+dcH+E8v2HZsmTauV6
 pgPEDEXoPVTUnASsoOUQ29pcPH0FD32q34WsOkF72Cgz+AzgcfAh7UVUhP9FrM3qUybd
 mbcQPtVA684wwU/8JaHn8Wms+wed0veWcwU6SQZgJS5JP2kDymeEsXvE1n2eZpePSEOt
 w6iA==
X-Gm-Message-State: AOJu0YwDX2EbGlz7tW5lhPmDEyW0TjQYj7YhSyUx74qVYIwPsTDLEiuN
 IYb9XVfK8I+jwm5wfX+69sGNiwcBs9IqBvf+W2mZd9IcGEX/UP9WRoRds5mH26uGRbomIoCM+tw
 4
X-Google-Smtp-Source: AGHT+IFeFJ2JGx/ZmqmnLWoV4naAhKN//95DH/a/FJRlmyvlekEZnDKLAFljJJrZeKdNfWFT4+eRbQ==
X-Received: by 2002:a05:6000:1104:b0:34f:96ba:ca3f with SMTP id
 ffacd0b85a97d-34fca621dbcmr3321638f8f.53.1715177616129; 
 Wed, 08 May 2024 07:13:36 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 d9-20020adff2c9000000b0034dd56189e8sm15448242wrp.22.2024.05.08.07.13.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 07:13:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc@lmichel.fr>, Peter Maydell <peter.maydell@linaro.org>,
 Damien Hedde <damien.hedde@dahe.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH] hw/clock: Expose 'freq-hz' QOM property
Date: Wed,  8 May 2024 16:13:33 +0200
Message-ID: <20240508141333.44610-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Expose the clock frequency via the QOM 'freq-hz' property,
as it might be useful for QTests.

HMP example:

  $ qemu-system-mips -S -monitor stdio -M mipssim
  (qemu) qom-get /machine/cpu-refclk freq-hz
  12000000

Inspired-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/clock.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/core/clock.c b/hw/core/clock.c
index e212865307..55f86ef483 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qapi/visitor.h"
 #include "hw/clock.h"
 #include "trace.h"
 
@@ -158,6 +159,14 @@ bool clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider)
     return true;
 }
 
+static void clock_prop_freq_get(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    Clock *clk = CLOCK(obj);
+    uint64_t freq_hz = clock_get_hz(clk);
+    visit_type_uint64(v, name, &freq_hz, errp);
+}
+
 static void clock_initfn(Object *obj)
 {
     Clock *clk = CLOCK(obj);
@@ -166,6 +175,9 @@ static void clock_initfn(Object *obj)
     clk->divider = 1;
 
     QLIST_INIT(&clk->children);
+
+    object_property_add(obj, "freq-hz", "uint64",
+                        clock_prop_freq_get, NULL, NULL, NULL);
 }
 
 static void clock_finalizefn(Object *obj)
-- 
2.41.0


