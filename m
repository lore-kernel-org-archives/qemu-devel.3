Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC88CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuXZ-00022i-RR; Thu, 23 Oct 2025 08:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBuUc-0005fS-JV
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:32:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBuUZ-0008SL-Ar
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:32:33 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso5980285e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761222748; x=1761827548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2a4PoXZUReoA7VfVNmy1fiLzr59C5J9k1wUFYONVrhA=;
 b=kPJiKj2cbJKGdhb/RU9bLUahmVkd9PRuC9zqRcIEOoAUS5ElVG+XIY3+RVzLgBC5kv
 DUB8JaKRZew3sk2PVJsiage8DfBcEDd+lE9PMUzxMI7RwZlKasw8CiWm5dt+9JtshL8R
 yVb7jQItet0oWcQ+x2ERm9vunnrFxGa1F674HkCpoVEEy/V1apwAkatKECVUZdiij4sG
 3nIFt9s+Xp5W9aS/qFSxEz1TCDMUPgK/3WL3qu3uf+SAZmpYrGoWUXRGFQs1zvFZzdec
 SiXt1qvbApTsSuqHFXSAOApnLtM8ZyH1NdSfWUX3Gef7Mk0CW0SOvq3sEKHC/Eg1I0Vn
 LJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761222748; x=1761827548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2a4PoXZUReoA7VfVNmy1fiLzr59C5J9k1wUFYONVrhA=;
 b=VetM4yz3WeG3mKbeHu/PJ5ijYcYdM+zR50pmUWQC/vU2P+L+XhK5HjQDcZAsKgqjnd
 U6bTNQFcEGb9DxEHZzcG9JpuOWAfN9Wr8/vG+QryODPN3qPQ79OzmlLUDup5C6Y1bygT
 WYulUeBLsrd+DoZGbwyV9XUiJ7HcBonDv9SSLOL94qm+1Fshh+cs5yKu6lb+YIHH+ruP
 e8tbSUkUYioXXheO+Rx6H0DttNIn6Hgo4XKJeyEzj7g7kLnW4J4JsrOMN/TOWo9SirxW
 zj+6GYzH5uXjqxEYnvMVquOvrjdjHJoeTeqwg6uSYGQBp4gDxUYVciJw5j4lGr4MYtEf
 RDlg==
X-Gm-Message-State: AOJu0Yy/1Mk6B7dpwjbFpOHJRSTDCWa5AmYBHQfnycG07uoxy+xxn2z1
 xAkI9+Gfc7PmUIfpSuPys6Gvyg4JCvS0geZXaXlbWinxMPk35GPMmXFVDS0XDzwCHShboN1Qa5/
 o/kzUn68=
X-Gm-Gg: ASbGncuvKa+ro9GZZZzsftjKPhXXAme7Jghmf2PJiR9mniY93QdwafRQhAf9PH/D3lu
 V5wbEzb3JwSpjfocMArQynowP8XUbJbhzmVj3K4TZHO0cmBnUfIvpbgubaI+zr28PbquVpFBajw
 P043XfsoCnAhYAEfIe3OF7BwF+6UPhCDb5Emf34k0bMTUfTPTFJaNW+t4eWrbBqrLyal3I22GQm
 vgdh8OIoBGkvIfHc3vv71cUUBZiNHb084dEWezfk+OQFl/QS0RDdPHvLpgvMmqBE+bxZ6Q3NnBt
 iDl6HwFh/crNmsxKCF0VfMrelCpKjSvCJwwbbvYVDiRfNTXbxXsoplCHeh7LL8asXGswg3I3bV0
 cAJC+sg3/6+Mz+8w1asawD3CpOGCcBTULzoSvxQrhr4v9PUu6Auh3FcZW50nApd8/7cfkPr5b5j
 WYGudqKWWYfdRfhbn6jGANuNLMuSfPlTFodNpeZui/0DUOERBw6hqBUGJwBx5r
X-Google-Smtp-Source: AGHT+IHXSw/fevYz6MyC72SPBobc67WK2XNzTHBsMH/1mqhupLtvi+rVRmQeKXVOKH10Ct5cjU3tmQ==
X-Received: by 2002:a05:600c:8b66:b0:46f:a995:55f8 with SMTP id
 5b1f17b1804b1-475c6f5df70mr37661025e9.13.1761222747787; 
 Thu, 23 Oct 2025 05:32:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496d4b923sm56754855e9.14.2025.10.23.05.32.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 05:32:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 58/58] target/arm: Only allow disabling NEON when using TCG
Date: Thu, 23 Oct 2025 14:31:42 +0200
Message-ID: <20251023123142.8062-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Only allow disabling NEON when using TCG.

This avoids confusing user experience:

  $ qemu-system-aarch64 -M virt -accel hvf \
                        -cpu host,neon=off,vfp=off,vfp-d32=off
  qemu-system-aarch64: AArch64 CPUs must have both VFP and Neon or neither

  $ qemu-system-aarch64 -M virt -accel hvf \
                        -cpu host,neon=off,vfp=off,vfp-d32=off
  qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither

  $ qemu-system-aarch64 -M virt -accel hvf \
                        -cpu host,neon=off,vfp=off,vfp-d32=off
  qemu-system-aarch64: can't apply global host-arm-cpu.vfp-d32=off: Property 'host-arm-cpu.vfp-d32' not found

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index bfd3b57e8a8..9343c6093b9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1457,7 +1457,7 @@ static void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
         cpu->has_neon = true;
-        if (!kvm_enabled()) {
+        if (tcg_enabled() || qtest_enabled()) {
             qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_property);
         }
     }
-- 
2.51.0


