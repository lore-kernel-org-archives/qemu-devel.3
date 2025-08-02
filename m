Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5677C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLP9-0005c0-38; Sat, 02 Aug 2025 19:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOy-0004bj-03
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:32 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOw-0001tp-BY
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:31 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-615ee07353bso1761478eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176349; x=1754781149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKnoobLYhlsWNDmOql8BCDTejxT7XKGUYJKu9t1JMBs=;
 b=rsWPSNv2lnQn5sLg4iNBzG4Dx8qUlr7r9iiLTrCG5PQ4n1Zg2X6lmQrAKworRg2KGM
 Ae1kmHMmsjKxhqFPP1SCAauM9HBYmH5DaI9Q4tvfpTeT4A7ba02/mmUg1gmWX+OqsVkf
 pMF0ZBczNc6Nn9MEraQtGEBfGOjyza/BMBiYQQe7wo5VagmJqx6vPpqmT+vdYKkvCPTv
 mmN04aIPL2oy+pdsNsfl4QkF4+TXdVIZ3cqKyJux0giMxJsMW/y/XZAG26PYoYrwTCSS
 9vt+NS6KkDFTrrxvqtbNLYcP75pljkLnOy0DCuRE0FD+527HjX7cc0X4pM+5Su5qg4Oi
 xHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176349; x=1754781149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKnoobLYhlsWNDmOql8BCDTejxT7XKGUYJKu9t1JMBs=;
 b=D8+TGzNtPNRxnkaFdU6e8MyWiC2NO+IutcH0zXZIFNBG3EUkbyA0RMIq/oY9Qgr/1V
 pqSCctifTroicPUKXo7cck6hVKQDcbRw3w0DeziNRKwa1SSC5cYlgXeW7nWHd91PJ00m
 dOy3mkNU49Htx4v7ufg1Px+GmsGBF+TInbfr5kxClNnGHp4wMTwwoGu8okYtOORLNIV/
 l2yeu2sza5G3tB/j+44uQ3VtJfB2aMywJOSgwS1dhau2/53cGCP37Tv4SjBRG+wvZkpU
 B4bffY7QubTXFVml6WhGGeWhXn3pXfctscj2SSJittJoLd4huXVzNOJuanhRZsZ6Y8C/
 rWmQ==
X-Gm-Message-State: AOJu0YzkDIs6gE9tWuoahHwFufIy/3S1fLwm/CJp3EvSujctjWWpW2KO
 u+4xmNmymTAbtAogS/xqJ3xpGsIIY1PaufzKr1yTgETV5+leKoYYD5aziGrlPIgbacVS4GVUKoc
 2zsYqCrw=
X-Gm-Gg: ASbGnctqUsfOc/LJuLS3NSQ3TDKK5lg+txHAMSanCkeIV/FqaqzzbSKLcf33tVneti8
 HDlSCF7wNOrLid8g6hj3wnuVuqaHL2xoy9YojN+z/XQP8ejDGoajxfQmfE3DRAUsWr6mg+RgvhI
 rlHcJxMUF4xYtfWZy3aMAhZFUvOQIrsSM9LSQ5e2gU6Bi+pFToEbCeEmFSZlLWVwfq/3oWXprL7
 ol57XJrG4YGKaRqZ7yVLu84pNzroXyQJ+XuBCjnHNwV5p5eYGz5Ony7ImFyWx5oCPF6bmiRKVEy
 eED5VggyJAjd+HrP6a0oCBmg9AbhSvmOKWe6kHvcGq2MKuCRQRu9xz9r0Hh3yQIwthAO4iKdqMA
 vilJigEGUX5iIWlyxaEl4KHXaXwfR2hTko0mZoVZ0k2PFNycht6aWwobKJudTPvA=
X-Google-Smtp-Source: AGHT+IG6SUw0hQR/eRE14mCd0ZgFlV4XdWsRDoVzu2mk/2hHKUAhGmTdgHk1jPhCBCZSeOINw8jY2w==
X-Received: by 2002:a05:6820:1b18:b0:615:b6df:4faf with SMTP id
 006d021491bc7-6198f2556b4mr2887837eaf.6.1754176349148; 
 Sat, 02 Aug 2025 16:12:29 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 73/95] linux-user: Move elf parameters to
 loongarch64/target_elf.h
Date: Sun,  3 Aug 2025 09:04:37 +1000
Message-ID: <20250802230459.412251-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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
 linux-user/loongarch64/target_elf.h |  6 ++++++
 linux-user/elfload.c                | 12 ------------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index f2d00c9232..e121e409d7 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -6,6 +6,12 @@
 #ifndef LOONGARCH_TARGET_ELF_H
 #define LOONGARCH_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_LOONGARCH
+#define EXSTACK_DEFAULT         true
+#define elf_check_arch(x)       ((x) == EM_LOONGARCH)
+#define VDSO_HEADER             "vdso.c.inc"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1a24dfee7a..6b0d73a6f7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,18 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_LOONGARCH64
-
-#define ELF_CLASS   ELFCLASS64
-#define ELF_ARCH    EM_LOONGARCH
-#define EXSTACK_DEFAULT true
-
-#define elf_check_arch(x) ((x) == EM_LOONGARCH)
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#endif /* TARGET_LOONGARCH64 */
-
 #ifdef TARGET_MIPS
 
 #ifdef TARGET_MIPS64
-- 
2.43.0


