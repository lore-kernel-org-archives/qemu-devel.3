Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2006C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYng-0001yE-5X; Thu, 01 May 2025 14:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYn7-0000Ar-QU
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:51 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYn6-00089d-1y
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:49 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85e15dc8035so45428839f.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124666; x=1746729466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tug16kX0HED2B7MwReNyhMxMcx758vAMRXpHEaxoLXs=;
 b=r2z6ks27SK4Q1t+i4QjMnyAA1bSf+mM1rUb72C1Htf2XZo2Vc82Cz5rMNvHloN1IA/
 kDEJ9pud/uxO/lBTJYnfbhp7aQPz8tWHEOsPjio6EBGUE/2bK9YNPfLHZ/j2myPB1lkS
 BTSMZqMs22wIAQOGJKRPe5rEjmBG3FFM9f46RaWyIy/OJ5hhYVq8KXmCHiGyksh/uznd
 9v+kgQVcjJmgHSepTeGMPwcqgLSweQDGtZzI9qPNq1vNh0/omWWvEamE7SKkK64kuCTs
 ZSHV3qeKwSCExbWs9iQXn3MZpvqdkD1Whear97EqlA6eApImLHl3Z/QXZQwsFUzs809h
 PhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124666; x=1746729466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tug16kX0HED2B7MwReNyhMxMcx758vAMRXpHEaxoLXs=;
 b=fUcI2LM9NHV9hvBupkfPM/4q+5vlgjoTQ1EVYpZ4KH2ry5J7xq+vDtao9OY6UxPfpC
 xWdEHSu2xNedNohq11uAxRetfbBBYu7kuPmwcuHaIoW/RqI7sAA0oUnNpwEeX9HElNVC
 sFuDKf6F7YZuE+DAW5LkMjefVa57NpQGLvS5IkdvTNeFGkSYeWTq6xk1TTNWDwtru0KF
 RQLsCKvJO1hCHLe3q2+4pq4RAI9tZE/IS+59U+XkRnE/Jtd/DnAN85I01L2poom61jLw
 z3T+mkeiEDLhQZNsdyuVkoL5BcMjqgqnMgPSF2Q6maPTwg2n7VpNWmzAwTeQD8rxgKrk
 rkWg==
X-Gm-Message-State: AOJu0YyGoFCJMraIYx2pHhTfIjhqUEO15vHUDrl88P1ioQyaTKmL39rF
 BczU5AsBmpfccnE8Jib2BxD04nigWruww/B4al9nTMSLUep+cTpZt2lt9RYRXqSHlEmty9vcbJ/
 P
X-Gm-Gg: ASbGncvFyLoViAznEJ2Gl8FKUAhhmkyE/ROaE7Z/wvEwqL6Nb7lmFygZlNZ1hC2Ds1y
 wGOre6luujO9ysaDlkKtSwAhqsGvwp42avHGlUyWqkom7VyMZIdsyLzOAVkegx+4sb+5hCQ59Pu
 ZYSQqbrlIQEQxr3MMtpsLJrlWjl0LAxgx4WHJWdNW3mBoddaT4ISn7fI038erYq6Qo5U+QpY3Qy
 SXsZ816ZACb/9cfx/Gf+1Gl2RVpFqfNe6T7hM3TNO4OEdOIMQD8t48xWtCR1UmNsxvx/R1mMg98
 jCl/sie+0hj4ou12AHrF3I8vzHplSU5a0bK1Hs0ruWeDLHmRV7l1uwfgtzaDbxeV7aQGnfR66Cc
 F5hSURAcksrEAsdaR3pkh
X-Google-Smtp-Source: AGHT+IGLdrDh/EFV7xYz800MCeK/LqZ6lioiDcjBesr9uJhVyUQdhZ1V7YO0/f4AZ5hH9K832oEHmg==
X-Received: by 2002:a05:6602:4a08:b0:861:6f49:626 with SMTP id
 ca18e2360f4ac-8669f9adb4dmr38788439f.6.1746124666305; 
 Thu, 01 May 2025 11:37:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882fc9af6sm293583173.100.2025.05.01.11.37.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:37:45 -0700 (PDT)
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
Subject: [PATCH v2 08/16] hw/i386/pc: Remove deprecated pc-q35-2.7 and
 pc-i440fx-2.7 machines
Date: Thu,  1 May 2025 20:36:20 +0200
Message-ID: <20250501183628.87479-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd34.google.com
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
 hw/i386/pc_piix.c |  9 ---------
 hw/i386/pc_q35.c  | 10 ----------
 2 files changed, 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 98a118fd4a0..98bd8d0e67b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -755,15 +755,6 @@ static void pc_i440fx_machine_2_8_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 8);
 
-static void pc_i440fx_machine_2_7_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_8_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 7);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b7ffb5f1216..a1f46cd8f03 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -648,13 +648,3 @@ static void pc_q35_machine_2_8_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 8);
-
-static void pc_q35_machine_2_7_options(MachineClass *m)
-{
-    pc_q35_machine_2_8_options(m);
-    m->max_cpus = 255;
-    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
-}
-
-DEFINE_Q35_MACHINE(2, 7);
-- 
2.47.1


