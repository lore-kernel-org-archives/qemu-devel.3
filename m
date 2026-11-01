Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D25F606A32F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JNhJm4Eq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNUKy-0007ua-Tb; Sun, 01 Nov 2026 07:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUKv-0007tY-R4
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:06:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUKu-0003YK-0v
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793534815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dHErglxKssozuQ3/XejqYtaNScnagugB+h97+vObpks=;
 b=JNhJm4Eqsq6quiV68vPl7XljeD1RmwSwJ3TOl1UdNpsQFAYNBRdsS0/4warBV28aEuWjOK
 0+hoBYU9BV/ZQ8BEqJTvswdQbuK9b7gesASNrGLCQ5GzBMeSxx7dRbZwQcR3hjEAARpucl
 oY8z1JFAwcZc71L7OVbgA9u1RWOAJ98=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-sg1G0s16PYy2Ci6f6TcyNA-1; Sun,
 01 Nov 2026 07:06:54 -0500
X-MC-Unique: sg1G0s16PYy2Ci6f6TcyNA-1
X-Mimecast-MFC-AGG-ID: sg1G0s16PYy2Ci6f6TcyNA_1793534813
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42F931800147; Sun,  1 Nov 2026 12:06:53 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4495C195608B; Sun,  1 Nov 2026 12:06:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 01 Nov 2026 16:06:36 +0400
Subject: [GIT PULL 3/9] ui/vnc-clipboard: factor out clipboard peer
 registration
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261101-ui-v1-3-8af305cef69a@redhat.com>
References: <20261101-ui-v1-0-8af305cef69a@redhat.com>
In-Reply-To: <20261101-ui-v1-0-8af305cef69a@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DLc1GntOk7kCpPPUtzLgYbRQUvB5XMF2wxLdKubT4aA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5ytOV9mOqCTvK8juc3R9XQu6G9WNbxgEZL/JS
 dd5UHwLhYmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaucrTgAKCRDa6OEJdZac
 5SzQD/0XXOC2V1fvLmOp2R0PTSsnlRSwCu4F4TaqBqVvtof10W0dw98toMJPU2uv98eLpij8ERK
 mGk773/BSuDXtvQl3Ghq8pCwvEtUlWsxQgMkumdJ4SxUj8eQfYbS1VXnkYpbrDBU/Z+Iyviz9EC
 qVXZyz8pFj1BsXPsXxyVUWspfA7Jtx4oWipWGoTQPhyYGXBY1DU3J6UJbNS0oJb/zprKB0VaDzv
 +HNPXfoEVWPpWazD1VA0g5pc7tRp+xeMvF6gAkSICHnEYR4MTUdPo16W1Oc+fd/6A9Mp7TYRQOK
 bXLrNavS/qwbfJGhBTqkQ57zuizx2p3z3Ja1fGo000lYNmRFUCJjkpKq4jBJSBKOXho2IyRhNcl
 Mwktiplw8u901lBoNJVje4hWkcSUsjJiTa2ygaQz1RbUAIVxt2TbZyQsJRqKQXPiwLSDCf8clnF
 1Ni6pdZVghidcZiAeOn+HZyMaWBCXIYifj3O34/id391KciN3AxlPaWNYJf+jxTN/gXTu+IbNDR
 O2o6fMKr4o+So1ZqxDZhgC0IDkbh5aUGrVFqyu+uss7N+ych972FPYdOjrNDlX9vFAodOUzoW7y
 EIDR9VAE0zJMokhFYkVTgXavgkyRoEjDJN5XaJ3UX197bah9Mabp61Dr4h4up++0Od4LbmJoH8o
 PIvIl8WqfJrUVYw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lukasz Kornicki <lucas.kornicki@nutanix.com>

VNC clipboard peer is registered inline from vnc_server_cut_text_caps.

Move the registration logic into a function so a subsequent change can
register the peer independently of extended clipboard capability.

No functional change.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261030141442.264308-4-lucas.kornicki@nutanix.com>
---
 ui/vnc-clipboard.c | 17 +++++++++++------
 ui/vnc.h           |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index dfe830f8199b..67f710f6ed80 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -325,6 +325,16 @@ void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text)
     qemu_clipboard_info_unref(info);
 }
 
+void vnc_clipboard_peer_register(VncState *vs)
+{
+    if (!vs->cbpeer.notifier.notify) {
+        vs->cbpeer.name = "vnc";
+        vs->cbpeer.notifier.notify = vnc_clipboard_notify;
+        vs->cbpeer.request = vnc_clipboard_request;
+        qemu_clipboard_peer_register(&vs->cbpeer);
+    }
+}
+
 void vnc_server_cut_text_caps(VncState *vs)
 {
     uint32_t caps[2];
@@ -341,10 +351,5 @@ void vnc_server_cut_text_caps(VncState *vs)
     caps[1] = 0;
     vnc_clipboard_send(vs, 2, caps);
 
-    if (!vs->cbpeer.notifier.notify) {
-        vs->cbpeer.name = "vnc";
-        vs->cbpeer.notifier.notify = vnc_clipboard_notify;
-        vs->cbpeer.request = vnc_clipboard_request;
-        qemu_clipboard_peer_register(&vs->cbpeer);
-    }
+    vnc_clipboard_peer_register(vs);
 }
diff --git a/ui/vnc.h b/ui/vnc.h
index 88293ef49717..d8b0070396dc 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -636,6 +636,7 @@ int vnc_zywrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
 void vnc_zrle_clear(VncWorker *worker);
 
 /* vnc-clipboard.c */
+void vnc_clipboard_peer_register(VncState *vs);
 void vnc_server_cut_text_caps(VncState *vs);
 void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
 void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t *data);

-- 
2.56.0.116.g6de20f6092dc


