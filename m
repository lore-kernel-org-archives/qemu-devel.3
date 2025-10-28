Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C580ECCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoJs-0004Zu-DR; Tue, 28 Oct 2025 14:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoJC-00048t-AJ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:20:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoIy-0002aB-SC
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:20:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so35891485e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761675620; x=1762280420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfeUVn3AUVOc8i76MmM0CIkfCI7XFzM26eB6JeFZWbQ=;
 b=Rv8MoNlOdHMvYAovOZipVBJjL/z9TSyQipI+714suRCBub1wkvD/6hR4u8NNy4nXvL
 GUZFf+5vQdWBwuXW+/hir1xQrLOcA9NLi+g9JBcC4nhRtAifLJtfdMBNiHLGUwtZlvvX
 nUeB52U6oJFXMK6h/d9pq5FSTQLlbCWUtRqKbA4PEQ/2U7ywNnU1eiTkd/9Erg05FK9L
 by0NX3rhdCcGk6bu3y9ELdOuHkcH2iG+WUpDRI0/x11+2bAPjqPTf/gBBB5g5PI2bDfJ
 WERZK131fj4BKXyio36TiPyfV9jcpmM94JUeAp8enn3sfp41M/C8cd67DEw3oVeO/Zw8
 1+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761675620; x=1762280420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GfeUVn3AUVOc8i76MmM0CIkfCI7XFzM26eB6JeFZWbQ=;
 b=LsRWgYuLV6ZwpgOLuvkeILU6JnWzOcRvYi/vyf466jMvtvhDR5wpAZwmmZzNLFzq5e
 bimSIX67Kc5XogtwD/jQ/d/wJiITxSyzkDuAHS7uPTu/1LQ0QZmJ754McZW8QDFrSiSd
 aZ1+z+2ubDb8uDofYoguzPxZSRuTPPXq265Sk3J3Yr5akT3nQQGP95PHfFei5RK+LPIw
 QdXWwatISrsQHSVbJyBPDn3v/Y0KC8xMr8dByy1ZX9ipN/80nUcIxr61hXrOfsi6Pdf3
 R4xoxMpWjgmf2rFKplaOAZ2sGYJLG2vrNMrLlFixjteY19ycOVXNAJpsQBoYenanMs0p
 uD7g==
X-Gm-Message-State: AOJu0YzTLj17WskC1J+iG30f5v2u5QLOuI2AGIaweiZTsTTYA6VygHQO
 yp7zIboCUiTnMM66galaraec43sIyPlvvIPeAU5S+yLgFgjvGJ/4QWpg9PFtXn+GeLTACt33OUg
 7n6iewns=
X-Gm-Gg: ASbGncvjbKvdTUVk7MmBqF4+0axeUDSIHKW7pwDJMFu3LdhQ8IWQKFtrawY0KCCH+WU
 wEZG8jOAHB42RBKXNIXfe40J5oTf+Njhl5JSTt0WhqHmcvDzSOPjM+rypP6iV7gZC1mrtVe50Ll
 Y06y3sZ1ZLFL2NOfYWCLImo696O8aWVgHWKdSe78gsxYd2/xCp88Z9lKYN9aMw0SpTBDDyA0Rsq
 9LxRWGOB096Q7YVIq82J/O+qu+uimQnrGErdP7SfbiYhhxS1e9HYEHiFLnAFPuGv0c6DkbmhHm5
 qahhe2SR1AQqTBTwaS8XWi7qUkfSS/DGTfDC7WGTRpLp5+HR0XGeRGw0u+fh5UDityDP5fdnolX
 SQeD3lQpOdXvN6IpPLy1q4Iav3upP/tl3v+3+nGTShPpRs8QbzOsfL9ozeLgSnwoNF8X3R/82Js
 7mflJLUijmZaQflb0zCO14v+mH+2ncWbmsNUNa4a4XOVKQtpGjgg==
X-Google-Smtp-Source: AGHT+IE4+6k4M+b4NtcuWtYqw/qnC8+nn4S/fp9gmDCS5E4FcUYInz3VNgEQ2qiMYd5mzGgXsmC5aQ==
X-Received: by 2002:a05:600c:848c:b0:471:16e5:6d7a with SMTP id
 5b1f17b1804b1-4771e181091mr3312195e9.13.1761675619704; 
 Tue, 28 Oct 2025 11:20:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d3532sm22256679f8f.20.2025.10.28.11.20.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:20:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 07/25] hw/sysbus: Use memory_region_name()
Date: Tue, 28 Oct 2025 19:12:41 +0100
Message-ID: <20251028181300.41475-8-philmd@linaro.org>
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

MemoryRegion::name is private data of MemoryRegion. Use the
proper memory_region_name() accessor, which might return a
different name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/sysbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index ae447c1196a..d33be6b2b52 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -154,7 +154,7 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
 int sysbus_mmio_map_name(SysBusDevice *dev, const char *name, hwaddr addr)
 {
     for (int i = 0; i < dev->num_mmio; i++) {
-        if (!strcmp(dev->mmio[i].memory->name, name)) {
+        if (!strcmp(memory_region_name(dev->mmio[i].memory), name)) {
             sysbus_mmio_map(dev, i, addr);
             return i;
         }
-- 
2.51.0


