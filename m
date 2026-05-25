Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6095CD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 06:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wROs5-0001xl-42; Mon, 25 May 2026 02:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wROs3-0001xb-5e
 for qemu-devel@nongnu.org; Mon, 25 May 2026 02:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wROs1-0000zh-6y
 for qemu-devel@nongnu.org; Mon, 25 May 2026 02:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779690780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s98FdMTREin0x+HMEMyCXnMppXkvaTAPzFjNpL5lKUw=;
 b=TaZ1G0VuuS6COUTfyoSMWQs+B11NUDNDqgIB2YC+Q0rAdt6AZeXcx4/mjSPoX+aQZwoogi
 7PMEjbUykPjxVjBKR6djYe7XDqtO5moflCnM+JgzAvBKsGvgyulC1cl71gijt5Htfy/7Pn
 HhEH6zD+8YTSn+sIw6zqyplbAK54OME=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-3Z1LBFkkM_e9LyMHxWqbsg-1; Mon,
 25 May 2026 02:32:55 -0400
X-MC-Unique: 3Z1LBFkkM_e9LyMHxWqbsg-1
X-Mimecast-MFC-AGG-ID: 3Z1LBFkkM_e9LyMHxWqbsg_1779690774
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71DA51800622; Mon, 25 May 2026 06:32:54 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 332CD1681; Mon, 25 May 2026 06:32:52 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v3 03/38] ui/vt100: add vt100_fini() check
Date: Mon, 25 May 2026 10:31:46 +0400
Message-ID: <20260525063223.1409791-4-marcandre.lureau@redhat.com>
In-Reply-To: <20260525063223.1409791-1-marcandre.lureau@redhat.com>
References: <20260525063223.1409791-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

vt100_fini() is called unconditonally from qemu_text_console_finalize(),
but it may not have been vt100_init()/opened: fix the crash in that case.

Fixes: 8fa294482eb ("ui/console-vc: move VT100 state machine ...")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vt100.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/vt100.c b/ui/vt100.c
index f8140cfa85c..6e64845b6c0 100644
--- a/ui/vt100.c
+++ b/ui/vt100.c
@@ -978,6 +978,9 @@ void vt100_init(QemuVT100 *vt,
 
 void vt100_fini(QemuVT100 *vt)
 {
+    if (!QTAILQ_IN_USE(vt, list)) {
+        return;
+    }
     QTAILQ_REMOVE(&vt100s, vt, list);
     fifo8_destroy(&vt->out_fifo);
     g_free(vt->cells);
-- 
2.54.0


