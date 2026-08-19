Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3D2C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwbI5-0002Q9-GK; Wed, 19 Aug 2026 04:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wwbI4-0002Pj-0M
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 04:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wwbI2-0004tm-Gi
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 04:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787126688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aUJQYjbpA3tCxEeU6wrxemt4je+T5qjYdApJWVjO/Ek=;
 b=aGLGGiS/sB01rMqQGCed7iWiDgTfbkzv2eF2ypSgq9XVWXYBjHCuT/dNjmFs4Lg1e5RJ/q
 n9KTKkw0Kx2gzuEHZOFGHDQm23o9so/7+0jQJV78MM+XiVgBkBE9LfRCuhEujvfV5t7Z3N
 0PBRYkMFDOddUndkyQLU4qFg+2q5HJE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-hGFUE732NPKGm8MOEOMGKQ-1; Wed, 19 Aug 2026 04:04:47 -0400
X-MC-Unique: hGFUE732NPKGm8MOEOMGKQ-1
X-Mimecast-MFC-AGG-ID: hGFUE732NPKGm8MOEOMGKQ_1787126686
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso5036735e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787126686; x=1787731486; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aUJQYjbpA3tCxEeU6wrxemt4je+T5qjYdApJWVjO/Ek=;
 b=VRye9b7fT71KvxiaP90Jif1j7hgFwEPKL8ZxEsfcBjY4tpeHCLGpkPyFz3GnFgYSZd
 0cnTpIdVCZ0svBqVaCRCqKl2DDaL+hDONnKfAkzDLD1sUvFQPUzjRdPcVyJLmGIOpjX5
 zWp05y2qEUJhTxSX9kMmy+G+0FivN91n9h0bd3hIpnaZC28IMoEqFQDDoUvIUTQcy7RD
 V09L7DcDUb0Zc7qKz1WKuwDzgLzySLjqqQpE1/fAKknqH2/J5qmvOy/4pPsAdW5+RN5P
 vtE0BFIFCC9/Oi53c/5zljlkU+H2kph+po6/u/08sZj7G/p8Y24Fp80h2tQUbvtdTyF9
 a75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787126686; x=1787731486;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aUJQYjbpA3tCxEeU6wrxemt4je+T5qjYdApJWVjO/Ek=;
 b=riTIzbuwyh0yC645eIlY7u0c0A/huAdTn+Ip1mY98JH0vvhnvYmtv8poP+HhPHsmbG
 Ahp/ZWrVqD6O3Vl0WDHdN8iWkkXaJCI6GcSsJ+aVfFPp+s5bRGre2lNA2qNuHVpVOgrD
 Uzz/ByAPLMXpOBn4QLLsXo93ioRzA85ahlZJWarLktlzuFOz/wtujo9+yHpCJtJp+6xg
 JAl02h6pWpca2II5Uafl7fe/tSwkIqi36TLtowbYWERdZ9fuW093LJk0FT9Qyd9H7Bwh
 DsJnHVPBgagDpRWcQ1oArzxLgjAHsAHtotrp6p2ip9qoxxCgQpfyPQM4qyb+bGFZc5J/
 vX2g==
X-Gm-Message-State: AOJu0Yyswvr8UQtSWqvvo38pbY2VXblnJPWPgyyqiKwZd9byq0VeGxF9
 0r+tyILsqx9r7pf14Sojr0wLzwfA7c7GzfRRBqkpGTmE3NQ5G9pMD4CE1Veikgqe5JeJAAWxA6s
 5LO+sN86M1SXlN/R2Hr8QFSiwXNDtLGvGA6SHnWaGIeAve5lgCh+vW29x
X-Gm-Gg: AR+sD10+1DIK6jnYhLaj8jhTDENfeybGy4g0WOtZGnxkNGUSyj5ZKNOF7YKO6CG/lHd
 7H3qCqQZdEIoLGlhRvlyxpY6L8KP/Y+4+sYWO5WUlGsjqDT453hlGg2JNEmRaIFKKaTHvCl37vk
 q2M35m8g9VTyWVQwLJjT2GPsx+2pvxmbknr0wsmTmVlBz4P28TA24buXb9wibUg7ryzMuucOE7A
 P7OhwAnPAxOxHO4+ZiBsKRecCuymjWJY+M/buramyaL55ECWGJKQIUXZxQlaU9nAb30pcHNJOi2
 4Kwjh6zKX0qHxRFj5vBtuWOrHWXI0qSEDm+dL31eLkIYDmRFdqw0OkoJmkIdnReUK7CDJw9WpFE
 OeFpDofE4Mi19mLCcTmgClZvAApBoA9THQ5lV9tEaoyi3tmxxU+y1V8SCBBnWWpWsBp+MXVwCHu
 BC2Y+ZXzTb3NMZ5mqFiF+rZCjKl6VjirF2rT3JSoRV4uu6
