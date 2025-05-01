Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E855C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLX-0005Mu-3C; Thu, 01 May 2025 02:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL1-0005B0-OX
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:05 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKy-00074S-O5
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:02 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso589990b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080639; x=1746685439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v43acThFN05/FatusJlue/N5CkXsn1OHHnhEzQzn40s=;
 b=XbLOu58PGrllZRs7HSr8qjfwt3mKU0mhOxlOzqdkhpuEpT9/dwSAUBS+yqeN2rPyjd
 sErEsbGM0gNiA5a4iIm7Q3yJkUEf6e8/uvAxRZa19ol8gGvVaXIsAHkhnt3/EkBsR4yk
 Wp8fNd9IcCKGbjWIAF7mojuAdUZ5FTIf+m5BaL0JG1Mu2ubIC9EMMOQed9/JOe6g7WVg
 9T2T/3TK6KevjJNaVnTpgb6lBPZTgdxvEZnYdTW3BiQCyhLqPYE1SXhWFQLrMLeL0MdP
 5oeYnTMxIQVEEfgQPiDsf52Klh4cKKFZ8C50OMw3wt6+5dD+Nzq1lcYgY+TPIy4VNJo8
 8Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080639; x=1746685439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v43acThFN05/FatusJlue/N5CkXsn1OHHnhEzQzn40s=;
 b=N1NXlPcbZFGF7kytRBhiegQU+Q53d6uRBPQUkVqlQcqHrpB8Tpl5hHASEapg3ueCad
 dQeXd1fUhwEmGqJbxib+ZbJhS4QK40POD41mwNddJ/r2Up3HOi8VX8+Rat/e70YKfivu
 zLFcEikDkECBpV5Cj/1S5U75LvCaiQ81Xsor1CkJeuM2ChKWA6e6m7gzXzNyegv2kiZB
 zwqeBydVnKgsAutWDci5oeR+4zLmWd7yc/EXYdo3dp7bp5DI7MT6Al1afqxCvqcxVSSX
 MsOT1lWhooOJzaZxkljBIfWML7Nss1qo/4Lp+ECdQfVKTV9GP3eJtemCP84Muz45kGLc
 EZrA==
X-Gm-Message-State: AOJu0YxcRWwOSyXJHMcHwvRdOw8as6EXAKa4lKkmnWyARP+Ak6JKvDvJ
 Qi3+aeBvV1YCdBQXAmRb8sUAlgTylIZzhxdKYQPG6EK1PmxYrIKNpSZrx4EvfFK6S1EbD0wYBsc
 6
X-Gm-Gg: ASbGnct2ABz4pT6UnYlGQ/YAXowt4meA6Txm2ktks1jM4dCXg1opMfg9u61eqBdu3SU
 Az1bHsFbvblG12vbxX6aZ382IpfUfORn6rsHwwWOjtHiyFn9RVNz5fZuZP6aXIqROGO+NHLfOj5
 msLgQOSg+uaIK4FYqmU4/hRNuKUNETRe9duVORNJRIqjPEKrVDqXv5vMlNjR/f9TDPvpLjSj2WV
 w4Q734mZck3+yiWE7JIbUec4FvJB3F2jrVZeRX5Ny0LGczcaAsJhDIFhiexPHKENR+lMUplDQrV
 hnKVfroq+4cq5t3NZqt+LNzYwXdAHBp5xJDdVO91
X-Google-Smtp-Source: AGHT+IGxPomAylWwLJi0L6OKGSROnLWYZiR31IMYciHNxQlk0i4DhhlCaz5LkQ50RwCVuokbYxi1xA==
X-Received: by 2002:a05:6a00:1411:b0:736:3c77:31fd with SMTP id
 d2e1a72fcca58-7404792b867mr2645976b3a.23.1746080639426; 
 Wed, 30 Apr 2025 23:23:59 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:23:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 09/33] target/arm/cpu: remove TARGET_AARCH64 around
 aarch64_cpu_dump_state common
Date: Wed, 30 Apr 2025 23:23:20 -0700
Message-ID: <20250501062344.2526061-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 37b11e8866f..00ae2778058 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1183,8 +1183,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
-#ifdef TARGET_AARCH64
-
 static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1342,15 +1340,6 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-#else
-
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    g_assert_not_reached();
-}
-
-#endif
-
 static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.47.2


