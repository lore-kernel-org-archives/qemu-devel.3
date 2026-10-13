Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14BECC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXZ-0007GS-MH; Tue, 13 Oct 2026 09:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUy-0002f8-Eu
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUx-0004m8-3B
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/L7FMINUUD+MvoHTH2qzOvnhfWzL7iqEgWyNchMUj4=;
 b=HNGydb6HvZqPv3br5zXtMjRTSEipVlDVGjjfS39kgGL6tt+GuJhg/fd5CiAzNRzD6NmmxQ
 HmHgBzpZyYmm3/PrkIiqIiQz5kyegT3zFb9DorGPDelJCqejcixrR/2ZqKpzF+z8qU8JxZ
 QObxDrIL9nk9Kj4Fo8T+yAKMYAF+NZY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-8mFyx2BfMKGkDPWK9jf3xQ-1; Tue,
 13 Oct 2026 13:24:51 +0000
X-MC-Unique: 8mFyx2BfMKGkDPWK9jf3xQ-1
X-Mimecast-MFC-AGG-ID: 8mFyx2BfMKGkDPWK9jf3xQ_1791897890
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B8631828ABD; Tue, 13 Oct 2026 13:24:50 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57B4F30001B9; Tue, 13 Oct 2026 13:24:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:21 +0400
Subject: [GIT PULL 24/40] audio/pwaudio: clamp overrun writes to remaining
 ring buffer space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-24-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1688;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ed9XiudiKbKK/pZh3UiQzHDBDu8kpnwGd54a/WsI83A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDD38KqL6Cvn75UP/ive/eBrl4WQXXxlcLYd
 AVCRDPsfHeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwwAKCRDa6OEJdZac
 5WHmEAC0SoE7ZXaAihRaVCZ1sEIHINaBJkVB4xVqSJHJGLiZASh8JJ3h6Z5qkIUpluBPVK1KovJ
 A8QrmaeUI6CLTKQ5HvNyRVox4+8psQBaLLBXGufEf3973AxB3HvQpCrMO6dzBMON8frBoT6/thy
 MQyzyYVbpCvabZ7VFGKib5L8B0gmP9I07ZZugBt/BapW53zfangBPle8BZjpeE+gDD6BBJBYL9r
 oOvv7txCDg1y+MhmMO8wqWg13oIvIy1OmDYuSeE+Sqz/NEKi15F2JGmSzfmAoPaxKPNrcm5Huez
 vop3w3wz5Rh8/8tIzYWxE2tOvmqus9Uc2ZiuKyGvsdeOtyk2SAJupaGu5ROnD2KXYN3DvCee8HJ
 J8b/495dJLNTHPI2rEStKCKjTjJu+qGzGAF+owMC7Q2Du9ERxG7pCvJulPD/8g37wpn5Anjv//H
 J5NIoDK5nCQVhIc649GtnlF29JNd9jSW7dgZCckOgy/+ToRCEJAVD9sDnyWfj/kOvn4oe87wUtY
 iGgVOR+iHoJ3L79xrQ0ZwpwAMrYrHI2mievmYguJmCqht5A4ixCA6Y//abWBqgRkueWZDDtxjCW
 tYjKpYR3HvtrqqVxTDsI80iCrBDuiRNCoFS8yddmgoCdLPlX5C8me4w7BovKecm60nOeyX/Hw/5
 3t2qD6wISr6i83A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On overrun in both capture and playback paths, the code logs an error
but proceeds to write the full unclamped size. This advances the write
index past read_index + RINGBUFFER_SIZE, causing filled to exceed the
buffer capacity on subsequent calls. Once in that state, avail goes
negative and the signed/unsigned comparison fails to clamp further
writes, leaving the ring buffer in a degenerate state.

Clamp to the remaining space so the write index stays within bounds.

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: c2d3d1c29415 ("audio/pwaudio.c: Add Pipewire audio backend for QEMU")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-7-ccbef537cbeb@redhat.com>
---
 audio/pwaudio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index af360e2ec5ed..1105e920f3c2 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -188,6 +188,7 @@ capture_on_process(void *data)
         if ((uint32_t) filled + n_bytes > RINGBUFFER_SIZE) {
             error_report("%p: overrun write:%u filled:%d + size:%u > max:%u",
             p, index, filled, n_bytes, RINGBUFFER_SIZE);
+            n_bytes = RINGBUFFER_SIZE - (uint32_t)filled;
         }
     }
     spa_ringbuffer_write_data(&v->ring,
@@ -318,6 +319,7 @@ qpw_write(HWVoiceOut *hw, void *data, size_t len)
         if ((uint32_t) filled + len > RINGBUFFER_SIZE) {
             error_report("%p: overrun write:%u filled:%d + size:%zu > max:%u",
             pw, index, filled, len, RINGBUFFER_SIZE);
+            len = RINGBUFFER_SIZE - (uint32_t)filled;
         }
     }
 

-- 
2.56.0.116.g6de20f6092dc


