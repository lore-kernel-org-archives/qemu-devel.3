Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA68CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcYi-0007DD-G5; Tue, 28 Oct 2025 01:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcYe-0007CI-Fy
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:47:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcYc-0003SB-Dp
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:47:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso76757685e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630462; x=1762235262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXz77BrZW3QUmlVNh5gnW4lPNFdnFM/IGe1E/YtD1U0=;
 b=zJcjRh81SiLOpwZCmZXxdmYvPMIIEopd7bSxSw7LMtccoGSe7N6o5xC4Lz0NvqcQFq
 Y3B7iM0q2AF1mckMI3GKGmu9jyS8TnfBuSD3rM4N2CNuz8uemG3m1+C0HHkpXPAsWF+n
 mH0TkYVlREEZxp2WGtcg3MUl7jqO0vb8mSRLTs0N3ApNzs/xJEYtdD5Qx/tlYdrMEj0Y
 04mKX289VahitCEk6pW0rOdqKJaFJnIaJmJR3zW5Hc/BsEkTUpc3Ww98ji/tXlBnfLyP
 +CoUpjutR8UeZaycTIigy8Cy1XDqDkTMIF+oSwLVk7wbeTdmKGfEEqiEgKZezoeRhNK5
 4Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630462; x=1762235262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXz77BrZW3QUmlVNh5gnW4lPNFdnFM/IGe1E/YtD1U0=;
 b=J3GWSijk2IwQo6nr9nHKr1Cwt0Cth4DhCPUBPrQKg8HjF/0So0Bf3vvUF0niMMrVu0
 bhW6epCXrRTYM+t4gOVcU4eeAZ4sJHOxI1Oy3Dm4lGSowRNBlQnDGzgQoRp8e0s8iIOc
 42pHPnun/9saP8Oeesg9WHl0AKHp17uCdglnE4pl0VX90WZLlRXdQ8Gkbbl2Czyaa8Av
 nJMOZSjJaRXCPdUO4eoeBteaUL6LwGSnOQoG0oCGR0Ob6P6V3AF1eKIig4oIDAc1U2W5
 JWbwHwGsFHlAhlMOvNVPk3hfde9U6vOW6cvlDPHo1nF+VKDElj6N/3CrayeKdq+lfcDt
 t1qg==
X-Gm-Message-State: AOJu0YxIpVThH93Sjrb8MBbgdiQMBox0oIEx7QbgpeDM4+7QSaI8DXSg
 zKg43wjOBV/9NxJPojRqUpeiXRmOLcGAhvIQH9DCKY6ztMv/P0aU0A4RUt5aZbcPwu3kyt8TEwF
 Knzl8KeE=
X-Gm-Gg: ASbGncsQxbeRBrscJgw2IEnz2XAEeiF91Vuqi67hDtJou97bGhUvKr5LV6BpsXTQp6E
 +Ql5s5Oot1Avi33svZhUV1W2JtBCFtGG8RNq9n0YLz3wHwIwU+tDRb2hjgQzj+gd3nM0kw6bIfD
 2WdyGA1orxATQ3MGUIvejzysOHx2fDo5ohVrkKmJUHKphCUfbnxlH71yKVJAXsGCjOnukzUlISN
 Qb2ucke2uEcNxuEvIzTiwYAnnLgutZZdQRy0nzU8hM2T6c6hsMSSDe7YrKaji3AnYc/M/yqEsgO
 4+X4WoVvx+m9lJ9fJn1z5h1MYlNCFQKb5KowzIYioeE8eSAGid6RU3lzr7UZvNKqwJC/nfIdPkz
 ZBMXbVfc+9DEMazzD4qRfNYjDE2xSDLHv8Mkq+d0J02bfH+27t3WaPL4m2Ai8brvugYngwfLIWy
 xwYlbxV3EBY+KaZMgil+CUoh4tN3VSTZ2rHMzhoewCisnXcZ3kBfMUgV6aFvGbNMWulA==
X-Google-Smtp-Source: AGHT+IGVX3zZA4IzQqDYpwXv7QgpZpfuFH3XYWTpr/Oqb8bagoBaKLrIOjsUTxyztzmQAfiXWY5dhw==
X-Received: by 2002:a05:600c:3e8d:b0:475:dd89:ac7 with SMTP id
 5b1f17b1804b1-47717df7ef0mr17181165e9.1.1761630462306; 
 Mon, 27 Oct 2025 22:47:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd477d0esm169959915e9.0.2025.10.27.22.47.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:47:41 -0700 (PDT)
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
Subject: [PATCH v3 07/59] target/arm/hvf: Mention flush_cpu_state() must run
 on vCPU thread
Date: Tue, 28 Oct 2025 06:41:43 +0100
Message-ID: <20251028054238.14949-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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


