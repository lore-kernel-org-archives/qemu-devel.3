Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4CAC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWe-0002Kw-79; Thu, 25 Apr 2024 06:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWb-00029V-1T
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:21 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWY-0007FG-R4
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34a32ba1962so661844f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041617; x=1714646417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ePrcln4bIoTeYHPaxB8JDKlC6bBG+7XjGQJPBdA/WHo=;
 b=EeZIbk/fyR3NGPPA1oJ+fFFLs/JBSjQSXOB5bx5HhRS5VJw4I2AgwG7zfzFRAgtDGi
 BJO/UVz5uCV747Fdn/5Ybp9OiWCwZbZCa7EHUiSxQRNJ4JCmKV74/cWPpoJ5oy/GXn5d
 /jyW/8MB8uo1yD/SGAfKY1AR6EmZIrIaHH81qQN2kL8qLkCWUPLAsZUYy3tJAmprTMBt
 3i2ets2X+abIsHcg87vm47wya91lsZjAtgyFt4HZ3W1h6fE0GVX2tyfqZpfeOq+oq3t7
 /s/Ws+cAWSJnM6+DcW0q01z/3AfJwawjYbsZOj+rqHPMROeb0gLcQk0yF6TBVX0JasXJ
 VhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041617; x=1714646417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePrcln4bIoTeYHPaxB8JDKlC6bBG+7XjGQJPBdA/WHo=;
 b=pQyzVy4QGhDjPFvw7iHixrTMWyiAywxsQAA+6WRFQdq7lEEgVyuTXmEh209TiVNrgD
 o5frNd6UE6TQbR0hGe9hbkXXu1bXs3lzpnF5R+52oqi3fyUQZSYjNidEPOj4D6tv6Ij7
 +CvSOzaeOaEpoVUutSb2eXDZyC620bWi24dEEj4mcXQzpHejX0q+8iMwJfJYE9ojIe0x
 Zj19C5TyZm3wzKj9NIRxbMvKx58vf8/Ty3g6IZJXowsgZLnPYpGvD6Ff8Pi1s2grRr28
 vU+YfxP7Kmw0FcemLoiYDoCIOy2tlYGkdjztm2HAXhd6oE/lwhVPEDPzakQaRgibiHnA
 6aiw==
X-Gm-Message-State: AOJu0YwsqMP9LcXSKGYVqfAmBVBNoQ9fv9oZkMc+ap0sDXfAxFIRgjeh
 Ad0xIeFCLg+S8FHQjKSbzNV5B+MP5tcl7w2C00XH61B9FurBUf13a257SmfpOu2gd5ng8cye8O3
 5
X-Google-Smtp-Source: AGHT+IFHQY2YOY5WS7z0bCCar5gsEI/6InL3LQEuVf0JAKI3hJa2sPTo6iZwaiZkbGywGWljp/noeQ==
X-Received: by 2002:a5d:56ce:0:b0:343:68d6:5636 with SMTP id
 m14-20020a5d56ce000000b0034368d65636mr3660613wrw.43.1714041617088; 
 Thu, 25 Apr 2024 03:40:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/37] reset: Add RESET_TYPE_SNAPSHOT_LOAD
Date: Thu, 25 Apr 2024 11:39:53 +0100
Message-Id: <20240425103958.3237225-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Some devices and machines need to handle the reset before a vmsave
snapshot is loaded differently -- the main user is the handling of
RNG seed information, which does not want to put a new RNG seed into
a ROM blob when we are doing a snapshot load.

Currently this kind of reset handling is supported only for:
 * TYPE_MACHINE reset methods, which take a ShutdownCause argument
 * reset functions registered with qemu_register_reset_nosnapshotload

To allow a three-phase-reset device to also distinguish "snapshot
load" reset from the normal kind, add a new ResetType
RESET_TYPE_SNAPSHOT_LOAD. All our existing reset methods ignore
the reset type, so we don't need to update any device code.

Add the enum type, and make qemu_devices_reset() use the
right reset type for the ShutdownCause it is passed. This
allows us to get rid of the device_reset_reason global we
were using to implement qemu_register_reset_nosnapshotload().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Message-id: 20240412160809.1260625-7-peter.maydell@linaro.org
---
 docs/devel/reset.rst    | 17 ++++++++++++++---
 include/hw/resettable.h |  1 +
 hw/core/reset.c         | 15 ++++-----------
 hw/core/resettable.c    |  4 ----
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index 49baa1ea271..9746a4e8a0b 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -27,9 +27,7 @@ instantly reset an object, without keeping it in reset state, just call
 ``resettable_reset()``. These functions take two parameters: a pointer to the
 object to reset and a reset type.
 
