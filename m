Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EDCC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzM4-0006WD-DY; Tue, 25 Feb 2025 13:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJc-00008C-TV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:57 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJY-0002Gc-Oh
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:55 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4399deda4bfso41031345e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506735; x=1741111535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/sOx4rsoLFvQjUbFkMZywFEIdmc3YIpvz9ivZYnsHZo=;
 b=Zqi/zLGLwtzPMehv16atvmNGErMYRVO93RSAdvUAN2kKHLqc78B0legApPnhmdFMag
 NnSKZgL11RbdccXEIl2ZjoeRsxTmL5870BDB0nZB4WaxvIYM8PIpKRkJ73BNFik3407p
 AnPwmKluJrTCUd4jZZUjLByeRFANjwuha7pPqtdkoMfibJG5+xTQaKj10f9/6IoRF7jc
 rcxQoAEtPmT2S8sJWqRf6GI8P+q308CWtnPwZW/rro7Y1BkebVqjuQ2Ht1lioPs01+sS
 HRCkYDur90SexByzAKr3or9yJe1Md4IM/JUhpGVw9E+IXN3gZrdF5z3SH+l6KsCr2Ukx
 b9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506735; x=1741111535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sOx4rsoLFvQjUbFkMZywFEIdmc3YIpvz9ivZYnsHZo=;
 b=Xs5bC37px33GucCouB9sO/Tuq6QHwxh8Ubddjc1ASZfJiaqrRtYn1yVbnq4fysUE7M
 MpZLT0B8avm26SMoQjH5fXPulbjaV8DtZwbSSUbGlpl6pcWvf6+8FR4ZksUPv+RuvJoA
 CRmkhCH+ne+jPd4MrbCkZQ/4fdJhSiSK8ohmv+Q53ECAPttU51jT9QjRutp2e0aXBr33
 MvcaBPDCjMSxu4Omt/6ClmbmBQ1vx9pq/lulnWEMM1Rs3pKyRLbiHB3zLGfCLKmbEl2g
 av4aPo+1N6DT5mXJp8Yo95a2iE0GaIa+01Vh2MHvgnKD5NlvUR2d1hbUhq2p2Pn2SiU0
 2GZg==
X-Gm-Message-State: AOJu0YzLUXMIECfgV+TSf9U3O5OtgqYFlTozRlgHXBn8LVo0zawGJ3U/
 h3F3hRHuuLFClPDtH/j3yU1njfrG0nxBidkLgD9dYDVqSRUCb7K6bAC4T5d6WY3ygQ7e0g5Fg5h
 A
X-Gm-Gg: ASbGnct6dmYtAXNbjeotEP6UgsiqMleDGyX8+8mHnL+6YanG8yU6WvC6QSqC08GktWv
 ufusNVvR2MPH5H80fTSeuPbJcMTgx/SkV3ar0TnrvIuk8AtZaBhszdGn7lGZVlBg5vyaTeyTsoU
 YHGYRCgYeznD8JA1SbpzuHh/N92AGk6w14wF8mcX2+2TYIRRPCSOlvOCxwEzGtwqOKl+zq9ew/T
 uY31RzVzr5SEENCmDz3t40AVMSml0eyNNbuB2o8Jy3PqoSvmqRJLZBWsuW2sxstVm/x3e/OQb9v
 Ms1zDDCDjUXjgH/6UI+rqZ8LNiZC06nw
X-Google-Smtp-Source: AGHT+IEN8W6F0SWW6z51qE0w6h995dTckQnr+kYcDPaB+Mvjhie8ea2R/MlN09vMDuOlLC5qTBipKA==
X-Received: by 2002:a05:600c:1396:b0:439:88bb:d02d with SMTP id
 5b1f17b1804b1-439ae1d9a2dmr166870875e9.2.1740506735331; 
 Tue, 25 Feb 2025 10:05:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/43] fpu: Build only once
Date: Tue, 25 Feb 2025 18:04:46 +0000
Message-ID: <20250225180510.1318207-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Now we have removed all the target-specifics from the softfloat code,
we can switch to building it once for the whole system rather than
once per target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250224111524.1101196-13-peter.maydell@linaro.org
Message-id: 20250217125055.160887-11-peter.maydell@linaro.org
---
 fpu/softfloat.c | 3 ---
 fpu/meson.build | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b38eea8d879..34c962d6bd9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -79,9 +79,6 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
-/* softfloat (and in particular the code in softfloat-specialize.h) is
- * target-dependent and needs the TARGET_* macros.
- */
 #include "qemu/osdep.h"
 #include <math.h>
 #include "qemu/bitops.h"
diff --git a/fpu/meson.build b/fpu/meson.build
index 1a9992ded56..646c76f0c69 100644
--- a/fpu/meson.build
+++ b/fpu/meson.build
@@ -1 +1 @@
-specific_ss.add(when: 'CONFIG_TCG', if_true: files('softfloat.c'))
+common_ss.add(when: 'CONFIG_TCG', if_true: files('softfloat.c'))
-- 
2.43.0


