Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B48DFA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp81C-0006DM-1H; Fri, 13 Sep 2024 11:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp807-00020E-LK
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp804-0007mR-Qb
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:23 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-374b25263a3so783831f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240459; x=1726845259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=txDZ12T6fHXdIDZypcg9V1CdvFzmbSQBApsf5uAHoUk=;
 b=bXw+bq1nnsKeUf1RM6xyQViv0scSsJcM0wxm+lS7aF8G2Jn/ZAZtDI5YkirhHKdzD6
 lW8JWvRvTCikI9DAgVbYrOLt4yz0mQ5L/oS2Z2mCTOtjiCxus8WiIir620MXiOR24339
 05oA+SHmI5Bx1FYbTmChJLtA6EtG7cFNDmlxz/LZKyssEwgS4DDoU1LkeW60mR0JTm7Y
 162IYe9nukcHIhg3FcsrwTbKVEYUuuTmnMlU7a5TklVEC/M2yGG67EHBY/fBhGWoauk6
 y7+kycEmKs14cyBm/Jfq7sCSl93xhiPB+P4TOrtrhVPU/zx++p6wiV792du2yuFm64Gg
 5Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240459; x=1726845259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=txDZ12T6fHXdIDZypcg9V1CdvFzmbSQBApsf5uAHoUk=;
 b=V8aBbEGFaJjIjxNBIlB21PgrGp0bBV4omzEKY2J6GD4q58r363O+/Pw62Z5ZUWFJ5V
 EEm7nIs6aDc02doTwuM1bKBQNUungmWQmtdVfl/136UEkIbdFCVlCnN4P4qusf9syNsK
 YtgxUPyjYtuMSN4CZ2rZd7I9fsRzcqs16KEn45uJVGi6sk5RAGJMnPeFFvwwmKrYc1/f
 jItc67A8tFUnLP09GQhOpNemOw7ZxNR166u7y+ALO3xOBIEOQQBI9xest+7xg3fTudZh
 ea3IW3Q5FRYzbXuaihtl1HciU4Vb51oBeIr4uiKdLxhlh9wSt3qKAqf4FA46gprECLFr
 fgaQ==
X-Gm-Message-State: AOJu0YxF8kBvTnygvIHsk7aeCWGKnKyXwXeu6ldkLqr/7m0PTZxoeJGn
 xe/CLc9/Cnc/DsmpJRefQFz7RiJ8qrSapzUjNWmHIOOsrBB4L4iIrpx8jZbw+gCUKdYPh/4IR+x
 /
X-Google-Smtp-Source: AGHT+IG5EdxSXSQ/U2OqhaPKxZ76SL2bWR+NH8voCDOJZs+XFCZcbgUEh6hAd4w1pNENtgKUG581NA==
X-Received: by 2002:a5d:5987:0:b0:374:c269:df79 with SMTP id
 ffacd0b85a97d-378d61e2b52mr2246391f8f.22.1726240458852; 
 Fri, 13 Sep 2024 08:14:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/27] hw/core/resettable: Remove transitional_function
 machinery
Date: Fri, 13 Sep 2024 16:13:55 +0100
Message-Id: <20240913151411.2167922-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

