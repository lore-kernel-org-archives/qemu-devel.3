Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98202C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr395-0004sI-GZ; Sat, 08 Mar 2025 17:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38W-0004ae-Ih
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:16 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38U-0005Mn-6D
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:15 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223959039f4so60749705ad.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474753; x=1742079553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckxZuevLuUfuaGbBEffRCMPAF7260cqu8cz/74iaKKY=;
 b=dMdfAOqUIzYd8XuX2TUOdcuBgDHiHLqlqkvneHVB8l8Pm4zU4xT6id6Wf+/w/xA9FD
 dP0kPokLR7ChkWdaFrVUhQkttSketrP/USWKKcoSFfufy2LH1P9WsoCtEuLkqme2LZAW
 +K6FlAns+byKfLIbot3HqXX9v4kR8AypRrj4Ui3ugtZij+w4JQHflStQKtDcelRPo4Kw
 Xyeh8roLme5aP25cYhSh0mPZsKKHN4zFz535bEJZEcUD0r9USPQbDpIrEI2O13VO6KSU
 gRU8bHZ7lyQuawDGHT7enQWPcvUE8eeFQGS/0sh7zQURTQTivTkEZ0maDGkG7Ho6sV5o
 Bsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474753; x=1742079553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ckxZuevLuUfuaGbBEffRCMPAF7260cqu8cz/74iaKKY=;
 b=li8wmfVKDrJ4o4eo5PMBMpMG1h6VoBrjDMSZlXRaAMlpeIpeZd4vUhTrlwId1BRmLJ
 C/pRtCNzFckAAMu/E87T5PmjvjHyMt/p0UhWz0ujggTD/0C2SCJ0vGiMXYIDu27uBn4f
 0nkAWqIQ82caUaDl2WFh7KxKgLypTBVGaMryPc8Kl+7mQ4Gnf/D/NFWLCTg5O75sQAFO
 nTWPK48/NLwS6iZ6/Vkb2tWel/aJ+ob+HYzmCnp4dmCqremHhHWriqv+74qdzcchRuUN
 24yRL2q1zFoX/Q6LRe3MjGi6SruRenCrJZWS8fVAUfB6HRX+/Owqm7LHUW63n/ZJtutF
 6dzA==
X-Gm-Message-State: AOJu0YwbldDZR3cpWKsVd0H6EbW9otlFznnGnzUOcMCgdIKWtYbL2DI4
 sBkfnDarO+E2AgvXBGeY5GKXxAX6uHUDJhE9/htCaHlEkR+b/ZqsprZ8GZniKBBK3uPqL4pd29E
 j
X-Gm-Gg: ASbGncvGSz8X6vEdAE+ZnIEdTZ+ZAtoP0crXpnXQvKgSzpzWixrc7D9dKqvWqdXvr64
 0+/GYC4udx/ny1+JYAkWgOzapLwHsPJHGAomWl2PFnHiIYNRE/nruTj/n6dkZTgsOKURwySvXLE
 PWOQCTKYdRtF8J46l9JzD2s/M+7EDsfqlPXCvcJ/e9SqRHJykhkK4tuEpEcJDJvpBEVMgclqA0D
 PS/3S43CnXNKVdRLd5kop366JuhItQFXK7ZNoZJ7M5e6kdzpsmgc/CGsA9V277sWf7B+r98czyg
 ng9K/7VDJ56cOyP3sKF7ksv44hT01bcVxjbwEbuAckJj2/8lMHXfRYq8ax+rmKHJa3YdaAxm6LD
 D
X-Google-Smtp-Source: AGHT+IEiEYoPRMQxBxzxapygUV9DqIGFTjIgyouF3X0bt8oGs1CIHm+RpSU34EdBYwPlrJ4B2vqmVQ==
X-Received: by 2002:a17:902:e80e:b0:223:669f:ca2d with SMTP id
 d9443c01a7336-22428bd5819mr141040385ad.35.1741474752759; 
 Sat, 08 Mar 2025 14:59:12 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 13/23] accel/tcg: Build tcg-accel-ops.c once
Date: Sat,  8 Mar 2025 14:58:52 -0800
Message-ID: <20250308225902.1208237-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Now that tcg-accel-ops.c uses cputlb.h instead of exec-all.h,
it can be built once.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 979ce90eb0..70ada21f42 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -20,7 +20,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
-  'tcg-accel-ops.c',
   'tcg-accel-ops-mttcg.c',
   'tcg-accel-ops-icount.c',
   'tcg-accel-ops-rr.c',
@@ -29,5 +28,6 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'icount-common.c',
   'monitor.c',
+  'tcg-accel-ops.c',
   'watchpoint.c',
 ))
-- 
2.43.0


