Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F23C79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a6H-0007cK-L5; Fri, 04 Sep 2026 16:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a6B-000752-Lh
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a69-0008Pr-Qa
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIiDAG2jKPc8trfxeDzWrsYVGy/FtqWuSjPzxQy4+IM=;
 b=Hz0oLytakhl0O1pc8V2wOtT+fwf+IWLbvWhhw6AibqrU72ExIP7GyVRMCU8YH9+9j9XHod
 qrm9CpqyDOf4iW05KtGIiEkunGV3Quo/pPhLXbYlkqa3Lc3HHHYFEb05HuZdqU7FpBujiD
 Y8DiJmuWf/lVzn0HBrNnlTa9xkCIwyw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-StwE3VGvO8yBVWG0QpciKw-1; Fri,
 04 Sep 2026 16:01:13 -0400
X-MC-Unique: StwE3VGvO8yBVWG0QpciKw-1
X-Mimecast-MFC-AGG-ID: StwE3VGvO8yBVWG0QpciKw_1788552072
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F0AA1944D40; Fri,  4 Sep 2026 20:01:12 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3A8C1800577; Fri,  4 Sep 2026 20:01:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:32 +0400
Subject: [PATCH v4 49/75] i386/x86: convert SgxEPCList property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-49-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cnTGm8gLgIdGgYxLJNoo6ULUUXiyoyqTdIIMx4XVumw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKOLSXMFpNJ4k1dkBucnVHVUQVNUNoi3yoo
 /VbEpdfC8SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5f1TEACsCsMkOfNvNRhfIFpxGLKiz4evd/JqErhK8oJvPrVry8VhsElpUhR99m2VbuC60Lu+E5W
 fqNhi3wtRnpk52AbWF32d4JVU9doPSUZIlAd/QuevCyLlxQLjuxCAprEYTNDumjTSwpEb9b36eu
 jV8oz1qTHgF4YMqNX7oLQWNaeHGFAe1loUts4hx/y/8gbsIvJ+Fq4IdjNFm1/KjrhFQUFYpmi/a
 pIhtRj7S9BFekMjrIrCQqXFv1EOQm6aiOPnjc9nPn22gWs14eMEuANv8ZVOyuBlJx7VTneiAhbX
 gigOrLW1tgc83t3cCJSgR1sW036HoTLPDuvCw5oRq9TyaxSIw5ofOo+YzC4guSG4ORDDs8ICQDq
 /Q2acoFDtvO6Gt8x6diwKjZAkOGaDNwd1KlPLyuv9d9W4AJ1+cdmcCoWMJHHW8Ew28pV9Sb/+Y7
 a8TA2rahiyqbvDxsn83EQXcEnvhp+P24OriyrCL02IrtrJvh914rsHJg2fLBFeQpsckKW1F9Bg9
 NATFkt1dplMK1bGJ0gSjWMv2IiSEwO+6EQWv9ktLKxX2E3uKqiimqZlvBGHTPL+bBy0vupQ/kvX
 fWCGaS6p0hyx9c2nTajmDTXa38+9sx1INxxPproYz83i+rg+LxXEbrX8XhsXh+dpQ4B7R6NSGNh
 /HKYlDuiZBQZ49g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index d0c782ec8544..ed38760d798d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -25,6 +25,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qapi/qapi-type-infos-common.h"
+#include "qapi/qapi-type-infos-machine.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "system/qtest.h"
@@ -426,7 +427,7 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, X86_MACHINE_BUS_LOCK_RATELIMIT,
             "Set the ratelimit for the bus locks acquired in VMs");
 
-    object_class_property_add(oc, "sgx-epc", "SgxEPC",
+    object_class_property_add_qapi(oc, "sgx-epc", &SgxEPCList_type_info,
         machine_get_sgx_epc, machine_set_sgx_epc,
         NULL, NULL);
     object_class_property_set_description(oc, "sgx-epc",

-- 
2.55.0.543.g5ebe2ebe4ea8


