Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89BDC04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 16:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxUKi-0000kb-Vd; Thu, 18 Apr 2024 12:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxUKh-0000k1-CC
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:09:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxUKf-0006Xy-IK
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:09:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-349c4505058so724082f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713456591; x=1714061391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpo0HdL0eHYUdshcZ/Szyn4EYxCkR3M8RtXPhI8xpmY=;
 b=gDyw2IUB9oyeQit2OBqvwUO/HeOmEegMTgm14PN/h+5515A7MpBzSK9YQrwdeqbriC
 e+cOjto9L5mUTWYnAKdXubEvU8S1HHkxsdw+4PXWePSoML3VWzh6K9fWA7c/6uqH6Ah8
 wCMEqIPxxqnEJfWKpMokXn/Ier8YkDxtHadNUhu/tBROR+mQEulxBvHgVodQYREe/OTm
 0j93j+6tjl/ZFB8MCfNDIp12MwinZ+qupI2G8TZhjMM9fPPVlx9QwWUvlJtunDp4n9K0
 7ihwQRCJ8mkZ3ZwkYmz2A9oiC/iqxgAL5MgmEdvDis9+seJlW0o9RmJ5SSzzWQp/rHCo
 HaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713456591; x=1714061391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kpo0HdL0eHYUdshcZ/Szyn4EYxCkR3M8RtXPhI8xpmY=;
 b=rlUeyYX70hYdsvA96TNKNzIbgdUGWOCQvtnO6xCKTtLzzcM214FgBEjzQQZrPc6B3+
 JOdq3036fIZc3qE3kasMCqXxNRBdzu3odpt6OX2JIZkFxU68LFBRNqJ/v6wDKsxV1l8d
 yfEz03JcUvmX4HyTxsryE/OokspnUA7iwtAXhg3CuM+xao1mxBys+IEEltk5T1eVTM89
 PpEmlb3FZ8+IkCTY3F/QlRxlNh43zPaQ4zB12ifVQI8z1uymwaunGkOG3ClBuD1PR9dM
 aTsk5hjRn75peEWSs9l+9KldEYI8PuThD/tjn7/MPAHgf9kKj3I3HsyPSPhQXGtqmBiw
 ZHOQ==
X-Gm-Message-State: AOJu0YyxXcfHSfu6NiHSlfls8c+gK/FZXU0DFY6DBMdmU+ihJRjtdnUE
 RVFowOYug6CQneC9RUoCQEHPPvX2oS9iQxwPYTMAMcOQyDFK89M+xobuL7O+jDJpGUT4prs3MsX
 t
X-Google-Smtp-Source: AGHT+IGp851teTyDhT7ce6yV0euRvN2T15mAVI/VygshimM9xVF5c30IkH2EWd3i0VEwFqqEBKLGEg==
X-Received: by 2002:a5d:4004:0:b0:343:7e98:e73e with SMTP id
 n4-20020a5d4004000000b003437e98e73emr2034591wrp.40.1713456591518; 
 Thu, 18 Apr 2024 09:09:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 h16-20020adffd50000000b00346d3a626b8sm2210100wrs.3.2024.04.18.09.09.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 09:09:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] hw/elf_ops: Rename elf_ops.h -> elf_ops.h.inc
Date: Thu, 18 Apr 2024 18:09:42 +0200
Message-ID: <20240418160943.95047-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418160943.95047-1-philmd@linaro.org>
References: <20240418160943.95047-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Since commit 139c1837db ("meson: rename included C source files
to .c.inc"), QEMU standard procedure for included C files is to
use *.c.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented in the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Therefore rename "hw/elf_ops.h" as "hw/elf_ops.h.inc".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/{elf_ops.h => elf_ops.h.inc} | 0
 bsd-user/elfload.c                      | 2 +-
 hw/core/loader.c                        | 4 ++--
 linux-user/elfload.c                    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename include/hw/{elf_ops.h => elf_ops.h.inc} (100%)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h.inc
similarity index 100%
rename from include/hw/elf_ops.h
rename to include/hw/elf_ops.h.inc
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index baf2f63d2f..833fa3bd05 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -383,7 +383,7 @@ static const char *lookup_symbolxx(struct syminfo *s, uint64_t orig_addr)
     return "";
 }
 
-/* FIXME: This should use elf_ops.h  */
+/* FIXME: This should use elf_ops.h.inc  */
 static int symcmp(const void *s0, const void *s1)
 {
     struct elf_sym *sym0 = (struct elf_sym *)s0;
diff --git a/hw/core/loader.c b/hw/core/loader.c
index b8e52f3fb0..2f8105d7de 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -305,7 +305,7 @@ static void *load_at(int fd, off_t offset, size_t size)
 #define elf_word        uint32_t
 #define elf_sword       int32_t
 #define bswapSZs        bswap32s
-#include "hw/elf_ops.h"
+#include "hw/elf_ops.h.inc"
 
 #undef elfhdr
 #undef elf_phdr
@@ -327,7 +327,7 @@ static void *load_at(int fd, off_t offset, size_t size)
 #define elf_sword       int64_t
 #define bswapSZs        bswap64s
 #define SZ              64
-#include "hw/elf_ops.h"
+#include "hw/elf_ops.h.inc"
 
 const char *load_elf_strerror(ssize_t error)
 {
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 28d9e8a9a5..fc60c01d57 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3672,7 +3672,7 @@ static const char *lookup_symbolxx(struct syminfo *s, uint64_t orig_addr)
     return "";
 }
 
-/* FIXME: This should use elf_ops.h  */
+/* FIXME: This should use elf_ops.h.inc  */
 static int symcmp(const void *s0, const void *s1)
 {
     struct elf_sym *sym0 = (struct elf_sym *)s0;
-- 
2.41.0


