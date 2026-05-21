Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592A7CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ25V-0002Rf-1c; Thu, 21 May 2026 08:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ25I-000147-AO
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ259-0005Kh-Lj
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779364855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdZWigP5uZAwHMBLPXk0fe2c8i/1vmI9qWN6XT/+9pE=;
 b=GZPmAaNB3y6uNWkMUeJCVAVEOUuC1ft3TW9W2GJi6KcA7trEStxJWpc6jgZruzcSTt9Ywh
 CbpYHFF8feasfU0FVYxQmFco06wBoS9t7jzHbWwfgTJk76Ek/cWBf1zAJzxXF+v34KA5Ho
 9l5YwuSpyEUAHLss6EzoUQuRAWJZrAo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-moHQMt-0PgGDHdyWZtNuAQ-1; Thu,
 21 May 2026 08:00:51 -0400
X-MC-Unique: moHQMt-0PgGDHdyWZtNuAQ-1
X-Mimecast-MFC-AGG-ID: moHQMt-0PgGDHdyWZtNuAQ_1779364850
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64C7F1956061; Thu, 21 May 2026 12:00:50 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 151AB19560A3; Thu, 21 May 2026 12:00:48 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 36/38] ui/console: Remove qemu_text_console_put_qcode()
Date: Thu, 21 May 2026 15:57:13 +0400
Message-ID: <20260521115717.1701482-37-marcandre.lureau@redhat.com>
In-Reply-To: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
References: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

It is no longer used.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-28-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/console.h | 1 -
 ui/console.c         | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 691040f5948..a31c5a4995c 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -108,7 +108,6 @@ bool qemu_mouse_set(int index, Error **errp);
 #define QEMU_KEY_CTRL_PAGEDOWN   0xe407
 
 void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym);
-bool qemu_text_console_put_qcode(QemuTextConsole *s, int qcode, bool ctrl);
 bool qemu_text_console_put_linux(QemuTextConsole *s, unsigned int lnx,
                                  bool ctrl);
 void qemu_text_console_put_string(QemuTextConsole *s, const char *str, int len);
diff --git a/ui/console.c b/ui/console.c
index 2dcb4660fbf..a7c977d0c44 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -328,12 +328,6 @@ static const int ctrl_linux_to_keysym[] = {
     [KEY_PAGEDOWN]   = QEMU_KEY_CTRL_PAGEDOWN,
 };
 
-bool qemu_text_console_put_qcode(QemuTextConsole *s, int qcode, bool ctrl)
-{
-    unsigned int lnx = qemu_input_map_qcode_to_linux[qcode];
-    return qemu_text_console_put_linux(s, lnx, ctrl);
-}
-
 bool qemu_text_console_put_linux(QemuTextConsole *s, unsigned int lnx,
                                  bool ctrl)
 {
-- 
2.54.0


