Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF9FC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1UF-0005eP-FN; Thu, 08 May 2025 09:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Ty-0005I3-Hk
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:40:21 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Tv-0004Rd-7u
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:40:13 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22fa48f7cb2so5971365ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711609; x=1747316409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8Pwvw+j4e5J09FPHtAsan2JUEBLBE3y7JNJd5PTK2A=;
 b=FIr8rXowpQIUXzOEZdUGYb58XXuwzHw4cT0VouJvTE324WZ94CAzqFN4BH2oJ3V5UB
 /1DzrTBfgVqBejhToh4NTs/v9uC8Io1py9wOX2dMoK3hEAMXwc8RfsuJwZyIkpGUscup
 VRzeCG1T6YcPgFF/kUiYvWjTDZk2FkokiAQA1/KnUXx6RXthXV2bO/uLk3jozNiSdvL5
 g09eKet8+l/rJ+QxhOufHii//S/HDHNwsguHw7CxjvSn4J+5hMM5h4/RUpfUx8aOVUtu
 SupR/q/RhddYpAFviWn9IeNMnX0t4uIwJuwsa3Bf9VYTiW7xD68UpXJ9af1j8ItVhQ84
 rXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711609; x=1747316409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p8Pwvw+j4e5J09FPHtAsan2JUEBLBE3y7JNJd5PTK2A=;
 b=SY6aS79XLDo4OgpHQdufIJzhMe/ntdt8sQXawL6iVfB6ocO2hYo0CtQAyFPnLyWNE8
 /CTExc0GiCW0dh9mnkLpO4dh2OV4UATyc02HTheUmEsbkm8VrApTO7RZrsWGutfKetTX
 Sh1f8jZoRqH1SIiBYa06fkLYOvBncerfa28W4SXcR6Ns+031AgSA7OK+bF7JW2mPPEi/
 bx5LIu0O2rpQy0Bbs7wkjmZc0dmUjUkjZLE+A19JqLsFHbaXgxs9XJXi6r0XCt/l5r/3
 bjifvNqE8jo+8isN2re9rxuYvSDGBa4rg3mLXOw3UdpMtzgCKuZ6kCyV/AXtzJ2/smYg
 v75Q==
X-Gm-Message-State: AOJu0YxC1eHUW9YjKpG52WkUl8X3dul4ksm1BhCELXfvtvuvjzOywuds
 uX91SQw+4HTppgnP1WUX985W5qQWj3/O4xe1hwCaJvt8uzOzfQSdj1FdY3jiQXWrZP0+M0YuaXR
 3GwP41Q==
X-Gm-Gg: ASbGnct7RA03sqBg3Z45BN9TtSqK/xX/VlYNWbsM4onsibjAOp4hRItkp7S+QQe2zi0
 ECrWmjeSu253xp/ss5Q8JKALY+IZJVoyDGFO95gEKEHvy5GvimFSvkG0EIvcUZjFkEC1mDZCSp1
 o95K0hNIaQtTPI+9HZ7suIMY4QnSZU3dD2OxqnUMqT1VXbl/FQ3HWRy5zKXyPjkVcAAj14fhg1f
 F+PTd7H8UwkwT1owtwIM9RIEJRSzD1r1GlYhby8oikJEfI7lszg47FWKM8h+1BGRzIjdU+QRNfD
 HKbDzIFUNIRA+yRAZ47GIx2rlHyjOCjB822ItlkGkJbzAsYaari70/D7T7kOgbae+S+2k7jfeJq
 ZZDNqnHiFa5XQp9A=
X-Google-Smtp-Source: AGHT+IEHNU51J756smrG33Ll3fKAa4cINEE9vVGIcVFbaMYD4LmaTKtFYWOJts/yoYULQ+dhKo+C6Q==
X-Received: by 2002:a17:902:d50d:b0:221:78a1:27fb with SMTP id
 d9443c01a7336-22e5ea38b30mr113474455ad.11.1746711609535; 
 Thu, 08 May 2025 06:40:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3b62502sm11305764a12.32.2025.05.08.06.39.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:40:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 11/27] hw/i386/pc: Remove pc_compat_2_6[] array
Date: Thu,  8 May 2025 15:35:34 +0200
Message-ID: <20250508133550.81391-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
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

The pc_compat_2_6[] array was only used by the pc-q35-2.6
and pc-i440fx-2.6 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a3de3e9560d..4fb2033bc54 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -292,9 +292,6 @@ extern const size_t pc_compat_2_8_len;
 extern GlobalProperty pc_compat_2_7[];
 extern const size_t pc_compat_2_7_len;
 
-extern GlobalProperty pc_compat_2_6[];
-extern const size_t pc_compat_2_6_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4e6fe68e2e0..65a11ea8f99 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -251,14 +251,6 @@ GlobalProperty pc_compat_2_7[] = {
 };
 const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
 
-GlobalProperty pc_compat_2_6[] = {
-    { TYPE_X86_CPU, "cpuid-0xb", "off" },
-    { "vmxnet3", "romfile", "" },
-    { TYPE_X86_CPU, "fill-mtrr-mask", "off" },
-    { "apic-common", "legacy-instance-id", "on", }
-};
-const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


