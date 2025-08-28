Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319B1C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIB-0006QL-Rl; Thu, 28 Aug 2025 13:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXn-0001EO-3U
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:57 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXl-0000Lm-61
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:54 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24622df0d95so6543745ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383351; x=1756988151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RaHhTTN035qJQGqD9PdDzeeKvrzQJZLWIQNdo5Ia4sA=;
 b=q1htR7uuwCc+kxvZqp4vv0+8wY3CDL3nVtXa1B1HSZT6fxVZw9XFXFff+0YC4km1lg
 SzIcVJQsr3p73oVxp7cG62g0XjKT/inPNo2ql4XBgboHntA1wVxLKyRGMf1Kt3uxFwXh
 /LpUMUAbQBqeKqCaaMCkmpPhMgKIskE+HWxlxgK3sisPXywceZ5l5KTT/UHOQx2rtltU
 cLKl9Dl3k9zI90g7O64DSqNa5kCXCNKTaWUWIsgmlFIEtUquxKnnjFcuVy/mem+I+X4W
 FAoLrwoBqclFBtMNIhmjvKYJ1WAmqIpzIT1Nj4mUopA8C09plE6j7NLN1WtnJF2Aelh9
 dfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383351; x=1756988151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RaHhTTN035qJQGqD9PdDzeeKvrzQJZLWIQNdo5Ia4sA=;
 b=Nqf5epGUBvl3h0gy4XbLaUDkeJIe8cAAeJVEBx5AwnKQc9/b4v9fuXtmclKigYl6uR
 3NnEAFZfphEU76I2cJut/yZwXlIjAviNaUnZkwu40/I0wLgf9KVgMPzcSKQY2/eXs+5g
 R04GxwCJk+gtvK27xkU1MipZtbO3Uui8Tj9bFaCrwWKcRfu0wig1mV4E7vTTotk0MkjN
 MB+W9JN8VkEUVsbD/AE40l09DCBYmtojDGtTdCC7MKN6Bvnmu4SpSJ8ddsIIOPyqjJw0
 cx3qRFj1fX231e+LJnJ5/bJYT3XFrcWCLXBs4CmfARQWzP/CzOs5ssq6u/1fQn5/OInj
 i2Xg==
X-Gm-Message-State: AOJu0YzWvlqkhvSi3wryscS3j9A5rxqU6vGv95FpUK2OCu8GXiG75FbP
 8GLhIdmliEylHyYhfrCUibDT+QIJ6UWwt7GwJ9VA5+xCNVVsEk4MVD5asmXT6q0W3OW5S03TrvR
 Ei3PDhrM=
X-Gm-Gg: ASbGncscBpojIm5HYXtqlwkiLb9RFc7m4kAfXmEvu9+1edPwx5LtLKXPr4s4qUSNPI8
 ASru5eV1UE0tICROcINy8kubkpqbM8G5ZzyhQsQSTvjpl1xYdD73SFh05uTZZJF2GyvZNdJ3FME
 NHygQIbnukhN7iYvBqS3B5YYySRxe1Da4Tt6KfDsqr7r7WtdXht4f4fNkloVvcx2MQtcJjiLJu0
 n3RUs4bD30bKc59U95z7aGb2IHQ/SP8ZUAkV3j8KQMU4umQvmqrXv5izBFAZ9QyKuVPFjUgLpiW
 FBJ9jMH3GoGkiRnpcZdKqbDyzaO8eL+uFsDJ4uDiTVIOjJ1HZP7lY8aM5wZzrzyZaThJy8Ildhb
 k95dZkKr251Fuo74Ioum5/FWRYA==
X-Google-Smtp-Source: AGHT+IF/J8RuQWQuR2NAwtYk+P2OoN+rke7AxA//SXizpOWa83eusUr8zWx4z/NBCG7i7eBvwpCyqA==
X-Received: by 2002:a17:903:950:b0:246:7e1a:6bc8 with SMTP id
 d9443c01a7336-2467e1a6fafmr238356245ad.11.1756383350839; 
 Thu, 28 Aug 2025 05:15:50 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:15:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 78/87] linux-user: Move elf parameters to
 xtensa/target_elf.h
Date: Thu, 28 Aug 2025 22:08:27 +1000
Message-ID: <20250828120836.195358-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 linux-user/xtensa/target_elf.h | 3 +++
 linux-user/elfload.c           | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index 850a7206a5..0689e79be5 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -10,6 +10,9 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_XTENSA
+
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6732011332..804a819471 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_XTENSA
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_XTENSA
-
-#endif /* TARGET_XTENSA */
-
 #ifdef TARGET_HEXAGON
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


