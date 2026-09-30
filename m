Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CEBCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0T-0002Ua-GI; Wed, 30 Sep 2026 11:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0H-0002Sx-Ju
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0F-0000gb-U1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/RpTFZOW17YdtVyJADct+Kt0iPKlWuajd/Kl0cEdYM=;
 b=cn4OsMpG2zAp9hqc8zHmiH/5ZMYn1WML/hWQB45eye/YxqMtcN9RC7csQ4AvZUpMT9oE5X
 qx3y4d1EeNPgtMD4ZdbKzXjjK1B/b2c/nVViVcEuFBwb3UsQzWE/0fpy3/tGOX54vFMHyz
 TWgM2kzNiFVzlOx+AZ1xQbYQAfl1HLY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-oEOP95xfPZCB9er_dR993Q-1; Wed, 30 Sep 2026 11:13:48 -0400
X-MC-Unique: oEOP95xfPZCB9er_dR993Q-1
X-Mimecast-MFC-AGG-ID: oEOP95xfPZCB9er_dR993Q_1790781228
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5337f26ee19so9447991cf.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781228; x=1791386028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g/RpTFZOW17YdtVyJADct+Kt0iPKlWuajd/Kl0cEdYM=;
 b=S/s9grnGDwBOx7SCbvPrUaDeJPSTP1CweedXng3FRuvJCVu0kQWpH7LOml0fVKvAu2
 FaqgY46qP8RauxoLaeW43UjS/h1OruhNzqx+FTIJl+SHLCNxaa/aF71OMZbSUYXFSFRy
 lUJTeg4XG3KmQLaJYc20I87I1WtEhpaTpXS/y4w5P3YhlDwIPTZ1O/Km2H8CHK9LQt4e
 YHHC2CQqg6wQ5TTQeNBJrdFST9K5z09VUAvS9D/x9Am4xAhT/pW2Un/dBlpwqgqEEsZ1
 CvE2Mvqtca+lPbqEOU2d/6u/uJDBpQfJXbI9QN6T2aDh/6AmyFWMBbaNxCjqyZ8wdWtl
 bj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781228; x=1791386028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g/RpTFZOW17YdtVyJADct+Kt0iPKlWuajd/Kl0cEdYM=;
 b=2HY32UZMQX6AVNF0UuKJwS9J0WL2a3B7Zjhr/YH40ztzVqSnkOk9lgfK1dP73j7Ta6
 V+CeKuuzG3VWfahO6R7VsIoqI6qYyHpFQg8Cy58k1VqjPs1jyQhNozmHDumlz/9IM7+1
 KqaJ594Ojp6AedKs+T6wibx1Mp5U37MXe3VYQC4BRGR2UxDcxCl2knw9af8KtG6iY8hC
 yOT2KZjYsFJy5wrzBVuLoYIOzome9oG6o/JBbXj4+JZY0nQOTuk7KA3UNKMMtKRcNz40
 M/uP97XD/SttwwzmQr+SA907KCpd6LaMrwzbA0ERpw+jqLNrblAP+WdVCTucTYMftBB1
 rADA==
X-Gm-Message-State: AFuF++nA8e87YphBUEmuCUD5wTSa0B2Dmw7NSyb1RNn5reRgrHsA/lxI
 ZtkfsTRBI0blRKuquhORKgT3t8SunkNBp4Ry9NM7Zd5d4pG/G2Z988O+EdIOha5OQg2k5ZMiUBD
 k+hKZdh9NLJCtqqGesGu3AJCxttcAhh6C0rR0MJgvNiSdKg6L+8MlZNehWzluTLq13gCx/G8luE
 bTtp7mves2HZJHZvdieUu3McPj95IgGOezyILrFEwD
X-Gm-Gg: AYBFou3oXiw2DLkxEuEA4+CPZ7EGBsOWhF/lZvN0vgz6HoKEYXj3QF68v+3lyJ7WJtQ
 +6LQxQHIA0DiH/BsKFHGE0VpqfRRB5uiRm/n2pEyUhVa/YZHrmO5PprmGo08frpZqnbL28VRmkw
 DpBx+Ub+lq+/NBK8f6EMqzJ3/w0X73NDHbieHiQK3DCX8Mq8OqbT4cwwNOVMI8kPVQJCk8IjrLP
 P5nUZ3IhreWkxsW+dHGhYObwPxPDSkeux20Y/vlOHwAeq2ei1V1Q5eEA3QMwphyR+pPOvNmnFXw
 JGvH/0uYLjO5EtfEbNt/Z63kCivbMZDzWzXGZT+LYpkOy4aq8CMmYKhO/mrgajKgyXx692s=
X-Received: by 2002:ac8:5f46:0:b0:533:2717:6221 with SMTP id
 d75a77b69052e-533742f520bmr33417641cf.31.1790781227466; 
 Wed, 30 Sep 2026 08:13:47 -0700 (PDT)
X-Received: by 2002:ac8:5f46:0:b0:533:2717:6221 with SMTP id
 d75a77b69052e-533742f520bmr33416781cf.31.1790781226727; 
 Wed, 30 Sep 2026 08:13:46 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-533824ba4a2sm1529871cf.18.2026.09.30.08.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:13:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Michael Roth <michael.roth@amd.com>, David Hildenbrand <david@kernel.org>
Subject: [PULL 03/12] kvm: Provide explicit error for kvm_create_guest_memfd()
Date: Wed, 30 Sep 2026 11:13:31 -0400
Message-ID: <20260930151340.2817042-4-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

So that there will be a verbal string returned when kvm not enabled, or
kvm not compiled.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20260929235109.1398509-4-michael.roth@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c    | 11 +++++++++++
 accel/stubs/kvm-stub.c |  1 +
 2 files changed, 12 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 120cab1e22..0b1407e4ea 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4758,6 +4758,17 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         .flags = flags,
     };
 
+    /*
+     * kvm_create_guest_memfd() can be invoked from generic hostmem code
+     * where KVM might be compiled but not necessarily enabled. Because
+     * of this, check for KVM support explicitly before continuing with
+     * any KVM-specific checks.
+     */
+    if (!kvm_enabled()) {
+        error_setg(errp, "guest-memfd requires KVM accelerator");
+        return -1;
+    }
+
     if (!kvm_guest_memfd_supported) {
         error_setg(errp, "KVM does not support guest_memfd");
         return -1;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 3d34e3b99d..acbd0785e0 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -141,6 +141,7 @@ bool kvm_hwpoisoned_mem(void)
 
 int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
+    error_setg(errp, "KVM is not enabled");
     return -ENOSYS;
 }
 
-- 
2.55.0


