Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657D1C25B10
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 21:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1COy-0002yb-Cg; Sun, 28 Apr 2024 17:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1COp-0002vb-C2
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:49:31 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1COn-00012j-73
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:49:31 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a55b93f5540so505639766b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 14:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714340965; x=1714945765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlnSWxk2ckicORZmY3MYyhbs7CkzbKWbFMF7/22EQlk=;
 b=Qh1OCHHE7tbSobxDJkXN+6ak85WEP03064n0Qr9NphLEE6UXJPzOMJErGOUmuO2x7y
 UdTl7Etl9dmziHK2n7sIdgaMDq/6PKx5IHNfZhsheuTly7885rkt0ZzThhrYizeUBOuO
 md/G2M+8D98tJ3VLErFZwysSQI+nDgPOAStEPF3s4rg1HYMVzdRQUChs59jtHrl2SoYO
 0zk83wzh7RZuT1NAwpxnA2h8xpxrEnIVFFjN5YG2cUpdEgUy/UtkhnslpGHAaIKkOPXs
 RAfD3J4zw8R+rhflF5Z8yj1mnB3jE8TEpFCwVKx3kBqRJ7D6q/BMI47q3V3ixqZbJb2e
 4mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714340965; x=1714945765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlnSWxk2ckicORZmY3MYyhbs7CkzbKWbFMF7/22EQlk=;
 b=Ak9E+0bOeHsVdTvbxwnZzjyX8h1VSlIdJ3H+/tXpHjBi8vGtOiRi23FZUzQSZy5Y+R
 OSME/GF18MK1Rf4XQtxpaMVASzG6pt9jDkNYhS+cIerNqMKPFlghQgJkDUJehXWPOKwC
 fQU+eAAxZ02YZoNVULiKt3dVtjSNH7NTSj/3JkgjTrw84qGjeVesRXA1VhNgAtWEcXoM
 LT9F2pdvZgZHhu7VnSuqkhE+7p5TB837nvBYbtmEYLTWzX2X4q9U6IySS3UWTC6H8Vt8
 p7WTbsS3UfQwmndDyO1cTdlw142RtNdZJW9+OETvZr5gZ5rLauOscF2TZvjKQSmOGlzc
 FTqg==
X-Gm-Message-State: AOJu0Yy47CGb5piENAUiQ58VdUiqu++vEN4HXKSVYZ4LXSu7LbCjYDRB
 6ZISPurqpZTquTs9KCXT3U2GeQdBFQ2yW996j6pEMyVzPRyzzI8EqsR14UgHgjPrdCyDe39VQc/
 e
X-Google-Smtp-Source: AGHT+IGhqp3Z44Zq3Zyf8WJt7WMs3PAAlvxnSP8g/OBw3x8NJsr+MhgiRYjUvZGdIHJjj1wYjXQP/w==
X-Received: by 2002:a17:906:c288:b0:a58:7283:f587 with SMTP id
 r8-20020a170906c28800b00a587283f587mr5365104ejz.33.1714340964816; 
 Sun, 28 Apr 2024 14:49:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a17090639c600b00a58d2a48a6dsm3131201eje.192.2024.04.28.14.49.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 14:49:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/12] plugins: Update stale comment
Date: Sun, 28 Apr 2024 23:49:04 +0200
Message-ID: <20240428214915.10339-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428214915.10339-1-philmd@linaro.org>
References: <20240428214915.10339-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-3-philmd@linaro.org>
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


