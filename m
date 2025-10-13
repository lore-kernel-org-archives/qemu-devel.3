Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A82CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 16:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8L8R-0007jW-Sg; Mon, 13 Oct 2025 12:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8L8K-0007ij-J1
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:10:49 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8L8H-0002mF-So
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:10:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so3105952f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760371843; x=1760976643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/+EHTUCThtQN+m+O/VxTEtMg257BUkao1q2OCXKIy5s=;
 b=GGc7akSGlpTmecqyOPlS80I57cENM88zsjVyUphierSd5UR0VbNxobM0I1Nul7+UiM
 p+7yV8tRN83CgaNzrFVckHiQUd8rTwT++hmQX8IlIsjv1lTnxJgzlCItMdrQprZuS56f
 xrZCd8hXYxIunRabWvDxjWc1tSNNf2j+jzI9ZAUK97A8fp89AX684hM6JM3fxtVj+KPW
 jqYI6WKS1RtqDOKMVFSO1OmzEhZGUttm1t7S93srmqLprme/tbOYNR1P13lGFOVXR0e4
 dMVWD+b3Ww55tCp7DCRhpWignktVgcS7C+LdAYR/aSarZ2OqcOoVmhhPNQQz+mFeCqr3
 8E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760371843; x=1760976643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/+EHTUCThtQN+m+O/VxTEtMg257BUkao1q2OCXKIy5s=;
 b=srIbFGsuXYIl6vkcSQtZfwQlE4aueZWQRMayIhLsJHCpBXaqHl2z48q6jVEIBvBifb
 1gsixzYozEGyjGxAbrmwGyp5CrrrzT3CkV7Q6PPRBYCURW9tkvYdrwqYi89qBT7gVF7L
 6qspJhijHjkHs7qzyV8HnX3vmH0tHb5kvLv7EIx1oQMznApdSG0c6b53fYQ2kaEQBj1A
 Mpd6wJ1EVwD+tZVoLKAyNfzogNmoyWtiYxPSlX75wAhmN+x4JhhQ/rS/qkgPheOR0UD/
 K7t59ZlL1YkwjBxYYVJ5nWbkI0kD6l4mZ8/OYB+7UHo8TrJXh/s2v0GOmrtpHWa9PLxy
 wQUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUI548DYccwGGe2D26vWhyoXSsEEo8LnqJR0MFhGvDSmKU+XoD+iyW6dkhJdboPihySax71v5sMq8U@nongnu.org
X-Gm-Message-State: AOJu0Yxikj7BQxvk7jB7TGFIgMbaesr+oESSPOb8FLgoHWfaP+3tFE8O
 GAUk+mXnIdUR2QxGZGkE9RqQLLoUT5mK5voiy1orub3QGDAtO65fwdr3hUV3tU6LW9k=
X-Gm-Gg: ASbGncs/JTYjtXuCzo2ArOAVSd1FDtxhhVXl8Es2LHDk+/zq4ONTiq+PSZviwnIMQCk
 EuL8YlwF62EqM5QReg47jk9N8pnO5CpPP9QlX3U19nkR/hLrjPfgkySpCkABmAWgmgD7D7TmxoY
 Bql5x/8ig3hVorrYFhZ7tqn+uB01QZ6pWCQSlUu52zhttBU2rBzdUxD1xyzdnzJFKwAcM2W71f/
 I7tpwJ+4hBOmOBDpafo9I60biqAjX1bzDcFDoLlrXJy04iQ/GEd0wr1cZTd5YyVxb2nNj0koqQj
 cyM7MykI+vzHNEFkHSGCLMrSo6qhyEOufJPqBO+R1tRJ++1yHoSOzaHpg/g+/T4HxDseJE32nRG
 7Z/oz1x1sOJgFVG/oULZSzIwwvki9x402tCIcqmxOlL1owAAAUrM=
X-Google-Smtp-Source: AGHT+IH15Y3LAVReqswQHCmpDmwNjSoUGzwUL4IxWBNZ0aeEklCJKIneRlba+0QMfAyk5+PhmMdfhg==
X-Received: by 2002:a05:6000:4202:b0:3f9:e348:f5c with SMTP id
 ffacd0b85a97d-4266e8e9026mr14215622f8f.60.1760371842814; 
 Mon, 13 Oct 2025 09:10:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb497af18sm192750255e9.3.2025.10.13.09.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 09:10:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Fix reads of CNTFRQ_EL0 in linux-user mode
Date: Mon, 13 Oct 2025 17:10:40 +0100
Message-ID: <20251013161040.216819-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 167f2909b3f..1e1c0e41415 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2306,7 +2306,7 @@ static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
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


