Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1615BC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvat-0007TJ-Sb; Fri, 02 May 2025 14:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvaO-00060K-2C
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:18 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvaL-0005bP-8T
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:11 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so300216566b.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212285; x=1746817085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zGgsDeHzR+ozHnHRK5ouuBtclIGW7njUHY2p1Mlkmk=;
 b=WRbewv/4rnI876E3WCc473i2QMrEVJvs7IMiaRI8p1f9NsXAVZwPjrnJEhPbZe2sbS
 qSgdJPYp96J5pg3gCQ/yxhj0arLelN2JhP/GDaiVYXFbmKbng6zKV3Hk7Dfe2HjaCR1D
 12QCsCFEIbPEt46959FcTHZXmJ86R9dWdsrAMxqVzQojP1qgmn670a6ZGxLBVLZ6HYnf
 q5iReID9lElcbvLI1n66c7w5X+6cx2ji61+vuTu14/SAN4aVeEygl80BiA4zyNzkIehr
 jmJncVoRrb8CrptSpcUHJkModEmqceRRn2BtilZE7heOPQbGU/j7xifkvZGh2cYJoWLX
 3jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212285; x=1746817085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zGgsDeHzR+ozHnHRK5ouuBtclIGW7njUHY2p1Mlkmk=;
 b=PwTAoIrFCp3KVkoPMQT6yEuH40Er33bE3szq6LqNcyCfiUrQjC5Wvbd64SF8g+1GgG
 Na/cUvwDXbqgkxxY76I2dt9P8AekRiB3QiBVgtv2UrOzjgt0bHkuKZbOa+ibvRF5fB0W
 wqcC+tneUr8xQkC9UyDsryiSUtMMqGQTIchCSSPVC/raGSs3gedbAS9zCELU1dfOPK1Q
 sbfrT+89ifvzaFuY1kLWCuJMC+8F1AQQ7DPzYV4zRH40RWvJwFai9plCM/I0gJnhLN7E
 rMz59xVJGjk422Jp1Vty1GwQmvmvOmjJeUorLKKXCzt7dVqob5C3F2WZsibECsw8Z7XL
 w8Dg==
X-Gm-Message-State: AOJu0YwJxj1Qhk3OKPw9lZnXGZ/Gx1aY8ohrxQc1T5596LaaAt+pnz9T
 GAo3O+ukQG1dL0pFzdbvmEXrY+wTK9pPO/i/mqHy1X60xowD0dc+Wo9oMAvvlxIPnE8OQ5CamJW
 K
X-Gm-Gg: ASbGnctyIlkdNmoLtCXliVOWrzPv3VRFauSEX16GjlurEhYgB5fsSwfTs6gSbzoLjpH
 5sAC3ABPu/jlOqX4a+uQu2TQHZzPGEogeKYC1etM5TFzVHLR+eqbdRnzlOUkI7ppkc1An+HBR7j
 R81P42Dpwp0l2OqtakHQ00FvWo2SxY4g58wKlXTUTC5sUgzYOC5JNnoKWFtd6LmyWVYB3+7RG4m
 dIOPGEiWJFElpPkZ2JBkwsel3KAr2iiJTYQ2XZZ0+LC3TfvStZ8TqbNeJnaPvTTCOf8G6whx6VG
 Ta3x7IiYDuPVR36dZZjv1Z46DmxKvpEtBJwA6GBpyArdv1B4eV9kQq0sMGHRxmb0HRX1j5F0m4P
 jo3S94lf507gVVwlhRyIgW9I8Clo6fdE=
X-Google-Smtp-Source: AGHT+IHuewecNhKn+5x8wx7OrZUcoS+mC0F1oMn8QJbesC07AuPkhqyEdQ28kbVcwJm2Bb3V98gbsw==
X-Received: by 2002:a17:907:3f9d:b0:ac4:169:3664 with SMTP id
 a640c23a62f3a-ad17adaedf5mr416356766b.33.1746212285509; 
 Fri, 02 May 2025 11:58:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad18914733esm85933366b.33.2025.05.02.11.58.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:58:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 12/19] hw/i386/pc: Remove pc_compat_2_7[] array
Date: Fri,  2 May 2025 20:56:44 +0200
Message-ID: <20250502185652.67370-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

The pc_compat_2_7[] array was only used by the pc-q35-2.7
and pc-i440fx-2.7 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4fb2033bc54..319ec82f709 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -289,9 +289,6 @@ extern const size_t pc_compat_2_9_len;
 extern GlobalProperty pc_compat_2_8[];
 extern const size_t pc_compat_2_8_len;
 
-extern GlobalProperty pc_compat_2_7[];
-extern const size_t pc_compat_2_7_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7573b880905..ee7095c89a8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -241,16 +241,6 @@ GlobalProperty pc_compat_2_8[] = {
 };
 const size_t pc_compat_2_8_len = G_N_ELEMENTS(pc_compat_2_8);
 
-GlobalProperty pc_compat_2_7[] = {
-    { TYPE_X86_CPU, "l3-cache", "off" },
-    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
-    { "isa-pcspk", "migrate", "off" },
-};
-const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


