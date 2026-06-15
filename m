Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55132CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE7R-0004Sx-80; Mon, 15 Jun 2026 16:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7P-0004QD-D1
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7O-000328-4y
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fblFAfWvPjTcuTdOqmHwe2ln7ZdoKOzUMwULX0TawoE=;
 b=cy9iHhsKLbDmQdQ1ZsW1JBxmbkz7yDcCNYiJHsXl4Yb4ricLI9HB9anbJ2naIkcCS47MDU
 jXRPgUZuTCHLjCVJ9lmyT3mZgtiTzo2xGC1bg7e89IVZyxhza0tdRVDa2GWVGK/WIWxm9m
 eKRL+BmCIICFtk1HHBeba6fx3Bl7bnc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-Fft2Kzg6P7eiqot1M-F3OQ-1; Mon,
 15 Jun 2026 16:41:10 -0400
X-MC-Unique: Fft2Kzg6P7eiqot1M-F3OQ-1
X-Mimecast-MFC-AGG-ID: Fft2Kzg6P7eiqot1M-F3OQ_1781556069
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EC651955F56; Mon, 15 Jun 2026 20:41:09 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 679621800347; Mon, 15 Jun 2026 20:41:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:05 +0400
Subject: [PATCH v2 39/53] hw/ppc/spapr_drc: convert fdt property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-39-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=998;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oNnnydeZ+Z/4woqlL+ZtQDVgVy8svDVrLv4Ho4BK3Dc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKPLUUzLYyhdg548zPry+0u+0kN0Le3M8Sdi
 cxQix+SONWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijwAKCRDa6OEJdZac
 5SV8D/9sl2cPw4Z0pXKEb7jejdoHdIimdegvEMFFb2Yyk9X/MR3BZC+6GP0EfivszZ0C1JDaeG2
 VdMnNBZ+76am+m5Xon1Sg5ZV9VFYMfOpBUMD1RpBeMm0hoN0nLYELw0gXXKeoZN/ctsL4xOTm5T
 1e0qaDs9fdUPa2sCccd6khrHWmPXw9EnS1E0mVFLnh7+TTRgnZf/Ae72qz4Yjixc20dmWZbYkJV
 jhohw5o7Iguz/Y+S9pRoiVIiiXBWzJlHitAfStOtQeBpLp0aFybfr6ISFWaL+gKcAaUf5+/bD2n
 52pWf4Y3nXMZwp6XmicY3tkVbBizeCKdhrkYCKEg7MCODwhnLNvCHUgtqcwLdAl2iyrTyMTNutG
 YYdLD6HNaF+fl0orEuY/qsoF95YepTQAlF9GUbk67jv2+yplRPyGgPq7clCQWD8QtGhiBpA8L1W
 QmfFoh5K/1ax5wt5+opt0hJPSrpHlph1kjArsPytT0NNfta5an46SPkgXyGsxKnFAKAEFIGDNYo
 6UNnaJMhAYTP+FOK1d5f+P8bzwb0FsYMo5cKHJwquAx9DkWpsSsohh3BtoFN1F8/e133UV7/orC
 JToLGhxvRg70SotXOkzd3nPpedDo0S/avhWREvBJdZerVGWCcZiguV/hq2un6mbtyo6ZejeD9vo
 cPijSQFNbshzplA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use object_property_add_qapi() with any_type_info for the "fdt"
property, since the FDT structure is dynamically shaped at runtime and
cannot be represented as a static QAPI type.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/spapr_drc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 62baf38a00e..fcafdef7dff 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -586,7 +586,7 @@ static void spapr_dr_connector_instance_init(Object *obj)
     object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ);
     object_property_add_qapi(obj, "index", &uint32_type_info, prop_get_index,
                         NULL, NULL, NULL);
-    object_property_add(obj, "fdt", "struct", prop_get_fdt,
+    object_property_add_qapi(obj, "fdt", &any_type_info, prop_get_fdt,
                         NULL, NULL, NULL);
     drc->state = drck->empty_state;
 }

-- 
2.54.0


