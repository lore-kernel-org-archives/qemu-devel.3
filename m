Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC94C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1QU-0006Af-S9; Thu, 08 May 2025 09:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1QS-0006A8-Al
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:36:36 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1QP-0003iP-1p
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:36:36 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b1fb650bdf7so559907a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711391; x=1747316191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XP+ZGWOYnOiwfrA3/LUhv7eqSLRqDyC8l2H8ehhMIaA=;
 b=aE/K7ScaiJjh+A9fvZjiGuJUAI0/3374/OqP+zRb/9Td+ff6F49YmgMs5dheZ1rZub
 WNv+ZhwMv2j4C5SJdDlAxbbYzLWgbsbSFUPV3bA3ju7Czww3H6ypoTkO1QNFFHXR0U6w
 v7EzyKr+ePKxDleGqpHqKM09JufYAiQPQ8vdDYnWXwgLeSqoeTziHlD6BlGCGQn39hA8
 SZNyEvhoD7vyqpJI+faHBjgtfxU0JsiAlAZiqoUxHAiSxmu2pPmaLU2QRIrb5/Eag/h8
 eV3fI7Y/R+7AqFsTu9ZYs8RQlwvoOR4kiyvv3nuBpq0LR5Ko71rRIRjilLF6ymMrQdKf
 STtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711391; x=1747316191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XP+ZGWOYnOiwfrA3/LUhv7eqSLRqDyC8l2H8ehhMIaA=;
 b=QWJL1lBojhXXorv60Eo0UrbyqNKowyHFXwcmoINarKlHa+3OYp8L49IFS1cS9wn9+B
 UuZofdY76JAfE78k9/WWdQFxnzMfUs4Ga8Cmdp+5xgthY+6En/TRKlSctuMVS5u4bjZW
 irogUbHxcn52e60Vy7Tae3ku+MH55ckSaqJWB0NjV2PyF/Q67gEnfRNtvcpue0CZYunG
 LIMxlIxuGpO/maFQYhpsOcRF/wEXwYuffRaUnR9Y0WNl83ml0njvbJeqijJSEuF8Pe+V
 HSCGYccjKifvZrlVz1dVQj+KxWYEh9nGoOsuiS0/gB33ForRHW33bH5LbCOFTLn7kZTV
 Z9mA==
X-Gm-Message-State: AOJu0YwwaOYF1wVtcHor3OGJKq46JqV2472A6EzZah5iKbK8HJ49KzsB
 J63Mag9Uvz9jsNz7gs+qXHJEQUyH8GGSEqrE4lg9fjbr6z+uUK5UR0fMcEsbYNORP29ee21Zza0
 +avu9Ng==
X-Gm-Gg: ASbGnctVSCiz5LJk2WYggbGXbmiF3W/kpOHgHDKv0o7bIZb3cR4sST2oLn7OLNEuSZ6
 5bFuRNPSgeS8T5eGoHP1rKRgyCpLOzLP/hKAZMNz3dJ/KirXR4hd5d1eplxmVzM1s+zkSlbQ8Jl
 pv2T7BCLGUpNAnLOhimTsfZkuLIBvx+1HV7T7y91AG2KiPlsGTZQj7GuLY18HW5HwKhkCbhFZnc
 Rk5E/BGQf61CrRCjRYZEZq0xTzcO67whaLa7l6jO/PoTnXHP0HHi6xHg4x6lTT3cy8I0gCHCMBF
 As99YzgGksL08PCAjUgIMURhLk848evLUgcLXdCLa6dB9OQe3kiF7TTynmT4yGfte40eLyv6cMe
 5VBYyvVLGVJWMAgg=
X-Google-Smtp-Source: AGHT+IERcd0wpsVEg7UAq/VxS+1i8htfAwkqBnDOgXkJzjD1MEkNI1SisofAeEu+2dRvjUVX/IEO2A==
X-Received: by 2002:a05:6a20:9f48:b0:1f5:535c:82dc with SMTP id
 adf61e73a8af0-2148d3124f5mr10576405637.42.1746711390803; 
 Thu, 08 May 2025 06:36:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3c6a590sm11373659a12.66.2025.05.08.06.36.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:36:30 -0700 (PDT)
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
Subject: [PATCH v4 01/27] hw/i386/pc: Remove deprecated pc-q35-2.6 and
 pc-i440fx-2.6 machines
Date: Thu,  8 May 2025 15:35:24 +0200
Message-ID: <20250508133550.81391-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x535.google.com
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


