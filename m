Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E63FC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kwz-0005Sz-6K; Wed, 23 Apr 2025 21:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kws-00057X-JG
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:18 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwp-0005Ue-Q2
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:18 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so341524b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456413; x=1746061213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQncdcCBTAzD3tdjUYfUMSnmVN4uvUMzzqpT196vY4c=;
 b=L5EFUqb+4WfThfiQHU2A+sGqSLph1enJySFlWRDsrMgJ8VJTszkxQB9uReuwaLSDcX
 fXcQe9Z4kmVBPfhwrLjb3PawvcbY48/MGLXDdzTyiZMGaXublvId6K0NxLt76IiRWBY2
 PS8MfRzQqzmFiidnIAaqtNgSAN0m7v3KhHeWeSHIgUtQ+VCgP4gdKd43oxfX3e2qMnoK
 FLXBGqZmPM8SDRKMtldM568iQQ/5XMqr/qY8gixmRZPrqBc/c255VxfhJFoh/oP/PJPi
 a9UTEMAO1fcxJDHi97wPgyjiW5z1MaqSrwllExrjbo4CJlrg61vcGdZsd8Y7fpUPjxwV
 diig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456413; x=1746061213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQncdcCBTAzD3tdjUYfUMSnmVN4uvUMzzqpT196vY4c=;
 b=gT/XsmMUUJg596tSNSBmoaFYA+1a/TKw21pMMW4ba2UZshEbPAb4UvaiBxZPfTQW5M
 C6i8oML990vxkkq6/n4RwWmsNkgm+kkFq3+tLfRY6I07VauH5A4eB3o/NSGzN8O3PXCh
 S/V0H8BMcpWo/d2jyZHQJDeHJsMDLa4QwwPi5Ey5W1bzteOM/HhEOLf2uRC/PTx8V+hr
 zDPvPlOBDb9V7X61rxKpTOAc2LsvmOIcOTMTnzVfuI3vSWib0g2zS2kp2WGHUsjPl326
 ubSBSB72XhrJVOuVcNXhS7BNE6buXzPDX3GaI7JDs9sY5JBntLhv9hFW+5lK+llt8Ccb
 Nbcw==
X-Gm-Message-State: AOJu0YytN2YBpGBAehXpJvzF/Pu2Sk6zv/0KE3hUIgozem5Ojr25U0/b
 2/gfoUfQgkXRmRVDHsglBJr37J8p0OTxnoA+fhU9ImG9yLE43ULJvAhnn7u+IhQ/Y47LDeh3yO1
 s
X-Gm-Gg: ASbGnctUWEK+Gcj1NgawI+l0vhYRbwPobx5yWcADXRJSqlSnfpyGXBbrPKA0b5bJIJg
 bbUdhg2jb+z5nl0gnbtQeexol3D2hKXALSPnvl11SnZvLkwqZo8A+5fmDmP8LPb7i4LnqhsgSY2
 JYhfSQI2v/gnymiCoaJgA6xVwBYnYxjLCY5LheokMGC7ktHh+NrPHWhFjK7ilPz1DgY0BEWpOPc
 02NXVIFQtcFduKZFJtjFiJfrJzX55RY2XYFtWkJZY9OrBfGsR3/H1x2Sjo7GGZBdI35mLnIZT+Y
 l4ikbdzO31rKAHYOGNHBMZtZTi0fMZEgPxNGPmmQcaY3TrCeh7eBL4laBJHW2zNyefTt2ihIqPs
 FucQ709YSmg==
X-Google-Smtp-Source: AGHT+IHelc0JkT204DVTBPu0aUqo54GzsTNDSk1L4OU5zYerKjgTypwynyd4lD9u388dAsI3z4D1qA==
X-Received: by 2002:a05:6a21:3294:b0:1f5:769a:a4be with SMTP id
 adf61e73a8af0-20444f9e8bemr964027637.36.1745456413343; 
 Wed, 23 Apr 2025 18:00:13 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 134/148] tcg: Simplify tcg_req_mo() macro
Date: Wed, 23 Apr 2025 17:49:19 -0700
Message-ID: <20250424004934.598783-135-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Now that TCG_GUEST_DEFAULT_MO is always defined,
simplify the tcg_req_mo() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-target.h | 9 +--------
 accel/tcg/tcg-all.c         | 3 ---
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 05abaeb8e0..1a46a7c87d 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -52,17 +52,10 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
  * memory ordering vs the host memory ordering.  A non-zero
  * result indicates that some barrier is required.
  *
- * If TCG_GUEST_DEFAULT_MO is not defined, assume that the
- * guest requires strict ordering.
- *
  * This is a macro so that it's constant even without optimization.
  */
-#ifdef TCG_GUEST_DEFAULT_MO
-# define tcg_req_mo(type) \
+#define tcg_req_mo(type) \
     ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
-#else
-# define tcg_req_mo(type) ((type) & ~TCG_TARGET_DEFAULT_MO)
-#endif
 
 /**
  * cpu_req_mo:
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 7a5b810b88..a5a1fd6a11 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -77,9 +77,6 @@ static bool default_mttcg_enabled(void)
         return false;
     }
 #ifdef TARGET_SUPPORTS_MTTCG
-# ifndef TCG_GUEST_DEFAULT_MO
-#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
-# endif
     return true;
 #else
     return false;
-- 
2.43.0


