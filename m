Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D45CFB421
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 16:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx7xh-0000qG-8V; Sat, 05 Oct 2024 12:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx7xe-0000ps-FH
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 12:48:54 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx7xc-0001dt-Fx
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 12:48:54 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e0afd945d4so2353758a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 09:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728146930; x=1728751730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iSrAwBk5bZNjn8Zy9dmgJJyBe5UY35yHEd3GQKBCY9s=;
 b=DITQYRdl1swQoyMDsXKkCOgW6axBDTsJmssDJrwNyvwvYby36+8MKwPlbdMOOP7UOh
 12sF+RfZjpxk56WenEYPIBUWZ8mo9LobA+39ohsi+kXtJc/namoDKXxaHYyXkk54YbY3
 QohKCqSSWEZFYJzuOmB4RnyTp1+Ike0yq4AR6xxhAAIbI3fZ/+3+em4vRonWGOHu9b/g
 /X2okF+8XNwZGZCJY84dS/7V83Upnxqp+c+Ct+N/zX1+PSrUg6BbIjPaOp0GgCGt//QA
 RpYLOtKoZ6lqBT8ukPRekeQuvO76XWmgOztmi219x/s46jRZaIMXrktkItKelwiHP+M5
 epzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728146930; x=1728751730;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iSrAwBk5bZNjn8Zy9dmgJJyBe5UY35yHEd3GQKBCY9s=;
 b=A6TEcZ04WQ9+8SN57zVVlxpeAx9xdFyOHgAJ8OeahF0CMSN892/l9lCWnnXl9n5TfG
 1F68iwI0mmBU09dt15Y8TLwwh72M51u7wTJhpgN6NCFEmCGrt0x1uwkC9naDJtjB+2v2
 gnAvFMy0CTarDxFBVtZRQNN3MzSLfQqKN8V8XNDEnX73z1LwI12hfQrxfiJn5dzaiGbd
 d0yXxuNhZtgYl6UPbnJAZCD9aLlnY5urF4jRAyKq92bRTkVIbsu4KCYm4MJwRPQQYvZm
 emwvQgZJ7Bau2M+hgDh3jieYyXANu7BOkFWlYALxaj818NQwxcSAMrwMxNrpfe2G0oq0
 03Ew==
X-Gm-Message-State: AOJu0YxPBamN3SL9BnvSsRwfrjSjPzfu4u5puGn8WaSJaJSPeysLVHrv
 L8FwHk7HkZ+/RPOOLaBZZtfl8wBNL0WstQ1ekx/11YX9t9nEdC8UVWIfXmmI+JqcRcEHaDSbRLx
 C
X-Google-Smtp-Source: AGHT+IHrFaiYUXXkb+26350+hd1YbPnIQtBz5AsI6Sj550FvAE750ku6uhOBe2SWhE5QfHvBKUx51Q==
X-Received: by 2002:a17:90a:c7c9:b0:2e0:a4a4:75d9 with SMTP id
 98e67ed59e1d1-2e1e622860emr7885380a91.12.1728146930528; 
 Sat, 05 Oct 2024 09:48:50 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e8665529sm3787753a91.39.2024.10.05.09.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 09:48:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru
Subject: [PATCH] linux-user: Fix parse_elf_properties GNU0_MAGIC check
Date: Sat,  5 Oct 2024 09:48:49 -0700
Message-ID: <20241005164849.424838-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Comparing a string of 4 bytes only works in little-endian.

Adjust bulk bswap to only apply to the note payload.
Perform swapping of the note header manually; the magic
is defined so that it does not need a runtime swap.

Fixes: 83f990eb5adb ("linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2596
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0678c9d506..52c88a68a9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3121,11 +3121,11 @@ static bool parse_elf_properties(const ImageSource *src,
     }
 
     /*
-     * The contents of a valid PT_GNU_PROPERTY is a sequence
-     * of uint32_t -- swap them all now.
+     * The contents of a valid PT_GNU_PROPERTY is a sequence of uint32_t.
+     * Swap most of them now, beyond the header and namesz.
      */
 #ifdef BSWAP_NEEDED
-    for (int i = 0; i < n / 4; i++) {
+    for (int i = 4; i < n / 4; i++) {
         bswap32s(note.data + i);
     }
 #endif
@@ -3135,15 +3135,15 @@ static bool parse_elf_properties(const ImageSource *src,
      * immediately follows nhdr and is thus at the 4th word.  Further, all
      * of the inputs to the kernel's round_up are multiples of 4.
      */
-    if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
-        note.nhdr.n_namesz != NOTE_NAME_SZ ||
+    if (tswap32(note.nhdr.n_type) != NT_GNU_PROPERTY_TYPE_0 ||
+        tswap32(note.nhdr.n_namesz) != NOTE_NAME_SZ ||
         note.data[3] != GNU0_MAGIC) {
         error_setg(errp, "Invalid note in PT_GNU_PROPERTY");
         return false;
     }
     off = sizeof(note.nhdr) + NOTE_NAME_SZ;
 
-    datasz = note.nhdr.n_descsz + off;
+    datasz = tswap32(note.nhdr.n_descsz) + off;
     if (datasz > n) {
         error_setg(errp, "Invalid note size in PT_GNU_PROPERTY");
         return false;
-- 
2.43.0


