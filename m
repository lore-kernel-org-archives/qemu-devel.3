Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C698E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSY-00015m-LB; Wed, 11 Dec 2024 11:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSW-00013T-OG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:08 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSV-0007pT-Ap
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:08 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so5589194f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934066; x=1734538866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=upixniKzEOa/S8RuV1mPlSnfanTUMOTGZth3cr6koyg=;
 b=wweJC04kThYMzGYHF+xt221pAitEWwFwb/kxhw0Vjw8kqXg7P4qZg6KDwx81oMZyJV
 XJ4UR6G1cTgmonPslH+I44/mqJS1sT8Ez0I4BzS2AbQW05JAe4UFmw3kBq638yfrWDa+
 ag8jsYCFY9734RrPWcl4ES2ZmSMH4QP4xswUNC3iw25dJUtsvT+6Kz8RRmig0xuitLuG
 7wnik7/DA1oqr1ZNa+G3JrPsDOexw9xBWQCMiOS458OGIyPcVhcTvrVBRMeAlnmMhrgv
 I2dzzLVfDMXK20kWRd2n8E9KorNKUP30lLPvQYUB+a9P2sTE3YR5cfiuHC2AqQuZ9dbn
 3CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934066; x=1734538866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=upixniKzEOa/S8RuV1mPlSnfanTUMOTGZth3cr6koyg=;
 b=sZjbo7M4WijXahJo9HLHZlcOIe+dksKtMmIbFruC3bqCSL2I5TjB81Q/EoBgnBsKQh
 fXz6KMVFne06p7A0vP0uuG6YV59U/AvRmz20lfwUJlS+jLOZ6y5H0w6XJTgduVw1VaVd
 TOGX9rTwmFxs3Nq7o9Lto+xw53FRpBn3DU06ypI0e+01266iL+glD5p2Q7HVZEqsBuQ7
 foeQQbnYmEKVsV7iQHnemJHU2yH23KNb5q6fQEVnj5tAvScOUWNSU8CV5P0Xy03O0Qax
 4kiNN1WUqz88EoVmP8/5Qn2i80o2fnGGJmJhu/YCxglb28iaxlIAaJgjvulJJv7XaEw7
 Aj+w==
X-Gm-Message-State: AOJu0YysPOkb0m/6fiEvNVngdPmD4jE1EFyjLKr6hCHdq6d5zGebJA/h
 zOoc4gJ9FaZdVcCktdJVINNQDzE0SP+zhhrQnUWqXVg3zztXdWlmlQDu7EMAfjHsm3LtfdbLBZU
 z
X-Gm-Gg: ASbGnctE1A9CFjJmVxDw1fjdhLooFpJXZJIAh32XGwVaMhXFAO2MzONSgO0RRNiE3hg
 b6hEI1XOxR87NMaABKMK3EGWebPHRhEPrI/vxWHAlkqGo+KEJzVMPXPt1vyQzOVEx7w/Hm7XO+x
 F9o5xu42cm7kTQbqIBHz4b/1CcuWFNJ/bXXdut4mS93lTtkvtrmoazDtfqKdRwWkNBZiqdyU1fU
 ns1NsUqnFUBJNYTQ8ElKTLWs7Tn9zNDQdtAa8sw5eEsHmVPZRqHuyXWq0pA
X-Google-Smtp-Source: AGHT+IFG2SVLjAz1bdN+gruzFUiAnqPE3iQv2Lj1DysdWGswMOPVqOy4QL8Ek6WmiBalhgbTan2y6g==
X-Received: by 2002:a5d:5f8f:0:b0:386:3e3c:efd with SMTP id
 ffacd0b85a97d-387876af743mr186911f8f.44.1733934065661; 
 Wed, 11 Dec 2024 08:21:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/72] target/ppc: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:43 +0000
Message-Id: <20241211162004.2795499-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Set the default NaN pattern explicitly for ppc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-46-peter.maydell@linaro.org
---
 target/ppc/cpu_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index eb9d7b13701..1253dbf622c 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7286,6 +7286,10 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->vec_status);
 
+    /* Default NaN: sign bit clear, set frac msb */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
+    set_float_default_nan_pattern(0b01000000, &env->vec_status);
+
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
 
-- 
2.34.1


