Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3DBCA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4ih-0002RH-M6; Tue, 26 Aug 2025 21:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hT-0001BM-Ms
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:44 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hG-00008e-V7
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:43 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-771f69fd6feso2008021b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257087; x=1756861887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ru+zkqkr06yFhMECXXsdeWAo58OIAebY2k6d7rRmYv8=;
 b=sHzIwSCSW2TZMcdrstI/2lv3V8CwLAJ97Q7dBrb3a/f9UA3/E+Od3wXZ6Bm/algYbb
 N9tsrrVrD7mYLgrVt0gwdA5GBRrAdDsDC29tR2iK1c9vk7s5GISi63EH1FpnC7vbvW2k
 adI0vm5AUqMbefgOQPQSrENST/W9dmVFimU0jb5gSEA8MXb8SqggJ0r2N9eGwWvbAMQG
 56FLcG4gB+CjXlU/C+6Ysv6+PUZrmkmU4/Ide/qrtUEWLQz3cRL3ltZpyYm1PNQk7vR5
 FB0w5TdQvh4eePS8jRp4Z6fekt0U+5PoH0yp3eNGZSIokNa26ecRCsqBt2YCdWIQXzdE
 MlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257087; x=1756861887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ru+zkqkr06yFhMECXXsdeWAo58OIAebY2k6d7rRmYv8=;
 b=JlUQxxD2txLGNcNKQXMnHh8sVnvpG91kDoIVbesYSsnYXkhCF8QozS0HorlWIzADaz
 zwkG2bwNLl96xtg0Gs/xoEiZ+/hSLLJgd2eocTvecTvRuilbv9WUMtNmsvn6Te2BZpQh
 l0nIdlcBNjRh3AVXvoU6HqvNLk5jPo4JHKhuq5nmaL/mbdcZbLqubGfX5tr73/Gzgehy
 9JhQr/jOtVercWNpo6mK1G0IjBto0ba+aEud5k3NGnHoA9H+tTW8bnzT+OHHyLLMyJWB
 e4ivFC2qyhvsEjpO3O21qbrcEFxI6J3HyH7CJDPlPOcQb2YN5O0mkgzu0h2NR2padteX
 aVbQ==
X-Gm-Message-State: AOJu0YwIj6EsCZHYTnjMBjL217U9zO2taHjSaiED3ZfSuca8H/ZLyxLm
 f5bqHYhOTRJmBsIxsyhuOM9k7cJTL41FgnLmIOpJOWhsyhF0bfEqBdDv+qGM116cD/nPC+V8IdI
 A9LAUjKY=
X-Gm-Gg: ASbGncsK2qh7QKQdApeaEcoG4pAcLIeRXJM5HkuZJ38mLhcyVzg3hAbJjGZoDOk56gR
 BiFtSNhMwU7DgUojKHPNZ32g4/F3nguIGSPWJmfjwnMwsMCXtFF3FqhzXOuYWiD6VZI9zFx9JlH
 g/fc4EIPwuq5PjyJRmZ/Urb09yd/XU3q/SPE8/mlIyf7zXXX93xg0TzTzqGu1Sg6OgsnD4mkNXy
 gIOvWmAg1e/SqkGUuMLn3rg9oH4jNR/Pk1dE+5YRaYFyPmcChsq5oh2At/9gOE5Efw7spKjmvE6
 viGtQkD+bhkJEPJHGGaQcba+WB2gJYlh8y9b8pXp4tt8ujWokizkh75KtacIr81qIO3Qayc3y5J
 7CPw8sl5zAHSf6YO3kfArroqQ/Q==
X-Google-Smtp-Source: AGHT+IGUkLAlYe8hrAm3tLT7bhBS/qc90gC+/iZcUYazS+zdqR3jVkMhsjj7ALPnjydCo231fV/W/g==
X-Received: by 2002:a05:6a00:9296:b0:771:f309:c04f with SMTP id
 d2e1a72fcca58-771f309c572mr6566051b3a.10.1756257087207; 
 Tue, 26 Aug 2025 18:11:27 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:11:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 45/61] target/arm/kvm: Assert no 128-bit sysregs in
 kvm_arm_init_cpreg_list
Date: Wed, 27 Aug 2025 11:04:36 +1000
Message-ID: <20250827010453.4059782-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

KVM has not yet enabled 128-bit system registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 9e569eff65..53c79041e1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -803,6 +803,8 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         arraylen++;
     }
 
+    assert(cpu->cpreg128_array_len == 0);
+
     cpu->cpreg_indexes = g_renew(uint64_t, cpu->cpreg_indexes, arraylen);
     cpu->cpreg_values = g_renew(uint64_t, cpu->cpreg_values, arraylen);
     cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
-- 
2.43.0


