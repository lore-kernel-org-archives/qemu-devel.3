Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5434C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHwY-0006Rt-OL; Tue, 18 Aug 2026 07:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHwW-0006NI-NX
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHwU-0007oE-T5
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DlOPStXdEIjyGF0oiytCfRyliZf4DuDKBTVkvMdaihc=;
 b=Xb00PxBTx7zrDhJOrSGMK82boKI8N08MohmZ0aAC5MttvnWfzNQotCz252gxFUMUPtZyzi
 XHwRa6y6Bqrh5r0rbaT35YqE59jWqTf2SKLf2V79cSU6N9HQAiaZNP6ZBAmQ82Jj6tPdMx
 lGVdcqQDvTSxUvdoOrAhDJzSM5qP/bg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-eXDyrJ9mNyq7RDsTxd46Jw-1; Tue,
 18 Aug 2026 07:25:14 -0400
X-MC-Unique: eXDyrJ9mNyq7RDsTxd46Jw-1
X-Mimecast-MFC-AGG-ID: eXDyrJ9mNyq7RDsTxd46Jw_1787052311
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB5A9195608F; Tue, 18 Aug 2026 11:25:11 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9A2C1800348; Tue, 18 Aug 2026 11:25:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:19 +0400
Subject: [PATCH v3 52/74] hw/s390-virtio-ccw: convert loadparm property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-52-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 qemu-s390x@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8KK4K4ulUWwzD0z52eof8cDeeeOb611fRZTz6Eqmcsw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD27KkgyIoz261EYLE7UCpEP9J2RjTTLQpX6P
 DxARhJFr8uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uwAKCRDa6OEJdZac
 5W5kEACo387VbvsRALkvYZPF1k9fFzXsX+G3JvAsFSyr6NkJJjEKM7tok4CvtvAjuGs3o6Ct1Q5
 c0dkIP2XRpmi492gEBqUFnxsPBHROe3IX55q6vRjf9ZxpHF3gfm6zHeuDCt531Zq7RSbT8JFg6I
 5Qjy1B/Xj10vCi+lAwwKyvFhUolyTg5UIYNUXhAA5W1Ix1LI9qyZReYmqG0YJVgcv6GQ9q+Tv5G
 nMbEIdj44QvalVzap4r9FSntgCUlgtilZHl4NYBFKmIQ6Muvi/PzrNpMNfq4pSO4FLkXyPFXzF2
 pCD5sZTxGmTwkaI+TP9CCHdWUza9WdLIk9feyg9vlLdkrMN6ZhCzDuE8RN6ogSLhW+SDxCuZnyE
 wLzQ+zpLEfCob37MeGmIZlBKjIn6PkjgSIrWZNoetsVYF1YmmSMPmT14wvbrlkq6OA6WW2U41Ac
 WdvXT4WBQP5DIr13btFI9sjZqbOvzOwtIF05n8AZtvDMjwo+jgx5VSNuTdNlvQ8wFvT0kzoaGWQ
 d60gWPZ1CY2PXmahqLpOF0UXg0Mu5GYm7hqilxpsuQsFHVsb7MMQJsoEhinBM36qZ/cTZDqzjfu
 0o0ZlWrPVBuVPUIkVMOiGnIqumG/IDrKyTABYIzOWjgRmH240nVRZKKNlDrYeJCJ7tIYrxF7Ijs
 NQvqvPVNq4uiMOQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 06e5def9092b..c80d7ac92b22 100644
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
@@ -847,7 +848,8 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "dea-key-wrap",
             "enable/disable DEA key wrapping using the CPACF wrapping key");
 
-    object_class_property_add(oc, "loadparm", "loadparm",
+    /* if QAPI learns to typedef str, we could expose a more specific type */
+    object_class_property_add_qapi(oc, "loadparm", &str_type_info,
                               machine_get_loadparm, machine_set_loadparm,
                               NULL, NULL);
     object_class_property_set_description(oc, "loadparm",

-- 
2.55.0.543.g5ebe2ebe4ea8


