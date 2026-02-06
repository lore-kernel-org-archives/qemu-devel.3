Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87480EE2080
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJ3K-0001Qp-1Q; Fri, 06 Feb 2026 05:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voJ3I-0001QC-8d
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:27:04 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voJ3G-0007Rr-Pm
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:27:04 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-81f47610542so1400965b3a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 02:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770373621; x=1770978421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fla6h4jLdKMGrrPAOvpc4PjnowUXEERvnLV1L7DC1cc=;
 b=j9Oj0ZGf7AvnUZXuEOeaVwcrcCZqpkckZDHDn6XiJAJvqzCvZ6rIkZKgg9abkXge1N
 BOaUsRyPr0+W/0kJ5AfET6LCVPsTvDhy3/nL/cRpps/tQPXEsTLghXCs4vGTK3QEEEwW
 XyWot2+PEeaF94O+XmGTTrsYmfbnzYXmDg+jEOkgOpDDju3fJH4kM8y0ppJ/bcA1UZvp
 JI9iUwUL6vAyxlL5Dxb+IBTLd1XeRAadKF3JQV1r5Ws5Wgtrvc+I7FV9vCBfEM1Q/JEg
 x/CLMQhEMhVg9hCn4M0JME/qqHSY+ume42/4zI2JOxsrh7i1nMUcwMLbA9YsjSlk2PSm
 a2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770373621; x=1770978421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fla6h4jLdKMGrrPAOvpc4PjnowUXEERvnLV1L7DC1cc=;
 b=jNqc+AT6GONhT5j+ENg3zgQQTGH4g5gFimBiNb5jVL8BsXshX3QSm6fpTWzfqpNTl7
 7bE6Zo+mMk2rlRYx8IOooYDe4qiUpBI2jpJGAyHnOLNGzyZmr8golN6OzxeOi8IkkBv1
 +97BNZ/q6Go7t9mO9+Zpc93E5t7hbedvI66326AT6ASGP+CEerppTN0NgP1dKpFqQLx7
 XLZcXw/1orRH4A36nqNXlJpjq3CPhyIVKgY0YjWNpW+1nyqJFxKWr0lJCj3XHkslwC1e
 u1LvvxShCM7gRXdl8Gf5QpoRGRniwo7Po8zSQvcVup8+zKc/UIPv+DbhgHuGNL1FmGKc
 aHNw==
X-Gm-Message-State: AOJu0YyYrNYdr9dvxqqG5IxAPzxCu8a7ds1hktntWP1MITPG+RXw7XxV
 EQNdzLpKKU/Z/GfRU0Z0+r3axUXEeKk5u1FuAO1gPWt+4ZfNV50e4pQcVwCy9FCuC7B2EVzzuWk
 /CUgwL/QLYBCi
X-Gm-Gg: AZuq6aIglIjzgev3Zd/2heFWoqoV1qVKBvnB0EVo6xbl1gX26vaWDpSHrPWCP6wOxCO
 5k1IyXt5mxVnUzIJgeYv3idn7dKZuXCm/Un43K3yH4mLOtvsuxSt6w7GhNjR7MAZ2XiuEG7bDtL
 0LZ5Hnmw+KU+kNQYmrOSuTCbCTimh3UdyXwPllGG3CutkKp6THMiAGlE3MCMGkEamn855W2Xv6h
 tsJQ0+eBaE31vUYkk54BS821/5Tcp+VGoX2B3MMa3ds5qdvx5Reb1NjknQ61LiHO5wHcv7V64OW
 ql8djSOD4rkYy0bHlWS01R0bemjF0d21Lct84bdQAp7Pi4S2/f8ecdlHVSIl2YCOlETZ9+TO1XX
 sK4qQIGgReE30eEpzb2JZJ5MOV7oCA/e9cm9/B0317OmPCfNBbd2xGPiD2DcDkycZB/zw2zR2zu
 aj0OdeyMUMS/pCCwjE2Wkah9aiFMjczO/gDwiZRMJ1owi7X4AGD8UeankzmPu6Fx8=
X-Received: by 2002:a05:6a20:cf8b:b0:341:9db0:61f1 with SMTP id
 adf61e73a8af0-393aeea9e25mr1994654637.16.1770373621174; 
 Fri, 06 Feb 2026 02:27:01 -0800 (PST)
Received: from stoup.. (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b1f49191sm2113723a91.7.2026.02.06.02.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 02:27:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/5] accel/tcg: Don't pass NULL to get_page_addr_code_hostp
Date: Fri,  6 Feb 2026 20:26:48 +1000
Message-ID: <20260206102652.164018-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206102652.164018-1-richard.henderson@linaro.org>
References: <20260206102652.164018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pass a dummy variable instead to let the value be discarded,
in preparation for making the argument mandatory.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 6adfeefe13..0ca13750f9 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -105,7 +105,8 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
                                                 vaddr addr)
 {
-    return get_page_addr_code_hostp(env, addr, NULL);
+    void *discard;
+    return get_page_addr_code_hostp(env, addr, &discard);
 }
 
 /*
-- 
2.43.0


