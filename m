Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB505606B336
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FtlvyL7h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwFo-0007vS-IX; Fri, 13 Nov 2026 13:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFB-0007GA-1N
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwF8-0005PA-Lx
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPGhFgf14jh1st9xVEg94b3SvHhq7SUynqKsdgm3ZX0=;
 b=FtlvyL7h8dkmnLagt9Ofqw3jrdtI4BW//F0UnU1f5iAfbOdNNFF2hfqaFUrj6axmBzzGRh
 DBwf/NYknDS86vHSHYupobzorOREQ4nYSd5k4lt+MNYCwwb1r+zYjNtICPPRdQIDYR6In2
 s4WYYwFq+VJOXObHnmeUM2V+rR0tIgY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-WnRysJCiOxe7QkTyJb1AIw-1; Fri,
 13 Nov 2026 13:43:19 -0500
X-MC-Unique: WnRysJCiOxe7QkTyJb1AIw-1
X-Mimecast-MFC-AGG-ID: WnRysJCiOxe7QkTyJb1AIw_1794595398
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 804931956064
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:18 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 403CA1955DB9; Fri, 13 Nov 2026 18:43:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 11/26] hw/scsi: mark SCSI disk endpoint devices as secure
Date: Fri, 13 Nov 2026 18:42:39 +0000
Message-ID: <20261113184254.2524253-12-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All these devices can be used together with supported SCSI controllers
in a virtualization use case, so must be treated as secure.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/scsi/scsi-disk.c    | 3 +++
 hw/scsi/scsi-generic.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index de2b6d85da8..a2df3a4ec46 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3378,6 +3378,7 @@ static const TypeInfo scsi_hd_info = {
     .name          = "scsi-hd",
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_hd_class_initfn,
+    .secure        = true,
 };
 
 static const Property scsi_cd_properties[] = {
@@ -3421,6 +3422,7 @@ static const TypeInfo scsi_cd_info = {
     .name          = "scsi-cd",
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_cd_class_initfn,
+    .secure        = true,
 };
 
 #ifdef __linux__
@@ -3463,6 +3465,7 @@ static const TypeInfo scsi_block_info = {
     .name          = "scsi-block",
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_block_class_initfn,
+    .secure        = true,
 };
 #endif
 
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index e48fcb926f1..747a0aa61be 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -1259,6 +1259,7 @@ static const TypeInfo scsi_generic_info = {
     .parent        = TYPE_SCSI_DEVICE,
     .instance_size = sizeof(SCSIDevice),
     .class_init    = scsi_generic_class_initfn,
+    .secure        = true,
 };
 
 static void scsi_generic_register_types(void)
-- 
2.56.1


