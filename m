Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5572AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOk3-0001kw-Sy; Mon, 12 May 2025 04:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOj0-0007zK-7i
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:30 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOiq-0001mI-9o
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so3598259f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039273; x=1747644073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmmxRVO0JjDAOZF2VaJXzWNNbUhPq/11vrvQt3l5Apo=;
 b=Yd+Ymkg0ZrB8Rv0TUMqTDUcmdOrmmELLc20zAvqLzF66+WCrTq60Pediwqi62CJl2g
 L+1mY5mC7fZFk21wseoLWeE3vq2gGXpwm39Ji4PTytzpDXIJBCd+odvKKyHlSWyuAOAc
 Vbkf+vPsPQWyO+CSsgs8AR+sP0rlXZ99+0cX/FniTRGgXzZM1GDdZ4Te1HxQ+9Yrhgkf
 dX9JWPUZChyzSoPZwb6F62jRDBDQFOdWKPNV2oDoq7XqQZndso+hU1zO5wcIdyD6yVwX
 HSjDZN8yAAd3evKcxxphoCCLwlanIAWW6A29xpbdTpuJmS29mcnmzl6GqJfjdgzIGsDI
 jOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039273; x=1747644073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmmxRVO0JjDAOZF2VaJXzWNNbUhPq/11vrvQt3l5Apo=;
 b=R+C+A7Rluy50mmXq61On6zXA6wms0SB5THU/stAv60+zQFAt8Espl8muCt6JmiJNE7
 hXY7q8hNKHV98QQS+qQt7EVi5pST9lNekAUdJs33pR3QIXpikyTD/r+cIEf6CfPQnDjQ
 kCScCEes9jasbvnLSOZWOlU2N2nqdzWvGG7Zl+WK+/OVopY5WkZ3tbh4z60Fp4fJlbyC
 gQuNCGPaWxsN5El5PRBCqiEnCMYoXvaTixuZjMFuDtNdNhOENPmQTqxHYEFRl/tfTprE
 a1pW7D4zYpEHgblysI4kX+7UAsc228gIxc7FC11azVk7yEToDk0nye71NYGtGX9HWcTy
 bR0w==
X-Gm-Message-State: AOJu0YyqkZBNBQJGLirdIDvP272HWwmxgBJQgzGA2MG1wbR/md4BpaOL
 nJseu1q0VosWUT+6vmFvawsCjC6LN/+D/ZudBU10eofcbp15nkhD8l61/FYdPlpZy8GisZf2dDI
 SI2scjA==
X-Gm-Gg: ASbGncs8MsvAnL0DDJqgg67QUUzZcQFj208YtnNS4jfDK42kx8hkEAjYIpihh5AWVU+
 QzM+nmfeNz0jA3pmlEsonXGn3nXOjcNOObYcKWiByHi1Ksmp+CTxtFgYISUOB2MyI6Xdl8DDRSp
 KRGFNz2SCWNpUuurVUExQ94spp/2qGGqHWaMuKcQex+FGoPjWY5sk8Gu7gMxqAvhIiZwalWTtQ2
 YWmmXc5B0Lu4zzoo/hkSi3IBuesdBDovdp+TqqHCHlDAp4UkAbDTAijdD+cBjsOEN1SFM/kK06a
 1sn7dy0OpO3dkXqgrcP2XNnAVULPl9GRiplK+l7NVEt6GttPbcBCPh62sqJMLkM5zP64YHcrKn4
 RI8lIj0nv3X0Us4K9NghUOVY=
X-Google-Smtp-Source: AGHT+IFFsxqp3h0hfWIHh9th8nQ7pxDuuFj2+3qs0CZo1L8UuMdE0l/zlsI1ppdRq31qYOfHpLJTlA==
X-Received: by 2002:a05:6000:4006:b0:39e:f9e8:d07d with SMTP id
 ffacd0b85a97d-3a1f6437e6emr10056092f8f.20.1747039272908; 
 Mon, 12 May 2025 01:41:12 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2ceccsm11807739f8f.64.2025.05.12.01.41.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:41:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 09/19] hw/i386/pc: Remove deprecated pc-q35-2.5 and
 pc-i440fx-2.5 machines
Date: Mon, 12 May 2025 10:39:38 +0200
Message-ID: <20250512083948.39294-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Remove the now unused empty pc_compat_2_5[] array.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


