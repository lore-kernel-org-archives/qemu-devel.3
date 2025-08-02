Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C0DC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLSy-0003nn-IM; Sat, 02 Aug 2025 19:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSX-0003d3-F5
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:14 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSV-0002Wi-Q4
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:13 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-741b1fe0d43so13517a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176570; x=1754781370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIssYzEBlpkGHd5iuJ42OMntD/yk9ZyACqlB/jV8zZA=;
 b=T0sPDHtSCbp7D+kB6sv1ySC5zdH4DFO12j/NhFOdmPjOS6b9CdBZzOhXJdXB16S6iO
 F3dr7CvVVrOBe6yzAJoia5mO/oK1tpzSokB3bzqrg/oFcJwPhVRfK0G4vHe1eUYrJDsw
 aBXdyxAC9Hl97XG4cPRbmPdirKWUTUkC3pFt9y7Qx6MZ5y+6D5w3IKl+Z0ituubRG1/N
 681a31wgTqOBuF6UPqTQ5sW5eVm/GVtXtjnurg3QZzuq+yVtytMlGoI26SyL9yngdIad
 KhzpYeYm2YAJCqXQZv4xs53vf3xKUxSX3ZnEonXjaA3nROLaP3yPmtLFrAbTkyJfoYwW
 //oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176570; x=1754781370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIssYzEBlpkGHd5iuJ42OMntD/yk9ZyACqlB/jV8zZA=;
 b=IZQxvHSlm8iL9m8C4rXanWXL1QIkemhQntlO+uTQ5J0BMUoR0y5jnj103TNvfRrsER
 GwOWGeS0dPYWDh3xb/0AlCJlJiYcv0RInvSeByuZtGu7b/Gr+Zyht7UcmMEnIhFOuHTU
 S/1jlTe4T1GoVeKu6mDLbruGdYJ/NVYiVLCPORPRq6dnLCwAruXaVc5Ad9OcsThSjo1L
 xb6ScgVkKTHJ9DoJzsN0ZfmSRetYXgE+UHcUgn37DKHdvi+NW6OR4sU2cSVpMTQ73IlF
 YiYcoOaFWigMImyqBR0q2mAxOGAq5TbKyYIxCBRDUeuz2ADf3clYMxmpfibeMp6yxrgA
 5ssg==
X-Gm-Message-State: AOJu0Yx403DsfpNCkVKn3tQZ0ATOv8jnZuRkK0BRSCFwx+V7uIOkdhpI
 6IuXIKEGZbkqGN5Hr5sTYgOkpb9dyvPyGa16+UaUumPGhyrTauO7XS7H/iaA2sVYvkz2HX2j7t3
 QkmIkg7E=
X-Gm-Gg: ASbGncs81A6gJIR6RI1lGcxzaPKz/KgRxSL0I2NLCVQ7d4Da/8cfsN9+HeVGMvwHU1V
 Z/WUgVlaU2hpDiQEfoT9C9HHY/qB/Ix06TqFu/71CYecU2WLGuvBPB7gJHjzUSZtDYNECPrrXYz
 NK8QSIUmuWLBwhfInLhICqEVUr3wv+qlvleGnh/tuQW8/Ohq2WZGws5zK0Og2fK/GsPkFE+Yg97
 WNr6FNGOY8e0Pd4zodkT3ov8hSWIYtZI+cNjxWhG6YSn6/TmD+JY63voTySGToSRDbITRpHOGen
 H2SPg6qiNCT1/gtx1b3Ep1HRP36LygnornNiZo04O3YLmN8SayoVqpIgrrnqmQpcMi/ugTWnouQ
 aasttTpLJk5wcaPKQzAcptCywRYR0navINq7+uz0dkswftiewdwA6xDgaF6W3oOE=
X-Google-Smtp-Source: AGHT+IE+Zro4G6u69R8u3JF4fCoE/z0bbsY1R3JEXKACFb0vJ0oLS6hHcXHZ0wE/y5QlGuiO2ExseQ==
X-Received: by 2002:a05:6830:43a9:b0:741:90d6:710e with SMTP id
 46e09a7af769-7419d2b5463mr2376755a34.25.1754176570409; 
 Sat, 02 Aug 2025 16:16:10 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 82/95] linux-user: Move elf parameters to hppa/target_elf.h
Date: Sun,  3 Aug 2025 09:04:46 +1000
Message-ID: <20250802230459.412251-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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
 linux-user/hppa/target_elf.h |  6 ++++++
 linux-user/elfload.c         | 11 -----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index b654758afa..9b6363a0a7 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -8,8 +8,14 @@
 #ifndef HPPA_TARGET_ELF_H
 #define HPPA_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_PARISC
+
 #define HAVE_ELF_PLATFORM       1
 
 #define LO_COMMPAGE             0
+#define STACK_GROWS_DOWN        0
+#define STACK_ALIGNMENT         64
+#define VDSO_HEADER             "vdso.c.inc"
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a0b9454f15..82137e7f59 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,17 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_HPPA
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_PARISC
-#define STACK_GROWS_DOWN 0
-#define STACK_ALIGNMENT  64
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#endif /* TARGET_HPPA */
-
 #ifdef TARGET_XTENSA
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


