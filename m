Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BED6CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MzT-0006Cy-6E; Thu, 16 Oct 2025 08:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mxf-0004SM-B2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:06 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MxR-00007J-RG
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so5339645e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617176; x=1761221976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eUi+/YruAu0GqnNptOwyORnqU9XWBam7ShlehwQN3yo=;
 b=UDHM4uw0sbwzNwLhQQsC7UybfEqo15xk1PWo5jYySqGxj5htHa37lIzR4i19QAC+52
 NLH+WnQM4/gdnGuayU6QL6iT2hqvt1VF+3nKC0XvW0XOew51bN3dFSGL3My2HczzZoiP
 LVL+jeZO2teWzpwdBuZmXTjkWwbR8Ebv4WzBPPWBVv+FPEA0+6/E4U/pHW/2OMRr70rM
 EzC+wtLXJGvjrZWMZzu+D4P3XI705zcvSxF/wQtPFKWRb68/neCdp9P1g3qjh9EZxTKL
 o1QUw5yB1QrXWFksCQDCvRTvxQDu1bJo2aOSXfaJsvypNM9U6lIvRO5INDWdqPrpGzVa
 /Iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617176; x=1761221976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUi+/YruAu0GqnNptOwyORnqU9XWBam7ShlehwQN3yo=;
 b=wgW0Aiz5+Fte5w3eq6ahM9WWDdSXjEXb0R7+hOVKDQLDCJnk/XVG6DA06EY2E5ZXWN
 pkdIyrnLPsuLkaOf746O4LAqJeM8FqnzmqjINhS4lLQ3zO7DIzxPinbpmV0eyVHUhCSz
 jiu1I4Am7MCjUtwrCqHmnchPu9dwD9zSTAtHXihSZwksG5Tp397vWOwZqHhjhXqFi3oR
 a/SbWEUTy+t314gzyPyQzD1orE0DdcaT+NYg3VLn0T4gZ8mMoSNwYGFn+Umk9SuMsGpq
 cUPhkHFjfetIIrv51ERBQtoMyJmKgfcv42lIC7pQTm7WuzOdgY7PNmVrH0+rA5I66Y6w
 C2lg==
X-Gm-Message-State: AOJu0Yw5Y+rN/d+e9qkgyFQPWwSfd4qV1avBvDkmwcTj08lju1t7oKoa
 TWBYfOVQPc9XSV1XFF9KH1nbG5ybq7LX3XkKYrebUBAL/ukEO+582VPUj33vdjHQyLaCaHoZsAn
 EByqbX1s=
X-Gm-Gg: ASbGncsLY3Cth1cNnRpKJdcX9pRO2EAw7QYTFzYqC+rJKjhz/p3n4i/VD/mUC3tAzbm
 UVL5s6q9DFlSfXLhArcMFfOXdj7aG5Vu8pdsNv7tIbTepR2MxMqJe8ciof8mf2cXl4nS6LFVuQT
 atQLCo7KHxAv7+QBBfXk2YkyJonHsAKb+ZuLgZ+e3fdKh02LCRD4Hplb9riyKbsymAELjjmXXr5
 MXOb0KZAvB1bi9TSNbXEYUrLb8+FgN3AihvQIILMhkI+PyMHabwI6yDtiBBgS7gSegSBV+0/vhQ
 Ed/Qy6kglppjwW6+edihTOe4n6AYqhno64hcdIlsUh/tkHLPHhNP1QH0w8a8XgyGdEVseKhXGuX
 DWP8BLgj1RgZVppwugjiA7AzCj/pASQ7owY548EJhrmOedlkdbWDYHo+82IH26RJ/3ZyGRHot75
 tzaSIoIipLLWe9qknQSUBgXrlhV3Pi/csCI3hMHifHpQiWBzFyEndexQ==
X-Google-Smtp-Source: AGHT+IGnTYSfs0TOOZESxNiRlfw0+fF36G3DN6GVBC6W32d2LhPBLSo+F9hoptJ9tsM5k2ef2p2m3g==
X-Received: by 2002:a05:600c:3e8f:b0:471:1717:409 with SMTP id
 5b1f17b1804b1-47117170635mr287875e9.23.1760617176365; 
 Thu, 16 Oct 2025 05:19:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710ed831cbsm18909815e9.5.2025.10.16.05.19.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:19:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/75] target/sh4: Convert CPUSH4State::sr register to uint32_t
 type
Date: Thu, 16 Oct 2025 14:15:08 +0200
Message-ID: <20251016121532.14042-53-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Since its introduction in commit fdf9b3e831e the %SR register
is a uint32_t type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20251008064814.90520-2-philmd@linaro.org>
---
 target/sh4/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index c41ab70dd7c..db27a693f12 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -365,14 +365,14 @@ static inline int cpu_ptel_pr (uint32_t ptel)
 #define PTEA_TC        (1 << 3)
 #define cpu_ptea_tc(ptea) (((ptea) & PTEA_TC) >> 3)
 
-static inline target_ulong cpu_read_sr(CPUSH4State *env)
+static inline uint32_t cpu_read_sr(CPUSH4State *env)
 {
     return env->sr | (env->sr_m << SR_M) |
                      (env->sr_q << SR_Q) |
                      (env->sr_t << SR_T);
 }
 
-static inline void cpu_write_sr(CPUSH4State *env, target_ulong sr)
+static inline void cpu_write_sr(CPUSH4State *env, uint32_t sr)
 {
     env->sr_m = (sr >> SR_M) & 1;
     env->sr_q = (sr >> SR_Q) & 1;
-- 
2.51.0


