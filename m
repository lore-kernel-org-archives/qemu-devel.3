Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E47CC5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBu-0002Cw-So; Fri, 30 May 2025 08:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBm-0002Ao-Mo
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:22 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBl-0001tc-0y
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:22 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-55320ddb9edso2266693e87.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609419; x=1749214219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1/G8aH8/VMahHq2OL+KxFBxIbdmS7vT+cIfVwHBZ6N8=;
 b=tHEhwwHX47oZP/W6k1ePMfmVgqIjGRBDhtdnMMRhLO4bDkkh58DL2NGFn2azFxjLMY
 f2cV2EurKMU6UNVjeY/uDfageR0V+DVk+GWoNLwE0RT+6UmFvmA1O9cAQX7eEJF/lOMJ
 ivXqYW4FHxvN0o6t9CobP/q5k9vBoCmvcjrb5sJDbDIRG7VOQhSjG15jYZQ2FyMYAQJi
 18AUGBcpBkpjts3ztKibDXR3bZPzXCxaWN7k+NR3WjSsxqHN8nSyz8vdH1q3VFd+SnlO
 d5ZTRQlx0Xep7QZYzCgd9QG5/JAk6ivClCkjB1oginnfT8j7M8g0uAFqz92xYx/hPcbw
 SYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609419; x=1749214219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/G8aH8/VMahHq2OL+KxFBxIbdmS7vT+cIfVwHBZ6N8=;
 b=nx4qNFZ7dH5C5vC9xR/tUi37ABiW4B1S9wJmdKrLfGCggQPWiebeZtRwzNa1xKlHF5
 PPSke1Hfvnt2LVTDCdMAAT0Fyvnfe14rdSNH3aj6WYmJEMirjZj54yaS8K/UydMuO/PV
 vvoqxkuKniCGQ9FVX4eXXrDSr0BIxQJPnZWocdEab+EOTxkFiGS8W+debLKXyyVLIolF
 w/vliyfyCEtnI3YRhbjT4IcnLg+x03ngcdLBABT6cBEobvZapW7EoP6841l1uGCA5kAQ
 qOJh0gyfAkHmCoK+4LCXpHnBQ3LVFJiT3YiWeUBXUiPfAI3laGXj0x0xXD9NA1J2oAzS
 4RCQ==
X-Gm-Message-State: AOJu0Yw1NSwJagIhoYZW90pYWWsIb+pApUP47qDdfNfZE1Qy2BjjzsP4
 7Mi1j6r8wf0RjPY9UqQmSMIOxW3z4msn9M+UZ5+pIpzbO9ANvIHCPzN0M97Q50I+Be6Ng98Ss6m
 NasJP
X-Gm-Gg: ASbGncuHfYs0ZR62EQqN1bbBcPJxVbMTLiVkT4JHIo/rR5/tN6URrn4LeQObH4+nr6E
 NjzjN/j5LRNi/JNVMZfr0xKobDeqsbNjWIrvU7shPn9SE3AqAYHIQ5hIgxNQI+SI5IKA/0Kbrws
 eg2zv6kYQnk8jx6VTR1Q/6bs/XA8sUi6HPN600FmEd8/1+dZbnpymU5x3o65H6zqGYJiiLyqcoX
 08FuSAT/4J87TD1MBds+9in9XQaRC2x1Crr5gXsFfGAhjxdP+N0pF7djSZmVMnsSwsMhs9+Y+Qx
 XqUjT76oM/Qw5bGc+go3LxgYWP0go8vxd4IHAmn36udaJNSycbeZ4y4Zig==
X-Google-Smtp-Source: AGHT+IEWigApV6uQy19hRpIegqaaftjMmPzfXBlmIb2ncElPWhELndfky1gFopiLXK09QIGZJGdK8Q==
X-Received: by 2002:a5d:694c:0:b0:3a4:f975:30f5 with SMTP id
 ffacd0b85a97d-3a4f9753445mr1361391f8f.27.1748609408424; 
 Fri, 30 May 2025 05:50:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.50.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:50:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/15] target/arm/cpregs: Include missing 'target/arm/cpu.h'
 header
Date: Fri, 30 May 2025 13:49:45 +0100
Message-ID: <20250530124953.383687-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

CPReadFn type definitions use the CPUARMState type, itself
declared in "cpu.h". Include this file in order to avoid when
refactoring headers:

  ../target/arm/cpregs.h:241:27: error: unknown type name 'CPUARMState'
  typedef uint64_t CPReadFn(CPUARMState *env, const ARMCPRegInfo *opaque);
                            ^

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250513173928.77376-5-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 2183de8eda6..c1a7ae37356 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -23,6 +23,7 @@
 
 #include "hw/registerfields.h"
 #include "target/arm/kvm-consts.h"
+#include "cpu.h"
 
 /*
  * ARMCPRegInfo type field bits:
-- 
2.43.0


