Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF02CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlDU-0004OC-Q3; Fri, 04 Oct 2024 12:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlDS-0004LT-Sh
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:31:43 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlDQ-0005ah-N5
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:31:42 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53997328633so3374293e87.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059498; x=1728664298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srr/+wHoyELt07jjPH89qrlEvr/MIKBSh1HnIzun2fE=;
 b=XfIB3/HOKogcZq/TTpn2mwWX7F3m1ILil+ggf0zuHBOhtsbB58weTeg2+BCeA4CpDI
 v4IqQ1JwEjcz8AZn9F7p9N9MsdFLxsoYl03jpmK4l8NKrlvVlZTlw29/bS1elNxS7xt+
 lKMQpVt4UkBVN0NNEsutz8heacF41JMu1jO80rNp8i9vtsfwsi4Ui1JDQws/VD+qpROZ
 KdvFHRbR6VC6bZLjv4QmulQqNwQp319QMYZ8p94FLg3uEelK9mykpwM21c80ui7oB2FH
 GPWPbld4zDy+DZjF32ua90RYZJCTf6biCdu1uuzzIi56O0iqD8cEHkYSqPrZTminKBeF
 00SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059498; x=1728664298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srr/+wHoyELt07jjPH89qrlEvr/MIKBSh1HnIzun2fE=;
 b=MaXfuEoPzgwbgbdrxKxV6vLRLURv+8u1UH+VOXoAYFO4mLSuChUttM14vif6kRuxHn
 vrEEcJkVf1y/pfZgXDGhsB/PM+kTKzFAIeO2qM20SRFxkD4TgOpl3RvUlSTyCWy+k+i5
 4aaDEgpZirRtFlVEW2xlPT9yhmUC6yOuXvb1eZOBthJL4Ql/GNBA8SsKPqntBuIMhlpU
 hrP+SRN8QqOWXR+lydAQgTNY7bjGig6ezVEMO0jrSLd+8NzNmuw9BkBTPJp9/SkPyetm
 Vm1iVmcKhg5JymdQAaoENBZ7KCv32M2AgNEUjStAiMCXdOGYkGitHdGkfKy4pFHC7KfR
 siTQ==
X-Gm-Message-State: AOJu0Yx8CnJDa1zdfnrRYPdTTulM5/+rK+qInEwrguD/jUOYGAPpagde
 vp6kGHxGAzAzKMl0fM51/iDlapOvVmiqaqxWZDRmsGpadO59F75Vv9vQxPpjipLjo/8ou/di5h3
 uoFRzlg==
X-Google-Smtp-Source: AGHT+IHJR7ib8v93RUrkaUqyzDERERj0oMk+Ip4lCEyAPZf7wutYpoQaivUCAVQhCezLA/67oTXy1w==
X-Received: by 2002:a05:6512:e93:b0:539:947e:18a6 with SMTP id
 2adb3069b0e04-539ab9cf223mr3337059e87.47.1728059498371; 
 Fri, 04 Oct 2024 09:31:38 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539afec1034sm1885e87.13.2024.10.04.09.31.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:31:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/25] target/alpha: Replace ldtul_p() -> ldq_p()
Date: Fri,  4 Oct 2024 13:30:19 -0300
Message-ID: <20241004163042.85922-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

The Alpha target is only built for 64-bit.
Using ldtul_p() is pointless, replace by ldq_p().

Mechanical change doing:

  $ sed -i -e 's/ldtul_p/ldq_p/' $(git grep -wl ldtul_p target/alpha/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 13694fd321e..bf5091c2a6e 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -59,7 +59,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUAlphaState *env = cpu_env(cs);
-    target_ulong tmp = ldtul_p(mem_buf);
+    target_ulong tmp = ldq_p(mem_buf);
     CPU_DoubleU d;
 
     switch (n) {
-- 
2.45.2


