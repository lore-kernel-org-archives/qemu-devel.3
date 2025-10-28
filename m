Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B8BCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcWf-0004tN-2b; Tue, 28 Oct 2025 01:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcWa-0004sO-LA
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:45:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcWY-00032h-IT
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:45:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso40346965e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630335; x=1762235135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEm2BcJk3lcGKEr7IiOVTfv620coTuiYKu5tYc8rMA8=;
 b=jCl5nAe4n0EmMtIEdAJuwKfX8uGPFd+eLKzc+q1nkmtx8M5rEC3LpfIh6+QktGh0q+
 XOWqy6A4H3HnTOxojb+iTDSATWCpRa8ALCPbW76sy5WP9x57GW+PnjFHHUTPoqjgjf09
 FUT9XtZH6lJ8B4FnJUY9QLnGYq3/IhZqOAPrRFHhdFcSIAz7g7t4frhD1d4RxKFWsaGV
 eb3nzx8WiMMghsZOdVfDULF9+thEYmZdSXEtbp2Zr1uEiQTfim2NEwV0/lMf/tlPb70V
 XNPkCTC+KxohzrXK0syl+yYrXNSteNyodpsVFY+rbmLEE6uoU0fIKEd5E7le29qsP0gd
 9Bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630335; x=1762235135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEm2BcJk3lcGKEr7IiOVTfv620coTuiYKu5tYc8rMA8=;
 b=KOghrHpdx38onrZ4OM8Ok+6kMrPS2B+WW5yIR3IWTNl6AdJvujHNzGhXWsA07fzLvz
 7TS5cBYp+Sg6xij9XC9GwpfEgrXobbX0SsrAJ6m1Arpit2Dpii+/qOF2ux7nxmUpbDK4
 HzgkiypZEPWHeNKsilVvPYdUjTVETO615ueqHy5ju/ijjhYtOy4YJqUf3spIymUK3Ef6
 FuG1IRoGz3AbsABsYMyUgVYAOax/Sw735tNyWfpnbDJSHi2b7B0lOLCTQKA52CWlstS7
 XpTMk3iNsXSpK7YYwa5nYBZIOlnPKUb7KjJl6LDEizNsx2nyfJWOA0si+xJzsb/mKScA
 mKEQ==
X-Gm-Message-State: AOJu0YzXNE1+ifjEnQAN/l2P3HuxcPLhuaTzB9YjT3sf2a46gnoR8qOk
 AAU3iWLtycMAwCMbi3soXlErHPsQBJ3d0OyzWvSDNhKeWT3v6c4qM3hlFIQMwbn153wNlTfxeOV
 La8RQzgg=
X-Gm-Gg: ASbGncv/uqZwdWDxi4SxEQyGLouRogmbZc1YbOsOcSInjt9NRIerDK9bTKX368HxP6c
 WDV4xdJGQuiNdUWOWk20JvzcgOfHtadyqu9j1+PVoTgYmISWpowGcCdr1FQxYyg4kiHJQSEOdNl
 g4EsjTIAlSQRhjRBogksv/fii/52FjwKRdpwbTX5gviijs0WcFZDsX7X9oQIabF8BvOu5Vy9AAS
 fx6MCfxioYzUG3Tmw0Mts0AzcX+KtAIUXkGCm+RiNMlTJ1JK94KGY7YuwhlDLA4qXkItZxfQJsi
 UNaC5HLR4t+7ML9dKsH0vSqMfV5Sstq/4gHevuie9sJN0uj8Y+JOfBVHWbHhimgTqG0OTrCFMJv
 o6dbUmfuJc35Ak+FU225jUqTFS+fh9hsvuVP60e+aBgd9KFwYt7YrxcTiBxFpsgCk68XMaSj2AL
 8LQMtPRYc3f/MNe6YJhNwCPf5pROLqPETHRYpKtDinnbTUNBrXgXu+oio=
X-Google-Smtp-Source: AGHT+IHpt0xwaemKy/yvq/FfaWxuSsYnG5zdlSQeS11LnDSl2uHUutoHJ6jNqV27iHrxoa1gw5RPtw==
X-Received: by 2002:a05:600c:a08b:b0:477:c68:b4da with SMTP id
 5b1f17b1804b1-47718176e5amr14811195e9.20.1761630333497; 
 Mon, 27 Oct 2025 22:45:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db9c6sm18409668f8f.36.2025.10.27.22.45.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:45:32 -0700 (PDT)
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
Subject: [PATCH v3 04/59] target/arm/hvf: Check hv_vcpu_set_vtimer_mask()
 returned value
Date: Tue, 28 Oct 2025 06:41:40 +0100
Message-ID: <20251028054238.14949-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
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

hv_vcpu_set_vtimer_mask() returns a hv_return_t enum type
(defined in <Hypervisor/hv_error.h>). Assert we succeeded,
as we are not ready to handle any error path.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 4c98faebbed..bbe0b24b821 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1782,7 +1782,8 @@ static void hvf_sync_vtimer(CPUState *cpu)
 
     if (!irq_state) {
         /* Timer no longer asserting, we can unmask it */
-        hv_vcpu_set_vtimer_mask(cpu->accel->fd, false);
+        r = hv_vcpu_set_vtimer_mask(cpu->accel->fd, false);
+        assert_hvf_ok(r);
         cpu->accel->vtimer_masked = false;
     }
 }
-- 
2.51.0


