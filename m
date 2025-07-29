Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E20C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguen-0003uP-K3; Tue, 29 Jul 2025 20:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJP-0004yT-Ts
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:52 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJO-0004hT-4n
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:51 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-74924255af4so5228232b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833888; x=1754438688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=51SXI9qij0/dgOIFVRy8/27FFUS6YEhrr91BtvZXKvA=;
 b=V2IBNwup/PyR63QC65uqf5hBY4j03tx9mbhY0p6BSKUquos+uXPQ3+U7fh3Kejh2tm
 uMsjCpBKX09wTmDk9WAYQeGu7vH5KC85z6tN3oRohSBiQjGvBgfjHmG3WfaAfMi1p4KC
 YRpWhpBmB63kFvGycAEdYDD4Hy7OqZ3Iw0DHhgW0MJcyZA+Qm1tAtN7mVdYq+jq4xp6r
 Osiylkn2rRM9QYSUSJLbg7dt5eN8JHliKdPAxkr5+bNGHrd1Ev09WfewrBe2kUYKclRE
 NaUdldaJgPDGaz+y+GpVyKweFSiVnOkNYlAkbijHl00Y1Hfkuh2n1CX+cCkmlUtttK41
 Pu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833888; x=1754438688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51SXI9qij0/dgOIFVRy8/27FFUS6YEhrr91BtvZXKvA=;
 b=FYtDSRvcG6ixy/s+f2O0F3k7NlliACFcXKZD90eriKOyS3/CqzfqTMv/xtHWmpAFdJ
 j50PKL5rYD9EUsyNQinuanLVpJZ86JAtMb6iOfPWf9ZdCcLT5luCrm6ZF2PgmjmihLLE
 tv/WjSbOLwvqgfifuEo4TdEqDsm+H6mw9q3RGozUV36HL7pZaYjB7nUpFEMMj+XF7+2F
 Ms1z6eJEU4X7Ibg1vrLa7uKEXi1fI4Gdk/zygZhRcKgL7S78IK82UGAesI8N17PI+OU1
 c/NCGC4fbJk9k7xqYIGtYxeR7d/WQ2gqhaufrtV6CpWz6yurtCm6/EZaYDb4yhEry+dG
 YeNg==
X-Gm-Message-State: AOJu0Yyxnjgwti7+Qkyw9iAgR2SXFmhH57JVE2CGKSfT9v73GIkDNIQh
 J7S9hWOTZe1IDgUfgwFdxKgLTv0ScyKSGjOfR1c5grlrZYOj+TY5PeagagVFzgW8e9l+ny462u7
 oOfho
X-Gm-Gg: ASbGnctSXtmgBG8DC5kLvD0lyd3ZiDPjN6q0/tPqLsOG4vx65YOR2Jj4dzq8uBvT5bY
 tJaGDIpdas98/9bVtS4X9RJuBlZcdUlOFhQB6FnQ96eFKs0eRYFTTD82B5H9YY/FF6naErI5baU
 qYrlHmFlDaiaPgSmQPrZF1KxN1RjpOJvbyChyGXFMsV9Bmt6uWTjqGvjfjmJsl9uZs0KWCo0f9t
 FRVddW8ZTyAXq14F3SmcWhHp2fnphxWbXh1HUjerwi8VcoZCOR1L310cGSsJDZ9Ez401zvgim56
 KwinAMiY2PDOV6Wk6Eg27ELvegVeX3AjQiyd9rA3zWFbAtUUWZfmZZoelOLOMB8klA/IQGJfuLd
 6LrFQ8BPNdUJFFnpaf6L7DyoOJy2YJBwCt2Gevdn0DR+UHofpZw/Wfqxxaub5R4aoVWCRSidT0Z
 xZRXZU8JR6+w==
X-Google-Smtp-Source: AGHT+IGvX0Z23xSVDbt0uaV8HAr3lrq1tp/vk7H6yi6fjwTBZ4S9TqCONocEqJsVvPtKsxV45ah5zQ==
X-Received: by 2002:a05:6a20:3d26:b0:237:b2ff:d1e9 with SMTP id
 adf61e73a8af0-23dc0d04459mr1831827637.5.1753833887591; 
 Tue, 29 Jul 2025 17:04:47 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 71/89] linux-user: Move elf parameters to sh4/target_elf.h
Date: Tue, 29 Jul 2025 13:59:44 -1000
Message-ID: <20250730000003.599084-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sh4/target_elf.h | 4 ++++
 linux-user/elfload.c        | 9 ---------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index d17011bd75..68b58beaa4 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -8,4 +8,8 @@
 #ifndef SH4_TARGET_ELF_H
 #define SH4_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_SH
+#define USE_ELF_CORE_DUMP
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a45d23b91d..38c5f2c4e9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,15 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_SH4
-
-#define ELF_CLASS ELFCLASS32
-#define ELF_ARCH  EM_SH
-
-#define USE_ELF_CORE_DUMP
-
-#endif
-
 #ifdef TARGET_M68K
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


