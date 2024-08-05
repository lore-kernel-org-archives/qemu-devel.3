Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D534CC52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sauVy-0006as-4i; Mon, 05 Aug 2024 06:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauVw-0006Lb-6P
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:00:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauVu-0001lV-C8
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:00:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc4fccdd78so74937365ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722852023; x=1723456823;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0RYDgLdr7HQ010CTBqvRUSBgNA/oE/wNQ3ZQWiob4V0=;
 b=MH8RfdcXi9UcYIY6oPRifvyyDV1LffA4fO4MlT9PAs9egxi2ED5stDGZogFA2tRWfC
 obEPihhxJ4w/as6oXSSAT5BLQPsfn+q8F3zHDyBawmxvyBYRKYrWcvHDl+GRqcWWhe+6
 aSND6wEwjGzL0RZb/Zq6AaRun76fJtRJsX2t/S1HaieFvrYqGsfad0ElH37bYlRpPUyA
 71ohMeDuwxrZ7u7RhMJjp3g1nSGfcFjczYzeUiDtIp5O/tRdSFcQ+eEuJl7iQLc/aKFU
 S0FxoWIld5FpIXnJmyvY7XzEZF88qETPjiJU3qj8HwTABSMnmmFxizwZ9CxRR5M0ys4R
 D+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722852023; x=1723456823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0RYDgLdr7HQ010CTBqvRUSBgNA/oE/wNQ3ZQWiob4V0=;
 b=FCF2WkgqVBdFmVB3u1QWqnV45/N3c+679ZR0nlja/G280mJgG9nodN8pejZb8/w42K
 sWQ9p602CCrfGAwnDpuIc5+j9LunyZckDxIvYdAbEmaZLgCwkinMX9QTK9pO9dVVv+Mb
 YLhG7FiBEn5HXgfdg/kRryTwIN6/z/yI+ccmuGKcVaD6+US0zEbgWzb+ytB3BYy2Lx9M
 Rhz2Y5d+c28ryZkz/K0aZbRXg1QoghT+lGfcI2S6f3YBHT506lhuHAkfzh9gj3PbOaFJ
 N28z8ZYlIt8K+8Uc5QXEO3TEXtoq0nfCDjxGpaVkCPzrmfqW9sOZWk9mZG2/jgzwVaxG
 CHxA==
X-Gm-Message-State: AOJu0YxT53RUqRYYn8QyJ+CG0pzapVbQ5o3CVR0TFa44FYRceh2kvx6f
 L+ZvZypec4BHRb5sVzJnZPqG0sUfNvJ7/lr3LCpDNOP3fRKSw4P9RJQfXZyrgu0=
X-Google-Smtp-Source: AGHT+IHXNDNl+zIg6sWNQhhjGql9lmad94AXBbi9U9FyunlQUbMbplTv1kqey8OfMX5KGHjln9qceQ==
X-Received: by 2002:a17:902:e88e:b0:1fb:35c7:8ea4 with SMTP id
 d9443c01a7336-1ff5727c893mr109091875ad.2.1722852023467; 
 Mon, 05 Aug 2024 03:00:23 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff59054759sm63612925ad.150.2024.08.05.03.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 03:00:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 05 Aug 2024 18:59:09 +0900
Subject: [PATCH for-9.2 v13 12/12] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240805-reuse-v13-12-aaeaa4d7dfd2@daynix.com>
References: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
In-Reply-To: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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


