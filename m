Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C03C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxPm-0005l1-Uy; Tue, 12 Mar 2024 04:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxPk-0005jl-Pv
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:12 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxPi-00019f-1U
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4131b1f8c91so25234835e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231788; x=1710836588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FG8zZPJK1bf6KOQDF42ZpXKRx0qaQ0s6JgBLKqquGU=;
 b=A1j1qLwuGMRGbtGfo7okEOBKDikyI0zeXLTiJTSJXo2ywBZt7setZb5E4Ugpjg9kd+
 u+cR6Q+oF78noG0Ed6WBQAT69FWkNPfKBFnIy1yrlfJ4WUfDGhfaLOA39xNNhxCQEG7w
 RjXAWUeC+XQL1/to/OQ9Hp3xhpyBlNvMmPQCqNUw5hmrN8oOuhSdpDCay7gz+Ep8JsOO
 4PvviiFS3EesELq474IqOkclVZ/JAt+PBd/fq3i2hbw7aWieH0mPg/ezhCVtnWRkB9DP
 ZgdN5stDM3VOGphko+5dF48wg2Cd6pfX11y4tsd3CkRAiuMi7HpVUoww3RxSjbWealXz
 1/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231788; x=1710836588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3FG8zZPJK1bf6KOQDF42ZpXKRx0qaQ0s6JgBLKqquGU=;
 b=Xa18ty/nSOhEDddG6LB9R1zArU+4+XwxaBnppwkMonxutrMQE7bEdrdLcNOH6wtlW8
 pbBbKY4C27DE1jaQTxzJLVeo6t78Ae4BzMwq2YcqTkDoH6VjnJG8jj7Y1Vh9yYP3R33R
 hLvp0i6bC8/Rafl3/XDIsPY3VCJPQ4ejq2nmhX6LD3zIzP2yBHan1CGOykWinFfL7aLi
 rSoUESDF4DQ31MT7OMQ2quYS7/6kGhAqHR8cxxK0Y788LiPbfzpAwc756rgq8EsHBljG
 /GTjWhWZsRXc2/yT73m8MMugQHxsk0ZwW8sEnw2hpFp9jiYoz9WFHucqD/tPYOJXzSwz
 nDmA==
X-Gm-Message-State: AOJu0Yy4U5K49I+vZaVn4DxcmxsRp92ctI090k4XoTsbnY0pMshccfCl
 opsAa0ec17RWI9WGefeZKV64/vdgeYBTD4pLrd4iTXY49Js/RH10CQ7aDEVVr90E+aF+yzL0rMF
 f
X-Google-Smtp-Source: AGHT+IFjpIHyDQhLi/+cn/X9cRHxihLXCE26NANe6r76wcYxDX6JnG4bdE3lQ4fjjjxjLQePGO35ZQ==
X-Received: by 2002:a05:600c:3513:b0:413:1741:289f with SMTP id
 h19-20020a05600c351300b004131741289fmr7491099wmq.5.1710231787739; 
 Tue, 12 Mar 2024 01:23:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm16112266wmo.0.2024.03.12.01.23.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 01:23:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/13] hw/core/loader-fit: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Tue, 12 Mar 2024 09:22:29 +0100
Message-ID: <20240312082239.69696-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
References: <20240312082239.69696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
can't see this additional information, because exit() happens in
error_setg earlier than information is added [1].

In hw/core/loader-fit.c, there are 2 functions passing @errp to
error_prepend() without ERRP_GUARD():
 - fit_load_kernel()
 - fit_load_fdt()

Their @errp parameters are both the pointers of the local @err virable
in load_fit().

Though they don't cause the issue like [1] said, to follow the
requirement of @errp, add missing ERRP_GUARD() at their beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Paul Burton <paulburton@kernel.org>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240311033822.3142585-15-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/loader-fit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index b7c7b3ba94..9f20007dbb 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -120,6 +120,7 @@ static int fit_load_kernel(const struct fit_loader *ldr, const void *itb,
                            int cfg, void *opaque, hwaddr *pend,
                            Error **errp)
 {
+    ERRP_GUARD();
     const char *name;
     const void *data;
     const void *load_data;
@@ -178,6 +179,7 @@ static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
                         int cfg, void *opaque, const void *match_data,
                         hwaddr kernel_end, Error **errp)
 {
+    ERRP_GUARD();
     Error *err = NULL;
     const char *name;
     const void *data;
-- 
2.41.0


