Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F84BCD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4YX-0004Ne-CS; Sun, 10 May 2026 09:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4YU-0004HF-W5
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4YT-00065g-8X
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778421048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bL0YotY8U+w1vhp/ZdhhG6qZnzRYwTMrPjsj6IHAqwQ=;
 b=MqCVjLpiA3TRxI1AHEhq8qKvSe72DHPhrRwzQJLUHW/W0XDL+SgcmXnMLT6xbJ9HeBVLBb
 5Dpa4Sxu4doGQu7ooyd9MxkwUnBTirOYVexu2SpUiuPNnRsFocz7T+AHsYO+iTqzST+fJG
 EYSINbfwVlY/V7oRzZzIUJnYUxU3SmA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-Bss_fv4-PGuglr9h2xPoZQ-1; Sun,
 10 May 2026 09:50:46 -0400
X-MC-Unique: Bss_fv4-PGuglr9h2xPoZQ-1
X-Mimecast-MFC-AGG-ID: Bss_fv4-PGuglr9h2xPoZQ_1778421046
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 271EA180034E
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:50:46 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F98A19560A2; Sun, 10 May 2026 13:50:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:35 +0400
Subject: [PATCH 38/54] hw/s390-virtio-ccw: convert loadparm property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-38-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=D6LPPuOFDLk2mp6M40+tSW3VFNMIGGCKwaJbYFaghiw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItwW4RGv1VJOrtrMvU1Pvce7XIr2k8o/hI8N
 thLtVplJ6mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcAAKCRDa6OEJdZac
 5ZoNEACmKfOdflLrTfXDbr2JDolVSIg2nXIAC+4rv8Qkb8Ins9zm9LVStRUdpa2AOUV3II4pADV
 dI0CVnSUt2OEALw1SwxVW66C/aqs4KpKfUk1b5ZbiVTiN8NjMs588nSr2g2uh1D1dkGAiAWor08
 Ryi7IfPzRU8VA2hLJ69OQKC7STL2ogESqP/dMDh42+XT7sB3/Kz0YPKBk8JUUEVIBtyrEjOkB5t
 O8Qw+PEXakyU9jXUj7FCihq2COrX8Pr8V7aGVMUP2vLYh1fQoeWTjp6ksn+UA73D9HbYrL1EGDr
 Jccr7TDega0bgOJ0Yg4rRa/rg+Ea5U5ZPVqFchfis6HUSKB8rp5YcgJ6B1yaWEQ/8HoW1e8Dynp
 0qTHO/Ygay51f4x4DMov3R5g2Can/KGrL0XfZTgoPcd/t7QdRTGZnbK+MKeqaK6bO7T/0IOFzWL
 HPA6uBsGJPUHZx/N6+fmt5Gn7U/5EWpZLZ9EkFFNOWH5+0m5GBzLl47N1vXS4I64okvx7+x6hVF
 JVtb85fhREVaIoSAKEAy8xTgsyEihLb3TXfIhDGwyACsgoPUTzB9vq8qEEgW/G8yB27m6u94RAN
 iUnf5IVllWH+Rkdsr2HIZ111C9ziDU2lomNzxbSFC2J+d/ExaKj6HoVE3EThBS7ERiVJlMNmvVO
 l8i7QEbT0OnbWzw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QAPI type is actually a string. Here also, if we had typedef support
we could expose a more specific type.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4d35f9b10bc..638eddfd121 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -43,6 +43,7 @@
 #include "system/hostmem.h"
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/s390x/cpu-topology.h"
 #include "kvm/kvm_s390x.h"
@@ -849,7 +850,8 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "dea-key-wrap",
             "enable/disable DEA key wrapping using the CPACF wrapping key");
 
-    object_class_property_add(oc, "loadparm", "loadparm",
+    /* if QAPI learns to typedef str, we could expose a more specific type */
+    object_class_property_add_qapi(oc, "loadparm", &str_type_info,
                               machine_get_loadparm, machine_set_loadparm,
                               NULL, NULL);
     object_class_property_set_description(oc, "loadparm",

-- 
2.54.0


