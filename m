Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E01CC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHva-0004Dm-PF; Tue, 18 Aug 2026 07:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHvZ-0004D9-4M
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHvX-0007GU-H8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIiDAG2jKPc8trfxeDzWrsYVGy/FtqWuSjPzxQy4+IM=;
 b=dZ32JPMcaqWHwkDnSmHIYn0Dm41ETdC274/9VUUpLYY+Yt3NH6GEpUl6XC5V09xuN6KIEU
 TvUyms+qY1Y6GNUTqAuFwyNP9aSOCw08sEbeMTKFx5HIGZrD1GUlW8I2BKYxSZik5oFAe7
 amlJLSE9F/Ncw3pzrXLFX9UW4aNrDH8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-5Ml62bQSO3u-tRqpTeh9Kg-1; Tue,
 18 Aug 2026 07:24:15 -0400
X-MC-Unique: 5Ml62bQSO3u-tRqpTeh9Kg-1
X-Mimecast-MFC-AGG-ID: 5Ml62bQSO3u-tRqpTeh9Kg_1787052254
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65D6F1956047; Tue, 18 Aug 2026 11:24:14 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 299511800347; Tue, 18 Aug 2026 11:24:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:15 +0400
Subject: [PATCH v3 48/74] i386/x86: convert SgxEPCList property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-48-24b8bbbe3d86@redhat.com>
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
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cnTGm8gLgIdGgYxLJNoo6ULUUXiyoyqTdIIMx4XVumw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD27i5h6WdjbgKQJFbRnX7zbgFQfLjcM96c1Z
 ud+a0WrkuaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uwAKCRDa6OEJdZac
 5ZHbD/9SMXkD6jEZ1nvLQMhr2h14XUnX1XL7EAC/Qkitl90HAkH8B5p+GnfHDzHTOWzUIK/ADBa
 BJvjkK8p48GCjIBCC/d8zw9vh6LmRQL4qEKYQmu97R6DvfypV5bqNd1cMY/dRN5P3fNqiSG7Ya/
 8OU7znsWTO3L5m+MzUNRWnXzEU8GxKBSTli34cQY5MNKlf70qAAFZGauEA6v8rerRNrQhbwlohk
 yAIFHkdWXXjzU63YquRT+LvLq6LyfCOvLJ3PN+XGcGVAZybOTEMRy5DY+cRDY1ijuVYZdSgxIYv
 bptHGcvTqscI7LiuPHPdaQ/lTONdZQLy2AMzoCSBzHayKY4YGLDFjnTMk/X5NYv+eFUf4GZSp4q
 IQNf1qrqemAKtewLrprB0DPMiMWNG3wr5UUWUibmV4qSo5bn7oj2N3TBK6SkeCcHvf4eq3KjyPo
 QihNCdpbvkpgUr7Hl5MxjcecvIKM3whbNBL6JF79snV5Q2lHC7bZIopFV5bUzA9u5B17d0+ea0y
 hX2aqIIoS4r817azZJ/s34v5qv64a3zlM7fdi/SHQ4xg7ok1+JuRG1KEsrRs8YCcjd1m7X1SLxT
 8N4WMA/FbD4iAS12rjIFA9a78i7SYMtXo6P+TOFI3YWC3Zyqs4+lEHOkZM0ELVcKHewNTjuIHYU
 oiPs9oUGvj490Pg==
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


