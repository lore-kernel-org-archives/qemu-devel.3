Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DE8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 16:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvJRu-0001uu-65; Fri, 12 Apr 2024 12:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJRr-0001tW-Hm
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:08:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJRo-0004a8-5O
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:08:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-343d7ff2350so723600f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712938094; x=1713542894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e/uP53aB4q+23J2glSZ0OAwIIKnVVLxT2g0uleIPttY=;
 b=XWG1zu8ljbyJMYJ9W9FpUwi411DDItepa15utZcBeuA81L8m/aLqgTqjqV5LCZ7SWP
 l5a8OOJgThYPpzhgUs19zsK206/BFkGnzOLo2xcjRfzauCWOy1WgCc2cRHb/RH5Lhb09
 HoZQSSU+CXX9uPaapwOKw9MLz9jhY7qc5OS9X5G8pnEjHkvUj/dB3cLMDb6JlHSU0cqi
 v6Nn54M5prnxx+re2YE4bkox2Fs/cIllqqLGEiAQ8Rq39ncNQSf95yoeXv0i8GLHCVun
 RKpU1wlOi/oRzGEIxX+HvNdlGJv1rN5VCIBzalKw6Ry2v7waBr+QhxfM1LtbZflQc0J2
 bo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712938094; x=1713542894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/uP53aB4q+23J2glSZ0OAwIIKnVVLxT2g0uleIPttY=;
 b=haXrsLTopVl3tMriLDGpRlnW6vz05+L1K5Zr1CeVvmBtDMax2qmg2HUdR4Y8mrJ6Dk
 SfWPB4aPvwlHywCkVxiTMfyspFznsbyvm5QzqYx9CCOMuwxqDCDvtTwnOD5kemM0PLtK
 9CE3FTVBUtr/i3wH2R0q4tLRBGBK2J8J1HiRe58NNMrB6Ok3fIERG4NrgpJtvoPs/pag
 e/9xKteES2P9e1810lr1wx45/qPTC/VWQAO3rpys17DBVIp588gVMnu3B27Q/sbsRhRg
 W0qbdemBFWuCDv+g2ObBiqmHIeW5VX2Xxhfus+HRyXKEpIhZ3w+MUOhxz8u8CYNPOvIs
 PwRQ==
X-Gm-Message-State: AOJu0Yzr3MHKxXbczAhXrgeq6TsrRpq9uMUe/HjPSRF7qNwlLbQG+bkL
 Y+fBZ0dZ/nrPUBh2wL0q/A+YPRJO1i1GDHS4PtOH4zN0oxXBrJkrWABeK+shNHd2/MCu5N7/fko
 e
X-Google-Smtp-Source: AGHT+IH+Fgy1wR/6XkYSy17qHW2EY30ITTmhFUDjXuxz5nJ0Fz4wbYUPznW0NDgRzVKGQPCoA7goMA==
X-Received: by 2002:adf:fe07:0:b0:346:aab2:7979 with SMTP id
 n7-20020adffe07000000b00346aab27979mr1886852wrr.25.1712938094576; 
 Fri, 12 Apr 2024 09:08:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 cr12-20020a05600004ec00b00341ce80ea66sm4582371wrb.82.2024.04.12.09.08.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 09:08:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] reset: Add RESET_TYPE_SNAPSHOT_LOAD
Date: Fri, 12 Apr 2024 17:08:09 +0100
Message-Id: <20240412160809.1260625-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412160809.1260625-1-peter.maydell@linaro.org>
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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


