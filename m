Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E162C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFA9L-00060J-Pf; Wed, 14 May 2025 07:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFA9K-0005zv-BF
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFA9I-0001MK-IM
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747221583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4J5CtSMgf/lbTPFeTGrU8Ks+Fea1QIrBlMcjYXKmsKI=;
 b=Cad1W1xvkEBRxEMMk8+Ft+5KtdAQ422SE31wVgGKjlQnyn0ZbumO8lO2s3swB0J70iL3k0
 yd0jSKSFXBTupnpaTsS5yVZdx1AwXWRY4YgBUosP+0lZJnrTyq/FBckZ2YLHZTFDhN6OYD
 Ib7mQ/fv+j9Tk4Xls6MP6JrrjVj6xFg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-mq43wVQcOEWlToZpyPLPPQ-1; Wed,
 14 May 2025 07:19:40 -0400
X-MC-Unique: mq43wVQcOEWlToZpyPLPPQ-1
X-Mimecast-MFC-AGG-ID: mq43wVQcOEWlToZpyPLPPQ_1747221579
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6D53180048E; Wed, 14 May 2025 11:19:39 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.147])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CF8019560A3; Wed, 14 May 2025 11:19:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] ui/vnc: fix tight palette pixel encoding for 8/16-bpp
 formats
Date: Wed, 14 May 2025 12:19:31 +0100
Message-ID: <20250514111931.1711390-4-berrange@redhat.com>
In-Reply-To: <20250514111931.1711390-1-berrange@redhat.com>
References: <20250514111931.1711390-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
 ui/vnc-enc-tight.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index a5bdc19ebb..705dcbb429 100644
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


