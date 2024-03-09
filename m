Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1243C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 15:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riz5G-0007Mr-FT; Sat, 09 Mar 2024 10:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz55-0007H0-TY; Sat, 09 Mar 2024 10:57:51 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz54-0004HT-6c; Sat, 09 Mar 2024 10:57:51 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D52065452A;
 Sat,  9 Mar 2024 18:58:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 565A9944BF;
 Sat,  9 Mar 2024 18:57:36 +0300 (MSK)
Received: (nullmailer pid 1694659 invoked by uid 1000);
 Sat, 09 Mar 2024 15:57:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 05/11] char: Slightly better error reporting when chardev is in
 use
Date: Sat,  9 Mar 2024 18:57:23 +0300
Message-Id: <20240309155729.1694607-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240309155729.1694607-1-mjt@tls.msk.ru>
References: <20240309155729.1694607-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Markus Armbruster <armbru@redhat.com>

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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.39.2


