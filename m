Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2EBC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaAb-0004UH-I3; Thu, 13 Feb 2025 09:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tiaAW-0004TB-O7
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:26:22 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tiaAV-0006mh-7J
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:26:20 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38dd935a267so727201f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739456777; x=1740061577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y5aI/36ue8kE5CC0CoYbs1TUh660puYQSaXyAWFdKYE=;
 b=DaelwGwqDx4TNdvnbMNjBF3EmBRg1rooBvuNShpMtyet4wMkgQy7XvuLB7YWahLBfU
 riRvXnXpyV+HyKbWbJYA0INSFN3GT4Ud4QP6oM/J0saU+cEuHiUGMSimX+622xnp0b3n
 c09yZH+GRKG+Y2XVWF08CQorctTLY7fsKyq0yh/7+Ursi9VBJvVj2c/z+u/JAtGAK6fP
 u7edumN+qkSUowyLDA6uWD3rJzKTwHZZRMT1Pqvh74e9EfqLiWNVIIqRxn6YQ8i7EDD+
 pYLB/nd2Po6NKeR29A1B5tvJM4ZFLWzUHc4JxV7Fow1fqF6goNykwv+4WQ6avoSEvQPa
 Ujkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739456777; x=1740061577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y5aI/36ue8kE5CC0CoYbs1TUh660puYQSaXyAWFdKYE=;
 b=ORa/d6Z0WjQxvPf7idgh1si6PzsJyo/08AmE7r+w6VbPPq6lwMKk+Qo7esTs9rGd1x
 GaT0wFj90CywakZd1zBj4CmtExd2xXxOdFFKIBCnDWnNXlABiGs4JDGUiO0qgGwidKb3
 wOI5fAZCIh3eg5V3TD8Rb3pEVoGvnHKLnpurvgFtsSkDYfuK/MzJRarNiK5YRPUuSyMQ
 ilpYCxJ9CcB4TMyvZtcWSYSyBNWHzyZb2gWfm9X93ZY3A/VqXebNeeTf0cwxoT6EUOMR
 XzxTItBaw+xGZTGswuQyyzB65CzBVLizadUq6yLM37iVxv/9AI/GyrgnKX3hcI2Pmk4i
 WoUg==
X-Gm-Message-State: AOJu0YwAH+guReavXHN1lqoTeKxmD2NUdV1XNTGfD7MvvkezFwDiHWl5
 7e3c68Y2GDxOiIzNFDC73tgmgLVJS9gaRka3Vn5BPaVEWIyIZ+of9yBNadZGJBVbZmFYPz9Zia7
 w
X-Gm-Gg: ASbGncuNnJYvijd0sQiESmGT5oYaZUT1ggRjq1KpdoI6xtKuo5LppUK6+xAsXN+3uLo
 u/kxMFgEe/zy9/t8sFxXbPcgmOzvYNaN8X/PTVr6JX0oD9Jmrv3+uN/afzGMEd4D+BrTVt4abac
 9RwT7ifNdz5TFv8i9D7uwpygau0whUE0W/LGhuXwf9taPsbJ/SFgLIXROenPgN86LYhyxbYnjWA
 tFP1eZ85XGI+HJwjwvVlKlAHYHj2fKsh0vADk0xBc61THipuNgQIB1/PAoim3pGVU+Dwf4RE14k
 5noZ+rUwW6sspP7XknuuCw==
X-Google-Smtp-Source: AGHT+IFADbruedXrrvDlo5ygJlNPz8DGKVf1TdjO2d4MXC5nGuqOE/40Buw7U5n6YvUn2uHKjHH+Eg==
X-Received: by 2002:a05:6000:1887:b0:38d:dee1:e2c5 with SMTP id
 ffacd0b85a97d-38dea258b98mr6684229f8f.1.1739456776282; 
 Thu, 13 Feb 2025 06:26:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4335sm2093604f8f.15.2025.02.13.06.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 06:26:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 0/4] target/i386: Emulate ftz and denormal flag bits correctly
Date: Thu, 13 Feb 2025 14:26:09 +0000
Message-ID: <20250213142613.151308-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

This is a set of four patches to target/i386 which use the core
fpu functionality we just landed for Arm FEAT_AFP to correct
the emulation of some corner cases of x86 floating point:
 * when we are flushing denormal outputs to zero, this should
   be done after rounding, not before
 * the MXCSR.DE and FPUS.DE bits indicate when a denormal input
   was not flushed and was used in an fp operation; we previously
   weren't implementing these semantics

All four patches have been reviewed by RTH. Testing is a bit
light (make check-tcg and make check-functional), because AFAIK
there is no freely available comprehensive FP testsuite for x86,
and risu doesn't support x86 currently so I can't do the same kind
of random-instruction-testing I could for Arm.

thanks
-- PMM

Peter Maydell (4):
  target/i386: Detect flush-to-zero after rounding
  target/i386: Use correct type for get_float_exception_flags() values
  target/i386: Wire up MXCSR.DE and FPUS.DE correctly
  tests/tcg/x86_64/fma: add test for exact-denormal output

 target/i386/ops_sse.h        |  16 +++---
 target/i386/tcg/fpu_helper.c | 101 +++++++++++++++++------------------
 tests/tcg/x86_64/fma.c       |  17 ++++--
 3 files changed, 68 insertions(+), 66 deletions(-)

-- 
2.43.0


