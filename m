Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0FFCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcU8-0001TZ-ST; Tue, 13 Oct 2026 09:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcU7-0001Qk-QV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcU6-0004ge-7c
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJQQwmTIWB8sRtQCuMoDjpQG9+C7Y1Xsxd88WYAlS3s=;
 b=gvTHW3ehGrViuD4nwcz8a4Ri/+Xp1x5TqSuvoOz7Hi/X21lfXlrKqnyoGYwxIKSAecsH6w
 SB9OA4jC07PB3IPiaj3G7tBz7aZ6fiwfxOXSI8NR4gYsEEHW1x7bngmY7q3ZhLN8tDTXrj
 un6Z9TtqaNV885uBoMRXGWZjo9wCve8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-f9zOYXGmPzORTmeSETEUjA-1; Tue,
 13 Oct 2026 13:24:00 +0000
X-MC-Unique: f9zOYXGmPzORTmeSETEUjA-1
X-Mimecast-MFC-AGG-ID: f9zOYXGmPzORTmeSETEUjA_1791897839
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B1C4193448C; Tue, 13 Oct 2026 13:23:55 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8883B30041AA; Tue, 13 Oct 2026 13:23:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:06 +0400
Subject: [GIT PULL 09/40] ui/console-vc: forward text console size to vc
 chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-9-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=K3G9iNlF5Hog9bASwEh/dRdQwdFpvW4h0AltCUPSZGI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDCHfkUgOU2r8bFMtkmGQPJhYyRMBogWx1P7
 YZEpVSaaNmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5XwuD/9SB2wr5vZAUql+uz9A9AIMsLlWK/a/wo9yXfvW+1qXLZk+4TFXlUIGNqloh4GLv+TRkIN
 JQY+Z3nvkxNiBZsQSTr6TEzqpUc7qpBTIrPoY5afw/H6Y5WjR7kvrQpF0rIncOcSb1vPDlkLHzz
 yCsiNLkz9gz148z77FFkkpj4iJ80Sl9Yi58gnqnxDDHtobVczejWd2rRC168wjPXLjyva5Zdcnp
 GOBcw6UdL8rjaLQ8GujScu1e5EvsgwQAjzv58SLC6Lm042vgDM1pPZdY1w+9+UMAokhl7VF96hL
 25E320NtsTsD099g9PeZ7d5+V7UtFI7cqoWy9YZ1RLnlMnM5bI99UNaodT+OdhkUfJnP5B8fMTi
 7yozXUWVSwVkgarc1LJUSaGp9iByerBNEAdXVB2kaNymRvkLpg1x6seBysYKrnzn00YeDcGF/mW
 BUAjIefxQw8MnrJE9hoOYYtocvI/ZZSd4sFLvxoDWqhME1bsn/ThBX8z5fhs5fNOWyTaEahY0vR
 ZpEEd2qqp3zPJ7pcsbgrmYqEJg65py+qV12tCq6QiEZ1qlRRhZwIZr+ROwkvuPImVthoTMP4AT+
 TagUmGnZOxBjr5c1/WKitnMDJUERcHOYPDVjPjVRLYxzFTxTYUN0iin+liT3toNWAUzACkRPYnD
 PZPKvRLd/9cAMrg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Filip Hejsek <filip.hejsek@gmail.com>

Update the vc chardev size when initializing the console and after
changing the surface image.

NOTE: There seems to be a bug in the code where the dpy_text_resize
      callback is not called when the size changes due to changing the
      surface image. (Though it doesn't cause any problem in practice
      because the callback is only used by ui/ncurses for fixed
      consoles, whose size never changes.)

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261012-console-resize-v10-8-2c3b10d829b3@gmail.com>
---
 ui/console-vc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 53d9e9d39b36..99cc8f09c887 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -115,12 +115,19 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return vt100_input(&s->vt, buf, len);
 }
 
+static void text_console_chr_resize(QemuTextConsole *s)
+{
+    qemu_chr_resize(s->chr, s->vt.width, s->vt.height);
+}
+
 static void text_console_invalidate(void *opaque)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
 
     if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
         vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
+        text_console_chr_resize(s);
+        /* XXX Shouldn't qemu_text_console_update_size() also be called here? */
     }
     vt100_refresh(&s->vt);
 }
@@ -254,6 +261,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         s->vt.t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     }
 
+    text_console_chr_resize(s);
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     qemu_console_notify(QEMU_CONSOLE_ADDED, QEMU_CONSOLE(s));
     return true;

-- 
2.56.0.116.g6de20f6092dc


