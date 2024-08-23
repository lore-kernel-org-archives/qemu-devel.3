Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7702FC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 05:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shMR2-0008Fz-Th; Fri, 23 Aug 2024 01:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMQg-0007UC-SD
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:01:45 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMQe-000059-KA
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:01:42 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2704d461058so1082207fac.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 22:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724389299; x=1724994099;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fEpDPUaFL8zPvYOx/0hsO+TqHl11ExTE7h8t0M0WvV0=;
 b=GgZi0PN7z8eBpLRUTBHRfFYyuMyN/P0pmW5rqQvjEzVThCP7ogwoHE8CWJ9rfb/WEO
 PAgS+6dh96ibzdInXgMRGSz4CbV7HEVuxxFoFyn0Tscf2+sIhpBxo85dlg+N+TZMVTy4
 eRCdOhMS+zPfWJsim5I1NMTPD+8y/p9mDKWkUv44iD9GnQaPrDxPXqWVzgR/GtsZTzI0
 kH25w0B/Ej3Snu3V/mY2L1RKaumhBlGPKP6mJsoSk4yxOz9mjmLCTOXlK1GbpgewNJq8
 aoAhBTHLAJgUk6Xk5Y3DNxsJgtHHyrvR9ndyh9CdJhNeZ6sXh+CyCQ5buXiZ4R5dNXBH
 63DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724389299; x=1724994099;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEpDPUaFL8zPvYOx/0hsO+TqHl11ExTE7h8t0M0WvV0=;
 b=fWuox2urKULSIMC0Hl/1UuNB6eBDPY5iZyfkfq4MOdc2rXHu/hkmo0hBGAtQzinz9c
 PWLGBGy6I/dDGVT9BHlYsIRgMGIiN0WxK844qHHlWdMAUqKeDvtdxmIpSDSU9DyfbSh3
 V5MxyO/TglT74n0wS2OTn/pt1Ds9us5x/M+QtxkRpkc9Tu1by5qU/2oQYhURdcvpCu3s
 Z0mlHNSBcYddS26eHsZC+fVSOQW1zUii+a4WHYqGwZ38DmnPgygSmTBDx8QKbqz7MOq6
 2K2e/F7PRjHz0er1gpPzs+4/0oxQ/vOmyI79jOZw5zqmqkDQe9jNlU+JuwBcfadTgjHJ
 C1BA==
X-Gm-Message-State: AOJu0Yyoeot2yh13y+BQ7eGsefKkSZh9G+IZsz37oRWWNgZvjkLB2GiL
 /FVot0Ee1WCSzVxT1ObhxUhBd1iWaNU1NqoDOjlHJ6nxOEklq1B4ALywfrGovSk=
X-Google-Smtp-Source: AGHT+IEVl7frM7nwY9DbDf52AOeWPAe5yxv7LAhJjay+VgUyoemyBZZyCHZBFG2Fz5XZ7CoulfMaaQ==
X-Received: by 2002:a05:6870:b489:b0:25e:b732:a913 with SMTP id
 586e51a60fabf-273e60158f4mr1108936fac.0.1724389298384; 
 Thu, 22 Aug 2024 22:01:38 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71434309676sm2265621b3a.174.2024.08.22.22.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 22:01:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 14:00:48 +0900
Subject: [PATCH for-9.2 v15 11/11] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240823-reuse-v15-11-eddcb960e289@daynix.com>
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
In-Reply-To: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
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
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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
2.46.0


