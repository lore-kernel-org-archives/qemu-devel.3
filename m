Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D26C02193
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmTw-0007sL-L2; Tue, 28 Jan 2025 09:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTs-0007pl-Pc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:20 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTq-0002LJ-Ob
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:20 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so63131265e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074135; x=1738678935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+boILYhYAtgeHGjq7jZm3ySgVoHBXMK8/hh/+aqTVRc=;
 b=zDKJ/uzzSbnVMhEOyWrbWTzi4EhJrFG1NPvkd+qVf5cp8ivj+C6fplNYZlCvoj3+iX
 BrkUg9rSTy6zQODNdtrU7UIIHijXiaJfKp1orT0nTU7prNKr/ZDD/Oa8JW99/f2x8PfC
 pHQjcxv2d0ZbIdzjX0AiaO64AZgA+uKvoWsM3RTZAdEwkZPGp03U21bhswQNaS22EJQJ
 AK1RewFv5Pa3xenVm13SCiqp3rahKzebYBUrshAmxVF15PVQIjcESCQBwgcm9lBDnoES
 LKNLYnk9XCoIqnNfalYZWbIhusdcQD/hiaAMdi6IvOYMnomAjAQI7k9eP/tKRgt9f7FO
 2Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074135; x=1738678935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+boILYhYAtgeHGjq7jZm3ySgVoHBXMK8/hh/+aqTVRc=;
 b=UKil+ei9nhFmvQF5InLCPKQlPkyUOJkktMCa86WqvBosqZ1oa12523MYWH/nZbiM09
 feEnD5bDpBEb91WqtIRvyozCKkH7uV+fu7dkmKQpK17BaU0Yc/VzUp3wQC0Fvlu0f1AL
 4FBMAACAJ3Wjyan5YaN44IAEBoacM7U5qTrn0PjjOna7Sl4TW5LmnuqbWn3ANAUcMF0l
 Sr2lStwfGHowAnO5GYzTrj32ptEkiD7MpZa/b7Bdxd862QKaMc84rtRlxMCQ3FcelDsF
 1BgBbi9m59UUPYV5AoDMlSyb6U0/NII2DXD2FXkhmkmbaCPxD+5XEQeeqph1/mvYP9TP
 87cQ==
X-Gm-Message-State: AOJu0YzUqRA5fitYnDcLZD1hJCqqk3FPYw9fcJSgI/OdQ4iQOfXegMzC
 OeCgyRP1+yENqQFXvv5oU2bxBBUxEjX5KAECAraQajqMyOEbvlLENdG++q5UCtd3IYSLms7O+is
 leVE=
X-Gm-Gg: ASbGncsyVqMCB1URD9zqaR3vFbdCKPVOLa0t2IFuCwUYlpuwq7WySQuhKf5p60Oo9YU
 VFxQuBwohq6uYke8DR4UM+w0RwJeQveL+3nTm4EebREKBdpGWWB30/gWI6Obvm9n5IQvags+Vth
 ta6pptbZHSLla9/AR2BoV1kfpFe0MzXmiXdBW24lUP8QUanftTME4R1bnQLwmiEPafXDaPi6xFy
 Z2fycsC11uOALXDpogtZ3iNtRxUUGYWmFrmiKsa69ZLG9W/isYzu+1N+hnbtzXqRoOJCNj8YOZq
 YM43UQ2dQPvdi8zirkYPd2jG08t3V4302P/3Qc8sCxxPbLwwWZSyYiBLJfFAG2ubfQ==
X-Google-Smtp-Source: AGHT+IGiyDf3PkdYsZe6jk+4/3mMAG2JXndCBMlzg8yxTvd0a+VKOSqbgVH5XTu3dPPXX+j4kBOFOQ==
X-Received: by 2002:a05:600c:1386:b0:434:f739:7cd9 with SMTP id
 5b1f17b1804b1-438913cf349mr381680345e9.9.1738074135029; 
 Tue, 28 Jan 2025 06:22:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4857b8sm168810805e9.15.2025.01.28.06.22.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 06:22:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 4/9] hw/qdev: Introduce DeviceClass::[un]wire() handlers
Date: Tue, 28 Jan 2025 15:21:47 +0100
Message-ID: <20250128142152.9889-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128142152.9889-1-philmd@linaro.org>
References: <20250128142152.9889-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We are trying to understand what means "a qdev is realized".
One explanation was "the device is guest visible"; however
many devices are realized before being mapped, thus are not
"guest visible". Some devices map / wire their IRQs before
being realized (such ISA devices). There is a need for devices
to be "automatically" mapped/wired (see [2]) such CLI-created
devices, but this apply generically to dynamic machines.

