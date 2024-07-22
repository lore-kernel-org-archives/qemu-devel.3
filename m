Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787ADC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 20:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVzJ3-0001aM-DF; Mon, 22 Jul 2024 16:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sVzIz-0001Os-Qu
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sVzIx-00028Y-Hg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721678801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=88/1GPhkmpmJqo+1fBvTPO4xBgJvZaHZw1AJlm/mYPA=;
 b=KC8LVt+d1GGnv0KIN9VQIFB4lXtr+9NjbKJI1LgpFBDwsnOOSMOqH2rMjdd2LcDtyntRsK
 z1SLG4M/33yfYsIm1+YTwg51W9QQ6nDl7pfS0iVZthJg8GxSltWOeiVCDyTYZrHriaWzXO
 80ZqzfRyCFvxsWHSpmZ1Gg8mksM7x/8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-txhalE9gPIq-tgoAfLfVoA-1; Mon,
 22 Jul 2024 16:06:39 -0400
X-MC-Unique: txhalE9gPIq-tgoAfLfVoA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EA0E1955D59; Mon, 22 Jul 2024 20:06:38 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0476A195605A; Mon, 22 Jul 2024 20:06:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 3/8] Cursor: 8 -> 1 bit alpha downsampling improvement
Date: Tue, 23 Jul 2024 00:06:13 +0400
Message-ID: <20240722200619.135163-4-marcandre.lureau@redhat.com>
In-Reply-To: <20240722200619.135163-1-marcandre.lureau@redhat.com>
References: <20240722200619.135163-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

Mouse cursors with 8 bit alpha were downsampled to 1-bit opacity maps by
turning alpha values of 255 into 1 and everything else into 0. This
means that mostly-opaque pixels ended up completely invisible.

This patch changes the behaviour so that only pixels with less than 50%
alpha (0-127) are treated as transparent when converted to 1-bit alpha.

This greatly improves the subjective appearance of anti-aliased mouse
cursors, such as those used by macOS, when using a front-end UI without
support for alpha-blended cursors, such as some VNC clients.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20240624101040.82726-1-phil@philjordan.eu>
---
 ui/cursor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/cursor.c b/ui/cursor.c
index 29717b3ecb..dd3853320d 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -232,7 +232,7 @@ void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *mask)
     for (y = 0; y < c->height; y++) {
         bit = 0x80;
         for (x = 0; x < c->width; x++, data++) {
-            if ((*data & 0xff000000) != 0xff000000) {
+            if ((*data & 0x80000000) == 0x0) { /* Alpha < 0x80 (128) */
                 if (transparent != 0) {
                     mask[x/8] |= bit;
                 }
-- 
2.45.2.827.g557ae147e6


