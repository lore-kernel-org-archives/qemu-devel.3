Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEFDC369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Uf3-0003CI-Hv; Wed, 23 Apr 2025 03:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Ueo-00034A-Nf
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uek-0003Bd-Dl
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kHAl7mGWyVtoVdcBAu7OviotqdkJHPswlSScbOveyIk=;
 b=agKrfrAoQQEycWPZgnmR41zwdv9MF3kuzFg11jiv3h30zyQoRXKgBYk+gjDElPsyTMYGed
 /na6vrQDgeX7znSRBZ36NYVUzeGUnN2YKMzEKUkHuaQXEnLRLsG2z7UzXdpXSZ7QXBce27
 ECs/NYpiWupsWoYpptOpJt7P2GBFzWs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-rx7uB6JQMMuMm_QgsycEhQ-1; Wed,
 23 Apr 2025 03:36:21 -0400
X-MC-Unique: rx7uB6JQMMuMm_QgsycEhQ-1
X-Mimecast-MFC-AGG-ID: rx7uB6JQMMuMm_QgsycEhQ_1745393780
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7420F19560BB; Wed, 23 Apr 2025 07:36:20 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3D0619560A3; Wed, 23 Apr 2025 07:36:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/29] hw/s390x/s390-stattrib: Remove the old migration_enabled
 flag
Date: Wed, 23 Apr 2025 09:35:43 +0200
Message-ID: <20250423073610.271585-4-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

From: Thomas Huth <thuth@redhat.com>

Now that the machine types that set the migration_enabled flag to
false are gone, we can remove it and the related code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250115073819.15452-4-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/storage-attributes.h | 1 -
 hw/s390x/s390-stattrib-kvm.c          | 2 +-
 hw/s390x/s390-stattrib.c              | 7 +------
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
index 8921a04d514..b5c6d8fa552 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -25,7 +25,6 @@ OBJECT_DECLARE_TYPE(S390StAttribState, S390StAttribClass, S390_STATTRIB)
 struct S390StAttribState {
     DeviceState parent_obj;
     uint64_t migration_cur_gfn;
-    bool migration_enabled;
 };
 
 
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 2a8e31718bf..d0ff04364d4 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -185,7 +185,7 @@ static long long kvm_s390_stattrib_get_dirtycount(S390StAttribState *sa)
 
 static int kvm_s390_stattrib_get_active(S390StAttribState *sa)
 {
-    return kvm_s390_cmma_active() && sa->migration_enabled;
+    return kvm_s390_cmma_active();
 }
 
 static void kvm_s390_stattrib_class_init(ObjectClass *oc, void *data)
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index be07c28c6e5..35bf697ef0a 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -304,7 +304,7 @@ static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool value,
 
 static int qemu_s390_get_active(S390StAttribState *sa)
 {
-    return sa->migration_enabled;
+    return true;
 }
 
 static void qemu_s390_stattrib_class_init(ObjectClass *oc, void *data)
@@ -360,10 +360,6 @@ static void s390_stattrib_realize(DeviceState *dev, Error **errp)
                          &savevm_s390_stattrib_handlers, dev);
 }
 
-static const Property s390_stattrib_props[] = {
-    DEFINE_PROP_BOOL("migration-enabled", S390StAttribState, migration_enabled, true),
-};
-
 static void s390_stattrib_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -371,7 +367,6 @@ static void s390_stattrib_class_init(ObjectClass *oc, void *data)
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->realize = s390_stattrib_realize;
-    device_class_set_props(dc, s390_stattrib_props);
 }
 
 static void s390_stattrib_instance_init(Object *obj)
-- 
2.49.0


