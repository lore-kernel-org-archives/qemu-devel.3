Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AD0D690FA
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc2m-0007Ft-RK; Thu, 28 Nov 2024 05:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGc01-0002Eq-Qy
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:44:00 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzu-0000hD-QQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:51 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3822ba3cdbcso462952f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790613; x=1733395413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M59b1YXia+t10MRDfuwOiG0kBN1H5nWvD2y8aDo+yb4=;
 b=LRsfQH2qLXzucM+4vtMquZLThHXOnKlyp1rVEbPjCVWumtNlHq5LiQE6V7fFVzOnKh
 MH6Cfsxeq/pkC0D+SIuZH9BzMfnxHFsrjOZRB95OPNG5KZshxUtnjQe7L/oLR0KbKOMG
 nnQOWdEVppz1rxM/M2sUQ4KOaSs2TbNBRuyALU5bK07zArXLx5/pydnnIzlJ4+p8Ganh
 qKt6aGkhH5mTB8ihaTs1g+fNRag/vfnPWJUbi6aeazmfBFBq7N4cAbXuJVMC5iqsn2rI
 6oeOv8venAUiypzn5+MqJAWl4hInFO5nYvtMzDKZsFNhqaqb3GoIdg+jEmnc0TYYfBrp
 5tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790613; x=1733395413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M59b1YXia+t10MRDfuwOiG0kBN1H5nWvD2y8aDo+yb4=;
 b=c7EVi77uk2YpgIn9pzKihtAeJR4DIOf+wNSC2bUhvDFVJhYAn6+Vm5mXJa3+6JRa52
 D01PjkhruqVmzH5HFgi0PSTMbrpmEHaMgprdoIxVu6GkOTcoQAFR1bEQAwgrkkhsUYE1
 /e3j9nbSYJ1kQBwkMjrd3HCn4J601c2EgVXmvwsfmJCe2CgNVOwKbgM11mFExSfswFoc
 tiHd6n6NBrIx4bi2JP1lnxvYPOhP+d+5bYDT16QLHq5AzE99vj+F2mkPAxkeONqmagHZ
 5zPueDBZTVmZt92Rz4rpdyl4UmEdwlOOG93jU/xQQJHUVBhX2x+xaEzlQV6TdPKqzuIE
 781g==
X-Gm-Message-State: AOJu0Yzb0y9yEqjZ6ftqzt1fttMy5vnyhlm1QFONvQMXRUVXGCq/qnWM
 wwxM5upTubmUesLZfLixp1DTMfnAIg6pazOAC+tObQI3xz3oE41w8irGzHRgpnUHGgRq0DGolcm
 1
X-Gm-Gg: ASbGncsiqwSOIUblmkpq4uVczKpKfA70HazIk+lNaMyud416sUHppph6XcZd4o5F7R4
 fFXHPOQo2HREx5x7VAwnl2sIblBcyTLNAxy4Y7XymBIaqzlXi1KE6DckQ1w/+DSzO0AzqYCDp0t
 1YO0yQBuoA2Ej2YatTlWExO7xVRwRjaGpRXTy2xVashi4O0dBQwxdf8IU0pTzckT0g1yd/sLtWV
 iQQL4mnzVwJgER92p0duoRiU7Y2xazE5obwynwl0RADgQDlHw+rZD0=
X-Google-Smtp-Source: AGHT+IFDBYQ0p8AMJvWcntf+/F6gf5Yuv4QaJlDohlcfyApXLCO7EQn6BfhYVR4vXEVLllhC1tMn/Q==
X-Received: by 2002:a05:6000:2d84:b0:382:5206:8b84 with SMTP id
 ffacd0b85a97d-385c6ebd177mr4215378f8f.14.1732790613468; 
 Thu, 28 Nov 2024 02:43:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH for-10.0 20/25] target/sparc: Set Float3NaNPropRule explicitly
Date: Thu, 28 Nov 2024 10:43:05 +0000
Message-Id: <20241128104310.3452934-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Set the Float3NaNPropRule explicitly for SPARC, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/cpu.c             | 2 ++
 fpu/softfloat-specialize.c.inc | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 61f2d3fbf23..0f2997a85e6 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -814,6 +814,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
      * the CPU state struct so it won't get zeroed on reset.
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ba, &env->fp_status);
+    /* For fused-multiply add, prefer SNaN over QNaN, then C->B->A */
+    set_float_3nan_prop_rule(float_3nan_prop_s_cba, &env->fp_status);
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 31b23ddb9bb..565790b1834 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -508,8 +508,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             rule = float_3nan_prop_s_cab;
         }
-#elif defined(TARGET_SPARC)
-        rule = float_3nan_prop_s_cba;
 #elif defined(TARGET_XTENSA)
         if (status->use_first_nan) {
             rule = float_3nan_prop_abc;
-- 
2.34.1


