Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C57CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJOo-0005Hs-Nt; Sun, 04 Oct 2026 06:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOX-0004gf-Q5
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOW-0002ut-58
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTmarXC+9fXel/UVF5cyWmEguj6SW2Q3ysD3pVzSM7Q=;
 b=EuoO/pI4Dp4F5+sXEWMfMdaKZADDk14cWL4OryJ0piXGpeTucvpCfMtM+N9HQZZqRm2oH8
 r3Gg9FNBS2PLJ6mXXeYhORAYnXCPn97xzfpoYak+BjHlZ2BpKOGnK9umBMZu9jmPejpngU
 7Sv8qTRsaFtrzQRfG8YdxQADyuPbJHA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-y6jNDlacNmaYEVK3Fcq4lw-1; Sun,
 04 Oct 2026 06:24:25 -0400
X-MC-Unique: y6jNDlacNmaYEVK3Fcq4lw-1
X-Mimecast-MFC-AGG-ID: y6jNDlacNmaYEVK3Fcq4lw_1791109464
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E9791955F0D; Sun,  4 Oct 2026 10:24:24 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FBEC19560AB; Sun,  4 Oct 2026 10:24:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:27 +0400
Subject: [PATCH 13/63] ui/clipboard: clean up vm change state handler on
 last peer unregister
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-13-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=991;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5/jWyKtQKAb3BsffhA9o32EGLojMiWDj4mNK+wLT/7w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikizzX9t1xdkF9J4QEIb47DiLrYoywnuCtJ5
 26+sIlLQiaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5ZjiEACtraGafPBq3nHjRd+dPinbpnHi5AIj4RtBqF91ZZG/vk6klkck1iGF1ze4MoQ29wLmVkB
 7m/vl8bGbtYXgTOD3GSn/kUd0kFImmdiO38rpghgLY1gM9auT0giubzGymMGGqJC7r/JIrN2HEp
 B3bmyTYCFqxXiUGr0FjSYbAE69jPtEPCnOLYOdAdMZhVXfcien6+p/BhvhN6Nnm4sYPMwZTsuv4
 VwX+MPaTv6BRMIc6lPCnVT0HztSQ423jUgZxhtQDP2XctIwNF9FbHidQD7sc2mpP58JNiUW6NhV
 MPYo+w/nFttnX+xTTg8KUoPuVW3YSMbpUQvwZ5eTlOUvpJEbYj8FAfGXz5/lg6R10Jo0wkJW1jL
 9jOtPE8uECZa+PaHev5QF21Wcu1mL9eUIuE0Q/J3R4rXfWC070qr573fxqQXUoaaMHbe+UPQv6d
 N/7t4pqP8WwOOp+1czyDnUN68eqIB5w0TCWR7PiHNRMN9NR9hn3lipzD2xRqiGC3G2veHroUuy3
 4Ll4KUjCP7U7jK+8MfJXj9MuQn2Epq2899lnD3H9DTWMxFaIDUxdHfneZkrOBZQU3T4oCGz/PP4
 BCY0dOD+Rxa8M1Sv5oK1a90XsO7JlOUV9DYlChspo2KcEiJzRzZZLSvJWVPvW08m9+sVqaurfNG
 9YBgb1GRWlB4odA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When the last clipboard peer unregisters, the vm change state handler
is left dangling. Remove it to avoid stale callbacks after all peers
are gone.

Fixes: c967ff606b99 ("ui/clipboard: delay clipboard update when not running")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/clipboard.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/clipboard.c b/ui/clipboard.c
index e3d8a31ba9f7..46e602dfef43 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -76,6 +76,10 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
         qemu_clipboard_peer_release(peer, i);
     }
     notifier_remove(&peer->notifier);
+    if (QLIST_EMPTY(&clipboard_notifiers.notifiers)) {
+        g_clear_pointer(&cb_change_state_entry,
+                        qemu_del_vm_change_state_handler);
+    }
 }
 
 bool qemu_clipboard_peer_owns(QemuClipboardPeer *peer,

-- 
2.56.0.rc0.29.g47ce80527c56


