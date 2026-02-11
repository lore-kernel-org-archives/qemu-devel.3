Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CB3E9E2FC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 12:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq9MT-0007H6-6s; Wed, 11 Feb 2026 07:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq9MR-0007Gv-8c
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:30:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq9MP-0000BL-5f
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770813023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGj9xk/Pm83KB03G6LVj5ElLZzoxkSGN+CQtNgApbDQ=;
 b=NTzxXaF/dqhF7rO7lTRBGTdc9cQth5htbc9b25uTkkiVJhpeTL2nTW2KZzjv1IIThXuK25
 Djcmaosh72zv+ctf47a+xu8CDYy2OGhB9eid5ybLygVDPWN+CyBLDho531zQVSludb7s+Z
 78UxVU6uBZ/rGb8/iuq4aFHezlSYjy4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-AMhWbVJWNvKZZaJjRa3M1w-1; Wed,
 11 Feb 2026 07:30:20 -0500
X-MC-Unique: AMhWbVJWNvKZZaJjRa3M1w-1
X-Mimecast-MFC-AGG-ID: AMhWbVJWNvKZZaJjRa3M1w_1770813018
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54D9918003FC; Wed, 11 Feb 2026 12:30:18 +0000 (UTC)
Received: from localhost (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0C611956056; Wed, 11 Feb 2026 12:30:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, Eric Blake <eblake@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Eric K <erickra@cs.utexas.edu>
Subject: [PULL 01/14] char-udp: Fix initial backend open status
Date: Wed, 11 Feb 2026 16:29:48 +0400
Message-ID: <20260211123007.3569932-2-marcandre.lureau@redhat.com>
In-Reply-To: <20260211123007.3569932-1-marcandre.lureau@redhat.com>
References: <20260211123007.3569932-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric K <erickra@cs.utexas.edu>

This patch removes the `*be_opened = false` override for the UDP chardev
backend. Since UDP is connectionless it never sends a `CHR_EVENT_OPENED`
so it is never marked open. This causes some frontends (e.g. virtio-serial)
to never perform any operations on the socket.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2993
Signed-off-by: Eric K <erickra@cs.utexas.edu>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20251208225849.705554-1-erickra@cs.utexas.edu>
---
 chardev/char-udp.c     | 2 --
 tests/unit/test-char.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 572fab0ad13..1025f577a0d 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -215,8 +215,6 @@ static void qmp_chardev_open_udp(Chardev *chr,
     g_free(name);
 
     s->ioc = QIO_CHANNEL(sioc);
-    /* be isn't opened until we get a connection */
-    *be_opened = false;
 }
 
 static void char_udp_class_init(ObjectClass *oc, const void *data)
diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index 8a98e42cad0..2869c4e09df 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -1012,6 +1012,8 @@ static void char_udp_test_internal(Chardev *reuse_chr, int sock)
         qemu_chr_fe_init(fe, chr, &error_abort);
     }
 
+    g_assert(chr->be_open);
+
     d.chr = chr;
     qemu_chr_fe_set_handlers(fe, socket_can_read_hello, socket_read_hello,
                              NULL, NULL, &d, NULL, true);
-- 
2.52.0


