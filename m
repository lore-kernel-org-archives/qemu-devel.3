Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42BFCFC287
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ews-0006jy-Jg; Tue, 15 Oct 2024 06:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewV-0006dm-Ek
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:19 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewT-0005wd-4u
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:19 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so3479928f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988695; x=1729593495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rL5/U4uh9bv7IicrualfqLWImO4ti0x7c8RykzNbskk=;
 b=bbhq79P+2Qe+a76FdrM1k4tbQ20J0wd9Vzk23INmLTEb5lVLgyjdLhwIbIMZOxs4YF
 w0brqTRtoTj6ifHqeoeKMMN/NQNEpQAvIiCEy3PtznuYnIWDC6eIJkW38AR1jQAb0Wt3
 elJ1rKhsBsykhzdxf1NWg1+o442IoYOauGmWHYt/ugLX8xOs/kGGs+rSii5COqiBOvNS
 pvSr6dNwtw1HUT4kHqY69TZvPse1E9G+vt7hr8Myfh82GzV5C70NtDytzCXpEDrFzGTi
 hDdPBHSqcVnua7nfsExb0KK1fAzdipAb5BFlvgk7NN9KuQ+1mBwg+09lpR3QEwrDxM2o
 rxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988695; x=1729593495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rL5/U4uh9bv7IicrualfqLWImO4ti0x7c8RykzNbskk=;
 b=JryUUt8pL/6Qfznv27olgtfAORdnyzQFpAKeBEewS0tqMpPNnyxy5HtT/pNhVN+tCY
 pRBDDDLOh36jzT+ibQsaIIkyWU9pd/xoE2lcLZrLFdWYNxIM0CeS828xLgbN6usEgjCZ
 WRrZagv/PH6I2GUDC4kUr5Y6ps7IUGYkqCq1kCyHGhrBPY63631HsKGkQHXPH4/GYVrx
 dLZowqsH2J/ek9tFlmzmgl2kZHBquMpYdpV2LaAQ5zxAexxwfwEm/A5OarUpoqi/IgAA
 4xVCAmlOq6Q7/BAKsuiSXZwq+od9lfg875X+Nuz1QTNPpRYaqiPfXXRMhZh8MyD4kYFv
 TOXw==
X-Gm-Message-State: AOJu0YwZZNdsjtXcdSWVXo8vbZVuSiULGJzxXlF/QrrrnUtvoLLMQJj+
 v1apPscQg08f+v+l4n2AJDxPiRF/4hxbAN7Qs2W+78d094fMyWDIps1d/cqE41WVotx/LaDpKFb
 a
X-Google-Smtp-Source: AGHT+IE+TebzO9ZVz4nPBXJ21FOwtzXNpMpB5+BsPkVM8g3R7mtaWRrCc3/Er8eF616vdJ6S45feFg==
X-Received: by 2002:adf:ecc4:0:b0:374:adf1:9232 with SMTP id
 ffacd0b85a97d-37d551fe43emr11843270f8f.19.1728988695490; 
 Tue, 15 Oct 2024 03:38:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/28] hw/intc/omap_intc: Remove now-unnecessary abstract base
 class
Date: Tue, 15 Oct 2024 11:37:52 +0100
Message-Id: <20241015103808.133024-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
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

The OMAP interrupt controller code used to have an omap-intc
class and an omap2-intc class, which shared common code via
the abstract class common-omap-intc. Now we have deleted
omap2-intc, we don't need the separate abstract base class;
fold int into omap-intc.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241003135323.1653230-1-peter.maydell@linaro.org
---
 include/hw/arm/omap.h |  2 +-
 hw/intc/omap_intc.c   | 13 +++----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index e1b6a7cdd93..420ed1d5735 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -59,7 +59,7 @@ int64_t omap_clk_getrate(omap_clk clk);
 void omap_clk_reparent(omap_clk clk, omap_clk parent);
 
 /* omap_intc.c */
-#define TYPE_OMAP_INTC "common-omap-intc"
+#define TYPE_OMAP_INTC "omap-intc"
 typedef struct OMAPIntcState OMAPIntcState;
 DECLARE_INSTANCE_CHECKER(OMAPIntcState, OMAP_INTC, TYPE_OMAP_INTC)
 
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index a48e6fcd6d3..a98358d92e2 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -392,22 +392,15 @@ static void omap_intc_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo omap_intc_info = {
-    .name          = "omap-intc",
-    .parent        = TYPE_OMAP_INTC,
+    .name          = TYPE_OMAP_INTC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(OMAPIntcState),
     .instance_init = omap_intc_init,
     .class_init    = omap_intc_class_init,
 };
 
-static const TypeInfo omap_intc_type_info = {
-    .name          = TYPE_OMAP_INTC,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(OMAPIntcState),
-    .abstract      = true,
-};
-
 static void omap_intc_register_types(void)
 {
-    type_register_static(&omap_intc_type_info);
     type_register_static(&omap_intc_info);
 }
 
-- 
2.34.1


