Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A35CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkPw-0000jj-G7; Wed, 03 Sep 2025 06:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkPu-0000dm-Rj
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:08:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkPt-0008Fy-99
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:08:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b7d87b90fso8274295e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894115; x=1757498915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KoGPe698wbL5728zFyk/gVxD2Onbdb37DNEf41ttDwM=;
 b=EPcfMr/tQhRmIEx4Ohn7g8EQCfZfJdJfB4kZUtpEk70yzSXguVMz7LblUy8toNv8rJ
 iRDyhasepTJhj9mxlj1foSfenH5pVYFYPIsDI4AJUgc+/vAuevXDK+SzgidscP6SSBfl
 TefUk9ushSi+cEtLzNq1K3745Qy4z6I6qcPxtNzrKqXKowrZ7E0IEqgmpO2zR1BVHBnU
 U7WU1u25/mLRZHwT9AubzIMQtdU27YXouoR3KjIXQf84ChxT3eHdrn2MidVqKRtufzru
 FKprQmF435NyreG5xk1Ph5iNFF+qMtP4cwgLjtY4uXZDIPhQp+8dI6AqenNeIntwREjq
 4wcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894115; x=1757498915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KoGPe698wbL5728zFyk/gVxD2Onbdb37DNEf41ttDwM=;
 b=YFccF+zzp0IvJE12QOHguMfjVWUVlUxU+nLURqpnsOvyWmEMiWRK9ZMuSnmsf86gfo
 iTxb/7qwZiO5CP90moYlUCQHZU0EyWjFfMQ1qroa06+yFMn3WIv8h81Ffgm2xJNAL3kW
 aELCMRCCUv81BqpOzwTImC7A7hE41oEJxXn1LDax34eXD0Yk272LnMvBvDQwdLVaSkoT
 ugPrOOPHUCrKNcFckJx9TPwKsYodnlClpGAjj18foL8WoyxM8O7oIg5bRM7v29je1aEn
 rouXDRNl7oXww6tqMkfPXWH5fIrEBkkMAUiUDUDa1kUtxtV7QYp2SpFYj2VtanL7QQVk
 s7DQ==
X-Gm-Message-State: AOJu0Yw2bWeMidgCSYRwhcxatIy5nsUfl7IzezWoFzPdIb4qyaOaSWCf
 dcPaYgIWq3TkOEldYT1vqZZKvKgLXdkTqXMGvALOFgTcmo5QmSC9t8nJel7bFHNe1pEOqtyK6Bh
 dkdQCjIdHhw==
X-Gm-Gg: ASbGncvfmauxIR/4+k4X2qxDTyyAXGHy4p71B9EQJ5rLZF1tgs3YNv//iTDJqeoJtBh
 Nq7LwcPj7tQiJuREM6VKN/aJMHoMQrENlcD9iB+Xc0vBQyqgnmBfUIknl9aOQdiCGBJMmof7qUe
 cxyGE1Ys7C/+b/rw5SeLWoFzVUC+Ioaqq4ApKCl0BOaVuMovT8RTnZRNHglGHDGB6uQijftAG5X
 oxWNtOZ+KCkWX5XisgarOdrRCA/leq8B2Sd+NOZ4GYh5TQvZnohuEAI0Ok2wHALuZv6EnsiRy0F
 4bDQF/mqOpTYhHHx3E23ex1s8d2R3LmyDIK7D0xr4mM6o7/3R6kEIXR5wOGewBZ16K8vhzl2gTr
 FoSOKLFEzOCcjSENEiwxE2um/wPf7I0OEYlNlUR3HTXwqGPsuG9lTIM1PVFZkGaKckMRm0TRaIt
 4vRsaOZqwJQFtmI6Cy
X-Google-Smtp-Source: AGHT+IHikBdHwMbExZmGuTsIF9ghl6WPRpyo1sb50H3zEA5DtcAYH+Tee4ZUwUOgN2zm9tff99qG1A==
X-Received: by 2002:a05:600c:a30c:b0:459:e002:8b1e with SMTP id
 5b1f17b1804b1-45b8c05a036mr76784345e9.13.1756894114782; 
 Wed, 03 Sep 2025 03:08:34 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d690f2edf1sm12372871f8f.16.2025.09.03.03.08.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:08:34 -0700 (PDT)
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
Subject: [PATCH 08/24] target/arm/hvf: Mention hvf_wfi() must run on vCPU
 thread
Date: Wed,  3 Sep 2025 12:06:44 +0200
Message-ID: <20250903100702.16726-9-philmd@linaro.org>
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

Since hvf_wfi() calls hv_vcpu_get_sys_reg(), which
must run on a vCPU, it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d87a41bcc53..05fc591b523 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1836,6 +1836,7 @@ static void hvf_wait_for_ipi(CPUState *cpu, struct timespec *ts)
     bql_lock();
 }
 
+/* Must be called by the owning thread */
 static void hvf_wfi(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
-- 
2.51.0


