Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F67C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb0Fu-0004I6-1V; Fri, 16 Feb 2024 10:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rb0Fp-0004DI-8H
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:35:58 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rb0Fk-0008Ju-Gw
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:35:54 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-511ac32fe38so3199942e87.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 07:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708097750; x=1708702550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fLBBhh1GSx7gD4Lvttkm3NNOOv+Jojp8q0UUHVCrGQ=;
 b=zpab49GdHR407PIxh5Gd0ldme4YocbRxvc/IrE1JsLfO29RoA+en4LtQ/YGwzhEk77
 52+E4OE0qrGgKBtDIdbnbLwLiD5rsGXzEdqwe79M/iLoF0KfmWSdDbaIQJMj43l8+Mv+
 P77mzyX8JiZC29066OSSQQDdNY+3dcpr454PAC6buUD+PTdYkF9E3JH2uhet8om/BkJ/
 mPNG9QKNG+R8E/VLcU6yrlfKifhnvgUxtBCPoanApzWEwrocshA6Pwt2G6GeajKtG6P/
 PO4BqHdgN2qgK9N5/VLBW9/eODa1rZIFyCTNd6nrEj7+qhi9DZJfzJk2oj2T17hwYO5f
 LypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708097750; x=1708702550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fLBBhh1GSx7gD4Lvttkm3NNOOv+Jojp8q0UUHVCrGQ=;
 b=tQYTmlJb4ZfOPB8sRBGD1mEcINwltGyAIzPxheib/tIZGNeBWx/tR/Xbud/6NtWLZl
 1Wj0/jO9BmSImjPLkmgrIuP2j2AvOfj/L3uSus+dNknvoQLKbh7VeKRuhk+ItVV+wvw/
 1Ki4RZhDBJngkwmGWyMdqlZJ/8BzM/HVZ9D/DCc/m03f6QP1MY8L7vpkH4LsUxi+qM4H
 Xcvlt6ncid6H+fwfgmJtA+o4kfLmoyft8GcXoSwez1T9etuVa/XiMHzFRuBRGliL4P8V
 82uy6EO5pUZCiddtUmkofTBuJsfDYDHu+rhaRqTuvwg0I3EW2GSXnHI+CPADtLN1waLX
 QfXw==
X-Gm-Message-State: AOJu0YxZgJrL3hjW+P1KMews6AruVJ2E+08W+BQlGcLoYs++D8pUSoqy
 vwOphpAAIQR5H/LNNgCjD5IrsjFaJukRCq7jgnhjeIAIyU7vHv8OxOiGhntIT1DQ5uR1LywCN75
 4
X-Google-Smtp-Source: AGHT+IGNHeZhgcGo12jNmOStEDC3hBsbxmtv6u/9HX9Me13ycUZT94SzgrmFQ42EJFSWhVNwe4Qrpw==
X-Received: by 2002:a05:6512:224d:b0:512:99ad:d465 with SMTP id
 i13-20020a056512224d00b0051299add465mr995055lfu.16.1708097750674; 
 Fri, 16 Feb 2024 07:35:50 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 e1-20020aa7d7c1000000b005621b45daffsm85225eds.28.2024.02.16.07.35.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 07:35:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] hw/i386/kvmvapic: Inline sysbus_address_space()
Date: Fri, 16 Feb 2024 16:35:16 +0100
Message-ID: <20240216153517.49422-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216153517.49422-1-philmd@linaro.org>
References: <20240216153517.49422-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

sysbus_address_space(...) is a simple wrapper to
get_system_memory(). Use it in place, since KVM
VAPIC doesn't distinct address spaces.

Rename the 'as' variable as 'mr' since it is a
MemoryRegion type, not an AddressSpace one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/kvmvapic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index f2b0aff479..25321d4f66 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -16,6 +16,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
+#include "exec/address-spaces.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
@@ -57,6 +58,7 @@ typedef struct GuestROMState {
 
 struct VAPICROMState {
     SysBusDevice busdev;
+
     MemoryRegion io;
     MemoryRegion rom;
     uint32_t state;
@@ -580,19 +582,17 @@ static int vapic_map_rom_writable(VAPICROMState *s)
 {
     hwaddr rom_paddr = s->rom_state_paddr & ROM_BLOCK_MASK;
     MemoryRegionSection section;
-    MemoryRegion *as;
+    MemoryRegion *mr = get_system_memory();
     size_t rom_size;
     uint8_t *ram;
 
-    as = sysbus_address_space(&s->busdev);
-
     if (s->rom_mapped_writable) {
-        memory_region_del_subregion(as, &s->rom);
+        memory_region_del_subregion(mr, &s->rom);
         object_unparent(OBJECT(&s->rom));
     }
 
     /* grab RAM memory region (region @rom_paddr may still be pc.rom) */
-    section = memory_region_find(as, 0, 1);
+    section = memory_region_find(mr, 0, 1);
 
     /* read ROM size from RAM region */
     if (rom_paddr + 2 >= memory_region_size(section.mr)) {
@@ -613,7 +613,7 @@ static int vapic_map_rom_writable(VAPICROMState *s)
 
     memory_region_init_alias(&s->rom, OBJECT(s), "kvmvapic-rom", section.mr,
                              rom_paddr, rom_size);
-    memory_region_add_subregion_overlap(as, rom_paddr, &s->rom, 1000);
+    memory_region_add_subregion_overlap(mr, rom_paddr, &s->rom, 1000);
     s->rom_mapped_writable = true;
     memory_region_unref(section.mr);
 
-- 
2.41.0


