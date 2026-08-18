Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2241FC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHwd-0006pZ-QF; Tue, 18 Aug 2026 07:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHwb-0006f2-Ih
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHwa-0007po-7t
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tz/am8znVea0EH/I3yKmAvS/zTKGWDHDy5Io0oDOs84=;
 b=SGSih2SsKgMsR2axG8SN8x5y5b9sqKzYHJoMbQuwWmgQzn2trsVQNEqaXLWRUe8gyvyiv5
 iOPduRjXClIV2QKOUKVJIcGG0I4fI10ISk7o0hZjAMjnRaxjcuEyZgkn1MU5xoLF/KW5JL
 4SKkZi2LyKP62Z40O5mKn0hUoNAHhuM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-kXAxSYTMOemP6hKK59RQYQ-1; Tue,
 18 Aug 2026 07:25:20 -0400
X-MC-Unique: kXAxSYTMOemP6hKK59RQYQ-1
X-Mimecast-MFC-AGG-ID: kXAxSYTMOemP6hKK59RQYQ_1787052319
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 187FD1956040; Tue, 18 Aug 2026 11:25:19 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5FB501800346; Tue, 18 Aug 2026 11:25:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:20 +0400
Subject: [PATCH v3 53/74] hw/ppc/spapr_drc: convert fdt property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-53-24b8bbbe3d86@redhat.com>
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
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=p8JanILoeFCoElHoPfG5YjLfU2MyrEO5wI6M3UiSSaA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD283AQfTXMR2X55zc8+lmc+34xEZQjh2uVQU
 DjFJuOFaVSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9vAAKCRDa6OEJdZac
 5W11D/9CAZMQrsluoisevZOYsaQ8dEYBXl0MAANzxTu57azcxKhGDwnJQyxCWv7HQwGdsRn/HQv
 4dltKfWK9j6o38hNzOZ+orAE5BD7n/EP3mSpMfB9IqTyZhk0n8vclcROvBsgOmDdj8QUZwJmMYX
 zvh5XJ66UV9pGO3KPbzqmC+PV3l5VmY0koJatKHPAyPhMl8uD/dlY1VRUbwfnKms9lswdYZmwXK
 A6rTgZJIZsETswcDQgHvhUtozdSkKpde3UjGeRbYRIQgrQmeNvrUKdtWWuA0cdLHuwrl6uBxzNE
 +tuSbuzg/Ohj9c+nqZlplKDVcqt1CvnTBY62xX0+gDVNmRI9dSFlSVFZUfOzeL5Xa4B+wqw3IkY
 nPeWpHqif3cqTzbfj4BNy8kTr1jswxGn37NgapBaAJEQ1LKsaKiJPKBqznxq9XPw8HXJCczC9PC
 gMzfrtKfkPfk/odbSGJj50LyzcXgDGGns6BjG5zseHnNwIo1qbJR564rBsxZ22LiTmwU8f6NRST
 CXuU/AyEZLLhouWqsPphqA96tHFidRM+uMHx+UiViiAvOa9TNm4fEW4i0Tjz8g4ZnZZAEcKD+T6
 ziF5hTDoTfs9Cz2DCvTfrycym0+3ElltNCTVPoFLK+2cN+T3bi3dew3O3GhywPvzk38cO/s+0vj
 NhJUqn/6+gjougg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Use object_property_add_qapi() with any_type_info for the "fdt"
property, since the FDT structure is dynamically shaped at runtime and
cannot be represented as a static QAPI type.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/spapr_drc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 64f9ca29b02e..740149ffdf3e 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -587,7 +587,7 @@ static void spapr_dr_connector_instance_init(Object *obj)
     object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ);
     object_property_add_qapi(obj, "index", &uint32_type_info, prop_get_index,
                         NULL, NULL, NULL);
-    object_property_add(obj, "fdt", "struct", prop_get_fdt,
+    object_property_add_qapi(obj, "fdt", &any_type_info, prop_get_fdt,
                         NULL, NULL, NULL);
     drc->state = drck->empty_state;
 }

-- 
2.55.0.543.g5ebe2ebe4ea8


