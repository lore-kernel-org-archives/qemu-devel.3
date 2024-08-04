Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AFCC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 09:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saX8d-00032y-Sc; Sun, 04 Aug 2024 05:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX8X-0002TZ-0j
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:02:45 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX8V-0001GU-9Y
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:02:44 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ff1cd07f56so73426725ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 02:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722762161; x=1723366961;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0RYDgLdr7HQ010CTBqvRUSBgNA/oE/wNQ3ZQWiob4V0=;
 b=IEe2YGLZj9Jwt0yq3+i2rGq2XDB3cpwLBf1UojUjehWxFkwhM+mZufc/QHfkkV8q38
 fOsg9dsE4oJh/u7Z6n3Oq/P+LaKkP0k3ZrfSSWbFFSdh44HhHtJjqZl2fkcq9/tmxOQt
 r3qGgqhWZO/j9CSGp0nqecPuv0kvoia8BqvEJWrO77Odcvbsm3zAyICr657HZRM8+5Ig
 mxOnK/NepoffbvjgzLnulbtRa+vvlAlsD+z+hrqAoOd4nlFWdX4gxRmSuLDvUOozW25n
 QqNFBzdZYuZnh1p0ZJPFXT8MczgLcqGLGbV79NCNfz5JgIW2osk/Z4V4KiHkTaMdEwOz
 IJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722762161; x=1723366961;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0RYDgLdr7HQ010CTBqvRUSBgNA/oE/wNQ3ZQWiob4V0=;
 b=nfeDD+9mGwENuWsPTjFFhEFZEVFhODBaadlAdMRiRePwoeNXAHWDRcP/tZ8FI7atNb
 G8TOLw6ZAFEkwLsqr8Wc/PR/vyZ8uRoFJK5QkyveQtGurzgVbwMFBQida/IIm/yHOxpx
 n+Oz3aWdPIj8ueHLZP/yOYZCDpGva8Ga7P1yeWDdLBKUWHcA2JO0z49y0MEILuHTkgl1
 USNa3gHv7rSKhI4n1sWlOYufqsXQizsmFXE+gRe+lRy6LyoJCqjIvwMGsK+bcjzGKsYd
 z26rd2EN/Y7GaghupbR4fo3ttzfgeKod6sU8goWHf/9Rww1kq7dxBvoCGe+HQ7tvVdF2
 BNYw==
X-Gm-Message-State: AOJu0YzzxA8ako9D+EROSGivJ70+RlsaXrrrf8plZPF+0ANnOGq3kJOP
 HHUfhaELxlKLJdmFq2Ln6xgu21vMoir9+FEDJciw2IVK584WsRN9xQP6ssnCL/0=
X-Google-Smtp-Source: AGHT+IEGs28GgpgVkfAxo4hHfuFgbz/jAGMJv5YQ0s77KSiTsTfjwX2Wwdqka3+VfAxTRjDMo6DPAQ==
X-Received: by 2002:a17:902:ce8c:b0:1fd:a0e9:910 with SMTP id
 d9443c01a7336-1ff574a6ff9mr105256825ad.62.1722762160991; 
 Sun, 04 Aug 2024 02:02:40 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff5928f518sm45979585ad.234.2024.08.04.02.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 02:02:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 04 Aug 2024 18:01:47 +0900
Subject: [PATCH for-9.2 v12 11/11] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240804-reuse-v12-11-d3930c4111b2@daynix.com>
References: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
In-Reply-To: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

It is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/qdev-core.h |  4 ----
 hw/core/qdev.c         |  1 -
 system/qdev-monitor.c  | 12 +++++++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 77bfcbdf732a..a3757e6769f8 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -237,10 +237,6 @@ struct DeviceState {
      * @pending_deleted_expires_ms: optional timeout for deletion events
      */
     int64_t pending_deleted_expires_ms;
-    /**
-     * @opts: QDict of options for the device
-     */
-    QDict *opts;
     /**
      * @hotplugged: was device added after PHASE_MACHINE_READY?
      */
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f3a996f57dee..2fc84699d432 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -706,7 +706,6 @@ static void device_finalize(Object *obj)
         dev->canonical_path = NULL;
     }
 
-    qobject_unref(dev->opts);
     g_free(dev->id);
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 6af6ef7d667f..3551989d5153 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -624,6 +624,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     char *id;
     DeviceState *dev = NULL;
     BusState *bus = NULL;
+    QDict *properties;
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
@@ -705,13 +706,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     }
 
     /* set properties */
-    dev->opts = qdict_clone_shallow(opts);
-    qdict_del(dev->opts, "driver");
-    qdict_del(dev->opts, "bus");
-    qdict_del(dev->opts, "id");
+    properties = qdict_clone_shallow(opts);
+    qdict_del(properties, "driver");
+    qdict_del(properties, "bus");
+    qdict_del(properties, "id");
 
-    object_set_properties_from_keyval(&dev->parent_obj, dev->opts, from_json,
+    object_set_properties_from_keyval(&dev->parent_obj, properties, from_json,
                                       errp);
+    qobject_unref(properties);
     if (*errp) {
         goto err_del_dev;
     }

-- 
2.45.2


