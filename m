Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C698FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrdB-0006Bf-Ta; Mon, 04 May 2026 07:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrd8-0005wv-6d
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrd6-0001Hr-J1
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uhmtc7dYjQMN1jMZa6kxMNc/KRWfHf/T/TyMWiJ680=;
 b=MXbgAK35imNkJpE2eg/t6l8Ue5e/ZA7EzrpyoYosBLF7DDeSyIrESJhIRvE9VQ1ElNMZcf
 rqfIDGA70ChhB2hfdIaVqPzHT5ljSvzJ7XJWQ5TOLCO4g95wzhn4bWxDk+XA9yqbOIR4j6
 NSWaeBdJOHhhinxhk0e5SNo6H28uZz0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-OiiLnOkQOAqJYO9hq9Jasw-1; Mon,
 04 May 2026 07:38:26 -0400
X-MC-Unique: OiiLnOkQOAqJYO9hq9Jasw-1
X-Mimecast-MFC-AGG-ID: OiiLnOkQOAqJYO9hq9Jasw_1777894706
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFD4F19560B5
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:38:25 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18B1F1955D84; Mon,  4 May 2026 11:38:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:21 +0400
Subject: [PATCH v2 33/46] hw/fsi: move OPBus address space init to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-33-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2041;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KILJnJhSBQUK/Muq0oJYoyL0XcLZf7mKortd6mZZUGU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtkHwrDnUZIC+S8Ez13lnmT8rBpw5EvgQr5
 /BfpM/ui5+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5V24D/9UPKuMHvfCzcumfKeS063iVTHyhYb+539Vpig5f4Xp18Gk/cr7lAmMnfkeQ66xvsYfRZk
 iKZFEEIePAmQrG8LBmG/G9tUaKuPL1aFRdGKKLP45XUaHmecI9LRmE71jZuNf24YfH7C0Y8MN6K
 Cajm+UoUMOTswAVKPNZLvWVmgRBVgFd6PgFPdtzhWAxtJpGLyKKGo9KxSVYCQmdIPgml8jE1lhL
 hVgPFydheMT+iQUT261nY3osxemGUnp21EGE5wwTZczFgzR++P+NGJupvroIQdOZwVuVDmyp7L8
 qYDVCkdogbNje4GvoodbliYMYe5mBoiVZZlJHLa5TwIgEAVJslk7mUc91OWDtbSYpYW+L3w2hTg
 rIYEOvENz5X55fQtCPwxcB6rTdLQzii5UYXKJ0FtkhdHLpLr+WtoYgjxPlT0x9rRTossPSeZR/G
 XDTB2xfM/vP3XR+BYbhmQ6ZfkBw9rjb7yfGch3lUgGezNJb3Oj5dC3iqsPYBIcoCloV1+6zE/Vs
 oIhY5srXSVNjhPiVZNfrclwC2MrJS9QyslklOtARpvGYWJCqS96cbfVJR1EyHqGGaZjUqvVWMsg
 sK1LdtFBKHT6duhsHvbQY7kr83XVoXaf7y1JUVhjzpI+n6W17xsyZgrZD0KBlrj87E/T1MVR7Df
 XjsicoeWiiYMUnw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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


