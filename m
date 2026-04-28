Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640F2FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHibQ-0005W3-He; Tue, 28 Apr 2026 09:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wHd9H-0006ug-J3
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:46:28 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wHd9E-0007Q9-Kj
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:46:27 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2aaed195901so48031225ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 00:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777362380; x=1777967180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Okk7PHtNIH6eCXbqPcBsp6vGhTSqfqbaB8Ruqvlhhrw=;
 b=oiQaEugfHlym6b+GZe3A8ILgK1jjVsrZCrM1ufKJMDjbCmbrp1DOLM8PBC1xxPyuy7
 4+E19sz+WqXwdomkL7pa6Zb6+xC7nkOMeUZoZUw6mI4NDaM3y0F+M74AZY9BpUJLecsH
 Rss6xaeD1m3HP7kmWTdPXu+oiYJRzxUaGLGdKKsr9kkWwj6ZjTWrrrZs8+YHPyoxkfEM
 9FVtLYA5rfQdEShWjwlr5KyomslZzmMqp80DddbdLOSAG25ceccjn03DpnmTqXieIawi
 c8w79IjBHSfTNel5b4oq2NbNwrfi5pX1J9CxF65rz72tzmFf0jV+0/SOg48ZE3hRft0c
 4Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777362380; x=1777967180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Okk7PHtNIH6eCXbqPcBsp6vGhTSqfqbaB8Ruqvlhhrw=;
 b=Lg6r6DKA3Cy78si2oFPHgjW6ipi5fXz4WUTgeuxQIg3G/qEGnZj4GBXnzuJxHTsz+w
 GOT88nSb72YUNbvzABR66Eattx38XEjqwzSkXsxJUa+scG+7N/YD2t4oSUiVsDuGnQHQ
 BbMBWU/aFLfdFwTxqcGHhEm202BeYGyhG2pLwpan785gX6AvCWxxKU7ASxsGgf3c6zQI
 DtzH3a5F/jCc+Q7R01g12uGHVkoXLRjhCEFiB7bYwUXwJQbIkz0FmRnysxOyhhBfxR08
 GYpSIp0nlxqmXGhDJcNJO5IxEIEvOYCGq4EDco+WQo3b8u6Ux34LIkzVhvh2F9vwzgFp
 /BeA==
X-Gm-Message-State: AOJu0Yzg0WOrWAyQHSUPo95N61zGEtRBxCiUbuW9UIm3xV1C8L/Vp3zX
 02Hi2auvjpiqT7BSxJ9Mf65woLaegnOcGUPifRgj7wPooGQ/Gy5gB2lbgh182A==
X-Gm-Gg: AeBDievCeqI8MaX1WUXXuAc4vQ4dcTi2ycPsVkQVyWyNR8PkjAd17CUuIBKGrAPjkpw
 U+gSH2N5BqCky/DW4OSEHKplz7GUdcp+NFyt/hQ+r8CFIFw8m27ER4nzAbG6xvR3+XNtz5sQn9M
 7u9M+tLkvRHt9MuMW09DAv3mCW4RNJCZ2TqN/GsJfDPTqXqvuGZBSf+BxCmyEqfJxlNbqFw0mnp
 WXenphYT21cZQIh2jlN7Hq8z2BnS9eAb3lnagt5ZlWKksVCAmzOiPGBvHtUe6sY2uFcDvpeiUbT
 dhJtGLYdxCQTU2qRd1NuB+WUl6fvohcgjCBLBCn232Gzq+LJHXKBFBmXMFuaTCFLjajOEH8zanZ
 c1uVRZaQnzZNNUFDIlGYFexVMnH+apZNqK3u00ocTA9aak+hAVvIuJwSiaHLPx6M0cdvOHjVvQc
 qovpG8Q9ePHw0eQeRkrhgly8FselmNrdt/iUEufCufmvAPrzPk7UA=
X-Received: by 2002:a17:903:388c:b0:2b4:5dff:310f with SMTP id
 d9443c01a7336-2b97c4b744cmr20689325ad.34.1777362379855; 
 Tue, 28 Apr 2026 00:46:19 -0700 (PDT)
Received: from localhost.localdomain ([114.249.134.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97ac8d439sm15827065ad.66.2026.04.28.00.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:46:19 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 qemu-stable@nongnu.org
Subject: [PATCH] 9pfs: fix deep path truncation in V9fsPath
Date: Tue, 28 Apr 2026 15:46:14 +0800
Message-Id: <20260428074614.3169999-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=physicalmtea@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:35:50 -0400
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

V9fsPath.size tracks the length of backend path data. Storing it in a
uint16_t truncates local backend paths longer than 65535 bytes, so later
path copies can end up much smaller than the string data they are
supposed to describe.

A guest can reach this with normal 9p filesystem operations by creating
and walking a sufficiently deep directory tree on the local backend. On
an ASan build, calling readdir() in that deep directory aborts the host
process with:

  ERROR: AddressSanitizer: heap-buffer-overflow
    #0 __interceptor_strrchr
    #1 g_path_get_dirname
    #2 local_lstat
    #3 v9fs_co_lstat
    #4 v9fs_getattr

Fix this by storing V9fsPath lengths in size_t.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3358
Cc: qemu-stable@nongnu.org
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Runtime reproducer:
  confirmed on current master (11.0.50) with an x86_64 ASan build and a
  local 9p backend

  guest actions:
    - mount the 9p share
    - create a 260-level directory tree with 255-byte names
    - walk back to the deepest directory
    - call readdir()

  host abort:
    ERROR: AddressSanitizer: heap-buffer-overflow
      #0 __interceptor_strrchr
      #1 g_path_get_dirname
      #2 local_lstat
      #3 v9fs_co_lstat
      #4 v9fs_getattr

 fsdev/file-op-9p.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index b85c9934def..e8d0661c4b5 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -112,7 +112,7 @@ struct FsContext {
 };
 
 struct V9fsPath {
-    uint16_t size;
+    size_t size;
     char *data;
 };
 P9ARRAY_DECLARE_TYPE(V9fsPath);
-- 
2.34.1

