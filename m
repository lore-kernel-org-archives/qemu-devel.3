Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34662EE36A0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqpoq-0007SA-AG; Fri, 13 Feb 2026 04:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vqpoj-00078y-D8
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:50:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vqpoh-0007Lp-Gw
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770976224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4feRG+PIqLPyCpVStJ7uIxka6xWW9klU080X9xA3hKo=;
 b=ZtYvv9lRqrfvms3O2pnTmSTd3GaLHIMimzX4B+mycX+G/DG48o95urPreWUOxEJ3SodZrz
 CnCYZdz1C+aKFjj1KXSFE4FdczXVaWwQ2qGSUNnJDAPGoI/w6GvJC3FVn6GxDGWAXaXL+4
 UnLEVdwuLBWRVrG+dExu52ittsePetQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-v2J-xh5zMnCpIbMpJcyfKg-1; Fri,
 13 Feb 2026 04:50:21 -0500
X-MC-Unique: v2J-xh5zMnCpIbMpJcyfKg-1
X-Mimecast-MFC-AGG-ID: v2J-xh5zMnCpIbMpJcyfKg_1770976218
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 757F1180057E; Fri, 13 Feb 2026 09:50:18 +0000 (UTC)
Received: from localhost (unknown [10.44.22.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E00863000225; Fri, 13 Feb 2026 09:50:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paul Durrant <paul@xen.org>, Anthony PERARD <anthony@xenproject.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL v2 11/15] chardev/char: qemu_char_open(): add return value
Date: Fri, 13 Feb 2026 10:49:30 +0100
Message-ID: <20260213094938.4074478-12-marcandre.lureau@redhat.com>
In-Reply-To: <20260213094938.4074478-1-marcandre.lureau@redhat.com>
References: <20260213094938.4074478-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Accordingly with recommendations in include/qapi/error.h accompany
errp by boolean return value and get rid of error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260115144606.233252-11-vsementsov@yandex-team.ru>
---
 chardev/char.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 3373c9b61f8..5d00cac2f31 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -246,7 +246,7 @@ int qemu_chr_add_client(Chardev *s, int fd)
         CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
 }
 
-static void qemu_char_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool qemu_char_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(chr);
     /* Any ChardevCommon member would work */
@@ -262,13 +262,15 @@ static void qemu_char_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         }
         chr->logfd = qemu_create(common->logfile, flags, 0666, errp);
         if (chr->logfd < 0) {
-            return;
+            return false;
         }
     }
 
-    if (cc->chr_open) {
-        cc->chr_open(chr, backend, errp);
+    if (!cc->chr_open) {
+        return true;
     }
+
+    return cc->chr_open(chr, backend, errp);
 }
 
 static void char_init(Object *obj)
@@ -1006,7 +1008,6 @@ static Chardev *chardev_new(const char *id, const char *typename,
 {
     Object *obj;
     Chardev *chr = NULL;
-    Error *local_err = NULL;
 
     assert(g_str_has_prefix(typename, "chardev-"));
     assert(id);
@@ -1017,9 +1018,7 @@ static Chardev *chardev_new(const char *id, const char *typename,
     chr->label = g_strdup(id);
     chr->gcontext = gcontext;
 
-    qemu_char_open(chr, backend, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qemu_char_open(chr, backend, errp)) {
         object_unref(obj);
         return NULL;
     }
-- 
2.52.0


