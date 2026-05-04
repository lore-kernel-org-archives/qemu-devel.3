Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD90CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrc3-0001Ay-AH; Mon, 04 May 2026 07:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbb-0000WV-QX
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrba-00011K-BR
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tn0OCpP159HA+f6R+KQP0S44C9uWxut2R7clX9nuNXk=;
 b=SlHD6ZgtUZO2w6OoQnO/LScgHVhjPBWX2FZXFcLZmVabszpMYliTu9ybZp3ULa4lr4kY/B
 SGioiBXL8E4tLN4wxWZ4sm7iV8hCD2pf+WUZlc8s3ZGxmpL40o3b1A1BiWAD6TFoWCYKT0
 F9inb2bZDtaYEBk7anHGp58o29me7zU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-nCrX5OxGNl6fPPGtpfiS2Q-1; Mon,
 04 May 2026 07:36:52 -0400
X-MC-Unique: nCrX5OxGNl6fPPGtpfiS2Q-1
X-Mimecast-MFC-AGG-ID: nCrX5OxGNl6fPPGtpfiS2Q_1777894611
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D4821800578
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:36:51 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 127FE19560A6; Mon,  4 May 2026 11:36:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:05 +0400
Subject: [PATCH v2 17/46] ui/console: remove console from global list on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-17-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mcTfYn3iaVcXEtf37PXP/OHeHd23/2dVTmMNCHATXSw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRsDmam5idYskbVhqMU75Wwoe6oS5IUKeUog
 mZkSoIx+uOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5bnKD/9x/MtQkRHJYXCgDOYTS7fOYJiRYwH+KP75H0e4shXK5aLXrow7IhNuSIBYWWVXKDs2dAY
 jWZhZb8g7qjZs10t5yTySq4u1Fr+wYNLOWbUm4L+hPJiywCmqx/aDMVWqVIaghwKJ/lHANtGMpi
 acYkOsxOBi8jGdGOGjTYAmgI0Hi3+B1jL+252xtscdGY5mbcERwuWqQVLCiDSIGyN8fg8mWg2Gg
 ojdkjej7MwgKNWvh+yL8NvcHQkWf22KRecpTvWngCLnnZY3MyOWIl4AotAqhmrNtUv66+b8bn6g
 /myeuLhjV44qALUapHkY/5iMA9l50BJSrfcU7BqD1nj7TOxWS6wW0Vsqe29ARx1p7YGONSx1AZQ
 uYRMluAY/r39tcEasxVdeleTu/phQSNf+H8IG3lmySn0aCB5wlfiZ1POUeHLhL1WAGUd+c8muX6
 v2c4WYoa4uOGU2e0Hk0bgM5O7qFtl2ONQ/EXNykuqTK5MgXJNbZZq8zw9VlwXttrBryQN048dqU
 mu3a2REcVPl9ILq0p2q2GlsM7DFeEIO6hXRgR7OGxedvXI+jEr7OUTITzWoOj6J7jgNdBURAQHN
 IjE83gWjL6wvF7d+7p0pNP/g1Oiimm6SzsTl+4Qh9QVRCMImZ15ZI9L1zI4KFt11IvNcIvp4zgy
 0BoS2NNwYfvJWMA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

This commit removes the QemuConsole from the global "consoles" list when
it is finalized, fixing use-after-free on throw-away objects.

Reproducer: QMP command qom-list-properties with typename
"qemu-text-console", "qemu-fixed-text-console" or
"qemu-graphic-console".

The assertions added ensure that `dcls`, `gl_block`, and the
`dump_queue` are empty before removal, confirming the console is in a
clean state. This is left to handle correctly in a future series for
hot-unplug case.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index 799d61ec1a5..2adffb6f04d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -390,10 +390,13 @@ qemu_console_finalize(Object *obj)
 {
     QemuConsole *c = QEMU_CONSOLE(obj);
 
-    /* TODO: check this code path, and unregister from consoles */
+    /* TODO: fix hot-unplug support of consoles */
+    assert(c->gl_block == 0);
+    assert(qemu_co_queue_empty(&c->dump_queue));
     g_clear_pointer(&c->surface, qemu_free_displaysurface);
     g_clear_pointer(&c->gl_unblock_timer, timer_free);
     g_clear_pointer(&c->ui_timer, timer_free);
+    QTAILQ_REMOVE(&consoles, c, next);
 }
 
 static void

-- 
2.54.0


