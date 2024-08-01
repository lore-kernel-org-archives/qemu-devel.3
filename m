Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E988AC52D6D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWiL-0004w9-4u; Thu, 01 Aug 2024 10:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZWiH-0004iD-Ux
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:23:30 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZWiG-0002eN-7y
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:23:29 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52efd530a4eso10870635e87.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722522206; x=1723127006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bek6kRqgfRzW+L/s2A9z/Tq60M2bck1dCjbLVYSP28w=;
 b=s8uVYjeP227e5wmxqTO5buNKKkseicQxqxXI23OVFVgTJwG6ZQEMgo829KidsiD3a9
 w02D2gdpJiZ9r8xrBZoD+n7OTCAvXOnXrOvX1AiR3quDv7nZOJ9IIIbu7aJHfLzBkOgn
 Q5pWFjkW1qiCKEMkCpnsMBjeFPZrLyaXg46Q03nt8DJ88FsYRyjkNnDmEelJ8WIxTFRd
 kLWstTYLNkN/Z2LtK+JIIQtyT2FkqOF/IM1lgvd5SVd9iJWf8tpinSEka34wYnSI8cna
 MRbT/9sFt2IWK2dk8fc8nmRjFYSwDSN72b02n9PCU5H97tNO4wMh/QZ2YbPqio6xaDT/
 sr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722522206; x=1723127006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bek6kRqgfRzW+L/s2A9z/Tq60M2bck1dCjbLVYSP28w=;
 b=PhXj1l3m8Jlt6+eoOCcVdDDDxDf6FKnooy+XtkZYx02GjSJ0NbbwLZYvGvrG2UWHaR
 Bkg+s7UnIFXJRF+pDZL2/XW9F+h2EXC6xcgu1Ll9Fvr0Fblow/6Cf4Ps/XbQ+UMhKeER
 w4ULaARds3irtfQKo/c54JP/Ae9stWK449mtE2cEt/JgFIBFml7MBcvnRkkB9J10f8vf
 SMnLPOHHRin8WryzP583EKJyBC53uX+XiC9oN0yfGjyroeACHpj5twihf4RVAMiMHZfz
 0XVvRF0dA8A+dHV1kN4qrbdUAANaigvMluys4hyJFZ58uzC+n/lSuYoCc70uIcA2CPo2
 DilQ==
X-Gm-Message-State: AOJu0YwJ4xxAS4OLDClsyI8BvD8J4sWYEiMIFtq2DANkpUqKf8efHX+d
 Wl/BAMWhs14Vs98/tkMMqOsFpLXqCsPo34QAly4o2wR3bsFwlCUcK2uzMmJGnvPPFapXgSTBEdA
 e
X-Google-Smtp-Source: AGHT+IH53T7pebIemw95fooMDr/bmv9tmNtJUgNKsMv/ZaKADbr5vLwLYRMGZExvlAdHVmNU8RoztQ==
X-Received: by 2002:a05:6512:3f0d:b0:530:b871:eb90 with SMTP id
 2adb3069b0e04-530bb39b860mr20663e87.40.1722522206167; 
 Thu, 01 Aug 2024 07:23:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e08012d7sm29657435e9.22.2024.08.01.07.23.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:23:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] target/xtensa: Correct assert condition in
 handle_interrupt()
Date: Thu,  1 Aug 2024 15:23:22 +0100
Message-Id: <20240801142322.3948866-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801142322.3948866-1-peter.maydell@linaro.org>
References: <20240801142322.3948866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

In commit ad18376b90c8101 we added an assert that the level value was
in-bounds for the array we're about to index into.  However, the
assert condition is wrong -- env->config->interrupt_vector is an
array of uint32_t, so we should bounds check the index against
ARRAY_SIZE(...), not against sizeof().

Resolves: Coverity CID 1507131
Fixes: ad18376b90c8101 ("target/xtensa: Assert that interrupt level is within bounds")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240731172246.3682311-1-peter.maydell@linaro.org
---
 target/xtensa/exc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 0514c2c1f32..ca629f071d1 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -171,7 +171,7 @@ static void handle_interrupt(CPUXtensaState *env)
 
         if (level > 1) {
             /* env->config->nlevel check should have ensured this */
-            assert(level < sizeof(env->config->interrupt_vector));
+            assert(level < ARRAY_SIZE(env->config->interrupt_vector));
 
             env->sregs[EPC1 + level - 1] = env->pc;
             env->sregs[EPS2 + level - 2] = env->sregs[PS];
-- 
2.34.1


