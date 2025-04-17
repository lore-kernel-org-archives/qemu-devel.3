Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B810C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 23:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Z7u-0006tU-Os; Thu, 17 Apr 2025 19:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z7r-0006q3-Ti
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:35 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z7p-0003oi-5U
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso13835605e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744934308; x=1745539108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MV1FxMb+Pm3l1uMqumgJWytel4/bj0k8yst6ffjyOR0=;
 b=t0xiYozBzTMuov5PGC9MpGUqtGqdEcfwRROyHss3rW2xuzY+G8CBzsUHm7bHtSmE8p
 HGQc+415tfVEOlFAmgBxJgZl1Ytvn4Xx/QCjC2OcjpaEks45JmTBcA6j7LHj/VvgJSkV
 x08nToDXtabnyCpS0XkaaRjkCXqc34BzIlAtwwx73p95SmwmDIZmAdJNbqrjjwItXr0R
 jm7MJXt8w3BhM9eD7KSxRdoejBjOjZjCH1uLxiC7z2MMiDT2MG0ntBkdydDu5tIKkU17
 RA4UKPb3rSX+lItCV2mUHA6xfcs8/VkNRe6a3Nl8BRZrdF785dxINKInFUJ01cOQaNks
 xqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744934308; x=1745539108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MV1FxMb+Pm3l1uMqumgJWytel4/bj0k8yst6ffjyOR0=;
 b=wovSzhi2DuAzJMBZ2le0OS+dGrGtSrkQ9hS3ZF4xAucnbjfxtNIMWK+XNAYKiMy8hS
 LkW4rklR40xN9WkV/uVxLlyifd6P14nbbJTvInFepqJytw/UyVLWawt4SYY9F1NZF/XS
 X5VRxyxe5Qs+q2MvNLsLn6TaelhzAVBkITdVKcZtd6zWMj1qHMta7esYIMU3vqYkvWoz
 6kqLV49ECXp5RN2TbbTBUPEgpK2DH3DlM1dtBWzWAXD44ANoNKvAciiED9v7TYF4GVdK
 ptNS5EmfzGSvqA10qDA6RGIccVTWwRT1EQrvH/PekWd7r5p0+gp240YaJVClaqd1OeEP
 Pn0A==
X-Gm-Message-State: AOJu0YzYV62jcJXwwXvyMa8KfmxzNA2MHJ2QXxk4DdSnBUkdvEfvnAoi
 RbMvwRlIioIcxcxI9vGo8Br0jg/RcVXnsGjnxPWUtMwUyeEyxhZHnWl3j0SFrE3HkJrlEXRgPGJ
 j
X-Gm-Gg: ASbGnctUaAN4X3IFhcZBbhSEeR+eo4QgkDjJeNmEamyN7YgAYhHRqbrs90+NV9YWQFi
 4JRqG3nc7AGIi80+cNS95S1Jy0U5C1eFHKoKLq3dTCnp++K1GjeVLzynQF+re5LBhaAKuWJjtUz
 h81zq08lr736vxkjvnuYe5zFoiZ+nuHkRBEkJcOv3bZEbFa+3tO6LKmU/Glo1CpRXRU0B/P2uW+
 /+gwQUB4A+ccKedejC+nOpY/TKYKl0BZGG+qlNgfE4nsgjCoxU3VYF33ZpkCAGgRG5xcT57fkxW
 FUJRCKrZVyeHKFneB+hYaodpNsC0SzeP+HGu0h/y9ZW+L35Nl8hhyuKcDrTquGaudrbfYMSLC1c
 VBNnyfGuGucO08VFWa7X4
X-Google-Smtp-Source: AGHT+IHoz2/LtVvIzf7wgC51R392OtB198utmEJV4FXBc0I4gOys0jI/hKLPvMu85Q0gjG1GVLpmvg==
X-Received: by 2002:a05:600c:4ecc:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-4406ac17729mr4620585e9.29.1744934307991; 
 Thu, 17 Apr 2025 16:58:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44034fd8f37sm66264105e9.0.2025.04.17.16.58.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 16:58:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Felipe Balbi <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 02/11] hw/arm/bananapi: Define machine as generic QOM type
Date: Fri, 18 Apr 2025 01:58:05 +0200
Message-ID: <20250417235814.98677-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417235814.98677-1-philmd@linaro.org>
References: <20250417235814.98677-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

While DEFINE_MACHINE() is a succinct macro, it doesn't
allow registering QOM interfaces to the defined machine.
Convert to the generic DEFINE_TYPES() in preparation to
register interfaces.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bananapi_m2u.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index b750a575f72..724ee4b05e5 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -125,12 +125,13 @@ static void bpim2u_init(MachineState *machine)
     arm_load_kernel(&r40->cpus[0], machine, &bpim2u_binfo);
 }
 
-static void bpim2u_machine_init(MachineClass *mc)
+static void bpim2u_machine_class_init(ObjectClass *oc, void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a7"),
         NULL
     };
+    MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Bananapi M2U (Cortex-A7)";
     mc->init = bpim2u_init;
@@ -144,4 +145,12 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("bpim2u", bpim2u_machine_init)
+static const TypeInfo bananapi_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("bpim2u"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = bpim2u_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(bananapi_machine_types)
-- 
2.47.1


