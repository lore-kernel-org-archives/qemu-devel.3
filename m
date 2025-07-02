Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD10C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwUP-00054y-8v; Wed, 02 Jul 2025 08:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwU6-0004xs-13
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:42 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTq-0007Dh-PG
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:41 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso2958591fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751458943; x=1752063743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phdMuO5PFzyuS0l+J9EZDp4Ant5FWeh391ft9bOj440=;
 b=DfR/EY1LqA953Zrk6ojxvFrHT2BmG09bIFl2jMesbajv7OdfjL8Fw8DPr4GmC43DPP
 cIu8vOCV4xvBjLVr6gwgaUW3rqXYBdZ9xyeVdg/1k1+/6o5iL4fL5Q4Gwb3P8zm8c5SS
 /QJaUyyWA/TsSQHYfLjiY9vLZVRX/z1Erk2ja1qJhTSIpVLhoeIDoXy7Yq5IQwmBSEAm
 lKXfzgRl176SP40EdwF0vb9tKBCh/jhewydYbV8b13sh1aMiEd/x50C/6iRv2nQdVjYp
 RQVJ+/iX72XgEUNbyAiZvjv0gjWUdRrvEl1fzxzgBjv6qvNsjeTOBMHGe8IXIlixnBZF
 W87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458943; x=1752063743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phdMuO5PFzyuS0l+J9EZDp4Ant5FWeh391ft9bOj440=;
 b=s5HbHpWdHiDHVJFWEJnzDOolsgIWNkDSddKz0kCqojh69nvmVxj1//pDGBSg1hSVHH
 c5/p/Fwy2RI8MwQEkl8718QL5PIm01ouBWlo12E1j9OPOblBZo4q8zhSg88gRG/lWYiR
 mFI+x86OcO7nIGlGLygfRs5/TNK+E3YW4/BXAkP8e4hg46UkgX/4C/WboadsdWRtKIb0
 gp9acqUWhnh1aVuxVPs4FgNYvm/JOGLR3LcDGguRJWqfc6u8J1ny5Ohh8mxDnwoET95s
 ttuoS45qTZ7rifLBEOCzDV9scaA4tOVEKPt5NoyPWgu/bOFHFvUDWkMuZw8cRF05h1BR
 2TPA==
X-Gm-Message-State: AOJu0YxnKyjePy3Q9Lgr+Xdlv5UHSWG5mOMdRWFbFoZaSM6ch1M4sRkb
 auPRo1BsEmPAvnFtggrowlbZvpQ9j0uxaEYyrAMeZIFcK98Iwfusm+rBJ+nuJB7qOHWA6mX8hez
 XaYra3WA=
X-Gm-Gg: ASbGncudHYjKLMFSlqnCYwbM88IEjEVOH1YKBHhFOgfbnxICX9HE8IkGR/zl3BLEynv
 oxoSo9iceYgcZLrmd8k5iXgFj0FH/eElYZ5Jpwus4rcV7xYKfw3NYdcAt3n/T/64rJGyY9aFOI7
 z5sv12TOfn166jmAKsTLL/3r2C9Ltu2EF9rUvpETNt/TQjFR2BMl0PH7+feGrtnum0z2XySl8HH
 rPONBwgqmgBdW3HwWccQwyTP2tUWakwHAVznGVO0LK4g+s9M5QhkgaEZByCqkSkOAV5+8zN8Wjr
 hvivewTfLUdPEJpBbWOC741M+m4TlawJnGyfjVac07NT52eH5lLn5M3DR40bdORpoBOv44or1Sp
 33v9P
X-Google-Smtp-Source: AGHT+IGZT6I/weadZbfX4/XW3bxIKBvsuN66aPgMB1uXdj2N1Uj3SoCrvNW9krezOWg0pb38YipVrA==
X-Received: by 2002:a05:6870:7007:b0:2d6:6639:52d9 with SMTP id
 586e51a60fabf-2f5c7adb95amr2103359fac.32.1751458943106; 
 Wed, 02 Jul 2025 05:22:23 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1bd3sm3785013fac.28.2025.07.02.05.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:22:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 06/10] target/arm: Disable FEAT_F64MM if maximum SVE vector
 size too small
Date: Wed,  2 Jul 2025 06:22:09 -0600
Message-ID: <20250702122213.758588-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702122213.758588-1-richard.henderson@linaro.org>
References: <20250702122213.758588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

All F64MM instructions operate on a 256-bit vector.
If only 128-bit vectors is supported by the cpu,
then the cpu cannot enable F64MM.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 200da1c489..c5c289eadf 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -237,6 +237,12 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
     /* From now on sve_max_vq is the actual maximum supported length. */
     cpu->sve_max_vq = max_vq;
     cpu->sve_vq.map = vq_map;
+
+    /* FEAT_F64MM requires the existence of a 256-bit vector size. */
+    if (max_vq < 2) {
+        cpu->isar.id_aa64zfr0 = FIELD_DP64(cpu->isar.id_aa64zfr0,
+                                           ID_AA64ZFR0, F64MM, 0);
+    }
 }
 
 /*
-- 
2.43.0


