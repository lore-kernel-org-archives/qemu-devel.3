Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4291C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLTX-0005Tl-Iz; Sat, 02 Aug 2025 19:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSo-0003jD-Jx
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:30 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSk-0002Z0-Ns
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:28 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7419f3428c9so267032a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176585; x=1754781385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mRFMQNgreHFfZ4Otx/nnJzKCNGmCt4FhqLze6+sSgz0=;
 b=YHY6vRrtQXJZimJ7eLWm+RhOzzvSuw82gXsBbsFM5Zhx+7ZJSOWbiWYTB4KqZ3jBMt
 a1MgyfZjI0h/BI9VXUstZdL9IjwiGatVq2WgE+ChpJnxRhxJyZ+16ONdTqxSvlYEX3qr
 U4M20L++dkeq1nup/RXVNdQkYUxlvCw1fEK6V4cw//dlC6L3QEk4b4/0iV9+4ieElbiN
 VLUOfemyuhS2reWfiNAuYIEGyqZYca3aR3aIUEUacrqXp8NYWd3C9H6HSSJHGoieDxDP
 tFX8bGNPTBRAeb+2zr0QmxDHN5q5bOYxBmolt/Vs4vNAGRQSsUFhAX16NEcWxdrRvMnP
 xanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176585; x=1754781385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mRFMQNgreHFfZ4Otx/nnJzKCNGmCt4FhqLze6+sSgz0=;
 b=ENmA/GStwnvhg3FKjURtnuPhc3mX2xVJl6uk3UA22qUcEfzWwHewrXl/OFUlMC+wKU
 2zE130Ta0JPtcl8yumZS2B0osnFosDeOg5P7co/+AjCqGUceq3OkJJ8FokaoA+Wn6i5Y
 C8ppboqrwJNQx8c7TWSquqlxR8xB5jcpTM95CMdi/l0gHcxqwBWWFa5RQQyQBxPXBeVw
 z59M9ZE6lrydxdQLG2EWLdXjtmre8xtCp/lcvvft+ONvEfhWMEw3HLG6lgMumA3RKhgE
 VMmyZh+qaJQYfvb2pIFDjagkb86gkgZzQSW+1AdDEJgBr0e2Wu5a80OylO3GJYgipOAl
 GH/w==
X-Gm-Message-State: AOJu0YxoT8mq4M2PGOj7UfBiplyOk9J3ac5LBJXNgu63o+So+pSuECJu
 UTFn8otbuDLOZ18uyWi14iCFqA+L3pFRP5e50eFTwVbKI+CbiOAMT+ChIjtHZe4HJTNGpUuViFb
 9IIqsJ24=
X-Gm-Gg: ASbGncvbehUK/GJne0z8Bo2nTx1u5rbj2RVDiw8vIGnZPSw4r0HS39FXVv5UjZzreG9
 18/IbS/zZXwuKvyJj3EOChCgVw6Te9sllIhoU3Er+uPxUi0fguO3EP2CVemIryHHUv+WqGgTW4n
 E2wNTWXfFQitH+M28XjfB5aoe/JFVL/jMot9lsA49GVwCtIWeeZGYnxUjiVbVTDsIYXxYW+o9wX
 3GEjAqxoLYFav3PyEjk9zaC2Md7rl5MCJddgr7zBds2rUohqHtjpAQpEhvU9Pu45TgRlcMriOBH
 /aP1YjDeLUlawsEq88s94wqYpZLfvUcJ+evn1usULDwlQIvGifr24rwzAc3IVcj5corFkYoPZyt
 zhcPvxhgWA8gRyIoY0xucOxWdNtPEUT3Mhuv7W5yh5e619NglLiaS
X-Google-Smtp-Source: AGHT+IEGgFF/02DoWdK3Ao+VchyekB+WkkgDmnAiZEp9LqjfuBOQKGW3aK100Y0t1hBBu4Ltz2tC7g==
X-Received: by 2002:a05:6830:2b10:b0:741:5d00:e86b with SMTP id
 46e09a7af769-7419d093f8fmr2450224a34.6.1754176585320; 
 Sat, 02 Aug 2025 16:16:25 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 86/95] linux-user: Rename elf_check_arch
Date: Sun,  3 Aug 2025 09:04:50 +1000
Message-ID: <20250802230459.412251-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Rename to elf_check_machine to match ELF_MACHINE.
Remove the unnecessary definition for loongarch64.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h        | 2 +-
 linux-user/loongarch64/target_elf.h | 1 -
 linux-user/microblaze/target_elf.h  | 2 +-
 linux-user/sparc/target_elf.h       | 2 +-
 linux-user/elfload.c                | 6 +++---
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index bfd0040a79..6ca3740410 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -27,7 +27,7 @@
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(x)       ((x) == EM_386 || (x) == EM_486)
+#define elf_check_machine(x)    ((x) == EM_386 || (x) == EM_486)
 
 /*
  * i386 is the only target which supplies AT_SYSINFO for the vdso.
diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index 93e71dbb16..f05bc68898 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -9,7 +9,6 @@
 #define ELF_CLASS               ELFCLASS64
 #define ELF_MACHINE             EM_LOONGARCH
 #define EXSTACK_DEFAULT         true
-#define elf_check_arch(x)       ((x) == EM_LOONGARCH)
 #define VDSO_HEADER             "vdso.c.inc"
 
 #define HAVE_ELF_HWCAP          1
diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index 45146ae102..60a495c4ba 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -13,6 +13,6 @@
 
 #define ELF_NREG                38
 
-#define elf_check_arch(x)   ((x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
+#define elf_check_machine(x) ((x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
 
 #endif
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index 6b0cac3caf..7827767bcb 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -13,7 +13,7 @@
 # define ELF_MACHINE            EM_SPARC
 #elif defined(TARGET_ABI32)
 # define ELF_CLASS              ELFCLASS32
-# define elf_check_arch(x)      ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
+# define elf_check_machine(x)   ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
 #else
 # define ELF_CLASS              ELFCLASS64
 # define ELF_MACHINE            EM_SPARCV9
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3343058865..135c4f319d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,8 +130,8 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifndef elf_check_arch
-#define elf_check_arch(x) ((x) == ELF_MACHINE)
+#ifndef elf_check_machine
+#define elf_check_machine(x) ((x) == ELF_MACHINE)
 #endif
 
 #ifndef elf_check_abi
@@ -346,7 +346,7 @@ static bool elf_check_ident(struct elfhdr *ehdr)
    This has to wait until after bswapping the header.  */
 static bool elf_check_ehdr(struct elfhdr *ehdr)
 {
-    return (elf_check_arch(ehdr->e_machine)
+    return (elf_check_machine(ehdr->e_machine)
             && elf_check_abi(ehdr->e_flags)
             && ehdr->e_ehsize == sizeof(struct elfhdr)
             && ehdr->e_phentsize == sizeof(struct elf_phdr)
-- 
2.43.0


