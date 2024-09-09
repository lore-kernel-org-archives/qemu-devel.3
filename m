Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ABEECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniBr-0004Oz-39; Mon, 09 Sep 2024 13:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBn-00049x-Dv
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:35 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBk-00060y-9i
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:34 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2059112f0a7so42399455ad.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902911; x=1726507711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmJ2ujIulBhjcVgZsB5TPEctVhmiUOFaoVw5hh6PLPo=;
 b=sXw8XCPHxp8fCP95ccOtH2DAEmnfFvLkh6xs2iCbnVzua9RpWopesDxfPvGeOQrrzo
 yBhsUza5/wQ0bpYCdlY75x1tHj4F212R8Mb51/xLlpJRmoh+lKMCh89BGSoEYEqG+75S
 wRmvRwSDhRx3H2lefwu2h3hmJ8aFH9l1/GGMGd8+zNtLD8y/iduI7/UbEdrKWWUqN9Jq
 EISj+1mV/+KMOEcMkUr9mTfS0rCaonldEq0Op5SdxACbwGB3Tc2hwS+Qy9lwTTlF6ewz
 tG0Ku5sLhsYhPul9owpkYtHixgZkl5DKdsxJoeY0iUZJlYNYNTnC67WE89x3Q1GglrD6
 cv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902911; x=1726507711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WmJ2ujIulBhjcVgZsB5TPEctVhmiUOFaoVw5hh6PLPo=;
 b=Bs6PYGJnnfVJtcrzZbplpeVi1fjqMik4qeI0C0iFSA4HBCf4hC252kM/lnkIkVoB9z
 VXnVYkjnTSrj5z2g/QHGnB8NKde1jpePSqdL/AUTEEtZR2zXcGOURPWLoKZQNElHozI4
 OxQHpIur41pDS5eTKKgRJZpg36u4vLGCtHpUImL4pC8A46s14e4mMMXM8r4idFeNyQl6
 ++EoFdc3aaDHnvNpvWSmyf8bEjoG7jD3JFCVUeawou3I4gIgkZJu9WasGMDR8+GfZluF
 K8HyMDexq+NM6/msXy19qK2Vzn62ZFFR0u6aEN4LD6ARAENBdZaDnMn0Tx3JzC3R65e/
 mbeQ==
X-Gm-Message-State: AOJu0YybYSgFD6bX+6IPFKN3w4UFYZeK6NXoYxCp+cQOsGmXyD5IXl6R
 sg8Vyhd5QPNhbDDJCrEE9azwxDMF6MGAmCgwoBtJv0CZpSdlj28arzpQ3aoy3CnV96D4hbO7Ogf
 z
X-Google-Smtp-Source: AGHT+IF1azunkvH0BNPYGkFZHoRgQxQXkT7bM8Kzgvrvgru03JfjdrMXwu7SYF4a6qYVsXHpxPj+FQ==
X-Received: by 2002:a17:902:db04:b0:205:9112:efc7 with SMTP id
 d9443c01a7336-20706f6ed71mr89466625ad.30.1725902910977; 
 Mon, 09 Sep 2024 10:28:30 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 06/26] softfloat: Set QEMU_NO_HARDFLOAT for m68k
Date: Mon,  9 Sep 2024 10:28:03 -0700
Message-ID: <20240909172823.649837-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Like ppc, m68k needs the complete set of exception flags for each
instruction, which means that float_flag_inexact will never be set
before each instruction.  Thus the hardfloat path will not be used,
so we improve things by compiling it out.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 027a8e576d..0e4ff874e4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -220,7 +220,7 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)
  * the use of hardfloat, since hardfloat relies on the inexact flag being
  * already set.
  */
-#if defined(TARGET_PPC) || defined(__FAST_MATH__)
+#if defined(TARGET_M68K) || defined(TARGET_PPC) || defined(__FAST_MATH__)
 # if defined(__FAST_MATH__)
 #  warning disabling hardfloat due to -ffast-math: hardfloat requires an exact \
     IEEE implementation
-- 
2.43.0


