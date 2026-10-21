Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B9D606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=alK8SfL1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZFc-0007Zz-PL; Wed, 21 Oct 2026 12:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFH-0007Ub-Sl
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFG-0006Vv-4A
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792600372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3yOq+0SmiKD4ABIG/MWGp5EqJWbc1XKSVkbY1vpqHNA=;
 b=alK8SfL1bekD8lboA//5jLebhP0T8QZF4Bn7eMGIwlGjFHT1drDtJJCgs5mupnuagsgkgZ
 axdpPzcjK4CfW8u+9g1OE6Cw+2eLzei/x7fycNpjmibF36QDKH8J45Yng2Og96nqy/pbRj
 5NWlg+Ild4HLvOXyTLe9maSLmOjLAnQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-5FibhARGN1KXE4ZvAFowEw-1; Wed,
 21 Oct 2026 12:32:44 -0400
X-MC-Unique: 5FibhARGN1KXE4ZvAFowEw-1
X-Mimecast-MFC-AGG-ID: 5FibhARGN1KXE4ZvAFowEw_1792600363
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 474A71800662; Wed, 21 Oct 2026 16:32:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70F381803A40; Wed, 21 Oct 2026 16:32:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A16D01827591; Wed, 21 Oct 2026 18:32:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 03/10] i386/sev: convert the guest policy properties to custom
 accessors
Date: Wed, 21 Oct 2026 18:32:31 +0200
Message-ID: <20261021163239.1131460-4-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Luigi Leonardi <leonardi@redhat.com>

Both SEV/SEV-ES and SEV-SNP expose a "policy" object property. The
SEV/SEV-ES one was registered as a plain uint32 pointer property, and
the SEV-SNP setter ignored the result of the visit.

Give both properties explicit getter/setter functions and check the
return value of the visit in the setters. This is preparation for
tracking whether the guest policy was set on the command line.

No functional change intended.

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260907-fix_igvm_policy-v2-3-c8c50f1dbfda@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 target/i386/sev.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b53d13e2fa28..38f97fd9b2b3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2996,6 +2996,22 @@ sev_guest_class_init(ObjectClass *oc, const void *data)
             "use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.");
 }
 
+static void
+sev_guest_get_policy(Object *obj, Visitor *v, const char *name,
+                     void *opaque, Error **errp)
+{
+    visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp);
+}
+
+static void
+sev_guest_set_policy(Object *obj, Visitor *v, const char *name,
+                     void *opaque, Error **errp)
+{
+    if (!visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp)) {
+        return;
+    }
+}
+
 static void
 sev_guest_instance_init(Object *obj)
 {
@@ -3004,8 +3020,8 @@ sev_guest_instance_init(Object *obj)
     sev_guest->policy = DEFAULT_GUEST_POLICY;
     object_property_add_uint32_ptr(obj, "handle", &sev_guest->handle,
                                    OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint32_ptr(obj, "policy", &sev_guest->policy,
-                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_add(obj, "policy", "uint32", sev_guest_get_policy,
+                        sev_guest_set_policy, NULL, NULL);
     object_apply_compat_props(obj);
 
     sev_guest->legacy_vm_type = ON_OFF_AUTO_AUTO;
@@ -3044,9 +3060,13 @@ static void
 sev_snp_guest_set_policy(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    visit_type_uint64(v, name,
-                      (uint64_t *)&SEV_SNP_GUEST(obj)->kvm_start_conf.policy,
-                      errp);
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    if (!visit_type_uint64(v, name,
+                           (uint64_t *)&sev_snp_guest->kvm_start_conf.policy,
+                           errp)) {
+        return;
+    }
 }
 
 static char *
-- 
2.56.0


