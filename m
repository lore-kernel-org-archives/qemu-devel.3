Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644FBCDE003
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNoU-0002Bq-2Y; Wed, 24 Jun 2026 09:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wcNnT-0001eu-ML
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:37:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wcNnS-00016G-9C
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:37:43 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4633193af19so840736f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782308261; x=1782913061; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dbmh3RMHWGextp8wn1iIt5XsGX3XsKMosrBI26uzcks=;
 b=VNeVEvXkaZP6985Otz+EEPnFTKLfdvU3WtAGbpTgsAj0VK/QMMLxejKLiRDIUWko+n
 1y3BX15Xqio43zmNHysqUFiI2V2MjhqP6Xa2DRtrheSC7TYRE0EtKTxKsLENB/WVscgL
 FyZfZ8bjW/P3Cz1uAib0UvdiIpy7A+1EkMsvotYwcMlH8ims9lFiijvNEms5mzaZAdWQ
 RjB7CYkKckkSQaio+GTApngtwDmLr82Dh9VjgptvGGKsZ+KC4eLIn4Fby5Aw0VUV49G1
 x3i7kI5qQicSN/hHNKc2BT3LibSvbwao52fx9+XRxt+PBqY5rIlKzp49CGeQPfx0Oqmi
 uuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782308261; x=1782913061;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dbmh3RMHWGextp8wn1iIt5XsGX3XsKMosrBI26uzcks=;
 b=Fz+If3WF+NBF+5iRU2AzzZVOH6mS9fabBj4oxQUOHehhmW1KYn1gJz/zk/7ZH1elGg
 cYIZQVuOqEEjGARWPUiWahbYasMrXHncbVtUG1pIskMuy02wnqlY2KengsfNIEFrb8Pu
 drevT2KW5UA9JO7JuOLWK7dgOG+K6Pf8TRq795b0khn/m3g94b1+eQAFw/jlJEX7XQnt
 CL3oBbfYZy6dLuZXkzUTlCBIwKeaYCQJzd9RdUKWc7xjfJYaGmFawS2Zl5P4tZdmDeKr
 BTJtwhaxKW+UCckV3V1aAjPoyet45OgmrfYgoARCiHtMbkFEGESolHYxEngydyfEHgNJ
 39ww==
X-Gm-Message-State: AOJu0YxAYQgC/KO9+pIZxRC13I6SPMyCE7/vLzqLNj9Zi1Vbhjt1rBzf
 g6wSDgpDQ3Ma0dBWusS61MEKG+3RpKRAckQId0OCidViMF109m4gy6XeYvM6yNW5dCQ=
X-Gm-Gg: AfdE7cnwaFl5YI64ID+S52cbj/jH7JZiE7zHnEsI2qZ6/yMIYiLOAn/j0GDAxC9eTsv
 C6fgI9W7UxvT5LONGc2MtkElya2ufSEghkRJI1kvvkXKF5igmpy3kPlaq40SjZk/CvPS2c5DUoc
 ubxj8SCVOQj8hLv7f66b8pwfWMRmJLUS88ufNm4IsVTtPWAltrxja3FImcztRNyU4raC1OOO/N6
 BIuB6QQm6uMwk3LGfsTwBatISeejJNVbwL7G7Wt2/bkfHtOxkKrQUx0M4qXvhRKa+9NWEWSlZ2w
 CYfkfSlC1UdbhV57pdEKass9vlyLgg7GjPUnztCRLCGNtSVfmkiJYPVXZj1OlATvShDAR0K3luT
 k4ZK/4yEbR0AoD2hWa4KhNYPX2SVcQ22KOSmwvZmqPhrupFrodhSGNfy8Z/Nz1PKL2NzsvQ86eu
 DmSJ/yrXsOg7l0y/nrKNdvKUwc0A==
X-Received: by 2002:a05:6000:2c04:b0:46d:32:3340 with SMTP id
 ffacd0b85a97d-46d0032353dmr966946f8f.36.1782308260654; 
 Wed, 24 Jun 2026 06:37:40 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:2e21:1ee8:260f:9a76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1e840efdsm6646334f8f.5.2026.06.24.06.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 06:37:40 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 24 Jun 2026 14:37:28 +0100
Subject: [PATCH v2 4/6] linux-user/aarch64/elfload.c: Add FPRCVT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-jmac-fprcvt-v2-4-dc6cf8e512b6@linaro.org>
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
In-Reply-To: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Alex Bennee <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x431.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 linux-user/aarch64/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 4887a3a7b7..4487d047bb 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -173,6 +173,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_cmpbr, ARM_HWCAP_A64_CMPBR);
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
     GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
+    GET_FEATURE_ID(aa64_fprcvt, ARM_HWCAP_A64_FPRCVT);
 
     return hwcaps;
 }

-- 
2.43.0


