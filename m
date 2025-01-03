Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42900E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTit1-0002MK-Ij; Fri, 03 Jan 2025 09:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTisy-0002Lh-0m
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:42:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTisv-0007CI-1u
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735915362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8LoI9OpDsxgB5tZy2fIMS4VsPy9QVHUsmhu4T8JJX0=;
 b=UaeyXBX3wxbVtMyB2Maop/05xvJaQreqdjjrZvAFoaYRmmYbQwfo/w3qHi8dUxbpBd9n3A
 QcrzvKj1T+k6AkUSRF2Cv1eY0eoOktUy2xXdfX4aSzWRhWPiKs27aicvPA/u1/U6gOLNiU
 ie1S+frhuQM6V7+0+hfrS0StArCUxUo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-ZQRriByNPlOFd_bYyUKeag-1; Fri,
 03 Jan 2025 09:42:41 -0500
X-MC-Unique: ZQRriByNPlOFd_bYyUKeag-1
X-Mimecast-MFC-AGG-ID: ZQRriByNPlOFd_bYyUKeag
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E02F9195608E; Fri,  3 Jan 2025 14:42:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D67663000197; Fri,  3 Jan 2025 14:42:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 01/10] hw/s390x/s390-virtio-ccw: Remove the deprecated 2.4 and
 2.5 machine types
Date: Fri,  3 Jan 2025 15:42:23 +0100
Message-ID: <20250103144232.520383-2-thuth@redhat.com>
In-Reply-To: <20250103144232.520383-1-thuth@redhat.com>
References: <20250103144232.520383-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

They are older than 6 years, so according to our machine support
policy, they can be removed now.

This removes the requirements for the storage keys "migration-enabled"
property which will be removed in the next patch. It also removes
the code that sets "max_revision" to 0 for some CCW devices, but
the relating code in virtio-ccw.c indicates that 0 could have also
been in use for other machines types < 5.1, so further clean-up for
code related to "max_revision" won't be done yet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 2be8da2913..bca61488cc 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1325,43 +1325,6 @@ static void ccw_machine_2_6_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(2, 6);
 
-static void ccw_machine_2_5_instance_options(MachineState *machine)
-{
-    ccw_machine_2_6_instance_options(machine);
-}
-
-static void ccw_machine_2_5_class_options(MachineClass *mc)
-{
-    ccw_machine_2_6_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_5, hw_compat_2_5_len);
-}
-DEFINE_CCW_MACHINE(2, 5);
-
-static void ccw_machine_2_4_instance_options(MachineState *machine)
-{
-    ccw_machine_2_5_instance_options(machine);
-}
-
-static void ccw_machine_2_4_class_options(MachineClass *mc)
-{
-    static GlobalProperty compat[] = {
-        { TYPE_S390_SKEYS, "migration-enabled", "off", },
-        { "virtio-blk-ccw", "max_revision", "0", },
-        { "virtio-balloon-ccw", "max_revision", "0", },
-        { "virtio-serial-ccw", "max_revision", "0", },
-        { "virtio-9p-ccw", "max_revision", "0", },
-        { "virtio-rng-ccw", "max_revision", "0", },
-        { "virtio-net-ccw", "max_revision", "0", },
-        { "virtio-scsi-ccw", "max_revision", "0", },
-        { "vhost-scsi-ccw", "max_revision", "0", },
-    };
-
-    ccw_machine_2_5_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_4, hw_compat_2_4_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-}
-DEFINE_CCW_MACHINE(2, 4);
-
 #endif
 
 static void ccw_machine_register_types(void)
-- 
2.47.1


