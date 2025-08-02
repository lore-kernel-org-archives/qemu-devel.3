Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E0CC88CB9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLP6-0005Ha-1W; Sat, 02 Aug 2025 19:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOk-00043M-5f
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:22 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOi-0001rg-Ad
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:17 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6196ca9a2edso834259eaf.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176335; x=1754781135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EsTLnH31scjYz+bxEZM+kYi0Y3PVFWRhTQ+Zd0S7h5Q=;
 b=HiTRavQLgnhZdIOaRLMUa4spvxvgXCEegiiixFUgWiqrDwLxkkWirX8l8UPgtgXXNW
 1kB9XrZE0MnuNqSo3SInquGpO93kg1TmQNq2yhOaut9Q47jS1JWcqePfrAb9zXI7hkZk
 WHVIr93pr9BQerOVqgJ1Gby3S1O+/BVwM7Zr8nbaLY/29utNgZj4fGTCnYWiHgAeA5C+
 YdTZfIR5FHjp41DXOaH2w0OzOZ3Y7TZNfmc1ivmuNuUKYH6ebumDNuuAn94LihDTLcls
 WwOx8/2FTv8cE6rF8s+rFWcuxPZClWDNweLR72xahVDZA9lv42vMUqwNlZU2jwWcjNtR
 W6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176335; x=1754781135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EsTLnH31scjYz+bxEZM+kYi0Y3PVFWRhTQ+Zd0S7h5Q=;
 b=gAmDNgxDE2RjsXnwsUhQ9y22543GlMml09ZUk9OYhxN7isaNBq56ImGLwaHGQ+l2OF
 cJtXy59PnGZp5Fu1H3aXSEal8LJlP+QdWYhRVrXIo6nsXgM7GJFrfYNHzUBnQA59zFQX
 UDbSIZXyZBhuDF7ob01o3ww96qz8HfuiBNXqMEc0YwIg/NQfZ1iOXapqLVdornkvgZjd
 +SPHcEnn3qyzShb+TcgDSpIOPzqLXjjNoiyETS3LVJeQHSmN95T1ik8qfNgf8DGsCmy1
 41+aKeT/AkaOGDECinAdU47aYjK8MnaViQ/FknZbzbzaE1sULEc50vim3DhSIeavv9Bs
 9o5w==
X-Gm-Message-State: AOJu0YyWbvmLVyA2PE6MF53zIF5CZdVPx1AurVnJFIFCtapnc2NQEtXM
 Js7U16hK5k1+ZZfj3Iath5Pax/NXs96TKUi1I4ttLnr6Ve1oXZNQXWy1TlA2ky/f7lPcFZr/Wsl
 y5chPbGw=
X-Gm-Gg: ASbGncvYB01szqzfDfVc3QHbAVcgMC0bHi5U+uhZEXmrY/uWV6TlGMx+BLjNUpfMzgZ
 TzzZnTHmrc5V0WNkyZf1DqqZ5wRJ1TmO6XEXPOnC3SlX2VX8HPAE5S9PBTXw0UB4WywF+DNanoq
 sZinIA1vDqAgBjzT0/6csra5McKKvRH08tmEc+4V62n3KmvS0L9upZ5zvEArQYHUBRdAoisnTuo
 kiJG2bQCZaI0t5/6QMcSU+DfRVZl9BbPCBwgi9d/ALgx0RJi3iwQQNA/4Hpylcp3LqIkcSjlBwJ
 No/C3mMhvvU4qGQ7KoI7HvdfOZWc/uLaL3i+T7DaDY6Figi/kq++7hkk55a5BO0Tl/AZPhyZSB7
 BV0z/2BywBeJwIWvWTrKjHloZz4PeUhY6Inim4qICai6ISQ9qx6EP
X-Google-Smtp-Source: AGHT+IEuke0XOlkLVcItYsWdckDMLKW1sJTJmSVPOwBXmcz9CiZYZuS5f0S8FXE1psx6HaGU6kUKng==
X-Received: by 2002:a4a:edc5:0:b0:618:d339:1fe with SMTP id
 006d021491bc7-6198f23451emr2592426eaf.3.1754176335185; 
 Sat, 02 Aug 2025 16:12:15 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 69/95] linux-user: Move elf parameters to {i386,
 x86_64}/target_elf.h
Date: Sun,  3 Aug 2025 09:04:33 +1000
Message-ID: <20250802230459.412251-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h   | 22 +++++++++++++++++++
 linux-user/x86_64/target_elf.h |  4 ++++
 linux-user/elfload.c           | 39 ----------------------------------
 3 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index aaf7b229c0..9acac275b8 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -8,6 +8,11 @@
 #ifndef I386_TARGET_ELF_H
 #define I386_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_386
+#define EXSTACK_DEFAULT         true
+#define VDSO_HEADER             "vdso.c.inc"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 
@@ -19,4 +24,21 @@
  */
 #define ELF_NREG                17
 
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x)       ((x) == EM_386 || (x) == EM_486)
+
+/*
+ * i386 is the only target which supplies AT_SYSINFO for the vdso.
+ * All others only supply AT_SYSINFO_EHDR.
+ */
+#define DLINFO_ARCH_ITEMS (vdso_info != NULL)
+#define ARCH_DLINFO                                     \
+    do {                                                \
+        if (vdso_info) {                                \
+            NEW_AUX_ENT(AT_SYSINFO, vdso_info->entry);  \
+        }                                               \
+    } while (0)
+
 #endif
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 8c4bd9a3d8..d924314679 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -8,6 +8,10 @@
 #ifndef X86_64_TARGET_ELF_H
 #define X86_64_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_X86_64
+#define VDSO_HEADER             "vdso.c.inc"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_GUEST_COMMPAGE     1
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 44fe1322dd..a017c2162c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,45 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_I386
-
-#ifdef TARGET_X86_64
-#define ELF_CLASS      ELFCLASS64
-#define ELF_ARCH       EM_X86_64
-
-#else
-
-/*
- * This is used to ensure we don't load something for the wrong architecture.
- */
-#define elf_check_arch(x) ( ((x) == EM_386) || ((x) == EM_486) )
-
-/*
- * These are used to set parameters in the core dumps.
- */
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_386
-
-#define EXSTACK_DEFAULT true
-
-/*
- * i386 is the only target which supplies AT_SYSINFO for the vdso.
- * All others only supply AT_SYSINFO_EHDR.
- */
-#define DLINFO_ARCH_ITEMS (vdso_info != NULL)
-#define ARCH_DLINFO                                     \
-    do {                                                \
-        if (vdso_info) {                                \
-            NEW_AUX_ENT(AT_SYSINFO, vdso_info->entry);  \
-        }                                               \
-    } while (0)
-
-#endif /* TARGET_X86_64 */
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#endif /* TARGET_I386 */
-
 #ifdef TARGET_ARM
 
 #ifndef TARGET_AARCH64
-- 
2.43.0


