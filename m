Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F074CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVyx-0002Lm-7X; Fri, 05 Jun 2026 10:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wVVyv-0002I0-2N
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wVVyt-0005RT-G5
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780671426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1H54cbYr+2kxG39h62zVmDx+o5zE08Ape6GxPEWxv2M=;
 b=Ae/o5a4S7hbEPwCOVAOWyvg1VSq3nk0TpVW3TS9eTtanR+Hm+SOxSNvTTIN5XgEc7q0Kmz
 EFsmSjXbaqz6yrULuJYWDkFSzinqAKJ1zQMdeKFdbGlBl1AXwjRpwixLI4Yc8Lj/Zmjxjx
 HaKOwwUnZEIaCnuoJ6FfBkWgCowl3Eo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-zeqxYuc3NdWULbKdLmFwnQ-1; Fri,
 05 Jun 2026 10:57:02 -0400
X-MC-Unique: zeqxYuc3NdWULbKdLmFwnQ-1
X-Mimecast-MFC-AGG-ID: zeqxYuc3NdWULbKdLmFwnQ_1780671421
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 775E419560A7; Fri,  5 Jun 2026 14:57:01 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.48.119])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5853180049F; Fri,  5 Jun 2026 14:56:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jaehoon Kim <jhkim@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 3/7] hw/s390x/ccw: Mark virtio-pci disable-legacy property as
 optional
Date: Fri,  5 Jun 2026 16:56:43 +0200
Message-ID: <20260605145647.272621-4-cohuck@redhat.com>
In-Reply-To: <20260605145647.272621-1-cohuck@redhat.com>
References: <20260605145647.272621-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jaehoon Kim <jhkim@linux.ibm.com>

The s390-ccw-virtio-11.0 compatibility property for TYPE_VIRTIO_PCI
"disable-legacy" causes QEMU to abort when instantiating
vhost-user-fs-pci devices:

  Unexpected error in object_property_find_err() at
  ../qom/object.c:1284:
  qemu-system-s390x: -device vhost-user-fs-pci: can't apply
  global virtio-pci.disable-legacy=off: Property
  'vhost-user-fs-pci.disable-legacy' not found

The issue occurs because some vhost-user devices like
vhost-user-fs-pci only implement the non-transitional variant
and do not define a generic device type. Non-transitional
devices have disable-legacy hardcoded to "on" and do not
expose it as a property, while only generic device types have
the "disable-legacy" property. This affects users running
older machine versions (11.0 and earlier) even when using the
latest QEMU version.

Mark the global property as optional so it only applies to
devices that actually have the property, allowing vhost-user
devices without a generic variant to be instantiated
successfully on older machine versions.

Fixes: 26103c13cff0 ("hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+)")
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260520183403.223983-1-jhkim@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4d35f9b10bcc..25a9fa495540 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -946,7 +946,7 @@ static void ccw_machine_11_0_class_options(MachineClass *mc)
      * keep legacy virtio-pci enabled.
      */
     static GlobalProperty compat[] = {
-        { TYPE_VIRTIO_PCI, "disable-legacy", "off" },
+        { TYPE_VIRTIO_PCI, "disable-legacy", "off", .optional = true },
     };
     ccw_machine_11_1_class_options(mc);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-- 
2.54.0


