Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B3DCD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX9P-0005XU-9U; Mon, 11 May 2026 16:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX9N-0005Kn-6I
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX9L-0002FQ-KO
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4iSM+T4OP0fJeJqglC+eTicdbxJnPoKhqUi6eEqqtI=;
 b=G3kRuieJOhR2IilFcHRdAYGojRZN+LrjGWsdK73SLM1WN77kV7oicEZdnUQEk4+NtskXBM
 1VSk62/Q41AA26Ju1GgJTTg+WVxeONYUeCQ8+TukI1oqSa8kYr0lG+uVJfOD+lCIijNLCN
 hvHtEXCQXWkPRt2I3Td+skYjEWYravY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-lKpJnAvtO2GtdZiEqWgh4Q-1; Mon,
 11 May 2026 16:22:41 -0400
X-MC-Unique: lKpJnAvtO2GtdZiEqWgh4Q-1
X-Mimecast-MFC-AGG-ID: lKpJnAvtO2GtdZiEqWgh4Q_1778530959
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAF491800372; Mon, 11 May 2026 20:22:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 667EE1800465; Mon, 11 May 2026 20:22:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Ninad Palsule <ninad@linux.ibm.com>,
 qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [PULL 15/24] hw/fsi: move OPBus address space init to realize
Date: Tue, 12 May 2026 00:21:01 +0400
Message-ID: <20260511202111.3091440-16-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The OPBus instance_init initializes an AddressSpace, registering it in
the global address_spaces list. When a bare OPBus object is created
and destroyed (e.g. by qom-tests), there is no finalize to remove the
stale entry, leading to a heap-use-after-free when a subsequent
flatviews_reset iterates the list.

Move address_space_init to the bus realize callback and add the
corresponding address_space_destroy in unrealize, following the
NubusBus pattern. Also fix the memory_region_init owner from NULL to
the OPBus object, so the MR is properly parented instead of dangling
under the "unattached" container.

Fixes: eb04c35da2c0 ("hw/fsi: Aspeed APB2OPB & On-chip peripheral bus")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/fsi/aspeed_apb2opb.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
index b9d72f3ecf6..36092468391 100644
--- a/hw/fsi/aspeed_apb2opb.c
+++ b/hw/fsi/aspeed_apb2opb.c
@@ -348,15 +348,37 @@ static void fsi_opb_init(Object *o)
 {
     OPBus *opb = OP_BUS(o);
 
-    memory_region_init(&opb->mr, 0, TYPE_FSI_OPB, UINT32_MAX);
+    memory_region_init(&opb->mr, o, TYPE_FSI_OPB, UINT32_MAX);
+}
+
+static void fsi_opb_realize(BusState *bus, Error **errp)
+{
+    OPBus *opb = OP_BUS(bus);
+
     address_space_init(&opb->as, &opb->mr, TYPE_FSI_OPB);
 }
 
+static void fsi_opb_unrealize(BusState *bus)
+{
+    OPBus *opb = OP_BUS(bus);
+
+    address_space_destroy(&opb->as);
+}
+
+static void fsi_opb_class_init(ObjectClass *klass, const void *data)
+{
+    BusClass *bc = BUS_CLASS(klass);
+
+    bc->realize = fsi_opb_realize;
+    bc->unrealize = fsi_opb_unrealize;
+}
+
 static const TypeInfo opb_info = {
     .name = TYPE_OP_BUS,
     .parent = TYPE_BUS,
     .instance_init = fsi_opb_init,
     .instance_size = sizeof(OPBus),
+    .class_init = fsi_opb_class_init,
 };
 
 static void fsi_opb_register_types(void)
-- 
2.54.0


