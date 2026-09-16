Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3DEC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kMV-0002HI-VF; Wed, 16 Sep 2026 03:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kMC-0000bf-HX; Wed, 16 Sep 2026 03:47:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kMA-0005OC-R6; Wed, 16 Sep 2026 03:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544619; bh=ZJhRIevipQGcpE9OxfuFapD4TDrvm487gDTJPaFV3m8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HJ+hEgCme571c9YWPI8YL2EoPZVY2JfpN/1MD9SmgRIBw7btOFGlsZNqJDq1FOwtz
 eLYNOiVbTIndDXrh5SoNbb8RPW0dtii4If/QzHaa84nq6QX08QFkU4CyjUaZjZF12V
 WumS3Yn7t8kKkgayErlkDG5P4jjXMA85el1SLK314rhc5EEnMPYpz31zHg8D6TDYgf
 2OJOHawc9BY8bzf4U/F8a4Z+eoSeFhbI7FdgxN2j8ZORH3ZH1GgYlUm2FHazw953ib
 jAi1L688rtl8+pulBxnSktBaI1lFub57MhOt/PJhUV0AavezImTWktjftjNdD7I/PC
 tW18CkfdxPyBg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0FB661D55B9;
 Wed, 16 Sep 2026 10:43:39 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 935EB429B72;
 Wed, 16 Sep 2026 10:44:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 52D7F5A717; Wed, 16 Sep 2026 10:44:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 43/49] virtio-scsi: set dataplane_started to false
 upon failure
Date: Wed, 16 Sep 2026 10:43:01 +0300
Message-ID: <20260916074346.671467-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Commit e24a47c5b73e ("virtio-scsi: do not use vring in dataplane") set
dataplane_started to true when virtio_scsi_dataplane_start() fails. This
is likely a typo since dataplane is not functional after failure.

The non-ioeventfd fallback is broken because dataplane_started is true
after virtio_scsi_dataplane_start() failure. As a result, the following
assertion failure occurs when a virtio-scsi device exceeds the open file
descriptor ulimit when setting up notifiers (eventfds):

  $ ulimit -n 104 # exact number can vary based on QEMU version
  $ qemu-system-x86_64 -M q35,accel=kvm -m 1G -cpu host -smp 14 \
         --blockdev file,node-name=drive0,filename=test.img,cache.direct=on,aio=native \
         --blockdev file,node-name=drive1,filename=data01.img,cache.direct=on,aio=native \
         --device virtio-scsi-pci,id=virtio-scsi-pci0 \
         --device scsi-hd,drive=drive0,bus=virtio-scsi-pci0.0 \
         --device virtio-scsi-pci,id=virtio-scsi-pci1 \
         --device scsi-hd,drive=drive1,bus=virtio-scsi-pci1.0
  qemu: virtio-scsi: Failed to set guest notifiers (-24), ensure -accel kvm is set.
  qemu: virtio_bus_start_ioeventfd: failed. Fallback to userspace (slower).
  qemu-system-x86_64: ../hw/scsi/virtio-scsi.c:1017: virtio_scsi_reset: Assertion `!s->dataplane_started' failed.
  Aborted                    (core dumped)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Fixes: e24a47c5b73e ("virtio-scsi: do not use vring in dataplane")
Buglink: https://redhat.atlassian.net/browse/RHEL-193328
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260825154854.263819-1-stefanha@redhat.com>
(cherry picked from commit 5440b6b5de469f62787f47f2b9177cb1136a85c1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 95f13fb7c28..bcb6e441335 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -230,7 +230,7 @@ fail_host_notifiers:
 fail_guest_notifiers:
     s->dataplane_fenced = true;
     s->dataplane_starting = false;
-    s->dataplane_started = true;
+    s->dataplane_started = false;
     return -ENOSYS;
 }
 
-- 
2.47.3


