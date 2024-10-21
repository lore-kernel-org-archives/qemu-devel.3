Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1ACD15DB8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2v8q-0004Mx-DB; Mon, 21 Oct 2024 12:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2v8i-0004Ix-8n
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2v8f-00047n-Px
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729527613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEL541755epd/Hpxl7BPJ7LvN3p43LICoxxZIR1/Mh4=;
 b=cyCOhiSYJKRX9qDgm3YUJkNkAo8WLVX4zraHenH0m5RpRjmlYZRFbuGEY4S/H5bitPWhFt
 mFjOch1Oahw3WrT3P+IrYlUSNl2edf/celAVw2JE8OLEAgvYYUQY09RkYtLHZpXy4Dxmn3
 ymabd3UXq5AHjquyRj9zodNd+yw/c5Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-BXs0fI08OTKWmom2jWoMJw-1; Mon,
 21 Oct 2024 12:20:11 -0400
X-MC-Unique: BXs0fI08OTKWmom2jWoMJw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 991A61955F54
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 16:20:10 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FF4D1956056; Mon, 21 Oct 2024 16:20:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 5/6] ui: fix handling of NULL SASL server data
Date: Mon, 21 Oct 2024 17:19:56 +0100
Message-ID: <20241021161957.1431919-6-berrange@redhat.com>
In-Reply-To: <20241021161957.1431919-1-berrange@redhat.com>
References: <20241021161957.1431919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The code is supposed to distinguish between SASL server data that
is NULL, vs non-NULL but zero-length. It was incorrectly checking
the 'serveroutlen' variable, rather than 'serverout' though, so
failing to distinguish the cases.

Fortunately we can fix this without breaking compatibility with
clients, as clients already know how to decode the input data
correctly.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc-auth-sasl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 25f6b4b776..a04feeb429 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -289,9 +289,10 @@ static int protocol_client_auth_sasl_step(VncState *vs, uint8_t *data, size_t le
         goto authabort;
     }
 
-    if (serveroutlen) {
+    if (serverout) {
         vnc_write_u32(vs, serveroutlen + 1);
-        vnc_write(vs, serverout, serveroutlen + 1);
+        vnc_write(vs, serverout, serveroutlen);
+        vnc_write_u8(vs, '\0');
     } else {
         vnc_write_u32(vs, 0);
     }
@@ -410,9 +411,10 @@ static int protocol_client_auth_sasl_start(VncState *vs, uint8_t *data, size_t l
         goto authabort;
     }
 
-    if (serveroutlen) {
+    if (serverout) {
         vnc_write_u32(vs, serveroutlen + 1);
-        vnc_write(vs, serverout, serveroutlen + 1);
+        vnc_write(vs, serverout, serveroutlen);
+        vnc_write_u8(vs, '\0');
     } else {
         vnc_write_u32(vs, 0);
     }
-- 
2.46.0


