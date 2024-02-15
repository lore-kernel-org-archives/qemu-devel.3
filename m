Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3740BC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafeF-0007v9-Cs; Thu, 15 Feb 2024 12:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeC-0007ue-QT
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:44 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeA-0003tr-61
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:44 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412345cca4eso1445855e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018540; x=1708623340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gVKVyr54/cu6N23YdS0aTVdm9ZYArOc/LwzJY2KIje8=;
 b=XhdSZMWg1cIMMEAhCvIyXM3BASqmnACklP0zHYjFZPHnYgP2LpERhG+Jfs2ebK50d/
 XlszHP0Yk7TpXaG6p6V2KvTnl7kSFvhX6LKzJz/z/hpsiIicnldtb1+pxlWzXTmfccsP
 rP/0umm3KD1rYRBSwitOxXSaJptyq8Ka5T8MLWNMaowY4V7FgTR32G2DAjpsbh2fCsh2
 jiYW057w9+SEXklYqwx/m3cGmQC5HTbIuqhWp8EGwdLVD+g+of7kHkdB5YTIbCfMnu1T
 KxdzvsiIXTKlSpqjw4FsxxTv0mZBSFOv+rCKHWGp7oyyt89ka7qZY7Yx3gwHGoxVLADB
 9/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018540; x=1708623340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVKVyr54/cu6N23YdS0aTVdm9ZYArOc/LwzJY2KIje8=;
 b=wOB/4bVsuw8zk17Nw7UHEODRSdPFFTIF4IHEevnwzpmfD0TDtJ+1Af1oE73BOQxy1/
 hKGPBx1kwTFPEUEs86wZ/wt6YMwweYP2bSj/+tFXKjBM+vL50h3GVQHBDfw98MaSxBHz
 EXv22d4dgCBbZLrXXL9TkBdSOEkYPJxHNIZti3Uib3VaH861oUSbVOQZyQ8m3KCmRwQ0
 VrBZK223vLZUNCu+aVdv2X6ZMy8rW8R4KWlyfusrh4q5tBPYMZF9nE2bamo8N+BEs1fx
 +3ubpvDQSfeQynih6si5bAu7hVc+Cc2SZqkw6UKBTunjnklXlEVrcBpki64VuhtEzO5M
 fFVw==
X-Gm-Message-State: AOJu0Yw6xBBITObJ7GA5NtOuP5G/x/9rZvB3+akwmR3E68uq50WutWYm
 /Smfcbf1ki9biBtwEFohh6LLJBMd7IFe+/3Wi3LisXyR8v2V1WufesmOzA99IQfp/cjt3gRyBUJ
 a
X-Google-Smtp-Source: AGHT+IHbyFM9SMkLXxq3dbdsQ1X/NiwD+5VWvaOdjPEUycANxr6OGcXQ2l6beEqQvQT3DcKUTXsUUQ==
X-Received: by 2002:a5d:6dad:0:b0:33b:75d0:9b4b with SMTP id
 u13-20020a5d6dad000000b0033b75d09b4bmr2401064wrs.50.1708018540624; 
 Thu, 15 Feb 2024 09:35:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/35] linux-user/aarch64: Choose SYNC as the preferred MTE mode
Date: Thu, 15 Feb 2024 17:35:05 +0000
Message-Id: <20240215173538.2430599-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The API does not generate an error for setting ASYNC | SYNC; that merely
constrains the selection vs the per-cpu default.  For qemu linux-user,
choose SYNC as the default.

Cc: qemu-stable@nongnu.org
Reported-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20240207025210.8837-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/target_prctl.h | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index 5067e7d7310..aa8e203c153 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -173,21 +173,26 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
     env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
 
     if (cpu_isar_feature(aa64_mte, cpu)) {
-        switch (arg2 & PR_MTE_TCF_MASK) {
-        case PR_MTE_TCF_NONE:
-        case PR_MTE_TCF_SYNC:
-        case PR_MTE_TCF_ASYNC:
-            break;
-        default:
-            return -EINVAL;
-        }
-
         /*
          * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
-         * Note that the syscall values are consistent with hw.
+         *
+         * The kernel has a per-cpu configuration for the sysadmin,
+         * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
+         * which qemu does not implement.
+         *
+         * Because there is no performance difference between the modes, and
+         * because SYNC is most useful for debugging MTE errors, choose SYNC
+         * as the preferred mode.  With this preference, and the way the API
+         * uses only two bits, there is no way for the program to select
+         * ASYMM mode.
          */
-        env->cp15.sctlr_el[1] =
-            deposit64(env->cp15.sctlr_el[1], 38, 2, arg2 >> PR_MTE_TCF_SHIFT);
+        unsigned tcf = 0;
+        if (arg2 & PR_MTE_TCF_SYNC) {
+            tcf = 1;
+        } else if (arg2 & PR_MTE_TCF_ASYNC) {
+            tcf = 2;
+        }
+        env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
 
         /*
          * Write PR_MTE_TAG to GCR_EL1[Exclude].
-- 
2.34.1


