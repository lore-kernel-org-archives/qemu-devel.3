Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8EACD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf4v-0001GO-5Z; Tue, 02 Apr 2024 10:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4j-00012l-N5
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:25 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4g-00084b-0B
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:20 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3437d3db788so139206f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067915; x=1712672715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vawk+LSw2Z6p/aOFRJRkJdEE2smC/bsXUmQB9oTHxK0=;
 b=IKmcaPZOpO6Pf72rYlxUfVocw6OuKhGZKuUkn/srCt9qoyxKOZAAPdLLrlFUO5b8Sn
 ClF83dBPD/U3SPmQ+rHoN5Dgt8MQI6+tB/+wQCATCuIFHJUXpVnODJpeQGICO9okO682
 oRXRN1Mtcmp3daSg0LmskqmO/Qi68NDq32lmMa9wCFmxQhIw09qzUHyG3cfDrOWZo3bq
 c0H95ULCVo2TDvTJpTpTN+8I1meOuFmqMm9iyDr4GsX/lWhvqKxdDI8yjLvSLUxyZBm/
 1bSVkhw8QQr9f7zSUP6rMYgx5gxqHYVPri3MnSNOh7ma9Dse4GbCsUmgIT2/lhB/fceh
 TGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067915; x=1712672715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vawk+LSw2Z6p/aOFRJRkJdEE2smC/bsXUmQB9oTHxK0=;
 b=OvXiceU90Vq5MHGw0lyczexETI3jfpKzDT/prvZuFEEtl+cFG4DD6W32ULx2Xo2txC
 CaDbHJ+SsKlA154fPVgsrKoQJJdzj6T32S1wqdcMgs4qOoIEAs8/WzWoa180gfvW/I2J
 R+78v+DkLW92fcODSCKKZhfaUcM2bQYEIfhi6paFS8rzyD2MBXLsyba1W6wGpss3XIQe
 WrDkp4g+A2wAmQpKZCfJ4uYC0ZhLyG2mBdRvSJ3DdE7mLmjK+aZcsOmWQqMzZhVnqfVb
 mfhbe/OJiVF4Bqfy/8c1fZjd56yxwn0B0GaCzBUBtp+oO/tkmKlbV+pTonsQgjGhpiLi
 LWog==
X-Gm-Message-State: AOJu0YzWDrNAOT89e3c1kfzoBpvmtZdVMzYK4dfOa1YYrKLNeaDTru63
 Rp8ezyl0D/wCD6XPQB+5vdzKasAWGP/z4XR68eOhaVGY/0243ECKHTFIHY+kk63xjenjPYs1BqX
 Wn6g=
X-Google-Smtp-Source: AGHT+IFJHpszbjIqBF+yYRpgQYe5a7ZHUg4a7GJafo0cxhAwOkZcBvYmyclis5LF/Q+ckcpOj8ETmg==
X-Received: by 2002:adf:eed1:0:b0:33e:7865:cf67 with SMTP id
 a17-20020adfeed1000000b0033e7865cf67mr7659653wrp.55.1712067915477; 
 Tue, 02 Apr 2024 07:25:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a05600c4f0600b0041469869d11sm21168544wmq.47.2024.04.02.07.25.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:25:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PULL 06/15] accel/hvf: Un-inline hvf_arch_supports_guest_debug()
Date: Tue,  2 Apr 2024 16:24:21 +0200
Message-ID: <20240402142431.70700-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

See previous commit and commit 9de9fa5cf2 ("Avoid using inlined
functions with external linkage") for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240313184954.42513-3-philmd@linaro.org>
---
 target/arm/hvf/hvf.c  | 2 +-
 target/i386/hvf/hvf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index e5f0f60093..65a5601804 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2246,7 +2246,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
     hvf_arch_set_traps();
 }
 
-inline bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(void)
 {
     return true;
 }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 11ffdd4c69..1ed8ed5154 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -708,7 +708,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
 {
 }
 
-inline bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(void)
 {
     return false;
 }
-- 
2.41.0


