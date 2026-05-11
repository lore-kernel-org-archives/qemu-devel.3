Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7190ECD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX8j-0002mn-M2; Mon, 11 May 2026 16:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX8b-0002bt-KK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX8Z-0001ye-TM
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFFJI4aLwWMpSc94KSgiihxeO+B+/H72qXcYnGybsnI=;
 b=SPVRRIe2A6HYTUCFwfsJCpv/AoSgwiFSe2uWWJNouSz1LJgQjt3nv62pMW89nyg+uVV3z9
 eZbromI1Bkyowwc+ktD0xDL2AljsSxWc0WrAgnGsuaJLoAGiriwA6BMgEFp+Lp00ToFAfQ
 XdwW+31OAlxD3KyGLAC94eW4veBSD+I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-WIwhcULVMzidcIc6uq_pHA-1; Mon,
 11 May 2026 16:21:54 -0400
X-MC-Unique: WIwhcULVMzidcIc6uq_pHA-1
X-Mimecast-MFC-AGG-ID: WIwhcULVMzidcIc6uq_pHA_1778530914
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04604180034E
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:21:54 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B579330001BE; Mon, 11 May 2026 20:21:52 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 07/24] ui/console: remove console from global list on
 finalization
Date: Tue, 12 May 2026 00:20:53 +0400
Message-ID: <20260511202111.3091440-8-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

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
index 6f6330d61f1..eaa41086743 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -392,10 +392,13 @@ qemu_console_finalize(Object *obj)
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