Currently the device creation steps are expected to roughly be:

  (external use)                (QDev core)                   (Device Impl)
   ~~~~~~~~~~~~                  ~~~~~~~~~                     ~~~~~~~~~~~

                               INIT enter
                   ----->
                         +----------------------+
                         |    Allocate state    |
                         +----------------------+
                                                 ----->
                                                        +---------------------+
                                                        | INIT children       |
                                                        |                     |
                                                        | Alias children properties
                                                        |                     |
                                                        | Expose properties   |
                                INIT exit               +---------------------+
                   <-----------------------------------
 +----------------+
 | set properties |
 |                |
 | set ClkIn      |
 +----------------+          REALIZE enter
                   ---------------------------------->
                                                       +----------------------+
                                                       | Use config properties|
                                                       |                      |
                                                       | Realize children     |
                                                       |                      |
                                                       | Init GPIOs/IRQs      |
                                                       |                      |
                                                       | Init MemoryRegions   |
                                                       +----------------------+
                               REALIZE exit
                   <-----------------------------------                        ----  "realized" / "guest visible"
+-----------------+
| Explicit wiring:|
|   IRQs          |
|   I/O / Mem     |
|   ClkOut        |
+-----------------+             RESET enter
                    --------------------------------->
                                                       +----------------------+
                                                       | Reset default values |
                                                       +----------------------+

But as mentioned, various devices "wire" parts before they exit
the "realize" step.
In order to clarify, I'm trying to enforce what can be done
*before* and *after* realization.

*after* a device is expected to be stable (no more configurable)
and fully usable.

To be able to use internal/auto wiring (such ISA devices) and
keep the current external/explicit wiring, I propose to add an
extra "internal wiring" step, happening after the REALIZE step
as:

  (external use)                (QDev core)                   (Device Impl)
   ~~~~~~~~~~~~                  ~~~~~~~~~                     ~~~~~~~~~~~

                               INIT enter
                   ----->
                         +----------------------+
                         |    Allocate state    |
                         +----------------------+
                                                 ----->
                                                        +---------------------+
                                                        | INIT children       |
                                                        |                     |
                                                        | Alias children properties
                                                        |                     |
                                                        | Expose properties   |
                                INIT exit               +---------------------+
                   <-----------------------------------
 +----------------+
 | set properties |
 |                |
 | set ClkIn      |
 +----------------+          REALIZE enter
                   ---------------------------------->
                                                       +----------------------+
                                                       | Use config properties|
                                                       |                      |
                                                       | Realize children     |
                                                       |                      |
                                                       | Init GPIOs/IRQs      |
                                                       |                      |
                                                       | Init MemoryRegions   |
                                                       +----------------------+
                               REALIZE exit       <---
                         +----------------------+
                         | Internal auto wiring |
                         |   IRQs               |  (i.e. ISA bus)
                         |   I/O / Mem          |
                         |   ClkOut             |
                         +----------------------+
                    <---                                                       ----  "realized"
+-----------------+
| External wiring:|
|   IRQs          |
|   I/O / Mem     |
|   ClkOut        |
+-----------------+             RESET enter                                    ----  "guest visible"
                    --------------------------------->
                                                       +----------------------+
                                                       | Reset default values |
                                                       +----------------------+

The "realized" point is not changed. "guest visible" concept only
occurs *after* wiring, just before the reset phase.

This change introduces the DeviceClass::wire handler within qdev
core realization code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-core.h |  7 +++++++
 hw/core/qdev.c         | 20 +++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 530f3da7021..021bb7afdc0 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -102,7 +102,12 @@ typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
  * @props: Properties accessing state fields.
  * @realize: Callback function invoked when the #DeviceState:realized
  * property is changed to %true.
+ * @wire: Callback function called after @realize to connect IRQs,
+ * clocks and map memories. Can not fail.
+ * @unwire: Callback function to undo @wire. Called before @unrealize.
+ * Can not fail.
  * @unrealize: Callback function invoked when the #DeviceState:realized
+ * property is changed to %false. Can not fail.
  * property is changed to %false.
  * @sync_config: Callback function invoked when QMP command device-sync-config
  * is called. Should synchronize device configuration from host to guest part
@@ -171,6 +176,8 @@ struct DeviceClass {
      */
     DeviceReset legacy_reset;
     DeviceRealize realize;
+    void (*wire)(DeviceState *dev);
+    void (*unwire)(DeviceState *dev);
     DeviceUnrealize unrealize;
     DeviceSyncConfig sync_config;
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 82bbdcb654e..38449255365 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -554,6 +554,15 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             }
        }
 
+        if (dc->wire) {
+            if (!dc->unwire) {
+                warn_report_once("wire() without unwire() for type '%s'",
+                                 object_get_typename(OBJECT(dev)));
+            }
+            dc->wire(dev);
+        }
+
+        /* At this point the device is "guest visible". */
        qatomic_store_release(&dev->realized, value);
 
     } else if (!value && dev->realized) {
@@ -573,6 +582,15 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
          */
         smp_wmb();
 
+        if (dc->unwire) {
+            if (!dc->wire) {
+                error_report("disconnect() without connect() for type '%s'",
+                             object_get_typename(OBJECT(dev)));
+                abort();
+            }
+            dc->unwire(dev);
+        }
+
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
             qbus_unrealize(bus);
         }
@@ -585,8 +603,8 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         dev->pending_deleted_event = true;
         DEVICE_LISTENER_CALL(unrealize, Reverse, dev);
     }
-
     assert(local_err == NULL);
+
     return;
 
 child_realize_fail:
-- 
2.47.1


