Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E801C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvav-0000At-FV; Fri, 02 Feb 2024 10:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvau-00008v-0T
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:44 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvas-0004RN-Bz
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:43 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50eac018059so2770019e87.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888200; x=1707493000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=90Q19bchD51USuhMKJ6oc+v8LKqSGaGapSq6FK0X6bc=;
 b=UlaSDmyX8ijizOgRy2fP018Ugd63Xo7W9rx3XUe8WlwUTHd1D8X8ro1mWe3kMD3wWY
 3RgBDVjpQga5U2HezKazlR/IkAtO3IvnISzsCYq3ijML1xOoXi6fKRBBrFO/WGriwjz5
 iLQ4WmKORkBmWuV8DQDO0+08PawOjEAccYvHvtRj27TxUZZQEKwiKqre+NtnS36sl9B1
 uFZY8f+boWAKB/T5LizJi7RN6nYTSvFo1g73tLtlWyq4vExzOCH+ejvpDkz+Fi8IKPIz
 UoOY4lJInxHtdBKgj+X/gro3l/3TIvSsaVnAH13h9i8yv1wkKdkwodkY0UStIM2kWU8X
 CPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888200; x=1707493000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=90Q19bchD51USuhMKJ6oc+v8LKqSGaGapSq6FK0X6bc=;
 b=SRjBb6zzedbscSih8zq2+Ua+Et5Ak+0g8ZkCjd6yGwm+Zuvk868PX896xolPAI/AMG
 kLRSywVJvhwNa5+U4PV609aN/ZafWRkr39ZAGd/julhh+zz7jNhk+lOBRATer9rnrDLz
 IP+Q1plasiIpaqTRqhOlQ8zNpI4Cg1SQrieDHKev6cjLD18etm/uGHkXglh5ysA8RKTl
 7P6tCLFXKKcZ8+JlXJmJpIpiJwVrQI447u4casRs/kr7hpGEbnEWV1oVkAQEUL8mucM3
 ozrdoU/ZSvLbpP9Jjcg9ptsdia4wrGItlSyMihBVx88n6TNEpx0osRuGp1J09G+9CxkJ
 Cuww==
X-Gm-Message-State: AOJu0YxHxOiaWX/wvsL3hXD3Ha+bfBX30X3dm3A8WAhJTSkHCdVf++8O
 x+jiRlJfVqcTWDV67f8HyfHTOWgMahAUsHFUvObdUjO4P73I6QLaGg3S76XuS+cS7qNTxZ5UEYd
 l
X-Google-Smtp-Source: AGHT+IFBDYiBD9rkr7X7DA90g1gmK9qdSHDYwfljVwgp3MpPyLu9YL36ld7IkzDw3oHk6yxAVeEz8w==
X-Received: by 2002:a19:f81a:0:b0:511:e8f:45ca with SMTP id
 a26-20020a19f81a000000b005110e8f45camr1680573lff.31.1706888200760; 
 Fri, 02 Feb 2024 07:36:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/36] adb: Switch bus reset to 3-phase-reset
Date: Fri,  2 Feb 2024 15:36:05 +0000
Message-Id: <20240202153637.3710444-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

Switch the ADB bus from using BusClass::reset to the Resettable
interface.

This has no behavioural change, because the BusClass code to support
subclasses that use the legacy BusClass::reset will call that method
in the hold phase of 3-phase reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-id: 20240119163512.3810301-4-peter.maydell@linaro.org
---
 hw/input/adb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index 0f3c73d6d00..98f39b4281a 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -231,9 +231,9 @@ static const VMStateDescription vmstate_adb_bus = {
     }
 };
 
-static void adb_bus_reset(BusState *qbus)
+static void adb_bus_reset_hold(Object *obj)
 {
-    ADBBusState *adb_bus = ADB_BUS(qbus);
+    ADBBusState *adb_bus = ADB_BUS(obj);
 
     adb_bus->autopoll_enabled = false;
     adb_bus->autopoll_mask = 0xffff;
@@ -262,10 +262,11 @@ static void adb_bus_unrealize(BusState *qbus)
 static void adb_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->realize = adb_bus_realize;
     k->unrealize = adb_bus_unrealize;
-    k->reset = adb_bus_reset;
+    rc->phases.hold = adb_bus_reset_hold;
 }
 
 static const TypeInfo adb_bus_type_info = {
-- 
2.34.1


