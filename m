Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DD6C10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uxj-0002kl-L2; Fri, 03 May 2024 11:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxi-0002ft-1S
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:38 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxg-0002io-9o
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:37 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51ae2e37a87so11228868e87.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750593; x=1715355393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k1ZHl3KtBDD8F5IDAshvr2j1UwCpx77YSs6aZ7LDCz8=;
 b=zuFBYJ5I4l4nXNTz3+RHdYe5A3Fuv8M8MnFCzWidfUgfdOm/c6mipyReBYp2Q6IIQw
 F26h/FlG+jMLpT+7i7BrX46LWY32HcW4fJX9mAng9iydakRZMcMayk2TicnE/kdzdgrH
 dWi0zm6BIMAO/6eT+bhGZYuEIIL4vyuV77CsbGgnVPsDxGe1ucnXaCB3fysO9sce/JhR
 QKEeKxw67azX2oRbVRAsruoMd5VPgIgXEPquilVBqk0iFulwGIOg+bCD3TplExt16ex3
 2OMvQBJkWjAW3ahLMBys4EACdPzNevkKWBRlOpxal0Ko30ojPsHDqEytRH+1TuQL5KjJ
 lX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750593; x=1715355393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k1ZHl3KtBDD8F5IDAshvr2j1UwCpx77YSs6aZ7LDCz8=;
 b=HS/A+3NpdOBtAu/FTJyLOD4ApujyWPE84i4xfFkxopGejWQbIWMhtIkZXTLpoKo0i2
 FCxp0+ARFUsR2TzYMdfiX/jSLxWNGOgqG9hY+YBYKfKC9rKt2HkUP892sR9F73wMNMkZ
 xzi7JvtZRCIY05H7AOdkI2ZuWfFhNoPf9WVNR6opakt+xE6YhdNWiFucBWAiFXpgiZTW
 v0C5j6ZEw8cYA78XGelPuRxfhNxj7t94Cnd53za21jLmu+PZU899o4sCzxhAXFFgAHm3
 CCDTkdrRBg7xqWobGwlcsvEBX/H0+0aerNpaTq6DQ5fQNfVKOyGWOO6EVzrHGVFsF0wz
 GIQw==
X-Gm-Message-State: AOJu0Yxanbp3P3d5Zb4QLa85Vav/wAE4kLoWhlkRqomULyvSwbcFEMYA
 jtSlZ7eUv3oPVPmRtJ/vZp1v2CiauFhRiThwdKDJi5mTYMCE3RXCPmwJKQK+iab5xwSR2Kf8lCY
 G
X-Google-Smtp-Source: AGHT+IELLF+Ss/gxvtOx2AuKrofkaAeOEqaHud+hJpklhx3fOY1QsfImgkP9QdXCpwT4bW9nPkKwyQ==
X-Received: by 2002:ac2:4114:0:b0:51c:fd0a:7e34 with SMTP id
 b20-20020ac24114000000b0051cfd0a7e34mr2094125lfi.22.1714750592384; 
 Fri, 03 May 2024 08:36:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 j21-20020a170906051500b00a59291b5551sm1820311eja.63.2024.05.03.08.36.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:36:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/14] exec: Include missing license in 'exec/cpu-common.h'
Date: Fri,  3 May 2024 17:36:02 +0200
Message-ID: <20240503153613.38709-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

Commit 1ad2134f91 ("Hardware convenience library") extracted
"cpu-common.h" from "cpu-all.h", which uses the LGPL-2.1+ license.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-5-philmd@linaro.org>
---
 include/exec/cpu-common.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6d5318895a..8812ba744d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -1,8 +1,13 @@
+/*
+ * CPU interfaces that are target independent.
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1+
+ */
 #ifndef CPU_COMMON_H
 #define CPU_COMMON_H
 
-/* CPU interfaces that are target independent.  */
-
 #include "exec/vaddr.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
-- 
2.41.0


