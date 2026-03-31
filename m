Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C971F109B468
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Yxg-0007dZ-Tw; Tue, 31 Mar 2026 09:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YxY-0007S6-Kx
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YxX-0004DK-34
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so70367525e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774963000; x=1775567800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XEAdYxhF17PZaz6P4rOJG8Kywf0twpqyRyAFFni9Rmc=;
 b=RzHd0iOgpBWmyHH/HzRnXhoRrSulFLveHLcIJEjJL3+M58/B73eWKYBBxf591Sa80c
 s11RPiLmkilEvGzKg9nlJtEr3myTblLDH6F1LvWFcbgdWYJDTTU+a2TpTk/ugVPezBAY
 CfHKBE7BmN4zto5+KxwsbXQHTmASo56Mpfj588p23T/426ScKlq344cNp+xO8SweLULX
 oho/ai8GHCRmXoq+ZCN1wD1s4i65yCtli73zJLXrROrGB/WIrvYGLCwlz0zv2O1+aWOe
 SvULh+e/moUmn385/9mTzk9tn2dEwj3zqKjRYwUQgh6PpU6h6Uhsdmdy7VINvy0zGwZC
 NiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774963000; x=1775567800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XEAdYxhF17PZaz6P4rOJG8Kywf0twpqyRyAFFni9Rmc=;
 b=SwDhsUDwfBEZFL5P6rJlkVn0r9+AAGoFKEKxAguVZPJnPH9xTTNX0lwaMLywsxaszi
 8bCMLOd8YxqouS20RWlh3IKBqm60x9KZfTU7ck80Kv48rcDHsrwinRXzhTpB79pte2D8
 Yv7wxd23j+BgUDX8Lq9StWzryGJMKUyLV4eGIEaqTt0sX7ucgt0OuwrJygJAJMm9sqMz
 wnbNxcu/M8iuBwy8x00dhQat3YSuO4YG2wu5RPxiFtIvhAGu+AJ71+kOt2sQqgQ1R/C+
 5PLQpwT/ya2d0fIXVXgtqJyDRY917EQl+OHwRhV16u35Bknxfd2KXtOHYGmvFP4cMMw6
 1q2Q==
X-Gm-Message-State: AOJu0YxLGWZZ0reooTAsPeFL2jG2jYrjc1Bnuy/A0Rb7bua1LguGKYAZ
 clR0y14LbYBMsWdKji/40IcRuwf2cq0YkI7chw5UidrnVZlm50rGZOHMZWwPTUh6W2F/HhyR6QS
 Gd5GlMlM=
X-Gm-Gg: ATEYQzwcLHSdBcDMgWdGJ0WBZmWHAs7A87CqVdQhEj+fCzGzrqBbFBkSm2SdBDd9XAU
 9Y4v71v8rACdOfhuFK7DdF4UtHDi6BPL0uqWFHhQWue+fdw+YNhKwZLGTffhYgpjLZFPgAA+Jrp
 sR7sjlFgAQ/XS6MLjP+ZQVrRu3F4ZO8jGiYKacsTdWMKW8fzwnX7Gv192gIpu+D3EZK7gDnnJWM
 hbiwkkuWX5KABVlv7EEC60BUVQTmb802KUPeUK2EVyAvdky/gei0QvwvLZmgkvjtW38Jh3t4kUy
 X9p4hn7OiwI5Qhp2R8DVkXVAFS7qna96LWQD01ryLUiMj2jIXuh92cl9KlCd+oTnvgfFUZZh6IL
 yRbkcR+JVbOyIu058pAh1/Q/NFcEkgcWMWi0Mxt6xr0jeKp/SsZbyds/3KRRWO8GL2LpzHC0e13
 G7hbxYmpWDo4F244EOnqujuISz/tGaJq016GVHMMu7RPXle9cX2b83UeqE1t6VkP3QtGI=
X-Received: by 2002:a05:600c:1e2a:b0:485:1878:7b8c with SMTP id
 5b1f17b1804b1-48727ee9f5bmr310093705e9.18.1774963000471; 
 Tue, 31 Mar 2026 06:16:40 -0700 (PDT)
Received: from localhost.localdomain (43.149.216.82.rev.sfr.net.
 [82.216.149.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e7e9728sm38926525e9.1.2026.03.31.06.16.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:16:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] hw/hppa: Disable Artist graphics card on 64-bit machines
Date: Tue, 31 Mar 2026 15:15:12 +0200
Message-ID: <20260331131514.21152-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131514.21152-1-philmd@linaro.org>
References: <20260331131514.21152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

The original Artist graphics used the GSC bus, was often installed in old
32-bit machines (e.g. 715) and can not be used on 64-bit machines.
This is why this patch makes the artist driver dependend on the Lasi chip,
which was never used in a 64-bit machine.

Note that there exists a variant of Artist for the PCI-bus (Visualize-EG PCI).
It has quite some differences in the registers, and would require that we write
a PCI ROM for it, so that Linux and HP-UX would be able to use it.

Instead, for now, users can simply use a standard VGA or ATI PCI graphics card
on Linux.  This can be enabled on the command line with "-device ati-vga" or
"-device VGA".  If the "-nographic" option is omitted, a PCI OCHI controller
with USB keyboard and USB mouse will be added automatically.

This fixes graphics support on 64-bit hppa machines and allows us to boot up a
64-bit Linux installation with VGA graphics.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260330211859.19317-3-deller@kernel.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 3663bac53bd..58e76bee2e4 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -384,7 +384,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     SysBusDevice *s;
 
     /* Graphics setup. */
-    if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
+    if (lasi_dev && machine->enable_graphics &&
+        vga_interface_type != VGA_NONE) {
         dev = qdev_new("artist");
         s = SYS_BUS_DEVICE(dev);
         bool disabled = object_property_get_bool(OBJECT(dev), "disable", NULL);
-- 
2.53.0


