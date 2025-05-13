Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A0DC3ABD7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmYt-00011j-5W; Tue, 13 May 2025 06:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEmYs-000110-65
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEmYq-0007wd-LN
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747130911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKKBAe1ac5qIPLruFGrkqf3C7tDHnVvDLfuSN/POzDM=;
 b=IrCqWvux0LKMPLhz3vIec15OkeFn69eIZWz0daqwpBcaCM7lCa2jQNX8prF56ntH7LsSk3
 u+GlRc6PuC5+S8KBgCyFSf5+eHAh3HzXDoIEIyhwFArxvLjghJNcRCh62CUxQSgjA1/eI+
 zAdBL5xBVv0zFVQPQn9+0F0bq/CnWJ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-EW_QkrjdNw2HoI66XISq3Q-1; Tue,
 13 May 2025 06:08:29 -0400
X-MC-Unique: EW_QkrjdNw2HoI66XISq3Q-1
X-Mimecast-MFC-AGG-ID: EW_QkrjdNw2HoI66XISq3Q_1747130909
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0D3D180087E
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:08:28 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F18B19560AB; Tue, 13 May 2025 10:08:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/3] ui/vnc: fix tight palette pixel encoding for 8/16-bpp
 formats
Date: Tue, 13 May 2025 11:08:19 +0100
Message-ID: <20250513100819.1179249-4-berrange@redhat.com>
In-Reply-To: <20250513100819.1179249-1-berrange@redhat.com>
References: <20250513100819.1179249-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

From: Daniel P. Berrangé <berrange@redhat.com>

When sending a tight rectangle with the palette filter, if the client
format was 8/16bpp, the colours on big endian hosts are not set as
we're sending the wrong bytes. We must first cast the 32-bit colour
to a 16/8-bit value, and then send the result.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc-enc-tight.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index c6e8d71d4f..f6d4411e14 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -1001,13 +1001,17 @@ static int send_mono_rect(VncState *vs, int x, int y,
         break;
     }
     case 2:
-        vnc_write(vs, &bg, 2);
-        vnc_write(vs, &fg, 2);
+        uint16_t bg16 = bg;
+        uint16_t fg16 = fg;
+        vnc_write(vs, &bg16, 2);
+        vnc_write(vs, &fg16, 2);
         tight_encode_mono_rect16(vs->tight->tight.buffer, w, h, bg, fg);
         break;
     default:
-        vnc_write_u8(vs, bg);
-        vnc_write_u8(vs, fg);
+        uint8_t bg8 = bg;
+        uint8_t fg8 = fg;
+        vnc_write_u8(vs, bg8);
+        vnc_write_u8(vs, fg8);
         tight_encode_mono_rect8(vs->tight->tight.buffer, w, h, bg, fg);
         break;
     }
-- 
2.49.0


