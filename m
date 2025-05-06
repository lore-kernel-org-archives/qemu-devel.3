Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07BCC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJUk-000196-5q; Tue, 06 May 2025 10:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSh-0007Xv-U7
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSb-0001WP-Bs
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so35729305e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542391; x=1747147191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0i+gB4qGYdD+t3Cj9VGzIhWK4paiq4kBCZvxw2YhKv4=;
 b=REai5aO3dhTbWXYJb7yE7QzM/PHK1ALrqmNcBwuAjCIpwiYEZArKXztJuktcHcK1FV
 qIxQrgfxyBLvAU1AZr9cI7fWwOSqezsXopLLUHuHTHKDXGvBpZRYRrbZ4W/7qhD8oWlb
 DO8NG2B2T6/nVPN/PHecKmEcaSScddqyMdUNnz43FsiVCRn/iJsT9nRk3IYOGhr/RUuk
 TlrgnuzWtVDr38wp3rF0+K+YBnc3Q+kbIRo52w7X9V7Krgt4/2PU9nUz7CLgo7pbsm+x
 QiMARyOVub4obi18YbfltPunea+rxEAJeDDmLIFj9WvqRLEBdYhaAa5/LWkY0VxtSyIm
 rOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542391; x=1747147191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0i+gB4qGYdD+t3Cj9VGzIhWK4paiq4kBCZvxw2YhKv4=;
 b=NdNc9jPrgU5CZmUoganAD0baSHWghd854coHJDeNLILuwEFHF5oxyVf41AFDBpdhLr
 coYAvSOT53XEUBRLdGjKv6mM/bRHrMQXqkIdvxN95ss3e0Mk9OSdsbeWiOmdFDeWGgWK
 T3hWZA0WJlqcUmi4LJ7+scYMednnI7F0hzSU2gg26wGXIKL01CEscHV5iNXQ2WZF1/ER
 ZW17p5bIJMkfDcxuFOiPRi81eEHjfAAE9YwGAEvIoWWWnuhtKYgceJnNHPCeVPRK9juX
 Xwr1bR2t3tvcEpvISawygppAmIExo72dEZ7U580L99vN4I4yCVQLOAPrjyleP7xunOD7
 zV6g==
X-Gm-Message-State: AOJu0YxvFmSdsdp1MjoKHNsVbTm2kZ8/fMl6S7HMZgzy+m5+1k0IUwsO
 APSqyyrzWDC3naJqHIloZ9DYvMycJe/tSF0jLwX+fE3fJkq+6dRTNiV+QnbhJnnV3cyh1i/pLsH
 z
X-Gm-Gg: ASbGncvl2bajPnX+U8zjHL+3ReNZipMesS5jNFta5bL7yitNJ8uDVNeEmklxyxDl+ak
 7hBOEeK+gIlqxMJQ4evSY4PMPutr///qi8wnaTCPcDpywpw5ccqK1l9UBisssUyR44Uv2ZxzJAR
 yCq17VxJgPdIfTZlWmi0MVcn/ZuA38vdaOah5AURYd9K0kg5zvIPxupK0WwwEAG5QHRpIuq25Dn
 3EH5+6f5JRq5nMO2DbvKy61HRRftsEZwzroEafQ81yk+3NR+SA5J/CBQVuHwFhGrc9wBgcJmHaO
 2X+S8cofNiYxE6+vrejPOPcCAELJ29U8/dJmFUciKmvSggl1uRRyQ2ygNBlmVxoiAmeiQ0HlLvN
 h6MTJe4KOPkLp5zI34K1w
X-Google-Smtp-Source: AGHT+IHZuexzZMSHe/rNrNPdbhfswXCX57ofFMmXPpBa9kNugHJlL2xrhjXO7b3mfQddd17/bWIwwA==
X-Received: by 2002:a05:600c:35d4:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-441d3a6e140mr138565e9.10.1746542391279; 
 Tue, 06 May 2025 07:39:51 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a2874asm170469245e9.26.2025.05.06.07.39.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:39:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 09/19] hw/i386/pc: Remove deprecated pc-q35-2.5 and
 pc-i440fx-2.5 machines
Date: Tue,  6 May 2025 16:38:55 +0200
Message-ID: <20250506143905.4961-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Remove the now unused empty pc_compat_2_5[] array.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         |  3 ---
 hw/i386/pc_piix.c    | 13 -------------
 hw/i386/pc_q35.c     | 13 -------------
 4 files changed, 32 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b34aa25fdce..79b72c54dd3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -298,9 +298,6 @@ extern const size_t pc_compat_2_7_len;
 extern GlobalProperty pc_compat_2_6[];
 extern const size_t pc_compat_2_6_len;
 
-extern GlobalProperty pc_compat_2_5[];
-extern const size_t pc_compat_2_5_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2b46714a5ac..cb375aabdc5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -259,9 +259,6 @@ GlobalProperty pc_compat_2_6[] = {
 };
 const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
 
-GlobalProperty pc_compat_2_5[] = {};
-const size_t pc_compat_2_5_len = G_N_ELEMENTS(pc_compat_2_5);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 04213b45b44..7a62bb06500 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -778,19 +778,6 @@ static void pc_i440fx_machine_2_6_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 6);
 
-static void pc_i440fx_machine_2_5_options(MachineClass *m)
-{
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_2_6_options(m);
-    x86mc->save_tsc_khz = false;
-    m->legacy_fw_cfg_order = 1;
-    compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
-    compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 5);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 47e12602413..33211b1876f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -672,16 +672,3 @@ static void pc_q35_machine_2_6_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 6);
-
-static void pc_q35_machine_2_5_options(MachineClass *m)
-{
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
-
-    pc_q35_machine_2_6_options(m);
-    x86mc->save_tsc_khz = false;
-    m->legacy_fw_cfg_order = 1;
-    compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
-    compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
-}
-
-DEFINE_Q35_MACHINE(2, 5);
-- 
2.47.1


