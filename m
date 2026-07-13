Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B70C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 23:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjPfm-000646-Ni; Mon, 13 Jul 2026 19:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjPfl-00063H-Dk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 19:02:49 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjPfj-0005lq-Qj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 19:02:49 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so4016255ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 16:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783983766; x=1784588566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N9vaunpGtCu85rFgK3ivuUDYGAyeCp+q4K8EoUFSa34=;
 b=eNiaPspwZhpaPLQ+qb8i72DivjRd1F9RSUb2NLUtp4GifxW+0XOghnHXEVR/y/JK7o
 /+ZaxF5Mr1tQL+btK9SblVKOPv7kMqDDtq+JEL9NbLR0uhcXf5WvLo+E4h6vSSNlznaE
 BCIkp/ARBlW6t23aoySkYCO5Tz5YRAOUaRU6qEKoSa/yEw/caoGv6iHvGeCZWtF96U3w
 KlNa+18xTQ031bc5k7uPGUCs0vldg+P/Oh+NJdaQA4oXb1aUeV6SmoSZJRRGK0pK97f8
 0rT9vO1VHQLFi2bomYqrNlhO/iA15tbM4HfeHxo5wEGkoNIFHsEZQ863EHrqbvLEXmai
 MLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783983766; x=1784588566;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N9vaunpGtCu85rFgK3ivuUDYGAyeCp+q4K8EoUFSa34=;
 b=asRD+bp+anOP746SwKKLRpu1eWZOxAYHyn8Zk2yrVIEkzJhb/aYRRh1xAxwAt13seT
 hbbowvdATEiNyLL/fMffhzUetL6coRr7D1dUBBn+neHfd6b7B9u3v17mmw0TUR2LODBj
 V9nsATrsBfLfAU7FJAABMMLaTSkBQgjEZM8f2cZY4DdS0kgG1d0rwv1+Uwn5c10BuS5P
 7nOCD8+PsuwXevqnBgpBP5XtRjUECh3LS4sAIbZWXi5TkpDu/J9xfNnprWiNoot81LuZ
 vV1F5XLV8NmiVRSD8GkQQdW1whWxiBb4x0R21dn3apam9umDHJGJqzSKks1LzL+UzXrE
 zlOA==
X-Gm-Message-State: AOJu0YwTAZbS6tfaqRym2np/ObmTeGFt0hEAHkqhKxOfda8acN034ECo
 Jr3KMVPXcKGjF7huapfGJ43CrbGpoicpP4JM1JBiqL6MYe6hnB+OBcaFk7gVu0yaaG+QWmY2wup
 nSjAX
X-Gm-Gg: AfdE7cnHcMONloBgiFNbb19ler1I9CYDJKh0r+myASpLxhlgliz94MG/1noxO+V2i2U
 LGZWHEG5rKSuBpWkLxs4b1SUu6l682vfyy9WshvQXqwWNMhEboHVLgEg3dVRb83lYBIKfz/oH3x
 C7FGKwrvhOUVXWG1QCb4/kfdqsMF4hZd6Csphz7Bq9lwNgg5JWjA1+yv3ePhIajcYYUiQZyYH8o
 vEeddZaIT9cz3FbtFsyt4KaioonbZArqgHMG7CaMlX4K66ZAWU8ikYCqKZZRuhzPqd1bHZHHWJq
 ZKp6m6aNfv2r3Z7f5UqqbLFHewQPVoQ2068y0yAfhXMgK19jmohR7xW0QR6jfgBJMpmTG7H1HQc
 aPQmMQswV6UZsvrX+CPfx4wA8FFOGlMEU22XZYAVnmCf0O3wn7imJuxPrCIbqKz06UhDkOIvR3J
 07QcGuJjRGvxhy8lZlGQ==
X-Received: by 2002:a17:903:8cd:b0:2c1:98b7:ecf3 with SMTP id
 d9443c01a7336-2ce9ec0f0bfmr98918315ad.23.1783983765604; 
 Mon, 13 Jul 2026 16:02:45 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf8e9csm106902965ad.24.2026.07.13.16.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 16:02:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH for-11.2 00/10] target/arm: Implement FEAT_SME_TMOP
Date: Mon, 13 Jul 2026 16:02:34 -0700
Message-ID: <20260713230244.70174-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Another SME2.1 extension that becomes mandatory with SME2.2.

I reused the little helpers that I created for FEAT_SME_MOP4
without renaming them to something more generic.  I hope that
isn't too confusing.


r~


Richard Henderson (10):
  target/arm: Implement FTMOPA (non-widening, FP32)
  target/arm: Implement FTMOPA (non-widening, FP16)
  target/arm: Implement BFTMOPA (non-widening)
  target/arm: Implement BFTMOPA (widening)
  target/arm: Implement FTMOPA (widening, 2-way, FP16 to FP32)
  target/arm: Implement FTMOPA (widening, 2-way, FP8 to FP16)
  target/arm: Implement FTMOPA (widening, 4-way, FP8 to FP32)
  target/arm: Implement [SU]TMOPA (2-way)
  target/arm: Implement {S,SU,US,U}TMOPA (4-way)
  target/arm: Enable FEAT_SME_TMOP for -cpu max

 target/arm/cpu-features.h        |  25 ++++
 target/arm/tcg/helper-fp8-defs.h |   3 +
 target/arm/tcg/helper-sme-defs.h |  15 +++
 target/arm/tcg/vec_internal.h    |   7 ++
 linux-user/aarch64/elfload.c     |   1 +
 target/arm/tcg/cpu64.c           |   3 +-
 target/arm/tcg/fp8_helper.c      |  50 ++++++++
 target/arm/tcg/sme_helper.c      | 191 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  79 +++++++++++++
 docs/system/arm/emulation.rst    |   1 +
 target/arm/tcg/sme.decode        |  28 +++++
 11 files changed, 402 insertions(+), 1 deletion(-)

-- 
2.43.0


