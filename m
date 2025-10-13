Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61719CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O49-00069f-Mp; Mon, 13 Oct 2025 15:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O41-0005oP-7b
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O3y-0001qQ-BP
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:32 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-426edfffc66so56034f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383107; x=1760987907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u/vJ+qKrlctD4eDXUGD4jfZ1DrLRP2Xsc63+XfRRrpM=;
 b=eq2wVrwMrxeKEvH01kyWloIPnbC0e/HvwWuRU4lgfh482p90m8LoMJ4d/k66Tt+qRp
 OumqSrm7vBIAJBPgFuHBEEOkrp51WLkw29J3ydNzpuO36/smji/KNMolLMRMNyWhQ5V6
 fQuGOICUvEZ248CkBQkXIzx33DAqf+HlyzALwOw7R2ny+jXTr9y/2woD7wcrHsGdFRRa
 IePV18OVsLrX5uAtudk8ExwR2kNhqDb1788hu05TN4zOhC8LCDybsxF4ss25AKb2EFsi
 Td41BwTEwW1DrsfOWF7hdeKrKbZcl1UyjBQ4ZXqZ6PPckagdtkY3HgqjuzOep/Kjq3WX
 W0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383107; x=1760987907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/vJ+qKrlctD4eDXUGD4jfZ1DrLRP2Xsc63+XfRRrpM=;
 b=DmeDimQRCukU13Ifb78dot4LM7GEG5cLXEgqK/CDHxt9WKx5Cvx5vsaNOzDXMjwnyt
 kJNhmMegAQxq2jnQnrBTqvc/D9neNDX0Vl3uHi/xgHWuKiLDwNu8jwmZc/OtPJ6CxqGL
 a7YGhZj7DYH4f0slYF+fhrahwNAmoU5+0EuBYOl9CEeNjGvfkvWWwIVpLRSzVHlTd/AA
 hymfWw5uNxMurYB7aW84gkpqlNqha/ImwTQt153Oiw5lSxHy2XXdZulz0gRlqeZ2ta3T
 /sxXr8v3Mp9vtjGkuSzfjsSY5ItLYrvPm12wp2fJS+5hp284uy1d9nXXHCpAqF0Jfj4L
 oncw==
X-Gm-Message-State: AOJu0Yy4GTK1dF7ka4FedmofiWKvlz1GrbWemZ7B/0pQX4my0xcekXDK
 NpKhzV2ARnLH8npcsQgYbMeeb2wJYbwWb0zEReX0DSUzfdXaMy+O7qy+Opd5elwm/9ii0BzNpI2
 NfIlGCZ6j/w==
X-Gm-Gg: ASbGncsB92RZ3KltT4MxA96zB3ccuItozcsJP0pp045GrI2Xqge+slM9CiU1402ULP0
 f51D+s1JLBcIsy9ErjPxgwmQ/NTxWS4gNTfNToje5AlMRLb3XSRHZascdAOvVTqhXYxkr4GCenh
 aSt0q69Y+mQVqgP+gUj+NUEJPD588PLk6+1KtXsKhievXM/i9P8VKNJQaqnRXWyNpWtPuMbLfdO
 RsPGekuakq+OYolGLNPHctuvu1RnijOVUzs0EUa29mEIderBt/uegcSmhdf6ovPB92tDxknhPo/
 CrFdC5EkbFMNYtLmGTDjMH4V4XdhU5p0qf86UMYyVL0/tuK+EziOJHrJuPMNYTF4OgtcdjCpbGp
 zzYoaiKRlfqx64xd/cLWivDZOnsNWZJUE80k/lb29D3ceVv567iD9hpFLkMMP3sfrg7LuTqM+Yi
 VfTe1CiPbKCBb1rw6Oqu4=
X-Google-Smtp-Source: AGHT+IHcD4eQQP9ijHtBMzETLcOiJoRlEKDYCB+bkorLzomQo3cdCBx78cMJldYrLJzYQMMQdywQZw==
X-Received: by 2002:a05:6000:3101:b0:3e9:b208:f2f1 with SMTP id
 ffacd0b85a97d-4266e7d025amr14684083f8f.29.1760383107593; 
 Mon, 13 Oct 2025 12:18:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d0011sm19717298f8f.31.2025.10.13.12.18.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:18:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] hw/sparc/leon3: Remove unnecessary CPU() QOM cast
Date: Mon, 13 Oct 2025 21:17:59 +0200
Message-ID: <20251013191807.84550-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
References: <20251013191807.84550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

env_cpu() already returns a CPUState type, no need to cast.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Clément Chigot <chigot@adacore.com>
Message-Id: <20251002033623.26800-1-philmd@linaro.org>
---
 hw/sparc/leon3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 0aeaad3becc..09d2cec488c 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -192,7 +192,7 @@ static void leon3_cache_control_int(CPUSPARCState *env)
 
 static void leon3_irq_ack(CPUSPARCState *env, int intno)
 {
-    CPUState *cpu = CPU(env_cpu(env));
+    CPUState *cpu = env_cpu(env);
     grlib_irqmp_ack(env->irq_manager, cpu->cpu_index, intno);
 }
 
-- 
2.51.0


