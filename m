Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C2EC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLPJ-0006NO-R5; Sat, 02 Aug 2025 19:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLPC-0005sB-3y
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:46 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLPA-0001vg-G6
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:45 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-433f78705feso215186b6e.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176363; x=1754781163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfym8zML+0wdkKsMmu1OiESY4P7K8MowokUWQbtFtAI=;
 b=o+32rqVDLCCJGWKF93DEldWGaEHI21fVt5q1dyRiIN1xCVY/GEKZ/FYAE0pVvW2zCh
 dQJssGlyL8ihuZxBBw3FnaY88A6cSuZyB10JGjRcUmjUgx058L7Myvi+uGA3C6zKeEZZ
 OsBHi9u3oP1S76IAcAdYA2mX0ByRbp1RDcjWDQ4ah464K1P8rJIYa4BpmZxQ0BNlYoG3
 rub/h3kS5vGyibX1o5o+V+xp0BicdGIS5p98a80qjvw1FGfyAHKvAroYnsVrGlwPe3FQ
 q8x0i8SLBum6vfTwy0ICQ2pwcEOsLvokE69X8cAnxZydApfxDTQY8FtrlapqWeoRS7rJ
 TRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176363; x=1754781163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfym8zML+0wdkKsMmu1OiESY4P7K8MowokUWQbtFtAI=;
 b=xIDzNOX9GgD3iBP4X0QFkppGLkopPj3qWMNPy5eMPmn6JHYnv0I5PvspQHKd4bRVLH
 N3EqhYr/8KV8xJpE6QaiJlIgEndRajJtzPnyjjMNlyaGd2EcVTstE+3MgQ+ELipRRtNq
 Y15F3A0P6MDbPX3unly3KVOl3JSB4j7sNJbmIWvfrNok6a1/Byd0jBXwDN2C0TxTdWrn
 OOUCyG/nHyvvC5edumG9a3wZjUohZ8D2Hs4o01pT6S8vY9dRZy1L+hOnjAXJyrfSQsLV
 k7W2qO4DvhcRRx1Mb090hS9gkW3dJHdblqSSCsdbyLcvT+/J2FrcvEg8DFGqJxRbwQkg
 MTZA==
X-Gm-Message-State: AOJu0YwUPEZPx1DxgQzh7kJW1sUil9wlET8KlaS9iLFUa8hYR1KZja5s
 ixy5d0KZH6YFHQpF3E8XL2/GLhh4Y6vIoiFX45DPPpALWYoVf58IEATkgXxR91yH+b6pG3+bmXB
 Vpx1XCV8=
X-Gm-Gg: ASbGncsuAXQVkqDeTWrSejl0Xadtk0wyQaLYCPdl3j+KyRhjbqQnM5JaP+pd6EDcZvt
 K0EvM2bZSHE5qUNzvHz65GTIaAlHnAEXZMrjcFM9Dit56NSZ0swyQae1CuoQromOvo6r8857/26
 T94IyPyVrVpVKxSApBZPPCRsLAGWZbFf4YRAj9mRRQ6jtmElwc+6qwifkebfua/Z65tzcDLXrVO
 AI75lpQpAqfW/mP4pBHhtR2dlp2TlqWXG1tPs6uAMEekBY1UN1aXlVxIr6pdryLG8BVxKHJtvY+
 Mj4Tz+hBDPbMmmAhExKpoFd6GQJ4KQhkHTSsHc9PN6nezDkXd75lrrOtzi1UXLmLRsz/fL7QHee
 p+NH+D43cn3KyHj0Eib/P4EsIVsCkz9/kT15ABuo43100iTsnjvFj
X-Google-Smtp-Source: AGHT+IHXCa2J7gJTwbx8AYgi+VFIUcZBIfzruZTCuv6/ZiSSu90zFc9ZATpx3g7FGv0UCeLyRJVW2g==
X-Received: by 2002:a05:6808:144a:b0:434:2f0:2e0e with SMTP id
 5614622812f47-43402f02efemr280326b6e.29.1754176363019; 
 Sat, 02 Aug 2025 16:12:43 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 77/95] linux-user: Move elf parameters to sh4/target_elf.h
Date: Sun,  3 Aug 2025 09:04:41 +1000
Message-ID: <20250802230459.412251-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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
 linux-user/sh4/target_elf.h | 3 +++
 linux-user/elfload.c        | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index b0f1ece1e9..b305cac5b0 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -8,6 +8,9 @@
 #ifndef SH4_TARGET_ELF_H
 #define SH4_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_SH
+
 #define HAVE_ELF_HWCAP          1
 
 /* See linux kernel: arch/sh/include/asm/elf.h.  */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 368c7be0e3..fd3bdfe9c6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_SH4
-
-#define ELF_CLASS ELFCLASS32
-#define ELF_ARCH  EM_SH
-
-#endif
-
 #ifdef TARGET_M68K
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


