Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85576CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPld4-0005ny-7q; Wed, 20 May 2026 14:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcQ-0004LO-2Y
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:10 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcM-0002FV-Ie
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:09 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b9ea536877so31518685ad.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301561; x=1779906361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUXVONoe8IwMkgOU4fg5iX+I5AZGpysKKoOGKzNezec=;
 b=XUC9F4VVHKuyZ4QDiiHn0+t40PivSDtMLKb9tl6h4//p8HZAkkgqDn9p51kSwyIiAP
 3yySbDO2YFnZ7SIoP3HA8EJHDYBelYf25hyFdcTl1WPSpljxLU/sbsRBp6Z2QHMg1ot5
 Q+YaWJuGe24k0tyN8ExseBBPrKBSUsfWngQRcQAWnzSaj6fhKCnvGJpudUv7k5XZ3DVf
 6w156Git7eUqm16MpPs0MwOQyQRBlezpyoOXFT8hzPqu33LvIZH+bjkL5opSVx4AQRHj
 l9TT1kFL2Atvq7+88LHnzP/tRIGZVXbRW8gxzYwJFw4zu9uhM9a1qw+CSql5OiTzHZ24
 LzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301561; x=1779906361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WUXVONoe8IwMkgOU4fg5iX+I5AZGpysKKoOGKzNezec=;
 b=eMsqEShPfC/f1wYTiZwVa41lh4jkiQyooEH18LjC1mNV52wt8urKy+tcoTHo6bINln
 UjxW7c54QOkq4ApxTz6/kNkG+MU6f4pmICL9BIwhJldmQI2USnjmxtthB98gwLgS8P9M
 W4cN9rgW7TcWY/H8nfeZbHsXLxmHu08gG+ONcSGHnm5onV9yK+RpdCGpbyeR4pASsf/l
 vYUSfAX3+HXEChwKwLG3H/st1J15BeksQqBphQER/RoKgPyiHxTN+QOHWW6U3zMIzxf0
 2USyb/ddd8rDx9qCQ4UU2vYrvEzsi/CgbLm8Vf01520U7bp9bzoXXwHWwly50CGNCsc0
 OKhg==
X-Gm-Message-State: AOJu0YypotVsxQtR0q+4CdA3Le0PfxQL6UKyH0VHrgHw2kBvZSVCA3d3
 JtMKxT9dC1QhjyMYPKgH/MFi+xJweF9PuWi7Cx+TNSdUkVesA+FCiLMVegr2543siJaZsj1/wjG
 KecCgQ8o=
X-Gm-Gg: Acq92OE0Tsl8I4s213opco084uYKNv6cdfRoZ3bEQ/NsZkFe2xyKRxUvFuMHiGkizMr
 FMDQwCZ9DcLR18+0sEiXSNemJqZZ+bdc5OY0QV2r7/8FEQJSFO/cJrOrSx5zB1wpO46P3P8tafa
 cKmwShJku0JrqMkZ2MPkJoxIM555GS0wbf5FLIjzo7U5k9a3wPIWQL5OJogGJMuV5F1fowk/9pV
 lowHh1JxY01qn5xIkQ7wLsEZKhaKpee6ng5fE3wFTfpTpFrBctf2JUZ6b7C0Jy2fEGy3y4UQNsp
 cxDhzHYlhdm36ENSox2nawYAWGyCxvrPZkdYElS8xonVcNRiXyRfPf6pCsa/76FPUMXzzgu6T/Y
 9l5y7jFX/VV+zEkG5J5m3Awhc6f2yNo2GPATkNL50EGW0uBUNETB9mnLJzVuTuS691jQJ5ZtdCP
 Z+8GzB/YPDjI1jP2e6Q2RreFyzhXs8OPLc9U/cX+M=
X-Received: by 2002:a17:903:190:b0:2bd:e021:6dbc with SMTP id
 d9443c01a7336-2be9d404eeemr5357165ad.2.1779301560976; 
 Wed, 20 May 2026 11:26:00 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:26:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 63/64] linux-user/aarch64: Implement hwcap bits for fp8
 features
Date: Wed, 20 May 2026 11:22:12 -0700
Message-ID: <20260520182213.872945-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 3af5a37776..0934524be2 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -218,6 +218,20 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_sve_b16b16, ARM_HWCAP2_A64_SVE_B16B16);
     GET_FEATURE_ID(aa64_cssc, ARM_HWCAP2_A64_CSSC);
     GET_FEATURE_ID(aa64_lse128, ARM_HWCAP2_A64_LSE128);
+    GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
+    GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
+    GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
+    GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
+                               ARM_HWCAP2_A64_F8E4M3 |
+                               ARM_HWCAP2_A64_F8E5M2);
+    GET_FEATURE_ID(aa64_f8fma, ARM_HWCAP2_A64_F8FMA);
+    GET_FEATURE_ID(aa64_f8dp4, ARM_HWCAP2_A64_F8DP4);
+    GET_FEATURE_ID(aa64_f8dp2, ARM_HWCAP2_A64_F8DP2);
+    GET_FEATURE_ID(aa64_sme2p1_lutv2, ARM_HWCAP2_A64_SME_LUTV2);
+    GET_FEATURE_ID(aa64_sme2p1_lutv2, ARM_HWCAP2_A64_SME_LUTV2);
+    GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
+    GET_FEATURE_ID(aa64_ssve_f8dp4, ARM_HWCAP2_A64_SME_SF8DP4);
+    GET_FEATURE_ID(aa64_ssve_f8dp2, ARM_HWCAP2_A64_SME_SF8DP2);
 
     return hwcaps;
 }
-- 
2.43.0


