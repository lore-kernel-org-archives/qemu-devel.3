Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A90C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCq-0007g7-JT; Tue, 18 Aug 2026 13:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCo-0007eR-UH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:30 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCn-0004q1-Cl
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-848743155bcso78994b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072548; x=1787677348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EhOF9jN/PD6V/ZU4mC7f/RoDc/u+gqWIwDoJ39rAJgo=;
 b=wpJ3wgi2i2m2qT043PE5Junv0pNhvWu9r3Fyo+JbcA433+D5W6lsV7zpRWGPKZk7T2
 nYtMvPAuf7GcFbDhQBqdOUJ+4PdTmoV0dZrr0DT9XV0ti4P/K8DdwZxBlpHN07o2QBXY
 PSEQlHBI0Of3QL6dd2L+XoZ7w8xQOTi+cZd1QQur6o3j3jmUrsyoSuE80ZkM2XRfc0yn
 ddNJ3QreVjvtnkPsYWnrxe2lZAs78hm/Ks59DT2bqcJ71IFWXbey+AhIZvXJhtVTN+eh
 og0URhpaynyyeb6aYxC7KvVGSSKs74vVLgQdvPglfd6ZxmhNz9pTwKOeLVX5a27I4k5t
 RVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072548; x=1787677348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EhOF9jN/PD6V/ZU4mC7f/RoDc/u+gqWIwDoJ39rAJgo=;
 b=gG3mMxzMqzIPSSwrSi+brEvTSMgx1L+Ykk0TanCwrW/D+a3sAex9RdRQ4AmOEipLOV
 0L04tYLZigkcybKzdB0kEb9g9Sina2f4N6+rItAhi7Ehpj9lwkd5UeQNRTNoFLtQ9aFS
 dyPgSqCaCm4Kjba2Q4TNO/4oOxWKbUnw/1AjJ8RirFDi/k2E9gPT71KV3Y13rfMNVVa2
 Y+1HOs5Ts16LtyADaMXC7QliGrMebKy+rviRRjDAyuzr2aWWdiTO72fS4piqA+Kc0QZw
 3E72wbSG7tcYXBubDzLBGB/rPopQESyXxzHcit4mvJ9G2nlBvE+D8gIg66EPPAIRTnp0
 tQug==
X-Gm-Message-State: AOJu0YxF5By+7s10zXOT0VxNT1BM8uoGKDjHTd4sIvYZ7jtdiXao8ne/
 xCgcaERbimVsw23aPTbOFInDkcnc5BFhjVL3VqJ9Kbe1XWgV4OyqmkfHPXCcuoQ+WIhHsS0N1jm
 1aSiauoc=
X-Gm-Gg: AR+sD13nmuAFFxTIFbDqxxw+K5qQJb4g58GSf/ObvDEh07ICf8V0fWT8zUjavRCvBr9
 8rMi+77jeY0T558GxjhJ8o++K7/SRclKXf/DY+zo7ZOsF+AYJobCnTzVLm1YiC/ePNncJmO1Wnt
 syoUfmUv2EcHBxVvDAIxSBLPQNHXq2euKrvTSdJK3oGAzhyDjH7EWN/7paUFfi4/XhQcVJtyt5Q
 TOxlbMA+ojxlndjlsqIrzvZ/8i1BxQKtFqqElUcxSHkbw9NFNbFvmhCz6uknMoGf7p+9yRrGzss
 f3TeVZHqDNu8yBlnVRb+OYFjJjpwqqWQzAB+xoPD19AfESCWOFxVlme/2jn+yJKKpjQGotGK/SY
 BSVJ8aAAQkSP/bUFrBO20WqDeL0STT63fgPUHuoq2IWkKvpN3u3BnIqfkxk3CLvKwBEL9TDgrYs
 9aWGU1ceeEmpGs/EoMqAjWOQmR3CUiXPHJS7IUPPOJ8MNYpUr0kJ+4jRSyikraDOb/vu9ySAS36
 4d3CJmkQxJzIfqzqYeSBSguxY1gf/eboN2N
X-Received: by 2002:a05:6a00:4501:b0:848:30c3:45dd with SMTP id
 d2e1a72fcca58-84fde001b0amr42699770b3a.11.1787072547693; 
 Tue, 18 Aug 2026 10:02:27 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/38] util/cpuinfo-aarch64: Detect FEAT_CSSC
Date: Tue, 18 Aug 2026 10:01:42 -0700
Message-ID: <20260818170155.1907006-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/cpuinfo.h | 1 +
 util/cpuinfo-aarch64.c              | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index fe671534e4..c32c04dade 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -12,6 +12,7 @@
 #define CPUINFO_AES             (1u << 3)
 #define CPUINFO_PMULL           (1u << 4)
 #define CPUINFO_BTI             (1u << 5)
+#define CPUINFO_CSSC            (1u << 6)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 288074c08f..4ce6deb7c8 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -72,6 +72,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
     info |= (hwcap2 & HWCAP2_BTI ? CPUINFO_BTI : 0);
+    info |= (hwcap2 & HWCAP2_CSSC ? CPUINFO_CSSC : 0);
 #endif
 #ifdef CONFIG_DARWIN
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE") * CPUINFO_LSE;
@@ -79,6 +80,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     info |= sysctl_for_bool("hw.optional.arm.FEAT_AES") * CPUINFO_AES;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_PMULL") * CPUINFO_PMULL;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
+    info |= sysctl_for_bool("hw.optional.arm.FEAT_CSSC") * CPUINFO_CSSC;
 #endif
 #if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
     int mib[2];
-- 
2.43.0


