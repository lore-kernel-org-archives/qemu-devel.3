Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDE8CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcVy-0004OH-4S; Tue, 28 Oct 2025 01:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcVt-0004Lt-Vd
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:44:59 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcVo-0002kx-JW
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:44:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so3367818f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630289; x=1762235089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXJBYBBxDFZzibjViQ0cPD/hzZBaElfD+qR56RI2SXQ=;
 b=NIZJdRJBFBu1dLBn1wHVCieIj6Y6+Iq/EGs3FIS+tEBdMQJdBrldN/Or8/wZVVFVC/
 zRY3p80iXITkq2rdmhyPiAoExA7sq7D6iFbPZXFs/anBOo2Hu7Av0gxc1iIftK7WUGvT
 JqZlr9+tEHZma/midvFMxBOvEodp5VnTxPQSira9NbNmaCuXpC0Gx34VW7i76gDpwsjd
 S6TYd/xLpjFizRkmsaTwZhwzFvRjZD/dMkIVyO7bbjqT8hhT/f2MpOKWEOB123Iwu/v5
 GvmjUfkzitsS32ofSKnXjxQJh+bAHiJ+i18wGTVuGTuPxVbh9L3n+cpELy5imw8Ro70U
 iyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630289; x=1762235089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXJBYBBxDFZzibjViQ0cPD/hzZBaElfD+qR56RI2SXQ=;
 b=UYHVrdIQtLBatMhGTGFpSXAZL5Yeoqg2pGsKdGOtq23wJSkzdJ/JQ8hFY6rlUwFv4b
 QLP1XovOfCLs0RPdREDTJzqDJr+S6R0CqeJbCTtVHFdbov4V7kQVyT+DNlxDYtoCCWxB
 DIzgjwCLsOz3u4Xmb5js2MWhjLb2fd/wPjxlxzUmb3TIyXTCQ2iFBGIOSu3UMu6bQz3q
 xZSPQsdjCtvH7oy7XZbqQ74+EIEnFIxU2sDlAZZXAAzjQ1xROzSj9r4X2271E7V7wJ6a
 pAOWNxxxpqrsDu5mzVTg7uBqWbuHbsjdmpi2ToBLpg3dUCzNPiFcRiT6W99hnS9Da7EJ
 FuwA==
X-Gm-Message-State: AOJu0YxypsYVY91ABwdjWovHWs827T5N/4taZBhlVYJauKB4GtIhgzGv
 jLKPlg3iYwBHHJTwu/KN50kMTNnuUkNgC9e/t9H8hZP8zTXkqYOcMd9VlYN0HSvXYUZR+/QlHtJ
 V9YBT5n0=
X-Gm-Gg: ASbGncuhji0IF+S3/XzcGOl91jk+KtffHeEJXZg0pNdXMGNAPIhXVwsi2tiGD/mFO08
 ZtLzY3s+ClmQhgDTPAdJFmJat8/2J58ufI0ECzpAzDsNcrGBb56rb2cvGl7msyc+qygcSjQd9gx
 h8vN+I4OcQYGCkh12t8P+ycz8yPakmepXDEFUdFQyZ5wBW/etYhlYxuOdiP/H1ug7Fhw0Ide9Fk
 VQg66N8qAuemEFRf3/z9ARfwTfbM+tyqmJSmvi4VpKkI9FR5KgzhRI6qxkJsimbp08eRo7xL3h8
 mdJmR2/gV1mU4loP3d3+hsDA1JpUXHScIc/GWOnBIJHQq27T/mqb4zabQnciTLq+j8Q1ar4Nmmc
 KLbGQStDIPchouno/BOIroJjCvUkbWCj6ySsErzmbEwtjagmYyMTo80q7R2VPIRlS2FvLgu+Rv0
 /deNdCHk3ThdKjZRQG417gZdloxlx3Lfwo1ymiRZ0dG39HBMAob2MvFK8=
X-Google-Smtp-Source: AGHT+IGEFvpmIwIspPKKlIzjFpjfzi6Gy8JyBGuNuotOF1i3Klx0iY+oFvmZYD18xKgSn3uT/YQWFw==
X-Received: by 2002:a05:6000:2501:b0:427:6c6:4e31 with SMTP id
 ffacd0b85a97d-429a7e59e7fmr1886003f8f.22.1761630289136; 
 Mon, 27 Oct 2025 22:44:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbb2bsm18299358f8f.13.2025.10.27.22.44.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:44:48 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 03/59] target/arm/hvf: Check hv_vcpus_exit() returned value
Date: Tue, 28 Oct 2025 06:41:39 +0100
Message-ID: <20251028054238.14949-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

hv_vcpus_exit() returns a hv_return_t enum type (defined
in <Hypervisor/hv_error.h>). Assert we succeeded, as we
are not ready to handle any error path.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 91bbd3a6aae..4c98faebbed 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -963,9 +963,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
+    hv_return_t ret;
     trace_hvf_kick_vcpu_thread(cpu->cpu_index, cpu->stop);
     cpus_kick_thread(cpu);
-    hv_vcpus_exit(&cpu->accel->fd, 1);
+    ret = hv_vcpus_exit(&cpu->accel->fd, 1);
+    assert_hvf_ok(ret);
 }
 
 static void hvf_raise_exception(CPUState *cpu, uint32_t excp,
-- 
2.51.0


