Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D109C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29k-00020j-N5; Fri, 02 Aug 2024 19:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29d-0001en-Gb
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:51 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29c-0004Hm-2m
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:49 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-81fd1e05a5aso92144839f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643067; x=1723247867;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARXUdRtW9JUYDBe/PGc2EUZh9mbaCTufkya2rCFHUZQ=;
 b=Kds3UqA9UUv2PDtcSSJjaNZwFHeZvU7RQFOkgeV1av6J9IMJRly5BT8J6QSZRhw3Yk
 cK16uppq1XU77/sH7tcQB6C3Xslj2ZPlarrULYGi3Mjb/44aHAuOoyvjwP25HwZ9mrQl
 j2kULE0G4HVPJRnoPTPfOouvfFaqmAj3PWSF5SvvzWlbonrpnU0gMjsgamqkiJ4aJZvO
 rQ8go1OeDum0X88toXGiSIzSN0LI9SvY0qUmvKI8ZeC2/7IuNGLRsOKAZlHFGLnxlNn2
 /WWWE1RyhknuhxaRd3cZkQy+mTzFvz+ovzo0srtYqA0X39S8BiV5ReeuPfa2cBjrL/ZG
 vQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643067; x=1723247867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ARXUdRtW9JUYDBe/PGc2EUZh9mbaCTufkya2rCFHUZQ=;
 b=NJOaDsOrfY+VTtMapUh1x0ESkKH6o0yDceYf990KfxqxQnVv9bWvTKvp8SF+u+oDHS
 iyF6Hltz46YjDImZeHL6vWmnUOVcozUzipOXPzd39YoSDQKFdNfqojenIZbDWb5QBFJx
 CpV/UTiAs/AiUB/Y8o0ky5Y6MOVOnUoHEZUzJnNHMwzzBxpjAubcMSzsi2G2sQnslXVn
 uD38iZGaKY2K7bUaRqjg7dvGKREXzQQmMTZLveq3tBqT9FLWX8Nz+eyyflW3xD+dey4y
 l7E9+fuu9Lv5tEt8SPnpggQxicSUE+7ZKt+pyH92esVbqm2XeEgImcVyraiHmjHt94Pb
 onHA==
X-Gm-Message-State: AOJu0YwhKJApy9TUVPGinX8wNIW1ryqNL3O/QR5NCYM7NcUlsEHKF1VS
 4NWKJG6bmGiZKZe42nYiQevWj8gRDchpWq+dzcw97OwtHmthrIbJ3YjBcbzPk4O1cYLPGP93cmW
 1k7E=
X-Google-Smtp-Source: AGHT+IGJ8kBl1jAk/AiBp+gXJapmmr90k+KYMEUr1aXQGBzm5v5FOeHeCD46xd5FHzwZ2op+oj4ZNg==
X-Received: by 2002:a05:6602:1512:b0:7fc:89ed:c15d with SMTP id
 ca18e2360f4ac-81fd43e16a7mr672562239f.13.1722643066686; 
 Fri, 02 Aug 2024 16:57:46 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 07/17] bsd-user: Remove deprecated -p argument
Date: Fri,  2 Aug 2024 17:56:07 -0600
Message-ID: <20240802235617.7971-8-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

FreeBSD never really used the -p argument, so it's safe to remove
entirely.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 9ad31bd1efe..709ab10ddc1 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -388,14 +388,6 @@ int main(int argc, char **argv)
             }
         } else if (!strcmp(r, "L")) {
             interp_prefix = argv[optind++];
-        } else if (!strcmp(r, "p")) {
-            unsigned size, want = qemu_real_host_page_size();
-
-            r = argv[optind++];
-            if (qemu_strtoui(r, NULL, 10, &size) || size != want) {
-                warn_report("Deprecated page size option cannot "
-                            "change host page size (%u)", want);
-            }
         } else if (!strcmp(r, "g")) {
             gdbstub = g_strdup(argv[optind++]);
         } else if (!strcmp(r, "r")) {
-- 
2.45.1


