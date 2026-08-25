Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DE3C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wytPb-0001LC-Li; Tue, 25 Aug 2026 11:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wytPa-0001KL-4q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wytPY-0006br-F1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787673002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QFiP7cYJs6osMWTZPzSxL6YtBHQtAPVaGS3ZceAg6zI=;
 b=hVLuMZPWx8wC78gC4Tis0J65x3QaN5s+skCRVL6fUQBpeSj0gF2gncQcB7c+xm7CRbpnBP
 0xg2DyWwy6W3XaCaR616vBlwkao3awafg4lu4NWE+ZBSyf9skOoHvNKac2hCjDZrcbTQdm
 tkHRAyOky/a89GphcECLNJUPyGMttTA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-TSyV5UPpNcyNko7SFHzezQ-1; Tue,
 25 Aug 2026 11:49:32 -0400
X-MC-Unique: TSyV5UPpNcyNko7SFHzezQ-1
X-Mimecast-MFC-AGG-ID: TSyV5UPpNcyNko7SFHzezQ_1787672952
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0012D195604C; Tue, 25 Aug 2026 15:49:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B3AB434; Tue, 25 Aug 2026 15:48:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] virtio-scsi: set dataplane_started to false upon failure
Date: Tue, 25 Aug 2026 11:48:54 -0400
Message-ID: <20260825154854.263819-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/scsi/virtio-scsi-dataplane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.55.0


