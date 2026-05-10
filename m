Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D72CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4Ul-0003DF-QK; Sun, 10 May 2026 09:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4UT-0002CB-Iy
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4US-0004w5-0P
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJVPgFmkndqxhAeNe76OT5PkkkXmq2X5amAic4RIpMo=;
 b=Du+n02s4iDVkWW30bq+jPOrtfhcFSObPV6T8Av2P1j4082L+xEl+4g7mCwNa3pDZ95hwId
 1q3Dpj+XHMIoFA8ewN56Pn4pdLy6AUcUhS3Y//9ntm3tbocGWqu/iCee1ipbVkI437XgyV
 xBILFxxsPf3xbnd55bjabKg6DpTm0RI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-btbGTpBtMZatRjv0xhoKtw-1; Sun,
 10 May 2026 09:46:37 -0400
X-MC-Unique: btbGTpBtMZatRjv0xhoKtw-1
X-Mimecast-MFC-AGG-ID: btbGTpBtMZatRjv0xhoKtw_1778420797
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 231C718005B3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:46:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3BC218004A3; Sun, 10 May 2026 13:46:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:12 +0400
Subject: [PATCH 15/54] qom: convert struct properties to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-15-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SrT2x1EQeUZfUkznMNB+UxE+epWiRHNKJ0FEXJcLuWE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItvWHt2hMCrZ9nGCVXdEYPTn2QN0ymay5jIP
 QMMfV7FHVeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbwAKCRDa6OEJdZac
 5YYYEACIcBMr2WU0JQ4y293rozmEYD9g5G4hBeofsW77c2EMWRHNFi5TkLhlyyhZC5wflm62EMX
 ZljS3X8m/aQIYwWPRUkCzvCigGAX/dT1Gaca1x36fZaaQgySvn+s42ujb8xxGXbOIcmdG86CyqQ
 kzcQBcKd9Cvtm0/UTOUklhyW7qZP/0eFRikfBt4yPQm23e4GQPwdYLofTQgaE+Nn3Nd2qLaMhLD
 vunkV6d0VOOCokbQddBq07HvHCY8QfsrzBvW5qNg5ZpEaECWS/CXQy7X8+JioxU+BK/3G37xLTP
 +Z5xD90pccViZjz1Oe+Z/1HzSGWBbPq4NAmh3KqbmeiQTPlLXcmzU7IEORS2Eflk1QMIDhoMm2u
 VmNbcP9H5fCOLmXBc7o6tItKnaI5zOTUG0krT4F/6yIx9MajQQzo8RQVbsh+F4pbETAHtVvCu0W
 JvTbZBJSNVDBq2LFp+nMCvkafDALiq+4rcyOWtzMU5zyDVokyq4yBvHeEUDjrM4dQEN96JCbPtM
 ApsA2mpPuFFH27G2VeWa4EnzBRq9x0QiNdJNO8tryk0ofMs0pfE5Ogn0xow5GdaxWzNdSXa+Xqw
 /m5ydkue60y2DWpakvmeE3b5OIXOu+rQUipTSpQAeNhqANCp3t5+5igpdeYK8qeOYJgevKRU9US
 qVxAlojBnWZ3eBg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


