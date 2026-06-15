Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CD0CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE6c-0002zc-J9; Mon, 15 Jun 2026 16:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE6a-0002uP-Q2
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE6Z-0002xC-F3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcsOJYbV1t9bvR0CbyRVNBwzQwlu40sYNc0EtLJX0Lk=;
 b=YRd0/cnYahjjU8fYaoaEBbY7w6gsc0CxHAXSdPBNBbL2AsijyLEZN/GlTtTkSri6Aq9+Hf
 RRt9fqfEG2bfO1VYcFWLooGtvitVb0XacM6KxNBHDd7lFonDtr+kU58CfJwGXHsEu98jOT
 B7avo/SoxCDTp2kEvHLacjRaxr/PPgo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-iTp-nj1OPIO5pnS_X2fxHA-1; Mon,
 15 Jun 2026 16:40:21 -0400
X-MC-Unique: iTp-nj1OPIO5pnS_X2fxHA-1
X-Mimecast-MFC-AGG-ID: iTp-nj1OPIO5pnS_X2fxHA_1781556020
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 879F11956065; Mon, 15 Jun 2026 20:40:20 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41D8B3008B37; Mon, 15 Jun 2026 20:40:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:56 +0400
Subject: [PATCH v2 30/53] hw/mem/nvdimm: fix "size" property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-30-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=712;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iLi46W9WFHxexD0wQx3j4fn0Sh6woma/VJ5/jKMvPFQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKPSFnFj/+Ic4gBtgNoXIQ9yBlour1jdUals
 Qy9fM6FHP2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijwAKCRDa6OEJdZac
 5daNEACK4ynnCxQM54q0x/E5r0WP8+MUiiz0wRb/1W362UeqDWHbNlyJ15EhJxyMLsnVpqQ4HUb
 cNyENNVzVteY+yFmm1SYy1QbBcQgnV5hDc7/BW0f8RpKELFPdaCz9pnmHxdYM2AuWCeTvlnf9YZ
 PXAC/gY7CszSu89Zm9YvIfGwj/oFpV9qijdkDptYvA1D67HaQNvLieoZmcLtoLkxttc0CIgl2/9
 EgE668/G9f4J6VfkviJkwTjNVPSnxXQslIDrTzGwUUzQuMVwSiHK7M5hFYJcfDrkLr5fzO8E6L1
 0SpgGIOznJqiWVTnBK/8ebV8OqZr5YOBAWRjvRRd7LdoaCfMa5JQignNydTKI/znyIRWXYtGErT
 sv8y769ZuqsG6IiRFOwBXdNlSGSetHNnwJG5ngtqYWAeIhcYo2N/Qn0tITw5hnvcLWUaZCnBCxS
 k8lz9jON1L8pfEZ6HRR+ijnEKFWOG/GfWfaQK+vAzUIqqOlyekwPVd1ZfnFWdoZWVCUhFW5JWKe
 3GdMZ+gV5FpOlbpTzuBuqAEi5pdQ8mxSfx5+8cKk0OQYRe459HOH4qYX67WvzzaVkOgDwLdYqBu
 +/0janWRYl7mF0nlNISUaO0s5fkbOVn5M1X5Cm4nyl+ofscix6agH+Sput4jyogU3gD9fLgUjBE
 Vrlomd7vdwA+UVQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


