Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5786C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQoLl-00024E-TW; Mon, 08 Jul 2024 09:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <halouworls@gmail.com>)
 id 1sQmUq-0000ZJ-NP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:25:28 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <halouworls@gmail.com>)
 id 1sQmUp-0005R5-3W
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:25:28 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70b0bc1ef81so1617147b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720437924; x=1721042724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nCGoD0xBJw98jcj6O8YNShoey7vZZpF+2IbEsXyWDKk=;
 b=U7Rmt7UTub6b1WtUyIW3NIbv7rXYkz0t9+IbeKVJAJMB2ZMx+cRF7BANEuQPmylfmh
 vu7s+0k/RwpmgI37vi/MoqslGzC3iypcXYFqUUMwWIDDt2yhHwd8znFwT/pKppqjw/Xw
 ESbtDsaFzphsPHwzN20xkIuEdxeI8LTdypbMsdiXK5QYiN1k2fuq0rAcDETI3R+k0g4E
 JixYZOa3g5Nh6V8lU3mEVndL73e7kbF2XLJkzowa5U/Qqth5QbTALglRlVk1vjSXFDhu
 fhJ3pGhmInICelqG+d4dPuw6my+AvvsmueUhU/jaIJVQHmoEZCah+gbQuaeBaeIxVDu6
 Cupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720437924; x=1721042724;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nCGoD0xBJw98jcj6O8YNShoey7vZZpF+2IbEsXyWDKk=;
 b=gLfLYcd2v3xuQIur0IRLs3z4/TIEnMdPFR3o0kP5XRrIvLNfxlbZhQt+gmrZMGzwdx
 yHRkrMF6baORXvFRqmuptovRc+rcvHX6y5TKoBJTSG6I5OW42mzD7kHVRre1N73ZJbCk
 55fjrxzK9CLitltKLM2iIxMMjx7SsiZmLW5vcgcLOQkV17NQWfsLsCCyEMPPgQ4bHwr0
 eS1S747UG8YMak8nV8fMth7sNwtcu4C8xv9hCARnOHtmJUUM3Kfp617DKx29RM0+g1cN
 dg8y39sJUhk7fr6L05R5NDg4+dbzRXzxarLDH6szUmZjOXTP0DlZwzv5KCnTLz4LATcv
 8cvg==
X-Gm-Message-State: AOJu0YytVc2HysZNOZ6TRW8NommTWX0vEKRoVPm59aM7bo2DBRdmQigk
 8qn6oTFXVAm21PWcH6zbkJ62DzGujZDuF34XAxfOUEwlsWX+wQfPlr5H1/lSBVc=
X-Google-Smtp-Source: AGHT+IGnF+17yFBxgPVis7cdLBwxrh20nJu5+QF2M3YIJ2qzfwAMcnw55tgQhrq9+VvYjJkpK8zlxw==
X-Received: by 2002:a05:6a20:2586:b0:1c0:f23b:cad3 with SMTP id
 adf61e73a8af0-1c0f23bcbd2mr2265437637.22.1720437923574; 
 Mon, 08 Jul 2024 04:25:23 -0700 (PDT)
Received: from VM-0-25-fedora.. ([119.28.53.59])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1fb1a075616sm94462495ad.15.2024.07.08.04.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:25:23 -0700 (PDT)
From: junjiehua <halouworls@gmail.com>
X-Google-Original-From: junjiehua <junjiehua@tencent.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 junjiehua <junjiehua@tencent.com>
Subject: [PATCH] contrib/elf2dmp: a workaround for the buggy msvcrt.dll!fwrite
Date: Mon,  8 Jul 2024 19:25:20 +0800
Message-ID: <20240708112520.106127-1-junjiehua@tencent.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=halouworls@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 08 Jul 2024 09:24:12 -0400
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

when building elf2dump with x86_64-w64-mingw32-gcc, fwrite is imported from
msvcrt.dll. However, the implementation of msvcrt.dll!fwrite is buggy:
it enters an infinite loop when the size of a single write exceeds 4GB.
This patch addresses the issue by splitting large physical memory
blocks into smaller chunks.

Signed-off-by: junjiehua <junjiehua@tencent.com>
---
 contrib/elf2dmp/main.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index d046a72ae6..1994553d95 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -23,6 +23,8 @@
 #define INITIAL_MXCSR   0x1f80
 #define MAX_NUMBER_OF_RUNS  42
 
+#define MAX_CHUNK_SIZE (128 * 1024 * 1024)
+
 typedef struct idt_desc {
     uint16_t offset1;   /* offset bits 0..15 */
     uint16_t selector;
@@ -434,13 +436,22 @@ static bool write_dump(struct pa_space *ps,
 
     for (i = 0; i < ps->block_nr; i++) {
         struct pa_block *b = &ps->block[i];
+        size_t offset = 0;
+        size_t chunk_size;
 
         printf("Writing block #%zu/%zu of %"PRIu64" bytes to file...\n", i,
                 ps->block_nr, b->size);
-        if (fwrite(b->addr, b->size, 1, dmp_file) != 1) {
-            eprintf("Failed to write block\n");
-            fclose(dmp_file);
-            return false;
+
+        while (offset < b->size) {
+            chunk_size = (b->size - offset > MAX_CHUNK_SIZE)
+                         ? MAX_CHUNK_SIZE
+                         : (b->size - offset);
+            if (fwrite(b->addr + offset, chunk_size, 1, dmp_file) != 1) {
+                eprintf("Failed to write block\n");
+                fclose(dmp_file);
+                return false;
+            }
+            offset += chunk_size;
         }
     }
 
-- 
2.45.2


