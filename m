Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CACBCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJc2-0002by-CU; Tue, 21 Oct 2025 17:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJbx-0002at-BY
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:09:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJbv-0003YT-7n
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:09:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so37950955e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080977; x=1761685777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMuddOKDPVxf+VaI6mjyNul03DXjnU7YZmJIUNGSfXo=;
 b=zKuujR2xFnbCwMh9tJsW0QRHT6AZ2qly8j/lmlqmP5hQNPg2ii5+MbiJkrz6w0SqY/
 A8AmffGjI57xX+ZZijddZKZ+VNfwtomg0oNEJ4/QnVpYaSCel7pgNNZti0dIh398R0Ho
 u/dCkqwceM/GC/XnSs923i/mJ3ZU+AkSytIbLNxzH7ccry2n/+APjGsqEKFcu46U/VlG
 eJx5r8QIyzaDclsLgfp1H1Rah0afS02T/2GUC1yHgJLr0YO3JQJz2dkg25eOtX4rTR2z
 2d0uGglVC9GUiKca1Qr/ZYv14d84AMyzRk/Dc3gyV2kKEJ3ws3I8ZTlDKUm4sDq/VZsQ
 DFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080977; x=1761685777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMuddOKDPVxf+VaI6mjyNul03DXjnU7YZmJIUNGSfXo=;
 b=uaeio6gkXB/gtVzbz6/GqXlJhOSvsI3FN11dI6KmJHrYI9m1G4TmBuv/BQCQs7yAOo
 jCqBgMXpj5M9U4ohkUDvibyU1GOvh9/vFM1E4lSmcXtSnTwIvFgLznSzwR/Wrb4MFFRg
 v7ExGyf/Nl5dqSvAG8qCPiHjNYjPxjnMdIqIZsETqnlv4g+JvU1jJnWyky5iNTDKNQtC
 hSSGrvYfNZrsE1gl9uJ0Boy9WeNbLSPtxUkD3blv85Ze/KfzQ09fHNG4h5daECBVhbs3
 zqgdgyWdS8Z34Ndx/U1oesJZ0dTiVaUndj2Mf/ztOEaHcCfyyuMIQj78MtrftxUDKqEQ
 9KTA==
X-Gm-Message-State: AOJu0YzzOr+ICjvcSjKlKhJb/a6jyGGNNU1az3PD90AuPhHmp4oLy6jt
 O9rkhVI5YC2eCymzQAp60Z6QrZ14OQKEyVfrSEg5r7kmA3DGQToFl0PInQAT8udn0gz9j/H1UOh
 oZG+LDvQ=
X-Gm-Gg: ASbGncsasKZRY41wcRj2sS4aqjFTI8h9oraiNrxL9fOnaMWlIDnooL3zvyqm5vZtDfF
 tjuUsj180JI3u3YA6KM8mHFQ0xR+ORPUKWsVP18aXP9WAF4lbmEYonKyTv3HwbyKGSf+pADNtko
 xqil6rgazkcVlXIkObfrsBg/DDeh25FadQJNOys58WiI5BbA/3+wOkbtYulSIsZ8L6bTkKJzx9b
 5Jm1d624lmOaxQVfQwNqloZ8qL3yNRdrfXWzUL2WiWXRmuMUFn/7pnVlY7pBiG/l28cTyjNhxmw
 fsU2SMXkfVxOpz7iSWTNE2KWQPNvIcA/no6ISGdT8VS2mQs98EMkUGSqWb4Mw2CPKFEEiqUCwms
 Hw/HBLOfyspG5G74AMMxB+3VFOacpbiR7TUafgE61BuOkDELn3suhqmcJZAI4W5SQkkKgxoHeG8
 98lPs5GtbDi9PfJkJtRv+4BTrZfGFOSrZ3ot35kdQKLVZJsyM9P3XLRgR27R9c
X-Google-Smtp-Source: AGHT+IF3TVP6Zsj6tly1fMq3qe+EuRCKyf5MkBa6Mwu9qTMQR+FiigrK+RoCyVb4WMQNJwOnw7Tg5A==
X-Received: by 2002:a05:600c:3512:b0:471:12c2:201f with SMTP id
 5b1f17b1804b1-471179134f0mr156183915e9.32.1761080976699; 
 Tue, 21 Oct 2025 14:09:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0ec2sm21795748f8f.3.2025.10.21.14.09.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 14:09:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Luc Michel <luc.michel@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 18/19] hw/arm/virt: Build only once
Date: Tue, 21 Oct 2025 23:09:34 +0200
Message-ID: <20251021210934.60483-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Previous commits removed the TARGET_AARCH64 uses in virt.c,
we can now move it to arm_common_ss[] and build it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index df4c1be3b3b..9fbbbc9a6fe 100644
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
2.51.0


