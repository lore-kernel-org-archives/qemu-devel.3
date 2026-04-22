Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1C9F9B613
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV1P-000437-6z; Wed, 22 Apr 2026 06:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV1F-0003vo-1I
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV1C-0002Dg-Sl
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dy2PsXn2nDdNVszo9dH1wnY4t2PVGu1uQOVeIHrysWA=;
 b=iyawRR4UFo7G7oOfEKmAyaO7FBmievWyfzUcxipthl3AbXFAr/oS76UkrLnsF2kKAKYYM6
 YqaqT1DObysO8EzOB09mVYuFZlMsS6ESkUkj0GBH39cyuHMNuBy+0I8Hz1p3pUhFwVX2dy
 ZVaZWrRfL95PkJMCk6Bag+0ZhNk7mfo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-GrlQwu2oMhmornqxBKHNmA-1; Wed,
 22 Apr 2026 06:41:14 -0400
X-MC-Unique: GrlQwu2oMhmornqxBKHNmA-1
X-Mimecast-MFC-AGG-ID: GrlQwu2oMhmornqxBKHNmA_1776854473
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7371C18004AD; Wed, 22 Apr 2026 10:41:13 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE94719560AB; Wed, 22 Apr 2026 10:41:11 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 04/40] ui/clipboard: clear deferred serial reset flag on resume
Date: Wed, 22 Apr 2026 14:40:05 +0400
Message-ID: <20260422104042.3936506-5-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

cb_reset_serial_on_resume defers a clipboard serial reset until the
machine runs again. qemu_clipboard_change_state() performs that reset
on resume, but leaves the flag set.

As a result, every later transition back to RUNNING triggers another
QEMU_CLIPBOARD_RESET_SERIAL notification even when no reset is pending.
That causes unnecessary reset handling in clipboard backends such as
vdagent and dbus.

Clear the deferred flag before resetting so the reset is performed only
once for each deferred request.

Fixes: c967ff606b99 ("ui/clipboard: delay clipboard update when not running")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260416070403.1683648-1-zhaoguohan@kylinos.cn>
---
 ui/clipboard.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/clipboard.c b/ui/clipboard.c
index ec00a0b8ec7..e3d8a31ba9f 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -47,6 +47,7 @@ static void qemu_clipboard_change_state(void *opaque, bool running, RunState sta
     }
 
     if (cb_reset_serial_on_resume) {
+        cb_reset_serial_on_resume = false;
         qemu_clipboard_reset_serial();
     }
 
-- 
2.53.0


