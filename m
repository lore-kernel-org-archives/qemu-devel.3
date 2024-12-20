Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83C3E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfi6-0001Cw-Am; Fri, 20 Dec 2024 11:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhA-0007nf-PM
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:47 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfh2-00082y-BH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:42 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so1413831f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711454; x=1735316254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFNvPYQIcnNtHhjWZM0/erUE8dZXW2FGWS1U/u140gI=;
 b=bhO9Hi/FPLXiPKjtdBpS1ZxXLo74XYwB4Adl+SuOOKWvyLyRSNzOGPVunuxkYUVOzh
 kaGpQ9gM/WXS3tbEqf3rIE1hMihGihJasjoVGRPt5nVgd2dLN/g7r689VkEeXuV2tyIu
 2zKThcGIoLGrf5lUO00JU4akRZ1X1Gpte1o+JP3KGREVd0VKJuCiEJCFdpGhco550KrL
 FPD0/GLonrWX2pfHzdUD1WhgvgimABE33wslEGETv2mZmEokQ5qQ4BUdOY4v3SFXHq6m
 ckm7RQau7IPjo7hZH2JgBdLXDE2KVXZddmmR2agW03xDf+Z8m/LcsagbJD3jX88mXtFV
 UCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711454; x=1735316254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFNvPYQIcnNtHhjWZM0/erUE8dZXW2FGWS1U/u140gI=;
 b=lf2pgtisBhUpnBBnLCmKvYLLulMpejBBk138f296J3MaK2CyXuFR+9woZteaJVX3XL
 82HoONNBqVDobRJqxUj996WODGvYYCkF+K9s37S1M7pcy0NOn0/0U1N3+PW8yCAorMLL
 OtcUDDy+7J0nFqjbAqvd1PWLOqLXcnCKgnCNOS7jcP0x98DyD3DcYDf0XqiUkCIhagz0
 Md9cjeVm0MPMc5iFd39A5VuqLIMcErhYcvjHoC+FfAXNDw1Fw+U+C+21wuoBu+evhijZ
 mb78m594rZybvwmqcXga6AStRTMGY7X1zstU6cJd1FNR3tZziz7VfTa34MeCbyUCzPrb
 rf1g==
X-Gm-Message-State: AOJu0Yz9opIfeZ5Pd13pzC1279321XT+KZFGtHPbV9lBDTQ2wPmwk60I
 T3w4th+p41K2OXf2UGX64PyZc3+OrE3wpYb/jX9jS+To7YH1xcahkO4F/9bbz4sn+8fvgltRlLF
 k
X-Gm-Gg: ASbGnct3BH/dgsciOT3x4PQRLXM5mn/BDWhW6LqDV1SqBNlMZunX09aUADHVp6dBdXI
 hvkDs3ibhOnI280rZQ9J1CzPq8Z5zmRvs97ABfQm8vgrMGsKLNRv4dPJU6Z/05jaFLsuATlNeOg
 Z0dawoapZTbOum2p84F3LMYfACq+CtUJFXCjAozxVO2TTptJa8QfXkqIXCM5K1j6wheDPSTOhwm
 g5TjG9f+GqMITyFpn2chH3xPH25zwIicff7oipVOxDqCj1huhmG14k08jBBgr91XC52TNEJoc4=
X-Google-Smtp-Source: AGHT+IFGNR7WGOQKl0jFud/huoSkEpdYJkmIVbk11wOhQRT7Zpd7Iikr/wi96VUfIoHTNCMTlvr+JA==
X-Received: by 2002:a05:6000:4a03:b0:385:f638:c68a with SMTP id
 ffacd0b85a97d-38a221f9f58mr3513886f8f.30.1734711454409; 
 Fri, 20 Dec 2024 08:17:34 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1cesm4305271f8f.64.2024.12.20.08.17.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/59] target/arm/mte: Restrict 'exec/ram_addr.h' to system
 emulation
Date: Fri, 20 Dec 2024 17:15:13 +0100
Message-ID: <20241220161551.89317-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

"exec/ram_addr.h" contains system specific declarations.
Restrict its inclusion to sysemu to avoid build errors
when refactoring.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241114011310.3615-10-philmd@linaro.org>
---
 target/arm/tcg/mte_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 9d2ba287eeb..b017b26d07b 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -23,7 +23,9 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#ifndef CONFIG_USER_ONLY
 #include "exec/ram_addr.h"
+#endif
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "hw/core/tcg-cpu-ops.h"
-- 
2.47.1


