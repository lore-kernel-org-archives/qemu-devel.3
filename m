Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE40DC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvau-0000Aj-T2; Fri, 02 Feb 2024 10:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvat-00008F-GF
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:43 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvar-0004R9-9Y
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:43 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40fafae5532so19305155e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888199; x=1707492999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SHSPShdHTgayZl7MMTSLF+LQqIks/NtrtDdxuxWI+Xo=;
 b=TBq21PaddtOAxHYpHNO+3IPnRLAE4kDz9h5U3qFyGIr3C9dr+naLxcxUbe584dS35W
 JzAEbaJ3teZR3UqekhcohcDxan8akgLQ7Dm5wj1Is5+qG4UPTeEUKxf/ByZAcfYRw1la
 VRg2Sf8Br1qTEKsm3WLGwdjw2vbdBGzFsC5DwXoxQj2zNqxuQBuS+HCYSDNAdzNltk5z
 9aOk/0qj1ghIgZ7Gss28Jr5pJ8TuVM/lhYAqId0+LFZm7VJdIGAY5jjGiifWraXxA77h
 p6cqjmDauG4iR05OCznO3K9E83yWaAXxKCK+EGH6F9tRdy5HvYuXs8M3jHORyb+mPXd3
 rQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888199; x=1707492999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHSPShdHTgayZl7MMTSLF+LQqIks/NtrtDdxuxWI+Xo=;
 b=Bl1vADmx8k9nvWHJymGMH7D1n4thDKN13ldPsGy9NLI/VTSg/BdVK4rtX6H7bPRF56
 Jxy9JtE+5uVX0SbJas7BLwZrZ374hu5RtFMuqFAYjAEdhq4ESZm12uuGePaPULIP8n1z
 2Y3Qu6OW3phLxMQY7+azcRMGwHPCaRfDrBxhnUc3dOOeLB2fWzo9b6i0pptoOLITueRQ
 TQPW1oYYFu/o4HclgxDk5Eap8ie5bEMn1YC1Nigd2m/DsPTgjBqhpxMg/9KRsnnEGocO
 tHSdDL2+C1X6Aqq1NrOfSCRKpKO5lbL8NCiYfxyQM5sQEI9MxwrR+KL0RZJSwPxUwPJx
 c4YA==
X-Gm-Message-State: AOJu0YyCTVAlQm82jBOTrWsEzxpWed5+BBcpDi6iyY8oTvK7FKsDazAx
 QmkDcrN14jW7N1y44XNtSgVkEZP2VONgeV+52CIDPDt8HF9JNuHj9cQUGtX02b6ow0UTMzWCVVD
 N
X-Google-Smtp-Source: AGHT+IGGf07eY7CvFXzGxvc34R2T7rJNnmaFJEK4I3sVNR5A7NdWhDdJ/nGDUlUd8KSr8LXq1u7q4g==
X-Received: by 2002:a05:600c:1f81:b0:40f:b283:bb00 with SMTP id
 je1-20020a05600c1f8100b0040fb283bb00mr6376045wmb.18.1706888199623; 
 Fri, 02 Feb 2024 07:36:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/36] vmbus: Switch bus reset to 3-phase-reset
Date: Fri,  2 Feb 2024 15:36:04 +0000
Message-Id: <20240202153637.3710444-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Switch vmbus from using BusClass::reset to the Resettable interface.

This has no behavioural change, because the BusClass code to support
subclasses that use the legacy BusClass::reset will call that method
in the hold phase of 3-phase reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-id: 20240119163512.3810301-3-peter.maydell@linaro.org
---
 hw/hyperv/vmbus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index c86d1895bae..380239af2c7 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2453,9 +2453,9 @@ static void vmbus_unrealize(BusState *bus)
     qemu_mutex_destroy(&vmbus->rx_queue_lock);
 }
 
-static void vmbus_reset(BusState *bus)
+static void vmbus_reset_hold(Object *obj)
 {
-    vmbus_deinit(VMBUS(bus));
+    vmbus_deinit(VMBUS(obj));
 }
 
 static char *vmbus_get_dev_path(DeviceState *dev)
@@ -2476,12 +2476,13 @@ static char *vmbus_get_fw_dev_path(DeviceState *dev)
 static void vmbus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->get_dev_path = vmbus_get_dev_path;
     k->get_fw_dev_path = vmbus_get_fw_dev_path;
     k->realize = vmbus_realize;
     k->unrealize = vmbus_unrealize;
-    k->reset = vmbus_reset;
+    rc->phases.hold = vmbus_reset_hold;
 }
 
 static int vmbus_pre_load(void *opaque)
-- 
2.34.1


