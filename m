Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7759CA600B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENAo-0005CN-8X; Wed, 07 Oct 2026 04:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xEITe-0004H3-9a
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:38:06 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xEITP-0000Kl-D6
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:37:49 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c2e40d62e77so143007966b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1791344235; x=1791949035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/PP1sE2gcMx15hvxcPEGbcot5JQYNmcdFBQR7TocUw=;
 b=iwfvRNwK+aAFq/RdfK3ceoYhn1sS2we7U8vcKb7cYvqeUIyv84GI5uCU3WrwkrwAPT
 FFjST0sEs37xkZ7IyXSdGPbutR9K6Y7jdCXWGU40gbz2AT8PzAdze2KDvsQcKjXNAi3K
 bIVAtX7N9mGUbxxnBI0C6U9YB8tJwmIoXkenU0qUh6At9jWpagp+BbnUBY1SiHoD4zvm
 tQsepfMiaVuYhX97BPV1weXoaY8NnX/+Npk7aP7T6wjhPKCNa83QCK0Im7YCZ+hcfYjU
 asQVv0SClROrwyGppaGRxApLz+v6b7nPo3qQ7y1qNCJphG3/bVl/8W8QDUoUjoxFk0jU
 hEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791344235; x=1791949035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i/PP1sE2gcMx15hvxcPEGbcot5JQYNmcdFBQR7TocUw=;
 b=QJqnfnNSUFRovcPlTSBDrnmgdLWhaGfAdAtjskOg8kqsUO9RroyvKSIw+8ZrGBUrUx
 DoxBfkEHVLaUJpjab5XtJFuM+oMeSh8ZZJLv96PcrAYz0QAz2C2A0LUKjnc7qJfc5gez
 ZAhdfPkiVoAxMSjLN/NiM0DMoxxkobMvOp1sCctqACQODtn2vUqrjhhnkHb+TJggbMaG
 oZwFSBET0A5l3AwRVE3zXAS+SrfPKXl22E2MDzEkW8d5TXRp3irMeNYQr2ap+jA8T1Wu
 fDZG/ci9mbI22JleH9GptDvi909N78PgBzudSHFRnxl9IA95MxwB0/AxKW1AMklxHTi0
 RbZQ==
X-Gm-Message-State: AFuF++kbTCIy+B1f5VHQjoj+0iqmLWF50Zgjkl9tB0+0gWtaLmq5n058
 ggL6WDbUqRqHdklRH+9iFwuJfzVIRW92m+uJzWPAeq7nulyDWcTGFrNs10jm6Wdas74wF/I7MfL
 /6jv1
X-Gm-Gg: AYBFou0RnbTJ7SHr8eht0OAZRhi/2uyxE2e6LIh6Th1OvJ88fCtyLd5YuZxEhivIDS6
 HzI+9v4+i84SMmk+J7T5gk0lQ0zj7oWXoKfIWybE7GhZHl1790n2Bvly1d+yjYC21ndgc6K5VVW
 yyEyG20fvBFDKlw7aUP0ys7jdYpLMNRS+lPgT5rP5cZx0qnx46I9FPabEzjpVmII2hVqM8yIwrA
 eUyG9lUlbeMT149V9Xpy10oTVfuj/JuccYMg+nJmBD0ibWnVUvCCHEhtpzYAj4MCiSJnUTj8uvZ
 GpJ2fL/J4sawDIZwYZ5YCj1pZ36kmvTfMLTmjWujCqkhq38+k/O94B9adpEOOfHnZ1+/mnkGgoN
 5kBM0AvTnG5QjsOvfmkVG8yk41xQhZiOsGJWupzltftWUWXEViP/XHbr4aNLUMQAeWspM75znO4
 EFiOqK4II5nijcZv07rusDY9qFq4EvwPGchl3YxN4phG6avH63y8q62eLLoe7QZlEFibI=
X-Received: by 2002:a05:600c:1914:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4a17b52d449mr33282475e9.9.1791306463480; 
 Tue, 06 Oct 2026 10:07:43 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a39a:8667:da6e:b69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c5b9d6sm76254095e9.13.2026.10.06.10.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 10:07:43 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 1/3] migration: add QEMU_COUNTED_STRING_SIZE for counted
 string buffers
Date: Tue,  6 Oct 2026 19:07:36 +0200
Message-ID: <20261006170738.453977-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006170738.453977-1-den@openvz.org>
References: <20261006170738.453977-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=den@openvz.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

A counted string carries its length in one byte, so the buffer that
qemu_get_counted_string() fills must hold 256 bytes. The dirty bitmap
load state spells that size as a bare 256 for both of its alias buffers.
Name it next to the qemu_get_counted_string() prototype and use it there,
in the length assert of qemu_put_counted_string() and in DBMLoadState.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-stable@nongnu.org
---
 include/migration/qemu-file-types.h | 6 +++++-
 migration/block-dirty-bitmap.c      | 4 ++--
 migration/qemu-file.c               | 5 +++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu-file-types.h
index adec5abc07..2a073bed29 100644
--- a/include/migration/qemu-file-types.h
+++ b/include/migration/qemu-file-types.h
@@ -163,7 +163,11 @@ static inline void qemu_get_sbe64s(QEMUFile *f, int64_t *pv)
     qemu_get_be64s(f, (uint64_t *)pv);
 }
 
-size_t coroutine_mixed_fn qemu_get_counted_string(QEMUFile *f, char buf[256]);
+/* Buffer size for a string whose length is sent as a single byte */
+#define QEMU_COUNTED_STRING_SIZE 256
+
+size_t coroutine_mixed_fn
+qemu_get_counted_string(QEMUFile *f, char buf[QEMU_COUNTED_STRING_SIZE]);
 
 void qemu_put_counted_string(QEMUFile *f, const char *name);
 
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 1b8f39c12b..1386f43635 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -145,8 +145,8 @@ typedef struct LoadBitmapState {
 /* State of the dirty bitmap migration (DBM) during load process */
 typedef struct DBMLoadState {
     uint32_t flags;
-    char node_alias[256];
-    char bitmap_alias[256];
+    char node_alias[QEMU_COUNTED_STRING_SIZE];
+    char bitmap_alias[QEMU_COUNTED_STRING_SIZE];
     char bitmap_name[BDRV_BITMAP_MAX_NAME_SIZE + 1];
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 7735e61854..df3f96fb24 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -829,7 +829,8 @@ uint64_t qemu_get_be64(QEMUFile *f)
  *          else 0
  *          (Note a 0 length string will return 0 either way)
  */
-size_t coroutine_mixed_fn qemu_get_counted_string(QEMUFile *f, char buf[256])
+size_t coroutine_mixed_fn
+qemu_get_counted_string(QEMUFile *f, char buf[QEMU_COUNTED_STRING_SIZE])
 {
     size_t len = qemu_get_byte(f);
     size_t res = qemu_get_buffer(f, (uint8_t *)buf, len);
@@ -847,7 +848,7 @@ void qemu_put_counted_string(QEMUFile *f, const char *str)
 {
     size_t len = strlen(str);
 
-    assert(len < 256);
+    assert(len < QEMU_COUNTED_STRING_SIZE);
     qemu_put_byte(f, len);
     qemu_put_buffer(f, (const uint8_t *)str, len);
 }

base-commit: 942229961efea74b153c44c59188eb08375f10f1
-- 
2.53.0


