Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F20C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNqf-0000ee-1r; Thu, 03 Jul 2025 13:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqb-0000Vy-Dd
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqZ-0001oU-Eg
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:45 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so691635e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564141; x=1752168941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjJ+lcNXcYC5f1FwLpKLJEf76e+ZyGqrMwDm/D97r7I=;
 b=OCBJ+txAeCFQeZQ/qovkre9uALn42SpFJnL1t2WZ9sAnoU48rIA8poL6tDeNZQUB6W
 hcXwZRWzblUvUV3Z0BthabR42CqTZOyb1aIvBl8wYrAeJYWDafPWhAUwgpMdOELW0JmY
 ma/fA8+urrJdwC8I4g1DqPH336irXj2FWBFmg1KXRfdkF7x8bcVJrA3Nfk7/2FdBWc1q
 JLiHUcwSgrBS4HGLf/TWO6F28Wt5MNmYNr2+PVQd5tharMUDMKwBw8fwoR7h8mvHfPQm
 KWy/NC7F6qQE2IOYGXHDxzQaKzCgyVFF/rXuTuQiP9rDygOqfOLtjk0UtDrdxPsrBj3+
 PmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564141; x=1752168941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fjJ+lcNXcYC5f1FwLpKLJEf76e+ZyGqrMwDm/D97r7I=;
 b=aXgSerjlsmtckjFUTD6TlYB/hHYcu/9GpXT7Qa3BandK6eXNwdvhayXihE3c6IpzAV
 BV+8H46aG76YfdWAoyTVjj7606ojz2UdszDG43aY6WnBcSClHwbkkfG/OQXSuFCbsgEu
 GEhxHDegUMZAh5wVdr87YwzSyWoFFKPzprVSRI9b/09Phb8ONDdw7P7DRtAsw5z9YNXZ
 qH7UTd4L2v/sGCl4PMtEqPhOgwCk2+OJYUiajA+1ZjNYKZZHHvkRns3LfcmmOi9aQZnU
 VbLKJoVXS4wWsyD/kOiWofjKTvuzvrViR3PlKGacO/bYXBFfI+Hw6yOtVIYrKDIxBUwV
 uHSg==
X-Gm-Message-State: AOJu0YyWjFECT4UhbhDFn0nOs70IFC9fBIijnsg1UfAIFqawim7BctQ+
 0CGLhz02zugwBTs/yVlJSwd0Z3Mt8RHNUHn5Z+u8KVci/At9UIaRtBhmJ3YAomnMbEyYx0cfT1V
 8XFH/7nM=
X-Gm-Gg: ASbGncufXb+P1FvHKWvwmml3PJyhncFhzhpp5Ejc3q9vvlflxNE60V+XGJfZmJvPL3w
 SGhnxGl0qFSTbG6/dkjB5hFAPXQ2yX79SZdh4Tag793uoDtoa2WkFlJecmLvTirSmQsEmXBycFd
 qMRQkNoBZWheFoq1Fi5T59c9I5gWi85sK1GUn0uxX+cDBxSf9djY7rwB7MxqcTh6uVmXXIsTMaI
 yVJ/7wJE6hbpoXu575GZ3o24HMcHXok3FqlYp1k5xO1A4cM/YDreUETEvC8gWx+jBHfZ97DARLG
 jhOonQ5OBU4gckBKq7ADzovIkoNcn+cv9HmEz5rz3CIlA4zGPmzPOnGPAlqxAE3naitxhcJGuJA
 gkrZhV/6lo2joCxzO+5A0/+tBQGiOAgnag6bq
X-Google-Smtp-Source: AGHT+IF3qpPPLYHCen/OvZ3c3kUwooh29DGaRG1oO4fn0b7UOW7ZJboMWSayZSJdRuauW6FDYFScEw==
X-Received: by 2002:a05:600c:c493:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-454a9c7fac5mr52499855e9.14.1751564140699; 
 Thu, 03 Jul 2025 10:35:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47040161bsm337927f8f.4.2025.07.03.10.35.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:35:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v6 31/39] accel/kvm: Prefer local AccelState over global
 MachineState::accel
Date: Thu,  3 Jul 2025 19:32:37 +0200
Message-ID: <20250703173248.44995-32-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 1b6b7006470..a6ea2c7f614 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2588,15 +2588,13 @@ static int kvm_init(AccelState *as, MachineState *ms)
         { /* end of list */ }
     }, *nc = num_cpus;
     int soft_vcpus_limit, hard_vcpus_limit;
-    KVMState *s;
+    KVMState *s = KVM_STATE(as);
     const KVMCapabilityInfo *missing_cap;
     int ret;
     int type;
 
     qemu_mutex_init(&kml_slots_lock);
 
-    s = KVM_STATE(ms->accelerator);
-
     /*
      * On systems where the kernel can support different base page
      * sizes, host page size may be different from TARGET_PAGE_SIZE,
-- 
2.49.0


