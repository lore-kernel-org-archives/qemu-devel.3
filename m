Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483DFC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIH-0006l2-4D; Thu, 28 Aug 2025 13:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXO-0000oF-6T
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:32 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXM-0000Hq-Ld
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:29 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-771e15ce64eso711758b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383327; x=1756988127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lowHNs0QIQ4pb8gQYo2rhZhqRLDHpO1LE/Cpq00H8f0=;
 b=uWneUh1HlC+pW++RO++HCgOc7IJHg9S/GwdB15yZyAPuVfBUwHDeqqTrdDI7qqS9mY
 ac39+ArI41pTFBMweBdAnoLl0ig5JZFK7SZ6FpyOWIfk5JRuoCDOFpYjMiq200/46+Eq
 bmdEe0cApiE05Qh1mKIOe75iU4nZQNLGNVZDY+OIZZqaeLzMHvB7tR/m2qNPlms5goD8
 JwffUAYrIVDivv+h1bGXkjpZ0+m7XsgfDzj00LkpBMAdKMyhPTWn+JxiwpJgwoSve/3Q
 lu+uMvOHVDLjf+alJ6Tc33uZqApxyJwBlDAMcB0UadLjTAKff6y9CP726CywTDRh3Aim
 c4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383327; x=1756988127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lowHNs0QIQ4pb8gQYo2rhZhqRLDHpO1LE/Cpq00H8f0=;
 b=uaIQjIhTYObZPZl9tujxFc/B1nDF37a4JVj0e0ERC5QKsbQRlC77ni1uuEUlj3903T
 cQenc089JUHMXMPMli3XXBHK1PpNnLof47GXeDRrm6V0cspRvD4gy3LOpe0EC8OmXAzY
 Q7vFfZyumjj2jQoVy/4IjJMVpXF6u6+9jsqtV9ugTA3+Bn4wFz93sPYuK/El13yjmr+n
 48KGTGlQ3GhoGWL8hA04JNa1JtboTB86aekp0wkmI2NyI4SgdZyVab3K1se5/YiorKXb
 NZ1S/h2KFkR5nxaaO9bfRE+Kuofg2y8s3jhzhvszj3j3/ZImTl8Bdo7ojvY7SYN40E/D
 o+Mg==
X-Gm-Message-State: AOJu0Yy6pFelwY3XmHd+jCo64QiHFmAHh36Y7BIjRjfONNHL2+3iNAyn
 3Sj2gsGNtu3uF6ZLI8P877fEe1USD3hr5LJMDMVEA3TBauoBHNWDUMah7YME/L66qoZh05PUYxa
 rM+MpRyM=
X-Gm-Gg: ASbGncvJeYLkiUaKuGOXpFvbwxkNZIL8EwxIoPGYKvZi1QSC046q4rUTq8fgIR0bTE/
 0FtO94qTJRPMnv1MyPCGctt9Ol1lT1lH+fAOhc3CeG18VsPRpZj3TTw5L84y2oTY02ipKiwSPJu
 Cqgu0DbTZ8KM2A65kuAZzi8zrBuQojVmPINocYNB01wy7cFakmt3cSBT1wYzEYtUZa2Ubnu4sw5
 Cykgq5S+XBe6GukCtplAMuULbl5PWp1LwcuHtxiQ4SZ5qJ9hgm4G5rVxXsUNVUgPCGOQt43ndjO
 pTaIGGmrHyk0O2mvVK5OrKN7e9LGTtHpaCYZqsh1oimQe7TfDKGRPCq2K8qzce44FmOqbQO/nSc
 Do3rDW3AB9oQA+4Z7iQ4gF5zG1w==
X-Google-Smtp-Source: AGHT+IHm7zdCBfKhvU0HB1tUa+KNHUV5oeObCpj+hgDEANE7ToaTCcOTZu2JBu6sT7iJqzsv4iA4eg==
X-Received: by 2002:a17:903:3bc6:b0:246:e1b6:f9b0 with SMTP id
 d9443c01a7336-246e1b6fad8mr175295405ad.18.1756383326570; 
 Thu, 28 Aug 2025 05:15:26 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:15:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 71/87] linux-user: Move elf parameters to
 openrisc/target_elf.h
Date: Thu, 28 Aug 2025 22:08:20 +1000
Message-ID: <20250828120836.195358-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 linux-user/openrisc/target_elf.h | 3 +++
 linux-user/elfload.c             | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index ad80e4b41a..ed9739380f 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -10,6 +10,9 @@
 
 #include "target_ptrace.h"
 
+#define ELF_ARCH                EM_OPENRISC
+#define ELF_CLASS               ELFCLASS32
+
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6c8771d804..d0993621c1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_OPENRISC
-
-#define ELF_ARCH EM_OPENRISC
-#define ELF_CLASS ELFCLASS32
-
-#endif /* TARGET_OPENRISC */
-
 #ifdef TARGET_SH4
 
 #define ELF_CLASS ELFCLASS32
-- 
2.43.0


