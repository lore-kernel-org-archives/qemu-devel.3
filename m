Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD58CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcaj-0000lV-IQ; Tue, 28 Oct 2025 01:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcah-0000fs-UO
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:49:55 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcae-0003oR-Lp
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:49:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-429a0d1c31aso1065226f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630590; x=1762235390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Jp6xdYt7Qm+0J/pdgQITMBLjBSEIftoO6mxQrB4mn0=;
 b=AvDxXoj8Y7QsNS+0FarH3Ngzo9yIbsrbHotWdFQ4aWmFVT7XncQa9Ni8m9hyzDXawi
 vxIdCFqBx0UoIbcNxqrWwGeLZWIDIsz5ErJ2z6w3e28H3i+/7vp4YdMptLE7FfYI2S/j
 uDZRzL61DzoZtnsRG84CO/7wnIo0y05IPRaCiXKL4eh4Mpu3BhF9AvuGY773afeQJ785
 Xi6psoJfST8TzZSBoe87RtN/ks9uDCIuCpIkrUsr/wMLXxlUnh1iWHP0URaJFm1IxTu+
 cBmkQRiEjj60PYV0PTnBdflxhk4mhZl53D4DZC9nvZ1zcgXpDg7l3BVp2O4/YhXp8z2T
 1WOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630590; x=1762235390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Jp6xdYt7Qm+0J/pdgQITMBLjBSEIftoO6mxQrB4mn0=;
 b=jQ5XTiJiez+qTBs/Iu7+pb2GhNlqy6sknMva2ttfxzcXQYV6kcT9EKlEL4B4V0+Iuu
 YyuQCIj3blqVgnuyyEkkJr+x9wd35+ECdKlSGDheLSLx29kJ0pRGx3HaeJHQeP+aPxmC
 QrbFzXI9fI5sX6xX96v8/7j1SqkocX9nf+a+1cBUGhfiRUpF94AqaPzhv77iHZYu4NJ/
 +r7Smp6artK5SIOdWn9m9hOoxJ7Rh/cITd6n6JNLIBTgJhIqns9V5VkwXosWNFKeyTD0
 SijcENqbD02Poy7ZTWfIWnz4BLauLoiIwh+8P8MNbx+DuPojoge73UpTM7jrFwFlK+VS
 i+JA==
X-Gm-Message-State: AOJu0YzD9G+Frog8f3MhDpF8AUMp0vF4WRd3ryWoC342QcCG/N4oiWOH
 8STzeOlp0fQQYdPHLPiTcydlu+B9uW7WKW9Qpvzy1LX1mkG/nnqXxm7jsiWHEsNygAocp6bRsjq
 Y6q1cJf8=
X-Gm-Gg: ASbGncs+poKoKfmlP7BNX0Y0F6LVuqR2jBjS2oqf/xVMsvdex6CI+nMXAzt1U1CzAP8
 GDnhC9moWFQ4xdkwAPLriOY1JIoYAUdeD2gqNNSAT7uLg6ZMmza81rgahRMe5ufWBp8IcpxSiHu
 JpfU4R1ZpvWDtDUmKamVHZT2/8xwOa80xuwnxaRU4u9/qGAs4aDHxvDqZGMN9dWrK0yi9KCFO5n
 Vj0tIr+Djs/FgeSm2zqQ/hmJ1mp+uRkYUpk8zUH78inkCdwW+MSIFDMlVGYQK3V3wfsOTKzVFqw
 QAVRN2OTG9synKIG/v+C8zc5w6KyRVBEieDbmsdvguwQsIRJNsqw/RGWEKcP4dLG9iqpOTTz6bk
 nLMIQL7JqJjvq2ZnzHcT3VZ87ce0iYpZ9QARwqPK7MzenFoDKhrSDNpQ4xwVYuGvYdE3rNJg5sw
 Zn3yGTlVhQh9sv1wBcwiFTol1plvPlVNY/1SzBy4Fvx0XIzEVGnLD9ubY=
X-Google-Smtp-Source: AGHT+IEU20PyYt+mTWr/WoR3K9FU/uUyz2i4zBcQyRDIjhExevt4g1PL7USbQzRHZ/Jtm/24YzR3sQ==
X-Received: by 2002:a05:6000:1a8d:b0:426:fb63:c01f with SMTP id
 ffacd0b85a97d-429a81f1f4cmr1599784f8f.29.1761630589664; 
 Mon, 27 Oct 2025 22:49:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db80fsm17775784f8f.31.2025.10.27.22.49.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:49:49 -0700 (PDT)
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
Subject: [PATCH v3 10/59] target/arm/hvf: Mention hvf_arch_set_traps() must
 run on vCPU thread
Date: Tue, 28 Oct 2025 06:41:46 +0100
Message-ID: <20251028054238.14949-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Since hvf_arch_set_traps() calls hv_vcpu_set_trap_debug_exceptions()
and hv_vcpu_set_trap_debug_reg_accesses(), which must run on a vCPU,
it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bfccf5e9a2a..ee04943b0f8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2192,6 +2192,7 @@ static inline bool hvf_arm_hw_debug_active(CPUState *cpu)
     return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
 }
 
+/* Must be called by the owning thread */
 static void hvf_arch_set_traps(CPUState *cpu)
 {
     bool should_enable_traps = false;
-- 
2.51.0


