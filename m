Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C065C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7gu-0005Lz-G3; Thu, 22 May 2025 11:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uI7gb-0005Hr-Ou
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:18:24 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uI7gW-0007jF-0Y
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:18:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso64931555ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747927094; x=1748531894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1boImOkNO9u05Axbzk7QIsP79Tfds3gPvrPsWXaqBM=;
 b=SDFP5/n7Kxd+fSnVj/PKhk6/I4c/aIhgk9+WFmPHcPjdHrWvhb0MxaQN9tjt4r69Oq
 FQLJU6KSfEfSivLo4s7XFSnnVrk26Sp/m1zrdZiScWYZLBh25nc0cDmfc46N0MfDvYtQ
 RaQTHIT/qLnFt3BWKnVLhShRqFxQpmWbyW7XW1HieTn9TKhlA+wbcNL4CWfNpIkDBiIG
 Q9iWlB1Jx4axbOisnCs04i8Y7/uARPsisKWXl6lyaoDwWvJrvmjCSq2/D8AYdPWGlxLp
 Qo7UyCvOLDgfahoEhERrlncsio3A8ofA+rYOLz78yzFPDpB0CvgmnjDCkxKKlUZ5J1ph
 3tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747927094; x=1748531894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1boImOkNO9u05Axbzk7QIsP79Tfds3gPvrPsWXaqBM=;
 b=XuSQitR5rOiant2z7kOC3JbYJGKzzY1oXLmoD6kua81L9nVj42QsT37sUQ6yciFFrI
 YXAeZryJFC2iHvDUocMEvvSUoc2QMcdpfdKJS1wR8ZwAiw/uYktHEti4oUt5cM8uwJiB
 zvuvBBeTerv9TaZwCghtcBXFmgTuBOEf380Oj2/jtNMPZwNYYrf435n6tu9QaSwrTayL
 I+xHElpIwVVJ1YhFTNI6dHS6W+OfVVvvvZvfqb7kRUjLKCpxHeg0/SPQSCpHjSm6d/KV
 C0W9Cul3iBPP44Scd1JNpswPKp1OvPFm/HAaSHZqC6pGocGMkPgZEd0FDnHXhYh6a3Ke
 rrUg==
X-Gm-Message-State: AOJu0Ywrpo1YuI8qcLdVLnriAoz+tstceaoanTJ9uuiJokwiS9XMoF3F
 h3G1JqZMx9v/8BaK0Mt7QfFbweQTa2NRitOYcZeXaihwnHTxV/5oPOHCPPWhWw==
X-Gm-Gg: ASbGncuRQ8hkB72zymoo6nMuU+A0IlcGIiUKmvS2OflzO+/fvwOOxme8wEZ1q4UsB1d
 DO819y2fG3pgC0JyH915Jh8XkIcFOtXayXJx6TP0sbFeEtxepna+prD9gq50IwhPVfVmHCGs5JI
 3FFIkwDIoK0gX7JLZJz4vRW1ZfXPbnw4W7L/YWhaE/qYUi44ean6VaLXifVtJru6Q18ir2xKKr+
 DT3E5Papf+PC3nN+Z/GPFbSjHJgcAxTiTA38R6HgHKeOzX5GhFhAI3tAVeErYg2eIjdNpfRaj0P
 8VtMIAZhqdHyHVN4xryU7CDmHqOanepr8PZb2clZlehJohCEeKs=
X-Google-Smtp-Source: AGHT+IHJRDmhG6UKcTyuWDscDV0MVynO7XlaLRfMjSgW3MyuXJu4jZzPqkdu1+9eT6vDXOdETSWU8A==
X-Received: by 2002:a17:902:ea0a:b0:231:8030:74a5 with SMTP id
 d9443c01a7336-231d45a9c7cmr360757065ad.32.1747927093645; 
 Thu, 22 May 2025 08:18:13 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:c732:a88c:b916:8b9f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4b017dasm110443555ad.98.2025.05.22.08.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 08:18:13 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 ktokunaga.mail@gmail.com
