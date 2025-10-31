Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4C7CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwj-0004cZ-UL; Fri, 31 Oct 2025 14:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwd-0004Se-68
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:51 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwD-0006Ce-Vi
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:49 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so1621122f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935603; x=1762540403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TMuql+NtLKlA8GuIs7V478yv/XgT4Lrb4R1PECeADQU=;
 b=pf+sbmjVVKO8hXLj91N5I/qazttK2Su97AazTQluDqP9W7khVh72UIMjYXtvY1OFgD
 tXC2iOdwW7Gqg7H0b0cnVAvro+UXs4Eym880PtODeLEY46nJ2Rdo0J9yxYLHoKyDgj3i
 sVfy7X2ICmrQA3b9/7L5NNiahYLvB+Bu6VOSugqXRJ7F/16fY9LGOge2EgqfkgEKDXAI
 FE+0jBlCA/aCMC9rK18r43Y+hUN2X5ZidXwI1mT5QcFpz7PAD4xbXV4i2x4Ab7RypqYF
 0RzgWYzagDwATKbWkIxNcs1HsTriTDGa5cL+jzwilTlMfUQjvO7iTS7L9ZT3ObY01YNS
 q7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935603; x=1762540403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMuql+NtLKlA8GuIs7V478yv/XgT4Lrb4R1PECeADQU=;
 b=l+aFbP4b2ZXPDmO0EPkc+VaMk4cvfXIjSnHoPBTOtpjNstZ5R4Qi0la0ooTtzpYEsn
 Dp0bDatU6voa0pUk0IyaBpYbAuRwvVZVevVxqbbboXbbhjWKIWiPoGPyB+gsqa8H3sTF
 rjVXGGO2evH0nBGZ5Kdhxo0WmnPR66uzUTWCEXIoy/JrZhld42Qw+rpPWegWe0StAtUt
 7JLQmBywMXolarPqx38+P+lb/5VJoEbAu7AxLnZ3TRkdK6rGooCmt2g/dXvzpoY+LkD1
 UOIkZu08KtmO+i/y3vcSxYf+Eo7vOl5dBQ56/b6/wfUrK6STUhuSL7D6ltebJ18JRXTV
 8OLg==
X-Gm-Message-State: AOJu0YxqnYM38GDLHHtsfOsk1CdxrLj1LOJiWSONanr9S3R9HTMgv5pY
 KIhAezYAXLhaKcMCo8AFAypCoaDjfO0+Yd5W065EbbCK5LSeWo5kq+/Enq1j3oR8AiJNAJhP4nA
 Os5US
X-Gm-Gg: ASbGncv3OrjA7bvYtDT6th8hTQD/llu/MnuVP7MpZbiZkzjpsBbQnRwrX+9TfsHNN65
 mEDyrBZJSE7C6erpoM8xXag7HTjaELLFsPzlC3BXSo4SXwnEUZsIratEu5L6oSHtrlpYguIlvzG
 vExzFCTZdNFvXVuV1FRosNcUSY/zRu+2qs2fyVL2gbm0iy7Xdm+HTulNtoUhr0mH7oB68fC4Slc
 aOBUlHW/3Vy2pOvrHkQeWTBQoK7oJFx+B6HK4hp5IBBn4YOD3it8U1iBvhlf4KSacALUyxnMRGh
 hGgGRkHVmERUsqlc933uoCJWnvcOZy11fyhwII+4LmY1JEE23tq7CH9xgI7COQz4tamUZekpZV0
 6rNHt+LtRlD2IQAPCnGv8ifjQzvHAEPpJhnktffAPjFvocR2zsVOKrIhuVudGAgJFqJUIDglWKv
 3yJR2cD4rxmVN2vBqI
X-Google-Smtp-Source: AGHT+IF1uhTJ21yDjLgrLB3wbPKJ3VpMfH/t055T0VkGRBX5sh4wBjzk4KMPtN5T/T43YWcEJdiuGw==
X-Received: by 2002:a05:6000:26ce:b0:426:d5ac:8660 with SMTP id
 ffacd0b85a97d-429bd6e3dbamr4377473f8f.58.1761935603174; 
 Fri, 31 Oct 2025 11:33:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/38] target/arm/hvf: Check hv_vcpus_exit() returned value
Date: Fri, 31 Oct 2025 18:32:43 +0000
Message-ID: <20251031183310.3778349-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

hv_vcpus_exit() returns a hv_return_t enum type (defined
in <Hypervisor/hv_error.h>). Assert we succeeded, as we
are not ready to handle any error path.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 91bbd3a6aae..4c98faebbed 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -963,9 +963,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
+    hv_return_t ret;
     trace_hvf_kick_vcpu_thread(cpu->cpu_index, cpu->stop);
     cpus_kick_thread(cpu);
-    hv_vcpus_exit(&cpu->accel->fd, 1);
+    ret = hv_vcpus_exit(&cpu->accel->fd, 1);
+    assert_hvf_ok(ret);
 }
 
 static void hvf_raise_exception(CPUState *cpu, uint32_t excp,
-- 
2.43.0


