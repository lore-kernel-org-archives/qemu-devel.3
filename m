Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C01C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJa-0003yb-7k; Sat, 02 Aug 2025 19:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJU-0003WW-Eg
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:52 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJS-0001C0-RH
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:52 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-741a8bb8aa4so157393a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176009; x=1754780809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iDR5eM+6o9oQbsnZxLAitiWsZ+OoVrg+xj7VGiHqrGU=;
 b=fjh8Cqw/LCrey+JYHIHhxw8Q4+eu0r2+n7Cvdcocuii6GaYzRKKMKECEIolZX8WDnL
 X75EauNlue7UrWpEw217aakMxrw8E+9ExC3MRHLZMxjQTmNk1YiCh7wAaMtc+X6iiPZ1
 fgFhfKs1XaDEk3Lh7XPmKxh+nSHUN/Iw/yKHaAmleXVd459tLOrFtCntM1XQAeJLg3fL
 cDuGlqO+07CNB97yKVeyPOJ7gS19IC6N2wxHcVsDS484mWdsoELmlsheiItyI6b/CGAM
 bnOGUGpOOVGtY3tIqtVEhbRnEjuCE3CucZhKL60WdwKTxWJLThWpwCxeQX20hnufOirr
 jznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176009; x=1754780809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDR5eM+6o9oQbsnZxLAitiWsZ+OoVrg+xj7VGiHqrGU=;
 b=gOtfDjP3YMhWNcMhbKlwia1hixKbWHy0ySsQ74aqKkjo+yy5tXeCS05/2B+mpqyb/G
 lcrjqTEX9eIrOlg9JR3Xd4M2BjyzF9NYUxMPSgchOvvmhdSBTAeXwXyVrwXmlkDNkXes
 +rLDmuz911gKSX9HEsgKFUFm3gO0CPP81EBwK5qJA4NlpBAAysyoBMhLCEoFV9WhyoCy
 rFSETUkzo75Mt/ezjmwjbCEJ2WGW6Wm3c/tOE18EDagt9wUB+MwvBh3QtTYyqLl7/0JI
 3yUQOAExokwudWgajak/t9XNtZjj0l/1Fk+q2fQmdmffcPIkN+JXUtXL8Lf6s1PM33NH
 6htQ==
X-Gm-Message-State: AOJu0YyEgtRP5b06Ra9/PeCigFqGLJrI1KH/VoJ6rH0loPXe6lei1yBe
 jgxDdOSjBMhTUiI427rrIOhw3hSFs3tn6OFpaFp84mKMdSGe2t+yYg1+aHfGMLzY4bueP6SJMtn
 nCSSJLJE=
X-Gm-Gg: ASbGnctu/u4CmRKhMmQONhnQWq5oMKRCHuJwrLVveADqA7ym0Mq9i8iFo0KETHcSAiG
 1mw1FIMOhKWYTizzMSwaVGp6MtXun9EikN2lPa4wid9WMylGpNQgzH/1uIfbzJ9wbs1Q2lrpFlR
 X+iAlKGTHQP9/hLlKM8sjON7/E1tzlSeQXS/TtUzNvuNVThhYnz+jFMcMpw3rkg4s5B854McSvV
 fcbsONfsYJKS80VEbkXqONRS6qbDKt0bJnr3e066wRjWFCboTfGc1MUVLb1ldvJa9oRBe1jyrL2
 lgegiTGQEQlFbGHHNdjWcxslhMecOLg8Nn+eeb/KXPNhVdOtSQp72NDsMl8Y016VMBkqEGgebIL
 /ua+sWt0EcyATmq4orBU32Kc6ww2P1Q3Ok+rRVBd9BeBsjXsu23+D
X-Google-Smtp-Source: AGHT+IGEld1750QAlSw/Zl1UUJ/vqA/ySk1D+wR5FB0NoV7POqlXUV/r9SrhT/MIDI3BxuN3v5Oc5w==
X-Received: by 2002:a05:6808:3c46:b0:432:79c0:7609 with SMTP id
 5614622812f47-433f021034cmr3220950b6e.4.1754176009506; 
 Sat, 02 Aug 2025 16:06:49 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/95] linux-user/arm: Remove a.out startup remenents
Date: Sun,  3 Aug 2025 09:03:52 +1000
Message-ID: <20250802230459.412251-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

The setting of r1/r2 was removed in kernel commit acfdd4b1f7590d0
("ARM: 7791/1: a.out: remove partial a.out support"), and the
kernel commit message explains the history.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/cpu_loop.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 739e1607e3..9aeb9b0087 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -492,10 +492,6 @@ void init_main_thread(CPUState *cs, struct image_info *info)
     env->regs[15] = entry & 0xfffffffe;
     env->regs[13] = stack;
 
-    /* FIXME - what to for failure of get_user()? */
-    get_user_ual(env->regs[2], stack + 8); /* envp */
-    get_user_ual(env->regs[1], stack + 4); /* envp */
-
     /*
      * Per the SVR4 ABI, r0 contains a pointer to a function to be
      * registered with atexit.  A value of 0 means we have no such handler.
-- 
2.43.0


