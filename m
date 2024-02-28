Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3A8C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfID1-00022N-Dq; Wed, 28 Feb 2024 06:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICz-00020D-RR
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:45 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICy-0007LC-7z
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:45 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5e42b4bbfa4so3862375a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120082; x=1709724882;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FEXfVsaC8WiwQLHzBhL9P9YmKLGvJ5rGOGPmQWC7dng=;
 b=j998qUCsPx+oitD0HEn8CCWBacETt2AnJ/6Y5e73bxocx5DYGz2N+cas/zoATmF2ds
 IoKCbl8yZpO1Y3j2m9aYA/pqcStbfbWhUPgjaQXWO+xL38tv22p+nyR2r3HBxGzvwJDw
 zfT2XfJwesgK5S1GPzMXc9jKfJnF48uzDG3q5pcxtehSR4C3At/p/VGL1JDA7tx8SZtD
 jPkhov1W3VvFiiX2jG1ImXRLpFgyDPEgv+6w3c96nrFYpNXA5QuJ9EpeRdKovM3SVgj6
 RpFeaGMzB+L2NfvXVfuecC2ko9J5jRqxovI1LcVpa0D8rMs460dDjTg4lZR1CEg/nfoo
 wZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120082; x=1709724882;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEXfVsaC8WiwQLHzBhL9P9YmKLGvJ5rGOGPmQWC7dng=;
 b=LQwOO+CvOhGC3VaxXGhgRHJulBkKEK5i1C73rgyR1WYNQWJyfA/QsnUpNNGMm647Zu
 VlnlwG6YNSLFs8Z1hDXzKwqoS/8PumzAw4wHi/LKseS3SSR3a5/Yn0Z6xZxb/lMAVxew
 ITRUB0biXCXa90Pl3aJ2791ioKSkrEpwmXrvLN4JHxfp5mBAHmyXu5jOFRsVx+Q+jcZ1
 qnS4IDMmng1qr066IiNTuKEq0MMo68lnICzq5D78KIs33PzP55EzGk0Rb1bAa7zVURPh
 RYpdkAI4B0bZcBxjKeeF7E6jD5fs9gkYmuED14IBlWl/zrgUuGz6gH0Zn8HNxnH9ZIiT
 Ljtg==
X-Gm-Message-State: AOJu0Yy7Xi8+k5ba/bxBWgEY3moc2q5iwvJnxVXbDei77qtFB2A7v7uQ
 J56RmDq1PVR5x6UoowJ2CXEpXW3nFNNWxAaCWNzPRHzpBBi6Cxthou8w8NFxG/0=
X-Google-Smtp-Source: AGHT+IFFd17WvflZaq66nmdvXhJak2r01wCePE4lRX4MR4ZFwBxkTQzNFqyfuq2L79jN7Ut3HwhauA==
X-Received: by 2002:a17:90a:2e88:b0:29a:b6d7:be22 with SMTP id
 r8-20020a17090a2e8800b0029ab6d7be22mr7253532pjd.17.1709120081958; 
 Wed, 28 Feb 2024 03:34:41 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 m14-20020a17090ade0e00b0029a4efc0231sm1373952pjv.56.2024.02.28.03.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:34:41 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 Feb 2024 20:33:26 +0900
Subject: [PATCH v8 15/15] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-reuse-v8-15-282660281e60@daynix.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-0-282660281e60@daynix.com>
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
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 9228e96c87e9..5954404dcbfe 100644
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
index c68d0f7c512f..7349c9a86be8 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -706,7 +706,6 @@ static void device_finalize(Object *obj)
         dev->canonical_path = NULL;
     }
 
-    qobject_unref(dev->opts);
     g_free(dev->id);
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5dd..71c00f62ee38 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -625,6 +625,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
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
2.43.2


