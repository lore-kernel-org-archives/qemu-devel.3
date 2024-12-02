Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF61D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Ud-0001wM-Dq; Mon, 02 Dec 2024 08:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gp-0002gr-0g
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:27 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003CC-1k
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:22 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e87b25f0so948439f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145248; x=1733750048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkb6PbnkCxHke0j4zsNXKqcSWFA8ovR1gPxWc3WytsM=;
 b=YJfNazbbaAcJOLPmHYZAkU3K8yIOl8c3Q6hpGd1QZaFLbC5fjDzpO80s/Ey4GhETZV
 dMpRAzLpKwAqhgsH1lvLfIZ3aC+P7LTcemyJ+CCcsdbT7Mv8jlIAp0zT4if3i6s7FyPZ
 W/zzSo+DY+blCrpcjuZfa8dTho3ZcGLeBXD7LR/qIId0LzJkqHzlrutkGReM9I058BqA
 IZUahFOS7K36l/Wpts2fetm6cgCjwP4MpKgL3zlCbB7qN7hspTDh0FHJoqOpg0p1t80t
 FtsperaUU+LrBzMNCAXhwLH5uNbIwSvkGPl2FbM2NlE0iLAeHiKqXGVEQkXRCLla1TI2
 B/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145248; x=1733750048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkb6PbnkCxHke0j4zsNXKqcSWFA8ovR1gPxWc3WytsM=;
 b=JbgPFiNvXH5gIR1yvfiPrDQ4T79uz2tcok3St9NoYC8FmL+Ip50/TiiLieWdIbk41J
 5GNpxuZJXh8Ciqvbzu7MHqW0c+LCoSrWS8atRGAT1ewRhny7CUXhPZgxuhvtPTn27wl4
 Jd353K35bEPOQxD3JQ5Cz9RK5kJlrPMiJNDMU8ITHVspZxRGo6Wrr0pxMvzXppwB8aOw
 xtWIYs3LqjKZ68Q7wxsBvw2oT+PThK44g+u+UsGOqfTFJxQPTBqyJaTbdQgC7xuX3T2l
 qAlKJJL2vnmCDm2AuWWxEFCHD2sk5bh9Umar22nbdXhtB2LE+a9L7/HSUT035Dx5CPK6
 ZhhA==
X-Gm-Message-State: AOJu0Yz/udnJtCFIa4SI0bNByoTqkEIKc+3SZuaqTwroZ6/Z6YmEEusB
 djBvi89GfgAXBuIa6KubfCatQEM5Oj3bS8LWGP0Qi7QioB5O4uocd/lN1KjuyJ0AfepZ2My77vw
 F
X-Gm-Gg: ASbGncsmI8h2tjtOYXrlRp2ai3Qyea0cBgGQ8jLoQZU/YllIbPwiFEOuQ5lReAj0qaY
 xSxDtRl7hD4KnRyTJpqlQAe4zhzZAcHzHZNsS8+yATpQFgacQ2Vr+BAFLFAGRWo467FNIRVtseJ
 o7lJXTkYFwRsgCN8oRDiN7rvDl7lMjo4mF8ux7jyXwulrMfZWTyB+kByZ/+SRWDVNY0g9bF92vb
 SW125TsbR8fChfQJs4/Kv9zxu5TO5VU+a75AvcXqkuJE78230DTop0=
X-Google-Smtp-Source: AGHT+IG6X1oEyIyDyppf7rwXx4M+n6JAUQhRDkZTGhHP6FublpG3tieqd2otQMma5wzvliP0/sGg+Q==
X-Received: by 2002:a05:6000:2a7:b0:385:efc7:9335 with SMTP id
 ffacd0b85a97d-385efc7985bmr4874353f8f.24.1733145246433; 
 Mon, 02 Dec 2024 05:14:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:06 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 09/54] target/sparc: Set FloatInfZeroNaNRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:02 +0000
Message-Id: <20241202131347.498124-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
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

Set the FloatInfZeroNaNRule explicitly for the SPARC target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


