Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D54CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoYx-0001M3-Fc; Tue, 28 Oct 2025 14:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoYT-00019I-TI
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:36:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoYL-0004mK-Vi
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:36:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so35562725e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761676572; x=1762281372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDDIpY5DBZefLzt1zYAEWbfOSaDV/iJd8y/kxVHu9fE=;
 b=iXdrD0KzpeskL7GUL+WFhInBsjK7TOjCVQ2nqxAvSw1YEAlr9ZabssbPr6i+fobDqz
 sZr4TAqGYt64YJQlrXHsBI1TC35M2D5n69mSmF1sYVWETE38xKw3fTE+Dq35gs0OmT00
 Smk6Q7PTa390DwQF7z5IUsdCI273HicECuYjcM8LBp7ZNBTNbr2K/JVjhDR6oiWbaqgi
 QASNQfOFIWJ2jrM+AcSL8cCLT1UqbpV7dn5VGRKn/iKHSI/6KorgFvsfQyxrIhd6yvNW
 1wS8kMULWQwfuAoltr3BsUujCoYQN68Y2dWmTa59DfnMixmaJH6e1mRh1g9XydJLI0Zc
 CDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676572; x=1762281372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tDDIpY5DBZefLzt1zYAEWbfOSaDV/iJd8y/kxVHu9fE=;
 b=mHWf7vDr5EPm8J2RkF8RqEML7j9eQusDEdNHb3zUTQPQK4IhWUaQar8UMS2JhvG7Ah
 +bZcRJBJjgj2ZjivyLBXCKTJo35ydUav6h69VvTPHP3ZD93QAbNG6U27+9RdOIBK2ems
 5QhkaYSo1xw7389wTj1RH1TVN+4kH70fkeu0fnIEYNDug7mI4gYDyqCUeE2p2ai/94Gm
 oK9dhDdktfUp8s6qyEvPSVo2jK0FOJCLIvKWXrMLc2wd/6MhmuleviZEJ6XB3kuNgOIj
 e7m+bK3VpdYmFsjGXbUmi7cbstN73XJAJ/0jECnuaQNJoHhBXj9J3wmP8ytkhdj0lkvN
 fyfA==
X-Gm-Message-State: AOJu0YxKf+9lf/3Dpg9l6g41y6CyZWqMrvkDrr5yE1K2UXZdJ1sEjNVk
 iFGLRe5fHMTKN4gnjIY9FB54wh0K77sf6kbllekfdFceNqP2KLQjHCZoipGdMwggtwt9X/gRTwq
 ATRGsCqk=
X-Gm-Gg: ASbGncviI38cnUM6q1OdLYWDq8FGUGhVjV61rn7DDFowjjq5TmAstxduAwx/O36Lf8R
 VEuu7vumkuQUOvoNpglC6BTnv9ntaq3kkAHp+waS6e+m2n0YtbFRvdnl4cpHtm7g8qyJW5Nrkt4
 CNANYLxA+gXpCWH75cfSTVIFlwxfX5zqx3aE4s3Nxh+sS/ardITNPOwdHoKRQsewYxQQ0gYf8tp
 lQPCju23OQD/2KURZqaEVQOdA1bIL9oja7ijWIPE1B7GKtMbkDj6z5a6L++tN5pnZsrZivgBDOE
 W4fzOPMxFErrkDK9gHio2ApUTT3ZjutdRXEMN0d22aIZJ4jv6uCuEG0hcr7MFUrSQZ0D8hEb6/S
 8k/dbsDQu/xmG7p7qidMTEJGvDnd22b5WX0fWyaHJNtGEX8oaD01DCX6T2Onh5EPCUesvs8sD+C
 0fREctLg16bDJmQTHWaRTQLjg/gGFKY03dVD7U8A6W2jyjClfFEw==
