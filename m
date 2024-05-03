Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28DDC25B10
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uyN-0003iC-Qh; Fri, 03 May 2024 11:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uy7-0003H9-LC
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:05 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uy6-0002ke-3P
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:03 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a556d22fa93so1171399666b.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750620; x=1715355420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlnSWxk2ckicORZmY3MYyhbs7CkzbKWbFMF7/22EQlk=;
 b=QY77vbzuo/L4noxT8m+Z3aT6G+HxboxSVbS/o9ZhA+qLlWp7utgXhTm4pYoXSyedPj
 Qc5NFSKM5vosYPniyyyTxQ/zrP6mZvZhcvl1g8IRhtLJooUP3e4eTBSRQInQUXyO6sWy
 4mF/DJbQ+1n/etO5CbcBtahZLd794o1Gt5mVdek4lySpCvRgttTHooBz8jlqmzuljg0u
 qFpAIb0m8J30gw2BvThprYy0N/D0uVKczgz6p1b3EX62b/0yfNCVLizfQEugw3YBbUdM
 rk03rvEV3x+QgT24DpG7p6Yv7wnaMWQxcZ7ecd6BgUperm/20sMIN+EKGk7jm8QKcdJG
 oDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750620; x=1715355420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlnSWxk2ckicORZmY3MYyhbs7CkzbKWbFMF7/22EQlk=;
 b=LWJFBt/9ZiRHPdZJvfemeCh4wmP7R24hEXO2nQueQypmwoV9aLi/vcb4Q1RwQelIzB
 01No3gkIIuybL+lJF6B4htBL/64Nv4wQBjTNo2DUKpH/SEbGO3Q80QB8oDu5S0ecxs++
 Sv+HZUlICXH3pH01iwu4ZZFHy6ZiZjEOb1/VabzcXFatQ37PMSUJXjieaa+BBJWGj+Q0
 H6CZHFjk93/7G0pSpYnPaRrY5u7oOHNUOQtLhLcoitECKdMMGn4RJHkL68ypUBj7WaNu
 txvmZM36uuuY5LXYMhIkBq9Ci9RlISgQdZ5QpAficGnNXY7GSsALbJEFta3NsCzW57Qk
 B0AQ==
X-Gm-Message-State: AOJu0Yx+mJCjyEJWJHvvF2H0md1gM4KVWnTUjNLjJktoydPJ5ImJ4V3d
 XDuO4hBkecHbX/j+kBMosOvMIZYvm/KiNv7DfsWdjmA0ViHOKCY7Nj2cy48bCOBkN18UFMiS9qO
 M
X-Google-Smtp-Source: AGHT+IG2v/TkD232kbxZ4sbwld86DlpKEL0TpPFek3f/Rflb6q63KQobkHyp4fDpFgPUD+xhnZHKDQ==
X-Received: by 2002:a17:906:3811:b0:a59:3eef:122e with SMTP id
 v17-20020a170906381100b00a593eef122emr1977695ejc.36.1714750620130; 
 Fri, 03 May 2024 08:37:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 mc20-20020a170906eb5400b00a599a85777dsm483492ejb.153.2024.05.03.08.36.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:36:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/14] plugins: Update stale comment
Date: Fri,  3 May 2024 17:36:07 +0200
Message-ID: <20240503153613.38709-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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


