Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F64C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 09:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq7eW-0008Vx-QD; Thu, 06 Mar 2025 04:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq7eT-0008V4-I0
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:36:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq7eP-0002Bs-6a
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741253779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yP/PaM17UPhBQJ0EU53NAP8JmA2pDk/19m9YkL3FKMQ=;
 b=ImaN777K4rE71M0rmCDGDZDOcJIY/Vn0iD2LFgNrkVPoKU8WRrsqPdQl0pEAUP6/QM7Tqa
 0bDBXn2esHCoZ1Py2rQ1YPJmasP1HKC1PZT9usrce39r1phQtNrntFyKJ4uXx0UrMulEUd
 j28QoHCnOf8C9sdJ4HgZ8MEMjePDBMk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-Wpt90_OhONGDX8YSPLzNUg-1; Thu,
 06 Mar 2025 04:36:09 -0500
X-MC-Unique: Wpt90_OhONGDX8YSPLzNUg-1
X-Mimecast-MFC-AGG-ID: Wpt90_OhONGDX8YSPLzNUg_1741253768
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 665681956087
 for <qemu-devel@nongnu.org>; Thu,  6 Mar 2025 09:36:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BD521956096
 for <qemu-devel@nongnu.org>; Thu,  6 Mar 2025 09:36:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D609B21E6561; Thu, 06 Mar 2025 10:36:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/10] qdev: Improve a few more PropertyInfo @description
 members
Date: Thu,  6 Mar 2025 10:36:00 +0100
Message-ID: <20250306093601.2264772-10-armbru@redhat.com>
In-Reply-To: <20250306093601.2264772-1-armbru@redhat.com>
References: <20250306093601.2264772-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250227085601.4140852-7-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/block/xen-block.c             | 2 +-
 hw/core/qdev-properties-system.c | 2 +-
 hw/core/qdev-properties.c        | 1 +
 hw/s390x/ccw-device.c            | 4 ++--
 target/sparc/cpu.c               | 1 +
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 7c9d1b658c..2098286b5f 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -662,7 +662,7 @@ invalid:
  */
 static const PropertyInfo xen_block_prop_vdev = {
     .type  = "str",
-    .description = "Virtual Disk specifier: d*p*/xvd*/hd*/sd*",
+    .description = "Virtual Disk specifier (d*p*/xvd*/hd*/sd*)",
     .get = xen_block_get_vdev,
     .set = xen_block_set_vdev,
 };
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6d7dcf368d..a7dde73c29 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -985,7 +985,7 @@ inval:
 
 const PropertyInfo qdev_prop_pci_host_devaddr = {
     .type = "str",
-    .description = "Address (bus/device/function) of "
+    .description = "Address (bus:device.function) of "
                    "the host device, example: 04:10.0",
     .get = get_pci_host_devaddr,
     .set = set_pci_host_devaddr,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5a801057db..c04df3b337 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -247,6 +247,7 @@ static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
 
 const PropertyInfo qdev_prop_bool = {
     .type  = "bool",
+    .description = "on/off",
     .get   = get_bool,
     .set   = set_bool,
     .set_default_value = set_default_value_bool,
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 1d4b8ea35c..1ea9934f6c 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -75,8 +75,8 @@ static void ccw_device_set_loadparm(Object *obj, Visitor *v,
 
 const PropertyInfo ccw_loadparm = {
     .type  = "str",
-    .description = "Up to 8 chars in set of [A-Za-z0-9. ] to pass"
-            " to the guest loader/kernel",
+    .description = "Up to 8 chars in set of [A-Za-z0-9. ] to select"
+            " a guest kernel",
     .get = ccw_device_get_loadparm,
     .set = ccw_device_set_loadparm,
 };
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index c8ea35be76..f0613f8a8e 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -939,6 +939,7 @@ static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo qdev_prop_nwindows = {
     .type  = "int",
+    .description = "Number of register windows",
     .get   = sparc_get_nwindows,
     .set   = sparc_set_nwindows,
 };
-- 
2.48.1


