Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7752ECCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyEn-0004re-Hi; Mon, 20 Oct 2025 18:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyEl-0004qw-Ko
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:20:19 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyEi-0007SF-P1
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:20:19 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so2848417f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998813; x=1761603613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EtYIMO5sWrEWTKJE1qtRKCFCaiepVkx5pq0F7e5w8lY=;
 b=rYMzYD+3Ahs3oqAlLssxRoAGIPcfRgT31EM7eJnWCji50b7WvpCUxlskgM/iasVZC9
 NE68+vaeZDluvJubW0xk/oZ8bYgZTzHPqkFSIfEHWeBJASDNm96AFlNJNO459ZmJ6uPl
 dCd2yrzZpTYDVQknyMKdfNGqu3jlmNzH9P+M1RNgAuC3ZzYRGQVSb2wUTbSy6vx7E3fp
 XccEMWFEFXz+slyXzkBWn4Mh/Pfn81wyzD6SxF32pzilbRT26LnePdiL2igRcAPHgK9f
 8vlFUjq3NxuIOAEC2PLjx7+UKfQHuATVwK/mKxHPYBvI88rH08+uQggDXY+HphrkwAD2
 IJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998813; x=1761603613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EtYIMO5sWrEWTKJE1qtRKCFCaiepVkx5pq0F7e5w8lY=;
 b=EOV0NseC/5Mt3rKrpQz5lppe12GdNUs1JXP8ttz+mMkvA35t4QqIwWXxU/JGrM+G7r
 ACLOuDSAgYVLex0GlpnrY96fO2SrN88Bu/UYPpXujdksfAgghSNctr7gaiaMOzMfHHjH
 6DkN20OUlCuvNff4tlgeFuXy+O2lR1hLC5Sw0f8FSnkajBgh2BTBPG+tRksNbns6AmIa
 MaVemaVoyyCSfNmmeJb1bLg9IZzonCxXQRUWmSqPIHB7kmO2q4E291vayzylhBIRVk8w
 rvcY/DA0+qqX3Yg4zzCjuu5jm7IFyi3xDNeR7OO7JjfwTabZ8Bn11VU/Ql5DDFgy8A52
 ug4w==
X-Gm-Message-State: AOJu0Yx7HSUz+V0jzzvMZOKhW5PStj31i9sx3Br9lroOkfhQ3nK06bBB
 Phab81McYOZOL32VEXYB3+XWxLan40gr+T9/INwgML5qeQjXDkAb8yxqCL8MIQJ+l3HCy9h0Hz5
 lP0R/cbk=
X-Gm-Gg: ASbGnctB7xsgl/D/3Jmk/qv2cVCtduVNcW1AnnLl7vdYgu+oNVG4lxTmPF1AW2yGnqA
 HgB8PL+5YiM+BZSEhLIsyhNB8JWy6LqVDUKorfBI9zANieFzeBqKI9hTEF957qBjuVvfgrkxSC6
 TAlDzgoIogd5TBhRaOLT94/jpcVTbWvjfYt61kiuczYVY6IkVI3xdLDxtgbS8aHwL4j3L5Ge+ig
 I1FnR4cj2yfFxvrmLalzXeEwir1oCeGc3/i3KxhVzRQDUqPN1mDACuSTqx2J5wxclDJhAS2PbUg
 0H4WixEToLQffnMV3w6fKyejgc7jtjILdLFk625iuUl7m/G3+Wf8hxdZwWxeTbIMb/wJ6LlekLm
 qyt2t6+wZ+CVsybV17YD1u7VBI6fD8GLynW10Ig9GS0pp6u0PszdgnB6rUHZcLrDvSgTPh4+Xcp
 3F2tMBzgCank+aZeUu7C2Uds3JmFwrqlwLVzwC/Nfk+oWeFwjVgB5x85F7lpeY
X-Google-Smtp-Source: AGHT+IFyd9RXa1atmsam4BG1VsN3H0sagygV8yd92YPfMnEP1+dhl5pyZocHgopbTd+65RZJnMndEg==
X-Received: by 2002:a5d:5888:0:b0:426:dbf7:9e51 with SMTP id
 ffacd0b85a97d-42704d522d0mr8704637f8f.18.1760998812856; 
 Mon, 20 Oct 2025 15:20:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3c56sm17476174f8f.18.2025.10.20.15.20.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:20:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Luc Michel <luc.michel@amd.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 25/30] hw/arm/sbsa-ref: Build only once
Date: Tue, 21 Oct 2025 00:20:05 +0200
Message-ID: <20251020222010.68708-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
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

Since previous commit allowed the use of accelerator definitions
in common code, we can now move sbsa-ref.c to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index a12d690ce74..fbd5e8da79c 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -14,7 +14,7 @@ arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32
 arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
 arm_common_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c', 'npcm8xx_boards.c'))
 arm_common_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
-arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
+arm_common_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_common_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
 arm_common_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
 arm_common_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
-- 
2.51.0


