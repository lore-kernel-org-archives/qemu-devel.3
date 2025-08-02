Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11831C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLNY-0008Hi-JW; Sat, 02 Aug 2025 19:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNE-0007sF-HR
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:10:46 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNC-0001ct-PO
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:10:44 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-42ce1441042so1168709b6e.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176241; x=1754781041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcKY3nbqGoTt331KVt3AQH8Upmaeqmua001Bsshfz4I=;
 b=NLSSXMXlDUxhWz8hbMPQasjeyLeoIe25CsmTKJ+Oz0z9/L3nZGQ4sASwl13Pnd2Hhq
 ep6gRLE5qixmwOQ477/e/tkbpUdMCyrclxdqIMkXotqxyZWv2CJgMFwHjXf/iojpS+zo
 G+rq+SUsv3KWxLNQhZCuKUWCcnyKhBg4fRT7UBQZ0fUQpzSNdkgbuXsHzZSzsfb2UXB9
 vlvS6HJvWXwFpk2gBFXZihgwQCWldmWaU/AMPikJ9YA3wVvl3S8IqmtQSNa3r527oSHr
 gEjQoipG8lA6gB05+mEaBfX+Y29NDbaY5xWDf7wniSC8w4Da//ueVSauVlF7ZqID/XTt
 xiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176241; x=1754781041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcKY3nbqGoTt331KVt3AQH8Upmaeqmua001Bsshfz4I=;
 b=j9lg6cSAt8Z1mPm/zhyrhIKRBWwwsqU4yxnuRpCglfhRdTXcowAU4Hw1nuN8rYXyEI
 tMUF9Zpvjygngs8O1wi3SV8hN8Dn9n613StfEf+oPO/1Em/Gtojd13ozOKqiR1yItUHD
 RZFbdi/RAQsmMHUEYeEIuGfeR9jqzT0ToFQLe9LmvNYonXyF31NRj0vairLmHtxRdeOI
 yC+ww+p5diqfA+ySTYYzTo/bKLNqOj99rcAqaXmJEFJCy8XF4qA2ktdxYYJyx+CoHDQR
 nxx9b8DeGacEF2U3QVDnXhbUl2+D2TEkninzdKMnZK9JDO9URNLqlp/qpXe/3uTBCLX9
 /dDg==
X-Gm-Message-State: AOJu0YwAV3qv6pI42+48MVoGhoXdF6biZzTADkHkqBVXaE0/03nDeo3u
 ooaT7MlP4fHLdN36wD3NnC2PEd1dBFyIeCQmFlM3tTvrGTNgGqjtFdWi1WpCrY62xRmCIL80T9c
 CkaxoDa4=
X-Gm-Gg: ASbGncvj0A7l00vWSIG+YnqSyshw+736SUZ7e3IeX2sh/tZcVYFLoLpeB7ZZG92nIHt
 znMaEs+S6xemc6wyEcpo2rw1jLttc0/V9ajmkUrpaXL30WyXsBGDR69vYr94tZ1Ibkmi2td+Xyv
 g+2M+RIKBdpdvzFjTcvsK/8KDkRRwxmsiMDvoR6FEUWnyjgMraSV1NhG37W2w7WOXwYHD++EAN1
 49gkzx7YmDZhQTJhNd6Ghpdpdy0cmqMWRNPhBLAmaR+MPJTAmcBUbaFvlNBDsvTpOpl+6iZNjZ+
 h597kKILBpDCi74RuMdMDtGbsf20J/+DRxhMeSt75A1Xm+FiuNCjFUQYOKkDWyHsD7FF1JEVe7J
 TFlJQ2GXSNHWoSDPYru57FbkYwf+uGEJB3JwHTGp7+DCB/AosTgftY25dPDo5w74nO3egz/fESg
 ==
X-Google-Smtp-Source: AGHT+IFFrwVFR4mJnfxBxxg3Pe2olsV3CMwXD/7caTi3cwJ93bzxNbkxsnb/yK8/nLjr6yOPo44KHw==
X-Received: by 2002:a05:6808:3086:b0:433:e818:bd95 with SMTP id
 5614622812f47-433f0250c7emr2607540b6e.10.1754176241248; 
 Sat, 02 Aug 2025 16:10:41 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:10:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 41/95] linux-user/hppa: Create init_main_thread
Date: Sun,  3 Aug 2025 09:04:05 +1000
Message-ID: <20250802230459.412251-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c       | 13 +------------
 linux-user/hppa/cpu_loop.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 556f11d720..4876e4b0a8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -864,18 +864,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #define VDSO_HEADER "vdso.c.inc"
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->iaoq[0] = infop->entry | PRIV_USER;
-    regs->iaoq[1] = regs->iaoq[0] + 4;
-    regs->gr[23] = 0;
-    regs->gr[24] = infop->argv;
-    regs->gr[25] = infop->argc;
-    /* The top-of-stack contains a linkage buffer.  */
-    regs->gr[30] = infop->start_stack + 64;
-    regs->gr[31] = infop->entry;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define LO_COMMPAGE  0
 
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 9abaad5ef8..3af50653bb 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -196,12 +196,16 @@ void cpu_loop(CPUHPPAState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
-    for (i = 1; i < 32; i++) {
-        env->gr[i] = regs->gr[i];
-    }
-    env->iaoq_f = regs->iaoq[0];
-    env->iaoq_b = regs->iaoq[1];
+    CPUArchState *env = cpu_env(cs);
+
+    env->iaoq_f = info->entry | PRIV_USER;
+    env->iaoq_b = env->iaoq_f + 4;
+    env->gr[23] = 0;
+    env->gr[24] = info->argv;
+    env->gr[25] = info->argc;
+    /* The top-of-stack contains a linkage buffer.  */
+    env->gr[30] = info->start_stack + 64;
+    env->gr[31] = info->entry;
 }
-- 
2.43.0


