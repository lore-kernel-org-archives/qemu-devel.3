Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB6CE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 08:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVRgw-00061D-Eg; Wed, 08 Jan 2025 03:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRgu-00060u-L9
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRgt-0001ky-4h
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736325926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5rn4JRDgt6S3RAIBV9GIikHN+SqKfKBRCjmS87hvyA=;
 b=AVZ6W59KYUqOnHETJ3QuSLG6N6aZ8F1uwdzEqa7AfKnP4KcGO3xzuY6U/Z4lK9qN2sSsn8
 HsKCcacK1NusGH5ls4vmXqoNg6qpgSg4Knx58LxozEJu5avBZMKbYpGRS/3uo02p4EWqFK
 uZf/lLtoh7BaPJjl2BipXZGtPpqazXY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-3ZvEdFw_ObmXZz4WQA7Xqw-1; Wed,
 08 Jan 2025 03:45:23 -0500
X-MC-Unique: 3ZvEdFw_ObmXZz4WQA7Xqw-1
X-Mimecast-MFC-AGG-ID: 3ZvEdFw_ObmXZz4WQA7Xqw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F4CF19560BD; Wed,  8 Jan 2025 08:45:22 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-228.str.redhat.com
 [10.33.192.228])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF43F19560AB; Wed,  8 Jan 2025 08:45:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PULL 03/14] hw/s390x/s390-skeys: Remove the "migration-enabled"
 property
Date: Wed,  8 Jan 2025 09:45:00 +0100
Message-ID: <20250108084511.238458-4-thuth@redhat.com>
In-Reply-To: <20250108084511.238458-1-thuth@redhat.com>
References: <20250108084511.238458-1-thuth@redhat.com>
MIME-Version: 1.0
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

This property was only set to "off" by the old s390-ccw-virtio-2.4
machine type which has now been removed. So we can now remove the
property and the related code, too.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20250103144232.520383-3-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/storage-keys.h |  2 --
 hw/s390x/s390-skeys.c           | 10 +---------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
index 976ffb2039..408d2815d4 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -21,8 +21,6 @@ OBJECT_DECLARE_TYPE(S390SKeysState, S390SKeysClass, S390_SKEYS)
 
 struct S390SKeysState {
     DeviceState parent_obj;
-    bool migration_enabled;
-
 };
 
 
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index dda96ea32a..995817f4a3 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -469,23 +469,15 @@ static void s390_skeys_realize(DeviceState *dev, Error **errp)
 {
     S390SKeysState *ss = S390_SKEYS(dev);
 
-    if (ss->migration_enabled) {
-        register_savevm_live(TYPE_S390_SKEYS, 0, 1,
-                             &savevm_s390_storage_keys, ss);
-    }
+    register_savevm_live(TYPE_S390_SKEYS, 0, 1, &savevm_s390_storage_keys, ss);
 }
 
-static const Property s390_skeys_props[] = {
-    DEFINE_PROP_BOOL("migration-enabled", S390SKeysState, migration_enabled, true),
-};
-
 static void s390_skeys_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->hotpluggable = false;
     dc->realize = s390_skeys_realize;
-    device_class_set_props(dc, s390_skeys_props);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
-- 
2.47.1


