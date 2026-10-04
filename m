Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6EFCA5FF1
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJP4-0006Dc-Fj; Sun, 04 Oct 2026 06:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOn-0005Fc-Vn
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOm-0002wR-Gz
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnR10Ds06SZM2Kioe9OM/XSLKjvVyWS3PKHl+2ydQiM=;
 b=A0gD/VLiUPvZV8oiHswMjAMU+T0fRzHfljY/TpztPCJ/GXfB0IRORH4XY705GRiW0r+Gpc
 FOqdXVBV3ai+HELxMbOshHGRru8R2VJ8UKgC3Mc8NFRb2TObnfLSeem8+wV7iz2BUroAHo
 Y8PCxNLX9I2ym3Lw4j1QaPW8/1f3KMM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-Qzgp7DzrOaa5FCxYsFU_gg-1; Sun,
 04 Oct 2026 06:24:50 -0400
X-MC-Unique: Qzgp7DzrOaa5FCxYsFU_gg-1
X-Mimecast-MFC-AGG-ID: Qzgp7DzrOaa5FCxYsFU_gg_1791109489
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F7AC180065F; Sun,  4 Oct 2026 10:24:49 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8AFC1956089; Sun,  4 Oct 2026 10:24:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:34 +0400
Subject: [PATCH 20/63] chardev/char-ringbuf: reject zero size with
 is_power_of_2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-20-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vkmWwWmCuKmh9/g3a/8MCfbHiyayEzMga4SSVAr5BMA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikiZboXlbLWvkPRo63x4PkwVmmydoCprHj9+
 k5bbO458t+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5TvMD/0ZFRkIn17pFoeXDu/P4rjZqgk9PhuozMc6cuJvZtb9CaWRv7+mjgocIP54TBdpQDcvBt8
 TjCAfJLVmNt8o7EvNN7RyNj0K0eTLU4CPe0ydYniCNSHCI0WBjjxjgMX1luwSo8a9S/dxXt1u2B
 VtOSk/AWlsV69j7h4yFbai3bHdsO1TIb4YrIFKYY34Suo3XiOZs2ejO2czSMDGOPRDjOEisx54S
 vQuVb4/Yq+0jWp+pPaJ8gEjmrf0qYmu6gqYk1kSvwFiNs49VeHDacMM6GqsxcCia2C6mySF1B0X
 41ChBaXmLFSbDcJL3oJROBR7WrljXIwXmWbMUZZTDAQQyAzg1b8OQgmXcvDTBLEXb9QPdfd+nxX
 vamTSgdtC0UYMCivvgvXI1tidZR9Vp8tupfrokxxNmYbeclITqREUzUQD7vgf0dl6GsFVgcXJln
 2oGEHIb2wZNxjElGEGmsgVwoXUvQNxrf1tR6SEyRGyTJU6yFPFb8iUbPq7Ee5Ka15xSTmI9bGM0
 Xur5ahP2Y+Hlg18+G6T9U9dxfKHuwiw5su7DZOAnAaVW82PyXB66XnavEyqCRTUKLdukGD/bEfs
 dNDibklpXCgTKWd4s/pZYrC17kTWuW8zj2jmZ1iW66Ka9Un0qBcVDYFggRtTIgiE6+G1iGdviBN
 udESiPSEXxsG6yw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The power-of-two validation did not reject size=0, since
(0 & (0-1)) == 0. With a zero size, the ring buffer mask wraps
to SIZE_MAX, causing out-of-bounds memory access. Use
is_power_of_2() which handles zero correctly.

Reported-by: Pavee Hui <phui@google.com>
Fixes: bf51f62869f4 ("char: move ringbuf/memory to its own file")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-ringbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index 8f998d26a49f..a80519f8d65d 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
 #include "qemu/base64.h"
+#include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qom/object.h"
@@ -102,7 +103,7 @@ static bool ringbuf_chr_open(Chardev *chr,
     d->size = opts->has_size ? opts->size : 65536;
 
     /* The size must be power of 2 */
-    if (d->size & (d->size - 1)) {
+    if (!is_power_of_2(d->size)) {
         error_setg(errp, "size of ringbuf chardev must be power of two");
         return false;
     }

-- 
2.56.0.rc0.29.g47ce80527c56


