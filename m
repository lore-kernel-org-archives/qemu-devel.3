Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D03C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thacm-0007S5-8d; Mon, 10 Feb 2025 15:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacf-0007Cc-Dt
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:18 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacd-0003g8-KU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:17 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso2115330f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220194; x=1739824994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=164MJWJMM4XF5ZTwp3LiTfxGt94ljlFDi9lBlhGSKKs=;
 b=i4gWmIS+FmyYSdXjemmR8Cm9KJWeJYhIw0O7JloFQil1P4XwGC78l0il/gaRzfmSp5
 bvEM8sgUu4VpUC9UqfGyvp0z9ZmPwrkUXZ9uEYCAmpaWihw2stpOXwVmpsEp73I4HDni
 tMTO85bsaIhYj6dzzeLJIicskeQw7lZBkT0gx4jrJ5SMGTODw3591KCqn+4qQ0279rga
 Hvqw1apPgRvTeL7PfOi86/42D3Y9WKma2i748ghTcO/N+sRWOV55TbQHqpxUN1WPPBKL
 VUeLwF5wwNZExCatifIyDWp7IY4o/hyKXrMTZOF/Bn/Z4OUQf0+60sJlZvArnqRi3zfN
 Dg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220194; x=1739824994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=164MJWJMM4XF5ZTwp3LiTfxGt94ljlFDi9lBlhGSKKs=;
 b=FQ4XtvOoGPb8FEed7Ks7f9j2yJSKZrvEHF2zRIK2KHUxcYWEj3d68X7P8EDUDO3lk1
 8naPi4tmuG8hv8aFtyIDeQGPWIFrMw20E66uGnkLgGsAkU6QFC0IW95aAF+ADOMb/WJs
 UQ3wsXFhi/StySMQyCEK48N10tTOGHASJzY6rqeFTxiQs3xDzSea7+Uh6U8Gq20rnuc6
 4/t+kmWZKe3DsD4keqK3hdo5zAKpa+1YvcR5oXbscjAbFDBNBiOPpphV9yu0cewkJumv
 SKrFWBEQdM15Ep62dxmZCdNQQ0dPMVdzUKya63tL3DUFei1+k/gRYYqkxopVnJzyBEK0
 4bzA==
X-Gm-Message-State: AOJu0YzKuQv/7Nsvpik6Z85wrh7gp+zTgdBea8vu4Cng9fEFImZ74K0N
 bqkY198Fo4hLkEs2v5EvyF58aEnRuIDD9gMSo3sT8Pmk/vpo+qTHS6+Rv3Nhc0JO2Fry79qGcZF
 RR4k=
X-Gm-Gg: ASbGncsE9s09bcLAh2AnoC6yejeQUOCYjeE0ZKVOPFHS/hAkY++ejijEY/tmeIWX6kz
 t0m3VetXxKogFzTS9bXL9+ZEujvmaoVnmj5rLIa/izSrKRivpemAUWjMArCw4ZU8xXy9CWJQrbF
 NyWsgs1cSksvUOleNtDkEJO8OGH+KQf2RQJKsIYXS6d/DAUn1jv/Vm6tdELAPii02Fm68S5LMik
 qEFe+zN5oeXIcGsTk8xnnrj+a3v3KD7xCaMMN+zOMqg9GrZZVeAhtN984rhA4A+obDzMizAeIns
 oWSamy/lqwYShgqC4+apIBNcLtahR0XPSMGad0D9L0/H2Vn0tnPAgsbKxh880Rmn4A==
X-Google-Smtp-Source: AGHT+IEQyCDA17Rv1DgYeW9fS9OghSWSHQOiqaK/1t4gRdiEU7CVLYGq9Xf3vKxGhRbcJERxvY2uIQ==
X-Received: by 2002:a05:6000:156c:b0:38d:c88e:d57b with SMTP id
 ffacd0b85a97d-38de43e921fmr588013f8f.26.1739220193397; 
 Mon, 10 Feb 2025 12:43:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391d5283b2sm161645935e9.0.2025.02.10.12.43.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:43:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <graf@amazon.com>
Subject: [PULL 13/32] hw/vfio: Have VFIO_PLATFORM devices inherit from
 DYNAMIC_SYS_BUS_DEVICE
Date: Mon, 10 Feb 2025 21:41:45 +0100
Message-ID: <20250210204204.54407-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Do not explain why VFIO_PLATFORM devices are user_creatable,
have them inherit TYPE_DYNAMIC_SYS_BUS_DEVICE, to make explicit
that they can optionally be plugged on TYPE_PLATFORM_BUS_DEVICE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alexander Graf <graf@amazon.com>
Message-Id: <20250125181343.59151-5-philmd@linaro.org>
---
 hw/vfio/amd-xgbe.c      | 2 --
 hw/vfio/calxeda-xgmac.c | 2 --
 hw/vfio/platform.c      | 4 +---
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index 96bd608b8dd..aaa96903db0 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -41,8 +41,6 @@ static void vfio_amd_xgbe_class_init(ObjectClass *klass, void *data)
                                     &vcxc->parent_realize);
     dc->desc = "VFIO AMD XGBE";
     dc->vmsd = &vfio_platform_amd_xgbe_vmstate;
-    /* Supported by TYPE_VIRT_MACHINE */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo vfio_amd_xgbe_dev_info = {
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index 87c382e7361..b016d42b496 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -41,8 +41,6 @@ static void vfio_calxeda_xgmac_class_init(ObjectClass *klass, void *data)
                                     &vcxc->parent_realize);
     dc->desc = "VFIO Calxeda XGMAC";
     dc->vmsd = &vfio_platform_calxeda_xgmac_vmstate;
-    /* Supported by TYPE_VIRT_MACHINE */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo vfio_calxeda_xgmac_dev_info = {
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 1070a2113a1..f491f4dc954 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -672,13 +672,11 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
     dc->desc = "VFIO-based platform device assignment";
     sbc->connect_irq_notifier = vfio_start_irqfd_injection;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    /* Supported by TYPE_VIRT_MACHINE */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo vfio_platform_dev_info = {
     .name = TYPE_VFIO_PLATFORM,
-    .parent = TYPE_SYS_BUS_DEVICE,
+    .parent = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(VFIOPlatformDevice),
     .instance_init = vfio_platform_instance_init,
     .class_init = vfio_platform_class_init,
-- 
2.47.1


