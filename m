Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E760CC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 09:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1te9be-000140-M2; Sat, 01 Feb 2025 04:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te9ba-00012w-TO
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 04:15:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te9bZ-0000dC-BF
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 04:15:58 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso20053855e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 01:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738401355; x=1739006155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNWPuDa8TGdgIkgMQ7fmGixmIo8d3RAnXJJCGYAmUDI=;
 b=q6Nuu4IZenEvIhSnvawAbLMDj8IQV2vLfiVBaPTdwvUltZnpJ1XdabcwNj5pkN5isS
 Ixf8UEqi83kg2NCJZ8CesOZF52vG8sTFG526vFgQvdYQz3nZv8Kzc6xwWy3T60XjYnpb
 3oueHnj+mz1bQGuE0zOwPXix3fCd+GWz/zVtMusVnmam7SaXE5u+MH8HhAdqmmfuaHDU
 27ZlFre203AzoNWWMk/+z7/Zv7jRaTbk4YslHzFNG/p3g/Lu9H3sGM4cOK2Qe/N6nKH8
 57FTvR7GGx77ZYAmQJVMa42VDOAf6uCAO423K8QVK+bThGMOvuZqjVzg6dLg3RCa7ZSo
 1/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738401355; x=1739006155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNWPuDa8TGdgIkgMQ7fmGixmIo8d3RAnXJJCGYAmUDI=;
 b=J3bV5rvKRLG0Oy4Il4L6oe7b1JSy6lJIESJsD8wcIyiSt+Re9YBDyqZn7h455MhJ0c
 GfejmeMlbdlAQMXfEEN/wKb5bOzLBj9LLkWuGqI+81ftRh/3HwWFvQLOJfy7VXWaN6e7
 kF+77O0QWz5tSw/domPE/kAQt6kEGZPsTwSZkOZZBaHqplSHo19GScdDQ7l8PV17o7Ar
 CslT2y0VQZyBwzX0JyT03IL7s+fABTLBO9HWuwidYbhtI9SEfwVD4e6iDxtSLluTUTTG
 xUcvgMPjtf8rk7KQAD5vqMnW0GM4Z9yAN4CRFxZZHZ6yEjpQUPBnMr+EADqpcLvWc/LZ
 nf9A==
X-Gm-Message-State: AOJu0YxkcHEzaJ407znxQxL9vi7Tjvvpi9qhYI8FVPMrOiZbXDmpGH1c
 o8sPDTVIQj4MP+GXAjzh48y8fZ684M/LSpDRFZUjKDHUzdzbVCfN/HyxwBOOZrZr2s07QW7W04i
 EANg=
X-Gm-Gg: ASbGnctEFJvaXK77EFClE/rmJw3K5y34FwGjZe4rwO/k8v8wTZNnxZqgQJKxMicPuHY
 k/bJU+j1+exO7JatByZ/GBqzAqqi4FtQj5J81PJJ67t6jo9bUpwiNGGqwMFQujJvbzhb438/enb
 QH72Nxh1goIaMFNho+la3bS3PNmMaIufZRHlhf5Uz+q5b2o5T9RVEHs2SNFKH/vZh5bOHZbG76g
 t7NxAfI8gjx23WHkXNgoJcxse471vDmnLery8H1GDxtKszKPzHt/LECw1VNjkRFr7ObkFFlbug3
 mXFtxXOfDff1oxD80kNkC4coxqN0LDeQ3+nPZC9G/FRuUPo0o4pBgXPDe0+Pv9vzuQ==
X-Google-Smtp-Source: AGHT+IFQ5mRPrNqZmR4MNd/zs6xiN8nBs8HG9i6hX1lK9EWJ5B0WpAmDDfMyOCn7THKQsBWb/bkU+A==
X-Received: by 2002:a05:600c:458a:b0:436:1c0c:bfb6 with SMTP id
 5b1f17b1804b1-438dc40f2c7mr111656295e9.27.1738401355492; 
 Sat, 01 Feb 2025 01:15:55 -0800 (PST)
Received: from localhost.localdomain (232.170.88.92.rev.sfr.net.
 [92.88.170.232]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf571sm6680720f8f.82.2025.02.01.01.15.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 01 Feb 2025 01:15:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jared Mauch <jared+home@puck.nether.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] hw/arm/raspi4b: Rename as raspi4b-1g / raspi4b-2g,
 deprecating old name
Date: Sat,  1 Feb 2025 10:15:25 +0100
Message-ID: <20250201091528.1177-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250201091528.1177-1-philmd@linaro.org>
References: <20250201091528.1177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 32-bit hosts, rename 'raspi4b' -> 'raspi4b-1g' to clarify the
machine has 1GB of RAM.
On 64-bit hosts, rename 'raspi4b' -> 'raspi4b-2g'.
Keep the 'raspi4b' alias but deprecate it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 6 ++++++
 hw/arm/raspi4b.c          | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962a..d635bd60d74 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -257,6 +257,12 @@ Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` ma
 Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little endian
 CPUs. Big endian support is not tested.
 
+ARM ``raspi4b`` machine (since 10.0)
+''''''''''''''''''''''''''''''''''''
+
+This machine has been renamed ``raspi4b-1g`` on 32-bit hosts and ``raspi4b-2g``
+on 64-bit ones.
+
 Backend options
 ---------------
 
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 4ea79ec7092..713b4693a49 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -117,6 +117,7 @@ static void raspi4b_1g_machine_class_init(ObjectClass *oc, void *data)
 
     raspi_machine_class_common_init(mc, rmc->board_rev);
     mc->init = raspi4b_machine_init;
+    mc->alias = "raspi4b";
 }
 #else
 static void raspi4b_2g_machine_class_init(ObjectClass *oc, void *data)
@@ -128,19 +129,20 @@ static void raspi4b_2g_machine_class_init(ObjectClass *oc, void *data)
     rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
     raspi_machine_class_common_init(mc, rmc->board_rev);
     mc->init = raspi4b_machine_init;
+    mc->alias = "raspi4b";
 }
 #endif
 
 static const TypeInfo raspi4_machine_types[] = {
 #if HOST_LONG_BITS == 32
     {
-        .name           = MACHINE_TYPE_NAME("raspi4b"),
+        .name           = MACHINE_TYPE_NAME("raspi4b-1g"),
         .parent         = TYPE_RASPI4_MACHINE,
         .class_init     = raspi4b_1g_machine_class_init,
     },
 #else
     {
-        .name           = MACHINE_TYPE_NAME("raspi4b"),
+        .name           = MACHINE_TYPE_NAME("raspi4b-2g"),
         .parent         = TYPE_RASPI4_MACHINE,
         .class_init     = raspi4b_2g_machine_class_init,
     },
-- 
2.47.1