Subject: [PATCH 2/5] include: define vaddr based on TCG_VADDR_BITS
Date: Fri, 23 May 2025 00:17:27 +0900
Message-ID: <7e749b8c93fc15ceb042eef95e49ac27cc917e75.1747922170.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747922170.git.ktokunaga.mail@gmail.com>
References: <cover.1747922170.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit defines vaddr based on TCG_VADDR_BITS. For non-wasm hosts,
TCG_VADDR_BITS maches the pointer size, so this change preserves the
original behaviour.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 include/exec/helper-head.h.inc |  9 +++++----
 include/exec/vaddr.h           | 28 +++++++++++++++++++---------
 include/tcg/tcg.h              |  6 +++---
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index 5b248fd713..cbeb7bc371 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -58,16 +58,17 @@
 # define dh_ctype_tl target_ulong
 #endif /* COMPILING_PER_TARGET */
 
-#if __SIZEOF_POINTER__ == 4
+#if TCG_VADDR_BITS == 32
 # define dh_alias_vaddr i32
 # define dh_typecode_vaddr dh_typecode_i32
-#elif __SIZEOF_POINTER__ == 8
+# define dh_ctype_vaddr uint32_t
+#elif TCG_VADDR_BITS == 64
 # define dh_alias_vaddr i64
 # define dh_typecode_vaddr dh_typecode_i64
+# define dh_ctype_vaddr uint64_t
 #else
 # error "sizeof pointer is different from {4,8}"
-#endif /* __SIZEOF_POINTER__ */
-# define dh_ctype_vaddr uintptr_t
+#endif /* TCG_VADDR_BITS */
 
 /* We can't use glue() here because it falls foul of C preprocessor
    recursive expansion rules.  */
diff --git a/include/exec/vaddr.h b/include/exec/vaddr.h
index 28bec632fb..ff6184a31e 100644
--- a/include/exec/vaddr.h
+++ b/include/exec/vaddr.h
@@ -6,15 +6,25 @@
 /**
  * vaddr:
  * Type wide enough to contain any #target_ulong virtual address.
- * We do not support 64-bit guest on 32-host and detect at configure time.
- * Therefore, a host pointer width will always fit a guest pointer.
  */
-typedef uintptr_t vaddr;
-#define VADDR_PRId PRIdPTR
-#define VADDR_PRIu PRIuPTR
-#define VADDR_PRIo PRIoPTR
-#define VADDR_PRIx PRIxPTR
-#define VADDR_PRIX PRIXPTR
-#define VADDR_MAX UINTPTR_MAX
+#if TCG_VADDR_BITS == 32
+typedef uint32_t vaddr;
+#define VADDR_PRId PRId32
+#define VADDR_PRIu PRIu32
+#define VADDR_PRIo PRIo32
+#define VADDR_PRIx PRIx32
+#define VADDR_PRIX PRIX32
+#define VADDR_MAX UINT32_MAX
+#elif TCG_VADDR_BITS == 64
+typedef uint64_t vaddr;
+#define VADDR_PRId PRId64
+#define VADDR_PRIu PRIu64
+#define VADDR_PRIo PRIo64
+#define VADDR_PRIx PRIx64
+#define VADDR_PRIX PRIX64
+#define VADDR_MAX UINT64_MAX
+#else
+#error Unknown pointer size
+#endif
 
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 3fa5a7aed2..256a7b059c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -218,13 +218,13 @@ typedef struct TCGv_ptr_d *TCGv_ptr;
 typedef struct TCGv_vec_d *TCGv_vec;
 typedef TCGv_ptr TCGv_env;
 
-#if __SIZEOF_POINTER__ == 4
+#if TCG_VADDR_BITS == 32
 typedef TCGv_i32 TCGv_vaddr;
-#elif __SIZEOF_POINTER__ == 8
+#elif TCG_VADDR_BITS == 64
 typedef TCGv_i64 TCGv_vaddr;
 #else
 # error "sizeof pointer is different from {4,8}"
-#endif /* __SIZEOF_POINTER__ */
+#endif /* TCG_VADDR_BITS */
 
 /* call flags */
 /* Helper does not read globals (either directly or through an exception). It
-- 
2.43.0


