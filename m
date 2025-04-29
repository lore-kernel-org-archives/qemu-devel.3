Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C93C3ABA4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eEX-0004Il-5n; Tue, 29 Apr 2025 02:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDg-0002dn-Vt; Tue, 29 Apr 2025 02:13:30 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDd-0005Ro-Vn; Tue, 29 Apr 2025 02:13:28 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2260c91576aso47211765ad.3; 
 Mon, 28 Apr 2025 23:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907204; x=1746512004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWxHh/yKpF2zaOUrrsaau/2srMsb179Ya0dY8ENIKYo=;
 b=ZhOTBG/qP8anJMD/ULvya+H5R54crvcaMAx644M+Uha6PpBKU6WAv1hTjv7EUKYYmG
 /FjrhYjPTALl0ZwbsfqN9mwI3xPIanSdHytzGp6L+qLfE35rugCwbPwsCKkGVPbsGhJg
 yTTMIMKvPWej+z8SoM6HBOoEeqkFkaD1zivO+Hn3IPrqa9+A7Su50u0KKm3RvgaYUVML
 Uc3ZqREdZOSVhJ25YxSgpHWR8sYKWmEJ07qvXlM7STwXzCy+Rm0hRMhGyBtVyK8pQkEo
 oLj1ogvftQVSvn50h7lzlWTr3n/9o6/SprMHt/M0+Z4k4EjjW8RSo2gQeOBLayKFal8A
 cing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907204; x=1746512004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gWxHh/yKpF2zaOUrrsaau/2srMsb179Ya0dY8ENIKYo=;
 b=bKYiYVH8WCM4UlIjeRB1zgYkyWyGOgoTF0Ktypaktd3YfscSZhW8+NKoCFmk3ffqc7
 rQIyNoA9t50M4x0XrJ3vB5SoFmOJ/PDFouvmSAu/47A+Ev/b2gumB3+wOfJIWwgHV4Kn
 WsHzZmIHjDxsFFQl9O9PA8jstsiKrUfTw4ZsRdXwV98+YSPF5KZoIy5qyVgBVrHd/OOz
 Jh1wDCi+zzgRx24tyIM0Ge/Pj4ubmDx0AyqBET5Jl/X2Trm7+GCMsNIlWWVPMrOQJPWS
 KhLAIMAkxMBNJPqbVQ4g+32W4tCy6jW/Wqts8NL1lct0gw2Cobl/QfdsdZsDLdTiyIUr
 Sv9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOmcNtE0jUUKCXVBxPT5tl/g6BBsJGvY9Bhiioteb/qLK7D34eQE1VGbdfqAnvXNtshCbydmxVEBKg@nongnu.org
X-Gm-Message-State: AOJu0YyRmc6BHleByU4vCHQelWd9YSmYjFjiWqQgzrASe0zOyYsIGajX
 PRf6xMT0hYd/Rn6hHr6m6ZPFJ9ZkVf+HiSNXs9OYttnLPxMpw6TOynaRAA==
X-Gm-Gg: ASbGncvip5PjE/GHbDGtIF+kJVtcpHOnYMGcpfCgtSeDtfJ3632KCZ51RU2lb3iPUMi
 TlZtELI4PMgiPE3E6mNga6GrcD4L3oMV07Bk5C9JAbGMACJEktWZP4yyZ++EJXXHZxdKqphIgUB
 XFzznNd74XIOhBIak9NKLBwBV5b1h9s9j35Latn+8LY7ujcAKXeO/s0ezzL5ZhGFhfBB24cNt9h
 uswztfO7C8FnfHu3XPDeT44U1PBXaVbEte/iSG7h6gzkbh6fEOvWikRkJq+UjdWquvCItJVELDA
 b3h29FtqEzxRM+Z2EKVMOATE2FkQRXbf6VB4uysrDgGC0+zpmv4=
X-Google-Smtp-Source: AGHT+IF+LIV7Qk6S59MyOpf6NVddImk7M0oT/AC9cEZT3KEIqLTiBEFRonoIY990a8Z+mduVgI/NKA==
X-Received: by 2002:a17:902:dcd4:b0:22d:e458:96a5 with SMTP id
 d9443c01a7336-22de45897f3mr39932765ad.38.1745907204306; 
 Mon, 28 Apr 2025 23:13:24 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:13:23 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/13] hw/riscv/virt: Use setprop_sized_cells for iommu
Date: Tue, 29 Apr 2025 15:42:20 +0930
Message-ID: <20250429061223.1457166-13-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 823ef7cbe447..f8943f81790c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1088,8 +1088,7 @@ static void create_fdt_iommu_sys(RISCVVirtState *s, uint32_t irq_chip,
     qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
     qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
 
-    qemu_fdt_setprop_cells(fdt, iommu_node, "reg",
-                           addr >> 32, addr, size >> 32, size);
+    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
     qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
 
     qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
-- 
2.47.2


