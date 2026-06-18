Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6904ACD98F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa7zK-0005Kc-RG; Thu, 18 Jun 2026 04:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wa7zH-0005JF-8H
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:20:35 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wa7zE-0006Ti-Gx
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:20:35 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c074ac8adaaso66868166b.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 01:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781770828; x=1782375628; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KKSPSnAl7FDN6Zt0DqKlBArO4lCMgimmNAk89edFtyE=;
 b=Vc4KAJ0WlsoBurHu9Y4umBa2mzlh4Ff+XsJY3pgRcBSE9pkR8D0hRhw4rvV7E/7RO2
 ritD9tk9x6gIkKeSYzShYla7ssZHH2wuq8wAl+UABP1BpAX5JqmEkli5styV3ai6gg8u
 a5gTOC/2cOU4jPP9uVcF+rMZdqxs5p/nMmNGAfMMlI3VK5uSiNTS71BMEKxTJM2FS8G7
 A1CgXbwW9E8JiiaftTEdC+SwmqRs/n90O1Y1zWTQaHcrImH3X+7SMMSNXQML2pC9Jv3k
 H6XNoMtRMAcJjSdW5lfHwK3R+e6t7Y8FHEBJkl5YN9Vdcm/FIGi3yFKxDuVRIz4U0M8G
 oCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781770828; x=1782375628;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KKSPSnAl7FDN6Zt0DqKlBArO4lCMgimmNAk89edFtyE=;
 b=tPCDy66SWY6pWp9M0IyrRHR9T22DhAdelFbt3EyXmAfl8rkhFXr0J56KwWRe79UHNE
 ufxWeRZKyNAapLwJSsmfudPAGXERSDgB+yN0yTO4wLQ6Bu3AUVGzuT8irnzMcWb42oRI
 kanGGqamxXX2nQz0RuHh2QYPgNH9ge6W61GzLa36tnyL8nrcrXh4vwQdHebRIYFSEcIA
 XhdOkt8cpjNoiONKM0dmirJXk9vUxs+gq/j5hnopEPQE+5aTFSNA5MIUiVtwx747QWwD
 wMdnThDDGvrIGYQC7hKtuF38DWEH78JaAA3ac1kcpcY0J/HvP358qUlqD6OSRadOK5Ov
 bp3g==
X-Gm-Message-State: AOJu0Ywwe1TFCJ8ca+oxagRIyx2c/ld+DJKpgdPTCy+w9GeKwM/vxTo3
 i70fnGdipovGpAcfqLjQwcBK8m8B0uZZJ36FF0HeCYQJzFK2ZtzP5iT0SlTyOC5dGbg=
X-Gm-Gg: AfdE7ckbNWTLm/n9O9GxkRomljH7MtNMrcbnlMG6Ii8FSfJseQwmbgkpl6q/J+P4/ek
 10oJTgsNqzf+hK2hm6jRxxS0aMYfXeqmReieLM21HNpNzEsh5TmFrFi6TUC+mrN5GkyUW05AQPQ
 3jl6Fep9WD8DzpyTHPga9B9kjVtfXrDFBNATiQhP7KgnlBOw4beCvP/BjJNIQ4ETZRnyrP2HYKB
 VeCjUkTULjyLQ67Mw4nMu4k2wy1eZkBAMfCDhWTCAAFh6WLvb7DcxN7W+uJDhZEM3aQml51eHzl
 R17y6p+UB+62crugTH6u6sEcds7KAM76ZVqE2ovfG/0KIwY+oRSX+Ir8hZzX419CIMjl/h28lMp
 S5IgS60vxj+5BrCz55P+iu3hUn0K/hvSbfSfnirP7LndSO/B50U1g8tRTVAM8BJpG0pmWVvgw/M
 IPTumnKKxfc0kjmJo=
X-Received: by 2002:a17:906:ee8b:b0:c05:7524:884d with SMTP id
 a640c23a62f3a-c05a73aeffemr462091766b.37.1781770828361; 
 Thu, 18 Jun 2026 01:20:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:a63e:e8c0:5950:f3f9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfe7cc615b7sm854334166b.48.2026.06.18.01.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 01:20:28 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 18 Jun 2026 09:20:25 +0100
Subject: [PATCH 3/3] target/arm/tcg/cpu64.c: Add FEAT_FPRCVT to cpu_max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-jmac-fprcvt-v1-3-1b4475bacf51@linaro.org>
References: <20260618-jmac-fprcvt-v1-0-1b4475bacf51@linaro.org>
In-Reply-To: <20260618-jmac-fprcvt-v1-0-1b4475bacf51@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x62b.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/tcg/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f7a920a202..f259e82dd3 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1269,6 +1269,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64ISAR3);
     t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
+    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* FEAT_FPRCVT */
     SET_IDREG(isar, ID_AA64ISAR3, t);
 
     t = GET_IDREG(isar, ID_AA64PFR0);

-- 
2.43.0


