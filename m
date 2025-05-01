Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925EBC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcVW-00026j-Rt; Thu, 01 May 2025 18:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVU-00025m-IU
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:35:52 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVS-0002vU-M1
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:35:52 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d96d16b375so7893325ab.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746138948; x=1746743748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFO1UMQCD2kehJV4cZTH35nEl20cSobaxPC84Fy3YfY=;
 b=l6NJlq9MoRoRaqEZf62nMzw2iwYM6nq+AjKtTmyyG7Yxvi4YRwkFRU6+ZhCf28+Uux
 BioTPtOnUXai75nGP9jeup5hhhoP35njFy/n66HEBqlPjUTb2efj4YKQLbZovE+QAHj/
 UyBaPbaOLPW859vsNdFv9LuNz/1ANT+DShi71MJlFPrhoD5L1qEcEGh41otSg4U4v0bS
 E3/608K8IFqPagXZ35uIawrnSIntLzBZcehc8Jk/trz5/Z++JCEjM3Yc0hyCtnzZxmTZ
 3ukMfMKPEziLqlXzY6pJU8fMO+hcQiX0//hNTfAuJDSt9WoPi2FBA2+JCccBPbun2Q58
 iH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746138948; x=1746743748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFO1UMQCD2kehJV4cZTH35nEl20cSobaxPC84Fy3YfY=;
 b=ClbMy1JAJlCjsQFMegpaAAmUD0rE0rEmYSnmSc0s9V+W8QJz4tw2v9F61IUNBitC4O
 yR+dX/4QDpipO5jY2HubxrrpgW1zTlDFxGa17ec3MdHlh9KAa4heJJdEmFzYKL3Wi16y
 hhh/GDIDF3zuVba6PZnQ7EjHSyb6EVmlcB8MeP2SJV+BE9ywM4UAgSV+mZ5W6k64/tM0
 hluj35qxKJiRfdRUXvtZXHMkspBSr1a4FtWEdgxQG/ZYjTP/d7QDJNmRsFELr1DIJgkv
 x1xboiByUsHhxBNpMrVAdUTwVRXVlClikBGHZeTmQjcBso85XuQs7DQPowDc+UHsT9O6
 6n2Q==
X-Gm-Message-State: AOJu0YzNs6PnG55+h01sYaG+4vrccOsWOE7A+e6/FDdn9wUfy3NJFaaV
 lph8ztq2W1Y9Gpw/nNaspYPUgpsJbanwDFPW0I4p0dNhK+/osPuh3JhuyFy86JEQ/47FdLNbOIS
 d
X-Gm-Gg: ASbGnctQ3WkqsqQhpwsrR77ELao75CemXcDnolU4yWqAulIizfVChX6xHRtFsxWKdc3
 rLYyxlYR5Le9cWoMT266zuyzkQJNrN4CVFSnwYXRdjAyBOSqVyRvdbLVJ1C4iKmTMNLtkNXgB3O
 DxxdsfrMmqAHw31GKgbZhITRTVFpCVeOXZnM9N2PxMXRkDHa5UPLHV3EvuZxqe/bZkVTURs5Rym
 MPwTmcueJ2jOtIJVgxK4kRghwUrdeNmdIvtGCUZkq56RFK/oEMAp6cL7yZ5NweBcVUa0Z6dlYGq
 XCryeuzZVjiYtljvHk9uiO2NAY3Z6SeIQqGyj8cD5EaMpS0y2TL3GJiPwUBP5/1F05z1tbOnl53
 R9RLgPLx33TD2FMP78fj3
X-Google-Smtp-Source: AGHT+IHwars0VaVJEyjQBf02Tn561qMYqUrhs75YGQc090guAXXzWrkGsjmKHcesNnIxSBZtSLLi2Q==
X-Received: by 2002:a05:6e02:3a01:b0:3d9:4724:c687 with SMTP id
 e9e14a558f8ab-3d97c2393a8mr8991165ab.18.1746138948669; 
 Thu, 01 May 2025 15:35:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa95febsm77770173.131.2025.05.01.15.35.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 15:35:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] hw/pci-host/i440fx: Remove I440FXState::pci_hole64_fix
 field
Date: Fri,  2 May 2025 00:35:17 +0200
Message-ID: <20250501223522.99772-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223522.99772-1-philmd@linaro.org>
References: <20250501223522.99772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-il1-x131.google.com
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

The I440FXState::pci_hole64_fix boolean was only set in the
pc_compat_2_10[] array, via the 'x-pci-hole64-fix=off' property.
We removed all machines using that array, lets remove that
property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/i440fx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index e13bb1b53e4..8071972d04f 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -55,7 +55,6 @@ struct I440FXState {
     uint64_t below_4g_mem_size;
     uint64_t above_4g_mem_size;
     uint64_t pci_hole64_size;
-    bool pci_hole64_fix;
 
     char *pci_type;
 };
@@ -173,13 +172,12 @@ static void i440fx_pcihost_get_pci_hole_end(Object *obj, Visitor *v,
 static uint64_t i440fx_pcihost_get_pci_hole64_start_value(Object *obj)
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
-    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
     Range w64;
     uint64_t value;
 
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_lob(&w64);
-    if (!value && s->pci_hole64_fix) {
+    if (!value) {
         value = pc_pci_hole64_start();
     }
     return value;
@@ -213,7 +211,7 @@ static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
     hole64_end = ROUND_UP(hole64_start + s->pci_hole64_size, 1ULL << 30);
-    if (s->pci_hole64_fix && value < hole64_end) {
+    if (value < hole64_end) {
         value = hole64_end;
     }
     visit_type_uint64(v, name, &value, errp);
@@ -360,7 +358,6 @@ static const Property i440fx_props[] = {
                      below_4g_mem_size, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, I440FXState,
                      above_4g_mem_size, 0),
-    DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
     DEFINE_PROP_STRING(I440FX_HOST_PROP_PCI_TYPE, I440FXState, pci_type),
 };
 
-- 
2.47.1


