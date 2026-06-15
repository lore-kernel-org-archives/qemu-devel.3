Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8C2CD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE5X-0005eT-2V; Mon, 15 Jun 2026 16:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE5R-00056t-ND
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE5L-0002TG-Qu
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJVPgFmkndqxhAeNe76OT5PkkkXmq2X5amAic4RIpMo=;
 b=HjhyF59+dxTMxLtyDvGGRQow2S3wDpf8ZK2cmtJMB+50qGnYBzDZ+TqP8IA6WW2IuLGPIt
 nXhMs4Y1ZDtJLP8lJPqpbJJhiKqkQJR7XxGwMTEcUZT2y62yaer46gX7RPOHps0IGHFu12
 Eup0hogKems4jyGZijBDkVPwOa3FKxA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-44cY4LPuP8SbO083Ow4a1w-1; Mon,
 15 Jun 2026 16:39:03 -0400
X-MC-Unique: 44cY4LPuP8SbO083Ow4a1w-1
X-Mimecast-MFC-AGG-ID: 44cY4LPuP8SbO083Ow4a1w_1781555942
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69BDE19560B0; Mon, 15 Jun 2026 20:39:02 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33F3119560B2; Mon, 15 Jun 2026 20:39:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:41 +0400
Subject: [PATCH v2 15/53] qom: convert struct properties to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-15-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SrT2x1EQeUZfUkznMNB+UxE+epWiRHNKJ0FEXJcLuWE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKO2u+RiTL67Ly9IXbxwEJCzQ0+wg/uqAFbl
 0K/yNXEabCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5Wm4D/9p5+vor6Vg7jzySD5ulCCHGUfnu6D0pOT9/4TDPmdYIdwVu1+gj3GImQbwGbergvRny7A
 +NdBo10xVVyNwVl6knviad/wZBBRINAVQTSC4e5h3gwSUXUNkjjGenP7uFnZfcQnEwuewXgirWc
 3MFLd2YSUJlrORnBJC/yAmDlQlTj+fPcDG+zeoVMkWzpEWupM330m488Rx0GtDadv/4UmV/Zd79
 gpK1NrZ/ex4LF+DoUJmB0zj8h2XM8sU+/P8wlhzkRmkZSG1G3Ze+WWmtzCKBI2GO++mNCXyq70F
 v4+ZsMOgDo4j0Fkf9N9CZfiwTk4qiOlQs+WENGkzUFsBIPR+tRvza67nxB3oNTOzhnp9ek/z2Ij
 TRl7CbAb5EntrTIatPXC/52a39NBn5j2bfPCLhFcXEtBpUpPMc7/eWuIVp8dgRS9OnE5JyC65HJ
 H0Fs6JHlVawYSCmgE4pGUl3QVRZ5WfFxWfUiA2REnLBg2LsCecE6Nfu5XW8RYI/Cx5p3NpY/OsG
 X8Wz8HwzpHNaJL8PM7T/dYQWJnw4bhzgSUrvG2YvMP6DRanvIuGhXIyvq/35tU/UiLDOf9EaeTt
 xMPHx1dmXMMh8DwaiJW3c2X+AohII+xh2AJ4TjarCY1YLQS8051fY0jlfbrTuOX9lEc05ibWYe6
 3eKOkn9xo0/cerA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Convert all callers of object_property_add() and
object_class_property_add() that register struct-typed properties with
QAPI visitor-based getters/setters to use object_property_add_qapi() and
object_class_property_add_qapi() instead.

This replaces the manual string type name with a reference to the
generated QAPITypeInfo constant, enabling QMP introspection to report
accurate QAPI type information for struct properties. Existing
getters/setters are preserved unchanged.

The cxl-fmw property type is corrected from "CXLFixedMemoryWindow"
(not a real QAPI type) to "CXLFixedMemoryWindowOptions".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/throttle-groups.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 4b1b1944c20..b161576432a 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -31,6 +31,7 @@
 #include "qemu/thread.h"
 #include "system/qtest.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-block-core.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
@@ -985,8 +986,8 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
     }
 
     /* ThrottleLimits */
-    object_class_property_add(klass,
-                              "limits", "ThrottleLimits",
+    object_class_property_add_qapi(klass,
+                              "limits", &ThrottleLimits_type_info,
                               throttle_group_get_limits,
                               throttle_group_set_limits,
                               NULL, NULL);

-- 
2.54.0


