Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC65CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDccG-00029D-6s; Tue, 28 Oct 2025 01:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcc4-00023b-LA
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:51:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcc2-0004LD-7W
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:51:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-429a0d1c31aso1065791f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630674; x=1762235474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zY05lUWL5hjS7DHXCd+KmMwND4lCTa4Rhsa0suClLwM=;
 b=m9xTbZUMWNbnlKrulpQiMlu1UIBc4mZnBNOU3hi42/HYt2beErL1VwKbjf0C1o8mxp
 TJigR9j6lCiegiKU7r9aOZm6BwIbTUZ3cq5xMQ0yUzX+jEl1TDxwm2wV3ytxg9q7cwMs
 VRU75dubJS9b8d4GJgUvUW8mOy407FLijVVSsiofEcJT6nnXXSu/3fC+D1UVoJB9Zejk
 oz7wGMIx7t3xVkj65oZzVZi5vMikxducBNLv1zwetk0D29b3pTV4ueOrUo29vvF/K+Sp
 sQB8Xy/uvZqP62FQt8dl298oO88EP80cGvlY3hkR9++5C95EMUE1Q6tOabwcXN3/KqVe
 dvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630674; x=1762235474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zY05lUWL5hjS7DHXCd+KmMwND4lCTa4Rhsa0suClLwM=;
 b=i+LMkJJZWRVbH9Y9O2DOnO5lR2Ihw6aWa4i+PV580TBdYPGNyWqtoxF/6CwQWxxgb3
 qJ/SXLrPm/cyUdMWtn6veS79t187jtHjKATalVkEa2q7MheriBZmoBXj7hpJi3DQmsqP
 t3n7Clo0pdGB5FOyWZxcbVfzAbSPhX+zpZxHaX/BNsFn8uJdDXN/9eS0wjrOv5PfGBJr
 dd6We9WI/cQ8/d3FwzdUPpoLbVOsW0eaPO14G+l/oVTH40ry/H1Ueo2Htih5k04pGGSn
 CrdTxs5V9WsjRWnoh9cp1hCcksW6bg6IvQulaQ7w0ruo6vI5dAUfNUgSjpligffieCZv
 P8kQ==
X-Gm-Message-State: AOJu0YyC1UHw242qfcruHaY8mFOXUWx139fIPQcrytJl/k/qH9TgHfQU
 QFBjaAuV9uAG4s6n/itjiyfISX2tqqc6J0XLCfp5ewPTaIOx2clXf75z28cIkJCG8mrxoms2TFa
 30YnikYE=
X-Gm-Gg: ASbGncve1KgG/ZBJv9zrpNoV7mnYfVoOI2BCOZ+JtHsOdhN8eHQ6cELhQQ59rPnopB9
 b+EMRWvuoq8EF+VOJbhq/yVDOI2CCw7fSgVAOYtFfvT1cqZSp2+59J2QLNafgtNkMOU6Fqea1/5
 /glbCEnRDCsCOPyKPFgES3HJBMOTKRYBaBoTovcPg1bIdcLH4nAF9wZ5mxMXMu9FXjoFLS40rMU
 CsC4CxHyefOLU97sKFEyQABTE2o0ytHbCLF4PEpcoK5JMUbI39uRV9WyM9utrnYHXOo0Qxu15c7
 XT+Xt0/FpjHO2UjzFH2Vz4n72I7GfWmoHw5Hheh/eNgMm21wdK/+9olwPH0MuW8Q4+iWgcR5eXP
 9U/AQsn4AWlx9F/HUjYSSB2PEiSel3mqauordeUvhCUmXaDYusF0Ox2dZbakBymSgk/hOQ3sacN
 xRbBkIROTiAY5b3oiO4wdXcY/yHfu6hdRGuFIsV1Lhzw+gZToWqUVxjrE=
X-Google-Smtp-Source: AGHT+IH2ZCMij5u/HguG9ium9J7tXLPq23syhivrY//lJInzKCk8P5thzvwXA6OLMlk+1oHn1CEZAw==
X-Received: by 2002:a5d:5f54:0:b0:425:70cb:9ba8 with SMTP id
 ffacd0b85a97d-429a81b1f42mr1411013f8f.1.1761630674361; 
 Mon, 27 Oct 2025 22:51:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbb2bsm18327270f8f.13.2025.10.27.22.51.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:51:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/59] target/arm/hvf: Mention hvf_inject_interrupts() must
 run on vCPU thread
Date: Tue, 28 Oct 2025 06:41:48 +0100
Message-ID: <20251028054238.14949-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Since hvf_inject_interrupts() calls hv_vcpu_set_pending_interrupt(),
which must run on a vCPU, it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ee04943b0f8..0d8ff49ae15 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1664,6 +1664,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     return 1;
 }
 
+/* Must be called by the owning thread */
 static int hvf_inject_interrupts(CPUState *cpu)
 {
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_FIQ)) {
-- 
2.51.0


