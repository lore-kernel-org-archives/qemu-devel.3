Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F06D690F8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc0q-0003kj-MS; Thu, 28 Nov 2024 05:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzc-000237-28
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:29 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzW-0000VF-MQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a752140eso5706185e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790601; x=1733395401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGeQkgWiOnpuuXWXZlTMDkuSTfoKIXOn3w/Ju141f2Q=;
 b=lZToagLg5Od8ckp1LAzBnxpaEWFSdxY+wwfHHJEQS+SCx9G8G5xkEPjdgc1GYB3Nr9
 Inv3wkT31m/pzuJH0CUCNNl584pKj9m1yl5Lan6ywzWydrpcoJc1pZajgfv5g9J7ZQAg
 LwkZosi4S814Gy2sIS6m2EJhUFLwNhZt8eSt2acxef/N2OaYePneA9Ki3xKDD/0e0DcX
 jK12FtzFQdjRtFqVNh5lKL3/IBkkgc4MPDQMrP0eCQ4u0+25aWz+OIjPD2BorZOnFDgu
 x2rcwpVWgB+YNz53BubNPN1opU1lnt7Urf6AMTY1gz97jN25q3y9hRkKTOM8doW3YcY1
 V+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790601; x=1733395401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGeQkgWiOnpuuXWXZlTMDkuSTfoKIXOn3w/Ju141f2Q=;
 b=SRTXXPppDo+1a8OIzOYmm5kDBX2b2wUQTDahcqofMOEhV5qmIuaTaPG8C7ldyYj35+
 muFXOpHUqbfjJn4D915wQyq8jHJiezWo8kzB38zZtdYKtQHPvhv6X9JJX9BAyBQSmxRz
 UwhpIwJlkTioJeMP3j74T5zvHjS1fL31dumm8aLNdPkOr6VMn2FXOsvFFta9alHgvnD1
 JPsyU6zUXxMlMKQ3LAbN4WMOvdEFrXBNco68vyV196Va1U5RmMkMzfXbMgHHDkcTqWeU
 8/Q+hdEf6pmYtlz2aiFKPK9A+vP10wDLKlsrTgbTvZwkEsK9umVMIQfrHYnxFlcFGmtm
 fSKg==
X-Gm-Message-State: AOJu0YxWuJf78inNe6ESPcVHUj6CwYhXm2BsUlhQlZzFuiUN/6D1k7HJ
 wEkJJXL41U7y6Cicbw4XTur3ZFsV3bU+FrPZpP12LVtj6GgNDBHaQWqHEwDiTlUAC7FQtiP4seY
 2
X-Gm-Gg: ASbGnctOR0Rxf+mjWpVXiPGWpqW9e/fxGaE8h6+mO8lQC8eaTymPhsCBNIWb/aDLgpu
 PWGwt5uO5uq26V9yw7grJ0jpzhXmP6v0xVntqH5E1rPVupVWPCUtCs+wRE+azWhWXlOR5YhdYi8
 HeQCCeVdXOi+1iW3iixOU9rZYpq8UUcu1EiLCZSp2WsLcDn177l93yXd07ubEESoUsJxOETl+pt
 +vY4H2zWEDouPGiDM3QkUl9mlti/ZSOuQVBp9c0s+RI498uleE3QHk=
X-Google-Smtp-Source: AGHT+IGjPCC8FhcTdAsDhnejmdWY3ApnB/Rlz4vhTiLGyw/FgA4UJIVI5PC65VDBKzcbWkvKFR0hsA==
X-Received: by 2002:adf:e199:0:b0:382:134d:65e0 with SMTP id
 ffacd0b85a97d-385c6edc41dmr5806320f8f.56.1732790601162; 
 Thu, 28 Nov 2024 02:43:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:20 -0800 (PST)
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
Subject: [PATCH for-10.0 09/25] target/sparc: Set FloatInfZeroNaNRule
 explicitly
Date: Thu, 28 Nov 2024 10:42:54 +0000
Message-Id: <20241128104310.3452934-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Set the FloatInfZeroNaNRule explicitly for the SPARC target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/cpu.c             | 2 ++
 fpu/softfloat-specialize.c.inc | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index dd7af86de73..61f2d3fbf23 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -814,6 +814,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
      * the CPU state struct so it won't get zeroed on reset.
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ba, &env->fp_status);
+    /* For inf * 0 + NaN, return the input NaN */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index db9a466e05b..7e57e85348b 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -489,8 +489,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         /*
          * Temporarily fall back to ifdef ladder
          */
-#if defined(TARGET_SPARC) || \
-    defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
+#if defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
     defined(TARGET_I386) || defined(TARGET_LOONGARCH)
         /*
          * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
-- 
2.34.1


