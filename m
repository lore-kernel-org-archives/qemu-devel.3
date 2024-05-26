Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFDDC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 09:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBAcN-0006CH-BO; Sun, 26 May 2024 05:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sBAcM-0006BE-93; Sun, 26 May 2024 05:56:42 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sBAcK-0003ob-Q4; Sun, 26 May 2024 05:56:41 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f8d688ba3cso1032770a34.3; 
 Sun, 26 May 2024 02:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716717398; x=1717322198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ln+3lJy+RB8fW9LtHsTAOIqoDd/xm29GUGTXmizOcVk=;
 b=De7WgquOQme9n5mY2cIH6cs67HrgrgnncZ5CIoGpjPYv9fY3CsZIbTu4euV7Yi/Ya7
 nF0jl9QzuK18W+5Ba+TyMjxgQ2SQMHT3g3iUUeh5e2lTHt8oG+AiWyg4ebJlOHAELwQc
 qYTfmOd+Vv1GPV46/b6jpYbZ384qnGyvXxPai6SQ9b9zT0CPxK+5jl4DDed1SozLScea
 Z8Gk0Wn9BfIB4QLpSfhlzSQlgyQuBXOCaHmTW4w0L21oWlobNOLKc8K73qEtZLl170k2
 6FUpjR9fe3QWzBa0SPtnpHgYxUUtc16cm6rjH9xprLs5Ng9yfDyY67z8lBPFFJoSXAVv
 LLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716717398; x=1717322198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ln+3lJy+RB8fW9LtHsTAOIqoDd/xm29GUGTXmizOcVk=;
 b=af6IAhtBQh1MymwakGecUFbKPj5JsieJg5wZu69b5jjXxnmLF81C2ieqNU95wUHHbl
 jOIxS1oj9Yd1NKOHI4I8zkP0HOXlb6G7DEF3wrfPZnYn/nC55E9gr1ZUQN/ZSrLZ8+l/
 6rJrT5EPixVwvfUMHIUFUqYUvbIZyPo4GwTaSaS2OsDr2b30bMsNwDeIfUuWKUThyBg+
 xNZguzWuSrhP0VKXx/xiT/MstHUcs31jHDvZypstqsSZfN7Ow4+bQh+00qsGgQw/6wYq
 1WSCUkHZ1cB5uHg20zB/n1HRCs9Q+gWw1NFlD4v7hEZv5VNLxxYQGY6sssu13Eix6CN7
 ivWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDyVpDMYC0WWZZxmxFCM943d4lw9k+qIjYuu+wbaptqzWyEctB42cnl0P4JkkWxuxk7CyqIHqgNolXgysnmUPae5ALlRw=
X-Gm-Message-State: AOJu0YxcECYl6BjfSCR6sdWVapgJryRoHd4qBHsAGsGrBRvxR7B1l1sZ
 KY30Oi3aAaVmCbF1ri2RHvJkmHu8bT2vBRGSUhBQaM9uFgQ8Fmt0ueG7AeZV
X-Google-Smtp-Source: AGHT+IGZDp16L8jUPuHhauGGkhx5LYLcMz1nEySgT9nKoAM/gdwxCcuyps1XFHPM1A+TV4XSacQzhQ==
X-Received: by 2002:a05:6830:110d:b0:6f0:6170:3762 with SMTP id
 46e09a7af769-6f8d0ba95f4mr6596480a34.38.1716717398697; 
 Sun, 26 May 2024 02:56:38 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm4021368a12.46.2024.05.26.02.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 02:56:38 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v3 1/6] vvfat: Fix bug in writing to middle of file
Date: Sun, 26 May 2024 17:56:01 +0800
Message-ID: <2871281d8ea41fb4d7ef8f9beeaba017a1717019.1716717181.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716717181.git.amjadsharafi10@gmail.com>
References: <cover.1716717181.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Before this commit, the behavior when calling `commit_one_file` for
example with `offset=0x2000` (second cluster), what will happen is that
we won't fetch the next cluster from the fat, and instead use the first
cluster for the read operation.

This is due to off-by-one error here, where `i=0x2000 !< offset=0x2000`,
thus not fetching the next cluster.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
---
 block/vvfat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 9d050ba3ae..ab342f0743 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2525,7 +2525,7 @@ commit_one_file(BDRVVVFATState* s, int dir_index, uint32_t offset)
         return -1;
     }
 
-    for (i = s->cluster_size; i < offset; i += s->cluster_size)
+    for (i = s->cluster_size; i <= offset; i += s->cluster_size)
         c = modified_fat_get(s, c);
 
     fd = qemu_open_old(mapping->path, O_RDWR | O_CREAT | O_BINARY, 0666);
-- 
2.45.0


