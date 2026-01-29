Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E7AD6100A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlQJG-0002VS-3N; Thu, 29 Jan 2026 06:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQIn-0002Ci-UG
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:35:14 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQIj-0007lO-LB
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:35:09 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so8835685e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769686501; x=1770291301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onHeNG6L+Cp0GwsmRC8UYqSZ2ksrcTcnPWdFnALo+iQ=;
 b=yw/Ygh6McKOFyBUy10ahKuKTVXde3utXD+DxJTepEmS8wzSe1TpHnLoNlZAXxCI5+D
 OG/Rr16EKKarBYjphRfz/mmf3CByvpOWxyi/U0DNic7xb14pRsF4PNIYsWGtRYftngBb
 A77r7V3VhdYZwQcXpBLeOWz51SHCpTr9uubaD/TFGBKKKWZMpb/kuGMyFA7h0k/A4+d8
 fAugIasuVYSm642XOkk6mfuJVD6oX46kCF9YiePedulC7fTDHhs0JR/NjKuTuLUdsBBm
 EMdUGRtX6RgYPcquvfqBLhGkI6TLgumkLdq/fUs5xlk6MLa3m9M3cQKoj/77HYw5K90c
 KRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769686501; x=1770291301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=onHeNG6L+Cp0GwsmRC8UYqSZ2ksrcTcnPWdFnALo+iQ=;
 b=SUxIMYcaMufKiwLuQxurqFhtUAuvIkaO/NPhnmiJkzMha+mJZUfyjJkDMQFrkYrCUm
 cVFnHMSyNL9teLSgG+FAlZgB7qlprsfsV6NjeFMd+VEojYJcbTH3f2rkiRxX84sypk6N
 ThywLP2Op0bpqge4bERGp0EO33qnfMiRyfZfM3FjogcqPDcgi4a/fxi2WtB2shkPFv8V
 qHUg9bB6xVjDJVGWxUAyz+kHwnysVhdicGpTWF3U5mBpIPmZwl63Nkcd7+0TDnQFFXv6
 6VNCQeJju8kV9qNOKIvjRC1UPoP2LgVhK+zv+GcXQ52mGgeueqaM8fvdvYamfhXXY+Hx
 wphg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzZV3LUmkgeHYl0dOKmtC/oI4l4rwkCcmwS4EIOvEovVSrzh4Xnst7z+NyURTLJ9qFfI723/tLqdMS@nongnu.org
X-Gm-Message-State: AOJu0YzJtGgwQVQp8DnGud1P/419kcWBCmnfn0Dof06VCO8iNy5kwHH4
 gcpGKikstuTOP+S6/g9fS/falmvsCfexWGWv4Q9wSAQkschFtpVUE2nKDKBveLYowTE=
X-Gm-Gg: AZuq6aKeit9YnkqeQVWkrcTyHGCMJWHnYDuz8d++5c8tCAI8/PaFIJ2ReR/UqHn8lmI
 qZI6J/XfGmCfB1bfr96QNqWNgCVUipS7avbtGi8u6E9d8zp1LBIB0NuJpoqSEZmjmWXzzz6KYMZ
 UGjK1KmEW/LlDeNz6rR4nJ+MyBIhyNvQdNRx7ju502GTnICNMMCSLI1jAXUs0Cg+Rcabkt19Sbu
 JEdAPIWUYJ3Yq2Urh4fcS4RObK2IivQk9NCg6G73WYq8Pz1mZ6vIOiMbnHHGWPSyH14jDZILPXV
 WH9L6JTgidFiJ22N2lRXDEHzey8IxmxOBt/vcp8ajT+AVHQKOz2hA936mr6YBAzenEnATMUD8QR
 EQ8Fuf7FoihA73XPhGScPTIMu91NY6DMFBjLjLOt+V96IIORLiKjCrysrFPpnIcSclgxgiD8kom
 wUm9AMC7CR9lfuA8V/Ewb1sCRv26twSfQUjBkvRvKZ
X-Received: by 2002:a05:600c:458a:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-48069c0fdafmr95011665e9.4.1769686501580; 
 Thu, 29 Jan 2026 03:35:01 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm196311075e9.14.2026.01.29.03.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 03:35:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 3/6] target/arm: Handle SME-only CPUs in
 sve_vqm1_for_el_sm()
Date: Thu, 29 Jan 2026 11:34:52 +0000
Message-ID: <20260129113455.1283266-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129113455.1283266-1-peter.maydell@linaro.org>
References: <20260129113455.1283266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In sve_vqm1_for_el_sm(), we implicitly assume that the CPU has SVE:
if called with sm == false for non-streaming mode, we try to return a
vector length from svq_vq.  This hits the "assert(sm)" at the bettom
of the function in an SME-only CPU where sve_vq.map is zero.

Add code to handle the "SME-only CPU not in streaming mode" case: we
report an effective VL of 128 bits, which is what the architecture
rule R_KXKNK says should be used when SVE instructions are disabled
or trapped but floating point instructions are enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7ceab0b503..732c3a9eba 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4763,7 +4763,7 @@ int sme_exception_el(CPUARMState *env, int el)
 }
 
 /*
- * Given that SVE is enabled, return the vector length for EL.
+ * Given that SVE or SME is enabled, return the vector length for EL.
  */
 uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm)
 {
@@ -4775,6 +4775,12 @@ uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm)
     if (sm) {
         cr = env->vfp.smcr_el;
         map = cpu->sme_vq.map;
+    } else if (map == 0) {
+        /*
+         * SME-only CPU not in streaming mode: effective VL
+         * is 128 bits, per R_KXKNK.
+         */
+        return 0;
     }
 
     if (el <= 1 && !el_is_in_host(env, el)) {
-- 
2.43.0