-Several types of reset will be supported. For now only cold reset is defined;
-others may be added later. The Resettable interface handles reset types with an
-enum:
+The Resettable interface handles reset types with an enum ``ResetType``:
 
 ``RESET_TYPE_COLD``
   Cold reset is supported by every resettable object. In QEMU, it means we reset
@@ -37,6 +35,19 @@ enum:
   from what is a real hardware cold reset. It differs from other resets (like
   warm or bus resets) which may keep certain parts untouched.
 
+``RESET_TYPE_SNAPSHOT_LOAD``
+  This is called for a reset which is being done to put the system into a
+  clean state prior to loading a snapshot. (This corresponds to a reset
+  with ``SHUTDOWN_CAUSE_SNAPSHOT_LOAD``.) Almost all devices should treat
+  this the same as ``RESET_TYPE_COLD``. The main exception is devices which
+  have some non-deterministic state they want to reinitialize to a different
+  value on each cold reset, such as RNG seed information, and which they
+  must not reinitialize on a snapshot-load reset.
+
+Devices which implement reset methods must treat any unknown ``ResetType``
+as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount of
+existing code we need to change if we add more types in future.
+
 Calling ``resettable_reset()`` is equivalent to calling
 ``resettable_assert_reset()`` then ``resettable_release_reset()``. It is
 possible to interleave multiple calls to these three functions. There may
diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index 3161e471c9b..7e249deb8b5 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -35,6 +35,7 @@ typedef struct ResettableState ResettableState;
  */
 typedef enum ResetType {
     RESET_TYPE_COLD,
+    RESET_TYPE_SNAPSHOT_LOAD,
 } ResetType;
 
 /*
diff --git a/hw/core/reset.c b/hw/core/reset.c
index f9fef45e050..58dfc8db3dc 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -43,13 +43,6 @@ static ResettableContainer *get_root_reset_container(void)
     return root_reset_container;
 }
 
-/*
- * Reason why the currently in-progress qemu_devices_reset() was called.
- * If we made at least SHUTDOWN_CAUSE_SNAPSHOT_LOAD have a corresponding
- * ResetType we could perhaps avoid the need for this global.
- */
-static ShutdownCause device_reset_reason;
-
 /*
  * This is an Object which implements Resettable simply to call the
  * callback function in the hold phase.
@@ -77,8 +70,7 @@ static void legacy_reset_hold(Object *obj, ResetType type)
 {
     LegacyReset *lr = LEGACY_RESET(obj);
 
-    if (device_reset_reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD &&
-        lr->skip_on_snapshot_load) {
+    if (type == RESET_TYPE_SNAPSHOT_LOAD && lr->skip_on_snapshot_load) {
         return;
     }
     lr->func(lr->opaque);
@@ -180,8 +172,9 @@ void qemu_unregister_resettable(Object *obj)
 
 void qemu_devices_reset(ShutdownCause reason)
 {
-    device_reset_reason = reason;
+    ResetType type = (reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD) ?
+        RESET_TYPE_SNAPSHOT_LOAD : RESET_TYPE_COLD;
 
     /* Reset the simulation */
-    resettable_reset(OBJECT(get_root_reset_container()), RESET_TYPE_COLD);
+    resettable_reset(OBJECT(get_root_reset_container()), type);
 }
diff --git a/hw/core/resettable.c b/hw/core/resettable.c
index bebf7f10b26..6dd3e3dc487 100644
--- a/hw/core/resettable.c
+++ b/hw/core/resettable.c
@@ -48,8 +48,6 @@ void resettable_reset(Object *obj, ResetType type)
 
 void resettable_assert_reset(Object *obj, ResetType type)
 {
-    /* TODO: change this assert when adding support for other reset types */
-    assert(type == RESET_TYPE_COLD);
     trace_resettable_reset_assert_begin(obj, type);
     assert(!enter_phase_in_progress);
 
@@ -64,8 +62,6 @@ void resettable_assert_reset(Object *obj, ResetType type)
 
 void resettable_release_reset(Object *obj, ResetType type)
 {
-    /* TODO: change this assert when adding support for other reset types */
-    assert(type == RESET_TYPE_COLD);
     trace_resettable_reset_release_begin(obj, type);
     assert(!enter_phase_in_progress);
 
-- 
2.34.1


