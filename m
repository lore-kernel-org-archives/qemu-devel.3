Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EA1CFA753
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 09:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNgM-0003CM-3N; Fri, 21 Nov 2025 04:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1vMNgI-0003Bt-PG
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:43:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1vMNgG-00053W-VM
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763718231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yGT+Ot+/8cc2vynMchcxei7L9SIL18EKocZzWxPIlIw=;
 b=inQEPPI62yy4LAIlxFAeZw9GqBCS4fBsF3bVQ7QbSHye6B+b6B8HaAySGHcbrvlM0UiH9w
 Vi3i8v1YVMC4PezU6k6J4xjA3X9+3LnLHrKt4OuTpZRXPbdlTq8/RJZm/4L3bQMi8Ue7hi
 NcdH0faQHBraigzLXXOE57QPjvtXkCc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-Ax7Nag_aO92JIVn7LDHFvg-1; Fri,
 21 Nov 2025 04:43:49 -0500
X-MC-Unique: Ax7Nag_aO92JIVn7LDHFvg-1
X-Mimecast-MFC-AGG-ID: Ax7Nag_aO92JIVn7LDHFvg_1763718228
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9280D195608A
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 09:43:48 +0000 (UTC)
Received: from dell-per7625-01.lab.eng.pek2.redhat.com
 (dell-per7625-01.lab.eng.pek2.redhat.com [10.73.212.98])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 338491956045; Fri, 21 Nov 2025 09:43:46 +0000 (UTC)
From: Yanghang Liu <yanghliu@redhat.com>
To: qemu-devel@nongnu.org
Cc: clegoate@redhat.com
Subject: [PATCH v2] Fix the typo of vfio-pci device's enable-migration option
Date: Fri, 21 Nov 2025 17:43:41 +0800
Message-ID: <20251121094341.80038-1-yanghliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Signed-off-by: Yanghang Liu <yanghliu@redhat.com>
Reported-by: Mario Casquero <mcasquer@redhat.com>
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8b8bc5a421..b46b1305a7 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3871,7 +3871,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
                                           "(DEBUG)");
     object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
                                           "enable-migration",
-                                          "Enale device migration. Also requires a host VFIO PCI "
+                                          "Enable device migration. Also requires a host VFIO PCI "
                                           "variant or mdev driver with migration support enabled");
     object_class_property_set_description(klass, /* 8.1 */
                                           "vf-token",
-- 
2.47.3


