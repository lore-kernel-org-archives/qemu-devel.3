Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B741CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE70-00040L-SK; Mon, 15 Jun 2026 16:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE6z-000406-FC
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE6x-0002zU-TI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1i/ELmR6ce5TxH25PBTsw4TXMlPSKUoUmXgW6eSf8w=;
 b=AVHbfzdfj22l0T5vsYT0HdwA+8sugKmeqXA0GYdQOBAmxTgjsgHmekaonFfHtNKUx8QsdH
 Iz4uo2FxNNBsIyJD01srdWSLk14U/Q9PoCpibHO1ArhYGh5HWSBWn2Gj3HbZZEZ+45Pqia
 btpqF2Ha22iTBiWfRcU/rqjefyNDIYU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-9h122AkRMQeY5zbb3eC9nA-1; Mon,
 15 Jun 2026 16:40:44 -0400
X-MC-Unique: 9h122AkRMQeY5zbb3eC9nA-1
X-Mimecast-MFC-AGG-ID: 9h122AkRMQeY5zbb3eC9nA_1781556043
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A7AA1800D9C; Mon, 15 Jun 2026 20:40:43 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D48A6180057F; Mon, 15 Jun 2026 20:40:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:00 +0400
Subject: [PATCH v2 34/53] i386/x86: convert SgxEPCList property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-34-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WUngJgOCn0YUIU7MxgXyN/pm0PMoj0Z05vKbkI0PuA8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKP5QaPq7BY8nlvJmtV8mrLHX9wudNT1OFjl
 UUFMabGCpuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijwAKCRDa6OEJdZac
 5RCRD/0QzuiTIkjF+mIQJbSuVZR5PNZ3xdRmfk5lUbvmh6/Q3Ft9THyMghksROUA55WssZ4aaPr
 bLNVLKGbiRmKTEex43AaE8gzdRUHjNszKd8xXpb2Tz8DDhe9nKfPkjxlBUErw3IHG4hIUS9h6DD
 JaP5GsuiI5SM0t3fCZLkBo6jGvZw3GevRxv+ZD3pIt5FYWBh+O/G8xMHFNsEMXU5sRtc9vMMqqu
 N+WEnUtXtb1Li5sTwGRleBw+RLe8HdKASYG4h8S8XjdTVtufx46uzAh/yoGBvozRFm/kJjlhDcv
 okXAHcCGdiTjSg4R/gssWCvZM90+9R4Zym8xeUIA+w0ikwIf5R2mg3ukBFrL+a23MjbIeJ8TiG4
 aH5HefActUh5IJRXRqJuPT7iCuisBDc7fLUAKyiVzCVUBvl8Ittinzjvrk2wb6k5+hVOSdSnoQJ
 CJbxAIRU1LpztB/sPOMjME+YGXgxtaSaYvtBsNLv+FNWuqduAF3gn6KaqWVHpYEHmFWAGgJpQ4j
 806/nKXAyBXCRSKZkMosIpWx7ldr5CAsx5qtgXXyDlhuuUoRdtGE+i6Kd+YpGel0XfU6IoV6VMj
 v5khBbD+QKLd7np3qZKQq70z8AayCzVRTvLDZwjro8qSQFiKmtD0GC2HHNvVP9cJaM7U5803OS8
 alg/yRDRqD8Iwqw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 361286019f5..6cfa4e03269 100644
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
2.54.0


