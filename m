Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFB9C25B4F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kQg-0002kK-Na; Sat, 27 Apr 2024 11:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQe-0002hs-D6
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:32 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQc-0005Km-Rg
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:32 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2de233961caso31732181fa.3
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233448; x=1714838248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQ+WqvRqZbe6NXFesfOZIQa4hGw4rQ6ubEcYnFEz+AI=;
 b=lNvu9q5bauNTe5wlRSEsdnbjC4sCAf8INOFZ0I7+bCrt/7RbkkMIR0uLMg/0GjTQdT
 y1LQLyq7qhsDmTMXH3sR0WKJVJGb9A4SrjC+omySk7R9fGYy4JWzk4MTX7NSRD4bXMgM
 0yJbRARZ8gKFbPAgVkb1q9Ym6GtCNnCK+0VE5nu087aYgfohRYeNZR1eH2xuuncJydbq
 0twT+6d9ZmYjEb9TTXGRkNWe4iwVHzqLhGOr/OCwEX87jmbrAxEYbSndBevUfVP83qdi
 hrLRwcvW35SmlzuVrqH/OSDn3PO9nptMigNzkJVpBJOpdpVkqhyOO2cPA8NuCfGVF+sF
 Mgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233448; x=1714838248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQ+WqvRqZbe6NXFesfOZIQa4hGw4rQ6ubEcYnFEz+AI=;
 b=vaBem8k5RpLkrPDRax5tONXEZALAbZ6ICfayIwK0VB/LMfDtLQiVulgFqF4G4zht/3
 W4MPErxL+SggH+wL8ThHc0Ao6KUfp9CSe8I53K/TarySX7raoTdZfwOeaVn4kztgEq4/
 nI4gHrJyt0HbGYSXQc4Q5+1X+qxQVwNid5MMPOR0lUDnFGZAtmb2Wv95knBTZQUrf18H
 aPe27xYQt/AuDrZAMcFVLWwJs8gkIfHkgIoYLtHBBkzfBGsBNdw93Z7exf7SMsuBnh/T
 /KFAS6LnspMi2ZhAybo0qpxjrG7vXN8xkUmDq7+a8C3cYAcXtQL/MPQolJPASrRXYeoK
 lBmg==
X-Gm-Message-State: AOJu0YzXLjeJVOGf/M9i8W1LcnKMhx4hDw/GAsFrSrIuR6KNZ5PvmTcz
 pER8279JFnAibwp+H7/50lC8m18lIpsmipALqQWvR4mBpRbulifcti24JhSjyO18VeGKf38BL0R
 x4pM=
X-Google-Smtp-Source: AGHT+IG2AT/myYaLCtNSriMrm+d5WUvxSl7nv9dT/U3dgvZGpkPyELY9db1FpMQ2wKlNBdvTh6gCMw==
X-Received: by 2002:a05:651c:150b:b0:2d8:5e21:8eaf with SMTP id
 e11-20020a05651c150b00b002d85e218eafmr5658132ljf.41.1714233447776; 
 Sat, 27 Apr 2024 08:57:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c19c600b0041bf5b9fb93sm1092322wmq.5.2024.04.27.08.57.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:57:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/14] plugins: Update stale comment
Date: Sat, 27 Apr 2024 17:57:02 +0200
Message-ID: <20240427155714.53669-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

"plugin_mask" was renamed as "event_mask" in commit c006147122
("plugins: create CPUPluginState and migrate plugin_mask").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 plugins/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/core.c b/plugins/core.c
index 11ca20e626..09c98382f5 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -373,7 +373,7 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_TB_TRANS;
 
-    /* no plugin_mask check here; caller should have checked */
+    /* no plugin_state->event_mask check here; caller should have checked */
 
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_tb_trans_cb_t func = cb->f.vcpu_tb_trans;
-- 
2.41.0


