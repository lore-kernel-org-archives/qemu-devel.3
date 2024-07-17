Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E79C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 17:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU8G9-0001Xq-D0; Wed, 17 Jul 2024 13:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sU8G6-0001W1-1t
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 13:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sU8G4-0003ED-IF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 13:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721236562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OR+6eFi0pWdTNZfRtWQZxDv6aiaz25syJLz3AozDCiE=;
 b=H4Dc8dyPsc2kd0mekKx9FNHL5BakBYRTJcgSd96nGsuDocqszFu2d6KOkggwNp2Z/LB+iM
 vQFb0GegEyingT0a9yfdvS3b3IrIqZc1Bd0BofJ8j7XgYmJmjTjj9VSGAEFMXgagS8IjHh
 LI6patmRebZID5Sb2JXGLsShwYAo11U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-5nTJUWm7P-qIlbr3T-Wlpw-1; Wed,
 17 Jul 2024 13:15:58 -0400
X-MC-Unique: 5nTJUWm7P-qIlbr3T-Wlpw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 793151955D44; Wed, 17 Jul 2024 17:15:57 +0000 (UTC)
Received: from localhost (unknown [10.39.208.20])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 311D51955D47; Wed, 17 Jul 2024 17:15:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/4] ui/vdagent: improve vdagent_fe_open() trace
Date: Wed, 17 Jul 2024 21:15:38 +0400
Message-ID: <20240717171541.201525-3-marcandre.lureau@redhat.com>
In-Reply-To: <20240717171541.201525-1-marcandre.lureau@redhat.com>
References: <20240717171541.201525-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


