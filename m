Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F0FC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag0v-00043n-3w; Thu, 15 Feb 2024 12:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0t-0003wn-AJ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:11 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0q-0001gv-Df
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:11 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d109e7bed2so15233951fa.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019946; x=1708624746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yChT06qqS/oR/UqktZBd9s/sYDht+XeML6XM2cVxcUo=;
 b=s0LTadxWgdGGcm4OR5WqSXjeZB3fvYXLUVhq9E8nnUdLPqmvAGEAWLR8S3+GY+cju1
 Jub++tGYY6pTMCGPn2WXNAdSH3Ve5YAvEM2Z/aQ2GlZTJcmw4oHL0cKn6LWcbHIXZoWn
 8eUNA9tLCqrcLML/lOziAxohLVxnJKKXMsdN3lvRDqca0oipj/hdK/dY/JKq1ay4slXk
 2aZnCtGV0uhvOTwENeaTOLK8wCsO9hdQh6dYunXXno54fvSpRET476MhH14qkD8eCJie
 CETFALxFEUdjInuzbrWniL5iAPPMqA9X2dHOE75p4QA4mPXfjVa2CuktBDEFrf0dmDXe
 0iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019946; x=1708624746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yChT06qqS/oR/UqktZBd9s/sYDht+XeML6XM2cVxcUo=;
 b=Se5YTZts8eE9J7fpH3quveXNJw0zlCLJc001BY+1I5dRg+HaLl3U0xQ/Cq+adfnm4+
 5N7/PFWNwK0EzSd7OzocdFD9HAi2KMspGsLunhKdiZEGzxJfB9wj1VJSALI7MSuEGXKJ
 bfx8fodBXSvz7gZMF3L2nKfKxT5cwf/maC8XVATfT+5PZtIAHYWPiPwHhfrwrmf8EDKB
 N7zqRtIbOzt9yv4C8VTGMb5swFKjRveoaKxtA3p3T0UVWKYU1IxC501VDyQieWuWTFdr
 ROPuQoelR0co+SAHqnxaJ4lLZ533f1EPfQAzY5448dcQNdnB/kO8PvjiwIAV6dHJreLV
 VXUw==
X-Gm-Message-State: AOJu0YxjUreAaGYjwY2jrOMO9NzPqdiX5ord324kG46SoCIfOFG7p+Ai
 /oie6D5pZtCvEdeKeZJzi8DudBxKgyZ++3+dSPfxFnCqq9pkFFTp87ZgecbgQLcqOmTparXWoMp
 szBA=
X-Google-Smtp-Source: AGHT+IGwBsc4haTLh6SoDLG3E8Mtd9pOKaLzwuLITPAfFRlaX4T6CgmnZMnyCIp23LF/R4aXEMCfkQ==
X-Received: by 2002:a2e:7a12:0:b0:2d0:b003:95b7 with SMTP id
 v18-20020a2e7a12000000b002d0b00395b7mr1959454ljc.13.1708019946401; 
 Thu, 15 Feb 2024 09:59:06 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 m22-20020a7bcb96000000b0040fafd84095sm5636762wmi.41.2024.02.15.09.59.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:59:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@kernel.org>
Subject: [PULL 11/56] target/mips: Remove CPUMIPSState::CP0_SAAR[2] field
Date: Thu, 15 Feb 2024 18:57:05 +0100
Message-ID: <20240215175752.82828-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

Remove the unused CP0_SAAR[2] registers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240209090513.9401-8-philmd@linaro.org>
---
 target/mips/cpu.h            | 1 -
 target/mips/sysemu/machine.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ef1d9f279c..5e97b5b422 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -749,7 +749,6 @@ typedef struct CPUArchState {
     int32_t CP0_Count;
     uint32_t CP0_SAARI;
 #define CP0SAARI_TARGET 0    /*  5..0  */
-    uint64_t CP0_SAAR[2];
 #define CP0SAAR_BASE    12   /* 43..12 */
 #define CP0SAAR_SIZE    1    /*  5..1  */
 #define CP0SAAR_EN      0
diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
index 218f4c3a67..6d1299a89e 100644
--- a/target/mips/sysemu/machine.c
+++ b/target/mips/sysemu/machine.c
@@ -282,7 +282,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINT32(env.CP0_BadInstrX, MIPSCPU),
         VMSTATE_INT32(env.CP0_Count, MIPSCPU),
         VMSTATE_UINT32(env.CP0_SAARI, MIPSCPU),
-        VMSTATE_UINT64_ARRAY(env.CP0_SAAR, MIPSCPU, 2),
+        VMSTATE_UNUSED(2 * sizeof(uint64_t)), /* was CP0_SAAR[2] */
         VMSTATE_UINTTL(env.CP0_EntryHi, MIPSCPU),
         VMSTATE_INT32(env.CP0_Compare, MIPSCPU),
         VMSTATE_INT32(env.CP0_Status, MIPSCPU),
-- 
2.41.0


