Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF18FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRtd-0007bf-GU; Mon, 27 Apr 2026 15:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtb-0007O3-Pm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtZ-0008M7-TY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oU4SNskSDPFZiif/NOcNoCJdXW+fc2i/XPbr9XUbsk0=;
 b=NSavbMoTPGRzwSDClFBJydnaeFkHeeE2JSzCEOirDsDsbbSUnQVS/nKmrvpVQCKQmf1iyf
 2t2mTffnoRQfYgdoB8e/hwoT4giAApLMKX2Gwq+CYvOuOToEF+y0Qli2kykNS9Sx2JybRE
 NFULJriShssolYHl1cgVOhphdNmXOJs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-DZew6p90MVaRME9onTFi8Q-1; Mon,
 27 Apr 2026 15:45:22 -0400
X-MC-Unique: DZew6p90MVaRME9onTFi8Q-1
X-Mimecast-MFC-AGG-ID: DZew6p90MVaRME9onTFi8Q_1777319121
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64BFE1800367; Mon, 27 Apr 2026 19:45:20 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B05FA196B8FB; Mon, 27 Apr 2026 19:45:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:28 +0400
Subject: [PATCH 29/41] hw/fsi: move OPBus address space init to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-29-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BS8tdTzpkf4ZJcQmTy07g8mUo37sYFyz7sUGqL/kRMQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVAfCGmF7+C/wG/j5UXHa8K7V/bavziGb/I
 4m4DPa4chOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5d44D/9oYfS6O6eLw30OBwOwiUXqwI+itdapJnwCWfu+Gi+CmBIiIyuATT/LL+x9PrTukg6/OM2
 cBKaJT/ShE+tjzg+2g0X9oSZS2pHVV70LCBCF65nanhCL8ww4xFVXOfFd8b8Yt/lih/EeL6cA6Q
 8xnfNwXGo4MkpLQPyxs9ReVXyPh4KTUHeTWyP377R3YP3OQErDTigSLlJMUNXd4wVT4q+ZuflSx
 aTTviPy4GVXih+ZHpgHhnPA/J+valLmY4Jhz0kytR/8A3UX7rrq13j5Wz6/zdbXE8HSQfi/mdJs
 YcFLjg+pox4EZwFRDsvyupY3A4iPbq5olpCIRSWZb5lMOKHiywauRmVEuCuoh4O0rHdzPq+3hFI
 cioO4Q8PAdQCtV1YtDEkJLpgnpnTMMBHr/ZQvAbIpU1N1LrKen/3iK+78D0dBCxAAuNwNUAGBmX
 OTNTow+JgHX46z3uwTiH6bUX7lZRSOyVUrUa0OT+LUO1XhYW5Ni9AZ391SXwcGa+eyDDsRGceCT
 nFAfI6kcknXxgg20qAhwCc//RjIwfmDoRFqM1BKIXDjMzeapojx6271IW04OZeKwbFCxCTNFcKb
 GuBqVEc+W1EjLK+Jc1gaGhTtV/yiqGCkG75IFs42nCzznfeLrdUo3tirD3r+ZczAylYAlLHaP51
 jqxPPlUnAmWD7uw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 hw/fsi/aspeed_apb2opb.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
index b9d72f3ecf6..5d1e471288b 100644
--- a/hw/fsi/aspeed_apb2opb.c
+++ b/hw/fsi/aspeed_apb2opb.c
@@ -282,13 +282,6 @@ static void fsi_aspeed_apb2opb_realize(DeviceState *dev, Error **errp)
     AspeedAPB2OPBState *s = ASPEED_APB2OPB(dev);
     int i;
 
-    /*
-     * TODO: The OPBus model initializes the OPB address space in
-     * the .instance_init handler and this is problematic for test
-     * device-introspect-test. To avoid a memory corruption and a QEMU
-     * crash, qbus_init() should be called from realize(). Something to
-     * improve. Possibly, OPBus could also be removed.
-     */
     for (i = 0; i < ASPEED_FSI_NUM; i++) {
         qbus_init(&s->opb[i], sizeof(s->opb[i]), TYPE_OP_BUS, DEVICE(s),
                   NULL);
@@ -348,15 +341,37 @@ static void fsi_opb_init(Object *o)
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
2.53.0


