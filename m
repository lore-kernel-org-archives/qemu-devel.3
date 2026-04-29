Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F85FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB7t-0003V0-PN; Wed, 29 Apr 2026 16:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QR-00087h-8u
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:03 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QN-0007gs-VQ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:02 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so7861526f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777471078; x=1778075878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i55Tulez84uC6S30BzMAZAX+g+KufDCaRfey8FY/Ij4=;
 b=AjgfJkzQuv9875UMnxr7oiePC2iOaA3LUlWzD5QQfhtMPtxPewMd96Tnv6kjc+6stn
 ougsQUUQ9ZoulwOOlUtgBdrm0R1qlDyQUGdqu3XLnXghjA4eJaa8BOIKK3KxHIldbCsF
 QCaMQLUYZFUZN5euRl8trySjS6bUow4DUZjHz5x2eekKSYbKwzyzI61RX3Nz7utRC8in
 I2qSeJG2MqOtTfcL+aOfXwt6DBHEOAt+P4Hulsu7N3VdpcEHQGGCJjwiW3wMTAbmqiPO
 iNGXCltdHLdijCSMSGzmBnmtOnWbdK0UabSwW3++wHhOVEK5JhQpH1jtag0NbfKhOVGD
 RzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471078; x=1778075878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i55Tulez84uC6S30BzMAZAX+g+KufDCaRfey8FY/Ij4=;
 b=qFguAHw5vKgjxIPOPf1VTsKlvdGVxPdh47voKQoBmneCbIoutvQacIxYqfNxl3a7gv
 3KBsnyK7xUDbblbMeg6/KtbASOp8Jf6HUJZhEwyiJ6/OSsb7EC9rEW2ZzQT+52jM0T+a
 XwzaIZeMg5nOwIQWDd0JwElPv3+h6w1TAk1uPK9lahP2ku4B5DkFmzOoHamPyR8/hKBO
 TRgIOFbY00zXikOLsI2fRGZvOih8TzpGu0OtjSlImsPlncMVeiqocAAkn9YLuBke7mvs
 HtSenEbKJYYYmEBoe8ESyJEipqhJPl5hZHrWXXaP/HzY5Qu0j81DoxAbd2qQ1gUpNOjj
 aAaw==
X-Gm-Message-State: AOJu0Yyaan91Ai+LHaz67AR7MklXhG3X7byG1XqLJ0k/6OZAQ2LpXjfV
 D2/OedbL2wyn5pM3qSq1rz/LHaLB8eCjYlnrPib/qgcuQqafWhXuWGnGNz3fzmBg
X-Gm-Gg: AeBDieuDLIYp33Do3T41kjln/whi30Px6hOLCXWbOlFW/akcpmHlNPY3Dtg1w5LP/HD
 OLdFnmhXvq1UpTmalJC96hnjPN1gstnLnk3kpScjMeh3I1X+EItDo6qrnzdV372TASuKCq8b6pY
 Flux34acy3HaUOY1kAtfuF+27sc2yUm4uEZ8NeOJnfbBcQoT+4V/MeamaXm8sD1qdbGfrbuAn5X
 M2Du2C2G6oKz/Mb6yl4ZKdeTJ7dNFBDKh8hrAcWgjzYkEgfNfSBUu4Bdyp5TtGYA6Da7/z0qUho
 QMpZe9WZKMwrSwbirrXm6lPtvqO7XKE7TfyNI1AGHqOTMg2GKL4O6kf7konNq4JScnJcDoO0dYi
 +U/u8V9o76t9CSrPVw4JuBTgtjSBB7kbevA8DcU7OyGpt8WTmOdtRrpzNLEaL96sTz5TqTT40J8
 d7lv6+lr51NJl9/DaJysfv8ZqNYqmZ+OHW244kSIDffD2OgFXXWQ0gSARHO4/VUmzAze6+SMbt
X-Received: by 2002:a05:6000:2304:b0:43d:75ec:26f7 with SMTP id
 ffacd0b85a97d-4464aced724mr14325698f8f.29.1777471077272; 
 Wed, 29 Apr 2026 06:57:57 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk.
 [130.88.198.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:57:56 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 arpit1.kumar@samsung.com, Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 02/10] qdev/qbus: Allow hidden devices to be busless
 on QEMU startup
Date: Wed, 29 Apr 2026 14:48:36 +0100
Message-ID: <20260429135717.3048713-3-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=joshualant@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:14 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Extend the capability for hiding devices, introduced for virtio-net
device in:

commit f3a8505656935cde32e28c1c6317f725084da1e0
Author: Jens Freimann <jfreimann@redhat.com>
Date:   Tue Oct 29 12:48:55 2019 +0100
qdev/qbus: add hidden device support

Currently only endpoint devices can be hidden with a primary device
and failover (known static configuration). However, looking at future
composable systems, we see a need for hidden devices which have no associated
bus upon boot. Move the check for hidden devices to before the bus
search, and if it is hidden ignore the case where the device was
described on the CLI without the "bus=" field.

This is motivated by a specific use-case: implementing the VCS
command set, part of the CXL specification (CXL r3.2 Section 7.1.3). In
this scenario a switch controlled by a Fabric Manager is able to change the
virtual hierarchy of devices seen by a guest within a fixed physical system
topology. The connecting bus is not known until runtime when
a bind command is issued by the Fabric Manager.

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 system/qdev-monitor.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index f2aa400a77..b51dfe0645 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -650,6 +650,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     DeviceState *dev;
     BusState *bus = NULL;
     QDict *properties;
+    bool hide_device;
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
@@ -663,6 +664,11 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         return NULL;
     }
 
+    /* Is the device hidden from the guest?
+     * If yes, no need to find a default bus if none given...
+     * Bus could be provided at runtime (i.e. in a switch)*/
+    hide_device = qdev_should_hide_device(opts, from_json, errp);
+
     /* find bus */
     path = qdict_get_try_str(opts, "bus");
     if (path != NULL) {
@@ -675,14 +681,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
                        driver, object_get_typename(OBJECT(bus)));
             return NULL;
         }
-    } else if (dc->bus_type != NULL) {
+    } else if (dc->bus_type != NULL && !hide_device) {
         bus = qdev_find_default_bus(dc, errp);
         if (!bus) {
             return NULL;
         }
     }
 
-    if (qdev_should_hide_device(opts, from_json, errp)) {
+    if (hide_device) {
         if (bus && !qbus_is_hotpluggable(bus)) {
             error_setg(errp, "Bus '%s' does not support hotplugging",
                        bus->name);
-- 
2.47.3


