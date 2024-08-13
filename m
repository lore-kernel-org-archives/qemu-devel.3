Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3906C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 09:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdoCg-0005Km-OX; Tue, 13 Aug 2024 05:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdoCe-0005CZ-0G
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:52:32 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdoCc-0001zP-29
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:52:31 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc47abc040so34485195ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 02:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723542748; x=1724147548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1DR36HIvFu76vDBuU+Z8chsrK+BUROUUvsk8uqfEyc=;
 b=pGPo9EzCrkyaBaDcM1z0BjHOwjx8bmt5MR0nH4okc64f4A+99gLG3LhS9wdOuleni+
 HOnKH8/hk0BSEMk68n4jEGLtVdtxb7y/xfW44RKU1oA9cJ7LJUMWj3x73d8KCA0M2FDP
 i08bOraICmmxwLTqhOZg/WCiii+Kj1j2/gMHKmgcQMj0YTiA9/nEBwEN3zJ7gNK/eu2c
 eEKsFr84IH2sJ6CpUFST4NngZXTK80wGiMy7OWTKCTpCHHKYIfHErn9t0IhLlD8ruByb
 PlIqNODtTrFZcLZLtfPtLXwHsNFCK7nkIGO+EndZWuBJSIu0nSHY+vGzuqKgJwrL5AZf
 RPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723542748; x=1724147548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1DR36HIvFu76vDBuU+Z8chsrK+BUROUUvsk8uqfEyc=;
 b=t14bK1O3lwzyQAyBuROqtI3f/5jSzJ2egZbPOQ0hJYnNcvI9JTfnLdbrNu0N2pZaPL
 IIzJxUhvFOcl1oeQYlEg4y6LVr4kgL/mDjW/cVfJ47N6BUMH4C9+OQkpKsvVLkQTAvC2
 4c9mmvDvKipHuTHA6LyhdWC2WDY7TX7ZQH9CSDiFmp6YhlJaMw/Ieeq8Tt/hwdIctu/4
 h84KFEFr7jS+758ZRCytpjIqj9BHxBYC9r4RdrNst6kbiQjmv2vSuwmbwobt4lzPlole
 kfeVyLCeQCv835/PYRgTdbu/IKAODznY+erw9OHdWe+o5ElMR0t+d2gBPhgWLlS8gwW/
 fpAw==
X-Gm-Message-State: AOJu0YwCNd2Gh/d7XVJPcl3sFdkZ3Uoj+GxDh1jgApfLas8AG7I1BTv0
 J7aOmrc3hwU+N3Z2F4UflziN1a5+NP+ICVXAOgv16u3yzdDoKwIZ5436bYEP+K/w9Ns7s9cxEYU
 LkZo=
X-Google-Smtp-Source: AGHT+IEZG0DUpBxXyzQionAqYXLKyqixoxJOSPvTMDhKZOkYIm/3ZytC0/zn4uJYXMiGXAt5JCgDVw==
X-Received: by 2002:a17:90a:ba92:b0:2c9:7cb6:38b0 with SMTP id
 98e67ed59e1d1-2d39254ebd9mr3233051a91.19.1723542748266; 
 Tue, 13 Aug 2024 02:52:28 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9ca796fsm10851876a91.30.2024.08.13.02.52.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 02:52:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] meson: Move -fsanitize=undefined into normal configuraton
Date: Tue, 13 Aug 2024 19:52:16 +1000
Message-ID: <20240813095216.306555-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813095216.306555-1-richard.henderson@linaro.org>
References: <20240813095216.306555-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

With 8e466dd09246 and 23ef50ae2d0c, we disable function pointer
sanitization in CI because the qemu code base does not support it.
We must disable this for normal usage of --enable-ubsan as well,
so move it there.

Append options rather than prepend, since all of this requires
proper ordering of options.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 10 ++++------
 meson.build                | 11 +++++++++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index aa32782405..fc5d516557 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -428,9 +428,8 @@ clang-system:
     job: amd64-fedora-container
   variables:
     IMAGE: fedora
-    CONFIGURE_ARGS: --cc=clang --cxx=clang++
-      --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
-      --extra-cflags=-fno-sanitize=function
+    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan
+      --extra-cflags=-fno-sanitize-recover=undefined
     TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
     MAKE_CHECK_ARGS: check-qtest check-tcg
 
@@ -441,10 +440,9 @@ clang-user:
   timeout: 70m
   variables:
     IMAGE: debian-all-test-cross
-    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-system
+    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --disable-system --enable-ubsan
       --target-list-exclude=alpha-linux-user,microblazeel-linux-user,aarch64_be-linux-user,i386-linux-user,m68k-linux-user,mipsn32el-linux-user,xtensaeb-linux-user
-      --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
-      --extra-cflags=-fno-sanitize=function
+      --extra-cflags=-fno-sanitize-recover=undefined
     MAKE_CHECK_ARGS: check-unit check-tcg
 
 # Set LD_JOBS=1 because this requires LTO and ld consumes a large amount of memory.
diff --git a/meson.build b/meson.build
index 19b18b4a8a..5b9ac6c6c5 100644
--- a/meson.build
+++ b/meson.build
@@ -488,8 +488,15 @@ if get_option('ubsan')
   # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
   if cc.links('int main(int argc, char **argv) { return argc + 1; }',
               args: [qemu_ldflags, '-fsanitize=undefined'])
-    qemu_cflags = ['-fsanitize=undefined'] + qemu_cflags
-    qemu_ldflags = ['-fsanitize=undefined'] + qemu_ldflags
+    qemu_cflags += ['-fsanitize=undefined']
+    qemu_ldflags += ['-fsanitize=undefined']
+
+    # Suppress undefined behaviour from function call to mismatched type.
+    # In addition, tcg prologue does not emit function type prefix
+    # required by function call sanitizer.
+    if cc.has_argument('-fno-sanitize=function')
+      qemu_cflags += ['-fno-sanitize=function']
+    endif
   else
     error('Your compiler does not support -fsanitize=undefined')
   endif
-- 
2.43.0


