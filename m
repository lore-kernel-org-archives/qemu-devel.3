Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16426C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnU-0006IO-5a; Tue, 23 Apr 2024 11:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnC-0004kJ-RB
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn7-0000IE-Vh
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hI2Wfdd4jjbYJ/EcapLaF3fT5yZEYHuVbDtiXsUnZqQ=;
 b=RcWexdJadBzoX17sDmNuIh3Oz4zvREbXBIR7532UTUmDAvwQdypFUQVNoYfDYr+yLzExQn
 vaIMR8Auo4t+a53LSY5wjEf9qtH6p5bq2WSn4hUC9KT63i9mLLhoRbedJkCyaMj7Et9Y3l
 Jt8QMjkRqjrv6Rju7MPr5Xw0Q7kMhSE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-WyqwbiYnP7-6uZYRDFRdWQ-1; Tue, 23 Apr 2024 11:10:39 -0400
X-MC-Unique: WyqwbiYnP7-6uZYRDFRdWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDCC1834FB8;
 Tue, 23 Apr 2024 15:10:38 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D9772033979;
 Tue, 23 Apr 2024 15:10:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>
Subject: [PULL 46/63] hw/i386/sev: Use legacy SEV VM types for older machine
 types
Date: Tue, 23 Apr 2024 17:09:34 +0200
Message-ID: <20240423150951.41600-47-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Michael Roth <michael.roth@amd.com>

Newer 9.1 machine types will default to using the KVM_SEV_INIT2 API for
creating SEV/SEV-ES going forward. However, this API results in guest
measurement changes which are generally not expected for users of these
older guest types and can cause disruption if they switch to a newer
QEMU/kernel version. Avoid this by continuing to use the older
KVM_SEV_INIT/KVM_SEV_ES_INIT APIs for older machine types.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Message-ID: <20240409230743.962513-4-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c      | 1 +
 target/i386/sev.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 41909f7bd7a..08c7de416fd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -80,6 +80,7 @@
 
 GlobalProperty pc_compat_9_0[] = {
     { TYPE_X86_CPU, "guest-phys-bits", "0" },
+    { "sev-guest", "legacy-vm-type", "true" },
 };
 const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index f4ee317cb03..d30b68c11e4 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1417,6 +1417,7 @@ sev_guest_instance_init(Object *obj)
     object_property_add_uint32_ptr(obj, "reduced-phys-bits",
                                    &sev->reduced_phys_bits,
                                    OBJ_PROP_FLAG_READWRITE);
+    object_apply_compat_props(obj);
 }
 
 /* sev guest info */
-- 
2.44.0



