Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98D0C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3BK-0002zx-8p; Thu, 22 May 2025 06:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3BI-0002zS-I3
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3BG-0006N6-Q2
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747909781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=biXxzScDBWVmE+hD/uFL07beKKlaR++rnGpBnyLbCto=;
 b=BBOydzOo254S59zhMPyV5xgWJj8r5dc+XdO+9/LfST+lZGxkAr27bWcC2ayDYZxP5aHDwD
 +CORa9UviLwkcgN0TGzDiHGI/38ESeOikE5MBQs2nqAjqB19K5uT6IPXUZbXO+hkVhpx0M
 9a/TE1BORjYX3VGEXEbaB3eNOaGAfLE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-MVlD0FQwNc6uMRLyrL4GWA-1; Thu,
 22 May 2025 06:29:39 -0400
X-MC-Unique: MVlD0FQwNc6uMRLyrL4GWA-1
X-Mimecast-MFC-AGG-ID: MVlD0FQwNc6uMRLyrL4GWA_1747909778
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB34E19560B5; Thu, 22 May 2025 10:29:38 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.179])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D03311958014; Thu, 22 May 2025 10:29:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 03/23] ui/vnc: fix tight palette pixel encoding for 8/16-bpp
 formats
Date: Thu, 22 May 2025 11:29:03 +0100
Message-ID: <20250522102923.309452-4-berrange@redhat.com>
In-Reply-To: <20250522102923.309452-1-berrange@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When sending a tight rectangle with the palette filter, if the client
format was 8/16bpp, the colours on big endian hosts are not set as
we're sending the wrong bytes. We must first cast the 32-bit colour
to a 16/8-bit value, and then send the result.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc-enc-tight.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index a5bdc19ebb..25c7b2c788 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -1001,16 +1001,24 @@ static int send_mono_rect(VncState *vs, int x, int y,
         break;
     }
     case 2:
-        vnc_write(vs, &bg, 2);
-        vnc_write(vs, &fg, 2);
+    {
+        uint16_t bg16 = bg;
+        uint16_t fg16 = fg;
+        vnc_write(vs, &bg16, 2);
+        vnc_write(vs, &fg16, 2);
         tight_encode_mono_rect16(vs->tight->tight.buffer, w, h, bg, fg);
         break;
+    }
     default:
-        vnc_write_u8(vs, bg);
-        vnc_write_u8(vs, fg);
+    {
+        uint8_t bg8 = bg;
+        uint8_t fg8 = fg;
+        vnc_write_u8(vs, bg8);
+        vnc_write_u8(vs, fg8);
         tight_encode_mono_rect8(vs->tight->tight.buffer, w, h, bg, fg);
         break;
     }
+    }
     vs->tight->tight.offset = bytes;
 
     bytes = tight_compress_data(vs, stream, bytes, level, Z_DEFAULT_STRATEGY);
-- 
2.49.0


