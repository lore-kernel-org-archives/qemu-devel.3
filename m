Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E07F5545A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 05:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv7Cy-0006u4-Mr; Wed, 25 Feb 2026 00:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7Cw-0006to-Jt
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:13:10 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7Cv-00043K-0C
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:13:10 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso53081585e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 21:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771996386; x=1772601186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j0v0q58T93WLY+QFmTAFfQHATj0wMqCjYTuLixMjNSE=;
 b=jGuaDM73zkKDJ+ixHFa6e+Iazgz2/9xd7f5iehoHHePkchRhzpsYa7BLsuWiAFx4VG
 1d1nPqHZozHvqwKn8sNrVPqhzgNIrfumXOkPHTfPNR2rWgZnNqUDoq/XGRcidYXrTYAU
 y4+G9HjX4BDU21k5mbuhScESefY/3w4W4pTgVvQ4XzCpq6gBZuEifdBXj3+5/iPTCDuZ
 pp3ymz9okWPNSLsnAyTLbCfhXH+SWkddlkxwwzZq9OW/Plb5imDr0vG0sP/sSGhaMp1D
 +C9fwG5YXXpJy7NZX2qyKynxAm8jEqFse2o/VmkEnWWyOZC1mHwMMshhh7a20zH3/dSW
 3k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771996386; x=1772601186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0v0q58T93WLY+QFmTAFfQHATj0wMqCjYTuLixMjNSE=;
 b=Qyoj/lS7iCwHNivLI11Y2WD/FniWZxCcuD/G7yE8tfneAbzSnkYIx0xijU713OnEtw
 uUsFi4NSgjTf2zHMAlqQ+OHf7ErlrPdpHAnxp1jK1BcUg67zMFF7LGJHJqIm9JUJex9U
 1vcMmZoDaPOEPauH7Kgaf695nHg8+Wcz4oZGs+Fxyh7uEZzAmS04+dDHZ8ywti8P9/26
 AFoO/L95+4Bjm818VbbJ9Oe3ebQM5G6YlkyenxvB0yjsSAl03HrzUl5JmYP8j4cNGxvu
 6OMt7LSe+OQt5lFPyswkrHfywNIPCWJkTwCZ36Ze53+9HuE21UGhB18ZWOVqYp8WAsTJ
 ZyFw==
X-Gm-Message-State: AOJu0YxGCqJRjeoZBdmJV2/TJOTqHmRI4j//Aiyy1GsqWAMARDY5Xun/
 1Rvtu7cr5S1uxyIe3pps/J9wftguAUeVCrmi3BD14ixMJJ4GGFVplAU4fnqbukng61LJUNEEoZW
 7q+emFn4=
X-Gm-Gg: ATEYQzx3ZrSkhqm1yA+h1knSDOeTGfE7yAyy1uhNh1QpQuF35YPOqcm2ZLLL/dJWmiH
 OyC+wbMm5ds2CjHS931w2mKfRn3SVsxWVxwbHpGIHwO7tizhvLRtql7dagrQRAZl4f9ywhlZ1a6
 W0+0pBWumvAm4tJE9amB8ixoyJULjaRaY+XC8w14drWppRXjiwQb43wlXCxuRxicQt1cbVeFZqM
 XOqeZ2J60UC+xf4nCOWbs0EnndUPWfg/YdqYvaimrLl5SeyItllWcEguO460KtrgKTO4PfPCpT4
 RWywYrJ3clPenzU6FoZ8zBTLarXpx9qAO4iTRxt3DrvYPnRuRcF1Bv/p3NvmMpSj6beABqv/dzT
 g5gy/CCVu1Fl+pbUndw2Rs9jirQVgt9dNdcZ9ZUJ1LQrwKk77iCosOn8OqTzucZbvGRKCwdXUah
 pVNSczQYoovDyj34Inmxu/my42TG4ObQ/dn6xLIrksmK6T/fuuvCTpOy+hvKLU672ddYq4np4Q
X-Received: by 2002:a05:600c:4fd3:b0:47e:e20e:bb9c with SMTP id
 5b1f17b1804b1-483a95fb0a0mr214322895e9.8.1771996386044; 
 Tue, 24 Feb 2026 21:13:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750701sm46374715e9.11.2026.02.24.21.13.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 21:13:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] accel: Try to build without target-specific knowledge
Date: Wed, 25 Feb 2026 06:12:58 +0100
Message-ID: <20260225051303.91614-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Code in accel/ aims to be target-agnostic. Not all accelerators
are ready for that, but start by enforcing a few easy ones.

Philippe Mathieu-Daudé (5):
  accel/kvm: Include missing 'exec/cpu-common.h' header
  accel/mshv: Forward-declare mshv_root_hvcall structure
  accel/mshv: Build without target-specific knowledge
  accel/hvf: Build without target-specific knowledge
  accel/xen: Build without target-specific knowledge

 include/system/mshv_int.h | 5 ++---
 accel/kvm/kvm-accel-ops.c | 1 +
 accel/mshv/mshv-all.c     | 2 +-
 accel/hvf/meson.build     | 5 +----
 accel/mshv/meson.build    | 5 +----
 accel/xen/meson.build     | 2 +-
 6 files changed, 7 insertions(+), 13 deletions(-)

-- 
2.52.0


