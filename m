Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EEEC5AD59
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 01:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wssQB-0000Hg-K9; Sat, 08 Aug 2026 21:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQA-0000Gq-80
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:50 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQ7-0002Hj-Vc
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:49 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so829134a91.0
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 18:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786239226; x=1786844026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KIM92dYKj4IImhb6gA2mCC61KUGnHOCCs2e0Y+4NqIo=;
 b=tBt6XCW4pcFEqCwX0WnFIufNY0GxdAHUBJGxv5qLZdWkoT6kkm+P0GkoZidwdPBKiI
 as3DxjcmOE9zlCOCF2mnx09q/pyxtfhRae4STieekCPCgwGwBDN562I7lZhOvq8LslGM
 loGwzm0JHSKx1ycLjwAEtr2OOzc2w4xQeW6uuYebxbGWhoZrSgSB8sBy/xIqFRSxrGS4
 xzxkn8bWBYBzU1qJg/Y4BloypCTaWrdlnNaWYo7YY4fW/21QGfHS2ZFjgCljVzl0Qu2/
 IQjUswJS4ke8TGYhQ6K3E61A5PZY31XTulAzSzcKrhzStT1ih7XUSa4nrBY8AVCqNifS
 KhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786239226; x=1786844026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KIM92dYKj4IImhb6gA2mCC61KUGnHOCCs2e0Y+4NqIo=;
 b=P75jOYt7GTmuagdm4m/zxOfEMp+dnWW/hkrkl+hCvhH6M1RloNFvnUL6rRG0hsKRdw
 IJpnCA99cXNfrrXH2qDRf/PWpYVijsFxbKrjpGun0ADQFM1iXi99TB4s5I3+LVVMw5CU
 WDOUJuLD4N21X5+/Nt5eD6cH34Zfvl8ASwYCTMBtGWXy0l+dVq420osIUevtF1Scyoxc
 s6AR7lA1AAmVxv3o2+6OziRDouApMZCnTHT5+BKxokFZtVKBnBkAV2ItJm/RiSQMn/TV
 q7Fat9Mz2uEwdyrEvXCCeA0jIteGNbYehWC6c1iqeTNkNDywtKpMkBs+rsMy/1lqMmAU
 lO8A==
X-Gm-Message-State: AOJu0YwkFaSmfAn+gQuHO5rsqBblBqXBw2ilZnn7lKgcGbdNmjSnyWzd
 wBVJ83d/szrpK/pYpqF/6qKK+7Dt2AxSXWCrM3X4u1XKD+lrM5YA9w8slQ8+LWRBKYwut61wEuy
 lTwxq
X-Gm-Gg: AR+sD11Bf2Yc+YdZcxP4ROtQR6UhHkCMT6WQm8UsZ1Ob3o9kIJlzwRHSdjQ30feaEzv
 CtsyOEFX8siYT1P+VZXkdQTRcJL9KKTczF/t0xMfZVEK9S8Mk3erI80ADwQRJMx803EIz03xau4
 W0g8o4Mn4vylRtWSsGPBZ7mY7BRBuV22oaWfDN6u4sowW6XVvLdC4t7BxBDdtgNfnIgU2rKQ70V
 ACpD+9A8jWRF/w3GLv6tPE483KA3PTODwwnGgXnlAJvFnWW7Ar72qKVrZUjcXLoqdofttzVSzSH
 huI0BYhyxihAo1x6uU2vkDzJLo2LBa84SpQbj4zQH4q1rWvamjaBB7sJ9rO8DgyucXXENQBcFRH
 INkWToNY1BzL13HToBNtU3gGtUXy9U4XHQJpOhxCFJc93/Qw9ZQuPGlras4w1PvHPV/P+lO6zGM
 5JLTLGxLPSDKHrNOcMupnBngNeqYwTFBCUkA/lUbmTlxl4dlS2ezIW4Gd37DURRPPB/64Wosmjt
 yL6c4fupXfIu/ovVrYT
X-Received: by 2002:a17:90b:1e53:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-3903c54cf2bmr31311730a91.4.1786239226433; 
 Sat, 08 Aug 2026 18:33:46 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085de8ddcsm10067927a91.6.2026.08.08.18.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 18:33:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 1/9] target/riscv: Improve riscv_has_ext
Date: Sat,  8 Aug 2026 18:33:35 -0700
Message-ID: <20260809013343.664966-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809013343.664966-1-richard.henderson@linaro.org>
References: <20260809013343.664966-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Constify the env pointer and return bool.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c9dfa7daff..376cff656f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -615,7 +615,7 @@ struct RISCVCPUClass {
     RISCVCPUDef *def;
 };
 
-static inline int riscv_has_ext(CPURISCVState *env, uint32_t ext)
+static inline bool riscv_has_ext(const CPURISCVState *env, uint32_t ext)
 {
     return (env->misa_ext & ext) != 0;
 }
-- 
2.43.0


