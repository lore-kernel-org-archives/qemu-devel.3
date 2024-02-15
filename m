Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA94DC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag1W-0005fH-KX; Thu, 15 Feb 2024 12:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1J-0004lj-9S
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:40 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag13-0001lD-4V
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:23 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-411fc61a03dso9909935e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019959; x=1708624759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZSw2YzJ/MkCqct1l1ey2O6+43vCJeEZUqJNCv27UXQ=;
 b=qZ+2VOCFyAL6TebQt2/Cq8snCNo1d5stp7M2EkQofuXexC4QQNx5biV7jWG+1kK/Zr
 bTxqYqj0vHRkhiBWKcIQa0NjoRQbgteHH7tKohkA8eoowGEdSINAihe5JynFKFkOpPTN
 2aOo3gFVTXE22Lfr2xeaSZOtjT68SSOVNIo4Ygla4cRFFd+gvLDuBMu/3/Hhxf3lS3s0
 I6MHK36hJYTyjKnbErSUuDGOGJzta6Mwmf65aDsIwQx0NkXPDb6RCwhWiFFsZcDM9GwD
 kSKEMNbqQLB2HOJOsEh7EbSCkIPcCBS7M7zYqrFD6bfH/WS7b8YfNUl/P7H+vvRTALR9
 NqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019959; x=1708624759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sZSw2YzJ/MkCqct1l1ey2O6+43vCJeEZUqJNCv27UXQ=;
 b=hOp6dUBrlnRPZj0UgA7uCC3WwTlpzcHBuKLWSSA1lErv4W6DP4KfuREH9bxln+XKTo
 412KosNVoOzcg0Uo6WCMLDHuyB+PUdDDVNSjytkY/H7elyHZLPIY4ce7GpN4/MK62mmN
 Zu7bvvF2aNhNq55E3iPbNPfUjo3DBveYM4sDB1ngQZYFy9DWrhcebDoodCBRmGlEXeep
 bYhgKD+IfGqtRIFhkg6u+LMdmi0mNQQlD+ZJ03EcezOu1g/P4wpypdbHqPg4Uu5eJUNm
 HeXwKZn5sKxRGDQb+MgcI8DGU5QWuESkIJzIKhpALC2bTZrqtY48F/+g3s0z9T4uk1Np
 zloA==
X-Gm-Message-State: AOJu0YwD7tL52xFQbG87lpy4Jc0oDNOicz89P+icOh/vPyPoNESse/3n
 x38OF67EfgI3+1LNuUdgdOwQO9IWIaNdQFmrCiFZI32lVQY8UiKS/xglk2bztcK2HrOsvuDqzcj
 Bz2g=
X-Google-Smtp-Source: AGHT+IGKkWrh1EfmpN5uflxPZiFBU+H+iWmUq/ar7QJRtpFMHotjF78s0XNRF/8UGGLjMsZOEdOW/A==
X-Received: by 2002:a5d:644b:0:b0:33c:e392:14c3 with SMTP id
 d11-20020a5d644b000000b0033ce39214c3mr1887111wrw.47.1708019959294; 
 Thu, 15 Feb 2024 09:59:19 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 az7-20020adfe187000000b0033d01fe1f04sm2519246wrb.55.2024.02.15.09.59.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:59:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@kernel.org>
Subject: [PULL 13/56] target/mips: Remove CPUMIPSState::CP0_SAARI field
Date: Thu, 15 Feb 2024 18:57:07 +0100
Message-ID: <20240215175752.82828-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Remove the unused CP0_SAARI register.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240209090513.9401-10-philmd@linaro.org>
---
 target/mips/cpu.h            | 1 -
 target/mips/sysemu/machine.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 5e97b5b422..7329226d39 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -747,7 +747,6 @@ typedef struct CPUArchState {
  * CP0 Register 9
  */
     int32_t CP0_Count;
-    uint32_t CP0_SAARI;
 #define CP0SAARI_TARGET 0    /*  5..0  */
 #define CP0SAAR_BASE    12   /* 43..12 */
 #define CP0SAAR_SIZE    1    /*  5..1  */
diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
index 6d1299a89e..213fd637fc 100644
--- a/target/mips/sysemu/machine.c
+++ b/target/mips/sysemu/machine.c
@@ -281,7 +281,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINT32(env.CP0_BadInstrP, MIPSCPU),
         VMSTATE_UINT32(env.CP0_BadInstrX, MIPSCPU),
         VMSTATE_INT32(env.CP0_Count, MIPSCPU),
-        VMSTATE_UINT32(env.CP0_SAARI, MIPSCPU),
+        VMSTATE_UNUSED(sizeof(uint32_t)), /* was CP0_SAARI */
         VMSTATE_UNUSED(2 * sizeof(uint64_t)), /* was CP0_SAAR[2] */
         VMSTATE_UINTTL(env.CP0_EntryHi, MIPSCPU),
         VMSTATE_INT32(env.CP0_Compare, MIPSCPU),
-- 
2.41.0


