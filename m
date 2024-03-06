Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2905C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 08:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhmQs-000762-Pn; Wed, 06 Mar 2024 03:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rhmQm-00075S-16
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 03:15:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rhmQg-0008Gn-Uf
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 03:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709712909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mFpMS6WR8NVLm8NlkeXo2TxGNnD58mgHm1nye30iap4=;
 b=COHEBsS1SyX3xuMYP65KlFN/7lcF5BmhnKFGzbopiZw62lWAiPEgRFahi81st3t4SflFxV
 YdZPEEzwlcnm+GMfeHWkZkdXHspqsSuoXlOZfEGtjGXsplcTB1990Elix4roYnK4m8UHhg
 zp7gZt6NDhcgaolH6YuUTvpMujP879Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-QMYgzSKWMhuLr_1Q0KX0eA-1; Wed, 06 Mar 2024 03:15:07 -0500
X-MC-Unique: QMYgzSKWMhuLr_1Q0KX0eA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21C91872514;
 Wed,  6 Mar 2024 08:15:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00049112131D;
 Wed,  6 Mar 2024 08:15:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6BB721E6A24; Wed,  6 Mar 2024 09:15:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-trivial@nongnu.org
Subject: [PATCH] char: Slightly better error reporting when chardev is in use
Date: Wed,  6 Mar 2024 09:15:05 +0100
Message-ID: <20240306081505.2258405-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Both

    $ qemu-system-x86_64 -chardev null,id=chr0,mux=on -mon chardev=chr0 -mon chardev=chr0 -mon chardev=chr0 -mon chardev=chr0 -mon chardev=chr0

and

    $ qemu-system-x86_64 -chardev null,id=chr0 -mon chardev=chr0 -mon chardev=chr0
fail with

    qemu-system-x86_64: -mon chardev=chr0: Device 'chr0' is in use

Improve to

    qemu-system-x86_64: -mon chardev=chr0: too many uses of multiplexed chardev 'chr0' (maximum is 4)

and

    qemu-system-x86_64: -mon chardev=chr0: chardev 'chr0' is already in use

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 chardev/char-fe.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 20222a4cad..66cee8475a 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -199,13 +199,18 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
             MuxChardev *d = MUX_CHARDEV(s);
 
             if (d->mux_cnt >= MAX_MUX) {
-                goto unavailable;
+                error_setg(errp,
+                           "too many uses of multiplexed chardev '%s'"
+                           " (maximum is " stringify(MAX_MUX) ")",
+                           s->label);
+                return false;
             }
 
             d->backends[d->mux_cnt] = b;
             tag = d->mux_cnt++;
         } else if (s->be) {
-            goto unavailable;
+            error_setg(errp, "chardev '%s' is already in use", s->label);
+            return false;
         } else {
             s->be = b;
         }
@@ -215,10 +220,6 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
     b->tag = tag;
     b->chr = s;
     return true;
-
-unavailable:
-    error_setg(errp, QERR_DEVICE_IN_USE, s->label);
-    return false;
 }
 
 void qemu_chr_fe_deinit(CharBackend *b, bool del)
-- 
2.44.0


