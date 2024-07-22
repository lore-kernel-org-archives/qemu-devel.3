Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A44C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 20:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVzJG-0001xT-QJ; Mon, 22 Jul 2024 16:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sVzJ9-0001r9-9i
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sVzJ6-0002Ap-V5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721678811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEJmUnkeUzN1ax0YK2lz7mjh5s7bmtFKiLd/PhFCb1Q=;
 b=H1rOO+GbZZCAewO63+3fG52XB+gTP8KOtN5HGS4YnkV+olf2cTI53xUzeLgofCI81l0V57
 aKCvzZk8d7fbpeFZ4C/kEXLR16SrM7rYhf3yxEoqFvbj7sT71p2Gj7q8M0ooMq5ZnY3E8B
 FLzg9zAyHHXjvWdzxbvqIudI7rk6QmE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-vit9v5uYOwK2rwIvR_KgGQ-1; Mon,
 22 Jul 2024 16:06:49 -0400
X-MC-Unique: vit9v5uYOwK2rwIvR_KgGQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36A2A19792EB; Mon, 22 Jul 2024 20:06:48 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0B831955F40; Mon, 22 Jul 2024 20:06:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 5/8] ui/vdagent: improve vdagent_fe_open() trace
Date: Tue, 23 Jul 2024 00:06:15 +0400
Message-ID: <20240722200619.135163-6-marcandre.lureau@redhat.com>
In-Reply-To: <20240722200619.135163-1-marcandre.lureau@redhat.com>
References: <20240722200619.135163-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

Place the trace when the function enters, with arg value.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240717171541.201525-3-marcandre.lureau@redhat.com>
---
 ui/vdagent.c    | 3 ++-
 ui/trace-events | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 64d7ab245a..cb74739bc4 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -872,6 +872,8 @@ static void vdagent_chr_set_fe_open(struct Chardev *chr, int fe_open)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(chr);
 
+    trace_vdagent_fe_open(fe_open);
+
     if (!fe_open) {
         trace_vdagent_close();
         vdagent_disconnect(vd);
@@ -881,7 +883,6 @@ static void vdagent_chr_set_fe_open(struct Chardev *chr, int fe_open)
         return;
     }
 
-    trace_vdagent_open();
 }
 
 static void vdagent_chr_parse(QemuOpts *opts, ChardevBackend *backend,
diff --git a/ui/trace-events b/ui/trace-events
index 07eb494246..f5faa149d2 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -132,7 +132,7 @@ xkeymap_keymap(const char *name) "keymap '%s'"
 clipboard_check_serial(int cur, int recv, bool ok) "cur:%d recv:%d %d"
 
 # vdagent.c
-vdagent_open(void) ""
+vdagent_fe_open(bool fe_open) "fe_open=%d"
 vdagent_close(void) ""
 vdagent_disconnect(void) ""
 vdagent_send(const char *name) "msg %s"
-- 
2.45.2.827.g557ae147e6


