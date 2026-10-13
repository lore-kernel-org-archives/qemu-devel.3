Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F93CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXB-0004dy-Dg; Tue, 13 Oct 2026 09:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUt-0002Ub-O0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUs-0004lY-Cv
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OaJeckcQy7DtZdtFStYRqCexe29EDMtzmjgkvmdJQw4=;
 b=UoqeAO6O32lbmagoNaQcab9Fgt9k5lep9eyNOFS1oAFOuBMBZHp+ndykWFNnEllQkvLQdD
 +uw+IudZrGCCRSfPSFYJHlJp666vTaNjTxkkLqwSKAsKSqEgbf1owhHESlBm8yiqWLD11S
 IeMdv5wnOZeGh3hmNRdFl1xA8GNZCFw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-U4xBPL1jPoy3Yv6TlCSZOA-1; Tue,
 13 Oct 2026 13:24:47 +0000
X-MC-Unique: U4xBPL1jPoy3Yv6TlCSZOA-1
X-Mimecast-MFC-AGG-ID: U4xBPL1jPoy3Yv6TlCSZOA_1791897886
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8EDA1954B28; Tue, 13 Oct 2026 13:24:46 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABC061956086; Tue, 13 Oct 2026 13:24:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:20 +0400
Subject: [GIT PULL 23/40] audio/pwaudio: fix capture buffer leak on early
 return paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-23-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GYyhi0tLsRHrNM2MsDEvxAPZ16RBYwfkVfSXbpieoS0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDDWUu5Ygr1iB2h+cie+T5KYmWMNzQ+kGss6
 U1dHoSW456JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwwAKCRDa6OEJdZac
 5eWkD/9xoMWHmH8M+J+PmJI79a1yZZC/JNPg+EH/G/V/i3vHSR9TmgT/w/Pis7fPx/t6NOSIKSB
 27Xp225KQWeqNoKA6bQPS8JZHuQtfHWxpx4pBs9Yz3gPDlgCUzOCakrA5piqE99P62bH0j9lqfD
 Dq1RvaJNA7nCoe1QTjkAedC6NjZB0ElXz10DNB5BmZuSxv1Cu8z+96yL5TM6thUj4eAo42dRh6f
 Lpg6mE5j3BPp5lTbiNPbKVk8nJuIWdUpB4c1rLz+aMq/2Am5Ol8hWIVKvHCyRh1P3w0bzjj2Lfm
 6GRHLQKWYPiTmD57K4PKQFfORKE2iroGzfnfRcMII5nB5PxvY5+bzfiqapwQ0I7BgljBdWETcZd
 tkHsQSqP58QQRE5WwxkaXyOqgHY2Eccxf7MRsDOn35ZuXGfCNXMdK5RubbIGTsmCrJQBgDSU+a4
 dXrx86skjJQOudN/Yn81sDdaYxOrLx2CnMd9OJfIkFo53Is3msfXzqNcoEnmv2nU7iXr6LgVUHv
 ZfmUS3XJXbkSX82cTnn7QfN/FFhWx43onMYrQ5QdPmLFuAH0xUYcHzCb6RtZk8EfPdhNYyZumXB
 y9HTHaNV6kFXcMYcWB1fCJ/2bdMzaSbVRaCIyAQklklaMwBNcUiT3hTBW8WgTi1h8jGN+1msgDX
 HVByJ9lM17Dv3iw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

capture_on_process() leaks the PipeWire buffer on the p == NULL and
underrun early-return paths by not calling pw_stream_queue_buffer().
The stream eventually starves from its buffer pool.

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: c2d3d1c29415 ("audio/pwaudio.c: Add Pipewire audio backend for QEMU")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-6-ccbef537cbeb@redhat.com>
---
 audio/pwaudio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index a59c22e60b87..af360e2ec5ed 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -171,6 +171,7 @@ capture_on_process(void *data)
     buf = b->buffer;
     p = buf->datas[0].data;
     if (p == NULL) {
+        pw_stream_queue_buffer(v->stream, b);
         return;
     }
     offs = SPA_MIN(buf->datas[0].chunk->offset, buf->datas[0].maxsize);
@@ -181,6 +182,8 @@ capture_on_process(void *data)
 
     if (filled < 0) {
         error_report("%p: underrun write:%u filled:%d", p, index, filled);
+        pw_stream_queue_buffer(v->stream, b);
+        return;
     } else {
         if ((uint32_t) filled + n_bytes > RINGBUFFER_SIZE) {
             error_report("%p: overrun write:%u filled:%d + size:%u > max:%u",

-- 
2.56.0.116.g6de20f6092dc


