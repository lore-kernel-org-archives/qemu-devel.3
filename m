Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EFFE77197
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyzG-0003Ta-2j; Sat, 04 Jan 2025 02:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyx-00034H-MY
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:54:06 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyw-0003C9-7g
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:54:03 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so228869455ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977241; x=1736582041;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fLF5NIhJzJ88eyADmFhWZLwmz6xmXA70tRWoalaM1Gg=;
 b=fh0oy/EyJGDSv6a2i4lT4KQnHxJQF7AnPJok4i3PJ19uAlhEMoiez4xGKB0ofALAg0
 4yj3Yy9kOAeed140tM//AlKumbKLsfNsAbABAQevX1R6jj8nrrczMq1IEqzB7mUPhQaB
 9LB9PFdZBVf/WMuRaaShi+e49X8e6/dSIwDDIK2pzr1TmoAzGPpzxnjRh/27X+RroKra
 tpNI46efxaPlX0uGMlT/VYPWFLVZR0/0t+zka3weJV0KeMToj/kondZOd4cW0bYSOxlm
 wxfRonGTRiy+4gQm3/55UgUXYzHyo8uZDqrFgaJ2cHUwAkY7TMT5cWyp3qKTMnsoEdyM
 23SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977241; x=1736582041;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLF5NIhJzJ88eyADmFhWZLwmz6xmXA70tRWoalaM1Gg=;
 b=hAbTbxFQ4DJx8ss5qAt0bndTEe/CREY9Udb4C8lptXB2RSYc+YF7lX3rJNYncRu3tJ
 NoFqbKxLvgYcHikEtpWxQmnSXSnUo8oGaAB2MsdxSQI78IUKgUPO5DqyVEaMGr6p+dww
 mDhkIOyDUEqY3FqWw7hkKZEm2ZcmMwj0ROTlbKpS4ZPRcjEXAJGObiLrBBmW4bdPkCM2
 9vTGDt5PClE0nxosa4Kg/zyJ1fbyeWZ0P0HqliRaMtKbI8EsKnqJ8psrhZrtb2sh3QMh
 pi1TTOB3yzqzT/eUlfI6UUkx99UQCB+4470F+X55pWt4q2Hwf45p6ZmW07NjXPIEdKXw
 iWRg==
X-Gm-Message-State: AOJu0YyMIx6sfncXpCSybFoQ806pSI72kRnfc73F7T+Us5GhwfE9Uwm6
 WCjXu6soB0br/9YtyjbmcqXsyOJNvqZsfTYbqKF7CQyk97NanptzNutJXQjnyMo=
X-Gm-Gg: ASbGnctVWHTXtGlt724VGiKhqPY3M54HACHbmy7iJOI0M5AHei75hSKAyM9VLDxihQo
 RvM9x98gO9XFZRnQq18Gb0CPqd1zdLBtQmAyJ+dQZ7Pl3ZjUl+qpkba+lXDu8Hp09FJ+IOyNXVk
 9vwdGjddRgofZjp/0aOu9iz26tL+QsVkOtcKisBUvB3F7+LTTFsHoCOmTO1bapZJnMOBJ37NQyF
 ZsXhhvwa1vkSz/3UC/IMqae1qIKNhoNdCcar7ZfR9pdMENrO8imwOguh/3O
X-Google-Smtp-Source: AGHT+IFPOJd+xpSweaEnqUnsCRPHMHngvT2PtFwPulptdfKFZo0ZfS8DUhuzawzOwMSRQG/VkFS0gQ==
X-Received: by 2002:a05:6a21:3a4b:b0:1e4:8fdd:8c77 with SMTP id
 adf61e73a8af0-1e5e044db75mr88533826637.8.1735977241001; 
 Fri, 03 Jan 2025 23:54:01 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-842b1ce1fd5sm25282421a12.25.2025.01.03.23.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:54:00 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:34 +0900
Subject: [PATCH v18 14/14] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250104-reuse-v18-14-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index e6ef80b7fd0e..c4d3dc39064c 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -248,10 +248,6 @@ struct DeviceState {
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
index 57c1d9df3a7f..09c4489e3c41 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -691,7 +691,6 @@ static void device_finalize(Object *obj)
         dev->canonical_path = NULL;
     }
 
-    qobject_unref(dev->opts);
     g_free(dev->id);
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index c844f5380255..6a38b5678760 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -631,6 +631,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     char *id;
     DeviceState *dev = NULL;
     BusState *bus = NULL;
+    QDict *properties;
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
@@ -712,13 +713,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
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
2.47.1


