Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EF0F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtM-0006If-1h; Thu, 23 Apr 2026 06:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtJ-0006I7-72
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtH-0001tB-MX
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so6632605f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938553; x=1777543353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v5ZNOu9NBVvbQVxY3EIRPHn6NOW6vsYmsD7qcmXjrYU=;
 b=f9nREdnixdj5WfR3TCgun20aQdwR6DxVxRuzdfMvT1dOKVqr+mz547byRVilYV3AmW
 t7k+Vgtfuj04t7BC1oFGY4urNU4PXAp8RsVQePYbembcRscHKV2BtzIoODc97F0VK1lO
 CYDKQPZaGfQrrsguGqW2tqOrQBuwt3cgYXalAczelrg7mXocktmSMN61kM/v7pAfpnrn
 Ti3HbNoUyW9NUbvNcro4Bjs1R3p2EuImClh6zqSj7iCg5Ps4VM6/X9RbQFB60mVshe3G
 OGjRKuqRQnnTPQhmLZKi77O01kPMG05IZfU/AZkMAU2eAl1larslNa3uhDkek2n6yuap
 /f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938553; x=1777543353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v5ZNOu9NBVvbQVxY3EIRPHn6NOW6vsYmsD7qcmXjrYU=;
 b=k201melB0iDinGMnho7jVLIqSlToJQFRdZvfPPjw80RZUVQlujXygH1oxkBywowJRl
 ALg9zG+qiPPavk15TmnEp+QSN2UKY0EzSnaETbMgMI2MlPiuIo0uH0FsS2mMtAMlrlsN
 xp3w0juhpjbe6AHn2rNSRKINBx1iOdugg0O8NSfZKY12Odh15wNlB46ucQoMzEIB2URv
 P/u8MYqtUT9T5XgGLmTbvv1Ws53eHsg7XTTK04zWiUHqfYM3HBl1ydu4O+DZgdj/8vDe
 p6EuE+PtqHoVlGl8B2tnY9boUZ+p7Nc73igR9+5gv+vDXx70EuKMEdSTVxMGMMUe0oRE
 7vng==
X-Gm-Message-State: AOJu0YxVL0209RTX9cloU3dCzR+CowErjg9Nj8JECPTpW9VkgYWkY1KZ
 rlxjD1Exh87nyNMqRJVoM90z5z2ivZZmx0p/R3+0sAmGJ/PndIMqTFAioakmiiNioocTKJqtKRX
 4iSWt
X-Gm-Gg: AeBDietOKwZxfpbsjhGgUbv40JvWHx3/+XS3KgLlhGlMCp9e0koN3Nxvj/O0Pu0JfyL
 rrivuSYsa4IEHAVHvXUDoDRM8pu2LjqC508YG5n+WxVBC65cAzAIPNx65kVOHSS/MIGSt7Ela/k
 4j9BKZMmoukbpeZtFe7xst5t99aYl9ieAKHGSC8C/iHZUGz1fRTkjeIcv2BoBBQJPdy3XqFyB5d
 EG4ub0lRgx7+8TTY9xYClHDZwTuXUYJ20hKXpX1wSLX4vNUDBLjy822rdyP7kefVxvuqVR5lGad
 mevRvoByLuu09Yw4YiDdogRqOM+rrUHF9m19Jkf/GjRhyZ28XDY1F6uKXv572DFhgnbUVSI2fTA
 PdU1WLrzjbi5VBj2dJAQvDXjv6YBct9XagfnedmPe7b7mxjhAqbibLW8Bc2tHE+gzQpgRdfAmEs
 FlDb56pmPa4QyVHac3d2kqFHwNF2DxZUGODOvJ5d8eYmJH5uyvecpCCK7PvCHi7I8hjCrpNW6A2
 JiRjWjurvYnPbPxBJDfYqNXgplwaJoLKEBy/7tOEw==
X-Received: by 2002:a5d:40cc:0:b0:43f:e721:76bf with SMTP id
 ffacd0b85a97d-43fe721784amr27785857f8f.41.1776938552190; 
 Thu, 23 Apr 2026 03:02:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/59] target/arm/tcg: increase cache level for cpu=max
Date: Thu, 23 Apr 2026 11:01:31 +0100
Message-ID: <20260423100229.2941820-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Alireza Sanaee <alireza.sanaee@huawei.com>

This patch addresses cache description in the `aarch64_max_tcg_initfn`
function for cpu=max. It introduces three levels of caches and modifies
the cache description registers accordingly.

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Message-id: 20260311160609.358-2-alireza.sanaee@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 84857fb706..649d854a65 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1167,6 +1167,16 @@ void aarch64_max_tcg_initfn(Object *obj)
     uint64_t t;
     uint32_t u;
 
+    SET_IDREG(isar, CLIDR, 0x8200123);
+    /* 64KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    /* 64KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    /* 1MB L2 unified cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7);
+    /* 2MB L3 unified cache */
+    cpu->ccsidr[4] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 2 * MiB, 7);
+
     /*
      * Unset ARM_FEATURE_BACKCOMPAT_CNTFRQ, which we would otherwise default
      * to because we started with aarch64_a57_initfn(). A 'max' CPU might
-- 
2.43.0