X-Google-Smtp-Source: AGHT+IEQHBby75ghyQxhJs2H+uO0E2xg04ykfY1VExJwXzc1JWKcrYMUPxFAIHU+uZPdSQ4Ux37r3Q==
X-Received: by 2002:a05:600c:820c:b0:477:e70:592b with SMTP id
 5b1f17b1804b1-4771e16e792mr5356505e9.2.1761676572454; 
 Tue, 28 Oct 2025 11:36:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e3b9994sm4335315e9.16.2025.10.28.11.36.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:36:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 20/25] system/ioport: Use memory_region_get_address()
Date: Tue, 28 Oct 2025 19:12:54 +0100
Message-ID: <20251028181300.41475-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

MemoryRegion::addr is private data of MemoryRegion, use
memory_region_get_address() to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/ioport.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 4f96e9119fc..9bb8df5e757 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -177,17 +177,19 @@ static uint64_t portio_read(void *opaque, hwaddr addr, unsigned size)
 {
     MemoryRegionPortioList *mrpio = opaque;
     const MemoryRegionPortio *mrp = find_portio(mrpio, addr, size, false);
+    hwaddr pio_base_addr = memory_region_get_address(&mrpio->mr);
     uint64_t data;
 
     data = ((uint64_t)1 << (size * 8)) - 1;
     if (mrp) {
-        data = mrp->read(mrpio->portio_opaque, mrpio->mr.addr + addr);
+        data = mrp->read(mrpio->portio_opaque, pio_base_addr + addr);
     } else if (size == 2) {
         mrp = find_portio(mrpio, addr, 1, false);
         if (mrp) {
-            data = mrp->read(mrpio->portio_opaque, mrpio->mr.addr + addr);
+            data = mrp->read(mrpio->portio_opaque, pio_base_addr + addr);
             if (addr + 1 < mrp->offset + mrp->len) {
-                data |= mrp->read(mrpio->portio_opaque, mrpio->mr.addr + addr + 1) << 8;
+                data |= mrp->read(mrpio->portio_opaque,
+                                  pio_base_addr + addr + 1) << 8;
             } else {
                 data |= 0xff00;
             }
@@ -201,15 +203,17 @@ static void portio_write(void *opaque, hwaddr addr, uint64_t data,
 {
     MemoryRegionPortioList *mrpio = opaque;
     const MemoryRegionPortio *mrp = find_portio(mrpio, addr, size, true);
+    hwaddr pio_base_addr = memory_region_get_address(&mrpio->mr);
 
     if (mrp) {
-        mrp->write(mrpio->portio_opaque, mrpio->mr.addr + addr, data);
+        mrp->write(mrpio->portio_opaque, pio_base_addr + addr, data);
     } else if (size == 2) {
         mrp = find_portio(mrpio, addr, 1, true);
         if (mrp) {
-            mrp->write(mrpio->portio_opaque, mrpio->mr.addr + addr, data & 0xff);
+            mrp->write(mrpio->portio_opaque, pio_base_addr + addr, data & 0xff);
             if (addr + 1 < mrp->offset + mrp->len) {
-                mrp->write(mrpio->portio_opaque, mrpio->mr.addr + addr + 1, data >> 8);
+                mrp->write(mrpio->portio_opaque,
+                           pio_base_addr + addr + 1, data >> 8);
             }
         }
     }
@@ -335,12 +339,15 @@ void portio_list_set_enabled(PortioList *piolist, bool enabled)
 void portio_list_set_address(PortioList *piolist, uint32_t addr)
 {
     MemoryRegionPortioList *mrpio;
+    hwaddr pio_base_addr;
     unsigned i, j;
 
     for (i = 0; i < piolist->nr; ++i) {
         mrpio = container_of(piolist->regions[i], MemoryRegionPortioList, mr);
+        pio_base_addr = memory_region_get_address(&mrpio->mr);
+
         memory_region_set_address(&mrpio->mr,
-                                  mrpio->mr.addr - piolist->addr + addr);
+                                  pio_base_addr - piolist->addr + addr);
         for (j = 0; mrpio->ports[j].size; ++j) {
             mrpio->ports[j].offset += addr - piolist->addr;
         }
-- 
2.51.0


