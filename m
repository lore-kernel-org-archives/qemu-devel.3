Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F27C28B22
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 09:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq7eT-0008Ue-8S; Thu, 06 Mar 2025 04:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq7eL-0008TD-UU
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:36:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq7eJ-0002Aw-R9
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741253775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXBKwZQYCzvLtOQMkjHrW4vkQj6qxAm6/iuBhXGD8k8=;
 b=eaRjpWnI7wJB2wQ1lM9NOzGp0V0EbnAYab+dokmI8XAxOSb9lqoH8J9Q8ycWCLTtiif9Kb
 TNAGcEi1ISXtfxV6mNJ3K/IBjsj+cx0glJjh3EXfsjMN1MYFJL5SDAnUOLvCZzPlt7bNMr
 LyUQA/mFS9FV5GD4DOO/5T0DgnEcT0c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-oAJ3x9JEOL-LTazFhxoJOg-1; Thu,
 06 Mar 2025 04:36:08 -0500
X-MC-Unique: oAJ3x9JEOL-LTazFhxoJOg-1
X-Mimecast-MFC-AGG-ID: oAJ3x9JEOL-LTazFhxoJOg_1741253767
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7E031800349
 for <qemu-devel@nongnu.org>; Thu,  6 Mar 2025 09:36:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A4151956096
 for <qemu-devel@nongnu.org>; Thu,  6 Mar 2025 09:36:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4A5E21E65D4; Thu, 06 Mar 2025 10:36:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/10] qdev: Change qdev_prop_pci_devfn member @name from
 "int32" to "str"
Date: Thu,  6 Mar 2025 10:35:56 +0100
Message-ID: <20250306093601.2264772-6-armbru@redhat.com>
In-Reply-To: <20250306093601.2264772-1-armbru@redhat.com>
References: <20250306093601.2264772-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Properties using qdev_prop_pci_devfn initially accepted a string of
the form "DEV.FN" or "DEV" where DEV and FN are in hexadecimal.
Member @name was "pci-devfn" initially.

Commit b403298adb5 (qdev: make the non-legacy pci address property
accept an integer) changed them to additionally accept integers: bits
3..7 are DEV, and bits 0..2 are FN.  This is inaccessible externally
in device_add so far.

The commit also changed @name to "int32", and set member @legacy-name
to "pci-devfn".  Together, this kept QMP command
device-list-properties unaffected: it used @name only when
@legacy_name was null.

Commit 07d09c58dbb (qmp: Print descriptions of object properties)
quietly dumbed that down to use @name always, and the next commit
18b91a3e082q (qdev: Drop legacy_name from qdev properties) dropped
member @legacy_name.  This changed the value of @type reported by QMP
command device-list-properties from "pci-devfn" to "int32".

But "int32" is misleading: device_add actually wants QAPI type "str".
So change @name to that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250227085601.4140852-3-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/qdev-properties-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index a91551a5ee..f2b6136d0a 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -882,7 +882,7 @@ static int print_pci_devfn(Object *obj, const Property *prop, char *dest,
 }
 
 const PropertyInfo qdev_prop_pci_devfn = {
-    .name  = "int32",
+    .name  = "str",
     .description = "Slot and optional function number, example: 06.0 or 06",
     .print = print_pci_devfn,
     .get   = qdev_propinfo_get_int32,
-- 
2.48.1


