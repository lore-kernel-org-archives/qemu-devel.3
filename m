Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D0CEDF15B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vquDr-0003hj-KG; Fri, 13 Feb 2026 09:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vquDj-0003gD-C3
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:32:35 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vquDg-0006be-Us
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:32:35 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d4be94eeacso849141a34.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 06:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770993152; x=1771597952;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7shjz985UmXwl4a6E+GGFbs4C1k6XgV3kTNLugeC3A=;
 b=pqqp9zH/QtSvHyzqgEdSUiDlqfqDlLJwvLdJglW/km7diIz1iBsFbSl6UMNOE6JrLx
 C7tgXFRU8AoUjax/OSLz/iyHX9kq8Cxa3Xql5MEEdCokvyVeVcMoGS/Jih2oSsZ35E7A
 tMKoV0ualnq2amrTSOoUe7VzCbmt3X9oNutXNJUeB6ijyKJq1wS4nWhE14c+uSSAxJM4
 tBd83mcnema3dt7mwv/PQtaBYJcfbLkv5P9wy2Wxtb6KqIYy5GGadgq7Lu4WARCny14k
 c+JUgFSku8xmXQXRejraevBOSwV6JRJMNRTlCAwwtx8BXru19LVo3nxGOTQFcHINxdae
 TiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770993152; x=1771597952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z7shjz985UmXwl4a6E+GGFbs4C1k6XgV3kTNLugeC3A=;
 b=nEJKIuGLjVzi3Ob/9aqABGhU6f8Kjrx2V7iB7pYW83U6fjp9monRrPTj4HImOR/aPG
 dkJjLnJ1vI7AOwF5W6pjlgyjtFoeYnJeomxSXBZoWfqgsSnt0OASqUT1f1eAYkGqrL8h
 k4+yEIxivUcn1/KrylMl92/DTainpCDOAW+6yo1eHiO6jeC/IMZBE44VMgJriivz5XFd
 h39VK5PvGsxF/8WNChAPlDjFNvM0oD1E/NrNX2I1AuIQ9UXL7dKEk2J8elQZRtWEKBYi
 DSYm3h1zx9o8zQl/6L0kzWqp8lTBrfGquFKDuge5MPwl8d4jG7IqMOCqbXM4LP6kx6yF
 7FeQ==
X-Gm-Message-State: AOJu0YwNHodX7uO10+0+n3PXFfvruK1D+r0u3UOTNt47oaXg09OTdaLr
 lEReEYw22X2YcM9By4DW2jWWNWpT4vx2QqU4srg2ERTVhTC3EZvo6Aa83Vn9z/++PRA=
X-Gm-Gg: AZuq6aKn8jmCohYcsVI6TPMOjAll/yXUgNb6kBuLls5CkSo4mUFlW2xg9mRP6Yk4wNc
 loab0FK8tf9PmquHJYueY95jSVvpi8XffL7YpQxm1PERQs+CjYzR+B8K+AYk2KdydhU9SfzebcL
 PQpXVrSKZFrzoJikGRpNFKGi6OqSmjlSSr+3Vj6hbIIckiAAyUIF5WD5BV/og1oeIpLp2lR9Ejh
 Zw6/txwvHZl7+jCyqlZfCS9LhbOl0lJK4CWmj3wQaAjLXyvk0VN2Bx41DibT/5ZSex8bdjI8iN7
 jIwxWWXx/qTwzraDZD6g8dcvfATTlR0cMw2D0iyCr+p9VJICvyPig9QqpUJHU5Z0gfugTRvGkwE
 WdsIy2A3sEWc9QadyzGnow4Ldy74N4+i6VEURWGgq2unhVB+A0TJrUtijUyJ2TeZjtz7ELZ8WZQ
 kJ0Xq4i5l94oNnU6zZwPK4e+Ep5UrDmELCa3zEGYPs4L1LWjF9If+YZenBpq/Tk/p+p5tJ
X-Received: by 2002:a05:6830:67e9:b0:7d1:4d70:736e with SMTP id
 46e09a7af769-7d4c4b67e2amr1048722a34.35.1770993151804; 
 Fri, 13 Feb 2026 06:32:31 -0800 (PST)
Received: from m2max ([198.8.77.157]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a733f033sm6564377a34.0.2026.02.13.06.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 06:32:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] fdmon-io_uring: check CQ ring directly in gsource_check
Date: Fri, 13 Feb 2026 07:26:37 -0700
Message-ID: <20260213143225.161043-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213143225.161043-1-axboe@kernel.dk>
References: <20260213143225.161043-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=axboe@kernel.dk; helo=mail-ot1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

gsource_check() only looks at the ppoll revents for the io_uring fd,
but CQEs can be posted during gsource_prepare()'s io_uring_submit()
call via kernel task_work processing on syscall exit. These completions
are already sitting in the CQ ring but the ring fd may not be signaled
yet, causing gsource_check() to return false.

Add a fallback io_uring_cq_ready() check so completions that arrive
during submission are dispatched immediately rather than waiting for
the next ppoll() cycle.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 util/fdmon-io_uring.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 96392876b490..124e40594c17 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -352,7 +352,19 @@ static void fdmon_io_uring_gsource_prepare(AioContext *ctx)
 static bool fdmon_io_uring_gsource_check(AioContext *ctx)
 {
     gpointer tag = ctx->io_uring_fd_tag;
-    return g_source_query_unix_fd(&ctx->source, tag) & G_IO_IN;
+
+    /* Check ppoll revents (normal path) */
+    if (g_source_query_unix_fd(&ctx->source, tag) & G_IO_IN) {
+        return true;
+    }
+
+    /*
+     * Also check for CQEs that may have been posted during prepare's
+     * io_uring_submit() via task_work on syscall exit.  Without this,
+     * the main loop can miss completions and sleep in ppoll() until the
+     * next timer fires.
+     */
+    return io_uring_cq_ready(&ctx->fdmon_io_uring);
 }
 
 /* Dispatch CQE handlers that are ready */
-- 
2.51.0


