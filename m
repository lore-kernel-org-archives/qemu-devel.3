Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1B8CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ21y-0004X5-TI; Thu, 21 May 2026 07:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ21w-0004ST-4N
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ21u-00040L-LC
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779364653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bnddn3jK2GBEQZ5IObPXYSBjY5rgo/9BZjPxgwCqYvk=;
 b=g7S1DIhmVszJwYSM7shKw42ukEn+JTGEkf3st52sSzwiEzXr+uLQeEG6qM2mhu9v4quz7B
 zuo7Xq+C7a6Fu9ZJWLQkhsT5wE7dkpbcfstnpEPajIddbNJFaMdydp5okM+OMirfdDd0v5
 Vi5HgBTtSrnqwBRjpe9LjbUrIynXFk4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-cSaGH51TPOWiCHAokpxV3Q-1; Thu,
 21 May 2026 07:57:30 -0400
X-MC-Unique: cSaGH51TPOWiCHAokpxV3Q-1
X-Mimecast-MFC-AGG-ID: cSaGH51TPOWiCHAokpxV3Q_1779364649
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0EDD18005BF; Thu, 21 May 2026 11:57:28 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC7F51800357; Thu, 21 May 2026 11:57:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 01/38] ui/vt100: Standardize on uint8_t for "ch" byte variables
Date: Thu, 21 May 2026 15:56:38 +0400
Message-ID: <20260521115717.1701482-2-marcandre.lureau@redhat.com>
In-Reply-To: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
References: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The vt100 code is rather confused about how it handles bytes of data
to be sent to the terminal:
 * vt100_input() takes a buffer of uint8_t
 * each byte is passed to vt100_putchar(), which takes "int ch"
 * that calls vt100_put_one(), which also takes "int ch"
 * vt100_put_one() sets TextCell::ch, which is uint8_t again
 * various places pass the TextCell:ch value to vt100_putcharxy(),
   which takes "int ch" again, but uses it unchecked as an
   index into a 256-entry array

This confuses Coverity (e.g. CID 1659590) and the reader, who may be
unsure whether the "int" variable really does hold only valid byte
values 0..255 and whether we need to bounds-check before doing array
dereferences.

Standardize on keeping known-byte data in uint8_t all the way
through.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260512104210.3330835-2-peter.maydell@linaro.org>
---
 ui/vt100.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/vt100.c b/ui/vt100.c
index e2fba822523..7e373766bc1 100644
--- a/ui/vt100.c
+++ b/ui/vt100.c
@@ -61,7 +61,7 @@ static void image_bitblt(pixman_image_t *image,
                            xs, ys, 0, 0, xd, yd, w, h);
 }
 
-static void vt100_putcharxy(QemuVT100 *vt, int x, int y, int ch,
+static void vt100_putcharxy(QemuVT100 *vt, int x, int y, uint8_t ch,
                             TextAttributes *t_attrib)
 {
     static pixman_image_t *glyphs[256];
@@ -468,7 +468,7 @@ static uint32_t bh_utf8_decode(uint32_t *state, uint32_t *codep, uint32_t byte)
     return *state;
 }
 
-static void vt100_put_one(QemuVT100 *vt, int ch)
+static void vt100_put_one(QemuVT100 *vt, uint8_t ch)
 {
     TextCell *c;
     int y1;
@@ -606,7 +606,7 @@ static void vt100_restore_cursor(QemuVT100 *vt)
     vt->t_attrib = vt->t_attrib_saved;
 }
 
-static void vt100_putchar(QemuVT100 *vt, int ch)
+static void vt100_putchar(QemuVT100 *vt, uint8_t ch)
 {
     int i;
     int x, y;
-- 
2.54.0