We used to need the transitional_function machinery to handle bus
classes and device classes which still used their legacy reset
handling.  We have now converted all bus classes to three phase
reset, and simplified the device class legacy reset so it is just an
adapting wrapper function around registration of a hold phase method.
There are therefore no more users of the transitional_function
machinery and we can remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240830145812.1967042-12-peter.maydell@linaro.org
---
 include/hw/resettable.h | 13 -------------
 hw/core/resettable.c    | 24 +++---------------------
 2 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index 83b561fc830..94f6f22e3cf 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -90,14 +90,6 @@ typedef enum ResetType {
  * @get_state: Mandatory method which must return a pointer to a
  * ResettableState.
  *
- * @get_transitional_function: transitional method to handle Resettable objects
- * not yet fully moved to this interface. It will be removed as soon as it is
- * not needed anymore. This method is optional and may return a pointer to a
- * function to be used instead of the phases. If the method exists and returns
- * a non-NULL function pointer then that function is executed as a replacement
- * of the 'hold' phase method taking the object as argument. The two other phase
- * methods are not executed.
- *
  * @child_foreach: Executes a given callback on every Resettable child. Child
  * in this context means a child in the qbus tree, so the children of a qbus
  * are the devices on it, and the children of a device are all the buses it
@@ -109,8 +101,6 @@ typedef void (*ResettableEnterPhase)(Object *obj, ResetType type);
 typedef void (*ResettableHoldPhase)(Object *obj, ResetType type);
 typedef void (*ResettableExitPhase)(Object *obj, ResetType type);
 typedef ResettableState * (*ResettableGetState)(Object *obj);
-typedef void (*ResettableTrFunction)(Object *obj);
-typedef ResettableTrFunction (*ResettableGetTrFunction)(Object *obj);
 typedef void (*ResettableChildCallback)(Object *, void *opaque,
                                         ResetType type);
 typedef void (*ResettableChildForeach)(Object *obj,
@@ -130,9 +120,6 @@ struct ResettableClass {
     /* State access method */
     ResettableGetState get_state;
 
-    /* Transitional method for legacy reset compatibility */
-    ResettableGetTrFunction get_transitional_function;
-
     /* Hierarchy handling method */
     ResettableChildForeach child_foreach;
 };
diff --git a/hw/core/resettable.c b/hw/core/resettable.c
index 6dd3e3dc487..5cdb4a4f8d3 100644
--- a/hw/core/resettable.c
+++ b/hw/core/resettable.c
@@ -93,20 +93,6 @@ static void resettable_child_foreach(ResettableClass *rc, Object *obj,
     }
 }
 
-/**
- * resettable_get_tr_func:
- * helper to fetch transitional reset callback if any.
- */
-static ResettableTrFunction resettable_get_tr_func(ResettableClass *rc,
-                                                   Object *obj)
-{
-    ResettableTrFunction tr_func = NULL;
-    if (rc->get_transitional_function) {
-        tr_func = rc->get_transitional_function(obj);
-    }
-    return tr_func;
-}
-
 static void resettable_phase_enter(Object *obj, void *opaque, ResetType type)
 {
     ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
@@ -146,7 +132,7 @@ static void resettable_phase_enter(Object *obj, void *opaque, ResetType type)
     if (action_needed) {
         trace_resettable_phase_enter_exec(obj, obj_typename, type,
                                           !!rc->phases.enter);
-        if (rc->phases.enter && !resettable_get_tr_func(rc, obj)) {
+        if (rc->phases.enter) {
             rc->phases.enter(obj, type);
         }
         s->hold_phase_pending = true;
@@ -171,12 +157,8 @@ static void resettable_phase_hold(Object *obj, void *opaque, ResetType type)
     /* exec hold phase */
     if (s->hold_phase_pending) {
         s->hold_phase_pending = false;
-        ResettableTrFunction tr_func = resettable_get_tr_func(rc, obj);
         trace_resettable_phase_hold_exec(obj, obj_typename, !!rc->phases.hold);
-        if (tr_func) {
-            trace_resettable_transitional_function(obj, obj_typename);
-            tr_func(obj);
-        } else if (rc->phases.hold) {
+        if (rc->phases.hold) {
             rc->phases.hold(obj, type);
         }
     }
@@ -199,7 +181,7 @@ static void resettable_phase_exit(Object *obj, void *opaque, ResetType type)
     assert(s->count > 0);
     if (--s->count == 0) {
         trace_resettable_phase_exit_exec(obj, obj_typename, !!rc->phases.exit);
-        if (rc->phases.exit && !resettable_get_tr_func(rc, obj)) {
+        if (rc->phases.exit) {
             rc->phases.exit(obj, type);
         }
     }
-- 
2.34.1


