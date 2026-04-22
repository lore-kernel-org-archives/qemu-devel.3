Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051D2F9B613
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4a-0003r2-IT; Wed, 22 Apr 2026 06:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV4T-0002UY-Ry
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV4S-0003NF-9W
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHSjDK/qYVKRrdf6jpWfmFnfqyoQkZfwRDatZTDmmFs=;
 b=fQiDEnToG0O9ivOi117/clEf7qKbev8gkfGlpkLDWf4NpGAcLbNxIoEERZ3aCnzb7Sw1EG
 v9G4ZyU3ekXtGqipAfPYs6C9GnynmoFvLZI2koVHg+nQjqQSjJZy4bG/bcVOXqJwekaC+B
 aNj6tkSgnn00iRBrOgStpnAXffPRTLs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-p5QUDusyMpmk6eEg7vUsuQ-1; Wed,
 22 Apr 2026 06:44:38 -0400
X-MC-Unique: p5QUDusyMpmk6eEg7vUsuQ-1
X-Mimecast-MFC-AGG-ID: p5QUDusyMpmk6eEg7vUsuQ_1776854677
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 729EF19540DC; Wed, 22 Apr 2026 10:44:37 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67D8519560AB; Wed, 22 Apr 2026 10:44:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 37/40] ui/vnc: make vnc_disconnect_finish() private
Date: Wed, 22 Apr 2026 14:40:38 +0400
Message-ID: <20260422104042.3936506-38-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.h | 1 -
 ui/vnc.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index c5d678ac31e..110c2bd4600 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -570,7 +570,6 @@ void vnc_write_u16(VncState *vs, uint16_t value);
 void vnc_write_u8(VncState *vs, uint8_t value);
 void vnc_flush(VncState *vs);
 void vnc_read_when(VncState *vs, VncReadEvent *func, size_t expecting);
-void vnc_disconnect_finish(VncState *vs);
 void vnc_start_protocol(VncState *vs);
 
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 37ebd1a534a..947ebd89471 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -70,6 +70,7 @@ static QTAILQ_HEAD(, VncDisplay) vnc_displays =
 
 static int vnc_cursor_define(VncState *vs);
 static void vnc_update_throttle_offset(VncState *vs);
+static void vnc_disconnect_finish(VncState *vs);
 
 static void vnc_set_share_mode(VncState *vs, VncShareMode mode)
 {
@@ -1306,7 +1307,7 @@ static void vnc_disconnect_start(VncState *vs)
     vs->disconnecting = TRUE;
 }
 
-void vnc_disconnect_finish(VncState *vs)
+static void vnc_disconnect_finish(VncState *vs)
 {
     VncConnection *vc = container_of(vs, VncConnection, vs);
 
-- 
2.53.0


