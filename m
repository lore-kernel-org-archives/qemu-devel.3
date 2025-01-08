Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E57E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 08:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVRgw-00061T-Qt; Wed, 08 Jan 2025 03:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRgw-000613-68
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRgu-0001l4-Kv
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736325927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gz3v/6EF1DakjN8iH3WKQVxZtElEUxjflajUmI9kip4=;
 b=LEckB5OauQkwAxusLbqNKltlnO8T+MQFiDm74R6rwyLofascGnDCM+yGbAAARpSuZ6/K45
 8KzhjfgGF2cmfWVGfk5UzOLNS64N2QNTazfNQv9xjg3IPivAeEShoXbmJJQxfdD65Yxg5H
 wZmGO8UXUdwGHs5g2bZ8TtKAvSaIVIc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-h6rW1vZoOvGSiAD5BNVbPA-1; Wed,
 08 Jan 2025 03:45:21 -0500
X-MC-Unique: h6rW1vZoOvGSiAD5BNVbPA-1
X-Mimecast-MFC-AGG-ID: h6rW1vZoOvGSiAD5BNVbPA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B2B319153C2; Wed,  8 Jan 2025 08:45:20 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-228.str.redhat.com
 [10.33.192.228])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EED2C19560AA; Wed,  8 Jan 2025 08:45:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PULL 02/14] hw/s390x/s390-virtio-ccw: Remove the deprecated 2.4 and
 2.5 machine types
Date: Wed,  8 Jan 2025 09:44:59 +0100
Message-ID: <20250108084511.238458-3-thuth@redhat.com>
In-Reply-To: <20250108084511.238458-1-thuth@redhat.com>
References: <20250108084511.238458-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

They are older than 6 years, so according to our machine support
policy, they can be removed now.

This removes the requirements for the storage keys "migration-enabled"
property which will be removed in the next patch. It also removes
the code that sets "max_revision" to 0 for some CCW devices, but the
relating code in virtio-ccw.c indicates that 0 could have also been in
use for other machines types < 5.1, so further clean-up for code related
to "max_revision" won't be done yet (see also commit d55f518248f -
"virtio: skip legacy support check on machine types less than 5.1").

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20250103144232.520383-2-thuth@redhat.com>
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


