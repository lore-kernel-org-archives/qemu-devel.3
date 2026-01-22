Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAB2C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 05:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vingz-0000uT-3B; Thu, 22 Jan 2026 00:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.wang@smartx.com>)
 id 1vilw4-0000J0-Pj
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 23:04:44 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wei.wang@smartx.com>)
 id 1vilw2-0003L6-80
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 23:04:44 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-29f2676bb21so5187265ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 20:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1769054679; x=1769659479;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tovPbYy3IcvNFqI0uQBzYWZzR3BR5HehgRBLgrUCJd8=;
 b=pkRoI1zAE9mF25bwD5x8zHgNQdi0tLlaIpGMy66bRyPkYDMQXxgKrYo1++GB1gBjgT
 GMxz+0bijOdFbA/vF3kVMHnELIqPogyhmdZ5KHL0CdTTvewr68Fp8Prp8PBXFKtFktiM
 GCT3lKC3bkNZcomTCtGhW14wzKb8IuRz0/mGw2mHFtHPGKDiyZQpTri+y+uScdXi7Voh
 yJTvzv+654vwH7sjfZy7A3mZutxta6O3n12+Y7TpkRmGo3lTkGGJZ6xIL95l0LEdxo4+
 r5sSZD/6bwjNiiI0oHUCZXoQMIu9lxFLm0+Q/sJC8sLR0dhpzrOjvXpENPJOE0jQYQuA
 1tPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769054679; x=1769659479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tovPbYy3IcvNFqI0uQBzYWZzR3BR5HehgRBLgrUCJd8=;
 b=Up+VMfQxyCpe95m81vK8knR9kHEhqDdySqh3iZ3H3NbARW1DdL4WlZBp6WZZ9b1Avm
 pxpye+o0O4xhBjugGaZ6Tj9A598J/BqiXnlv2IyCwfY32i9KH+3/liYUbhiHau4pMKHn
 tbNq9ER0Y4AOdRy7G4E06lihA2d/KhA13hqpHFRsaE0Y+lBtTBT31iFEFzSorEKDpKRd
 qmZrmO7l/K2Lm6S82xnDQNqPZ1ngtDqvmJAbzVaDJ0Q8DTtdfg3DH2j8f4C0M1/gXr/D
 h4MTmkVhUmKHsAZlkiibGcmEiRQsXWQAblvGqVU7fGxtpdMpFvQLYadgiKJ9ZVazOSJj
 cRfw==
X-Gm-Message-State: AOJu0Yw/aNd/u1EsmD7efnKa68USbTPoLKJIyeavWekH+RA7B3mcmS7j
 3PQTqDtqm5o9vEdWmkyi97YgO53NX/Z9TBw+ihH3c3AZOwPNy3EbzpK3CcVty+f4XA2erOahtbI
 B9VisOGY5eHa4N5qk+MqC+ItqDo0fKCRmZJY1+8qsEfe6/wKzTfb1wmLF90zZJS8PdKRy
X-Gm-Gg: AZuq6aIe9A8VADGhR5HBiY4+jD5ic+95CVasmkSqSgy4/b9fVk+JUsNukZd4WkYtMOK
 fknz57qaVX/sHzYxY22ur9jtfM3tKUhVBUclgqHPO6LNX0rREA6h1hv3Nhk4Tp9lWHeHyiQJidC
 xXyYs0WXOfdxrxzhiKgCu6dCvqNJvyvSO1qsTcZdgz4iQOs2oLX+PiQ7d1S9iOQcoBTxRRQWMxr
 uIXVT60mx25sK+WmaXeeeA0uzreBjFq1v9pa67/PtDqvCmjkalTUFKbRlh7zjWc89Ip07a8RnyB
 UZVdDS04mvj9SZ7VyhuPKsRl8LR0ZGgZgUO6v9iyH/AySIdHMak7NlEopJ8iMmccmMI4Y4NPsb1
 MJ5o7syiby4HJxll7aGZ7Cm9SZeffvFC5qzt6XODGeGz4dQTqVYTruqhL5IE7xpUejZr8c4c2WJ
 g8g0xt
X-Received: by 2002:a17:902:f788:b0:29e:9387:f2b7 with SMTP id
 d9443c01a7336-2a7188577d1mr195215335ad.11.1769054678958; 
 Wed, 21 Jan 2026 20:04:38 -0800 (PST)
Received: from localhost.localdomain ([2a14:7dc0:201:e15::416])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a75889f594sm66256565ad.85.2026.01.21.20.04.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Jan 2026 20:04:38 -0800 (PST)
From: Wei Wang <wei.wang@smartx.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com, Wei Wang <wei.wang@smartx.com>
Subject: [PATCH] qga: Fix crash due to redundant error setting in
 qmp_guest_file_open()
Date: Thu, 22 Jan 2026 12:04:30 +0800
Message-Id: <20260122040430.51001-1-wei.wang@smartx.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=wei.wang@smartx.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 22 Jan 2026 00:57:14 -0500
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

Avoid setting GError multiple times in qmp_guest_file_open() by checking
if errp is already set.
This prevents crash caused by repeated error handling calls.

Signed-off-by: Wei Wang <wei.wang@smartx.com>
---
 qga/commands-win32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0fd0c966e4..8c45ca5004 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -263,7 +263,9 @@ int64_t qmp_guest_file_open(const char *path, const char *mode, Error **errp)
     fd = guest_file_handle_add(fh, errp);
     if (fd < 0) {
         CloseHandle(fh);
-        error_setg(errp, "failed to add handle to qmp handle table");
+        if (!*errp) {
+            error_setg(errp, "failed to add handle to qmp handle table");
+        }
         goto done;
     }
 
-- 
2.39.5 (Apple Git-154)


