Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A7CF9B610
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV1K-00040O-OY; Wed, 22 Apr 2026 06:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV16-0003uL-Ee
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV10-0002AU-Vv
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hqN1Kugycd4KH9Wqc6KEj3jfYJJzyW5nlCl72WtZig=;
 b=ROjedMx3Jb6Lis8OJXBw6zvHBG3BbtJIUK49rpqOt70D3UWXE2CpfrVbrwcszuI7xeO3ci
 DvUp8y4yr4XuG3DYkXepA1oYvarL5fjfxIx2ssjdicMkhT7dSHJ2MtCbuevoVXO9z3GDC/
 mQv85voS5YjD4voA+9bC5eKCeiWgUAM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643--6OBsdM7MSmQECLObJJVMA-1; Wed,
 22 Apr 2026 06:41:01 -0400
X-MC-Unique: -6OBsdM7MSmQECLObJJVMA-1
X-Mimecast-MFC-AGG-ID: -6OBsdM7MSmQECLObJJVMA_1776854460
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 719C4180034D; Wed, 22 Apr 2026 10:41:00 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C72B33000C15; Wed, 22 Apr 2026 10:40:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 02/40] ui/spice-app: detect runtime directory creation failures
Date: Wed, 22 Apr 2026 14:40:03 +0400
Message-ID: <20260422104042.3936506-3-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

spice_app_display_early_init() creates the per-VM runtime directory
with g_mkdir_with_parents() before setting up the Spice socket. The
code checks for "< -1", but g_mkdir_with_parents() returns -1 on
failure, so the error path is never taken.

This lets spice-app continue after a directory creation failure and
defers the problem to later setup steps.

Check for "< 0" instead so the failure is reported immediately and
spice-app exits before using an invalid runtime directory.

Fixes: d8aec9d9f129 ("display: add -display spice-app launching a Spice client")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260408031725.641417-1-zhaoguohan@kylinos.cn>
---
 ui/spice-app.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 9e55f273715..0df7325e679 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -151,7 +151,7 @@ static void spice_app_display_early_init(DisplayOptions *opts)
     if (qemu_name) {
         app_dir = g_build_filename(g_get_user_runtime_dir(),
                                    "qemu", qemu_name, NULL);
-        if (g_mkdir_with_parents(app_dir, S_IRWXU) < -1) {
+        if (g_mkdir_with_parents(app_dir, S_IRWXU) < 0) {
             error_report("Failed to create directory %s: %s",
                          app_dir, strerror(errno));
             exit(1);
-- 
2.53.0


