Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA39C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvaw-0000CP-Io; Fri, 02 Feb 2024 10:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvav-0000Ap-72
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:45 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvat-0004Rl-8Z
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:44 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-51137c8088dso969502e87.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888201; x=1707493001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wyZDr1Zjb+maiQcAIaO52bka0IE0OhCst2zFuC2UbQo=;
 b=b0z5QJf5n801ia+vPvZL7ACABnaDb5foj0OyL+Ex8sLrV2C4NonUypHEeD3XoeDgoa
 ZmsrR8jIz8s0OzXK6qI9Pg87p226j9C+WdadVSOYZis6pB50Jsa5uJB1OTKtl4g8pDL8
 p0SPr+Nm262+s6dOF9xIQsQIQdEE/I9lc8Qa2rHEBGCg7fw4rBXlN3p7zp+skJmt9RzJ
 q4VzS2NSmK/OKxkAXStk1y65Ze/5DEONVU4fWv4CAKET9z6Wx+WbA8zyc1KoOrCXqOof
 PwhWKoweG97FStyI1YXDnXfxMsvGImdmYK0sncBboYjBCNLm7nBnCDSxs2l23g7LXVrQ
 pD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888201; x=1707493001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wyZDr1Zjb+maiQcAIaO52bka0IE0OhCst2zFuC2UbQo=;
 b=fNisH3LFbtEKjebGX0HH4KxT4stJqPYRu81gLi+ZM7UCRh7onpszNaHCizTHqHaIZr
 D4Fszif5x1+QFrf4UKmGuOEDxS8un8T5nDEfgjqUTG/aBgmEfEpxt1HyaXtJ7DaB+G2N
 3C056nl++MkvgMCPQsEvOUcBVIORQfMRl4dfUKz67FOl4VGAdgQGzhhPSsdaSBQUjQoe
 Jh401zIU/0iUMkpAZwMGJBU5aDpAhMzS2y8YJQqakYOHY/KBwoRTzZDioNjDMi0H0c/z
 F13YQCF54k+sZLR2k77vKmYKtF9eNoI/B0Ua/OlSsaerMTmnAYU/EIrtLWTDFPjvcNum
 7myQ==
X-Gm-Message-State: AOJu0YxLrmNTAi9uSOFkmlbSl4v84OlL5ULiJ9EHoerE4zg0jbdok0SV
 bvX77zyY40zJPrkukT/J5fOX4Pyh6XxLo1dIwwz5nfieNR4sFCamHvLoVBNsP4XD8GeisryTTP9
 W
X-Google-Smtp-Source: AGHT+IFITSKcmbr2aPKEAwhYEqRNg30i3qZZuxTmDP6+9SBvsrM4tCnLiXFcJNiect9eL6AmcpUcEQ==
X-Received: by 2002:ac2:5101:0:b0:510:1b65:dd97 with SMTP id
 q1-20020ac25101000000b005101b65dd97mr3929634lfb.17.1706888201673; 
 Fri, 02 Feb 2024 07:36:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/36] hw/core: Remove transitional infrastructure from BusClass
Date: Fri,  2 Feb 2024 15:36:07 +0000
Message-Id: <20240202153637.3710444-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

BusClass currently has transitional infrastructure to support
subclasses which implement the legacy BusClass::reset method rather
than the Resettable interface.  We have now removed all the users of
BusClass::reset in the tree, so we can remove the transitional
infrastructure.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-id: 20240119163512.3810301-6-peter.maydell@linaro.org
---
 include/hw/qdev-core.h |  2 --
 hw/core/bus.c          | 67 ------------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 66338f479fe..d47536eadb1 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -329,8 +329,6 @@ struct BusClass {
      */
     char *(*get_fw_dev_path)(DeviceState *dev);
 
-    void (*reset)(BusState *bus);
-
     /*
      * Return whether the device can be added to @bus,
      * based on the address that was set (via device properties)
diff --git a/hw/core/bus.c b/hw/core/bus.c
index c7831b5293b..b9d89495cdf 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -232,57 +232,6 @@ static char *default_bus_get_fw_dev_path(DeviceState *dev)
     return g_strdup(object_get_typename(OBJECT(dev)));
 }
 
-/**
- * bus_phases_reset:
- * Transition reset method for buses to allow moving
- * smoothly from legacy reset method to multi-phases
- */
-static void bus_phases_reset(BusState *bus)
-{
-    ResettableClass *rc = RESETTABLE_GET_CLASS(bus);
-
-    if (rc->phases.enter) {
-        rc->phases.enter(OBJECT(bus), RESET_TYPE_COLD);
-    }
-    if (rc->phases.hold) {
-        rc->phases.hold(OBJECT(bus));
-    }
-    if (rc->phases.exit) {
-        rc->phases.exit(OBJECT(bus));
-    }
-}
-
-static void bus_transitional_reset(Object *obj)
-{
-    BusClass *bc = BUS_GET_CLASS(obj);
-
-    /*
-     * This will call either @bus_phases_reset (for multi-phases transitioned
-     * buses) or a bus's specific method for not-yet transitioned buses.
-     * In both case, it does not reset children.
-     */
-    if (bc->reset) {
-        bc->reset(BUS(obj));
-    }
-}
-
-/**
- * bus_get_transitional_reset:
- * check if the bus's class is ready for multi-phase
- */
-static ResettableTrFunction bus_get_transitional_reset(Object *obj)
-{
-    BusClass *dc = BUS_GET_CLASS(obj);
-    if (dc->reset != bus_phases_reset) {
-        /*
-         * dc->reset has been overridden by a subclass,
-         * the bus is not ready for multi phase yet.
-         */
-        return bus_transitional_reset;
-    }
-    return NULL;
-}
-
 static void bus_class_init(ObjectClass *class, void *data)
 {
     BusClass *bc = BUS_CLASS(class);
@@ -293,22 +242,6 @@ static void bus_class_init(ObjectClass *class, void *data)
 
     rc->get_state = bus_get_reset_state;
     rc->child_foreach = bus_reset_child_foreach;
-
-    /*
-     * @bus_phases_reset is put as the default reset method below, allowing
-     * to do the multi-phase transition from base classes to leaf classes. It
-     * allows a legacy-reset Bus class to extend a multi-phases-reset
-     * Bus class for the following reason:
-     * + If a base class B has been moved to multi-phase, then it does not
-     *   override this default reset method and may have defined phase methods.
-     * + A child class C (extending class B) which uses
-     *   bus_class_set_parent_reset() (or similar means) to override the
-     *   reset method will still work as expected. @bus_phases_reset function
-     *   will be registered as the parent reset method and effectively call
-     *   parent reset phases.
-     */
-    bc->reset = bus_phases_reset;
-    rc->get_transitional_function = bus_get_transitional_reset;
 }
 
 static void qbus_finalize(Object *obj)
-- 
2.34.1


