Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43188C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNq2-0007uy-GE; Thu, 03 Jul 2025 13:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpg-0007bq-Pc
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpe-0000xh-UW
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-453608ed113so1118925e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564083; x=1752168883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOj2l0QjwiOWVtDmZos93I73sy6okOj775eGXYWLug4=;
 b=XyP4NvrA/eFtLPquR0AUqRBhtdTRMqDh6uiuAZbZfTOHEO0dVmyvOvdbmdSvCuaGAC
 JKQjNHR4F1oHl4xoJd2bHbabajcHUHZxK1kdPJLVojrNRrznj7SCc8ZceX1uCCJFWXqc
 XR0vGVwJyVo3q+uGpdzAV8s3vpo8q0d+7byVPHDDMfKfY6qwZGzoZJG3yp1OifP2KnGy
 Yk2szSA1mhTYCgO7STfWgNvqISSBftSm7BQzJmFwlefasVp+AKRjXz5NrA0qFHbTlVqQ
 Ocq0NEMHd5b6L1rUriKtanxxOdmaM4mLIhyYhTcX93hmM2pYwDUyG2/PaZOSvCGkI3Bl
 WsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564083; x=1752168883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOj2l0QjwiOWVtDmZos93I73sy6okOj775eGXYWLug4=;
 b=wc3PL2Pg5GBnI9Wo4qg/qf4dyP1nfN82kSh4EUOlwzQoZ3OZe2oOKlhIhRmHz2umys
 xJAKkDjVjCgyFWnvUxYSr/eX5+5YncP2waNAvnEDqDi61vEkmrzYWDo32fLRKaxI13mu
 ixT6O369CUB8tu7qf7hpp3tfTKbSnS1itTjdunOOic012ZaGBNji/Pex9kH+B3dFYSun
 aQyVGY6ky5Oa+q1osB8tHFHIBN4DJp1US/8kxoCnJRhQeXqywyiP2/SSLu9nbrzGpDsM
 F7MQADfC+o2d1t4aiCe/u6THxsJgvB9h0voLUM9zO7F/OxAz91AQ8x3QBdpslHEvXkLF
 +v8w==
X-Gm-Message-State: AOJu0Yy3B6R/7FCqDYyk+J5JiFH5CZEM16KkFvIngyhed78FoPWa1rl3
 4QyxK193mE6Zx/5fEIwadAuutUip43/kmnDUDj7d7EAIajX98+jQcn7gMUsb+OW3PxSdt3caxWj
 SKOLaxuA=
X-Gm-Gg: ASbGnctkz4b27O4cywnkKIFaKzO8FTHX/frZdv0/XwekqSApZnXMLxtr79/hGocpSIh
 V/gpZ4xgfoYmaxi5fnY1AaqcB4QFgVhkbn0FQLsi1MoY5e8DWg7Fv5Hxz2cxmqSaBjiYyHW1iZc
 F/WOTZkpp0a+GRz1tdwDrufwgo0QzIXOXVrdaVDjrSLS5bnbMaaGUgYQhTbtCiRbN3BTgH7lAd3
 0XIS8MIX5k1hBrNoXU6ekgkl99kMDY+Id/jPgQ4k+rICMlZTJ72uW8vLxHckSxM7NnNVpkcS5Uh
 ogWwxdoYLc1Yuy3UCDf8O70+T98OSV7dANr09GqPfX1VAkMnwJ9UwrgxJEujCaivfgixtEHC+kw
 tqK4SkZ6CcYGJle36MFuft8SoZL0ogyTwzGjV
X-Google-Smtp-Source: AGHT+IEf7t3XY9WG5MiyINoO7fyv1zs6ACiM9J1a/TjKhFcJOEWEm+sjYOgNuSXDyqWbySjiSaOs1w==
X-Received: by 2002:a05:600c:1c9b:b0:453:5c30:a2c2 with SMTP id
 5b1f17b1804b1-454ae6124a8mr32945485e9.8.1751564082777; 
 Thu, 03 Jul 2025 10:34:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225afefsm311104f8f.82.2025.07.03.10.34.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:34:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v6 21/39] accel/kvm: Remove kvm_cpu_synchronize_state() stub
Date: Thu,  3 Jul 2025 19:32:27 +0200
Message-ID: <20250703173248.44995-22-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
to accel/kvm") the kvm_cpu_synchronize_state() stub is not
necessary.

Fixes: e0715f6abce ("kvm: remove kvm specific functions from global includes")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/kvm-stub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index b9b4427c919..68cd33ba973 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -29,10 +29,6 @@ void kvm_flush_coalesced_mmio_buffer(void)
 {
 }
 
-void kvm_cpu_synchronize_state(CPUState *cpu)
-{
-}
-
 bool kvm_has_sync_mmu(void)
 {
     return false;
-- 
2.49.0


