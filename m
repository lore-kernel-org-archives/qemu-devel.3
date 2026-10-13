Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8F4CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXH-0004nZ-UC; Tue, 13 Oct 2026 09:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVE-0002pz-8r
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVA-0004ni-O3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+mgV+pOyhaSqOdlETzKmECBc0xP9NThN4srLaPVRQp4=;
 b=bO5SvXiyV4XwCuO13BXuU1RWdbHWOspHo/0Cf74mxcAxw+7/nU8gt+W566NhxdTC5ByRn4
 8E4STo3EQb/Lw9A/caoFHRwYf0+LCWRO6NUihnLfIaFwWRfg5q2RyjZ8noDNHVzhCQvu7/
 OPaoANwR8JJG2bpyk1K3BxiHAlK5Ag0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-ox7gmP9xOBaQj3pAepYdQw-1; Tue,
 13 Oct 2026 13:24:58 +0000
X-MC-Unique: ox7gmP9xOBaQj3pAepYdQw-1
X-Mimecast-MFC-AGG-ID: ox7gmP9xOBaQj3pAepYdQw_1791897897
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53E9419539A2; Tue, 13 Oct 2026 13:24:57 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CCCB1800361; Tue, 13 Oct 2026 13:24:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:23 +0400
Subject: [GIT PULL 26/40] audio/pwaudio: handle negative avail in qpw_write
 and qpw_buffer_get_free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-26-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=p0lb8Mwe8uuREq+fFVP6SqVdaJ211mRE+uLP2texcAE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDDW/cOvooJrChhZ0qILMvVQAlTTYPXb4kKQ
 f32ztHUbvWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwwAKCRDa6OEJdZac
 5VZcEACFiuRSSEDxpJblcSMSYMkA6mkOaR8WXXKcAmyriprPHfPaeuyyXnjN0lf2a11hv+vDrJW
 jg3FvtSl58jPpjOghj1pDtmyt34YeOImumA6k7vwe7hLhpQghLAOOFPQbZNKJEvUHJWZe/j4OT0
 Zj1SclZv/vvQdwutbLwa5dK/vhgLACWhYe1THRZPOl0uAEy1M0XjUOei9M8ss+VmN1CG1RkNS3/
 h5yFuPzqAlXC0YyDN7z6MuW5m93X1mNCLV3iC3KCIzKS0W/thVrE+RPqJRMf/edLMmm1O55CcqD
 BLUmKeEIORTLvU1WTKWmAZ/cdackLL11rADyHuEgof4Dpp86asJhumqtDq50AS6TZGSA8Z8EOkk
 mdDZeCiolUMnAX8yn4psurCMWSLVuWGZAVFXtSBqkvjGRuWcqPcVVtWLR5ukq6gJBceucX2AS1Y
 KfxJ2CGzacYRROu7WOiHnqootahci0BCtZsLdb/lqOp8Q2jjz8SLJtODS/JAnrmf+CohWeoYK1t
 WNU4k7G2ah12f550A9Pne5nNqVC+zZxv3kSQfIyu7iT8fxyOkSQ3sivRk7sb9gD5eD51rvIEDZC
 xoK4Pk7fCAlu7Ndqn5rrWZsA2FvBeHjwYnAexDlLntq2hHS42oh1QLoePceRgilgQLmvcaeG2xF
 FTAFkEb4Ht2JphQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

qpw_write() and qpw_buffer_get_free() do not handle negative avail
(highwater_mark - filled), which can occur transiently. In
qpw_buffer_get_free(), clamp to zero. In qpw_write(), bail out early
and fix the signed/unsigned comparison with len.

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: c2d3d1c29415 ("audio/pwaudio.c: Add Pipewire audio backend for QEMU")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-9-ccbef537cbeb@redhat.com>
---
 audio/pwaudio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index a8c18b9ecf85..8b3faae8a907 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -286,6 +286,9 @@ static size_t qpw_buffer_get_free(HWVoiceOut *hw)
 
     filled = spa_ringbuffer_get_write_index(&v->ring, &index);
     avail = v->highwater_mark - filled;
+    if (avail < 0) {
+        avail = 0;
+    }
 
 done_unlock:
     pw_thread_loop_unlock(c->thread_loop);
@@ -312,8 +315,12 @@ qpw_write(HWVoiceOut *hw, void *data, size_t len)
     avail = v->highwater_mark - filled;
 
     trace_pw_write(filled, avail, index, len);
+    if (avail <= 0) {
+        len = 0;
+        goto done_unlock;
+    }
 
-    if (len > avail) {
+    if (len > (size_t)avail) {
         len = avail;
     }
 

-- 
2.56.0.116.g6de20f6092dc


