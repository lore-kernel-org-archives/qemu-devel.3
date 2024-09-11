Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90378EE4981
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 09:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJQu-0002ho-2s; Wed, 11 Sep 2024 05:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <01020191e05ce6df-84da6386-62c2-4ce8-840e-ad216ac253dd-000000@amazonses.collabora.com>)
 id 1soJQr-0002h3-Bn
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:14:37 -0400
Received: from a7-41.smtp-out.eu-west-1.amazonses.com ([54.240.7.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from
 <01020191e05ce6df-84da6386-62c2-4ce8-840e-ad216ac253dd-000000@amazonses.collabora.com>)
 id 1soJQp-0003d5-IF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726046070;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
 bh=tnDwwg1Sa9WCRfRDgMB4ilCs8xWPlKuNbSApMfrUhWA=;
 b=jrcePwNckn1cBEAmozGe05WydzUVdJXOigOgxZt9JmomMj0zUKQoXhe7GV8IeBLB
 HnXPAamGw+tMq/q8gwMnotbmUswpuBCXOwteM6wCSaoavq/w9Gwx8kcee0WJ5gbJOf9
 3vkcYjO5ocJSs7YDcrNCwJlZhf7v1KIq34LdePAyFhduoTb8M2c8Bc2RELHDRbutDzo
 OvzWMi4xuHYcNveG7K1fC/HffU7Uw/ci/sSMPgIBdC22uu0Q6EyLQRdr0VObThExl8P
 mdg5DBoIFlxgwOlLa8XidlLOpZtAJOFah+tuA//HtGcwerXZ6WGCvDa8fJcfqeTOXFO
 HBz/Tfn2DA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726046070;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=tnDwwg1Sa9WCRfRDgMB4ilCs8xWPlKuNbSApMfrUhWA=;
 b=H4AN0/uAyq8KfMFM13DsSormkKN1vt3EPheYiU3eK12UGvZik4SnFvny+cngL21H
 RVUdfEQuEI8VXqXi74HfK3u+ZmEvk8jzxE6Q9h+ZWRE0U8B/JJz8c9DHBK0rAsFjb1I
 mNnzyLRb80BW1tdYJyDXmB2Jp794fOXHyqSwt9Y4=
From: gert.wollny@collabora.com
To: qemu-devel@nongnu.org
Cc: Gert Wollny <gert.wollny@collabora.com>
Subject: [PATCH] qemu/ui: set swap interval explicitly when OpenGL is enabled
Date: Wed, 11 Sep 2024 09:14:30 +0000
Message-ID: <01020191e05ce6df-84da6386-62c2-4ce8-840e-ad216ac253dd-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.41
Received-SPF: pass client-ip=54.240.7.41;
 envelope-from=01020191e05ce6df-84da6386-62c2-4ce8-840e-ad216ac253dd-000000@amazonses.collabora.com;
 helo=a7-41.smtp-out.eu-west-1.amazonses.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Gert Wollny <gert.wollny@collabora.com>

Before 176e3783f2ab (ui/sdl2: OpenGL window context)
SDL_CreateRenderer was called unconditionally setting
the swap interval to 0. Since SDL_CreateRenderer is now no
longer called when OpenGL is enabled, the swap interval is
no longer set explicitly and vsync handling depends on
the environment settings which may lead to a performance
regression with virgl as reported in
   https://gitlab.com/qemu-project/qemu/-/issues/2565

Restore the old vsync handling by explicitly calling
SDL_GL_SetSwapInterval if OpenGL is enabled.

Fixes: 176e3783f2ab (ui/sdl2: OpenGL window context)
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2565

Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
---
 ui/sdl2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 98ed974371..51299f3645 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -115,6 +115,7 @@ void sdl2_window_create(struct sdl2_console *scon)
         SDL_SetHint(SDL_HINT_RENDER_BATCHING, "1");
 
         scon->winctx = SDL_GL_CreateContext(scon->real_window);
+        SDL_GL_SetSwapInterval(0);
     } else {
         /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
         scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
-- 
2.44.2


