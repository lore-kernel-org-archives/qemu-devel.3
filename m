Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B94C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvZO-0004Y7-1W; Fri, 02 May 2025 14:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZL-0004V9-2U
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:07 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZI-0005NF-Oi
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:06 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso383187866b.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212221; x=1746817021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QsChSFQ9xfBFOGYiAY/gUqNa+0g2ne7rXsTx8MOyPRo=;
 b=Bgc1uVyYUOUEHezKlKDYH+y728lkzwupDdOXAJWjYdIBtRY5xmLGTl8oh00deIInao
 8NmFVSCwR+g/8G0W+25rGHOfx3QnHG1f3Xww9141M3gR/s559dvTkkTjigs0DO+zSrIY
 9r0E/RCAoESk6Q5b52an/VZvb3Ez9DfYY2jZJC3OqbeqFw3evJRotARHRPxahsck46Ve
 dwZrC45xnPTHOAPb3oGTFDU1KFOeG6j/sYU7Swrxlw93thd+SMzT2ZkP4eKT5kTK+lWY
 YtlxgGKm21SQBuKFfITYS+ZZ9Kn6CNgSVKEe5OwxCbIY9IcDttX4WMYTN4NIGNA3+6Fd
 fDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212221; x=1746817021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QsChSFQ9xfBFOGYiAY/gUqNa+0g2ne7rXsTx8MOyPRo=;
 b=D8JcST/aAmR+HspwKGH0WZ/IXeshgir5UZUecNu3lMUeRdkYoJHJZc7vceG/2ALFKV
 JdA6ebwaoOjMKkJgz7JZI0TTK9+v9IqGVnsHD0eFu/PqJJG4MyEchuNGpLM166Y7oGnh
 anh+raqreYFS5Bts96J01d8u4mxGsZrBMI+0pvl4DSf/m0eeSERNDiekg9LYrS1+RIkY
 BYgluQVXvuK7zPCjNg6Fl8LwIS59dRAFL8KZowIedyTqXa3vCngJneYg17eLxLsq/lVd
 0E7a4pkKVbfIbxPySiLK9AiZh5OmxbBsL/0ZjiIAaOyJaeOyBgB55Czf9AarXKUWVqGc
 yznA==
X-Gm-Message-State: AOJu0YzWMFtjD5qd0Gcv0UnAKZuE+gNnpACUKBZTSutxy1gxnskHelNh
 vbzBP9zxxogrzimUzjphhw8BZpivBl6yu4diP0G3dTC3jHSgm3aqVZz6QfEwm7UG3n72U8mTArV
 r
X-Gm-Gg: ASbGncvJDAOlTcOm/74Ilf4YGMj+gMj/WGCDMxJlrQRDEW2vmonf9P+g3gPMP5Y3D7U
 2KLWm9frAiu8UiDIZPOLm8882jK/vOVvh06LygQRU7JARhoCq0SqWL4BWN/Wkd6fIIJtv6HIC7D
 KoFcJEzBlJ0iqQwQzMMpGuSW9rxJposRm42OAeDwI4w4Azy2VZvtqpj/lcKdpjDqUBSjygrXnnl
 6gT3/d3+ItUI5h7yK1zCoUVbU7AEtjoA7rl974+QDjYSYudm1+utbwccJTnQM7KZUWXxygXtf1/
 opWx8Lsjd3VReNgMedLT5sANFMzFq1gn5OmRTd/375tfPE8z85AKpPjs1ZTBzUejQYIJxtcnxbn
 5PjNlXoKKhsPmEUIVtBRo
X-Google-Smtp-Source: AGHT+IESQY8qEcZTdZKHVXc/Me5NPYRFcc9Vdmdab5vjHAgBJKpE2/yPJAGaaytJrYSVqamnSOFt0w==
X-Received: by 2002:a17:907:7287:b0:ace:ca87:2306 with SMTP id
 a640c23a62f3a-ad17b5f27damr382895366b.34.1746212220734; 
 Fri, 02 May 2025 11:57:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c29d3sm84586166b.113.2025.05.02.11.56.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:57:00 -0700 (PDT)
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
Subject: [PATCH v3 01/19] hw/i386/pc: Remove deprecated pc-q35-2.6 and
 pc-i440fx-2.6 machines
Date: Fri,  2 May 2025 20:56:33 +0200
Message-ID: <20250502185652.67370-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 14 --------------
 hw/i386/pc_q35.c  | 14 --------------
 2 files changed, 28 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7a62bb06500..98a118fd4a0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -764,20 +764,6 @@ static void pc_i440fx_machine_2_7_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 7);
 
-static void pc_i440fx_machine_2_6_options(MachineClass *m)
-{
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_2_7_options(m);
-    pcmc->legacy_cpu_hotplug = true;
-    x86mc->fwcfg_dma_enabled = false;
-    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
-    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 6);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 33211b1876f..b7ffb5f1216 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -658,17 +658,3 @@ static void pc_q35_machine_2_7_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 7);
-
-static void pc_q35_machine_2_6_options(MachineClass *m)
-{
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_q35_machine_2_7_options(m);
-    pcmc->legacy_cpu_hotplug = true;
-    x86mc->fwcfg_dma_enabled = false;
-    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
-    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
-}
-
-DEFINE_Q35_MACHINE(2, 6);
-- 
2.47.1


