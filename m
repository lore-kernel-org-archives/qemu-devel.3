Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B19DCD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrdK-0006qm-Fk; Mon, 04 May 2026 07:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdF-0006Wo-Gv
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdD-0001Il-Ps
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0bsIIMKhxFpIJn0xl6jXJpi31e37LsGmYzmuzP6pM4=;
 b=J5E/rmy/0VZOWMUXTa5OV8E0ItAvZzjRgZ7dXKZXC3vjGme9wLSH7Fs+NO0rjd6a9BUhyu
 F2FMETXDFtbBqSdW8LEreHCXEWeQlRHjUfU+/Fdve9P3lzvxznM9fsItgNtqFbQzM4MVng
 hxfnurcrcuEDoWTl7givFprLbidBU2I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-_x_9NHkxMY-Wyjy6jtvc5w-1; Mon,
 04 May 2026 07:38:32 -0400
X-MC-Unique: _x_9NHkxMY-Wyjy6jtvc5w-1
X-Mimecast-MFC-AGG-ID: _x_9NHkxMY-Wyjy6jtvc5w_1777894712
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1C2D1956053
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:38:31 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63E3E19560B1; Mon,  4 May 2026 11:38:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:22 +0400
Subject: [PATCH v2 34/46] hw/fsi: move OPBus qbus_init() to instance_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-34-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CVudjOeCyZzDTPF5IBNWQlIgSw+1Rz8G/fZyKfzNExw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtZ79WtCadqntEqeNDEhdxBLIEkOMbnlciD
 NtU3PK2QwmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5a8/D/4pwdSQCD7+NMRTqLTM6CNdc2m1lYb/kNngSd6LxcPoc3wHUylgG4L8nbQkNSkdLq7nGxO
 NfR9mSYuVrylntmbxQtES8uzvB1COP2N/OH+N/c+z3RsvV/StSaymDCkgD/yIBVbKqHPk35Z6EM
 POVN2WknnJbXQClJDBpfIb5Z5XVZ8QPXIVZxEf5L0gEL0piDDbaRAPVkWQJFf1cH6ad2inAonw3
 LJGvymaLYpHhdHc9p0RhDVx1e8LoWwN4Fgafe2YfLbHMPlnubgH8MIOXLsr1/Vso+dxQN/YJwvm
 JOeoxgl6qBf6jWLTu7NFuKHqco4wkSNxCni+zffWbfzFdNnApvhSBr3cFMFLGvwIrcTUQk/T9j5
 RfHn6MQ/3sBhDfKBurs+e9rK+BXkdNIVCgPcFlMEVQyz4KXmdJBWvHB4adf8LAtA+1kU4xVMTHk
 2D3/nxnuMqNvSMy4mDuxcWgdxba2xKfy+rXiYoIiAGQTWA3S6kE4GxSiFuDxhLyfIKi73ZTqnCF
 P5qqmzDIj94djIj8oQ5R872cQKqYGdMMEZh08GPj+/htnNoZbvop3geB9cHgDgaaS4C6pguMwfi
 3XKXNRqwArLJBrtXc5cmMK1w31lNgOiqj3I/kFl5aCzhkQjmXucwt+Aq4o63gUBTLnXkp3BbCP9
 gb2RFcVrF3UtdIA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Remove the TODO comment that documented the workaround, as it is
no longer needed.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/fsi/aspeed_apb2opb.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
index 36092468391..058abc86452 100644
--- a/hw/fsi/aspeed_apb2opb.c
+++ b/hw/fsi/aspeed_apb2opb.c
@@ -273,6 +273,7 @@ static void fsi_aspeed_apb2opb_init(Object *o)
     for (i = 0; i < ASPEED_FSI_NUM; i++) {
         object_initialize_child(o, "fsi-master[*]", &s->fsi[i],
                                 TYPE_FSI_MASTER);
+        qbus_init(&s->opb[i], sizeof(s->opb[i]), TYPE_OP_BUS, DEVICE(s), NULL);
     }
 }
 
@@ -282,18 +283,6 @@ static void fsi_aspeed_apb2opb_realize(DeviceState *dev, Error **errp)
     AspeedAPB2OPBState *s = ASPEED_APB2OPB(dev);
     int i;
 
-    /*
-     * TODO: The OPBus model initializes the OPB address space in
-     * the .instance_init handler and this is problematic for test
-     * device-introspect-test. To avoid a memory corruption and a QEMU
-     * crash, qbus_init() should be called from realize(). Something to
-     * improve. Possibly, OPBus could also be removed.
-     */
-    for (i = 0; i < ASPEED_FSI_NUM; i++) {
-        qbus_init(&s->opb[i], sizeof(s->opb[i]), TYPE_OP_BUS, DEVICE(s),
-                  NULL);
-    }
-
     sysbus_init_irq(sbd, &s->irq);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_apb2opb_ops, s,

-- 
2.54.0


