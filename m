Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFCCC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LR2-0002WA-DI; Tue, 01 Sep 2026 06:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1LR0-0002Vm-V6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1LQz-0000xh-AA
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788257380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIEprrdH7LZapW8zVSYHVi8VsanTJW2FyNSSrivNz7A=;
 b=OmsDzJy1DRXBh0da4+OfwS9MaY8JK/CGvuqX5cXxgj/TuKbR6D68lWf5ltzlZ38FQV94aI
 fp4MVHvAe3NEPxcHypLq4gXniCPl9yIpgOrsWRCnX8MM6w/pn4h+8Q5VeC+8TH2GhgiTTE
 VQXolCWpoigknpTtTnUa0rxrNbtqN48=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-vBmRl-fZO6SVu56GXhhTcw-1; Tue, 01 Sept 2026 06:09:34 -0400
X-MC-Unique: vBmRl-fZO6SVu56GXhhTcw-1
X-Mimecast-MFC-AGG-ID: vBmRl-fZO6SVu56GXhhTcw_1788257373
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4843313047eso1735819f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788257373; x=1788862173; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QIEprrdH7LZapW8zVSYHVi8VsanTJW2FyNSSrivNz7A=;
 b=VXGdwe6ST/bUNVtPyUCwkLGSs9fqWjZ6+n70Ce8AjldfhTeHUhXxk76ziiWU+9SvY3
 zmRbK+OLfcgFFwp1JechPYIOBEwTnYFI+1ipoWA0vGgpWgBnN9c3DKbFe83y+PEq+x1Q
 9jkn/0lGQefxZYcATkDAS2JK/VmN2CKrNOBIQdu2tOZuZrcrsZzYQH6/nVKFzT8CPj2a
 unJX1Ag+6LKmWg68wTFDXLosRa4DGSRP+epmDRfjImskBeZWKej3EK7YxsYyMEXfKaBt
 jwS5JxuSXEJlU87R5BrRI+0akEccs2861wCaRzIENOd6w2pXxATGzH3rVI3XmIL8UtkT
 2HZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788257373; x=1788862173;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QIEprrdH7LZapW8zVSYHVi8VsanTJW2FyNSSrivNz7A=;
 b=jquc61IUgfZCKcKdt9cVluKVVdQ5YMISZ9Ym+Z9ambmG4ADEsM8JTd9iHF9jsf+6be
 AwGOxDrbLZpaHxFwbPaKtYMASc4kCEoSHNGK4h4PSmBPvIvhbRz4GtkCdZ6Ki0ukUbAr
 sZKmK4MuXxxD7xOIb6m8Ds1K1YRlnJLUu5QzwPO2yAhTVasxH+rAW0Ty59wjUzrBPGtH
 ytlRH71YUAP47Q9lR63+7r+E33OlH89PSPepGEQeOlEhFojQQrMGez85JBkKW4vbSdb5
 paCfw3zJRhedwzEah3kBYhXWTfSagDIGBso/bY/mtTvoQ42U4O2zBflinEF6UX96vQc/
 aoMA==
X-Gm-Message-State: AFuF++mpSb/u9xoi41nbKyQGHdhhpM/DzxJiV4ZfYkUsHQzYsyF9cpBD
 kaCRmKhmF29K7cHiWFy39b/xnW+rYN/q0ylw6plADNklwvuZGXDzdlxTD3qDYhQhDt8M8GflPcm
 ROFlw1FHWE9Suj5Vejx4BFzq9nE98nmkleWRQCfdQX2Heb89OjrSVdsQP
X-Gm-Gg: AR+sD11B2x+cU7wpgE2e9Lq9Lul4HHhuOl6+Woq0SXklW7Lh2EItyFeKERjTat2nDNQ
 8M/b4h/hck2GMLJqA6HKYobGHXAi3LEMpyTuhTV3RWRRiRRDnjSsKltFpmyiArL0Lt4Y2BwiBN2
 J4dQ1aP4h69IFNLJTrP3rsQEahwwffeSwXD3AwFPLVZu744Wx4ADWMR7HaQq/qKS8Vk0lct00C4
 fJQbusF08MfzTkf31kDzyzNW4/g23NSzV3qCTPcCR5EfFBvhJxVmZkUz9Ur+sgHzCN7McUkHL4t
 kM09VEXesCQA2jjSVrW9Nv2BgE40SC2r0G0Nzp+moWb5ewekp+p8UQHE52sysVkBGkC22yYkE1q
 sHOz6d0uobbi5qKcanJzcEPc1OOP8ypDv3nhP5sOrNwTtu8P+7a1C5qGw3MpG+/456njf
X-Received: by 2002:a05:600c:8411:b0:499:bf0e:95c8 with SMTP id
 5b1f17b1804b1-49cdc405494mr133905095e9.1.1788257372974; 
 Tue, 01 Sep 2026 03:09:32 -0700 (PDT)
X-Received: by 2002:a05:600c:8411:b0:499:bf0e:95c8 with SMTP id
 5b1f17b1804b1-49cdc405494mr133904365e9.1.1788257372560; 
 Tue, 01 Sep 2026 03:09:32 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d7c1c0sm3941620f8f.32.2026.09.01.03.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 03:09:32 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 01 Sep 2026 12:09:20 +0200
Subject: [PATCH 3/4] i386/sev: convert the guest policy properties to
 custom accessors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-fix_igvm_policy-v1-3-e93a6cf8c5ac@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Both SEV/SEV-ES and SEV-SNP expose a "policy" object property. The
SEV/SEV-ES one was registered as a plain uint32 pointer property, and
the SEV-SNP setter ignored the result of the visit.

Give both properties explicit getter/setter functions and check the
return value of the visit in the setters. This is preparation for
tracking whether the guest policy was set on the command line.

No functional change intended.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 target/i386/sev.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 465415c535..c76cdba8d2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2956,6 +2956,22 @@ sev_guest_class_init(ObjectClass *oc, const void *data)
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
@@ -2964,8 +2980,8 @@ sev_guest_instance_init(Object *obj)
     sev_guest->policy = DEFAULT_GUEST_POLICY;
     object_property_add_uint32_ptr(obj, "handle", &sev_guest->handle,
                                    OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint32_ptr(obj, "policy", &sev_guest->policy,
-                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_add(obj, "policy", "uint32", sev_guest_get_policy,
+                        sev_guest_set_policy, NULL, NULL);
     object_apply_compat_props(obj);
 
     sev_guest->legacy_vm_type = ON_OFF_AUTO_AUTO;
@@ -3004,9 +3020,13 @@ static void
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
2.55.0


