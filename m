Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA0BCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 20:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Jac-0000Ui-0O; Fri, 10 Oct 2025 16:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7JaL-0000Qc-NA
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 16:19:29 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7JaH-0002mb-F3
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 16:19:29 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso3664331b3a.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760127563; x=1760732363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cu0j3u1EiPOo3ymLdtqAPpVdEyM8avmIgAx+FgTrQms=;
 b=ykk6EedlP3l2SwEedfsAIo56u1YzSZu3GNjVHWUdqH96aNiQ5RIw8Lc/KvS4jim3a7
 1L2IpjmMJaLBoPd4WINEHGs0VdYnB+LoIwONoH0w2iF1Dy/WxCmm8TfpnLcnA864jxbf
 n+QV6UcYhLq0jB1s2kI0PtX2AE9Lrc9qa0CM0lV6RLHtywoB3ZMZD8F19R+V54s2f0Zb
 XbteTE9+f1OnC35SOnfjHJQdSftZC+cQ36zR4U19ATyT7I3fXhOTRbIScjh0rFPr9712
 xwazInmPa/dwkFwZ21+rkLuTjyCs3VhNMPs4nkE1pKOeQY4ZlREYy1hn2pN/ZSi/12Lh
 7MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760127563; x=1760732363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cu0j3u1EiPOo3ymLdtqAPpVdEyM8avmIgAx+FgTrQms=;
 b=rVe7lCrW1Xig7j7pljf4bs6IDURYf5BJPcvylyA7EfXL+CcLitEDL9apmB/pePFAdH
 +r1Nzazx3o02zAzNk5uWylDHuBaxdHAopD3knbvebrYgc4UqXxGZl2Z+0WKfrjEOtSnW
 f82Qi4fhj3+XwJlx2DPeDVTj+F1R61OYOnEyGdx+zaD4xCjBLOwZTVo22OLRCVm7C2l2
 iwihS3mQLgwHn5xtA0zlkpx+qdpzvNI42j5qsTOj4GdpLhUcua1yq/YPZpwQYdC9lWnZ
 8Ict4QTUxlk1PVXEw//x03JNNIPXJwms6qVfGrMx/HsB6R7Nocl5iC2Q9aBC1PaFMoUn
 teMg==
X-Gm-Message-State: AOJu0YwxLw9mXcYR/dGUKFVAZ+brInV0MqmO7YNVldoVhRPSoHE+gwsF
 OO2EIismJfkaj0SfPGZpmyCGqjArFSihT21OCJwZUTw7l6DiWCZyhyk2IsYW1cIDX002gzQ1zFL
 aeqIyxKU=
X-Gm-Gg: ASbGnctaCsgq7ZxxUmBnvtMYk6L9xUIwyb41uXvV1jp+itbaT/nSM22AimE3yp5C6Hm
 o4yN2/+BGgyspOx1eCzsNF8/UedKCcWuq0WEfFj0rWtgP3VCZ/6Ebjle7+uFT94GKcgJH1Ooq0A
 tLC8/XUSU74zm8+Kz0ItPYp6CKeVPkbzCdMk4q0awBA9n3M4UwDXwW+AIu/xlON2i94kiq9VOH8
 Z+vTVLK2x9pwNqn7gSICQ2zknu0eTqxWz6tDFrsT5hNhZOD94VMXn664ju6NcCGffAjj6orOrOq
 bp/WFc/dAYXWgLry4qXDaZOceORz9yyn3eqAFCN+9jw6jTfEJ/OJTnY9tuWgMLPBmFlInQJfVIP
 1IHLoft9QLkBHP/Z4qECksM+ARHTuE1n9fMGf9ngMrJc173iBb9k=
X-Google-Smtp-Source: AGHT+IF9/t8/V2aMRUwKhAPvTmYxObLcnN5Hqr9xyZf4qUVQgSWRtus/L7hsU99L9XECJo8wU7Vulw==
X-Received: by 2002:a05:6a00:1146:b0:781:4ec:4ec4 with SMTP id
 d2e1a72fcca58-79387a23c57mr17005819b3a.31.1760127562763; 
 Fri, 10 Oct 2025 13:19:22 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992dd7ee5bsm3764830b3a.85.2025.10.10.13.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 13:19:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 6/7] target/arm: Honor param.aie in get_phys_addr_lpae
Date: Fri, 10 Oct 2025 13:19:16 -0700
Message-ID: <20251010201917.685716-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010201917.685716-1-richard.henderson@linaro.org>
References: <20251010201917.685716-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5fcf104272..23f6616811 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2319,7 +2319,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
-        mair = env->cp15.mair_el[el];
+        mair = (param.aie && extract64(attrs, 59, 1)
+                ? env->cp15.mair2_el[el]
+                : env->cp15.mair_el[el]);
         result->cacheattrs.is_s2_format = false;
         result->cacheattrs.attrs = extract64(mair, attrindx * 8, 8);
 
-- 
2.43.0


