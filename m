Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA08CC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs1F-0001VD-TB; Wed, 21 May 2025 18:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs1E-0001UW-5O
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:36 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs14-0004zv-3X
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:34 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso6858657b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747866864; x=1748471664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEdpnrBOTPtpx4cupcWYpTpp82dk3nMUunAlRdaZgS0=;
 b=rnwccpqwyshXOHmOVwHIRvJqqBTo3EeTAnj0vI9yErL0UuuKpbTGH952D9QHmCIzv5
 eoazqyXpQ01S3ux9gtKDlgwvfeNAPvgLHvmhEFYFy06nF/2BF8XDHbFj+KYaezYPDaPL
 lny4l7UZ8IQHciUyOJg4Dccbz15oiHej32vbCUQVI7xAUzdgmZGYHAtc4NXmBmovNogz
 /0QXFPMB0eeYo+0Okz/42x9Pq011zREU4+pSukkG5Y2bwG3Cp8078wFn7uu2zlMBbC9M
 +p+iGZhfJVrXnFRwSKeuspDs7xf/f1nqk7gROeAP0Prs7oXRCcSUNgFLE0PDKi2YlUlS
 ztOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747866864; x=1748471664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IEdpnrBOTPtpx4cupcWYpTpp82dk3nMUunAlRdaZgS0=;
 b=ce1aDBkjwzGIw/NMh+M6r41vX0vjB1uXiSL5pfHJWiHpz62LIKlDf4/5PiU0/iLjnc
 /KCU6UOHAbauD0vSbRYF9OcCAB+oPP/vRVAKkJWak8DCyLshUNtyFCjtlgmROuk3YPdN
 7sQV1s7lIJN7SZavI49ATeXh3ta2WpP4gvCuJAN9tlcPH7kYdrScvalK6TK7+JOrjrTE
 fWa3OoWhldncK2reMDb1Gbwt+NyLzt52kDjWloUYwguiepfeCLUVQzKxdARgemHEsHUm
 rMtPeAlaSQBHmd/xPUkBgSmA3Aan8W6lZQfrbysMah+A7N/dOVaJob1vZtO7wK0lg2Dk
 ao1A==
X-Gm-Message-State: AOJu0YyCOQEYgLrPb1eCTJo/m9wflj5PbfrD+/U4igFA5QqUDwQ3TUZ1
 4ACSeuSgQc0oq0ghSMk/ExhrWnnOB9qtJFMmBZrlC6FE4XqE99+05aqNYdEDlXqOTJp3eYW3vXP
 c4xiE
X-Gm-Gg: ASbGnctu96/QbsxOHoHzzZey45ddvo9iZFyZiX2l1+I6dTjCLWGz/Ier+FjZPUp2OAe
 GYcL7Ule8SJnJlpwSKmyG5FlMg2PcqLT49x7mohdz7OvTq0t2aVnFIUodzdWIg+53LCNUYPlaCW
 TmTrlqTqFd3lP9n/sq5VxzEbRxHJvtXeKd8hgKeeNEeEwcaIRxjM4dPrfqoN9D5BGwEgc3+iQMk
 gF0GZ+63h4g5HIHa5ukIYkX07FRF4FxdEfVsysiRSz0h0kxGMt6pFFjVXHO5IkrU9J7Mq0yRPT7
 ifo1pCmYxExwdWI0861iNH7yApDIQ4S4llEAArn8SUbc8syLRAA=
X-Google-Smtp-Source: AGHT+IFdjnunZiQIyzgsaHRZc0F/SPWogZJpIGtwKYfkKfkd/u0QhNHZIQuXu/KB5R5fUNpHzORwkw==
X-Received: by 2002:a05:6a00:1994:b0:736:4d05:2e35 with SMTP id
 d2e1a72fcca58-742a99fc950mr29699507b3a.3.1747866863720; 
 Wed, 21 May 2025 15:34:23 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf5a31dsm10165224a12.2.2025.05.21.15.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:34:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/7] hw/arm: remove explicit dependencies listed
Date: Wed, 21 May 2025 15:34:09 -0700
Message-ID: <20250521223414.248276-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
References: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 5098795f61d..d90be8f4c94 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -8,7 +8,7 @@ arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
 arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
 arm_common_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
 arm_common_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
-arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [pixman, files('musicpal.c')])
+arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [files('musicpal.c')])
 arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
 arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
 arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
@@ -79,7 +79,7 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
-arm_common_ss.add(fdt, files('boot.c'))
+arm_common_ss.add(files('boot.c'))
 
 hw_arch += {'arm': arm_ss}
 hw_common_arch += {'arm': arm_common_ss}
-- 
2.47.2


