Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B463ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwd-0004UO-Gp; Fri, 31 Oct 2025 14:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwV-0004OR-4G
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwG-0006C3-MH
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-475dbb524e4so15613595e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935601; x=1762540401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=REfuEoYYWsxL5VHgmLIdH3KQEed0GHE9hAwD3zw5rt8=;
 b=FsKoqk5KTr1d0NwSxJpHJeumJVmFB9jwydA/scL2SoO0qWc1Y4LYHJG90dfeYyuoYO
 tycAwPBWTnF8shK32BUOvAacksuA37w2CioNC+/WM+xnqSBLq2OuJMYp8YzIyAzWqoGG
 PliIuJ1Sew+qQKAqWOSy0U5ZaxUVHthuZk6HMtcN80yxqwcbBauSdWhUdw34cIzVS+46
 n8zWPe+sDBYEidi0ENQJNUibTgm/CeQFMY/DgN8+XyNO5iyXpUa2vbrqtYxzttA/upzt
 pMFfH2N8a5iIZdZ7LgmSdgS7UwHEcmOk3bA5ijdaBUUPfF5gCTxSt1Cbx/gzbT9eMifF
 s3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935601; x=1762540401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REfuEoYYWsxL5VHgmLIdH3KQEed0GHE9hAwD3zw5rt8=;
 b=gj0XcGnsCdzRh3YECZ4tc2O9tJEMNCet9MgyjPiLVXVMI08K7rqHc8WeXJPrNuu0Xg
 5I9Zw698WMTx5UorPCagr59Q6wwQzSUmXmA3XXhg34aOgAz94xRpQv0rXAQ5C7yTW8NY
 a7FOlfoSSYmTDpG68/1e2AuG0MNULZbsBlvi6pfhle112TC/hJjS3IW1zO2XVutbPhOq
 TYQFueE/LkhFpE6TlqBvTzJBuNypAl02o6hBRy0qZU1Tq4A2A4apIAOgATRQKU7SzCU5
 Eb01DHADSQp9tqxGCWMCd5WuYX8jwLp6DMCdqEZEZa2C+rFH8wCg7aLN7AeV4SgYqmLR
 rW4g==
X-Gm-Message-State: AOJu0YxDzGK/cwd+kA2oD72C02U/RBOjJDK5o7cSkf+GUihtARbJXQbb
 QBTUi1L23yj3jeGE3exnJMRoTd7JOAWa2p8tcBKxdI9rUp2dd4W7QjK/6Tr0p43wSDOMzyIXcnZ
 eAU0S
X-Gm-Gg: ASbGncu/mgG+mOrI9re//zS4f7IK+iOTDS2byJAXUbfSyUnKTGklXZsdJ1OVe+Ac+jw
 bbjdXJ25hYdIzYPx9+6lXEPhCvbYvDs1uIUBHFYq5wrUXfik9gTlRurnleMBx7PVGMdldJryOUw
 brQDnajwu31Z83kxbirpctr8JJw7aB6KnyP4WL6Wt4mCD+dEL43dYeeQjkXk+2gY+WAG51cGhxM
 hwX400jrhGxPxnF4lOw9FfyPSiJUoGPneP2my0M3HrTXRI9SXNwm3kGChxmcSPzNb3kvv1p4nY4
 obKeTCkwj2N+C8ijS+57x3IByOUbyQHJH08pnWwEjfop294eyMVkO6PlLdmlGvdQp2q9wDR/Eiy
 sB+S8ME2Jh7fqlDHlTPRVsBxORmrkdEhZvNrxpvJ4Xl7S9cHoUFlRjiYqdQaMZazwqubk7jWP3e
 bnUcj6kA==
X-Google-Smtp-Source: AGHT+IGRgh9fEn55AXacTroGovT78yyLccxS1WDn+fTSIfHd/GfYKyjUutksnwlOKOzCogK/tQgg0w==
X-Received: by 2002:a05:600c:35cc:b0:475:d8f3:71c1 with SMTP id
 5b1f17b1804b1-477308be6f1mr41372185e9.27.1761935601248; 
 Fri, 31 Oct 2025 11:33:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/38] target/arm/hvf: Release memory allocated by
 hv_vcpu_config_create()
Date: Fri, 31 Oct 2025 18:32:41 +0000
Message-ID: <20251031183310.3778349-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hv_vcpu_config_create() is documented in <Hypervisor/hv_vcpu_config.h>
as:

  /*!
   @abstract Creates a vcpu configuration object.
   @result A new vcpu configuration object. This should be released with os_release when no longer used.
   */
  OS_OBJECT_RETURNS_RETAINED OS_WARN_RESULT
  hv_vcpu_config_t hv_vcpu_config_create(void);

Release the memory allocated by hv_vcpu_config_create() with
os_release().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0658a99a2d1..83db1088384 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -150,6 +150,8 @@ void hvf_arm_init_debug(void)
     max_hw_wps = hvf_arm_num_wrps(config);
     hw_watchpoints =
         g_array_sized_new(true, true, sizeof(HWWatchpoint), max_hw_wps);
+
+    os_release(config);
 }
 
 #define SYSREG_OP0_SHIFT      20
-- 
2.43.0


