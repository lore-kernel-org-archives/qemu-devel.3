Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66E8CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgDH-0004DW-Ui; Thu, 28 Aug 2025 13:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXb-0001AL-Bw
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:48 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXZ-0000K6-S3
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:43 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2445806e03cso9501665ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383340; x=1756988140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxucZH2VlyVQTK5f+n6yVv5JTT2Ms4zzKCkkvcbLT78=;
 b=xBcvlSTYPwXotFAdTT3DXG1XHzH2B1Bc54HRXeUvxbsxgcrPoXOyxK9lGZTAjibHDO
 630jCna041FNZGM4jwUP5xzSWK7byHaL9T41Dgxp9yYz2VsyHDPSxUkt9eAi4GxFpnrl
 qITUarbGh0SAnYTXcr855xTFXM5MTlIs9FRgKYE93fqXj8g928EEleg7nBDqwUDlAEVw
 SiQeLxnb2TsOuyZVOsu7JoiUJE/Y1DZY5ExZQfrZ9ejk8NG/qhKTcEUj3bD9ZIuE6YI8
 EWadmmEqqDiSEBxVS4AFomk1T+T+CUKO2ZyoL9HuuSBKk7cb+2p8edKlWv8nCjLz7fKu
 NI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383340; x=1756988140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FxucZH2VlyVQTK5f+n6yVv5JTT2Ms4zzKCkkvcbLT78=;
 b=BHwAr76aZmuqn+6OWQCRHJfO4+LYhF+S+a5V/6CC/Gc4tudECLaCeZ79BYl4WRovje
 wFwQlsC4COdBsJxGT5RxpZ77OWuhVIzLmewq/uCat9mqo7HwivzWSBrOcExyAjFAhuUN
 ZMt7BqooEPNGW71q6tkwU90oqD2rTad8jUQkoTbnoBedq54ANgg1as+GHHyk+07kvWK2
 G0w76aB9UI26JpJQ5O9sHXoo4W5eEGOhV88LoymvB1+cM+Et+NhAoErluj2m2GBXSriz
 aNDNga08/X8hvfBdwdUtNYTs1QmIvSIuePfguk+FEq9s43zyp/yq+53XB3e+FnUS4Ws7
 iAKw==
X-Gm-Message-State: AOJu0YzxufecGDN7r07gi7MklufQC99TcultNuf8CH2Qqhewf19vT0F8
 lKv0WamgFuqFWzpxQrut6cijkcdCfI2nF/x/dp0DbdMf2Zhs9l1TdnCPWy7FO5+/BulhhsdSigU
 xWmQRoz4=
X-Gm-Gg: ASbGnctaSqYep0la2WcVfsLmuMStH6461pgoXorxuFk7PtR2a4kTOvNpOWk2cZEZ1Tr
 8KhwSdGL55URXgnYIwsRW0lsIh9kURUWRyZ9zZgCaoX78svkx2MeX/Ee1qvGwRaYBd1buGHbAnK
 n1ZnE1mqSAUfEUDMfZURr4LMXwVd11jDViYNEhlY9vx/5nkT0xkwi7xHLqIhmkNthsfZCU4+GFh
 AeyYPq1jqq/BXoCcsaJB6MhilMdF9vqc+IdtIircJ8WxnnyJdaAyJX7R9+geEdYtkJO9ON3apa4
 hFct2YekiWlOIKs+TCMgfZyoGX+pOYMcL7SN5mJrc3KcbxR/CXO955OzjdawTW4yyrlD8OasJ/n
 mSKuqPIJj2rrL53Xd2NufrB4gHo1yH2ohchvh
X-Google-Smtp-Source: AGHT+IEFwL0CqF+D4i24xUbyc6QNoa8gfFhIFdfj/lTdshy/RoLxbO+L3+oRMS4C1v71yzu4LFc8Lg==
X-Received: by 2002:a17:903:4b03:b0:246:cf6a:f00f with SMTP id
 d9443c01a7336-246cf6af34dmr192721815ad.31.1756383340014; 
 Thu, 28 Aug 2025 05:15:40 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:15:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 75/87] linux-user: Move elf parameters to s390x/target_elf.h
Date: Thu, 28 Aug 2025 22:08:24 +1000
Message-ID: <20250828120836.195358-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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


