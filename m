Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8195EC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 17:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU8GB-0001ed-Pa; Wed, 17 Jul 2024 13:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sU8G7-0001XJ-B9
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 13:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sU8G5-0003EO-9k
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 13:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721236564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkrpErPEsycDE4jj8oa6vQ88btMLDBnOnO5pTIecg7s=;
 b=ER6G+6uWuM5qqC9/X983/DO1B6Su5R93mjhOi0iTxjnhIjDmOnj9cFUCzHNNeva7M/f4fz
 X5B+oAns1xuU7k1VK9oPN2yZKTQxqhFNFDeDqSjDLPTdM557jvNHy/eC2Jet/JGl/90RjY
 nM6ZIp4/N9WcgrCJbJWFbQz1Nyr1jvI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-OJZI4XVtNc-XuylERvBsnw-1; Wed,
 17 Jul 2024 13:16:03 -0400
X-MC-Unique: OJZI4XVtNc-XuylERvBsnw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 156AF1955D55; Wed, 17 Jul 2024 17:16:02 +0000 (UTC)
Received: from localhost (unknown [10.39.208.20])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A94C519560AA; Wed, 17 Jul 2024 17:16:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 3/4] ui/vdagent: notify clipboard peers of serial reset
Date: Wed, 17 Jul 2024 21:15:39 +0400
Message-ID: <20240717171541.201525-4-marcandre.lureau@redhat.com>
In-Reply-To: <20240717171541.201525-1-marcandre.lureau@redhat.com>
References: <20240717171541.201525-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since we reset the serial counters, peers should also be reset to be sync.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/clipboard.c  | 2 ++
 ui/vdagent.c    | 2 ++
 ui/trace-events | 1 +
 3 files changed, 5 insertions(+)

diff --git a/ui/clipboard.c b/ui/clipboard.c
index 4264884a6c..132086eb13 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -155,6 +155,8 @@ void qemu_clipboard_reset_serial(void)
     QemuClipboardNotify notify = { .type = QEMU_CLIPBOARD_RESET_SERIAL };
     int i;
 
+    trace_clipboard_reset_serial();
+
     for (i = 0; i < QEMU_CLIPBOARD_SELECTION__COUNT; i++) {
         QemuClipboardInfo *info = qemu_clipboard_info(i);
         if (info) {
diff --git a/ui/vdagent.c b/ui/vdagent.c
index cb74739bc4..2a4b3574b1 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -720,6 +720,8 @@ static void vdagent_chr_recv_caps(VDAgentChardev *vd, VDAgentMessage *msg)
     memset(vd->last_serial, 0, sizeof(vd->last_serial));
 
     if (have_clipboard(vd) && vd->cbpeer.notifier.notify == NULL) {
+        qemu_clipboard_reset_serial();
+
         vd->cbpeer.name = "vdagent";
         vd->cbpeer.notifier.notify = vdagent_clipboard_notify;
         vd->cbpeer.request = vdagent_clipboard_request;
diff --git a/ui/trace-events b/ui/trace-events
index f5faa149d2..fb253c1666 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -130,6 +130,7 @@ xkeymap_keymap(const char *name) "keymap '%s'"
 
 # clipboard.c
 clipboard_check_serial(int cur, int recv, bool ok) "cur:%d recv:%d %d"
+clipboard_reset_serial(void) ""
 
 # vdagent.c
 vdagent_fe_open(bool fe_open) "fe_open=%d"
-- 
2.45.2.827.g557ae147e6


