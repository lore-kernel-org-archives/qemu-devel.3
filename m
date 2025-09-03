Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0725CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkRG-0005rX-MF; Wed, 03 Sep 2025 06:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkRD-0005fc-5g
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:59 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkRB-0008VY-Co
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3c46686d1e6so4317890f8f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894195; x=1757498995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCaAK1U7AfzQjqZldPBE5RveEpShlRIboizZxhe2VkY=;
 b=h0bklGCQv/xiIteVzE4B+ytaBKY5ziCFDSVtfVemH5FW+XW9BOhZ876QYVxyMtlw9S
 ujNVpDWFta2NiCtThwUk6584X2OAcgxD96qox4Z9GXHsf91dheONKvJZpAmU/apd6gSx
 1xiFwX97SGaLGPwFTv+yd3LWcbUD2vaNsl2u91z/64i0aTAYQhKScvqmjza37A5pon9+
 85fxmtrQgR5LdikhmekRjBfMLyexAv0uWR4pIROJOW0gdp8bPILfwla4w9CPOmWlVv5U
 Q/4BPpD0MQXdLwuuHLJvD2H4APfD9WoDLQ2z1Z+7hew+wl5opL40R27M64iY07Ut/fzF
 2zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894195; x=1757498995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCaAK1U7AfzQjqZldPBE5RveEpShlRIboizZxhe2VkY=;
 b=YiAFL1mDuVmMn/Cyry6VMAca0W9SpWhmUmhkEJkIQ/FrJvIhwvdddhOIHsnXe0TNKa
 Zer90q2xzjWNJoat043plUEpo4I0j5DEGd3A6ayaJJRxDoWRyCxmGjBi6+3L5mfHygQ5
 xmhxnhZ5MOB5dBKAUuDwGgAh+9zHr41L0qZxGrM1td6uFFd1go5H6SBXOsfKs48+y683
 /da0OsPLJ0oZ9+5iIG7exBmrIyMQctQvtCLSKATeq/h6FnoOkBrPV97VwjaNnsnahURu
 VYuQwLCG1b2hmYUSzPZ2ibYF85gmRUQqVRzqXi9usjlCTIfhbrFzzIw/UPKKBIGqgjde
 F8Hw==
X-Gm-Message-State: AOJu0YxyJsqAKRrL2wxGSiUcebxw13C8Jeme1aWCCTmVKqDoONRNQeAJ
 AOY8FUSkBJ8i0xb2jVXII3MTzE2HK77Rpl02n+p7Nq+qt/gNhRFcTnRUs13ceIV2yc2/xJ+1PZJ
 qthKyOKUtsQ==
X-Gm-Gg: ASbGncvr3yXiLDYhDOSWbSv+tnwuwJTuTJaq3+CCnDx4KBl2j2saDfv6qXxK8Fsq+1h
 OiOV5CrNGmIzbfD5kPRmeXR9308irpqJkRQwrRAA5yDOD1JwWMaR4hwU9LmRJEz1Vso62xjd8Br
 aOob1GJOkGFINmld8nUEhh+FdfXUIewGxUneg1WQwYhEbo949PGYFWd4uFzaNhKi5sumJEB63Gl
 HeseEEhh27wYL1VZ/HgPXKdQaB1RJVOXw8unUDu3dh+XmDxHOkk7ODP2pgPXCZigy472QGwGflE
 QdxbslLYKZ4noaWFq1MuTF2ML6+pMsm1wJJQWM4OikrGZvyOYCnXtFHTyReYSBWasqlCq/KbEdQ
 GHZTM9r54X4d1wiBIq56DTkMprchVexaikrlxYmvqAdcQRKWjlf8Wl53hHlfgfd5dfzAF/ospM0
 O97KnHsK2MmmPw/N+F
X-Google-Smtp-Source: AGHT+IGU8BAg7tq431LWl+B0LEsfKkDkREYGOYoLoyFgBZgv+sRl6kcDrBAKCXXTt4l3HFRmI9CCoA==
X-Received: by 2002:a05:6000:40ce:b0:3d5:f5ef:3bb with SMTP id
 ffacd0b85a97d-3d5f5ef0766mr8304072f8f.11.1756894195377; 
 Wed, 03 Sep 2025 03:09:55 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45cb687fe4esm11930835e9.23.2025.09.03.03.09.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:09:54 -0700 (PDT)
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
Subject: [PATCH 20/24] accel/hvf: Guard hv_vcpu_run() between
 cpu_exec_start/end() calls
Date: Wed,  3 Sep 2025 12:06:56 +0200
Message-ID: <20250903100702.16726-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
---
 target/arm/hvf/hvf.c  | 2 ++
 target/i386/hvf/hvf.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b60efdc1769..40ec930d244 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2154,7 +2154,9 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         flush_cpu_state(cpu);
 
         bql_unlock();
+        cpu_exec_start(cpu);
         r = hv_vcpu_run(cpu->accel->fd);
+        cpu_exec_end(cpu);
         bql_lock();
         switch (r) {
         case HV_SUCCESS:
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 73c50175048..cb4af70e91d 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -749,9 +749,13 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
             return EXCP_HLT;
         }
 
+        cpu_exec_start(cpu);
+
         hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
         assert_hvf_ok(r);
 
+        cpu_exec_end(cpu);
+
         /* handle VMEXIT */
         uint64_t exit_reason = rvmcs(cpu->accel->fd, VMCS_EXIT_REASON);
         uint64_t exit_qual = rvmcs(cpu->accel->fd, VMCS_EXIT_QUALIFICATION);
-- 
2.51.0


