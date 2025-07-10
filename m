Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4036EC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZomz-0001zJ-FH; Thu, 10 Jul 2025 06:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomm-0001rr-Gq
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:56 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomd-00078P-IZ
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-453634d8609so4776625e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144339; x=1752749139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1lONaDCGcDF8Vf2dQSf345RzEHUxlyX4PcTEZfK8bc=;
 b=eIiaPVXZ+TImU06oLM5pJYqSCgTF7Ta6a7H/ojRZQ+LZVCI+v1abe3wj5H7xaDpmwi
 K/2SbcnafMWSsp+jnJ7se9siFCizWVRBoR61r5XyVyYS92v5GDUIWd1yH8lQWhmmXDkz
 t/mQ7YnKHws8DMLJHTGkOs0f47kacV8G7Ena32xObT+hG2hxq/R+ewvavqZSM04AEOox
 h22y6fdYOz9/XMbn7i7SB2Dyd60WCaPwQTIndtDJJ3wnw8cOIf5p3HyMM84hwpAOgtmc
 Abge8F8nAAg5gb/ae75jHG5RUancu9YrXhXbdncC1NJXYRfWJD47O4lCDvkN7u6ZPzbV
 C4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144339; x=1752749139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1lONaDCGcDF8Vf2dQSf345RzEHUxlyX4PcTEZfK8bc=;
 b=gdWUSv4UrXpRE3ygH6Upg8PEm1jWu3fqL6WV2Yy4CN37XsFzbBHsJ8W0ubMGNv7amt
 /+P9H0/b7RO7eYF/8hAFQwylJSiawpCIJ/TkOED0kULJ67ARYK4r9gUg7QEBmZ9R4ub+
 W5c5GzztDve4AteHUxkUPNX16x34wBPRdY/0G3RsFWqnO9PtiYDxWwE5Mlo5JqWjqDxx
 xFq7h5BI4E9JCPdIr8JQOUi6wlA6JpyXazJ083POe1HSAr02hkRdncGzrbJz7FZ5cmcV
 cy7uPK555lsVJNsqRcAlWaTUqPYWUQPHBCYLC5hZvGBfChJpBBq7Ch1tMLcbRD10h4aa
 +rYQ==
X-Gm-Message-State: AOJu0YyMoM7J4/9SpJCIGfRtLjfPKnvndEq1YyuuyjJOuuEM5wo3wF56
 1McHPKyb94ywVquc10ss1vJgpRNM+VYnLAniRptgvEjuc2xQGy+/UtlkrRClti5KogI=
X-Gm-Gg: ASbGnct7Iox+RnF6Nc7EzjS8yUsn73v/vZ+Meg2FPyY9cMw9mq3Q+JUbiPxpBAYORjr
 NEGVKh2yUi8/Ow0irYeNkhNfc5tqWZWnUWV55+uhBR3tLMt6FqZH1+MevDsXMfzdMTk4Lj5t6De
 h1HAIlwWNnXt8Ofb6LMfbTrCX4Uk3ProRlgUPIbKx4VYIgNnHLehtJgHdkb/jNPJF7OFHVrnPZr
 gK8rkpcDs3DKR1LatRUFfaXZ+ip36LygQYFfsjZndG61yxGvBCP+0p+vxQNeEq6DGfNQGE6ncR/
 suuto9eWIakXqnueI+3G3eOYztalC65O/oRMi3t2+TJfFNw7kjTexloaOgCElPw=
X-Google-Smtp-Source: AGHT+IHO7PxjfZO7RtVnQlPFZRSaZVs6hRhnMDeQzkKHslS/UfaLWsb7RSXMFKgtd0e2NW4Sgbc8HQ==
X-Received: by 2002:a05:600c:4454:b0:450:cac5:45e7 with SMTP id
 5b1f17b1804b1-454d52db8efmr54057855e9.1.1752144339127; 
 Thu, 10 Jul 2025 03:45:39 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df5a1sm54634875e9.22.2025.07.10.03.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 03:45:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC9645F8CE;
 Thu, 10 Jul 2025 11:45:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 7/7] docs/system: clean-up formatting of virtio-net-failover
