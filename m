Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2484CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrfe-0006bz-Ae; Mon, 03 Nov 2025 05:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrfY-0006Ti-M1
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:20:13 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrfO-000402-C9
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:20:12 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47710acf715so20381515e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762165194; x=1762769994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zQ+kr7tsJFbwFHKOahptlya76rrqrFtmiQlsKMFVa0=;
 b=A7+mxddKlKXPw4YSn9omQShB6YxHmA8sPquPdDDPiZk0qiPzfhY56q1cMNLAX4AU0D
 nMuTmiogdqZPSTC+3L+wpuQh9ssVbYrd84ssqN4pZEL6x3mJ/AiypXPzr3i/LJJogtPx
 w4rsutNtwd6vde4i4uD66EPitzOAhUGdWVz6RlJIhPucw46eYJDhcDVL3eMXWkDR5THB
 slHJfTFK4LtE8xNbl/oDvs/s+M24+xPXeXMTmKb0Err3o5se/uqUCWJex8odTHy8TW54
 LPv0PENnAcul5eax9n4UIKLFNZpzXZYFgvgZ7GyDiozca7VNOJKwU15XjSss8XJTQ9x9
 EOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762165194; x=1762769994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zQ+kr7tsJFbwFHKOahptlya76rrqrFtmiQlsKMFVa0=;
 b=fWNbOuDQt0HeIlPGuzWlasAKkHelM8CKE4kWcGiQzUYnzNuY/wcB+aBsgBAW8Bh3Yd
 4kvpAdf8C70PuuX8Q0L/rFksQAKHG+hXY/Kbu8YC3vvyozfJaI3vsQtnpXALEjZTXGko
 zkgxYijUFvZ2UgdzCIl80yHfrk33djfQY7DLz197DjL4GjyjVC30EQg8w4ES3AnVjwi+
 VaztBbLJCd4KRTwZLWpX6gnv4BSGHjmq62vLwtdKPKmb8la233RpyOhXi5hur9oWnQSx
 iEWDO6j4MqvY0Qf9+o8JGTSYkyOdiC3U/V1WT27dpnB4BUBMf0hNjqr79/6k8UIMFzrM
 5qhg==
X-Gm-Message-State: AOJu0YxtNf5vY0wLNBciEuXcFuQpsa5884j1/j4DAkdyGDsPAZ1sF0PQ
 L32tMjPF06OCHGdsLA3YkTLBRpf2Mntm4idpB9WvAmgNt9Cee6S5f4mf1r3NUvfciBfD5ibkZ/9
 GD6gfu72ToaJU
X-Gm-Gg: ASbGnctVR8gz7DVBYk7pK1zUNFEHr6pMR4I/1T+TEpUUEGh8X9IqLPj3UwQRvgf8qgm
 QLTUBrHoNRJ3hjDv4b7WGSqjT7uFqQbZoHu0UctQB2/mBwbWOCtSK0GDCL8vGrGEtmW/teM6fp7
 nLsN6hl60mL5emXHxP1u3YDLq6hf94t05H8wo5jrIttG0QoQcnfKR0PUmQlnVNlvzPBAcL1Xehk
 iJUhINgos6sjHHgJSuvbG08oJFiKfTI20vlcpiiyEXD9eDEqHD2UG61vFFzUivic/i2UOK1/N7y
 +I9YHsgigKuywxXQwwon20rSTza49GqJFfnijnti12EzWTy579VRAJmY2aU20QT/kfMj1xe6YWw
 sdFAygjjVd1oQbkdV8VxDzPW+5ROPFjpUlWwyLUX9k58xBEE8Rtt+McIJXN5OKkfT74IXl3FxD/
 mMu3C1wFMLyn1J6UFqrUM1ZOPitdqThHrFq48x8HCULn0CLxN2elB+2aOVCbc=
X-Google-Smtp-Source: AGHT+IFM5G/bbzxpzPIwuFSkGk2FVHlqkJqBtmO8jLNiCL2XdqjT9lN9G9eZB3C/rrsWZjAWaTO7HQ==
X-Received: by 2002:a05:600c:3149:b0:477:942:7521 with SMTP id
 5b1f17b1804b1-477307e285dmr102838195e9.14.1762165193648; 
 Mon, 03 Nov 2025 02:19:53 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772fbc32d9sm86170835e9.1.2025.11.03.02.19.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:19:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 21/23] target/i386/hvf: Flush vCPU registers once before
 vcpu_exec() loop
Date: Mon,  3 Nov 2025 11:10:30 +0100
Message-ID: <20251103101034.59039-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/hvf/hvf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 5134f302c08..51b3d392879 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -731,6 +731,10 @@ void hvf_simulate_wrmsr(CPUState *cs)
 
 void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu)
 {
+    if (cpu->vcpu_dirty) {
+        hvf_arch_put_registers(cpu);
+        cpu->vcpu_dirty = false;
+    }
 }
 
 void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu)
@@ -990,11 +994,6 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     }
 
     do {
-        if (cpu->vcpu_dirty) {
-            hvf_arch_put_registers(cpu);
-            cpu->vcpu_dirty = false;
-        }
-
         if (hvf_inject_interrupts(cpu)) {
             return EXCP_INTERRUPT;
         }
-- 
2.51.0


