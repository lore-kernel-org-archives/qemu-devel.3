Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC21C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLU0-000645-BL; Sat, 02 Aug 2025 19:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSb-0003f0-Lm
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:18 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSZ-0002Y8-5I
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:16 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-741a905439eso349253a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176574; x=1754781374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIxZZk/BNm2YTjKM78Vbu4/Y5hyqvqvxEmS8hrDowg4=;
 b=CIS7fs95ucTFse2UDlQFg9TdFPIgUfVEkTrDUxCWboalPiuddY8AxopC+073pdrje+
 m59nxWH6obkCeZwikqiXGCZmpX8MTxtJxNF+drQgQXNvX75eNfzx7wRQxGdfuoXfwizd
 qkKlBFgOfTI7ADgI4d/eHtCG9T+VqH42UBY+AfcFIdfNIAJnl3J6wzWhzPTFVvhdtYkP
 jQLGY2i4bF/gag58mb3r7/iwh0CSKXqI3PC4zDPWQ7pYLuxrglchZsSplmX+AjqAZyz4
 vHGi6EBs7SQiYBiGRMUGAtPZgyRNGLtrt4I9/WbEgIFRnmxIbD8fmfZpQV4ahMcEfrbi
 zM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176574; x=1754781374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZIxZZk/BNm2YTjKM78Vbu4/Y5hyqvqvxEmS8hrDowg4=;
 b=EcjAmojG886SCw3XNwU62ZGH4lD0UlWk+Ez1lUfZIT9G8QLAzZfsqMpf/zOXiKbWwE
 lt+TgHgP7C63ibSzvbjDbR0oZu/3lLjr3CP0JGTpHkHWkn2KJoN0W811ne5nRRVPoLUY
 Dfh+tt6kXsb61IqSuC+D519s/TPwhzwn5dBIDODRW2svBDe4LX6GJwZLyLcsADOoGUBJ
 Jy4NV0uU4J8CWCJni/3Ws+9ZuB3yyZ0R5ebLP38a30cI1z3Iowqm+GU4n3deogrn4Y9k
 2YXSW8h5LpwNm5Owr68xvclXxQQY16MooxVEYzY4SLgnB+nYmp3JoB2EskQzL+H7cJyl
 bQSQ==
X-Gm-Message-State: AOJu0YzlNaqb2h2IrfhPWWQNBp7apQagWcPWBF8gF4fZ11W7GsBbJQAK
 FccwhXBNmM6XhvCCGPT64JmkzoQFdOxhp9HdyyZtbU9fs4dKUR7rgplWrAb3zyYsCzYpajJjTLP
 I3BInrjc=
X-Gm-Gg: ASbGncuJzfCQ5ohk6CRjcYsjoztxRH4IUfC0DDwHMuHWTthM+odhbjmNRQPNjO2nMlt
 4NjbU4Vk5hPKdznR+YqJL4QheoMhDcLcvHqzm9jieVmynUNZvKMroe94Cm/1apSJAQrU5HQICGb
 mWefjaMm1PJlkUldz0g50/ydQGa41idCFG66AjEvwO504PRPR4LzwVM/G7JaXCQGE0RtklWwanb
 veGmIr8RJwvB75gqG61GwWBQxKYCgPmA9FiBqp2MQcF+gtBav3a7Q9kooTn7E8mjvhti6QWjDEa
 z7HoFTS7ZnLMbRH1IrP3IW8piFsBNriDZlym4pd/1DHL+BXEa4QBJxhv1N3hMVeoVdRXdJTYukl
 elO26KOdrK2xF+qHjljzcAg9VKfd2EG0Nm1irBzrShOFpbIWJ2SLX
X-Google-Smtp-Source: AGHT+IHUhxS8prYp0kK8CQ9ELrfc75TQyEeyCUnnPbXKPzcxqXYC5TxOkCr0Ygto7IF2QX3xlbMf7w==
X-Received: by 2002:a05:6830:660d:b0:73b:2751:eee2 with SMTP id
 46e09a7af769-7419d2d3e9emr2477035a34.23.1754176573977; 
 Sat, 02 Aug 2025 16:16:13 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 83/95] linux-user: Move elf parameters to
 xtensa/target_elf.h
Date: Sun,  3 Aug 2025 09:04:47 +1000
Message-ID: <20250802230459.412251-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
index f84fc9e6d1..011a77a1d7 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -8,6 +8,9 @@
 #ifndef XTENSA_TARGET_ELF_H
 #define XTENSA_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_XTENSA
+
 /* See linux kernel: arch/xtensa/include/asm/elf.h.  */
 #define ELF_NREG                128
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 82137e7f59..f6fb9926a7 100644
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


