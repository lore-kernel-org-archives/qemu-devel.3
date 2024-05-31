Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE57FC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD109-0004aE-CB; Fri, 31 May 2024 08:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zu-0004Tq-6s
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:38 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zr-0003WG-3b
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:37 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e73359b900so22626551fa.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157071; x=1717761871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WemVooe7jVrEZVThnl7qxXnfDDz1+XFheEherDLTAvE=;
 b=Tnz0NhFr91aXM67b/4qf4D8tVenpPKxSuKnWRWODAsdRo/qUqcD4NukyT2CrJgH+Wx
 alGufi/SmP2bAEzubPD65c2amkStCbW0/s9OXRYSVVt19lMKQplyo7PYm6DzUzWnr3/w
 fPAyjTcgR5JfrT12A9Wi798nBeBJ8D+aiVS1Ve9GLTdvsgzpN6+dl6+3Hub57ZWr5rlh
 Sbvvit48ffZ/SILBden+lo/TUcNaw1HR9TQx9v2wE8fVEXSY3NDzXYVGVm0CQbFbSq8s
 kK8giW9H6N/sKCo06rp0NUYkBy6zFPI12b3/MpEm01NEfLl51GK7AESwSG2x5rX23vLg
 tU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157071; x=1717761871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WemVooe7jVrEZVThnl7qxXnfDDz1+XFheEherDLTAvE=;
 b=fWFd7EjjFTVvwyfgPiwuu1vpky+X33qzXMqR1BK0ZZaeLrQXejLpZHol8tqovbNh24
 /4Boxuw1zRP1V5aaJ+7bkOV+kKiZRVe1qD2oFIpvEqvJMi7+KHKLh2sq+fRVnc+en/E7
 X4gWfwfsgg+Cn4xT+RZQ5A2d57H+K4ymFHnYCgm8q8L1qVVFhkp8HNPhCp1Tn3xUTQNQ
 WWktw37y4FCSpuPosmb6d6cJdXxnrGvOIcWlpc/9etiiKZgwsirI94Q/B2tW2DCISF1S
 syqUHNWhnjfFgNRrHWyrAsWO7CnLaifde4ppEolCRW5K644a9vBLOn2iIR/TF6CiDHL7
 oQHA==
X-Gm-Message-State: AOJu0Yyo2E92PEZ0I+7xQJwcD1OygUUKwuyXazTSzVy5gkpDIGLh2FDo
 aVPkxp6Laz6mTVt/hKvvl6yQns2XGPNgUOtBkAvZXYZ8/rc8MEtrj+fE1rvrcfkkARyE4FDmMzJ
 t
X-Google-Smtp-Source: AGHT+IEzbPwfFhyA/4Ir5tlIYVPGVJFiYIAKkCSm2q04em7+JMRUmwKNwIBuCpX/mzj7ggOQuHDLOQ==
X-Received: by 2002:a05:651c:499:b0:2ea:853f:18e4 with SMTP id
 38308e7fff4ca-2ea950e5266mr10657301fa.13.1717157071012; 
 Fri, 31 May 2024 05:04:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/43] target/arm: Disable SVE extensions when SVE is disabled
Date: Fri, 31 May 2024 13:03:57 +0100
Message-Id: <20240531120401.394550-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2304
Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20240526204551.553282-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c15d086049f..862d2b92fa4 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -109,7 +109,11 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
          * No explicit bits enabled, and no implicit bits from sve-max-vq.
          */
         if (!cpu_isar_feature(aa64_sve, cpu)) {
-            /* SVE is disabled and so are all vector lengths.  Good. */
+            /*
+             * SVE is disabled and so are all vector lengths.  Good.
+             * Disable all SVE extensions as well.
+             */
+            cpu->isar.id_aa64zfr0 = 0;
             return;
         }
 
-- 
2.34.1


