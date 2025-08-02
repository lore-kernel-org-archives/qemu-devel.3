Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5211BC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLP9-0005bz-4U; Sat, 02 Aug 2025 19:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOr-0004Fj-3n
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:25 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOp-0001sq-HC
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:24 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-433f787057eso432184b6e.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176342; x=1754781142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9KQfwAxii2oEHvk10Z9N3J74RVGe8CdA10oQJ2nk78=;
 b=zAYPj0N5jF1SGV7J9lOQwxWA0cwT+yji8VuddcP44c2ZFzUzGMEzQuA3cZoW4pWwoh
 7OLTstpxo+Zt1IK0gDXuGQZiGb9ms178RTIb399fnKi5y0ti9p7o9blUoeN90SJzkIwW
 7/AE6lRjxsN1s+inSmq8jQt/0fIxoKDGRHsB8vU5YLqGUlmKvOhYAiJCBsC1IDNUEG2K
 edLYZrdZPmD26dN3NqBIt0MfiI3+UeAWr6xl8hVUdfzz9C7J5DS8pvkKHicZC236NWSN
 TfaYsrXV0RY3SRz5qVKByLSjqZxzopm5TzlhQWHKRDrDV1QRvIPLXVq9u7lfeQDTZbXg
 kICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176342; x=1754781142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9KQfwAxii2oEHvk10Z9N3J74RVGe8CdA10oQJ2nk78=;
 b=CcCp7LyAH+JNx4rVfDtCOuI5Ch+v0v/NqyD7zr5PqZBVrt/p/E9uynYUVlqqvos6zN
 sz+o+lmlGxBwWhtXWPAMJu7DuGjgVVrFn9WStzM5nmLUGS1yKx3Y1HzFMlTMmYVD6mQb
 LpXgcXpqCkJqLl2BSoXQXQj5XmI7oFXjyi6aKpYlnZN07Ckoi4r66fJljwTjYxvhSkPq
 lSQ35Z+9MQmSDYg4ctCB+4J0O4eT3fjQEuwbiUEqS+Iavnj6IK2ay2nUowlwSilmMNRM
 kqk0n0kNWdIcg79V5At5S/Cb4dqLg2QeBxZM9AwgcjEWdPqDFwfv5W9c061CIMx1hZcb
 r7Dg==
X-Gm-Message-State: AOJu0YxUfTcOXD+1e4FvarjOng7ekDMuAeaGkIQvsAhZ8bPdonp6E+Uc
 E05C58ZCoiEyBw/flxHenIPWLVYgggs1xEzZZArvngWaYhyNN46r5lhPcyLTX1OV0b0X/AenXKx
 t3ciUulA=
X-Gm-Gg: ASbGncspv5Qcxcjg1O48l6XEelE/aySSuCU6UrhD8jJDRlWovqNXhFo6ACfH1umGzt2
 acg4G9UTrYYb5NeWYcddp54xHWLTiifkOC+vd7v+0VYaTzOHXPJNRmAWde8aDp9FFf+GcUbEFC6
 hTzKxjNoHdWXivbX+E9Du9paG3m993aqIkMkXu70077eAaKPrZIDkyNNJChmtvNTL+3/QzNMmry
 6iHmjFKdVOIBioKM1T/MeRTN+ynYNOyxpH3ns4VCTKUf5PvDXK1Vr5UxuB/mOKtGUQ4L/PM+pX8
 QZzYxNFv7tG7hlgK4ScypPnCmW6ZCmXZuPZeHUA8XRf8pLwezMh70vb9MSa/lgwgRqkQb3icaze
 1I8vwNQGEY16UCF1SGHCLNrkeMLd0J9P+NZrX92IYl6MI06rYL/Pl0LsZ9ItmccY=
X-Google-Smtp-Source: AGHT+IE3viSk3ChLHSxM4Z/qkDeye+btXPS4NBS7MNCsqxxgMe2PoLHd0gcdrJYUeLMWOl4iyqSJKw==
X-Received: by 2002:a05:6808:68d5:20b0:433:fe6a:e879 with SMTP id
 5614622812f47-433fe6afb41mr637583b6e.36.1754176342413; 
 Sat, 02 Aug 2025 16:12:22 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 71/95] linux-user: Move elf parameters to sparc/target_elf.h
Date: Sun,  3 Aug 2025 09:04:35 +1000
Message-ID: <20250802230459.412251-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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
 linux-user/sparc/target_elf.h | 11 +++++++++++
 linux-user/elfload.c          | 15 ---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index b7544db0a1..f89c708c46 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -8,6 +8,17 @@
 #ifndef SPARC_TARGET_ELF_H
 #define SPARC_TARGET_ELF_H
 
+#ifndef TARGET_SPARC64
+# define ELF_CLASS              ELFCLASS32
+# define ELF_ARCH               EM_SPARC
+#elif defined(TARGET_ABI32)
+# define ELF_CLASS              ELFCLASS32
+# define elf_check_arch(x)      ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
+#else
+# define ELF_CLASS              ELFCLASS64
+# define ELF_ARCH               EM_SPARCV9
+#endif
+
 #define HAVE_ELF_HWCAP          1
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fb1c125566..e321ff3d14 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,21 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_SPARC
-
-#ifndef TARGET_SPARC64
-# define ELF_CLASS  ELFCLASS32
-# define ELF_ARCH   EM_SPARC
-#elif defined(TARGET_ABI32)
-# define ELF_CLASS  ELFCLASS32
-# define elf_check_arch(x) ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
-#else
-# define ELF_CLASS  ELFCLASS64
-# define ELF_ARCH   EM_SPARCV9
-#endif
-
-#endif /* TARGET_SPARC */
-
 #ifdef TARGET_PPC
 
 #define ELF_MACHINE    PPC_ELF_MACHINE
-- 
2.43.0


