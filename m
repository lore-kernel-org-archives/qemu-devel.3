Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E089C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldc-0003tH-4l; Wed, 24 Apr 2024 19:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldZ-0003qM-A4
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:49 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldX-0002ff-L8
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ed2170d89fso1069564b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999766; x=1714604566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSa2977I3Rq8Xc+67Y2/yCKgEWXvHU4DRnUfHiUzUVE=;
 b=rWdA/ZocjsbTHgQyVSCBkurn0kpCIzt7nHMhhe+LkutEV3yxrW6IEtB1DH5o7tYvk8
 Kp/KSg76YryBVmYAMwNrcUYCWh/Z+wZOLX5XOVNveOULK3EElgHhJp8B6QheslEHD1Sl
 Wkk2liwlVTtvk9w7RlpghIMBmTTwk1IpLgShcvOSRjJwwywSUfhZrjVxHICtcAz5zWge
 eVko/0TAxc/lK3VhFi6quog/ys5+EeXResQ72M/VzVh5z7o3NnBji4r7T+WbD86Vaody
 UqkmUO89XZnRNepvP8Rm3pfInDl1aZ3vMrVCab342F9j8F0QBrFIjBnDAuY87v9FePum
 cTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999766; x=1714604566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSa2977I3Rq8Xc+67Y2/yCKgEWXvHU4DRnUfHiUzUVE=;
 b=Rl1ymeJki0CMsuQn2o1g5uxfXR/tgqgyngJbCfY9y/FxUHSz7zvq4YXThKfqwfUB0c
 cSF/X+vSyFdDTuX7KGfxryH5htL+6OuKp8PLXyI7EWoVKwA8PbxqrQc6fWsx4hA1Pbc0
 yupgP+QJlwtphEUUqxYMLWGCV/VpxmRkUv5xsDj2EZJZz01oaKxVf2BUOnw0vYrd8tKF
 OR95n3KeUz3NEEcFAk7TzUQQ9aUdiIfo7+luOymsnRxaQ/KbW5rUKaduM31qJkGwkiFs
 88T825HZagoOoCihq6i0Onj7ZIm6nzhxfc3rL6BOeohMme7dUZ1UVR63wZcGMaC/iPc2
 HGng==
X-Gm-Message-State: AOJu0Yz3Lx7KH/mmmbf3ryRq36pNsokiUT02oVy/llvSVSM/CQQJaEbr
 EsKk+9xqBq0EcQFyoNDLtSewy8mxce/VHScL+mxhivHBN2kyITapEeCAIyy6iVAh7Mc6MbjgWpE
 n
X-Google-Smtp-Source: AGHT+IHG7uTD+ZEk4KuLzihs6mKBz0c+68izpGnO/g7CJH2GlDP0gDDqsC+B1CkNRqzgsb7eGq3p7A==
X-Received: by 2002:a05:6a20:564b:b0:1a9:509c:eba6 with SMTP id
 is11-20020a056a20564b00b001a9509ceba6mr1531026pzc.25.1713999766125; 
 Wed, 24 Apr 2024 16:02:46 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 19/20] plugins: Inline plugin_gen_empty_callback
Date: Wed, 24 Apr 2024 16:02:23 -0700
Message-Id: <20240424230224.941028-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Each caller can use tcg_gen_plugin_cb directly.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c0cbc26984..d914d64de0 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -60,19 +60,6 @@ enum plugin_gen_from {
     PLUGIN_GEN_AFTER_TB,
 };
 
-static void plugin_gen_empty_callback(enum plugin_gen_from from)
-{
-    switch (from) {
-    case PLUGIN_GEN_AFTER_INSN:
-    case PLUGIN_GEN_FROM_TB:
-    case PLUGIN_GEN_FROM_INSN:
-        tcg_gen_plugin_cb(from);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
 void plugin_gen_disable_mem_helpers(void)
 {
@@ -362,7 +349,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
         ptb->mem_only = mem_only;
         ptb->mem_helper = false;
 
-        plugin_gen_empty_callback(PLUGIN_GEN_FROM_TB);
+        tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
     }
 
     tcg_ctx->plugin_insn = NULL;
@@ -419,12 +406,12 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
         insn->haddr = ptb->haddr2 + pc - ptb->vaddr2;
     }
 
-    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
+    tcg_gen_plugin_cb(PLUGIN_GEN_FROM_INSN);
 }
 
 void plugin_gen_insn_end(void)
 {
-    plugin_gen_empty_callback(PLUGIN_GEN_AFTER_INSN);
+    tcg_gen_plugin_cb(PLUGIN_GEN_AFTER_INSN);
 }
 
 /*
-- 
2.34.1


