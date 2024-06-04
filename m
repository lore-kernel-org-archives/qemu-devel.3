Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8CBC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQv9-0007yR-Ob; Tue, 04 Jun 2024 05:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQv5-0007uV-Tj
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:32 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQv4-00028r-B2
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:31 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52b87e8ba1eso5503464e87.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495048; x=1718099848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSBLM04d3DAbKCspvBjFgiIMn9c2P954kLTi2eYOo9c=;
 b=whjKlISRZm2GG4dGvOyT55289SeEHgC33ztpy60ELy46mx6CmA/pZ42aEXAZXZhC4t
 e0wpb9pSku6GWKMo3CLtES95Lscs1DrIxTiXznQMoASnuKAL+MsMn6w2L8sqQKBD7xpX
 dTuxax3Xoly289P/KK3yReko0xwZH8SdTJHsPjHmZfvWxqp8gtVffLYIa0qLa2SGkOsv
 cIbUW9TpVpExcgOv5oNDarXGYlr3VciHfmzZoWJlW1iIog6hzTwMMO5ZYKTAy32bwTWq
 yC0H39fvbOA8PpBSDi2RvIgO32dKQnQKkrWV1sBi9wX7KaZYJCjhRhac9f11cFpoY+ds
 sPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495048; x=1718099848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSBLM04d3DAbKCspvBjFgiIMn9c2P954kLTi2eYOo9c=;
 b=Kw4qq5h4+ufuqDd6Y2B6ynDPUOglw4i7tupyq3q6WzL7/Jh9d1nBPmLTJe5+u8On7x
 gEBa1sfqkSXbJ63Gj/k3KLxgSD66eEMA1ECkPeHpTWK+rMto2AFJ6tN/YyLWkpekOHaA
 peFsGPbySePp8RPdX/fkJ9gAZpe5AAN8zzqpbBMY69v3I/gLAIRcFRtSYePRxBqSQN3A
 f6EOF1QZf2DRxtFFJMnSarM8exltQDh4RTqA1rblBfAnDbq0TZR4thmLYvEx1y3A8b1o
 29E6DIYcuUOWJAVRzYXVDMewsTGY+BOZhwCI78r6pvpM2jKtPQdbtOOSnaQr4gLBsBZ+
 P5Rg==
X-Gm-Message-State: AOJu0YxEIGe3h3BXiFiTOXsfALcDhtBN7EaEWwxv4qFG91WjmenPQB1u
 IqWIBfB90lqGlSCti2Ftup8JO7jjNCxNaL83JP9P9pa4ufpsZlteEXc5+mm25l/6DXNXDqc2B24
 r
X-Google-Smtp-Source: AGHT+IGV42mO2QBgoA/NiPQiATIP+vXmcJDIo/PhKYV1G+1U4VC/MaC96g5jPKuFp5AwdHxUMEOxNA==
X-Received: by 2002:a05:6512:785:b0:52b:8612:edd3 with SMTP id
 2adb3069b0e04-52b8958aeaemr8764573e87.30.1717495048129; 
 Tue, 04 Jun 2024 02:57:28 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b838acdsm149376765e9.4.2024.06.04.02.57.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:57:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/32] accel/kvm: Fix two lines with hard-coded tabs
Date: Tue,  4 Jun 2024 11:55:50 +0200
Message-ID: <20240604095609.12285-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In kvm-all.c, two lines have been accidentally indented with
hard-coded tabs rather than spaces. Normalise to match the rest
of the file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240531170952.505323-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c0be9f5eed..009b49de44 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2893,7 +2893,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
             !memory_region_is_ram_device(mr) &&
             !memory_region_is_rom(mr) &&
             !memory_region_is_romd(mr)) {
-		    ret = 0;
+            ret = 0;
         } else {
             error_report("Convert non guest_memfd backed memory region "
                         "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
@@ -2964,7 +2964,7 @@ int kvm_cpu_exec(CPUState *cpu)
 
         kvm_arch_pre_run(cpu, run);
         if (qatomic_read(&cpu->exit_request)) {
-	    trace_kvm_interrupt_exit_request();
+            trace_kvm_interrupt_exit_request();
             /*
              * KVM requires us to reenter the kernel after IO exits to complete
              * instruction emulation. This self-signal will ensure that we
-- 
2.41.0


