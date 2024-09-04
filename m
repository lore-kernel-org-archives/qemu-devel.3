Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1956DCD4853
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsg5-0002DN-Mw; Wed, 04 Sep 2024 12:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfr-0001Lz-3U; Wed, 04 Sep 2024 12:16:04 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfl-0002I3-5l; Wed, 04 Sep 2024 12:16:02 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5334b0e1a8eso8739584e87.0; 
 Wed, 04 Sep 2024 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725466554; x=1726071354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nym7Vpc1+HcpD0fJwqv749eMWZaaEovUQaBKn9/MOQM=;
 b=nBqioEnfRwLtPkXprS/u1kpCsAaP4D40wUE5Bx+OdrVpBBNUp3EycBKejRGZL2bv4g
 ODsv6M8CmaAfPL+hd7lcUH9Z+R89dxITLif301VJAS7XmfUAbwg+q2pREYeoQxnN41Hm
 ECT9OZ9wgFYQSNBo6ex8B9CrxoQWfDG/eAAHBad9v8NSiYG9qGGzJBQIktusly8lCGGI
 c3um61Vs6TaBAVmLUQIc4iz5pX1L8TYai8Gnbg70M77+Ow/CmRrH7/flAFTs9uxQquTk
 IuL4RTvob/0g6QbgA1o75S2ZR4cPLKQUkF7FiEgMPr8zbl/a3Rs6XJ5G//9vP9inGf4y
 /DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466554; x=1726071354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nym7Vpc1+HcpD0fJwqv749eMWZaaEovUQaBKn9/MOQM=;
 b=oqk9mPKM/svv1IHsRiefqsWp2723mHgy7DZY9bmDHCkqky9oe9Czp2rpKTDLwNjB8x
 VA2WfoVK8YvcWo7tazhiJQr4FUSCj0v0aS98aOVbYStIm3A7dVDFwyegVWGZe1M0wLRd
 Mp2YGOqvqZ/vctdZlhj/6objScjYZ/xhJPXiX2i32AqQuZov403IintnfP6PIh6bq/Wy
 4LGgUbHu0SQNMCI2qTKmgV3dELSQmIaqzp3WRWo4+7og/s4R54gen5r9g1Y3h3YR6vN7
 Gslnke7Wrd4uV0UlM+6gpzCNUfT94CsLGfnvBelL2KnYEgDBEGwhyvIoJptl+SMrJie7
 5/qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBLKUVDgzz3BJcJ5pRrMGdDfG5PsthKVAKgBfeG8A1JdTFafEzv4QbSQhnRc+iFQkyCv9CAYViQQ==@nongnu.org
X-Gm-Message-State: AOJu0YwkfyoR7YrdaJjzaSG0zfpsn/wiBStVFDRUNk9t1krzaSqnazPZ
 ESIL3fFELBT08PsykR1frM7Fby+Z1LCi1MWBvQgjdjfudWHwApsLQu8gFIhK
X-Google-Smtp-Source: AGHT+IHdK+MGVaxZaTPG5mtVrOpYHs1uliw2A+U9Y8zDTRSlyKp4eJOx4pA7txuXly/nIFn97leCnQ==
X-Received: by 2002:a05:6512:39d4:b0:530:e228:7799 with SMTP id
 2adb3069b0e04-53546bab2e9mr14075298e87.58.1725466553759; 
 Wed, 04 Sep 2024 09:15:53 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53569eeb4d9sm143326e87.65.2024.09.04.09.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:15:52 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PULL v1 08/12] hw/arm: xenpvh: Rename xen_arm.c -> xen-pvh.c
Date: Wed,  4 Sep 2024 18:15:32 +0200
Message-ID: <20240904161537.664189-9-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904161537.664189-1-edgar.iglesias@gmail.com>
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Rename xen_arm.c -> xen-pvh.c to better express that this
is a PVH machine and to align with x86 HVM and future PVH
machine filenames:
hw/i386/xen/xen-hvm.c
hw/i386/xen/xen-pvh.c (in preparation)

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/arm/meson.build              | 2 +-
 hw/arm/{xen_arm.c => xen-pvh.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/arm/{xen_arm.c => xen-pvh.c} (100%)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 074612b40c..4059d0be2e 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -61,7 +61,7 @@ arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-e
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen-stubs.c',
-  'xen_arm.c',
+  'xen-pvh.c',
 ))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen-pvh.c
similarity index 100%
rename from hw/arm/xen_arm.c
rename to hw/arm/xen-pvh.c
-- 
2.43.0


