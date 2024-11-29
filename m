Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB97AD6EBFF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 11:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGzNA-0001r5-0E; Fri, 29 Nov 2024 06:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGzN9-0001qw-5r
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 06:41:19 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGzN7-0005hH-2A
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 06:41:18 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a10588f3so11139325e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 03:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732880475; x=1733485275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/o+BS+OcIItedzzG1AU2rEt3OTvDpG5A87iPkWMu5Rw=;
 b=df1JmmMwvVSrqQaIZXpUB30wyDT4TgznRFB/O5vJ+wIViPgZEqMIwdOlB5Bb/6NAKs
 GSxE4k4K8MzCW4Q8AcFsM5htj5blWd2ktPmJKdBCcdpRzmzwcMHjNMFMHjMg+mQn2oDm
 eDX+18sp83whdhGRwg8Ocz3aK4IXwnpLDr/NGfOAhKaIAWsLXsrl8mu0IOvxxz1x7oUg
 ztEygHSEaCU4DnsqP9QFDq52sCrSq5FEGLXRvM+oEtp4qHWLABpvSmyYqo+yJQ1oSGM1
 YsBc8Q/NloOrsVzrEmcZR5wC8Q+uN+/0yJo8XNmLFfrAgLQvJNlXORTvWHuW7DcbrD1G
 HmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732880475; x=1733485275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/o+BS+OcIItedzzG1AU2rEt3OTvDpG5A87iPkWMu5Rw=;
 b=aPvKZubGdjebluKgwrIFKMSsLeFhTOTRhCuHtOfjZ2xoJd5CH/V0VOJtZ+S+Y9om8p
 N7wgocH94t7vHNdFCr5L9ophCudRSjc1ThJSPAS77n+4d3E4/A8IIye8YIFanfmQYvUE
 1uX3ATgGGBb/asym4W8f6Sk67/y8ko1/ymHa5MCqULiKAsZIXO/SFdoQT5SmaQvbdn75
 u5QeLyH7hraENDGNBOVkK3RI6XAMUmKFbIb5k6VNyHRMZT1u1aTTMdvP8sr85vvKgURy
 JFE1b40piEAFxtm/mGJGrANArY6aSpNMReDuzVvDDYXEiRTfpdXPfWR+nxGwMDl8Wxuy
 CDJw==
X-Gm-Message-State: AOJu0YykLMfdDvkxA/4xuPraQ4BgTymI1p4WaJhv5d0RMkE9mp/KDp2H
 ODJ9bCprr4H4aUOHo2uDKztMBNYztLrICal62g/iv3NabHjmjlnEJw0Bg6qoFqvXh/GNjJg7Pvo
 i
X-Gm-Gg: ASbGncsLiyafx6wqSyJShBQ4pfBOuLOl18CDziH4P/8ulJW2XHVwQZQIE/HpoDAwAam
 y2QOEHpBMV8LtEItX91ja0feGKmLnuNzzgHe9EJpSjBBOXwVdYL57VL+uA2L9bqk+YcYg8DfLHz
 2xC4n2DyI8KVn8wU3jSclIdczSvgCND5NoQKQbjHxqUEApCaF6g3Qmfv4+cFKrJSkwWC84Y2HQD
 pSoPj0AJ9GZ/1aDrh+Sx2uq0rNhVP3KMImfQz1TDnAWxvXx4umhI3fXbIERa+NEbctjTi2iswyW
 lFn8l98RZRuO7iMTVJ8A89tEvIqYhw==
X-Google-Smtp-Source: AGHT+IE1lcy+shPR/HEchi9kcSQgIZ8rQ6wiHT9NE9NxJwz3N+RDB/IwwOJHwIOhJ+qOiw3unJ0miQ==
X-Received: by 2002:a05:600c:1f06:b0:431:2b66:44f7 with SMTP id
 5b1f17b1804b1-434a9df7a8dmr114281755e9.31.1732880474951; 
 Fri, 29 Nov 2024 03:41:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa763a59sm81750635e9.11.2024.11.29.03.41.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 Nov 2024 03:41:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Hoffman <dhoff749@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Vasant.Hegde@amd.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Santosh Shukla <santosh.shukla@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH-for-9.2] hw/i386/amd_iommu: Fix XTSup feature check when KVM
 is not available
Date: Fri, 29 Nov 2024 12:41:13 +0100
Message-ID: <20241129114113.33215-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

When building with debug on a host which doesn't provide KVM,
we get:

    C compiler for the host machine: clang (clang 16.0.0 "Apple clang
    version 16.0.0 (clang-1600.0.26.4)")
    C linker for the host machine: clang ld64 1115.7.3
    Host machine cpu family: aarch64
    Host machine cpu: aarch64
       Compilation
         host CPU                        : aarch64
         host endianness                 : little
         C compiler                      : clang
         Host C compiler                 : clang
         C++ compiler                    : NO
         Objective-C compiler            : clang
         Rust support                    : NO
         CFLAGS                          : -g -O0
       User defined options
         optimization                    : 0
    ...
    [1589/1590] Linking target qemu-system-x86_64-unsigned
    Undefined symbols for architecture arm64:
       "_kvm_enable_x2apic", referenced from:
           _amdvi_sysbus_realize in hw_i386_amd_iommu.c.o
    ld: symbol(s) not found for architecture arm64

In commit 9926cf34de5 ("target/i386: Allow elision of
kvm_enable_x2apic()") we removed this symbol stub globally
(debug and optimized build profiles). All code wanted to
access it must be protected by a check on kvm_enabled().
See the similar check in x86_cpus_init() added by commit
c04cfb4596a ("hw/i386: fix short-circuit logic with
non-optimizing builds").

In order to fix this linking error, protect the whole
block checking the XTSup feature with a check on whether
KVM is enabled.

Since x86_cpus_init() already checks APIC ID > 255 imply
kernel support for irqchip and X2APIC, remove the confuse
and unlikely reachable "AMD IOMMU xtsup=on requires support
on the KVM side" message.

Fix a type in "configuration" in error message.

Fixes: b12cb3819baf (amd_iommu: Check APIC ID > 255 for XTSup)
Reported-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Alternative fix to:
- https://lore.kernel.org/qemu-devel/20241113144923.41225-1-phil@philjordan.eu/
- https://lore.kernel.org/qemu-devel/20241114114509.15350-1-sarunkod@amd.com/
---
 hw/i386/amd_iommu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 13af7211e11..39b6d6ef295 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1652,13 +1652,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                         &s->mr_ir, 1);
 
-    /* AMD IOMMU with x2APIC mode requires xtsup=on */
-    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
-        error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
-        exit(EXIT_FAILURE);
-    }
-    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
-        error_report("AMD IOMMU xtsup=on requires support on the KVM side");
+    if (kvm_enabled() && x86ms->apic_id_limit > 255 && !s->xtsup) {
+        error_report("AMD IOMMU with x2APIC configuration requires xtsup=on");
         exit(EXIT_FAILURE);
     }
 
-- 
2.45.2


