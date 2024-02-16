Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9E5C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw0X-0006TQ-Gu; Fri, 16 Feb 2024 06:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0W-0006RK-5J
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:03:52 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0U-0000tB-2g
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:03:51 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412345cca4eso7136985e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081428; x=1708686228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuItVagnX21LnnaFpIrCDiEh6nnybH9GKoEtwiotckg=;
 b=zNIr7y0EqNB2slVEoVD7JE/EWg79kDhOfze+vjPAGjuJ35R1MMLkDxzeIG9MuY2uTc
 teic7TqLhD7U17NYex5MxbWWKRrFY7mLll2gs18eQ5pdqS7v0IZjK4k8TuExWAyN1WYP
 ETooz96kVf67wAqZhv05YpAwLvvO3m8mRkWsXrb1Fll6N4/ISmgIsINOmYod0EHbmJvJ
 NI2JTpSHqi7DDFPc1+hnuylXIkr1dBEv3bqdc9IybqRfoMtGwKjIQcLII3Qo5Dy6hvih
 +jqIQAzq3wnKZkwCzefgEewZxjgxR2LZfedaGU/EDu+x52xWs9m8iPkpXEM/UqNteDio
 lEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081428; x=1708686228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NuItVagnX21LnnaFpIrCDiEh6nnybH9GKoEtwiotckg=;
 b=iF11jaQZNJSJKJtP/V8da8L8guObVERNqzDfnKf950D29Kj4L2EUz8ThzTRT8Fz+XW
 /OThyhT+QVYEKuVEQYmtZjcCdW99aPE7dWqbIH+xxldCKiH2I7cS1AeF5ihAw7A7MU46
 52zRuZIL2sYReVKEYJc8w9Vu04pEqHTR9RuGCIC5j2GhZweUNlv5te5+VGeCPpqBE8qh
 CJvRZiWVXk6mWyaP05yRsd4Gtcltg5tq+gQSTB92/2w1SWfud0tOsZhT1mYphWZo49Pr
 aQsLbx7yNwsHkv33Zne8W03QMw8AWBAhWTgSAI3zmlDoOQQetd7qxlErS5pI4LdaQsoH
 vIrQ==
X-Gm-Message-State: AOJu0YwQTJhp+6qZJBnJn1I+0OTiyoBmfgV/T2ARK67rZvggMABUEOt4
 SXwmyX+1x5jefWNiqLFq/9/Q2fDmLqmQ+MlOGzmpoGP6jzyH0ZPxzciVhrzVOPJM0HKJBvL6zKb
 Y
X-Google-Smtp-Source: AGHT+IF1rjUpQD9NjyQ+iWSd2ftr2L4Qc5BBAPfLtU5QmVd9bHlSq1HNudg1PtEIdKHsOlgDeHuqIw==
X-Received: by 2002:adf:f34b:0:b0:33c:e1fc:65c5 with SMTP id
 e11-20020adff34b000000b0033ce1fc65c5mr3642680wrp.69.1708081428352; 
 Fri, 16 Feb 2024 03:03:48 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a5d5184000000b0033b4f82b301sm1942603wrv.3.2024.02.16.03.03.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:03:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 05/21] hw/ppc/pnv_bmc: Use qdev_new() instead of QOM API
Date: Fri, 16 Feb 2024 12:02:56 +0100
Message-ID: <20240216110313.17039-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Prefer QDev API for QDev objects, avoid the underlying QOM layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/pnv_bmc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 99f1e8d7f9..0c1274df21 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -269,13 +269,13 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
  */
 IPMIBmc *pnv_bmc_create(PnvPnor *pnor)
 {
-    Object *obj;
+    DeviceState *dev;
 
-    obj = object_new(TYPE_IPMI_BMC_SIMULATOR);
-    qdev_realize(DEVICE(obj), NULL, &error_fatal);
-    pnv_bmc_set_pnor(IPMI_BMC(obj), pnor);
+    dev = qdev_new(TYPE_IPMI_BMC_SIMULATOR);
+    qdev_realize(dev, NULL, &error_fatal);
+    pnv_bmc_set_pnor(IPMI_BMC(dev), pnor);
 
-    return IPMI_BMC(obj);
+    return IPMI_BMC(dev);
 }
 
 typedef struct ForeachArgs {
-- 
2.41.0


