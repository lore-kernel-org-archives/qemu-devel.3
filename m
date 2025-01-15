Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA209C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2uP-00067s-Bf; Wed, 15 Jan 2025 07:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tY2uC-0004kE-OR
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:53:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tY2uA-0007Bw-5D
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736945633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbJbwT5jk5zJFpqmW4wIwmehik+dFuAgLStiAW93MDc=;
 b=P8H9NYUNy0FC8/1V0AGQ5GW0uldzubkhspGUcumXjnWfVn9ybKrpaJKj903eTHx8JcRcnk
 MoJCHVfma5xfFpahroI9OcDWfilBqzOz1w+5kZUib+Qo+8/plgFAMs2j6SuOLuLBrvTDyZ
 W3M5VMa80MmAJVIwWNbMUBoOK2puTPI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-eBLUljWjP5m3b92n-SLWNg-1; Wed,
 15 Jan 2025 07:53:51 -0500
X-MC-Unique: eBLUljWjP5m3b92n-SLWNg-1
X-Mimecast-MFC-AGG-ID: eBLUljWjP5m3b92n-SLWNg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2BEE1953947
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 12:53:50 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5A0919560BC; Wed, 15 Jan 2025 12:53:49 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	anisinha@redhat.com
Subject: [PATCH 2/3] pci: acpi: Windows 'PCI Label Id' bug workaround
Date: Wed, 15 Jan 2025 13:53:41 +0100
Message-ID: <20250115125342.3883374-3-imammedo@redhat.com>
In-Reply-To: <20250115125342.3883374-1-imammedo@redhat.com>
References: <20250115125342.3883374-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

Current versions of Windows call _DSM(func=7) regardless
of whether it is supported or not. It leads to NICs having bogus
'PCI Label Id = 0', where none should be set at all.

Also presence of 'PCI Label Id' triggers another Windows bug
on localized versions that leads to hangs. The later bug is fixed
in latest updates for 'Windows Server' but not in consumer
versions of Windows (and there is no plans to fix it
as far as I'm aware).

Given it's easy, implement Microsoft suggested workaround
(return invalid Package) so that affected Windows versions
could boot on QEMU.
This would effectvely remove bogus 'PCI Label Id's on NICs,
but MS teem confirmed that flipping 'PCI Label Id' should not
change 'Network Connection' ennumeration, so it should be safe
for QEMU to change _DSM without any compat code.

Smoke tested with WinXP and WS2022
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/774
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 733b8f0851..1311a0d4f3 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -654,6 +654,7 @@ static Aml *aml_pci_pdsm(void)
     Aml *acpi_index = aml_local(2);
     Aml *zero = aml_int(0);
     Aml *one = aml_int(1);
+    Aml *not_supp = aml_int(0xFFFFFFFF);
     Aml *func = aml_arg(2);
     Aml *params = aml_arg(4);
     Aml *bnum = aml_derefof(aml_index(params, aml_int(0)));
@@ -678,7 +679,7 @@ static Aml *aml_pci_pdsm(void)
          */
         ifctx1 = aml_if(aml_lnot(
                      aml_or(aml_equal(acpi_index, zero),
-                            aml_equal(acpi_index, aml_int(0xFFFFFFFF)), NULL)
+                            aml_equal(acpi_index, not_supp), NULL)
                  ));
         {
             /* have supported functions */
@@ -704,18 +705,30 @@ static Aml *aml_pci_pdsm(void)
     {
        Aml *pkg = aml_package(2);
 
-       aml_append(pkg, zero);
-       /*
-        * optional, if not impl. should return null string
-        */
-       aml_append(pkg, aml_string("%s", ""));
-       aml_append(ifctx, aml_store(pkg, ret));
-
        aml_append(ifctx, aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
+       aml_append(ifctx, aml_store(pkg, ret));
        /*
-        * update acpi-index to actual value
+        * Windows calls func=7 without checking if it's available,
+        * as workaround Microsoft has suggested to return invalid for func7
+        * Package, so return 2 elements package but only initialize elements
+        * when acpi_index is supported and leave them uninitialized, which
+        * leads elements to being Uninitialized ObjectType and should trip
+        * Windows into discarding result as an unexpected and prevent setting
+        * bogus 'PCI Label' on the device.
         */
-       aml_append(ifctx, aml_store(acpi_index, aml_index(ret, zero)));
+       ifctx1 = aml_if(aml_lnot(aml_lor(
+                    aml_equal(acpi_index, zero), aml_equal(acpi_index, not_supp)
+                )));
+       {
+           aml_append(ifctx1, aml_store(acpi_index, aml_index(ret, zero)));
+           /*
+            * optional, if not impl. should return null string
+            */
+           aml_append(ifctx1, aml_store(aml_string("%s", ""),
+                                        aml_index(ret, one)));
+       }
+       aml_append(ifctx, ifctx1);
+
        aml_append(ifctx, aml_return(ret));
     }
 
-- 
2.43.0


