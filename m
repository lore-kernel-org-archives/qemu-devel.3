Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51F7E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBBd-0007PF-O8; Fri, 10 Jan 2025 04:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBBA-0007IX-Af
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:45 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBB8-0007Kx-GG
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:43 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so941831f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736500779; x=1737105579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+/NISODu1GRl/Mp6rLZjlsIN+RHbK+6rE+y/BBm/B8=;
 b=pMYoXnAgB1zOLQUqlHMkoy8iuitStQ1TVuarfw4mnSo6gTr3oGWPhQpuDQ8t2+ZVc0
 O+nJUOAbeaxnNqZ9g3x1KcaUoPmuiulqbt3uAWMOiykM3xLjmeIUx4DAmBPjCFjNdeZ/
 XxrAdCP48TWFzn3s9jFOAlthqZbk4mLIxAIMfJflfDva2x6QOZeB38mUh6eOZlBBvDzu
 sBEY5mMQFRCrrKLIn2UlRJF05+xt8tWkxpwx71J4DvkPePvdLQ8Fa/sfbzGtojvONq1E
 rYWhHe3T0/I/tK3tRHjOagtdIpJ9WSk+O6QC9k4ymCv8KBCRHiXCQCMHpVZNdSoOYy7C
 5qFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736500779; x=1737105579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+/NISODu1GRl/Mp6rLZjlsIN+RHbK+6rE+y/BBm/B8=;
 b=lA2D4UsZzl5JXzZ+UJ4oPoHCTy5qZCZl3LtV7IKDKSamxRT/FW4z6hLva6Wd5eKsBm
 t0QVSrnNrVwy6iAyzIczPCDkemLC8U3zlAbJEKPLWkEqeusGoK9U7siteEjASA8pl1QC
 7MSbkL26yIcu5mmV2m63z+77CYECxTQZhDeHdBMc1YYlheDhq4TdAIbsoKOS2JHce78A
 XrOJoNOA72AG+qtYbaBowpsDoPtMWQ1H+61l2a6jGY0/uAfFfWdapkintK2ubhGK4LtT
 XgwCJ0IA25zCdHNKkZMP6A73AOuGkjEArj0s9Ox3nMBBtw0zNsiFSWI76/kuYlSMu3Tn
 SREA==
X-Gm-Message-State: AOJu0Yx+5u9MmpCKCXsz2v+pyV/eg/y8MSIEr6ZKSM2uqM7AXP2oZKrc
 SQD/Ta1N0qF7vIjZB02rQD5NmO+qzyGAbr5Jye+qjtCt9YUUdEDZdUyH+tYzLN77Na0zkHSeEQS
 zMwM=
X-Gm-Gg: ASbGncsz3DZ92Rf/hlwE6y0XSExvzSuIHHmkjICk4uBj1gOavtB4nHrCSJFQYsiMoSv
 AABbco2xDmHngmqjNIdf0TGo3CcuP8TY0oHwq4daJLm2MM2JlfCFXl1OE8Y9I9q87dcFjUCUmQa
 Lk0n+rafoVO8l1o5L87SlNfyWBo/sjP660N5G03MWEn3UREBd/h8LiLh1KmvzeUF+0QwVzFbyzy
 kpkvE0wPiZQ019LVZjIO2E8ePItntoMgQOEn/Z69QHWLqKSYkzwNMrbnG3P5FKO7ueUAv7zOuyb
 YecRLz/ggEuZ2T+j3EX2ZXgcEnmIrD0K5Qmk
X-Google-Smtp-Source: AGHT+IEhk1njiWEUYu53V7hbctQxjIH6qmkWa3YYwrG7U1MgycWR/LACsxsYf6GbWgnjhhPRmF/yqA==
X-Received: by 2002:a05:6000:1acc:b0:385:db39:2cf with SMTP id
 ffacd0b85a97d-38a872c943fmr8316848f8f.12.1736500779275; 
 Fri, 10 Jan 2025 01:19:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03f62sm45803685e9.22.2025.01.10.01.19.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 01:19:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 6/6] hw/qdev: Check machine_hotplug_handler in
 hotplug_unplug_allowed_common
Date: Fri, 10 Jan 2025 10:19:08 +0100
Message-ID: <20250110091908.64454-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110091908.64454-1-philmd@linaro.org>
References: <20250110091908.64454-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Commit 03fcbd9dc508 ("qdev: Check for the availability of a hotplug
controller before adding a device") says:

 > The qdev_unplug() function contains a g_assert(hotplug_ctrl)
 > statement, so QEMU crashes when the user tries to device_add +
 > device_del a device that does not have a corresponding hotplug
 > controller.

 > The code in qdev_device_add() already checks whether the bus has a
 > proper hotplug controller, but for devices that do not have a
 > corresponding bus, here is no appropriate check available yet. In that
 > case we should check whether the machine itself provides a suitable
 > hotplug controller and refuse to plug the device if none is available.

However, it forgot to add the corresponding check to qdev_unplug().

Check the machine hotplug handler once in the common
qdev_hotplug_unplug_allowed_common() helper so both hotplug
and hot-unplug path are covered.

Fixes: 7716b8ca74 ("qdev: HotplugHandler: Add support for unplugging BUS-less devices")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/qdev-hotplug.c |  7 +++++++
 system/qdev-monitor.c  | 14 +++-----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index f6422cd0e4e..e11597acd1f 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -48,6 +48,13 @@ static bool qdev_hotplug_unplug_allowed_common(DeviceState *dev, BusState *bus,
                        bus->name);
             return false;
         }
+    } else {
+        if (!qdev_get_machine_hotplug_handler(dev)) {
+            /* No bus, no machine hotplug handler --> device is not hotpluggable */
+            error_setg(errp, "Device '%s' can not be hotplugged on this machine",
+                       object_get_typename(OBJECT(dev)));
+            return false;
+        }
     }
 
     return true;
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 99b638c0aca..30f28eb8e4a 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -683,17 +683,9 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     dev = qdev_new(driver);
 
     /* Check whether the hotplug is allowed by the machine */
-    if (phase_check(PHASE_MACHINE_READY)) {
-        if (!qdev_hotplug_allowed(dev, bus, errp)) {
-            goto err_del_dev;
-        }
-
-        if (!bus && !qdev_get_machine_hotplug_handler(dev)) {
-            /* No bus, no machine hotplug handler --> device is not hotpluggable */
-            error_setg(errp, "Device '%s' can not be hotplugged on this machine",
-                       driver);
-            goto err_del_dev;
-        }
+    if (phase_check(PHASE_MACHINE_READY) &&
+        !qdev_hotplug_allowed(dev, bus, errp)) {
+        goto err_del_dev;
     }
 
     /*
-- 
2.47.1


