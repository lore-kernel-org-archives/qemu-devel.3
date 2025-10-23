Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A8DCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtnN-0007fY-W8; Thu, 23 Oct 2025 07:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtmq-0006HH-KO
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtmo-00023H-Qy
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-475c1f433d8so5914545e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220035; x=1761824835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXz77BrZW3QUmlVNh5gnW4lPNFdnFM/IGe1E/YtD1U0=;
 b=AP4s2tyk888yIHsq5rxJaiHBNivDELc8peSJie6uyHaAHJCvnD1//4lwfg0GdeQ3FZ
 2Xe89JvaYBlSZCAqFuV2evtfcXFY/uObrgHSFfoM421ZumxBuDFVO3LGtQvoUvpOWrT2
 8apisztDBH2CosZLYhirCO2hEfQwzJQuh7JVUgyu+3X+kSAtlH3AEjqBZ4kjHAgQMrGk
 jM9OKQ9B0mgYoL2IB2ANYflRt13fETJ0CUSXyoVEuMABEPVtVmOXt+qyNSrE5PW36EN4
 pdhRjfo7NrWvkg+v9LMIimGTHVMC443QlH/3BxJiZQ4dIdjiSiuJfW+9TSqPlL2l41JS
 4yYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220035; x=1761824835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXz77BrZW3QUmlVNh5gnW4lPNFdnFM/IGe1E/YtD1U0=;
 b=bC8QF9TlcNNqHXPTCMzE0DlYTDuRNnbErroi6uBKkszC5Ky5xCCZs+TgLbsrFhBQar
 p1FNs3TLoWKVeAcR6klPSbgITRxRXf5O1gPZ/ZaB8DJBeGP7eBwpwAsStFbPHq6f3P3D
 nv8d4wM55qIV9hQKQ2qPLkjpy4nVKFeE0J5/DDV0tNEI305XtPIw5XoKgpThJrJEbL/i
 U2GRWUDqZpkFO7Ii3rSxDzw3j93U7KcEOo+ruolT6EDxHCUGFNNibcjAumPh7F1TK0M2
 RE61zfMBFeJv+pP96EdxkoWM2+om6ZLR2h+iftZeIVLreI9+mSTTyV0n/wRz+aZsHG66
 Ykdg==
X-Gm-Message-State: AOJu0Yx98vEPl/pnmeEocu2To4I7n/Pl/QVenDCtSVhjewpGj/iWZVYi
 Wbm96va0PftHwbvzRImAV+vwEB1LgA5i7jJGfdQGDIhIIiI5CEjZ3kWvYZ85gzzdyEXETOUjP0H
 3xV6iwDo=
X-Gm-Gg: ASbGncv5tFl+WUaENIlBZQ3j4JZmIsQzABQC+Gtb32H2iqS2iTXG2/jBJItene443PR
 kBCCjr54e0L/4m1kG6SOGX75pLWBu95wU0OFIwY0ObuE/gOIjM45dCkx7p+jkpDpCHr5NLDhXO/
 rwgA7+HWMVjsRk8dCH7tax4VPANVzZIQVx0I8fwSqJlt4CPtzpDR0UwzTifvcJpYPZ6H0xVNhG0
 Nd97PKklY08MUNCt/evQ4PVBi3VYMXxO9HTtvPT/ufS/1YgMrecG49F0nAfg9yDO0O6P1n2JByD
 u0fCQj/ykTeOGcw0RtoS5Wl5vCBmObfoKEwIyR1V7ueBnFM4Rogp4qDIRG6+odenqUQBxQTBwKF
 pou42kn03T7ZkbUNDyKWJ75ztLgzIV9NYt+GWj5aPqdL+2Aoqlbk+Oy07HdYVhPrd+9EGfhP16W
 jRcol+Yq5pXFnl3tqaFByYLUfpanxN2r32L8AY58mUD3zpuhp5L312NhTv+0rR5+VQKJi//6A=
X-Google-Smtp-Source: AGHT+IG40mtVqCovXd+9LEpjM/bYQFuHSQCHhYNWE4+XKKPR2r/SITrZ2eIfuna2/wOrb33dtGCIdQ==
X-Received: by 2002:a05:600c:1396:b0:46c:adf8:c845 with SMTP id
 5b1f17b1804b1-471178aba5bmr160769465e9.16.1761220035456; 
 Thu, 23 Oct 2025 04:47:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428e9b2sm93063075e9.5.2025.10.23.04.47.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:47:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Collingbourne <pcc@google.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 07/58] target/arm/hvf: Mention flush_cpu_state() must run
 on vCPU thread
Date: Thu, 23 Oct 2025 13:45:44 +0200
Message-ID: <20251023114638.5667-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Since flush_cpu_state() calls hvf_arch_put_registers(),
which must run on a vCPU, it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f0a0e5d1a75..fdf8df09d4b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -689,6 +689,7 @@ int hvf_arch_put_registers(CPUState *cpu)
     return 0;
 }
 
+/* Must be called by the owning thread */
 static void flush_cpu_state(CPUState *cpu)
 {
     if (cpu->vcpu_dirty) {
-- 
2.51.0


