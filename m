Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA78C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHtV-0001pi-PD; Tue, 18 Aug 2026 07:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHtQ-0001eO-T0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHtP-0006y1-JI
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=upABZVt3TfdZce8AYOa3jKo5LaXazAetV9qjSdghA5E=;
 b=NFBtmOy73zF3yom59Z8DE3DZ7oBGxumxzvxUuS672Byvr8H8KykUUllUunvRcMwwWZHLkV
 tcNR+Wtx2bX/IOyD6rivV13h9wgMvJsaqG2mWt8jf3XfF5XYzNlmK6+0DLKKaOV1MhDMh/
 v8izCk81pwIDfWC5bTfsc1ayXbZAoUU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-FD7FXlZENpeDkCoIcg-PQg-1; Tue,
 18 Aug 2026 07:22:02 -0400
X-MC-Unique: FD7FXlZENpeDkCoIcg-PQg-1
X-Mimecast-MFC-AGG-ID: FD7FXlZENpeDkCoIcg-PQg_1787052121
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D9F6195609F; Tue, 18 Aug 2026 11:22:01 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBA78195608A; Tue, 18 Aug 2026 11:21:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:07 +0400
Subject: [PATCH v3 40/74] backends/hostmem-memfd: fix "hugetlbsize"
 property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-40-24b8bbbe3d86@redhat.com>
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
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yQQ41cp2PPxrzqYx6smXKcd2PGq9TgrY23dLiOx59og=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD26R8p52L+EJzJzIYsE14kOQbzix+l4p8AvM
 NkJUYnie4uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9ugAKCRDa6OEJdZac
 5b+qD/9Os9IrLx3YmHS7RBI2gzun/U7Vr8Ub6QUIsjnQmB8h8M94wrwdYAUAU2M03NKY8QBvMk1
 SFIm3c4dQKMEPt/MxRLokDrTKVi1QgXPBno+uF9th37AuV08pAUIPzk5zr7B3OE6pAOk5eRfSZe
 1z2+uOH+5MpM1ROrOLH7IDeme5gn6wDZZsuaZKBtduxEJ6w43q7dc2kr0wbZgEbX0xQKawYif42
 gS6Z3EtVTePApTukWmE1rI0f8qY9qBvSzUWrFTEyNgdP0zC2mL764f0SYbNhKd0xa/AIQJWG/fm
 HMe+cy5PxjQnF2Q/K/vCI4NudiAOmFy+mPIIDOCSiU5oSe4CaKimyK49Zz8tOHeUmVRTWaEJUTe
 hI8e09NYeZGM9ZVzkZrr3nB/E5ndqxp66PjugGORq9kHqSrJRqM65Z7wlK9T3h9zackETqloVoC
 1tJ7hsj+TUXaD93gHNB69qzSP/k4YB2vxm/mz/AA7MOYt0gyVX4rn0f9v6nq+ZINNayblOwfe1E
 dIW/9LP7Wp/R63IPCOWpPLld4ftEBfR82PVVvH4T1xktfXP0NnCeYUAy9Pw7jGYpfjn06TmSwKt
 +TZ2s9CYBjRRtS99mJ7TUqJkETXimr/HhzVTlC79Aj+OFxA4nPTpkFbm9iGqxiOUYsfVaPgI4oF
 9hLr2c3Mohv9IiA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The getter and setter use visit_type_size, not visit_type_int.

Fixes: 3829640049cf ("hostmem-memfd: add checks before adding hostmem-memfd & properties")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-memfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 923239f9cf69..77f7eab40fe0 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -145,7 +145,7 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
                                        memfd_backend_set_hugetlb);
         object_class_property_set_description(oc, "hugetlb",
                                               "Use huge pages");
-        object_class_property_add(oc, "hugetlbsize", "int",
+        object_class_property_add(oc, "hugetlbsize", "size",
                                   memfd_backend_get_hugetlbsize,
                                   memfd_backend_set_hugetlbsize,
                                   NULL, NULL);

-- 
2.55.0.543.g5ebe2ebe4ea8


