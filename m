Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2646AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qf5-0002Qn-Hr; Tue, 30 Apr 2024 12:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf2-0002MQ-04
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qev-0005c6-Iz
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41c011bb920so17359935e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495726; x=1715100526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OMxck9KpF+SFTheDcuOfZ7ikJRZmZ4fmmOkZUV1rQxg=;
 b=BJORqfn49JaQSOFGJgOmqpFfNlrtf/ogL3CQwR7nbxw+g8pkdf27WPhIF8RJsl3Iul
 I2DDOS9kDsrQd+LYI1Re/RR4fvVR1/o977LaFXVoXnOhu1i5Ot+0z0uwj6yUE1mTmkeH
 gw3eSVK0xgSS8RSf5Z5uzQbtHjVUefLm8VCHbe4tfkLuX1oOvPMX3gfU1a54aeEQnIhv
 rKFNt+7O5outzvMSbHcYkF/nU0eVBN88AEdAFQfjMHlPQ5eS9MtHqXvqLacrUz6xue8w
 KIBqMKctIpImJANyZL9rQ39T62KyjbKBjv6ilrKkWNDlsFfm5FyLJMc2OFbIDXLDUrMl
 +eZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495726; x=1715100526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMxck9KpF+SFTheDcuOfZ7ikJRZmZ4fmmOkZUV1rQxg=;
 b=TzhGUrpLYmX+Y510Ms2j4i1KdkLhpN025D2nWBc6DEUycSwzXePU8Owd6miXATO7T3
 f92E/6X76zIjdNiAcAcW9b6dN3IGtqF/YpbQdGRf1JbsKLipKYZkwiveeJmxBWy3tt02
 AXH4VJG1B04XYPiPv9BqoZznExowwkFz5r7xYQv1OVckQaeTW7TdAL/vTQ7ofcvh3Hht
 q4xYOSmvcl0iiH/d83/WOR2jCtGkVIJqS4TbfH3b3pyWB2tGPv6Vx+SuuIRSAfK348Wk
 J4ph7xfxfH3/IChif3x+aJSd0aF6TdwHshgrnii4YKlH0cJqtAdmEoVfVEvDVkXjBVDc
 MqIQ==
X-Gm-Message-State: AOJu0YyutkxezjsYpuaSEGEYqq6O0OB9ldmpyma1SZKM1YEvahPgYqWN
 lRpA9AlNLExHT8UeSzEGWkDE6Ax6eo0PMzKCSBgV/CZBzLDVBeTmW6yNIoMvA1wGLyMdpFi/G5E
 f
X-Google-Smtp-Source: AGHT+IF8J3exoPVdS3M95wxRvHrOVPN+zffEsdSc1nhDU9lpMtXy/tBTBZZWHpTZ04w8fsvxj+8J3A==
X-Received: by 2002:a05:600c:19c9:b0:41b:f30a:4221 with SMTP id
 u9-20020a05600c19c900b0041bf30a4221mr3622296wmq.15.1714495726614; 
 Tue, 30 Apr 2024 09:48:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/21] target/arm: Enable FEAT_CSV2_3 for -cpu max
Date: Tue, 30 Apr 2024 17:48:26 +0100
Message-Id: <20240430164842.4074734-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

FEAT_CSV2_3 adds a mechanism to identify if hardware cannot disclose
information about whether branch targets and branch history trained
in one hardware described context can control speculative execution
in a different hardware context.

There is no branch prediction in TCG, so we don't need to do anything
to be compliant with this.  Upadte the '-cpu max' ID registers to
advertise the feature.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240418152004.2106516-3-peter.maydell@linaro.org
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 5fdc64a944f..d70b66f7530 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -32,6 +32,7 @@ the following architecture extensions:
 - FEAT_CSV2_1p1 (Cache speculation variant 2, version 1.1)
 - FEAT_CSV2_1p2 (Cache speculation variant 2, version 1.2)
 - FEAT_CSV2_2 (Cache speculation variant 2, version 2)
+- FEAT_CSV2_3 (Cache speculation variant 2, version 3)
 - FEAT_CSV3 (Cache speculation variant 3)
 - FEAT_DGH (Data gathering hint)
 - FEAT_DIT (Data Independent Timing instructions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 62c4663512b..8ad05c53e8d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1159,7 +1159,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
     t = FIELD_DP64(t, ID_AA64PFR0, SEL2, 1);      /* FEAT_SEL2 */
     t = FIELD_DP64(t, ID_AA64PFR0, DIT, 1);       /* FEAT_DIT */
-    t = FIELD_DP64(t, ID_AA64PFR0, CSV2, 2);      /* FEAT_CSV2_2 */
+    t = FIELD_DP64(t, ID_AA64PFR0, CSV2, 3);      /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR0, CSV3, 1);      /* FEAT_CSV3 */
     cpu->isar.id_aa64pfr0 = t;
 
@@ -1174,7 +1174,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
     t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT_DoubleFault */
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
-    t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_2 */
+    t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     cpu->isar.id_aa64pfr1 = t;
 
-- 
2.34.1


