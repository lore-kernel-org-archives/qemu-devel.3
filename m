Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FFCC3ABAC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb5w-00011s-8a; Thu, 01 May 2025 17:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb5u-000112-H9
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:22 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb5s-0006Tu-UU
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:22 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85de3e8d0adso34150839f.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133519; x=1746738319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGgUb/s2/eo1hN4YzKtPUZJhBvJN/kDbmTO2X06CYEM=;
 b=lS7os7SOjwVWqKVql0zxfpCbVEbZbEKXWhQkEDtvbzsTjiLKuUyR8ECdK2MOSnqFDK
 FBChmQx9KMAExY019UJ+A1XGtBbM+UIymMuL3yiFQS5Fq6gLytNH+Zzx9jlMKkTe2HhS
 dUhFg69tDI3wau7oHBh3T0W89cbqBUkYIfBQnV4qpOUVbL+55fZB3CGQfsWcT/Z6qiL8
 6t2QohUYy2HTTQYDHviAJNq0duU0utN+ZkC/Y5cFpHHxh/BnyKpWUGOs8QHfqwoDb/K1
 DgKm2e0agVbNvOa4e087/N5xIrxV0SOLxvVEuyFMtf1vkCGReVVvsM5LCyHWVCpGq3Tn
 bW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133519; x=1746738319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGgUb/s2/eo1hN4YzKtPUZJhBvJN/kDbmTO2X06CYEM=;
 b=v2oDoEXemnIFm/TS2pR+WBU7lfmuGcfI7sDGdias6OxUJ6HyX1sWXJHf7kwNwV6Ogi
 UAAmtea0OqbMJjK/7XJulWN/uk+vbkm8+/sDrTwhWco9EWDp14L9qb2E9EBVloymn2pY
 lN36jy9xlLTpKeye/huPpjxUm1yBsvEpd8+omHDt73u7ZN/KwLCPSDfBxXDIKaZ6sJ7/
 viayJx0rGmTg7ft3jQt3dPUzujK9nixVoq/O87K/FX2O0344psdDbywo9RcgdUfDPpa6
 T0UDwYHa0Iy3fmrVAV9c/oqesqfVoUzKvbF2lQn5TlHn+xyU+/4Q26vG8O/mXdPpgLWN
 uFSA==
X-Gm-Message-State: AOJu0YwoldterA74gjGQjLDqSizaJmugLUDDK195JUMPJwYaAfV6hquT
 lj1KZXuT4UDyCbC7MTbHDDF0LntMT23Ew2ZMoeEvBCQ7dhqF2xlWl55ZDYI6gSj8p7u2orL5H50
 q
X-Gm-Gg: ASbGncujd5rzrs5CHVdzLDRAGPUMgSmcuITJ72OySHx1rgWC8S6DZqejD0hRFBewzKC
 2s1ly7mWW52HRMcSlfuAhXf8zRxdJ6wJ6adQhkGRp4Q4VFqSYwh4zo2XOTaR9Stk6QWfgWueWD/
 AWj0zGKNzfR98TaaAHlItyxxAveQ21YCPayV2dIPhejGEiyTWg9pPwDDzGJdf/jt2jEHbm69jNu
 JxS/fyP7sB0obeKc7ay150qCpsLnsb0iegDgWVUWXJ2JdiH9ZngI2M0B74KRTR5l0Wz90hRVTCE
 YAI4B09zwaxYR06LwiLsyy3XtQHQRmKpznms5Bh7Rrcs6kxCzWc9SnWzfOWb+ZPXpPMnIb8W5lw
 0U50Z4Z9LkdFDhN4=
X-Google-Smtp-Source: AGHT+IFLuaXtArgSY3YBEgqFVrTiKi3lDR2E8JAjAA4haw6eZEILkWHq6r0elrGKn/D+5sVPHQoTPg==
X-Received: by 2002:a05:6602:7285:b0:85b:538e:1fad with SMTP id
 ca18e2360f4ac-8669f99d5bdmr118117739f.6.1746133519384; 
 Thu, 01 May 2025 14:05:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8668c2ee05esm6459539f.30.2025.05.01.14.05.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:05:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 02/18] hw/i386/pc: Remove pc_compat_2_8[] array
Date: Thu,  1 May 2025 23:04:40 +0200
Message-ID: <20250501210456.89071-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
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

The pc_compat_2_8[] array was only used by the pc-q35-2.8
and pc-i440fx-2.8 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 319ec82f709..db02cbc0d65 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -286,9 +286,6 @@ extern const size_t pc_compat_2_10_len;
 extern GlobalProperty pc_compat_2_9[];
 extern const size_t pc_compat_2_9_len;
 
-extern GlobalProperty pc_compat_2_8[];
-extern const size_t pc_compat_2_8_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ee7095c89a8..5f07a44d447 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -232,15 +232,6 @@ GlobalProperty pc_compat_2_9[] = {
 };
 const size_t pc_compat_2_9_len = G_N_ELEMENTS(pc_compat_2_9);
 
-GlobalProperty pc_compat_2_8[] = {
-    { TYPE_X86_CPU, "tcg-cpuid", "off" },
-    { "kvmclock", "x-mach-use-reliable-get-clock", "off" },
-    { "ICH9-LPC", "x-smi-broadcast", "off" },
-    { TYPE_X86_CPU, "vmware-cpuid-freq", "off" },
-    { "Haswell-" TYPE_X86_CPU, "stepping", "1" },
-};
-const size_t pc_compat_2_8_len = G_N_ELEMENTS(pc_compat_2_8);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


