Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6FEEE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voThF-0002su-IN; Fri, 06 Feb 2026 16:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTgA-0008Nk-Qo
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:55 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTg8-0002nO-KQ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:54 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43591b55727so952173f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414471; x=1771019271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKnWqMlFdhfT5+UmlR1BBig60NqWA7q7tTMMaOLNvRI=;
 b=yKMoJxyz9opXYrKq8+0WqLAjftzBOLBO7XrGhMP3OKL7evxkCbCNPzC/E1Yp+Fl7VE
 hyBUGfFJpmvqlFCqivu6YGL9pFdxGUKieTD/n4F8CY2QX6PjP8jQR5xKbniIDLEvqA4z
 dGylTP43JvvpmI+bCbHzSawjKztioGR3D45y+KbIH+DhQ6XnF4SMIP2T+WMoQoStt6Kl
 ZV9pUUxQNKt81mcI1PM4RglOP1i+Su1oS9eOVQDrP57XhKngjce2Vr4c2gakFwCehfFu
 uVWV1UH+sElitMf2reDh7Fk224PjDF34OXmUWEpW0hnqW0teTef3zQsUAlja9ida2U1k
 gamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414471; x=1771019271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKnWqMlFdhfT5+UmlR1BBig60NqWA7q7tTMMaOLNvRI=;
 b=q59mzd/oDCsAwrT34XETweE0Vz850tcERKT3dYM4klFIarvWAy+AXEDaB8M0Cg0yZE
 X8eUzs/CAmXvQneq6nBl208eApXaDG/L2OorjEIl51LyO77X5KLoFKAl9Y8fTWWbNhb2
 dIV7qsMmBCZGBCDxVRov62jqAvmzoiDLthKJSmjfFjco05BWw0cDcatAD33+iYtWiKiY
 pKNRt5bF3RaIkmmUCnQ+ltBnW05YTPN5tzr67dQMTnZwGw5Z1IaYIG60k1YK5d4Z0aea
 1lGKdrza7WTXG6lL5HK720I2OIVU0MNbkZFOg126t9g1nA4j+S/qHKV/OKD+nHt6vq04
 ed0w==
X-Gm-Message-State: AOJu0YzghKeyhCxkIZOBK3DueAuBliCoDYciU9/3MarI7h4XZKN/qEBH
 nBFfClt/IlLKI3S1E0xBbXHwiM64lfiU7KImPOvNReJqB7wHGcFsonsgsSMjGfpzUOpkdY6JycW
 nYxPdHqw=
X-Gm-Gg: AZuq6aIL7gXxXYWUUH1fIobAOIxe4x/Hzv9Nw6djkwGBcMIbyOuhsFK9msZtr+Saq1+
 mBXK29KDnOuBOeVfQGKQWiJJcdp3Bw843Gr2im6rZJJqE4ebSjNF8RG2KYbqj93e7qyWyh2PRUB
 y7Y8OeSJ+JIKhzpvUMZkrcp37LmQF+zThs8r5otIYL32ZN4ik9CCOAdJhiMicDLcOMpJu0UZkPo
 Wetm8O6yUw+soRZEZ+paqQEa7iishuTSzQIlTYOJ3Uckm+bGeKwUWph69CIp0uAChL6fedGJ9QE
 mMrDnKcVQdM954KiKtZnguVyMErFe/BhLOrASzcVOJuIhhYWEJTx56F4/CMiC1Wy9HPToe+5nvx
 ER7lYCJCbGrH0dIVC4XAH8DVOK2DVPEN7SfpFVmGkqyN7Ru7A3bpekFdNRHJkNpxLGBO+pY0ugi
 JP9wXnXEz1wVZJxM4QUWfDThvmhHUogqERxlHsTAMOTVbbdO75GV51jJr1iMBjtFXvWX8tp58=
X-Received: by 2002:a05:600c:3b03:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-483201e4011mr63412645e9.10.1770414470789; 
 Fri, 06 Feb 2026 13:47:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d8342dsm131683005e9.12.2026.02.06.13.47.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:47:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 27/30] hw/or1k: Rename or1k-sim.c from openrisc_sim.c
Date: Fri,  6 Feb 2026 22:44:45 +0100
Message-ID: <20260206214448.22008-28-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Match the filename to the machine type: or1k-sim.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stafford Horne <shorne@gmail.com>
Message-ID: <20260205030244.266447-7-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                            | 2 +-
 hw/or1k/{openrisc_sim.c => or1k-sim.c} | 0
 hw/or1k/meson.build                    | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename hw/or1k/{openrisc_sim.c => or1k-sim.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e973e21709a..29f88d48f30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1495,7 +1495,7 @@ M: Jia Liu <proljc@gmail.com>
 S: Maintained
 F: docs/system/or1k/or1k-sim.rst
 F: hw/intc/ompic.c
-F: hw/or1k/openrisc_sim.c
+F: hw/or1k/or1k-sim.c
 F: tests/functional/or1k/test_sim.py
 
 PowerPC Machines
diff --git a/hw/or1k/openrisc_sim.c b/hw/or1k/or1k-sim.c
similarity index 100%
rename from hw/or1k/openrisc_sim.c
rename to hw/or1k/or1k-sim.c
diff --git a/hw/or1k/meson.build b/hw/or1k/meson.build
index 49c274b8483..a5c23f4f5a5 100644
--- a/hw/or1k/meson.build
+++ b/hw/or1k/meson.build
@@ -1,7 +1,7 @@
 openrisc_ss = ss.source_set()
 openrisc_ss.add(files('cputimer.c'))
 openrisc_ss.add(files('boot.c'))
-openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: files('openrisc_sim.c'))
+openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: files('or1k-sim.c'))
 openrisc_ss.add(when: 'CONFIG_OR1K_VIRT', if_true: files('virt.c'))
 
 hw_arch += {'or1k': openrisc_ss}
-- 
2.52.0