X-Received: by 2002:a05:600c:37c6:b0:499:87f3:a2a3 with SMTP id
 5b1f17b1804b1-499aa1c7bafmr49499595e9.15.1787126685711; 
 Wed, 19 Aug 2026 01:04:45 -0700 (PDT)
X-Received: by 2002:a05:600c:37c6:b0:499:87f3:a2a3 with SMTP id
 5b1f17b1804b1-499aa1c7bafmr49498845e9.15.1787126685274; 
 Wed, 19 Aug 2026 01:04:45 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb
 (host-95-233-147-132.retail.telecomitalia.it. [95.233.147.132])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm38560945e9.13.2026.08.19.01.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 01:04:44 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 19 Aug 2026 10:04:42 +0200
Subject: [PATCH] hw/nvme: fix firmware boot path when nvme-ns has a bootindex
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-fix_nvme-v1-1-6d3d5e6909c1@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ML3bTMivi8stxU3RSL5LTERGNjM4tkSyWg8oKiVKAc2Kjo2NpaANh
 nYgVaAAAA
X-Change-ID: 20260818-fix_nvme-d8cfaa3368c9
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

The correct way to register an NVMe namespace in fw_boot_order is to use
the NVMe controller as the device pointer with the namespace ID appended
as a suffix, producing:

  /pci@i0cf8/pci1b36,0010@4/namespace@1,0

This is how the controller-level bootindex works.
Explicit nvme-ns devices instead register the nvme-ns device itself,
which is wrong: realize() reparents the namespace onto the NVMe subsystem
bus, disconnecting it from the controller in the bus hierarchy.
qdev_get_fw_dev_path() therefore produces a path without the controller's
address:

  /nvme-ns/namespace@1,0

Fix by re-registering in realize(), once the controller and final nsid
are known, using the controller as the device pointer with the namespace
suffix. The old entry (registered against the nvme-ns device) must be
removed first since add_boot_device_path() only removes entries matching
the same device pointer, and leaving both would cause a
duplicate-bootindex error.

device_add_bootindex_property() cannot be called in realize() because
QEMU parses command-line properties before realize() runs, so the
bootindex property must exist by instance_init() time. The final nsid is
not yet known then either as it's assigned in realize().

The fix is restricted to non-shared namespaces: for shared namespaces
there is no single controller to register the boot path against.

Also add the symmetric unrealize() cleanup so that hot-unplugging a
non-shared nvme-ns with a bootindex removes the fw_boot_order entry that
was registered against the controller in realize().

Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 hw/nvme/ns.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 7f0f9ac766..83786b4401 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -727,6 +727,10 @@ static void nvme_ns_unrealize(DeviceState *dev)
     nvme_ns_shutdown(ns);
     nvme_ns_cleanup(ns);
 
+    if (!ns->params.shared && ns->bootindex >= 0) {
+        del_boot_device_path(DEVICE(ns->ctrl), ns->bootindex_suffix);
+    }
+
     /* Symmetric with nvme_ns_realize() which sets subsys->namespaces[nsid]. */
     if (subsys && nsid && subsys->namespaces[nsid] == ns) {
         subsys->namespaces[nsid] = NULL;
@@ -891,6 +895,19 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 
     if (!ns->params.shared) {
         ns->ctrl = n;
+
+        /*
+         * Register the boot device path using the NVMe controller
+         * so the OFW path includes the controller's PCI address:
+         *   /pci@i0cf8/pci1b36,0010@<slot>,0/namespace@<nsid>,0
+         */
+        if (ns->bootindex >= 0) {
+            del_boot_device_path(dev, NULL);
+            snprintf(ns->bootindex_suffix, sizeof(ns->bootindex_suffix),
+                     "/namespace@%" PRIu32 ",0", nsid);
+            add_boot_device_path(ns->bootindex, DEVICE(n),
+                                 ns->bootindex_suffix);
+        }
     }
 }
 
@@ -1117,10 +1134,8 @@ static void nvme_ns_instance_init(Object *obj)
 {
     NvmeNamespace *ns = NVME_NS(obj);
 
-    sprintf(ns->bootindex_suffix, "/namespace@%" PRIu32 ",0", ns->params.nsid);
-
     device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
-                                  ns->bootindex_suffix, DEVICE(obj));
+                                  NULL, DEVICE(obj));
 }
 
 static const TypeInfo nvme_ns_info = {

---
base-commit: 9696bf5dc5a5bf0b4a9d05b6cdfe5f13990f97aa
change-id: 20260818-fix_nvme-d8cfaa3368c9

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


