Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B6EC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d5g-0008Pw-3z; Tue, 29 Apr 2025 01:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d54-0007hp-JV
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:31 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d51-00061R-Nd
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:29 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22401f4d35aso67683345ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902825; x=1746507625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lofZ2Bm8qaw0g+MX7QK5XKjfJFx9l5xRSef1IWMqPI=;
 b=raYmbRQeS7kG+S9kKd61UZWqNSKkjxL2obe4fqyQ6QD1EaazXQKdtFsF1uOgkW4I4e
 8oa66BtnKHDm8lg1Cs2j72QugHfoOB6qrouX4Cj++1RYF6kGj20j26LclDafVA4LQ708
 5PdBa14CXeYuSKyWiTR00QAkQwE0zR9ADju991ojjv90kgI7Ia8r9Zqtpvjc5OJ0Tkg6
 +tcwcXETPAWAjcLShGezqxmMoDG+NULWUXs9oSVXQ1L3902zc9XmHNhnL6hnIGqobZEf
 ajOQK43WhqVFltVJgZofP3uW4C4hw2kfNP3Z0A5u36E6od/aoh9nmjRhGx84nh7WQa5t
 dfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902825; x=1746507625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lofZ2Bm8qaw0g+MX7QK5XKjfJFx9l5xRSef1IWMqPI=;
 b=pgGgN34cHPozsDlsUj6MbuJens5T/R2meM2XaHEhXe09dO4Fr7OPa6fALnlQMGpMrN
 d90pRp/aoR+aJrgq4IrC5Wlb/+HuoLmgMDnSz8I3hm++ogWrGzzQLeMYRrM7gG8Fr7bc
 fHSWXM86+mCMDLUQiRG8OWDu1X4ViQ1AOfcMb5PdIBcoXflF+4XzydWEovX+Ynqb8bsb
 X0s9F6SiKahD770bOx+gAzua7DffH4QwW+ZfVjQqtg7MTNc5zMKqCGSPl48DvCe/7GpO
 iko5S37VnIvD7yWcHnG5zm8i1zsZqUf2OcFg01iUUX1iMk5oPmoLeuAueGrHyodXAG6W
 N2tw==
X-Gm-Message-State: AOJu0Yy4iZvCV/9t5nmcMb1Y2o1RwpYJZ7QcFrLNY8sacbGfynTEHJGh
 5hS/2mArSMzhdK9Lb7CqwbhYbgQ6cLzmE028Nrfcrc5T6xgFTL8hIyCEv9MTliUn3UT5vdj/GnS
 0
X-Gm-Gg: ASbGnctV3WUM0na5EInWydRhQ7WfZMSte1NOZA7HEBQALAByD2VgZDeCM7xtzSsSEhi
 rsIq3WCBG/l4ZX5tZvGqtaEQZuAQCDlrAElLYz2zX1RwcllY9X/iwgE127D3gXVT67SK7vvNLFh
 XASPES2kyqDA1+qO37T+etsdutTn/E2oz7TYvSAKBSXXo0VCmkH5cdhZUY0TJQgT4f0SsWLsn9K
 fZVLtm/wywkEKx+w1kxXcGcK8UJEN/9psbrue1nVrrYuphVsE4/DHM41vbdOmaBSbdq47NU42ZO
 IaVAhAQo1zOoPPenxRmSg2nXCr+1UO1p3UC5+EA60O7Enf19mM8=
X-Google-Smtp-Source: AGHT+IHKajVGWFwx2GV64yYYge6HnuSIfHi7SBgyTCx5wiAVxc+fYk17l7nH2nNKkMp7ATQMXoSv6g==
X-Received: by 2002:a17:902:f70f:b0:22c:2492:b96b with SMTP id
 d9443c01a7336-22de7015dfcmr25481425ad.15.1745902825364; 
 Mon, 28 Apr 2025 22:00:25 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 10/13] target/arm/cpu: remove TARGET_AARCH64 around
 aarch64_cpu_dump_state common
Date: Mon, 28 Apr 2025 22:00:07 -0700
Message-ID: <20250429050010.971128-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 85e886944f6..48ebaf614ee 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1213,8 +1213,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
-#ifdef TARGET_AARCH64
-
 static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1372,15 +1370,6 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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


