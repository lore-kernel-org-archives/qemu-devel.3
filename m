Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286B6606BDC8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rs0J+pWw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwFu-0008Js-GG; Fri, 13 Nov 2026 13:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFO-0007P9-QG
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFN-0005Ra-18
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYhOkhWNDL5GNlkgVNiF52ZiQVBB2qVKlixTWBKBXO8=;
 b=Rs0J+pWwkyH3w82J4J0i1l2QySkwKdyBVrN4iRx8qAYa1eGW/xFLM3gho7dIFAjv6DXY7I
 xUWumR6++uGtrIlN9p6nRCM8OKIbY7npx6tHi4xtnnQgQ/PsqtGrnzvrAr2NMcsNcnRjTs
 FNLd9q/wxHUX+jZrcLpnZfO/2Z31hPY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-UVFXd0QaNg6JYHiGGXTcsg-1; Fri,
 13 Nov 2026 13:43:35 -0500
X-MC-Unique: UVFXd0QaNg6JYHiGGXTcsg-1
X-Mimecast-MFC-AGG-ID: UVFXd0QaNg6JYHiGGXTcsg_1794595414
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30255180034B
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:34 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E7AB51955DB9; Fri, 13 Nov 2026 18:43:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 20/26] hw/mem: mark nvdimm,
 pc-dimm & spapr-nvdimm devices as secure
Date: Fri, 13 Nov 2026 18:42:48 +0000
Message-ID: <20261113184254.2524253-21-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These devices are used in virutalization scenarios to support memory
hotplug and other uses cases.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/mem/nvdimm.c       | 1 +
 hw/mem/pc-dimm.c      | 1 +
 hw/ppc/spapr_nvdimm.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 08086997d7f..4e98d88de2d 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -277,6 +277,7 @@ static const TypeInfo nvdimm_info = {
     .instance_size = sizeof(NVDIMMDevice),
     .instance_init = nvdimm_init,
     .instance_finalize = nvdimm_finalize,
+    .secure        = true,
 };
 
 static void nvdimm_register_types(void)
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index e9b872450a2..81ad1fca555 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -303,6 +303,7 @@ static const TypeInfo pc_dimm_info = {
     .instance_init = pc_dimm_init,
     .class_init    = pc_dimm_class_init,
     .class_size    = sizeof(PCDIMMDeviceClass),
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_MEMORY_DEVICE },
         { }
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 542ed79497a..ae270168500 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -916,6 +916,7 @@ static TypeInfo spapr_nvdimm_info = {
     .class_size    = sizeof(SPAPRNVDIMMClass),
     .instance_size = sizeof(SpaprNVDIMMDevice),
     .instance_init = spapr_nvdimm_init,
+    .secure        = true,
 };
 
 static void spapr_nvdimm_register_types(void)
-- 
2.56.1


