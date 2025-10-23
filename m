Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C251CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBv1g-0001PL-Pp; Thu, 23 Oct 2025 09:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv1f-0001Ob-75
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:06:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv1d-0006Hn-FI
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:06:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so5287455e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761224798; x=1761829598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iYI+9qPb4lKcaT8r0cUl4054QjPkgSdWroSx2d2l+g=;
 b=vi6urhRuRJ7x9CKKrI9emrE4cpLqDGb7BODv/TScb63wRPOXidclzBPRZrmTobG6jI
 wGMf8UogLCiDRfi/X3MTpyIcyUeYTzQviSwADo7If1E+Yare81zkTFwll8sBTQErZ0UO
 UFX8TFPc/CA5eKMtvdLgtJyOa+/l6JVYxPXQEpli0ccDmgqsM4HFhqdlVwO3JccMoXye
 U1q/p2gSkjqhYF6gXKPkunfjxfjPFM5nzysGcFfoCN2UXnmCrY9UMjhQckQZJ53F/3vN
 qN/Bxm9UBUULFX7G0cT4hdq7Sb+1qGoCdyc+bUB2wc2FCsPEdru0N6YjG1mHREwtjJrE
 2C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761224798; x=1761829598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+iYI+9qPb4lKcaT8r0cUl4054QjPkgSdWroSx2d2l+g=;
 b=Jad4qODJOmm72nC/SET1Rxsp+ET4BM5zDqA4F0SeF2p3xlaDCeKEdrNjXyKxwvqQsn
 fjowx4/uB73YmfGBnS2JJ5U8erxYNJe/J0QIJcjPE9fTS/6hZKQYSmAvTnIuqx8pWLk4
 z/0Wmia5swPsEgKldzOusF98jRLb2wehiir3jlLDR8RUN4wAnJ/1EiipJA0FkrcSnhAN
 oYwmz6Wqkq9xzA8K8ESTZ9Cru8bsSul2WZEd+b5b9Ng198gq2KtvBGrr6yuB4yTcPfRQ
 R5yZEvR4AMZUjwn4JQm3azmIflQrCkwPsU/o8bSRCcdSzjAo3g6+jZGY9u1x7NuH/dhC
 oQJg==
X-Gm-Message-State: AOJu0YwlVxILtH3KlP4pLoo6HAgipa0KWRwrHQ2VIuIL1gCaXhQjt3he
 pqxqgO6dvrBWgs4yP3DjVsqPONIXTlC+1ontM/SZF6p7Tdkmt7End7kwVLAkszwzlOaP8iXJ/ax
 9VEtCPEo=
X-Gm-Gg: ASbGncvn64XTdPbDgk/S3nl3KKTHzLRUh+8kWBW4Rfc5VvGKUGqaMvR0D4DfMM9wmhA
 RiOpv7QfCsdPKmBjUSP/2+DUtbYOTZ/58Cf6IA799H2QTZLO2OLk/6fnInELNsuCnyTMsa/L8fv
 1Jq/xEiYAco0ddUn61fbZuZPTvWudnA1vtWfOfdxncfX3GjFbndEsb7WuKZvynZqb3b0JucCRYX
 oQycxgUeL+9QtC1RoC1OuxzUohtWfWWEkQZXrAoiVWLLxog6rxsIYyh68Epr8fy45S0C2vS1fHZ
 UzH7jRbIfhAsW6it9S9174j73Q5DnrsMZAlNQUvWgx7WUNOF4kT0k/yBXeqOfH7nrjRd0okuHBa
 xJ9bo3P4D3aleoDxvEvM25pVCUNQKOjqTcCNbS+OGQ6AOMpFt7vaYwdLk0KKHUCf2zWziyBOdI2
 aiJfKJVMEXgorYc/IyM+X7JfTywCctUGNjFfH76jqEmyfHTUg5vw==
X-Google-Smtp-Source: AGHT+IFO3tiqOSZiOxEn9gdYKzQwGcXYvLK0iWLousrE5gOvGzkWzXB9U2Eq8xGhqGRDgV6DwxlSYw==
X-Received: by 2002:a05:600c:458b:b0:46e:4246:c90d with SMTP id
 5b1f17b1804b1-471178774bfmr167520355e9.11.1761224797894; 
 Thu, 23 Oct 2025 06:06:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897e763csm3983570f8f.6.2025.10.23.06.06.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 06:06:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Collingbourne <pcc@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 44/58] accel/hvf: Have WFI returns if !cpu_has_work
Date: Thu, 23 Oct 2025 15:06:20 +0200
Message-ID: <20251023130625.9157-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 target/arm/hvf/hvf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index cf4746c344a..8c2eac6738f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1749,6 +1749,13 @@ static void hvf_wfi(CPUState *cpu)
     uint64_t nanos;
     uint32_t cntfrq;
 
+    if (cpu_has_work(cpu)) {
+        /* Don't bother to go into our "low power state" if
+         * we would just wake up immediately.
+         */
+        return;
+    }
+
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ)) {
         /* Interrupt pending, no need to wait */
         return;
-- 
2.51.0