Date: Thu, 10 Jul 2025 11:45:30 +0100
Message-ID: <20250710104531.3099313-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710104531.3099313-1-alex.bennee@linaro.org>
References: <20250710104531.3099313-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We didn't clean-up the rst formatting when we moved this into the
docs so lets do that now:

 - un-indent the usage/hotplug/migration paragraphs
 - properly wrap the command line fragments in code-block
 - highlight parameters in text with ``double quotes``

No changes to the actual text.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/virtio-net-failover.rst | 51 ++++++++++++++++-------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/docs/system/virtio-net-failover.rst b/docs/system/virtio-net-failover.rst
index 6002dc5d96..0cc465454c 100644
--- a/docs/system/virtio-net-failover.rst
+++ b/docs/system/virtio-net-failover.rst
@@ -26,43 +26,48 @@ and standby devices are not plugged into the same PCIe slot.
 Usecase
 -------
 
-  Virtio-net standby allows easy migration while using a passed-through fast
-  networking device by falling back to a virtio-net device for the duration of
-  the migration. It is like a simple version of a bond, the difference is that it
-  requires no configuration in the guest. When a guest is live-migrated to
-  another host QEMU will unplug the primary device via the PCIe based hotplug
-  handler and traffic will go through the virtio-net device.  On the target
-  system the primary device will be automatically plugged back and the
-  net_failover module registers it again as the primary device.
+Virtio-net standby allows easy migration while using a passed-through
+fast networking device by falling back to a virtio-net device for the
+duration of the migration. It is like a simple version of a bond, the
+difference is that it requires no configuration in the guest. When a
+guest is live-migrated to another host QEMU will unplug the primary
+device via the PCIe based hotplug handler and traffic will go through
+the virtio-net device. On the target system the primary device will be
+automatically plugged back and the net_failover module registers it
+again as the primary device.
 
 Usage
 -----
 
-  The primary device can be hotplugged or be part of the startup configuration
+The primary device can be hotplugged or be part of the startup configuration
 
-  -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc, \
-    bus=root2,failover=on
+.. code-block:: shell
 
-  With the parameter failover=on the VIRTIO_NET_F_STANDBY feature will be enabled.
+  -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,failover=on
+
+With the parameter ``failover=on`` the VIRTIO_NET_F_STANDBY feature will be enabled.
+
+.. code-block:: shell
 
   -device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,failover_pair_id=net1
 
-  failover_pair_id references the id of the virtio-net standby device. This
-  is only for pairing the devices within QEMU. The guest kernel module
-  net_failover will match devices with identical MAC addresses.
+``failover_pair_id`` references the id of the virtio-net standby device.
+This is only for pairing the devices within QEMU. The guest kernel
+module net_failover will match devices with identical MAC addresses.
 
 Hotplug
 -------
 
-  Both primary and standby device can be hotplugged via the QEMU monitor.  Note
-  that if the virtio-net device is plugged first a warning will be issued that it
-  couldn't find the primary device.
+Both primary and standby device can be hotplugged via the QEMU
+monitor. Note that if the virtio-net device is plugged first a warning
+will be issued that it couldn't find the primary device.
 
 Migration
 ---------
 
-  A new migration state wait-unplug was added for this feature. If failover primary
-  devices are present in the configuration, migration will go into this state.
-  It will wait until the device unplug is completed in the guest and then move into
-  active state. On the target system the primary devices will be automatically hotplugged
-  when the feature bit was negotiated for the virtio-net standby device.
+A new migration state wait-unplug was added for this feature. If
+failover primary devices are present in the configuration, migration
+will go into this state. It will wait until the device unplug is
+completed in the guest and then move into active state. On the target
+system the primary devices will be automatically hotplugged when the
+feature bit was negotiated for the virtio-net standby device.
-- 
2.47.2


