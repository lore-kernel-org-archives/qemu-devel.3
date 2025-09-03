Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F73BCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkPk-0008QS-Ul; Wed, 03 Sep 2025 06:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkPi-0008LC-3u
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:08:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkPg-0008Dg-CT
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:08:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b79ec2fbeso42995855e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894102; x=1757498902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WcDycBA98iC96XL5mALM8orqALEyJbh9hu7aJGRuIUw=;
 b=coBGjxyijVy/G5ySeyO0UoxxhDrD9tbRH3qg8q9laj/sEAC3/iI3TwmPteyimw5KhA
 4tYh7Y2lhL/4WBtTFIr76FkqZGW5dGoZZkvmpubFmoCIi+iXs9TFko9yCm7urtDycusc
 9Ug1o/TOBZb5jUfmxzeikf1G036vBou6QTM9RVFOQN5XeDtTJYlip2ZCvOYsxjGJ7psO
 dgRHRvoJnlj9YFaC15vulwxedPbxzY5UREGSWsDvymbQ6kiR343E0RWWrPNYqQ+YwYvD
 Rqj07R9DlibnVyavnw2uK+wh7uRnDE8T3VD4fgiJQ2IlFvQjHSq6yBdRUDFB5k6x/0Hx
 PFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894102; x=1757498902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WcDycBA98iC96XL5mALM8orqALEyJbh9hu7aJGRuIUw=;
 b=MSL1jddqBIW+VuvXpPxxt46GUR/21KBvHgOQ1z0Jyz03UX7oj1v9Yg4/B1CWs6JQ1+
 KgUyyQog9xJ2qI7z3eT1giP3Z7cxiFUp3QYOlfqEMvzNiHCDQSNfjeWlspDhfJwpZudB
 CaICTpW/VC4ubKODKRAmaO/bOdp08uohm9PL/vuxQDJ51yLrIcWA1CDX6KC9JIeBa/cI
 c8CdGIE3BoTUPPIiXo5OVF7cz17pFZObmQ5svcZSDkhjuQYx2p0oTZC7XKDKxVKgolRT
 c0bHT1PjmwB4ynRj5oaWWqVYVv/1Ixzdkxx99UNvfFdn4wLJ1VSMOG8skI5BKuPPUTFG
 xKbQ==
X-Gm-Message-State: AOJu0YzArA199j8kO33i6qZ8UHYR0s2u4BufrHa3x1bjiwNYCg0P5qmt
 +DkIMP5wTPHCKAMz1zkRg/lbiMlAEKDT8Aa5cZIeutZDTZBzfA+yuzn1v7X4+RBls3YryTDxc0P
 HFRjeq2A=
X-Gm-Gg: ASbGncvnppCS+SV8aaNrHTOE2AlfBQ5JRGT/+S9szw3tFuieyAC83UkK/nr02t+gwcI
 SGEo9ocClea0R8EIapgsA21CijhoqoD4JGR28wiADXPn0FM7qsrLkHsPp9lomWJTwpjXN8wXt59
 ob4cRKpdy59rJUjsrZaFptJD+PT4xHMc2HcYj21Imfn+Scp5uyS84FEvDXdqM3EEgjDWplNFlJi
 f27b6dEq9Nm95FEJvYfFjmy5SQ3me8tfXxicp1qmpTkIf7p6MXNHEHQdPVS8UbEfSaKmn0itbxj
 /2LkHXzwOgiR2KclFM25DGK6Gu4i85yUAErTAl5Dn0k4IcTMdG+YIy1VoBkpIqb/dEXzQsGw1H5
 ZzLpoaxD8hLMCHHBz98IN5SkVQf2EycQKoURF2Q1yk24mZx0WAtO9Y/QuuEMcuWKs0vFMSx/1PT
 Ki5dEl6w==
X-Google-Smtp-Source: AGHT+IGhtpuKzPtrGO8wqDqzfI4uI4n77KDn1AGnJ9MQg6iG9Ouc2B1r0+XLR6JZlmcG04oDChLirg==
X-Received: by 2002:a05:600c:1f1a:b0:456:1560:7c5f with SMTP id
 5b1f17b1804b1-45b8554f88fmr108256385e9.14.1756894101036; 
 Wed, 03 Sep 2025 03:08:21 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b87abc740sm168190995e9.7.2025.09.03.03.08.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:08:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 06/24] target/arm/hvf: Mention flush_cpu_state() must run on
 vCPU thread
Date: Wed,  3 Sep 2025 12:06:42 +0200
Message-ID: <20250903100702.16726-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 21002f419f5..58934953c4a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -814,6 +814,7 @@ int hvf_arch_put_registers(CPUState *cpu)
     return 0;
 }
 
+/* Must be called by the owning thread */
 static void flush_cpu_state(CPUState *cpu)
 {
     if (cpu->vcpu_dirty) {
-- 
2.51.0


