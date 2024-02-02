Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333F5C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmRt-00012m-Md; Fri, 02 Feb 2024 00:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRs-00012J-4v
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:48 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRq-0001b8-Gl
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:47 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ddb807e23bso1212472b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853045; x=1707457845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kq0J8Afnqo7enZSunt87RCQsJ4GxKCY2HEoeL1qsLBQ=;
 b=pCqcBld0yov0Vh/iMZGpt/nhYT8+xPPr4tiphnbp9WhENAlS+w9PEeT8IwR+Aceaji
 8EspkphOPsvj+27rCm2x5BUjX1Aq6TEJVtWVd9rXQt2NKYWavwBkL5yNziCmCsa29NG8
 dm125HF8kacEtwiaou5OKarTEIDkHZLyDfM4PRZkE5ItaaMoUZl5esICN8m9x0q1kiR6
 AWhnePSkmuwx20+ymIPlFZOJZol0e46enXQk2qvA/eK4mKHUKzorm9Kt4+3hagQmXOxL
 sFdUw8LVMMowctHiU+JkjsZpz1uvPGc/dF4jDdPxj9P2PRLUCxG+76S36CReRcmQ6BkD
 ia7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853045; x=1707457845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kq0J8Afnqo7enZSunt87RCQsJ4GxKCY2HEoeL1qsLBQ=;
 b=BJk4nvlbbxYhmnHLy+qZRaeGMLeDzasb97/I8oFuzuoszswAuJQQO2kdPOvzPxL2y5
 beuprR4ZkJS1Lwh4A7Cijo5y7TwVVWSmvTHnaKdNGGAl4DlMq+WZqov5CuHAgOKLMSKc
 +LPlQ2V7Y6vjLcVYnzKoKHsr2Caur3P+YvK4r/hgRoe3vOCTXPDwDlxDzD/CaLdYW6eT
 vOfa3JslSsjvAnB4snissjZc3FcSU19f2Q0WVX0wNyaKjuRqdA2JG8puq1gbDvUN/vz+
 h/m7CCEuTRvRynQAqy0XYMKKMk0/uF7DJ0iA0rQs3q3Ktv8aNDkzESVsVgc3lBnOq3v1
 3s3A==
X-Gm-Message-State: AOJu0YwehneeP7FSIMZZ0kq0zLJJzhX+8Y6tFjc5kk89T7SY63xjF/rW
 pQtqltpiU8eEBuew9+RmdSxP/G/m0KODMDlhOtFKSdb4GKkhdY0IA88p8iFkZrbUE29bH9kWUtz
 kqrQ=
X-Google-Smtp-Source: AGHT+IHvG0Blh1Fm6y2We/h3S+PXtYOhejH0DtZKI76iwiP66Xh47IwkmKqSU1/qpxKHXePR4auw0Q==
X-Received: by 2002:a05:6a00:4c93:b0:6df:e035:5549 with SMTP id
 eb19-20020a056a004c9300b006dfe0355549mr7634554pfb.15.1706853044886; 
 Thu, 01 Feb 2024 21:50:44 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:50:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] linux-user/aarch64: Add padding before __kernel_rt_sigreturn
Date: Fri,  2 Feb 2024 15:49:40 +1000
Message-Id: <20240202055036.684176-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Without this padding, an unwind through the signal handler
will pick up the unwind info for the preceding syscall.

This fixes gcc's 30_threads/thread/native_handle/cancel.cc.

Cc: qemu-stable@nongnu.org
Fixes: ee95fae075c6 ("linux-user/aarch64: Add vdso")
Resolves: https://linaro.atlassian.net/browse/GNU-974
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/vdso-be.so | Bin 3216 -> 3224 bytes
 linux-user/aarch64/vdso-le.so | Bin 3216 -> 3224 bytes
 linux-user/aarch64/vdso.S     |   4 ++++
 3 files changed, 4 insertions(+)

diff --git a/linux-user/aarch64/vdso-be.so b/linux-user/aarch64/vdso-be.so
index 6084f3d1a701316004894fcdd739c4e1e0463b68..808206ade824b09d786f6cc34f7cddf80b63130e 100755
GIT binary patch
delta 121
zcmbOrIYV-SKI4pu2Kk&{7{Gw#%fuBAMC1c?^>~k}v|avdxNjSSLfftVb3bgJ!|2S&
z_-6A1CJrVZc?IUH8G;R$7#SF@Om<{a*v!K!&BXX-vIe^~TWO|cva$K*Om;sOMw`hy
ZxXl@VO#Z-a&zLdUfXALuXmSCM0s#EKC)of1

delta 116
zcmbOsIYDxQKI4Rm2Kk&H7{Gw#!^9O2L>8U?-5V_M@!kH(Sx4vJn|*ujLPgija~Pc&
z8DDIEz{J5c`3;N8W)W6tCdL<&4cM*OEF8_<v%@zRviq?xT1-B`ZO-^%@(*r%#)Qch
RJocPi5ThAdCO2?N002V6C;<Qf

diff --git a/linux-user/aarch64/vdso-le.so b/linux-user/aarch64/vdso-le.so
index 947d534ec1899740edbd6921da6bc6e70e2ecd09..941aaf29931193300de1f62097867c282a7e0c74 100755
GIT binary patch
delta 129
zcmbOrIYV-S2IGv0n)#exSQx<I%fyAxMZTVBQ(04AP_*V|Vxp|@=@;x8zb9;-!)U|E
z_-6A>CVnO!c?IUH8G;R$7#SF@Om<{a*v!K!!o>JyvLd?^n`3BUW_royOm=q`Mw`hS
dxy>1WOn%92&zLb;lgFM@hy!9z%j7~Xc>tTxDQW-!

delta 108
zcmbOsIYDxQ2IGW@n)#d`SQx<I!^DNpMK&+G&+g_}w9WI@dn@@euKVesZ-h6`VYFdn
ze6jf^6F<}BH!LcfMOa0c7+*}*WOrgKEO1Fl%G+GX?#{w!F?lDqIpc@PAGz%r6DAw-
M*fVlXF62=M06owo?*IS*

diff --git a/linux-user/aarch64/vdso.S b/linux-user/aarch64/vdso.S
index 34d3a9ebd2..a0ac1487b0 100644
--- a/linux-user/aarch64/vdso.S
+++ b/linux-user/aarch64/vdso.S
@@ -63,7 +63,11 @@ vdso_syscall __kernel_clock_getres, __NR_clock_getres
  * For now, elide the unwind info for __kernel_rt_sigreturn and rely on
  * the libgcc fallback routine as we have always done.  This requires
  * that the code sequence used be exact.
+ *
+ * Add a nop as a spacer to ensure that unwind does not pick up the
+ * unwind info from the preceding syscall.
  */
+	nop
 __kernel_rt_sigreturn:
 	/* No BTI C insn here -- we arrive via RET. */
 	mov	x8, #__NR_rt_sigreturn
-- 
2.34.1


