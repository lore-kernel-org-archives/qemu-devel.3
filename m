Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5624FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkr-0003Ep-Mg; Sat, 30 Aug 2025 11:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7cO-00053G-Go
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:48 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7cM-00044n-D7
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7722d6cc437so1102534b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506644; x=1757111444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxucZH2VlyVQTK5f+n6yVv5JTT2Ms4zzKCkkvcbLT78=;
 b=w7rjNtFFCJcJipiqCru+KGQrdHYmWzbRC75jsRpd3Pr4mfyRv2Qa9OHflqNaId4QSl
 LSwqhw3QdaVWeiRHCcjD0BmEXDnMyuP1eTeTqfJZgsGcQS3vmA/n8CWfoymXhyITtUzD
 wuGr5PbH326TL0nfdiqlF5qiQ6Qwj139ERFtSBf6sdexdiQ95wADYbLL1gBAcZYidcmq
 sbxnJHgqKnnlq1S8wNydL6dCnF7Z0U5W376B719bzPDEArPZn6rSPDo+c8KZ6Fm+E1Wh
 ASMF6l/heQ9yLMbGcHEr6NzTwteP19v583KsY0HDX/JvfdGciZgGejie/W4+NI3bT5Z/
 T0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506644; x=1757111444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FxucZH2VlyVQTK5f+n6yVv5JTT2Ms4zzKCkkvcbLT78=;
 b=iiLC19KjfcZwuykiazYWfVsvNsmYy/8sXWZLgx2OaCLj96drWqn/2+jKxxL+zabEzq
 3+e50gBEWhr/bGyApoGAyWhUz/MkXisgrhFX1eHo1Xd+Ff643Is7dhHPWr4jEo9m4N4i
 ghsJnVFa95agcVXBqVC205g0rKpmmK+GPyObZA0NUZeDjsx9/XwcScQHv0OsmR56+TgX
 5k6366EpO29BW9BNLv2hzRZ45fG1uFxcX62sZJ+qaIzHtfMad1VCHNE02HEQuTyxlDDP
 lTXHh5b/5HPXddjhvJkHvSvAiyBTUNNoWUsRCXIKWir1weoVTxJEWPZCsCAx+g2pxilG
 g0fQ==
X-Gm-Message-State: AOJu0YyV56kQ3bKtl/T/Xr941xZScGqLFBYBETi+O4RsRQ7KCNgufTkp
 AjtH0XnzET+8hvz7eTbp5yALVUJKLRmWINrg1QZaw4p/itlzqL4edRxnN+mBTItfgz105CM+Xop
 W6zBaDMw=
X-Gm-Gg: ASbGncvbz/jv4VccDsy0xQwZZen40f4eORXVY6y3VgeK/VcrH+WDYaGEZUpx9KYLPOA
 LmvHvgoCzLTmEmmx8I5m+m4cG1hj9HoPBLB/JVyFn8E5OvPfb99fbx8gCddylEL3p3pAjt6EDdm
 g3nwBqEWagn8K2qYwboaO15cNwMNGrBbTpBALssDehQFeGCP6OkfVe0Ao8NYFzDBod9K8gOTSId
 GZCjYiafXAQ2Mc4p4adO7p1JifdlboGWpMD8YoTTB7bRJsk7/fehs7sNldgzpEB+agZq/yB6bLB
 0o2+HTLY4qoPEFBFPKLuVP/SfFutJkRoG93UDBoclD2bO9/jxBtuANA8s37ABeeLh0SaF3zK0sN
 OwGPG1qiT7y0bT3lcAYbsYa+48cGg73KXJMV/71RSqRP4KVZ1rJWWdKiGZ+XAFMw=
X-Google-Smtp-Source: AGHT+IEsK57VTmdlAgmlhoPtyCsy3K7DE967cJwQ6bE19yvnQfmQAVuWnHKnuNOQK3diTe5/m4UWVw==
X-Received: by 2002:a05:6a00:4709:b0:76e:277c:32f7 with SMTP id
 d2e1a72fcca58-7723c504870mr642479b3a.9.1756506644038; 
 Fri, 29 Aug 2025 15:30:44 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 79/91] linux-user: Move elf parameters to s390x/target_elf.h
Date: Sat, 30 Aug 2025 08:24:15 +1000
Message-ID: <20250829222427.289668-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 linux-user/s390x/target_elf.h | 4 ++++
 linux-user/elfload.c          | 9 ---------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/linux-user/s390x/target_elf.h b/linux-user/s390x/target_elf.h
index 670c7b3eed..b23e46ab46 100644
--- a/linux-user/s390x/target_elf.h
+++ b/linux-user/s390x/target_elf.h
@@ -10,6 +10,10 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_S390
+#define VDSO_HEADER             "vdso.c.inc"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_CORE_DUMP      1
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index aff800baff..705d726922 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,15 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_S390X
-
-#define ELF_CLASS	ELFCLASS64
-#define ELF_ARCH	EM_S390
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#endif /* TARGET_S390X */
-
 #ifdef TARGET_RISCV
 
 #define ELF_ARCH  EM_RISCV
-- 
2.43.0


