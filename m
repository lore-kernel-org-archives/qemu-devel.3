Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB37CA0FFC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 14:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk352-0005Jw-Cx; Fri, 30 Aug 2024 10:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk350-0005D5-Kk
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34y-0004ca-3z
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4281ca54fd3so17458315e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725029902; x=1725634702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnGlGQPEvgFWUJ8YohN4Pf7h807GK3plLxCZqkrhNJw=;
 b=T3IeXA0qahlHH8j1lBXpqyUobfFIx79LFvpbJjjCMsUBCbN+RtvYA0/frl7sKm7IIZ
 JAY31shAZnVL5RHXnckZC8P/d7Y1JlyKPQ/+FW1/geuGE+pfgZE/U0CMRm7WUaEAe4Ec
 uDj8cmd4W7ceppi/5KMi8xD1WfOVbj50jsctrTmdq8fGjw8CXUUeXejcpNLDIW5l8imQ
 5WCMoB7st1tdDChHbI7dOEbCe5XDSm37XGRXPccq4QPQODRNfrE2OtxWdfrtc2fTCw84
 xXkkQhhHqVTgxV/ynfy15oNBjMCMu/P3/kuZ8SmpUKsKHQ1/cIxNX1xh/6XbujAgxdOr
 ZZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725029902; x=1725634702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnGlGQPEvgFWUJ8YohN4Pf7h807GK3plLxCZqkrhNJw=;
 b=FEEYEsyrtg4mi0FhlI//DIY5OEG5YWZxf9whn31jhPUYx9ufUvRGzcMBHG4j2kmVJo
 RciUoc9qod5FRQJ17qnJoR2pQd/5xm0h2ugQ5yXiuKFCzWta1DlcgLrI4rC1eSIK1tah
 Dz4cva3uKoWw/Og4mLSlMpTF+R94WZiwhoz8rbuRYhNORrBB7XiP+gdU+krgQn7e3e7L
 h6PHSZXKzfDUcQQ3Qgcfrrv/AiwjzWmpc+VpLAOox3RweaWz32V7csd+o/V+eO0fwHw0
 9+wBCaAFZzKYtCe0BVDjkMN7beZr2RQ1n/Cf+vZXslIV9lu7rTSecTgEGga99JjhFVxk
 hmpg==
X-Gm-Message-State: AOJu0YzYVpDdIq9+u7VZkvPPVdejmyzEZlJLM2O2S3AP/ZMEmGEQZqxp
 h6ifkAAlwpzsrL5wfiERIV3KG76a2zx485QhfubxULykb27ei/BdKHoDV3SAC7W2AcBOqnTQMNV
 /
X-Google-Smtp-Source: AGHT+IG+ffiz9h9nsiew2HtQooa4Q84BCUtkQJn2KpZo+Da1ktRpDz4KgE3niwrTtExnH9FL5+hNpQ==
X-Received: by 2002:a05:600c:4585:b0:426:554a:e0bf with SMTP id
 5b1f17b1804b1-42bb02ee854mr49869205e9.16.1725029902212; 
 Fri, 30 Aug 2024 07:58:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6da24bbsm49022345e9.0.2024.08.30.07.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 07:58:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 11/11] hw/core/resettable: Remove transitional_function
 machinery
Date: Fri, 30 Aug 2024 15:58:12 +0100
Message-Id: <20240830145812.1967042-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830145812.1967042-1-peter.maydell@linaro.org>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

We used to need the transitional_function machinery to handle bus
classes and device classes which still used their legacy reset
handling.  We have now converted all bus classes to three phase
reset, and simplified the device class legacy reset so it is just an
adapting wrapper function around registration of a hold phase method.
There are therefore no more users of the transitional_function
machinery and we can remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


