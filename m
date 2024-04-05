Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A730CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglA-0005zp-LO; Fri, 05 Apr 2024 06:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl4-0005xl-IS
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:18 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl0-0004ej-Ea
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:17 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5a5272035d3so1030156eaf.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312712; x=1712917512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=anHznBY/Cz4MfTk0yCQsZvoF8eFCJyevU6fe4oFhrBI=;
 b=a0auxoAHpw4KdJUE7mZ2KV4LnrV12c4Xw02M3iC4dw/IbhdrONCpP1so038k8xj/Bw
 +6iS5lezCN7ltm32GMcrc7RLdHgkoZ5ucq0RjlV+RjSDtTym/8afLuO/I6jFsBx2MflL
 mvLps+C7rkbxoFVLYJgTwGTjLAxg+8kmUqJbzrDp1HgYZUrfvAd9wa5czj+t6xVvY1VJ
 udobKnqcmd8SNjNOVZZ4w0FwAblmfOLfTzdfbu9rluw7uiGOSV7HuLjSJCLpa1Z1bwLH
 4BNS8bB/D7mTyTynVSpUeMEkTRe5sMCkEZwFW6FIkrt1fY7yDAUkXbipEaGCT6oE4+ti
 1djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312712; x=1712917512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anHznBY/Cz4MfTk0yCQsZvoF8eFCJyevU6fe4oFhrBI=;
 b=mFX8gErBsyqF2Pl6yLj80T+VefZ/2iLsbN/bZP9fHiuvoguGaAjtC7sTwpoQ+TscbO
 hdC/qxTrQIeCATC/Av/CChKR+qSfmqonp0UtujmDBjcQriuWXUSJL6jYawkHzQlH/v1I
 D/4uJxUuV1UHSUFfTV4jbfsaONrcH6Z5psgFTOp1POZHXYhLLQPfdE4XSjBxy96tqFuv
 0f3Xqf4OjNK1d4V7+Wi28duExomcP641/B5VucPgdt5fy7bA2PaCe0Lx8EAiYYmINQbV
 WTmpqMGFgz/BuDet+O9stArDtpAAylGfSVYIBPq9/R0b+FV9sDi+VJ+IQy/7ijkP7huA
 DTYQ==
X-Gm-Message-State: AOJu0Yw0vGNK/zNNPgy9z47YZul+edR5fflwo6JZq16zLP+EscSCptgo
 9xlHPlFCEfK+tQ4hXKE8aw6WxKqu9oC74no6FIUP5qah11MsLpclMSTf4zV1U2KYh5iINaXfKR1
 w
X-Google-Smtp-Source: AGHT+IEp7BH4drwDtO4GBzJ9FwMFx0vnTmRjHk5vaoOUCsg41pRhnl8iZrZzK6s25EMxvXWkLp3lag==
X-Received: by 2002:a05:6359:a214:b0:17f:59c7:436e with SMTP id
 ko20-20020a056359a21400b0017f59c7436emr1494053rwc.29.1712312712231; 
 Fri, 05 Apr 2024 03:25:12 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/32] accel/tcg: Record DisasContextBase in tcg_ctx for
 plugins
Date: Fri,  5 Apr 2024 00:24:35 -1000
Message-Id: <20240405102459.462551-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h      | 1 +
 accel/tcg/plugin-gen.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 135e36d729..2a1c080bab 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -537,6 +537,7 @@ struct TCGContext {
      * space for instructions (for variable-instruction-length ISAs).
      */
     struct qemu_plugin_tb *plugin_tb;
+    const struct DisasContextBase *plugin_db;
 
     /* descriptor of the instruction being translated */
     struct qemu_plugin_insn *plugin_insn;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 3db74ae9bf..94bbad6dc7 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -329,6 +329,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
         tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
     }
 
+    tcg_ctx->plugin_db = db;
     tcg_ctx->plugin_insn = NULL;
 
     return ret;
-- 
2.34.1


