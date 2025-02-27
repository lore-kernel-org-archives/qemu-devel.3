Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537F7C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZgo-0003dh-AO; Thu, 27 Feb 2025 03:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnZgk-0003ch-FG
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:56:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnZgi-0001kb-UW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740646572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcEpytVV0GCSykoFanyGhL3GqCWFL4pf24EXyuR20qw=;
 b=GsPrZ9T4pGtNCXjl9K3cJhrSIDmTCRSHnPVlYsgoElSfRtHe7h9xXIy5ldyVL1HWA8t4gk
 6/UgBbh25H1NmldwjvZVSZcXcPEmsMlAru7pZATUu6jz3Y/GGQUQRvAA8CSBJ7iTY2Abr4
 f6krMzW4qJCkdGZAYCPzakrw+qR/uno=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-HfMV6-jrMOiqvdaMUhRwcA-1; Thu,
 27 Feb 2025 03:56:06 -0500
X-MC-Unique: HfMV6-jrMOiqvdaMUhRwcA-1
X-Mimecast-MFC-AGG-ID: HfMV6-jrMOiqvdaMUhRwcA_1740646565
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CB351954B1B; Thu, 27 Feb 2025 08:56:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED39F1944D02; Thu, 27 Feb 2025 08:56:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 05F8321E65DD; Thu, 27 Feb 2025 09:56:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	berrange@redhat.com,
	eduardo@habkost.net
Subject: [PATCH v2 1/6] qdev: Delete unused qdev_prop_enum
Date: Thu, 27 Feb 2025 09:55:56 +0100
Message-ID: <20250227085601.4140852-2-armbru@redhat.com>
In-Reply-To: <20250227085601.4140852-1-armbru@redhat.com>
References: <20250227085601.4140852-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/qdev-properties.h | 1 -
 hw/core/qdev-properties.c    | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index bf27375a3c..ae6ec2b990 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -49,7 +49,6 @@ struct PropertyInfo {
 extern const PropertyInfo qdev_prop_bit;
 extern const PropertyInfo qdev_prop_bit64;
 extern const PropertyInfo qdev_prop_bool;
-extern const PropertyInfo qdev_prop_enum;
 extern const PropertyInfo qdev_prop_uint8;
 extern const PropertyInfo qdev_prop_uint16;
 extern const PropertyInfo qdev_prop_uint32;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 0b52aad555..2540bd8880 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -122,13 +122,6 @@ void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
         qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
 }
 
-const PropertyInfo qdev_prop_enum = {
-    .name  = "enum",
-    .get   = qdev_propinfo_get_enum,
-    .set   = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
-};
-
 /* Bit */
 
 static uint32_t qdev_get_prop_mask(const Property *prop)
-- 
2.48.1


