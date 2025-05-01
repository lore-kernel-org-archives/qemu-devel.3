Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F8DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcVf-0002EG-95; Thu, 01 May 2025 18:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVa-0002CM-Rv
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:35:58 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVZ-0002wu-CD
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:35:58 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d57143ee39so12997205ab.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746138956; x=1746743756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mUzjya4/yrCYE5fBr0m8sscOfk57w9pos5S926FUF4=;
 b=a0c3W5IHuAMH85pADD4m/jUkG/eSfeogJORzmKpOFDGih7Hh4Ll5EmmKnW2Dj4HRvx
 5oPiakGwopZrQ9yQPBtLHThA4ckdYWgKPAqmLBI+8Ia3GTizApacHGtym1ut1h1dKGU2
 4imvYkQDGXu5nDQAz9QcHBn/dUMSlmlZfPAe/Rkcxrvb+u4b+yrPSN0X34kIK6uEziWW
 sB73gCS2Dy9/hm14aGAypVe9rqhSLXI/VwBI5ZZXPcV4K1aGlEsB3xM2ZsFrNQi2s7t0
 WsIC/dIlNW1xYSI9GDpyXSinGKAFPYptV62TDjvWOfuG4L3rmP8SbKs1vOhVjHuj7sVM
 wJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746138956; x=1746743756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mUzjya4/yrCYE5fBr0m8sscOfk57w9pos5S926FUF4=;
 b=WDm64AOyVQPzVwfRCZAgdaWeogaiNd2Sz0MgHGBsULHSBwQSJxGjqOkWng4XOwxMKd
 MmvrMzep94phPBIx3c2zLkATWxdShfkCZUwfcd4XwxhGnoMzWql8oEewlOCQNiMzOn+m
 jJhLVCl0IMbHE3e6gt5jpq6GtLiv4nVKcK1jtQRIRA00LM6Krqq9Z2qik8DjuTkgrI85
 uKV1pic8EiLiUTOElQCpWU/ELIpZNwc+XY6ak8PjrpspMUBeeuO2TgbyN+QifNLkKGS2
 bBJfTCm12qzS55TCYv7ewLtCxbl6bFCiO1EnyjTFtxJ57jDkY8jv6HaF8OJ+K7V2VqZg
 kUMw==
X-Gm-Message-State: AOJu0Yxgnop5Tn0/rWMhywtBzST3ItVLs1ft5MmkHzldPDPrbp65Yy2d
 GfBeVQd8ug3kv/0e/EaCiG3wWUqc7vZnN0lxJRiHzMKkHmVIq7/fO2a7XeV+6Pn6ZjH2GIYCluY
 L
X-Gm-Gg: ASbGncsbaYpMlc0h3RiBx+MqFjUcUfy/nqDDqAaU0JZKi9BBZoC+2Bwd368cYfXmSZH
 KJVOYonSRIOuvG41cHjqiX0C0KmrmmukYu0yHsTmcHfuYwNmOymPhE5DNK+RyWMHht/Nm2TtSz3
 oKtEABUb+v5oemFBy2zG7sXWrKOznDPPEVOUewHei+Cq3etcHBqNljVkRKaHqMtb+u/lOEZopwJ
 H5njj7r5fQJqr5ObLcrPNIV98O6PG9k19bijNk6FMJV8U7t9vfNykKjoTn9wpoOTgYrz/NQr1yR
 HEDfOsAkSZDUacVvS4ZXYDhzyObfTr3ZJzjCzCVAFCsVkCiaxuJRVySybJdroOmPMZtABMiiUGC
 oYB2Z9+owEbronUKO67jE
X-Google-Smtp-Source: AGHT+IHtgiNdtUtG8DfyMmt0afRMDwGmQlH0wsVfZTTJmkV8HFCPjDLceX7GiB5cBPMAh/FuhO1O7A==
X-Received: by 2002:a05:6e02:2307:b0:3d9:2aa3:fe2e with SMTP id
 e9e14a558f8ab-3d97c184cbemr8165855ab.10.1746138955788; 
 Thu, 01 May 2025 15:35:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a9416edsm78326173.64.2025.05.01.15.35.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 15:35:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/8] hw/pci-host/q35: Remove Q35PCIHost::pci_hole64_fix field
Date: Fri,  2 May 2025 00:35:18 +0200
Message-ID: <20250501223522.99772-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223522.99772-1-philmd@linaro.org>
References: <20250501223522.99772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12b.google.com
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

The Q35PCIHost::pci_hole64_fix boolean was only set in
the pc_compat_2_10[] array, via the 'x-pci-hole64-fix=off'
property. We removed all machines using that array, lets
remove that property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci-host/q35.h | 1 -
 hw/pci-host/q35.c         | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index ddafc3f2e3d..75810528205 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -63,7 +63,6 @@ struct Q35PCIHost {
     PCIExpressHost parent_obj;
     /*< public >*/
 
-    bool pci_hole64_fix;
     MCHPCIState mch;
 };
 
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 1951ae440cc..f6e29cc4fc8 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -116,13 +116,12 @@ static void q35_host_get_pci_hole_end(Object *obj, Visitor *v,
 static uint64_t q35_host_get_pci_hole64_start_value(Object *obj)
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
-    Q35PCIHost *s = Q35_HOST_DEVICE(obj);
     Range w64;
     uint64_t value;
 
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_lob(&w64);
-    if (!value && s->pci_hole64_fix) {
+    if (!value) {
         value = pc_pci_hole64_start();
     }
     return value;
@@ -156,7 +155,7 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
     hole64_end = ROUND_UP(hole64_start + s->mch.pci_hole64_size, 1ULL << 30);
-    if (s->pci_hole64_fix && value < hole64_end) {
+    if (value < hole64_end) {
         value = hole64_end;
     }
     visit_type_uint64(v, name, &value, errp);
@@ -181,7 +180,6 @@ static const Property q35_host_props[] = {
                      mch.above_4g_mem_size, 0),
     DEFINE_PROP_BOOL(PCI_HOST_PROP_SMM_RANGES, Q35PCIHost,
                      mch.has_smm_ranges, true),
-    DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
 };
 
 static void q35_host_class_init(ObjectClass *klass, const void *data)
-- 
2.47.1


