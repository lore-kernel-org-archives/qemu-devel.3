Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFB3CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjb-0004ms-Ln; Thu, 23 Oct 2025 10:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwja-0004mY-EK
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjY-0005ZW-IB
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-426fc536b5dso692391f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231367; x=1761836167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mpia8VtBhyjUZ96P3AibBv3IBX5aDSXvG00OnWmgK9A=;
 b=N1yiv6lXKESXMI2yIuRZjc95sy0bVkOegnRLkG0sJ5zYjpzPOTfO8xN/+PmJUe0Rlg
 mYSpA9qU/s0EELYJgyIOKi/51kfshsBq5GN/mvnlu8tSPARAK/+UN+MFKql8OF66co1V
 owAVB9c6W/B5Axl+IcO7jGxipagTTM5LFFSUKwo9cBsAEeKuS/5WSBSmU6Dnk52MsNxA
 eGbg6Gjy6xy4eb4qV5bSRDI5q8ZlGE8XQCCP/avNZHSVB91kzdexwtmzLTlgUj4W0lmW
 eFrR7Ij49YCPnWwap0fy4j/WOJhmmgs3JzDxCQ49NuImofSVIqMO054VgAwNfJJQ/M87
 dtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231367; x=1761836167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mpia8VtBhyjUZ96P3AibBv3IBX5aDSXvG00OnWmgK9A=;
 b=CQaBNHdxWPB+k4lt6U+d2w8cuarfCi0r6tbTohsUlYKx2lELO4mh3aV26uZBypPyQ1
 FX7V1k0GwGlsPdB8vxQ0WXlCEDqzO7uvWWURS43bM1sX+JqB2yZJOVRKsiLkVIUHv161
 VvXUN8lYbtUTDE0T243qrCkhsAUoDR/xM/dc1kTpPCJxBDE8jVPBtwtgK4DAjzvTAo0z
 C4H8YyuGitkEj0M204pEl01uCdidfQFZn7O0ITM0LXK2BRb+Dpbf9bVfCENIoerkj29g
 QfnUdHOyZHLafGi7no1VpAH0sPNje1L9kRkssoh9QFU+NsmNKcDswaxV6U7xSN8T8ymb
 rdrA==
X-Gm-Message-State: AOJu0YwV3Pj5j/073e50cnlUUkheAYb6ZtxXPyuOc5Mf8UYxFmU56mhs
 Piepq7dzGE4qFeNBz3G7aTJo6kpQ0A/jvEtF9aScbWWd1TX5ZC0vqAt+wLUrmT1bw5M9YiQUGoj
 vfq92
X-Gm-Gg: ASbGnctR+lEdWYCr7nv1gLacAfp0Yd0I/Gbycp40GRWJ54wH5BJhYq1vACzvENYrvqN
 9XgaXhqw0YUjMlnNOcOMMuHLY0vifwh5yRHpIph+4wRe5J4aqirOs6KgIOA4jZRQgMmwdyfyTdC
 aNjniQ1XjtQ4T2VO4DAqS+xiBV3sZDqPkE6SsoRWT9g9QM82AKM0jmmO8QOfv70MfyPS2s5ynR3
 9kP7GM9lKhSRoBrBvwO3wcPZW8wajEuoH4YUhakMjuW9sWFq5me6XAzyt+xxwoiZofj88PtiQcQ
 Yb9SgZJ9u+Z8GETc73EQRoBxx40vYZzqDe0SrSHsM9IsZRXo7Oq+rFRK+xvhpFGZ+4foAPs6Pbz
 T18TMSF8eJGLO7Ojl4s1ormTUBxpCtrd19Klmtsdf12pYtuUzSH/uCWdr7R1UD9MVEuu/7O53ZR
 5VXVJEmQpTd4gjtuxE
X-Google-Smtp-Source: AGHT+IFsTzjfRBanOU7LaokSXhMprnVaaedq4sxulK9yqSk7iton/NC/FjykliuiYbHi784oVC2s/g==
X-Received: by 2002:a05:6000:26d1:b0:3ec:db0a:464c with SMTP id
 ffacd0b85a97d-42704dc94a0mr18735827f8f.44.1761231366879; 
 Thu, 23 Oct 2025 07:56:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.56.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:56:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] target/arm: Fix reads of CNTFRQ_EL0 in linux-user mode
Date: Thu, 23 Oct 2025 15:55:48 +0100
Message-ID: <20251023145554.2062752-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

In commit bd8e9ddf6f6 ("target/arm: Refactor default generic timer
frequency handling") we changed how we initialized the generic timer
frequency as reported in the CNTFRQ_EL0 register.  As part of that,
we chanegd the linux-user version of the CNTFRQ_EL0 sysreg from
having a constant value set at compile time through the .resetvalue
field to having a reset value which we compute in a .resetfn.

This accidentally broke the reading of CNTFRQ_EL0 in linux-user mode,
because the cpreg is marked as ARM_CP_CONST, which means we translate
it as a read of the compile-time constant value in the .resetvalue
field.  This is now zero, so userspace sees a 0 frequency value.

Fix the bug by dropping the ARM_CP_CONST marking.  This will cause us
to translate the read as a load of the value from the CPU state
struct cp15.c14_cntfrq field, which is where the real frequency value
now lives.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3159
Fixes: bd8e9ddf6f6 ("target/arm: Refactor default generic timer frequency handling")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251013161040.216819-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8c0b8889dbf..2ef9c178147 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2309,7 +2309,7 @@ static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     { .name = "CNTFRQ_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
-      .type = ARM_CP_CONST, .access = PL0_R /* no PL1_RW in linux-user */,
+      .access = PL0_R /* no PL1_RW in linux-user */,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
       .resetfn = arm_gt_cntfrq_reset,
     },
-- 
2.43.0


