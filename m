Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8311F9B612
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4T-0002Uu-Vv; Wed, 22 Apr 2026 06:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV41-0000U2-7S
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV3z-0003E4-Tp
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6GrZmfHgJNAbQGynB9WLfXX3dTv6Zs4b4Jza5cDDUo=;
 b=b54MYC7PZLt0R9gpsLodYT6XIb/Ovf/IUIaf4Yfn7c5F1LZ9ZlVSts8Ty2KKsisnXw60UX
 z+v+YOMsjkbkrhfHoBdo6L9CczC5p52NK4crg0Hgt/bTPO4Qw3wzOBeharMUfKkuAvu2UY
 koDFAXS1IQXU8gAywwmdOwaMsaHTu/Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-9m_NRNOcNxieWtZ0UdjVAQ-1; Wed,
 22 Apr 2026 06:44:07 -0400
X-MC-Unique: 9m_NRNOcNxieWtZ0UdjVAQ-1
X-Mimecast-MFC-AGG-ID: 9m_NRNOcNxieWtZ0UdjVAQ_1776854647
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 203771956076; Wed, 22 Apr 2026 10:44:07 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17631180045E; Wed, 22 Apr 2026 10:44:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 32/40] ui/vnc: assert preconditions instead of silently
 returning
Date: Wed, 22 Apr 2026 14:40:33 +0400
Message-ID: <20260422104042.3936506-33-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Replace defensive NULL guards with assert() in vnc_display_close()
and vnc_display_open(). These are internal functions whose callers
guarantee non-NULL arguments, so a NULL value would indicate a
programming error rather than a runtime condition.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 4aa446a48d7..e6860cf4c8b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3467,9 +3467,7 @@ void vnc_display_init(const char *id, Error **errp)
 
 static void vnc_display_close(VncDisplay *vd)
 {
-    if (!vd) {
-        return;
-    }
+    assert(vd);
 
     if (vd->listener) {
         qio_net_listener_disconnect(vd->listener);
@@ -4070,15 +4068,10 @@ void vnc_display_open(const char *id, Error **errp)
     const char *audiodev;
     const char *passwordSecret;
 
-    if (!vd) {
-        error_setg(errp, "VNC display not active");
-        return;
-    }
-    vnc_display_close(vd);
+    assert(vd);
+    assert(opts);
 
-    if (!opts) {
-        return;
-    }
+    vnc_display_close(vd);
 
     reverse = qemu_opt_get_bool(opts, "reverse", false);
     if (vnc_display_get_addresses(opts, reverse, &saddr_list, &wsaddr_list,
-- 
2.53.0


