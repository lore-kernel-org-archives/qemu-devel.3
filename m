Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586BECA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXYa-0002QV-12; Thu, 14 Aug 2025 08:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYA-0001tH-4O
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:24 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXY3-0004Kx-2D
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:21 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-323266baa22so793910a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176352; x=1755781152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NR3W5du9ZFi4qPy6YJwkknWURFd+s6CJ6eRMr5OXqWE=;
 b=nncKknFeoKGtKUk/uqhRJ4h0wnXToyjQs3NkF4qJRGD5vX2FITHUC5rnK1O0NTR/Il
 q+0dNnWQC39bZj3xin+SK4MpnEPZkLGVz+AU+/6xf483SEwCX8QYnvuEwxfS3jrOHwMf
 Odf0IeMJ/MvLTaIYC6QLZzSZxhb2nIxOMF9GhuPqY3yAVqWW7vDYCcYRbIytXNOXo4IX
 GmpZsHFjPANh+lDMSTHoygXQnRFgx8ha3xHekZBoouI5AcAO9EfksVldYciXefuzu7mQ
 boxBStOJ3p274WrEayliHeCWF8cyT07dLvX2vr8gCbPvIDscwqRDj2Qxgy0ouXrr337Z
 HdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176352; x=1755781152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NR3W5du9ZFi4qPy6YJwkknWURFd+s6CJ6eRMr5OXqWE=;
 b=bRPmchmmiHFRH5/DTPvBp6477BAyJVv3EEjUODF9G+yZACx/MEuTgWgCLheNmn1rOf
 ErORKzgEvnTUfyNS36DwLj6g7ntBoOj8yTqpi1gLeJ8zNfGegkBBPch8N0nFmzRwM6Q5
 3YAjTpb+jafBB/WLILbhc/JDYv8wXulp/lf50G+vc34F6bxCFv7+MYX6BtNc7IO1eq9m
 FYdnnWQ9zR7Ke8UIHOAzmL9f4Ekc2oZNcOmbWHSZ7UfoNApBRmxC/s96yeARzM6hidVf
 XrsKl0UZKQuiaHnniuHIZuRokSFuRAqUr0kOA4DkulN6CpNux1cwdBhXDwK9ZM8Cc8Vm
 pNhQ==
X-Gm-Message-State: AOJu0YyabeOOsAYDILG/mZDqnNRG8+dVvtwHJtTM0QpMO0QWgk63RS7J
 DZdQWdREo6yjVIqIwqDkdp1DGDazgA9uP8AkkFwDIbOme9EjiSTRj1xC8fuQpv0nJAtrCvFeVDO
 chr6kBTw=
X-Gm-Gg: ASbGncsPH8CrMsjf9S9i8cxpCxgmTnQFTMwZYoaEm/IdSQmNJXF8k6N877g0GlQkA98
 3+jM+b0hNpsjfzSH+1G8ryQTyn2s0uEJ2NN1i5+H2Id+OPYaNFE9w4PIabKTxImox904j54tYFB
 O9DkaFGwnMYEjmKCEoCYzFmDCyAgyKLVlxBbU9szxiJ600AdawVf8ugmmi20VpUen8M206eYTKS
 GFkhRWyrolzI3jGe9+jU/n0z8uPsCSYr+Vg8OPLqXRcoQicUVEBpxaVlhIoFQpsunvY9pn/COxr
 iZTje5inZB4GuTUpKpymw1Jiv7Kp1WOLVqsz9P/0R+yrw+BdRC+s0pCm602RGMhAVr5gqXCZWq3
 /oQs8u0ZKrM6YaLN8BzVcySBSxxf0Q11lojcmDqW/CrcAGyQ=
X-Google-Smtp-Source: AGHT+IE16wTyEHV4JHno6gXkn6uhGWf7om6i/p+FiFSpzgamHVtEGX9G807pNxxqiOacP8NPU84E9Q==
X-Received: by 2002:a17:90b:3f85:b0:31e:9cdb:32df with SMTP id
 98e67ed59e1d1-32327ab3dfdmr5237021a91.10.1755176352072; 
 Thu, 14 Aug 2025 05:59:12 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:59:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 22/85] target/arm: Expand CPUARMState.exception.syndrome to
 64 bits
Date: Thu, 14 Aug 2025 22:56:49 +1000
Message-ID: <20250814125752.164107-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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


