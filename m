Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEC8C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UWA-0003oo-WF; Thu, 03 Apr 2025 20:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVv-0002zn-U8
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:28 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVu-0003K4-7F
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:27 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso1697518f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724944; x=1744329744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwcqQLVLsCf/9/gdCQJlK3me9QOHV8t+9EaOZdXtMvk=;
 b=YQRFp8HwL/Q6+CbhKgD2GjYY7dyGzaYCAppP1nCuSnCNKIejhTIG2rIcNmaTa4AFVF
 CTLnvnDoBYArLeTnFZGOzBiuOtfqjI7QPzK1xDpwdt5Pu6Ho+RKP+/lVZi2wTfmg3Xe0
 JY1I9M6pDIZxXGytFFop3N7sEGdKd6kbJfZEXzws3JLgMMZs7Tl8NGcX5Mr9r5gG1rJo
 SqqZtx0NgfvW333lyPWdGXqqst/1IaMRnpzTK3cQSPCxkfsy5TxJfNHv+GfQzCPVt9ae
 E/DR2wXneNuA3FfA4CI3zZslip9AYgrbB7ao8X4yiX/S4S0sjcTLT+T1joXA/uZQhqcH
 lrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724944; x=1744329744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RwcqQLVLsCf/9/gdCQJlK3me9QOHV8t+9EaOZdXtMvk=;
 b=JU4/h+G2pw5Of2c1uHzUJl9XtRxLO5Fc2mtrr6oZcKeG8jfl1+4ua3b1sdBcsWixvg
 evtFFnCjlLCZwD3USoxwjZOw7xCwvN0emDvVAfevx9a+rp2Yp9/uz1D6D/yw+HvTZ+s/
 bGxexZRTOZvMvYGz/VI4XoPM1BqOeN6So5g8JL8yOavoVLofH0ArM04XIs0lt5xCFuF4
 k8gE+4KUqP4hN0qYw9AdAho98iEZgXookd7gqZdo3I7suOSOrfD/xV0ourGSM0BeOP1q
 OUAdpnkQJiANNBeCrOeQhsvhpDbIRNdmuEHETdUbypVwRGp8HRPIUfnrhdJn8hp0Op6y
 jz4A==
X-Gm-Message-State: AOJu0Yx8rO3kcO9UzQg1qyBBrZElZ7nVakz2j0IbTwiOc0u0+n+UPC6e
 rg7m5q5zAZAYTDi5sBS+JJ5NvkCYSEkoZ9C6ZrvN25cJwbVtsEYnPeavfq+RDYYqBcJIiP6vuZw
 l
X-Gm-Gg: ASbGncsTYCNTeeslXTFlBzJ91M69NpUhAv/Kry7HhL6UfWKhU8CPeJfbZVLfP9syDFc
 sE5Ibq/CIaA3L+bvBnWg3r/Z1taNaoQC/XjJKWbatMMqNKsxgPKu+9/6xKKnkTXgdT6y+IOwFI8
 xVctdrPOwGbwH4KcWtDNbeM2zgECna/lPL3KaqUMRKqAor80qteU/bIyHZiqYAts4u7vGUyAyTX
 6ky7BoNWNGbNXcjWcd6aKwx7GpO5+YtIUr0zefDkZGYh2A5EjURiH3VLnnWpMZP96gTi8uo8Yig
 RE9vL0Ct1m19bxTgn7LIkeuRCbkAGk2v9ePguWWq3Jeqc7tBZ2y+S/yrzRDd3hPmGK9zqil2BIC
 RCwTMg/4/1UVwMCCft7U=
X-Google-Smtp-Source: AGHT+IFy055IFoC0KQEcA7p0yd7vu8ee4QXrqBEgiSf4RDGttBxj+E9p75FvGotLxKcVIX2GjkZBig==
X-Received: by 2002:a5d:598e:0:b0:391:4c0c:c807 with SMTP id
 ffacd0b85a97d-39cba941808mr964267f8f.53.1743724944480; 
 Thu, 03 Apr 2025 17:02:24 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a9da1sm2921791f8f.22.2025.04.03.17.02.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:02:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 37/39] hw/arm: Build virt.c once
Date: Fri,  4 Apr 2025 01:58:19 +0200
Message-ID: <20250403235821.9909-38-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Previous commits removed the TARGET_AARCH64 uses in virt.c,
we can now move it to arm_common_ss[] and build it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 7eb49c7327f..c46e5036722 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,6 +1,6 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
-arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
 arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
-- 
2.47.1


