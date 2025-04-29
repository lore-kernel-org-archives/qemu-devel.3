Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476FAC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9leA-0001wC-2v; Tue, 29 Apr 2025 10:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9le9-0001uk-5o
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:17 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9le7-0006Ny-9x
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so57378335e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935753; x=1746540553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0i+gB4qGYdD+t3Cj9VGzIhWK4paiq4kBCZvxw2YhKv4=;
 b=AWamMWcetZW6oWOSg6f+eiFcrLXxTQS65YvJ7uudA9xkmVl94sHeuYBP9jUae1NkeO
 9/26/1mesyVITacWPthZts7lqmjH+Hjqqs+/H/VTmQ1jHf3DPv4mpJZzEtb1OwumSP9Q
 CxdiCprJL/EZ8HMduF56aK/4MqIc5y4oXEs/eWPKHy8taM0K4KSMeLIIQh6iAPlmnRKY
 mI1KpNjZo83dyRl51a7LZeXuu/pniypxk9fjDCeBhzlSmUV3oYfsiPCRmNMqpV03oSu5
 f/w9Uh+uvIzyPs5N3MMohfKs6Tq5tDtj9zTpsztqW3Ydi4a+11G7VCHEFhQJOtS3Jtk/
 wgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935753; x=1746540553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0i+gB4qGYdD+t3Cj9VGzIhWK4paiq4kBCZvxw2YhKv4=;
 b=wVbeoT7XaOz1h9BWwfINe45ur8qj77dZeGHVFC9nBDxVcfH0iEWE4amaoVN+z+ngQa
 77yV0ZZJqrjvInf+2yfz7Cx4TRFyBPjKajmxR6ipHBuKLUUyGs4cHA55pvvZQqFFckuO
 JPtBonSIK8vHb/V/nW2FtO0BBxtTpA+Dv6RQr8WyP1G+/ss6qaKXdZQyB9cwHO6CZ38b
 ODk8fuvG3GlezQcfYllZvqRSYit9my3KLPYGqKr3JBamQmIWdNU7lUefPXQLo0IV0t06
 FBm0relHSrK6itKX5+wF+A5wsBu2PAwKpIf8F0NV4GWmhXSh6aGv92Nt45xbSCqCmKEN
 zd2Q==
X-Gm-Message-State: AOJu0Yy/EiYcTdhcbqyO6OSAxGtxQL9siPBov1Hpbb3C/9iWPcOVwGG2
 mk8PMyanzgPBCi4R7199O3Ly/K21/Ejd5NVkazGIFsddoN/cLrxOtwxl0+DjmCx2iGEv891T/mg
 s
X-Gm-Gg: ASbGncuZO+JZ1Vct+P1zpSzCQoduV31Xr9YGZKnJ6Wb9gWafkrfVw+ILELdjaXlVYc+
 Gq0jIym7M/P9eJe3a5b53qpfefj3+ZXwFVAp65SU8XJ/m8QTR9vofbgrsCm1uhKHMBraBBsCBg6
 DESGnieFQEzGOTZpKtJKMY2PSoHvEI6PTO1Sxe+CuHIdes/KwjYLeyDwaGtLic4zVQffCH4NnfK
 xgHrBh5s/NHp7gaCdHkLtiXGeyJIrP+ZQqRlzRnvctS+VfZUlKGeYrGEZEvXBPP/YPWQrRNccAl
 TaRR+WuVuRzetbdTfOW3cCkcCVY8WwVK9fwtZeA5bqnBAh8RpiNfodCwxezJ3OSOE0PB41lFKI7
 7AnTq4PBPSFLIhJUwLqnWpIrf4/AkVDo=
X-Google-Smtp-Source: AGHT+IG0V+GEcw6tH8VrFu6UE4V9XaJvTJ1AeqPT4BaeV0LcbmcXUMKqgC2UkMSam2yLpr77TdqwpA==
X-Received: by 2002:a05:6000:400c:b0:3a0:88e4:3d2f with SMTP id
 ffacd0b85a97d-3a088e43d58mr3313540f8f.5.1745935753110; 
 Tue, 29 Apr 2025 07:09:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4742sm13810924f8f.23.2025.04.29.07.09.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:09:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 09/19] hw/i386/pc: Remove deprecated pc-q35-2.5 and
 pc-i440fx-2.5 machines
Date: Tue, 29 Apr 2025 16:08:15 +0200
Message-ID: <20250429140825.25964-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


