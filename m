Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EA1CD98CF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXPlr-0005n3-71; Wed, 10 Jun 2026 16:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXPlq-0005lp-Ao
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:43:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXPlo-0003nP-Dr
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:43:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so2174315e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781124207; x=1781729007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tx6DudLGT4l0C9mtb2AcxwOIfor49xO4HpzRGBE3rY=;
 b=SqE1HBqmn8Dm74ms9En+AbCGfG+2My/ZHbXcsqCYOpM+k9KXzKImv+NvyhqiFCQbIj
 n2jeTjJobQrlbpstfmDf73rc8WITkARUBss8sJsWImVNbyXd9toktktZN0+LOYLKkwNF
 v2HIZEE1YxUzcsxrqdANrSLfbB95dZBzaaFJyBC+vdHj+ehw1WGHWRre4cY+pxfByHaY
 VCeREnzE1qrJeKEx9ChNISvzCQaOgD0cxKzR0XnsTT2rmdnPRFZl6fIEyYYbXSdAYtqa
 XTMBLmup4CLZizEr6sn5apgSVbA+n3D6JWtx5YWAzRI8hIu5QKkJm1u6bZdnRo2Ukd1Q
 D7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781124207; x=1781729007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9tx6DudLGT4l0C9mtb2AcxwOIfor49xO4HpzRGBE3rY=;
 b=NgrDnhijMtEKaIZ+7gkAUNPIuXzmHKwEeImEFe+y11NIa2pw+QIzP943BfrQd0Hlc9
 Vi3au+hiVHZ0A/g1FQF6/HTl3u5suUqy4kIKl3WSqLslBs9bvnvrjExlX7OhjtDbfwJf
 ttI6gknU753iplomAv5TtgaOy9it078OXEuCGJTDyCl5EmL7/fkxRuq65LPE0rlPpI0r
 ux0Q6M80OtQ65sAl9py2Obx+x8UFwXUQGXliKXMyXxrntkgfHQ+cL8Cd4aFxhuW3MJv3
 I/M3PiKXbF1dEzuVx5o4y1Mlt4uduRmXLzF0R/8nS3RpC54t0wjAK/a4Z7R9QX85CrlQ
 hL0A==
X-Gm-Message-State: AOJu0Yyk8v/GxxcXdd8YiqO1eeTTa9GOQvLtnUKsASoeA4x8PxmDJRZb
 byjtBeAQNIMq99syotubOu0RPEsnXISFVZ+BR+4AuJOYX6h6kpR3+WgLgqdhksDwZokFIZTEfsF
 4B+Vf
X-Gm-Gg: Acq92OFi/G37HiA+kiOgLe7nDKQkqfqScKLxA8mrObhkem2EH3+M7FNHzS1lkuRZ+Co
 6eYj+HCujWw7onnhzhDli4UEtFplT5qTxQ9CAJtvut5Wt7Lf12AJmZ0c4+7+Q1MyNNpi7hFLf2k
 tmVkJfxOKgkX2KpD5vS6/ftkh9/o8huDUAKAdB/JxmwpaQWTRv9W9H+qa6Kqrmxup1VvVt48/Yh
 d0TDAJKwEMX5OHuJaCFIgdFYtwuSeFXjRYBTEBnC886ZMjbW9tQwToI/CDJZHJIPiJk33WtPEma
 lTCWXHjp0P2spM0d7TsqbZB7EV0PcBz8kFva2igDlPOGq4C6T5AXW5b45ba3K+fwNwXdHW7nYFz
 zNzIpn+gnmyv76DTC3fN+7NhJ7gWDV2U80hI7yue+YvI+Bezq8p5FGXnGSK1+Tc5PV6rYVJOUMA
 3B/pOLDFafJmg9wR8556W+EvyOiiYKabDBlg==
X-Received: by 2002:a05:600c:1c27:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-490e34cb3ebmr2166545e9.16.1781124206768; 
 Wed, 10 Jun 2026 13:43:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2cb2f4fsm11056255e9.15.2026.06.10.13.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4AC7A5FADF;
 Wed, 10 Jun 2026 21:43:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 3/6] target/arm: trigger timer recalc on SCR:ECVEN change
Date: Wed, 10 Jun 2026 21:43:19 +0100
Message-ID: <20260610204322.828645-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610204322.828645-1-alex.bennee@linaro.org>
References: <20260610204322.828645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Toggling the ECVEN state affects the offset calculated in
gt_phys_raw_cnt_offset so we should trigger a re-calculation on its
change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5c640853060..22f5117ee54 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -37,6 +37,9 @@
 #include "qemu/plugin.h"
 
 static void switch_mode(CPUARMState *env, int mode);
+#ifndef CONFIG_USER_ONLY
+static void gt_recalc_timer(ARMCPU *cpu, int timeridx);
+#endif
 
 int compare_u64(const void *a, const void *b)
 {
@@ -821,6 +824,12 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     changed = env->cp15.scr_el3 ^ value;
     env->cp15.scr_el3 = value;
 
+#ifndef CONFIG_USER_ONLY
+    if (changed & SCR_ECVEN) {
+        gt_recalc_timer(cpu, GTIMER_PHYS);
+    }
+#endif
+
     /*
      * If SCR_EL3.{NS,NSE} changes, i.e. change of security state,
      * we must invalidate all TLBs below EL3.
-- 
2.47.3


