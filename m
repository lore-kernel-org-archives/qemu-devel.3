Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4ACC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3bii-0006qS-8o; Mon, 07 Sep 2026 11:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3bib-0006pW-CH
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:57:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3biZ-0000uX-Ao
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788796630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNEHRJDHdcdZeT0Nz44zT2pq9EwMvgRWKA64S1eEvDM=;
 b=DC0qxUvQBdA8ny5wqkJA77TiePQ+V8C/U1jcOnN9ow80cLcjznF9ZGkVbdOnlV9FzIm0dP
 qlfOzSZb+HqQqXp+k6sOY8CMlWA2uBa9LK7Ompz7RNcyuTSGaDyGbJ83JUPDlT06MyVUcz
 Ahi2rxUTRYlfs7B72E4dzePV5t7mSns=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Q462VYAuO6CRT1FFCWpwUw-1; Mon, 07 Sep 2026 11:57:09 -0400
X-MC-Unique: Q462VYAuO6CRT1FFCWpwUw-1
X-Mimecast-MFC-AGG-ID: Q462VYAuO6CRT1FFCWpwUw_1788796628
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49ccfad90f1so22775715e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788796628; x=1789401428; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LNEHRJDHdcdZeT0Nz44zT2pq9EwMvgRWKA64S1eEvDM=;
 b=p3nt4Iytrh3vaIOQ3Ny7mNMuor4cobLDS2+lqRrWlRC73sKrQHbrnD0V/JYfHSM849
 FDyGS2hkVIsATQQl0iHKP+xCElfpdwbsc/txawzassY1imGOxI1Abs9/ZX0Q/elWp3KR
 iHeQ3obervjTqPspJW7yfmQKd/yABqpYJuhHQbRTxuNUTWFkFmjbFDxJZEC4AmJHpYxr
 xGHM5Nw+Ay7SeYA/JmkjnTNsQU//8n2nmfUt+9dBQaKkbeuckWIOFUr7+4ad1+OFppvA
 X9zFeT0sErvlRLcBqgdcBr+AQoN2HP26BfQr+bF2p9FYA9lO/wW99J6Fp52JI2ASqj90
 H0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788796628; x=1789401428;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LNEHRJDHdcdZeT0Nz44zT2pq9EwMvgRWKA64S1eEvDM=;
 b=KONBBPMN8r/VpFkHu88l6jWJkcevtwhg2WaZW3ckB8D96Nk49XPnvRotFZmmBhf7Ft
 Of87pWCj8PqK3YxMdz1l1JXlQcKw5Y43/1SEAf5ljxVdUix0Pi1JNXI2Jt4y6qOS2VvB
 BTXkBSKy/vMuZyW+vauHzkO721iyx5noiS04wRDOmmRIpYzT9Nb9gJVSEmJwkET5AvVm
 iffSh/+mRUs7K+irmZYPJhDF8zO64kWGR+dkTEUnXDjDZzooReeGY8j6007r8/sXB2Y3
 8MzbRoE3Cko4/S+i9bUdLuOVzF/UDqLnDrMIsuxx5QDTy3MqcSLTdJKjXD5xti/iaKxV
 DuOw==
X-Gm-Message-State: AFuF++n2dLtvYVUN7d1wYh/y+erNaAaljhXQBRyg7ZNaHj3hF76q6KOk
 WVdUwN9gv6qDevJ+uFzaSLA625bUxsLp2vblym7LeJfbRUbMZDNp0qs4o9PAEWX8ydZb7RCa3WZ
 gF+AQsxT/q+x+B/BiqDzGM1+zHdHZ5sxIMj/DWjE/DOFgY+K51EGCM+8SZseYfJdSkrTGpYAe+4
 qrholPibY903LlbqC9kpMg3Aa9mWF0I5d19BjlAVXc8lY=
X-Gm-Gg: AYBFou2pBvoHbK51RPB42saQB5d/CwTp8WEQx2AEMD1TrHcAq9nhNDZi0RAdLgnOWU/
 XYnmZcQ4n8OutisJ8b9Ou3dVFx21vM5e/nQHrfDZ4U2oNnDxLHGQVgeeIJJTgffNDQWuKFbc8jU
 mkHmzHDs+9yniLOSmlhL2sMQf7wYQwptXP53MOaGPnnhDp28SkPZdnCuyxDNrrg1WVrln/5RX2a
 Rt++Nk6IRk0XC8b8UnrELnj7W0T5FxE/70uirUuuo0IQ3GC16dsoAjXgStRzkI2tFespsC7UKtR
 mva1Rh/DS3amvAykzGqFWXS3js2Vr7bx/Z/LibwROS0FkrxcTacfaIp4lnWWLi44DTn3IWoPxjz
 Q57pIM5gZnBXdfi8Vqs81YYYtTYhoI6ctgMPioCNTGQBHblK1L4ZUFK4aWJB/rWkPxF3q
X-Received: by 2002:a05:600d:4449:20b0:49d:3a:e576 with SMTP id
 5b1f17b1804b1-49d003ae639mr122997665e9.5.1788796627847; 
 Mon, 07 Sep 2026 08:57:07 -0700 (PDT)
X-Received: by 2002:a05:600d:4449:20b0:49d:3a:e576 with SMTP id
 5b1f17b1804b1-49d003ae639mr122997145e9.5.1788796627429; 
 Mon, 07 Sep 2026 08:57:07 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm320477955e9.0.2026.09.07.08.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 08:57:06 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 07 Sep 2026 17:56:59 +0200
Subject: [PATCH v2 3/5] i386/sev: convert the guest policy properties to
 custom accessors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-fix_igvm_policy-v2-3-c8c50f1dbfda@redhat.com>
References: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
In-Reply-To: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org, 
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

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 target/i386/sev.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b53d13e2fa..38f97fd9b2 100644
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
2.55.0


