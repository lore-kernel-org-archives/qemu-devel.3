Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11370C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLjl-0005HD-2w; Sat, 02 Aug 2025 19:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhe-0008OW-8a
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:54 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhc-000569-TJ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:50 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-30174a93186so2672590fac.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177507; x=1754782307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NR3W5du9ZFi4qPy6YJwkknWURFd+s6CJ6eRMr5OXqWE=;
 b=NT9xT0zncpoYCgpt+cP0ZCPct1QsOXG0V3zbxmzV5L0zbmiooomVF3SaFrnawA7KDg
 8pIGxWqNFuynYffQWogifF3QanXKmfVCwZ1DY55bDEZpHmoblIFK41+/p76N8S2+elen
 uvKJopGRnTxpqzuOaAfEVuC0CedJFgQZuRAJHIhPERZDhPy8bB6qaUkVHB8zQJD9s5Xj
 DPCGl2BB0R8ARd+g+lzWdY3YyLPW6nMyJJ+jy9PscnGjRXZWDu3URVYlTzfNZGaYTdeM
 DnkAkFfT4MLlQjDA40be4vZ4o51K2gVXcNbU2npmOljhR384GDdaiWc2ZwklsGb7uX80
 x6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177507; x=1754782307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NR3W5du9ZFi4qPy6YJwkknWURFd+s6CJ6eRMr5OXqWE=;
 b=mbWqD8J4LBYOV3NstoLC/Bmu3T0xhArIML8blv95dmgK+YGohViiVORf4h8Xcx/1MZ
 p8hwWJcd+V2i5fmnQdtFTGgc+rCHZ/Q02ikwb9E+gQ6+FlLGqGCl9Flp9I3iXFS7BGg3
 qJpBjuxAuq7jb+6sx3Xu2ey365MZfi8Yde8y46uBwrSasCDjznnwIYKUNLeIARPA4hIi
 h49mXVg+PD7mgtV18juTMKriqtqFTZ//dRFwhzRAXf4tbkp3eJUU9uv1oGvywBQaXSKn
 4fW/U/DlXl7CE+wIBDXmw8QMI3jByGnTCqafgLPR59CeL/V9iKCXEONqlPuUPOCyMamM
 6Epw==
X-Gm-Message-State: AOJu0YzMLwjfoDOUBuY+REaCTcyqa5l/h7mG/eQBPD4IGkqeNLKRhOhl
 JEQNcUm/uPoAMQCvNdF7TusYir4EoFZ9uP5QAO2sDPwa7rdBHaqI0oNSxjKja+SyX3jOqS6eIzI
 fglLRkVc=
X-Gm-Gg: ASbGnctdTg7Thhs9TnB8MeLMNZKEuBoRLJtHklYqZXwblPsGn9DhYxtVOKFAsq3/lU/
 0yjPSKqYcwGUQn/+73oQHKkrO/fq2U092KsiwlDxBBbKPyO7irRCPJT2z+E5H8qkgd2W4iSlopX
 /U9CI8FsypjtHIL6cf/Pfr7kLfrX5vpxtjLGrdAk/5e9St8WAr51fodYQ6P2BCA35cct4LGKVYU
 g/Dzta2sZsA8rJcQUh5MJ3OJmHIQbunFarZJwhLpWRZmeWxz5l8CztwQNnto9ZA58+a7LX3Di3J
 vDSWUOJwkski3QskTTHS7OvYHlZVQdNKQRdhUCoGpF6UY2CYdJiNvZi3oFYPZtnji4GBgzUQGHg
 NuiQhMNDIADicE5RYeQ2tuGj1A+feZhBzntDtimxrO01EFJh4NZDK
X-Google-Smtp-Source: AGHT+IGJMnEvtsvIBqloejw81L8/1dMitVLEcq4M/I1eq0MXKlQ4VMhdYJBeYpOUnEQZvfKa8Of4dA==
X-Received: by 2002:a05:6870:d32f:b0:307:bba1:d09f with SMTP id
 586e51a60fabf-30b6768a30dmr2446653fac.15.1754177507685; 
 Sat, 02 Aug 2025 16:31:47 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 22/85] target/arm: Expand CPUARMState.exception.syndrome to
 64 bits
Date: Sun,  3 Aug 2025 09:28:50 +1000
Message-ID: <20250802232953.413294-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

This will be used for storing the ISS2 portion of the
ESR_ELx registers in aarch64 state.  Re-order the fsr
member to eliminate two structure holes.

Drop the comment about "if we implement EL2" since we
have already done so.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 7 ++-----
 target/arm/helper.c | 2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fb87fcc3e6..4940bd6a45 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -644,13 +644,10 @@ typedef struct CPUArchState {
      * entry process.
      */
     struct {
-        uint32_t syndrome; /* AArch64 format syndrome register */
-        uint32_t fsr; /* AArch32 format fault status register info */
+        uint64_t syndrome; /* AArch64 format syndrome register */
         uint64_t vaddress; /* virtual addr associated with exception, if any */
+        uint32_t fsr; /* AArch32 format fault status register info */
         uint32_t target_el; /* EL the exception should be targeted for */
-        /* If we implement EL2 we will also need to store information
-         * about the intermediate physical address for stage 2 faults.
-         */
     } exception;
 
     /* Information associated with an SError */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 168557b08f..9447d7ba59 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9438,7 +9438,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
                   new_el);
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && !excp_is_internal(cs->exception_index)) {
-        qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%x/0x%" PRIx32 "\n",
+        qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%x/0x%" PRIx64 "\n",
                       syn_get_ec(env->exception.syndrome),
                       env->exception.syndrome);
     }
-- 
2.43.0


