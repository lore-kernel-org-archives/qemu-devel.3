Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4326F9B608
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUYj-0007LU-7m; Wed, 22 Apr 2026 06:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXt-0006vi-Qf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:11:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXq-0000o8-Sk
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:11:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488ad135063so45769745e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776852657; x=1777457457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fpr3Ng7R6+bvHtx79oLF5EYo5OylKP6gzyU2DP/N60=;
 b=K3rXP9JgvR/oBPJaQBdpU2BDL3IfsCux20qPNp66Gjv5OGuT3kKUBbQAPXyXuLFuyC
 0k+QlLXVOqH29/WWSl1dVrr1rgbnNYfeZjFbPECwRg2hUCnEbsFQXdRwNjBbOVMLfNJt
 V6VdiOINivX2IkE/T9F8+LEnuw62P6VUtT32JrQdV1Y07cjgB2fFR4d2HDL04GJI8bpF
 IwLNrY/eg7v9cXgMM/Xp78XFoydWXymitZ3yONeAFgo8Vdb5xSQ4gS5hJAV/Fg4ENT6l
 3FTPXFNwjyeKw4JwXi7Zj3BH8ACyrg8krhBZ2TNykWZSCWHM5t2FxyVEBt/RFmCQD5wH
 vx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776852657; x=1777457457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9fpr3Ng7R6+bvHtx79oLF5EYo5OylKP6gzyU2DP/N60=;
 b=mn19u2gqqquGC+Tvuevtg6jqdkz8Hv5XyV2S7QDLAUH22/TIP4ap6Z8qKB0QrbiFyk
 G9j8ComctqMzfpwB2HFsohAU8NN+ariEZt2LeYAXERQHJGp9RIaDU3e+8fgL9DAwKabr
 ZwRXKbqZzuskNpoAk/UVrR9k9MMDJWYa4r6o9u3Kb3+1I9Y8Kfg4tqLaWzC6KWn58bkC
 MIApN6J/1ow7Iq2tY6NIZ7R4EtwrSfmYdEhx3xNqRNd8+WpHrpgVERUg5FtgMwi9JKzy
 fpPmX/5g28BgE+889Ns28Gh9HKU+OJykd0bNm1S6dOo/Bg2EQf9gc0LgTtwe/iatAvyl
 tWPA==
X-Gm-Message-State: AOJu0YwMYdsheLrASn0Q5AFsuBlEkM006N6l+yp2NMY0D46OLgcXy29M
 t+HlA2TsYLN9xhMzF5g7sK0csFsTrDbpUcxDiz9qFGGs0WrkFBAo0pcjcxcH41QMEI1ew/DYGbu
 N27X4j8c=
X-Gm-Gg: AeBDieuJaPQQKFrWaKb9JgHvISXV08M+T6B1aJfgvSmUuu/00VMdq/0c7CCRNUnMGuj
 KMfXHEn9xgy01Mb6fwYwKDevJ21njPFjScpX50T4pJDNNBvpXqEWmjn/J713Wv8yMVlBA4nOefW
 7By4sKJ04ROMI1munc/yBK7uf2hz9D4++jRapW5beKz+fKiR1BRTAwqEx6QauvOlo8aQNR62+zf
 olCQhM90uMRJj0Kt3ynVJW2yJurFg1uldtyVdlA5EHLfTw5+HY0gtYr89hYr0obbRGb3G/SAsjP
 NkrrIV6M8uAlEZNo4cO4i0kDKDBe2t89Y/7yu59x10y33hIsBYYJuImsp5ro4ubHjm9SX99Cd5C
 PVjR6a93Jy9+7l+hX8ARyonUZ1dpfU2WbvdvL41F3gdkxpM/GJv63GpsUxSnmaAx9zjdCXhRsfS
 Ev8Up9Xh6k2xuwDWvdLGI7GU6UESVVyIFBb4NeQXvW8o3A
X-Received: by 2002:a05:600c:6990:b0:48a:5970:1fe1 with SMTP id
 5b1f17b1804b1-48a597021eamr47506875e9.4.1776852657303; 
 Wed, 22 Apr 2026 03:10:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1393f5sm410402795e9.9.2026.04.22.03.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B1380610BC;
 Wed, 22 Apr 2026 11:10:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 16/31] target/arm: use syndrome helpers in
 arm_cpu_do_interrupt_aarch32_hyp
Date: Wed, 22 Apr 2026 11:10:27 +0100
Message-ID: <20260422101043.1234229-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

One more step towards dropping the old #defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop excess brackets
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7389f2988c4..40dd070d2c1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8898,9 +8898,9 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
              */
             if (cs->exception_index == EXCP_PREFETCH_ABORT ||
                 (cs->exception_index == EXCP_DATA_ABORT &&
-                 !(env->exception.syndrome & ARM_EL_ISV)) ||
+                 !FIELD_EX32(env->exception.syndrome, SYNDROME, IL)) ||
                 syn_get_ec(env->exception.syndrome) == EC_UNCATEGORIZED) {
-                env->exception.syndrome &= ~ARM_EL_IL;
+                env->exception.syndrome = FIELD_DP32(env->exception.syndrome, SYNDROME, IL, 0);
             }
         }
         env->cp15.esr_el[2] = env->exception.syndrome;
-- 
2.47.3


