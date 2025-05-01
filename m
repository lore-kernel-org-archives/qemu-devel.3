Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259C3C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYnP-0000NN-LC; Thu, 01 May 2025 14:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYmH-0006lr-3U
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:36:58 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYm4-0007uh-Rs
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:36:46 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85b41281b50so43688639f.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124603; x=1746729403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ppxPoByuVGLWvliwBsIadaJ9pT2YSnGBDzsW7kKKos=;
 b=YeCEHs1sam2dJ0PFYaARpBQm5vvL2c22luPgu+7rtqJ7v6OEx4pF0WtJvXBaxma9aq
 SLPfFhYDG5tW+rJ0pOfccXscKUlSJDDdSnBfNpvnooeKaYE/PgRPvE1rw8WLRv4lh35N
 76B4GbPu5S9Nd4vlsr/NmFTIc/VLg6/802HecgqDOvt6Q8iAUwKovmyvBDTYBWSDo4CA
 +YaJ8ezl9ymUAei06AhnUxfBZs4rzwn4t45EwOTapWK8rYZCI+PUUSA1L5vDqr1TZw0l
 uSH+6+qlmboJ0D1BLQMaD5rGX3u19/oJj0sJPc4ebwXG5RD5roO7VL5SxqkVZuwyxKYm
 Vneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124603; x=1746729403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ppxPoByuVGLWvliwBsIadaJ9pT2YSnGBDzsW7kKKos=;
 b=S1zX32GLOveMmmJGunJwmOxdxrBUigD88qcZOH8BXPWfT/5Z5oSEBN8bK6EiL7lAyT
 +BucFNaF+t6eMGXQxS6Qx+9fCvhA1aweYofHdu+BC66oOhAfS0n3DP8iYTN0d0qVP8z4
 ukEK9+w/GmDE92FWscCyW9A3yhjrx15qbtKpM/oJVsSJL6hMXzST3+h/EaJCUn2FpZrR
 Di48mgsXGhq0CsSTl7B8lQ4FjTGhhuqTkl91MHA1tm9OkCqMHRlFgBw2tHpfbp1iDWdi
 haZYkN5tdI0Ux4Fs3592IQBBVoWWk10zxFEBQp+sLJyLlW0gqEsc1sk1hooqwKpqLVxY
 WtnA==
X-Gm-Message-State: AOJu0YyTIHqlE8PuyGbRwKrr89zWSJGR0QKvzWjll13zySua3Hkby69e
 uzm6/GrZRS1uvS1ySKvITwLXl059/wnj58r/cz97sQ5HFItzF1X291ycltyUg+TUVz/BsJi5D1n
 P
X-Gm-Gg: ASbGnctFRSfLy2kwCuf58I/0Gr2cZZvygVCap+FJUUaklGL+erF9Pp4ypnn49XlVaaj
 ppkbPpPNIjO/pRZQhnI2g5k38h0T16yfcs/JBj1LcrsCzDEQIVRY6na4zTR5wJWxh5ELtLOoVes
 Camg7vZObZEUtkhlWw6gqxFV5I9gaTGugRaLMr9R/uYRCq4710AKKMJ/xx0YG1eVpa+HrRe2X9V
 eJFfNCdn4ljY1SolzAs3d1lKUtklh59263ng6LlYQ0224jDGmZX+YFll6fHjwMt6/BCSoloXN+w
 dx5H96T5hZAjYZoBjlf4WTc9rcmUiMsNbD9CpuCMZZYPo9iSgZ8x4PLCZ/X6SC5lrj3qK+1NjsU
 z7LV6a5eBtVnoMOvBBYGx
X-Google-Smtp-Source: AGHT+IEkDox/adfLJYQ2JgU/AdYD+FVuU2ph9ZSnt0DXIPfmiRqwGmaHZDJRFhOMqvmufehOOhvYag==
X-Received: by 2002:a05:6602:2983:b0:864:4a9c:1bd7 with SMTP id
 ca18e2360f4ac-8668c263a5dmr41655939f.0.1746124603367; 
 Thu, 01 May 2025 11:36:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f883014747sm295913173.107.2025.05.01.11.36.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:36:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 01/16] hw/i386/pc: Remove deprecated pc-q35-2.6 and
 pc-i440fx-2.6 machines
Date: Thu,  1 May 2025 20:36:13 +0200
Message-ID: <20250501183628.87479-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2e.google.com
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


