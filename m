Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC35C52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZkhX-0007u4-SG; Fri, 02 Aug 2024 01:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkhV-0007kg-Lj
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:19:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkhT-00070Z-Jt
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:19:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fd65aaac27so20889545ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 22:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722575974; x=1723180774;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0RYDgLdr7HQ010CTBqvRUSBgNA/oE/wNQ3ZQWiob4V0=;
 b=XtZ1g8JqBzX0FYFoyj4Nz6/zHzalerpjrEbyC1aOwTZLhYU2zK5WtTK45CC4+GjdwP
 fUg8uDhhz2Z5tfozJ/ydXRtXPfn0dfugV24IjQVWVGmhuuSXmp31vwDRApolu7HgGXMM
 tFqCttFgXQXOFnRD8dbQwu7hUW7dpI+cP/NNHfZ9ZZPj+7QsCbEx1b2VmUUFhi727ao+
 UChIIQKMM+WJOTfGUG4w6HGzHwMDwUOWDUyONuDg/4F+7uxlhN1seSi3wl8HxzAzoSU7
 s5FOj2pU/N+0kjGDM8a7qM9v/I7f/zYOX/J//kvX8y3dN+mOY24CHpj+fa6ldkPVOema
 9shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722575974; x=1723180774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0RYDgLdr7HQ010CTBqvRUSBgNA/oE/wNQ3ZQWiob4V0=;
 b=DvWVhw9MbNrd1uhYFwDB/XusnnYdTGY247PdHuvdksCmSJMYY6zf1A3Ja3pwiLfwWp
 ixXkRL68r9S2/gYFauVnBmjH8mgaKtJQQlG377VSEi90zdbcWnL8xiRVBxnRM604rolL
 EiIxPCuXa+YhGqpkULpnxbcDurbmrTBLpcyJtwTDqWdlfwvcfa+D7Iq560K7hI4xDinF
 y+7gpruW9pknP6avqItb+pJdXRgj34USfX956uGaARMIDjeWS/LaBZxsJJmTCUMqSL+f
 rMewbTZSFscJmqEQvIVUqLMZ7HqJNppHg7lz+JYPUMvQykJnxJxvSBXSJHOTpskCH/U6
 EPKg==
X-Gm-Message-State: AOJu0YzkC5mygTqge2utVZhIaAuOXqQ0teBoyshdFdp+C4uBOlTYEFog
 BwJCzR98ykNuWTexsFLH/3mbL/RAYt/dMvq3nfbBdnw1YdHl3QI9f5yDRZMhBMU=
X-Google-Smtp-Source: AGHT+IEDYHPvHBQL+TTvTJTSvHIjVBsC1UHTTOyjd66+dQwL02gyRtvLyK4DiPHH7qZRais7zdk0wg==
X-Received: by 2002:a17:902:e5cb:b0:1fb:6ea1:6e with SMTP id
 d9443c01a7336-1ff5240bc5fmr50314765ad.9.1722575973716; 
 Thu, 01 Aug 2024 22:19:33 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff58f62e7asm8094375ad.115.2024.08.01.22.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 22:19:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 14:18:01 +0900
Subject: [PATCH for-9.2 v11 11/11] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240802-reuse-v11-11-fb83bb8c19fb@daynix.com>
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
In-Reply-To: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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


