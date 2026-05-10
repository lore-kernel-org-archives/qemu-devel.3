Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3002CCD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4X9-0001L9-PW; Sun, 10 May 2026 09:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4X3-00018S-FI
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4X0-0005Tf-IT
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcsOJYbV1t9bvR0CbyRVNBwzQwlu40sYNc0EtLJX0Lk=;
 b=LsIneutSmjm4poOwYYyEEY1Y7AJSkvV1N+uVGzNh9by7Vj2Siw0jQ6oe74eFtVoQWGEySs
 nW9WaZX15UkU2o1qErlDS4GC/SIPYfKrXGK9BhXNesKkVDvTgGBa8PJNrEeUyiRJpfipEl
 kv66qgFqTiFqtdbe/UXoZgcrsh6xt4s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-chIUq745PtSfvMceFDeLuQ-1; Sun,
 10 May 2026 09:49:16 -0400
X-MC-Unique: chIUq745PtSfvMceFDeLuQ-1
X-Mimecast-MFC-AGG-ID: chIUq745PtSfvMceFDeLuQ_1778420955
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A6231800359
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:49:15 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBFD53002D30; Sun, 10 May 2026 13:49:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:27 +0400
Subject: [PATCH 30/54] hw/mem/nvdimm: fix "size" property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-30-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=712;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iLi46W9WFHxexD0wQx3j4fn0Sh6woma/VJ5/jKMvPFQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItwixCVrx75OFL/oiOSxn3WvU/rhwb32vR/Y
 42eH2qwAYSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcAAKCRDa6OEJdZac
 5c3UD/98YEeNU/2jKyRwum5ot9eD8FlwwDBVLuiv8hzhdf59kcT8l4QUsRK4akaZ9pbENsCKJ4Q
 g+Ql35hoQTh3Ps+ugWN5szXABTb3aUsZJA2kGioqeiO0h4CwfKASyKZK2D4we9kEx3Qe8oFVqJT
 pdYQ/akITuZvyp1oBuZ9lm3bU/1EbyzSe+7dzMICiiuGpZwzPC2ikTLuu0hrfaKilvzlQDjJmLh
 JAj4L9Hg/mfI6txw6u8hUjO8jkPJo+gBj0IMsJjn7dCMd1yVLrzC8/8sPC7ukc3a0buctIt9HuV
 PPNSz46F3xM9M1Q05QUsk8ywBfY52v0tbnstvSeX/hJAXg0HRm+exfVcw1C6aV+CTT2on9mHzEX
 bjwiSAdFdenEqw3BNDdbdsJtt28IRAYT1svbRfsvLjuorQH37VVPeoEEZSnlYUdg+UWhXT3GEP6
 1lVR+4giOcUQFCipGuYTSuI8Tu9sOGQ70OM2lms1o3xcKatAMK0KS9YHcXg62PYehsPEGEFx2VI
 rGYGNkB4qwiv9XJlwlncMOhTnN/cnHFnQIRxG9ojQDw45L7HImVF5o5OYpovMKnllj3HCPKkby8
 0XuyWwGZXbDjNi9HaQfNAK4J2Se6iPP67stN0Ov0ZK7nNJHiLDjsNbPGYvO4gC3nctW7zHJ1GTx
 DIM0pCFR0yojEug==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

The getter/setter use visit_type_size().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/mem/nvdimm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index b7032525271..cf8a4d8c5f2 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -99,7 +99,7 @@ static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
 
 static void nvdimm_init(Object *obj)
 {
-    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
+    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "size",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                         NULL);
 

-- 
2.54.0


