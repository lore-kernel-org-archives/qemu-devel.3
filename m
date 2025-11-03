Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4CCCCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrg0-0007u9-Aj; Mon, 03 Nov 2025 05:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrfr-0007ep-NQ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:20:35 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrfm-0004J8-S5
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:20:30 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso54922555e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762165221; x=1762770021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAPRFLr9vuEGB6NuD3MRzbTtng8wcNEQ/2tGtl9RYyM=;
 b=fK0OcrQUz6BXCoWWNSlYQygeFyt/ZDcswDwmBU1wtXbcsi09DDJ4bIU3CqtlBeu+uL
 VKyGcV7D4tMOngLEZk81/IVyGSWWnIfJZyCGAIRVicxxx9olL71zGEAAs+BjNzVzee6S
 icQ9to1LX/xt2HAv8WElILgy8/TH0WCos8gT7+d52wXP63bvHXCO9efa2kMqByutGky9
 nTrvYz7Hww31touVbDTFCNkJg1O3xA7Kg7gEGFPZVthDFHmTvDChqg89R/hLozc9it53
 jS504nzOnxJTXfH5RRERan8CWqXmYtbq6ZHoYxzJvGCmafZuqP9jz27MKhsXTTCYaiZb
 RRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762165221; x=1762770021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cAPRFLr9vuEGB6NuD3MRzbTtng8wcNEQ/2tGtl9RYyM=;
 b=QRp7oSU+xoFy6T9zsVwpd8Wp3NFudUYu6Ogom/gt3AFSKBK1lkiwFHnSjYttQEktSU
 YzWElVeza7wSTN78ipZe2r63eQAD+Q9GqOZSyKsYBRjMfM5/t5kP43OaaoSNjIR3jTTv
 aB/ifxLw9fNvyMmi8yBpzLZ/VMGzMF2GOyTudDjoTZUJGK5LhRV/vRMGMlOyhono2fB9
 g2hJkTcWz3C5TEV5fT0lZGeRJXM5N+FIkS401uzOwHQEW35f9vFVb/hhyNVuJ7fn9HCA
 G5jtbnTvzs39gbZje8fk+KzS4ZuINnJU1E9eC6w3nhEk5kdiCXFS4DPMekSVRI8xV3oI
 jLow==
X-Gm-Message-State: AOJu0YyuwiGr7Tz+YC1qO2OEKz/3S/4vdNiYLLcVdY1ERZD8SV0VV0+R
 mC2O71aaXAr641F2fVn7KAW/EGrx4QGQTeB/rQqD3KwA+k+AUBOdzcxSixPDYQNV77go4hsI2K3
 meZXF+bdbZrCK
X-Gm-Gg: ASbGncvJj3VXq1sVUvLe3mFr2p1XCKoG6HNJn0AOAm8KGW669XgDOcbUXjK1mkQsBgF
 bCFoRyj6dgDYZqBK4tX4sSVRf9kc4GAUujwq6NjNK+ibe7WoqkrnzO+ltFbFOkucs+AFUBtHCr9
 HXKBHe2bXIWm6xFe+duwi704e8XC08uOKGJoewBvPil2k4VL2+pb8ZKS7bY7QjlN57vVgrX3DF0
 mPLYZFhaFxC0DIroSy3BHomySXbqUKJbmhE1kLWHzPopS3Lct4g+JonLqlh7TeRsIfsfSxBBtBu
 RVSDpO/6Ptz0//+/XDJ9/Sg5NUVNtBp8JhMIWe41f2K8PiCekykYvAkidjmUT2q4daT909+Sx7g
 4hP//K9ASEnLcZB4QdwKyB8lPiTovTe8YtEAg1JXWtH5WJLxCIy0QoXMohr6ed3gAI3Th993Som
 ptrxrdtGq6giAQ1Uhg1loC9ZW4CS3bw+vJcbDIWfhJhVyv/l1xjP6uDK+hzLbrc7hHXEhBQg==
X-Google-Smtp-Source: AGHT+IHEoxliw9cXSsdZp0YQd5iXI7NQiNi1ypvJIzxIwL+gGSs3u8a/R+/JP6HzjWE9rlVljY4wlQ==
X-Received: by 2002:a05:600c:190e:b0:471:669:ec1f with SMTP id
 5b1f17b1804b1-47730791083mr125530505e9.8.1762165220747; 
 Mon, 03 Nov 2025 02:20:20 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13ebfe8sm20110383f8f.35.2025.11.03.02.20.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:20:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 22/23] target/arm/hvf: Flush vCPU registers once before
 vcpu_exec() loop
Date: Mon,  3 Nov 2025 11:10:31 +0100
Message-ID: <20251103101034.59039-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
 target/arm/hvf/hvf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8d0a528dceb..268a0bcd8ea 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2019,6 +2019,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
 void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu)
 {
+    flush_cpu_state(cpu);
 }
 
 void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu)
@@ -2034,8 +2035,6 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         return EXCP_HLT;
     }
 
-    flush_cpu_state(cpu);
-
     do {
         if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
             hvf_inject_interrupts(cpu)) {
-- 
2.51.0


