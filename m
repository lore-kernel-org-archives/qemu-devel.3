Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F4FF41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcuV-0003NH-MX; Mon, 09 Mar 2026 11:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcuR-0003Ky-2B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:52:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcuP-00087H-AS
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:52:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso119541225e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071556; x=1773676356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dbkT8Ir/6ERT+BlEo9AWddD42Sjvd+yoa66xU1i+ei0=;
 b=ZSjoxE84tsxcMam+j5bOAXP8b28I/qeUvg/Be8av1Zo2drCbAs2/6+JpWopZHtXXSl
 O10L7LAq42WV2gSND3gSGBCv55YEIbnWiINgUmKJsJPIMuzh3j14D15jq53TMbno1vPw
 9m+qC2PmwQ+WOT5b+TVHaQrp9xYDDMsOWXKrnPJlhW59J5PUWwgSZ+cNMjXOMcfT0ZX2
 ekP/xzV7j/KKklcOCkPCg3KOcjoc6YovA/y/GACv6Ywo9c7XCNTL35b6hwDbpeVkpU0e
 budtsIaPb3uq4EzRqh5u2g+H1+MH71NS5mSa5cN5T3nCsY+SGEvex5OIBztpeSPhuouh
 ymZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071556; x=1773676356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dbkT8Ir/6ERT+BlEo9AWddD42Sjvd+yoa66xU1i+ei0=;
 b=wmfqFJLGstrZo5BIRkarYA23XJKhyTgNkz2LwNOc9lggCvD3SY5fJu0Y1cma7h2sQC
 nEApS1tLvBUX8N2FMi+I5UxezWefYYTevBNk5v7Q+kL8GS6ii5IXvapiuEAUVyV9Qz2m
 pECCr3u3ClfghV8vYntEcOB3tA6hk2onEk+DVNjT1b1Akd1T8+EYK+zHUZSkv/LIsVGg
 uukk18VwZlWNSn7pa2incO1gGG0MWyvh0uh4YmdHkt7G4R0w6JeTjyRPl0F7yahGmbbU
 ouSGcY/Voc79xkScgB0Wtji6CkWahD3UFnxY+XSxhdiffyHnsdxvKCz4InRgT1yEx2fo
 t3Zw==
X-Gm-Message-State: AOJu0Yx8ayH/I8bG8rCn2JcxZcBV4V+wqUhLwWJAJmsTC0MEfaDvqm2b
 fq5ifngSF3JrpSGwXACZYN76JM7qj8MV5/WihJbZU39axT57reFI4Zs7CoyCAUgWH8+tIYEKmEs
 1iNvXMPo=
X-Gm-Gg: ATEYQzxzguKDIbHLH0YQRhG81OGFb2FA9OlfvNhfgnwuEMua5fxsH7iM3HWESeK98i8
 tPh5P+EonXvFW7KNv0Ng+v/2k6DXliut6pNqFM+Vdelo6L6XmXQlz1nJEuJMX/dopLtbTQ2Zf/j
 TGKS46JY548KTROVqzQsZaFcYN0h6y02kXm1i3mllNdwzFFbEA13U53oLs0UmHNN3082CD5IYUH
 8jYGupU1b7hnLcnv9nKugZ4ojyr8xodmJZw3r3SV9wbyKqaNz7f1ryiaG9X9BJ7P3NMQXqzO9s6
 2aYt7OzUcF8C9uNL8MJKQQNh+ytUVXMKWv+hYvZwIAAX8SwfoKO6s76fZYTu64WKGR5IZKWa4T5
 fifWhe3svVVMuVpo/RYbCxKVcC8XVRCcjfIx/OBL9kQh/6u2QzQcGz6KRuj+uR2BXzCz5GXSrlr
 UA8a2j4RzBW8HgHZ43Nl2lj2R3vAhwkDXrsVhjuZvImv/RGpSWbpIPMTzJLOZqJWo495K7LARh
X-Received: by 2002:a05:600c:8b53:b0:485:3b33:f4b6 with SMTP id
 5b1f17b1804b1-4854192dd55mr2123945e9.0.1773071555652; 
 Mon, 09 Mar 2026 08:52:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237e8095sm166780205e9.2.2026.03.09.08.52.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:52:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/49] hw/i386/pc: Remove deprecated pc-q35/pc-i440fx/xenfv 3.1
 machines
Date: Mon,  9 Mar 2026 16:51:32 +0100
Message-ID: <20260309155219.62400-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260309145013.44327-2-philmd@linaro.org>
---
 hw/i386/pc_piix.c | 25 -------------------------
 hw/i386/pc_q35.c  | 14 --------------
 2 files changed, 39 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 29c8e997131..2b94c472446 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -655,19 +655,6 @@ static void pc_i440fx_machine_4_0_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(4, 0);
 
-static void pc_i440fx_machine_3_1_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_4_0_options(m);
-    m->smbus_no_migration_support = true;
-    pcmc->pvh_enabled = false;
-    compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
-    compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
-}
-
-DEFINE_I440FX_MACHINE(3, 1);
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
@@ -679,16 +666,4 @@ static void xenfv_machine_4_2_options(MachineClass *m)
 
 DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
                   xenfv_machine_4_2_options);
-
-static void xenfv_machine_3_1_options(MachineClass *m)
-{
-    pc_i440fx_machine_3_1_options(m);
-    m->desc = "Xen Fully-virtualized PC";
-    m->alias = "xenfv";
-    m->max_cpus = HVM_MAX_VCPUS;
-    m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
-}
-
-DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
-                  xenfv_machine_3_1_options);
 #endif
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index f102da8e4a1..52b8064b4d2 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -600,17 +600,3 @@ static void pc_q35_machine_4_0_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(4, 0);
-
-static void pc_q35_machine_3_1_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_q35_machine_4_0_options(m);
-    m->default_kernel_irqchip_split = false;
-    m->smbus_no_migration_support = true;
-    pcmc->pvh_enabled = false;
-    compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
-    compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
-}
-
-DEFINE_Q35_MACHINE(3, 1);
-- 
2.53.0


