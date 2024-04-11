Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90C9CD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurU9-0005I3-HO; Thu, 11 Apr 2024 06:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurTX-0004zA-8U
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:12 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurTU-0007Sz-Eq
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:10 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-346b94fa7ecso486168f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712830565; x=1713435365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBk/zsqMq62UHC2ppX+I9WzKRA310LNthTyLJkfCC3Y=;
 b=npx7zF3F+rNXSdjpahiHK5yvhRce660+KGKjQ7e3DCDJhppAReTnQaCYzTNIB7Q7MN
 LLGc8zLgCchOvVrvIdrPFzRRiwiH9BEEbuxwoGTxV2NW4gmn2Nz1sd7oNW9ZNwt3rTZz
 /58tsgUw6VFSjvuI+HElyIWReWo/KD201MbUogF/Wd+TL82RV/1kAQ5zxCwTpoBYliXJ
 j/vjrRXPQwnyaL3SKwYHflofOQRvSSbMCANULWrz5g5gbVqnLeVWOLlM+zmc9lMIOpiW
 j36+zXzv5iIZpLAA3grV+UOb7DfjX7GNc1JT5LU1QJGdE4gQRjLv76gZBbOhaqGwK/Bi
 iuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830565; x=1713435365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBk/zsqMq62UHC2ppX+I9WzKRA310LNthTyLJkfCC3Y=;
 b=vMI2TMI5+EmGvgfhB5EinR27EGvTYJUiQHgXObUnhdQcYihHXSkUeCYlEeSdH8bNuh
 LRZvjwAipz7a1G7rdXTAmgI1y2Seh+yqgwNney0CZE7kHXJZMi4IGZsxdoVBQwsWmq45
 9pCNAzN8NqaNoqRvS3zHdfDrYbsXS4WPDnnJ7WzIolEmzs6tbp3UYT45oQ5CsD7fhNR5
 n7FlFhc+2FFin094i6yvovlbbTTSHRzF4CepsJU155rK7yE9EBWocIbkPROTcE1arA6Y
 n908Pe1l281RvucQ80NHWQNY+eOXXNXTefAQ+vUMWhD7O6wxj0hBEUHxyQqq2Mv8aqUa
 R4jg==
X-Gm-Message-State: AOJu0YwE61ZEl0XFmt0D0+gZIpeC8aoUHdCB33ajq0/FKhUA7W9/X2z3
 ANK/FsxnX3eiu0lolBoBdF8EUkjcxG/mDLWTTTjDiYH8WUJLrVImU07dWooONDNPH8/56yqQuU+
 SMdk=
X-Google-Smtp-Source: AGHT+IGbm6ewebu8mZZVMK2b62OKNvhyFmwivxHaSmdj4wLFZh5m0WgJOJvIRmje5Cs4KKtwIcqO6w==
X-Received: by 2002:a5d:62d1:0:b0:33d:73de:cd95 with SMTP id
 o17-20020a5d62d1000000b0033d73decd95mr4629373wrv.17.1712830564945; 
 Thu, 11 Apr 2024 03:16:04 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 c6-20020adffb46000000b00346cdf48262sm658277wrs.2.2024.04.11.03.16.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:16:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 02/13] hw/vfio/pci: Replace sprintf() by snprintf()
Date: Thu, 11 Apr 2024 12:15:38 +0200
Message-ID: <20240411101550.99392-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411101550.99392-1-philmd@linaro.org>
References: <20240411101550.99392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 64780d1b79..cc545bcfbe 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2444,7 +2444,7 @@ bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
 {
     char tmp[13];
 
-    sprintf(tmp, "%04x:%02x:%02x.%1x", addr->domain,
+    snprintf(tmp, sizeof(tmp), "%04x:%02x:%02x.%1x", addr->domain,
             addr->bus, addr->slot, addr->function);
 
     return (strcmp(tmp, name) == 0);
-- 
2.41.0


