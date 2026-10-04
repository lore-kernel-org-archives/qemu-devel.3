Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0F4CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJOY-0004d7-LF; Sun, 04 Oct 2026 06:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOH-0004WW-17
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOF-0002uD-Gn
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XeL3T7ul9TrjR7bOCBr7mlon2MfBdrcThkP7BfNYA0Y=;
 b=OT//ZJ9B/XaWhM3v19Qm9maXRPuXSTIQHsKqJte+7pRod+y9OzrA+hUEy7A+gfe0dDtRrC
 mRJYtOljv9AdzceqKdH3N+mjMcZh1DFJmlRVxJIZfw7S+AeKKJcf9GXkzKjT3Oj5s+6ScP
 qgZNhdxmFANfqlcTxIA9bssTnMPOjHU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-66MSmTmmO7GuK6IJF_NrcA-1; Sun,
 04 Oct 2026 06:24:15 -0400
X-MC-Unique: 66MSmTmmO7GuK6IJF_NrcA-1
X-Mimecast-MFC-AGG-ID: 66MSmTmmO7GuK6IJF_NrcA_1791109454
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D548195421B; Sun,  4 Oct 2026 10:24:14 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE2D61956041; Sun,  4 Oct 2026 10:24:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:24 +0400
Subject: [PATCH 10/63] audio/pwaudio: bail out on underrun in qpw_write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-10-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=934;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qGO50B2N2d7O2eQ2kB2aRGUrCjM6lYoPprJdVeBpeXo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikhQh6INlbp0pCSjAO3vMFPf+wGM9932tS3J
 KZEs42ca9qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIQAKCRDa6OEJdZac
 5bKIEACIEBGDd0CgVVtEXiSSYnNkI5+efOZhmNaVFzJeRmml/LrgA9aDPwKXlG7tI1X6oS/7/+W
 v2R1kr1h8EeR/08U5VK9MukogNTeHhK8vw1/eP0rzONOZ2s+BKXaRZzHbgYIFlqrwIlzFBhspCX
 WNZP1CTLr35e8xmJ8SCSUrnFl9fOkFRDX4IVHDh8x6StbY36EqVDpqfUOqzu/BEhxwxyYvXzcgH
 g0p0TKkakFwkSh4+4sQD56oZqh4kG632fgB6bltPw8C9VRtZbmzv1hUd7ZRoEugsWCKXmi+thO0
 lLVphoRy5uxWHsnwJ6Jg8gSrjAVD2vD+2TWGN1vsu/Qb8vQs0rQFbJcFGTZDjNsJb/MExqZ4PDX
 6Qd8EBWIX06QHrmXRPxpdZ/mcBFsu90YpKs8oP2QEYZ9wA2meNgAFogRTtIAXt5KIPaFwPbhUP4
 r2TGLf8Lw0WcyFF9LDxEbtdbYQt1+uuVy8hTCRRY1cjIoUgD/1SPyGQpZGBvH9/aTPyucdKLhXT
 KujzouLlU6Y9IxYXJhgxKXk544wJybaB4vwZsj87g05DTq7J2tSepHBunaaa1JzkeFwk6waKCDI
 5s2gGQm1KTrT41UWNuXRjrqIDaYuVfCj8EZjlBTKqA6KbrKfH33kIzjBj1faobkqs0ebmPX9Nfi
 h/ZuDmuoTfbJiIg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When filled is negative (underrun), qpw_write() logs an error but
falls through to spa_ringbuffer_write_data(). Bail out instead.

Reported-by: Pavee Hui <phui@google.com>
Fixes: c2d3d1c29415 ("audio/pwaudio.c: Add Pipewire audio backend for QEMU")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/pwaudio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 8b3faae8a907..18b371dc4f93 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -326,6 +326,8 @@ qpw_write(HWVoiceOut *hw, void *data, size_t len)
 
     if (filled < 0) {
         error_report("%p: underrun write:%u filled:%d", pw, index, filled);
+        len = 0;
+        goto done_unlock;
     } else {
         if ((uint32_t) filled + len > RINGBUFFER_SIZE) {
             error_report("%p: overrun write:%u filled:%d + size:%zu > max:%u",

-- 
2.56.0.rc0.29.g47ce80527c56


