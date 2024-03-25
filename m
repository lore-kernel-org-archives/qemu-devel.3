Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C9FCD11BF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokSD-0002by-Nr; Mon, 25 Mar 2024 09:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokRr-0002Uv-So
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:13 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokRq-0007KB-7y
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:11 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33ed5b6bf59so3181568f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711373588; x=1711978388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzMbY9DE4/3HwqgfxhwLJUdxgeZIWP3uN9BqoNrhiWM=;
 b=Anc33GabkocihGnodBXTH1AjtqxD4Kbpvg2JZKbPNzCTWsBJzJvQlvr1a4raEfZDBj
 vpWYidbEpliZHOQA3XmLZhrQt/Y07nUTJP4EWjIGZa8R6seHOQs8WK9x90rWW4+Rvs5r
 W2AoJFs+F6ceAV6w/8+nWghKAZBMh2qHPG6hGvfWVDejxccajTtShnWkl91PNS3FnE6J
 2cjq/RlXPW6Y+z2yKo2ESdaQCU3OxOTA2PmYNJePNGYSWdudoHMGYOLPcTAkHn0Rp4D6
 vH7QvqoJbrbTQQgTIYPMjLr10yFYRMSLRZHMGgRUJkSAx8VXDJjdtzxZmqw7SDjW4MeK
 2Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711373588; x=1711978388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzMbY9DE4/3HwqgfxhwLJUdxgeZIWP3uN9BqoNrhiWM=;
 b=ilteFsCiBYahAZJTK/C1H8VvhmQHVPL5YhbDoE+gBFx4NGp/aP+vZupnVZiyIY02fg
 02B+soY/Y1RB84fy2hzVGlXTcJvznNsvC5Hn3Ziz5qWRKMs5w0AR/PHeCW1TLTMjUkC7
 lCeXlgUZyxgz5ZX1ScojlVQyema9/ioW0fCXk9ukGq/cKtbOOLbG1OWsxU3uW4f8SgND
 ccUbNbIYMx+pwzy5XwKS6J/u1CqAgBtV2OtqVcFijcMZASsflSayD8icdi4o9LFze2OP
 gXNbxUfkn1RWisCrqpXbQrTsUuxbOtythoqo97APtqHW/83dCzO6s7ra3/jO21EgFbaO
 7AYw==
X-Gm-Message-State: AOJu0YzHbzgy56VAVJJkjqqmJ3ZnCC01NbYjb+HnRkPQb/eUSQGixNNd
 TbLLHKiHsUwZTOLqH2ZlbMby724aFvnnnBYD4VsK0mm4tqL25EplXflCxJEakGbWfeQG2Wr68KQ
 Q/hM=
X-Google-Smtp-Source: AGHT+IFeY2vJu2FC7PeDSmMscT6Xti4bGL4lGsaDwB0K3J6F1wJ2Adq2Fh+BDm/LUPL+NZGiWFiQTg==
X-Received: by 2002:a5d:6507:0:b0:33d:6fd8:90d3 with SMTP id
 x7-20020a5d6507000000b0033d6fd890d3mr5158151wru.4.1711373587797; 
 Mon, 25 Mar 2024 06:33:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 ez19-20020a056000251300b00341c88ab493sm4601353wrb.10.2024.03.25.06.33.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Mar 2024 06:33:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 1/8] hw/clock: Have clock_set_mul_div() return
 early when nothing to change
Date: Mon, 25 Mar 2024 14:32:51 +0100
Message-ID: <20240325133259.57235-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325133259.57235-1-philmd@linaro.org>
References: <20240325133259.57235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Return early when clock_set_mul_div() is called with
same mul/div values the clock has.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/clock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/core/clock.c b/hw/core/clock.c
index d82e44cd1a..c73f0c2f98 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -147,6 +147,10 @@ void clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider)
 {
     assert(divider != 0);
 
+    if (clk->multiplier == multiplier && clk->divider == divider) {
+        return;
+    }
+
     trace_clock_set_mul_div(CLOCK_PATH(clk), clk->multiplier, multiplier,
                             clk->divider, divider);
     clk->multiplier = multiplier;
-- 
2.41.0


