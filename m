Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5914ECA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO0C-0001bH-JK; Sat, 30 Aug 2025 12:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEUr-0008UJ-FF
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:51:30 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEUq-0005j4-1U
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:51:29 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b4e84a61055so72483a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756533087; x=1757137887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IYbDL7ZzrPeJgVCiHhUdegByQ1ip3ofl4M+Y1UUBtM=;
 b=tF+KtZJqZWblzeGDyvUXOKnygutZWk05JnYQees/vIXupNu0ax+LstJhkjinkRAD6e
 rb/izfa2Af1PfU4HqIiXlWjgXIlcWmdHqETeGyx8uFiGqS5YV3tnhGlIEVGvgKpIGLBf
 hzCT+CrkLgHxsD/6OLZJ6NRnqABn72fovoi9zttnvLGEebC3mKAZPXlz1xXsKK9bSKLR
 lKZjCA3HXkApN73Km/IxyiMbuVsZXp8qJbylsEOcLZRQKDSq8YzTLLbRTRzry29lW2dM
 O2OLeUSFbezEQt7UHuDLA8yidy/XmCNRl6nPySZ3KBwKL1HK09C0SY1ZelbQ2AqiibSh
 bKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756533087; x=1757137887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IYbDL7ZzrPeJgVCiHhUdegByQ1ip3ofl4M+Y1UUBtM=;
 b=oU53RW2rwJJKWnryW8D+7hj3ObCdMyPRsUtchNrS/nVUPAQd3JRm4cmDvbV7wyONl2
 +VaEfZXbkTGpcXDWZzqJdTGQ8yT9Sam12UXDnBcFyBK8utRHJryxHd8K+NeMLXSp+lel
 ChaE6xFknv5gl7zy+UF2aCm+LT2lN5sdY5Cw9+H9NSzKIwetMPEt3D0858vk4sbwRgvL
 FR/YeVpFatFEK97xnYfBA2r7pJ3CMjufsZwst0hPNErNbEs28vyPwBOMauIaDrNtHt0R
 IkmQuTBG816+5cTXq7OS4g16foR47lfNm1s63MJeCyaNQa8SALZQFAcOhlnxxSPXB2dL
 nAww==
X-Gm-Message-State: AOJu0Yw23W7aCSZbYiKhR6nzLbGFuCeHSZdP2eoaExSoylUb/C9yczMb
 VSBOs/eaJsNs3CULI8+ZjAMFXvHmAiPQzaNPUBgK7fDf1oMEaTtXcq/eG/tW9zFryNYJIS3EYc6
 XhTQl4QI=
X-Gm-Gg: ASbGncsL5UjmyLA+N5G3B+UXcyUAmr0aMc5VKVlESLi+TPWuBrm+Ej/L2KtgsVekq1g
 c2xuvSH7egmA2f01rbaTRv1WL63A3kTQxyiHc0iVD68UpuMlIb7BNmvKk0jD0UEyllxPqzWH0dw
 zeW0NzEKxSspmS1riQR2Ge5wtDNzZWWyGsL/6kyDrbgV2QqCLPOEec3sv7T9u+UHcuKMdNh1Gag
 U2q1bi2RFfpp6Kbgen45bS3pv44RJ3yiaa/ymzliE/0GFbc0ItF39fnxDtgVE+LaBaXH7uz4Edp
 V51Q29I1pBFWho5Ze8cFMJ+swcsJZOF8k2JwWApSHsDLD+NjE6m0AZAhm1xoIjLSlanThk7ky16
 cwEjPAneXlf8KvMmJCyw1ZaWl4Ikiv9jOeq4RG93I4MBASr2lSmZtL0XlL/JKM9jOBbsOwqM=
X-Google-Smtp-Source: AGHT+IF33CZNJgSyEhFaeYSZPZ+iQhpvI/gDhdIyl4tLJ2EDGNHSi840laJeYx+eKHsrnnIftARhSw==
X-Received: by 2002:a05:6a20:1595:b0:243:af83:6c75 with SMTP id
 adf61e73a8af0-243d6f0293fmr1639383637.28.1756533086649; 
 Fri, 29 Aug 2025 22:51:26 -0700 (PDT)
Received: from stoup.. (122-150-204-64.dyn.ip.vocus.au. [122.150.204.64])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a2b7d10sm4198475b3a.33.2025.08.29.22.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:51:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 81/84] linux-user/aarch64: Enable GCS in HWCAP
Date: Sat, 30 Aug 2025 15:41:25 +1000
Message-ID: <20250830054128.448363-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 77d03b50e1..3af5a37776 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -169,6 +169,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
     GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
+    GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
 
     return hwcaps;
 }
-- 
2.43.0


