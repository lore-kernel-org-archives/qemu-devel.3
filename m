Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1037C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcVS-000255-Ru; Thu, 01 May 2025 18:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVM-00020p-VB
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:35:46 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVL-0002u8-2a
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:35:44 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85dac9728cdso41573739f.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746138942; x=1746743742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iciK1Ov3CYYXIv04KWMi1cwVSHb7UpaXRa3iCf7VwYs=;
 b=y8hmRsLgfZoEFrl6qZmNo6i9N/Q5Fka5GLKCzc5/BhcjrjaJ/jhq8ezjrLCH1Eaclt
 jaHYi4IpE/4dNOOip6v84/Qv7RXE4BoEs4li5Ni8XSqvXFJFxiBz6tbFkna7K/0mqsvK
 SMKTxo0tETRm/qUMAQe/3Vr+YKAyyZWoM95PrrdANM3Hqs3Pq3ZQ+OMthzt1AmL1BzzQ
 Aru0i8eaaIvf7kjrLjC/4GHzCuSgL+nTwfO10ldKa8qg+LqVuYRtUHSKm+wiEuYduGMQ
 +SPWlTyGWmRgA7r1Avqeb85CLG3xmxknyyE4GdLLMp81v/8X20+lWbzmlFDv0KHVRJLj
 orLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746138942; x=1746743742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iciK1Ov3CYYXIv04KWMi1cwVSHb7UpaXRa3iCf7VwYs=;
 b=QosDGGwZKAOoO6jgGC7iT4uswFijdC4+05F5ZPUASq2hopwFxwzopUSD6zNUbMgjdc
 xAJ7mlLRf9AZMVBtWMXwZZGh0vx+TToaFriQyD3+4m9Mmi7Ij++spRM40XXWdpZLJ90W
 WAwdNyOCDRkF0Touj70g6h9XzhqwlrAYKyzTjl2M7S2OhEcXya0EZ1YJRkhOmSeRsc6N
 CR04SxemE+fcga0kvRccW0CVNgzAWFT0efGA16t0JdhrlS2VANSOoIEWJBPaBrgMdUbR
 3sndiY9zN/c7ciT+acUKrYfe0TN08pH71QNa5ub7Yg8fAfFOQ4uOJcJ4a/uEOZVaWBPY
 vt+A==
X-Gm-Message-State: AOJu0YwQjIWXOxAc2d/H+Sj4o569X8KN8ob/vUDF/EEg73dmyU/aYynX
 vbkaxVq0WokmWC5TrLp6Up6ngeiNc/2N0z5wcT4kgVW0O+g1tDFcoF/yGb+l4OTyP74BI90+txN
 x
X-Gm-Gg: ASbGncsO4Gz5swmDFvEFj7jrfJKzviFWcO8eaedJhvkzZxmzzhz/9K+m9Lnd6NrYHcm
 xYkyRT/ZA7Wcm3foZR0A3A04030nQHWzUAYNDcV5XEq33VVX+U4HI29NmW5THqdzk3WLym4QJLT
 XcHuboknuR9AEibyzrucMsy3JUI9qHndyqMSqoQS2/fuiOKm+hyMKO10aA8MBKqSKR7vCLvHmKx
 bYXWi9Qyrx6A0iYC22CMWh9lrG1P4g3rQIgkD2EoXB3K0RC2qosCS2cJXlUj0ivLhN+Ju9jc5/h
 W62HeCkoZHSYEMx2lCwornQWevl/+XswSOTW/fW3G0E3atsPjDOECUiI2QqDq+ufda7/rh7d3Ud
 oLM2g4BkgNZgFLuIjA93h
X-Google-Smtp-Source: AGHT+IHX/IandFkHY35LvqYasl909p0ZLJ0FMOCj6a3RtdevwQfeB8+nU466lxSi+9GjC0i0GCWBmQ==
X-Received: by 2002:a05:6e02:218c:b0:3d8:1b0b:c930 with SMTP id
 e9e14a558f8ab-3d97c129edbmr8841825ab.5.1746138941628; 
 Thu, 01 May 2025 15:35:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975f58f5dsm3271765ab.57.2025.05.01.15.35.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 15:35:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] hw/i386/pc: Remove pc_compat_2_10[] array
Date: Fri,  2 May 2025 00:35:16 +0200
Message-ID: <20250501223522.99772-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223522.99772-1-philmd@linaro.org>
References: <20250501223522.99772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2d.google.com
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

The pc_compat_2_10[] array was only used by the pc-q35-2.10
and pc-i440fx-2.10 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 7 -------
 2 files changed, 10 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 455b869cce9..c27ff262033 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -280,9 +280,6 @@ extern const size_t pc_compat_2_12_len;
 extern GlobalProperty pc_compat_2_11[];
 extern const size_t pc_compat_2_11_len;
 
-extern GlobalProperty pc_compat_2_10[];
-extern const size_t pc_compat_2_10_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 298091932ab..d3e38cf9f92 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -220,13 +220,6 @@ GlobalProperty pc_compat_2_11[] = {
 };
 const size_t pc_compat_2_11_len = G_N_ELEMENTS(pc_compat_2_11);
 
-GlobalProperty pc_compat_2_10[] = {
-    { TYPE_X86_CPU, "x-hv-max-vps", "0x40" },
-    { "i440FX-pcihost", "x-pci-hole64-fix", "off" },
-    { "q35-pcihost", "x-pci-hole64-fix", "off" },
-};
-const size_t pc_compat_2_10_len = G_N_ELEMENTS(pc_compat_2_10);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


