Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE85C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5OI-0006Nk-Qf; Tue, 07 Jul 2026 08:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5OH-0006N6-JK
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5OG-0006sT-7f
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783429147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0MsinMrsw1Oeu5E3QZ3WnM5GtGatRv2OEk/DgzNYnE=;
 b=SklYU1tsYG8BbSr020U8MjxoSvfGbdfaqCsi2yweUOh0FnZI9BzPaE6/eBTeRultaeGXe+
 CaZMA0DlZrTbpAZELy2+OMCK8eAb9G0qXli/NfNb/QEnPjxYcdwg7kaWZTo8XpOzMYrTp0
 iwUxh4nknnThKSvu/QcsGS8/x6rQ7ME=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-qV51VXBYN-66YKND_IDjLw-1; Tue,
 07 Jul 2026 08:59:06 -0400
X-MC-Unique: qV51VXBYN-66YKND_IDjLw-1
X-Mimecast-MFC-AGG-ID: qV51VXBYN-66YKND_IDjLw_1783429145
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 026AA1944DC5; Tue,  7 Jul 2026 12:59:05 +0000 (UTC)
Received: from gondolin.fritz.box (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C636C1956040; Tue,  7 Jul 2026 12:59:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 05/15] pc-bios/s390-ccw: write IPLB location for non-net virtio
 devices
Date: Tue,  7 Jul 2026 14:58:37 +0200
Message-ID: <20260707125847.1785168-6-cohuck@redhat.com>
In-Reply-To: <20260707125847.1785168-1-cohuck@redhat.com>
References: <20260707125847.1785168-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

When IPL type is PCI, cutype is unknown, so the IPLB location does not
get written to lowcore.  Instead of checking cutype, check if the device
is virtio generically, which covers both CCW and PCI variants.  Net devices
are excluded.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260630141917.673995-6-jrossi@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index fb47d29bb1f2..9c147ac5fa55 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -52,7 +52,8 @@ void write_subsystem_identification(void)
 
 void write_iplb_location(void)
 {
-    if (cutype == CU_TYPE_VIRTIO && virtio_get_device_type() != VIRTIO_ID_NET) {
+    if (virtio_is_supported(virtio_get_device()) &&
+        virtio_get_device_type() != VIRTIO_ID_NET) {
         lowcore->ptr_iplb = ptr2u32(&iplb);
     }
 }
-- 
2.54.0


