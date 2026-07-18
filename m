Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0715BC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDG6-0005cC-0a; Sat, 18 Jul 2026 18:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDFy-0005II-Js; Sat, 18 Jul 2026 18:11:40 -0400
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.34.181.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDFv-0006rr-Le; Sat, 18 Jul 2026 18:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412695; x=1815948695;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JxsdngGf1vpRbF3WMt96zeeKeAwn2sWQR8YrUeyOLnY=;
 b=cK5C1OZcnXyGKp+npfruL7XgvE3cZH6bEAKgxjj+gMrB75NSqQ83XvqX
 yvh2OWot6L+VnW72Bffsz4E3u43G7Fkcyr/N6TCRfu1t624JAf5RwX68N
 z14+X8vsEN5ddgBRQp7EuSh/048jTl3gzKyQNJYffu1oco6qgeeU6vaIr
 I4Dv/W9xH6jVjbpsLYZFDLr8TmVPe3HvJrTpkNeXOkFwFr6S3j9mKVuiH
 q4txcKSiru5m/EgDw0grVCoh/nniM88nPZ5d4NlMOPJ8l+DtKM28eBFSo
 oh84agWRngwRxsZdoEiNUvsuvKrZL+yyy9Fc6uwr1+BweWRmfuDYq3Czs Q==;
X-CSE-ConnectionGUID: /USlnKMATLWjirLbwFlIyg==
X-CSE-MsgGUID: oE/elDOBSqiXO3d5XSXTHA==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23911384"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:11:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:21933]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.230:2525]
 with esmtp (Farcaster)
 id bf37dde2-f3ee-4628-91eb-0981056ae999; Sat, 18 Jul 2026 22:11:30 +0000 (UTC)
X-Farcaster-Flow-ID: bf37dde2-f3ee-4628-91eb-0981056ae999
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:11:30 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:11:20 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 123/137] hw/virtio,
 hw/display: Parent per-device helper objects
Date: Sat, 18 Jul 2026 21:36:38 +0000
Message-ID: <20260718213652.37673-124-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.34.181.151;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

The virtio-mem system-reset shim, the vhost-user-gpu backend, and
its socket chardev live exactly as long as their enclosing virtio
device.  Parent them under it so they show up in the composition
tree instead of floating with only a refcount.

The unrealize/finalize/error paths switch from object_unref() to
object_unparent(), and vhost_user_gpu_instance_finalize() drops its
now-redundant unref: the vhost-backend is a child<> of the GPU and
is released automatically when the GPU is finalized.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/display/vhost-user-gpu.c | 12 ++++++------
 hw/virtio/virtio-mem.c      |  5 +++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 57360898ca..c2c150bdcf 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -439,7 +439,8 @@ vhost_user_gpu_do_set_socket(VhostUserGPU *g, Error **errp)
         return false;
     }
 
-    chr = CHARDEV(object_new(TYPE_CHARDEV_SOCKET));
+    chr = CHARDEV(object_new_child(OBJECT(g), "vhost-chardev",
+                                   TYPE_CHARDEV_SOCKET));
     if (!chr || qemu_chr_add_client(chr, sv[0]) == -1) {
         error_setg(errp, "Failed to make socket chardev");
         goto err;
@@ -462,7 +463,7 @@ err:
     close(sv[0]);
     close(sv[1]);
     if (chr) {
-        object_unref(OBJECT(chr));
+        object_unparent(OBJECT(chr));
     }
     return false;
 }
@@ -584,7 +585,8 @@ vhost_user_gpu_instance_init(Object *obj)
 {
     VhostUserGPU *g = VHOST_USER_GPU(obj);
 
-    g->vhost = VHOST_USER_BACKEND(object_new(TYPE_VHOST_USER_BACKEND));
+    g->vhost = VHOST_USER_BACKEND(object_new_child(obj, "vhost-backend",
+                                                   TYPE_VHOST_USER_BACKEND));
     object_property_add_alias(obj, "chardev",
                               OBJECT(g->vhost), "chardev");
 }
@@ -592,9 +594,7 @@ vhost_user_gpu_instance_init(Object *obj)
 static void
 vhost_user_gpu_instance_finalize(Object *obj)
 {
-    VhostUserGPU *g = VHOST_USER_GPU(obj);
-
-    object_unref(OBJECT(g->vhost));
+    /* g->vhost is a child<> of obj and released with it */
 }
 
 static void
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 35e03ed759..c45cbdbe32 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1011,7 +1011,8 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
      * we need a dedicated reset object that only gets called during
      * qemu_devices_reset().
      */
-    obj = object_new(TYPE_VIRTIO_MEM_SYSTEM_RESET);
+    obj = object_new_child(OBJECT(vmem), "system-reset",
+                           TYPE_VIRTIO_MEM_SYSTEM_RESET);
     vmem->system_reset = VIRTIO_MEM_SYSTEM_RESET(obj);
     vmem->system_reset->vmem = vmem;
     qemu_register_resettable(obj);
@@ -1023,7 +1024,7 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
     VirtIOMEM *vmem = VIRTIO_MEM(dev);
 
     qemu_unregister_resettable(OBJECT(vmem->system_reset));
-    object_unref(OBJECT(vmem->system_reset));
+    object_unparent(OBJECT(vmem->system_reset));
 
     if (vmem->early_migration) {
         vmstate_unregister(VMSTATE_IF(vmem), &vmstate_virtio_mem_device_early,
-- 
2.47.1


