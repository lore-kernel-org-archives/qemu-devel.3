Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2994FC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVoi-0006ys-9M; Thu, 15 May 2025 06:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnX-0005JX-7B
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnT-0008FC-F6
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so5643815e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304798; x=1747909598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L4y+E8AlUZJJawRvRasL16CerSr3cx6XgUGc/DdJyiA=;
 b=REDDuoH31kR8gyge4JYx0n31nrhrcScpBU7C8dOX/dDfIUR1xhEMT1kgxyBpOj5sBk
 vvt+54bfpdOfvR+ESxKfcHrrUejkk3n15v05igoqwGN24pwAK0q4nZqe1eaZpcCASWYe
 1RP1aBco/LmgU0irppsIJCQxlpC3DFMuqD4AgEp1jxQAn3nUXyLDOmfE21tOLY1z8wEA
 uXwuFuQ2NcmQc6b5VsFdVmLLaJLusQLf3qdMEHs0GiQFjrkIhMlluyRtln5fBXR+5xGZ
 SX3FCdagEaTlyvsUvtE3Pn2k21AYDeJYImvfkWkz45R7akKjWUFqzcZHcG8yfHs07lG5
 b9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304798; x=1747909598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4y+E8AlUZJJawRvRasL16CerSr3cx6XgUGc/DdJyiA=;
 b=jNEo+RRl8v1fSjAZkO3TBYQDY2isGdRpnSBFdxu2RfgR6jrjz/fE7BUacVJdYWvU5G
 xyeIarj37iek7Bnw9bXBgvQYhxmpGPVij1zlYIsaT/LRW4RAPFJGsI8PeJmlEZ1WME12
 pkAZ8gTwbTatPrC6C6419hPKIPJTF1Ijc5ZZN4TJsDFkj5zMo3Ze49d/T3bsH4F2n1L6
 AK+rG1uPQse4mS7YVKYucMAfVuY0UhRJFoQVcegH+5+/nTWiTxV3h+vxPjtWnwl1i48x
 +za0w74xCoaIMG2l679v3ak8QNABMwe2FUTPrnRNrVGDFp7uAB8x7m/KkjU31tDcV7Fd
 JUXg==
X-Gm-Message-State: AOJu0YzLSpLBc8RKKjsRPVq862JRpNyNcqdoKj0wVD+x4HstUeH9ZXqp
 MX7oI25taA70XuscPsTfVrgn75hLl9SEfFmZwCNxWByyrC9XpZ4v8WLWN5c4WX/wO0IMp9NMgQX
 qZxk=
X-Gm-Gg: ASbGncskTwDg+PtxlASMNEmk2J9bk+Bmbeq2hPMduEvINd08W/aJIW58sHfyrNvGlnA
 6D45BtCbWvcOTdKez/WwsLE5ay22fTUErr7UhzOsJklLN3nwYg8HW2un0kEMu46mPyGhQQ52NnL
 uALMCBgvUm6zUmW23SR6bdOcMACdNKrbFlJz5MSWtWrmDGVj7pK9cMh/doVPTFc2gtHlDc5gCRt
 DRrZEao44bAE0/9qS0cjdRc/Yqz9p9T+5yIqNtoFm4Y4TTc+KnvMeCPcoOB6nFWX2wWe34UlPzl
 S83oXRMGWK8ChE9XU/pr6x1VSLeopVrfl/pJlwJPiOcHvCPd/+Bf2jZqeN6hd6Fxq1dG
X-Google-Smtp-Source: AGHT+IFdkvekpH2NVhW/w23J3H0UHbUmFyz/ilCCRTbF06LsmofQeKUgkmNWarP5i4FtkdGz9U9sXA==
X-Received: by 2002:a05:600d:1b:b0:442:f861:3536 with SMTP id
 5b1f17b1804b1-442f8613581mr25387725e9.7.1747304797663; 
 Thu, 15 May 2025 03:26:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/58] target/arm/cortex-regs: compile file once (system)
Date: Thu, 15 May 2025 11:25:26 +0100
Message-ID: <20250515102546.2149601-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-29-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 7db573f4a97..6e0327b6f5b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -16,7 +16,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'cortex-regs.c',
   'machine.c',
   'ptw.c',
 ))
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
+  'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.43.0


