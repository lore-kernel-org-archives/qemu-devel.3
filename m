Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D405E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIO-00087t-PF; Thu, 19 Dec 2024 11:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcN-0004Wl-Np
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcM-0004R4-Al
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:15 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so10658095e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622752; x=1735227552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9A6H1EuKRU8oSMUlfiyYQGgNe/t50Uq0zCTd6hbC9F8=;
 b=gxKPGZixvGdMAumjI1jZ/COXjOdcpgB3HW6dXG6p7C60JYziRAjLKPDphpO+C/iTTH
 O2DWADs8e1MGjCqbuqyiUDYjNmvdgXSXhziZ+DiTz2Lb4gcmUWIdqufpzUjFRhmKZRlF
 5r6V0pVIvlXIxRHBm/ZQDdLeR+G7tkjqZhnZOrwbKlThUgCdiIuigW2uNt+pnbQqSN3Y
 i+74dvYuU4eWRWrx+YPxl6arWd5USwm9L9DNmloNmlpAVy4G1iPTbpsOLW9/HEmSRvRN
 V93mt7wxIfbdTGXJsUt057wXXTaQWZ0CRoTgZL288CHvUjGuWcAVh4FK8xg8I0NnfyxF
 91zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622752; x=1735227552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9A6H1EuKRU8oSMUlfiyYQGgNe/t50Uq0zCTd6hbC9F8=;
 b=rLtGEF+/ajHpetBNtiShfleCgyROyW12c2iQ9JmlA/eAt8EUQeAc8ZbzyyEQ6y9YPc
 rGUBmJ+G/MmLgSjkFQQolDUh3wTwpERPIIDMIA2p3dTp+dZVQS8J8yW6xRdpXE8lD+qQ
 y4n/4fDAx7Z3HRByReG75oacVHI0AeiV1MJbm4lXDUgG+A4bbybWMabz6ecbybFIJNis
 RA3JOxiZK+OyvJtZeJNg2+RsuO5kZo3Obkl1aS/3XnsH3asnUJXVjTGAN5jUH2JcnGdJ
 //lbXOlvf7dHRibIHbDSfDSMdctn1JRX5vyPeq57J4MdIz+haOiqOp47oHMGMh8V/sSl
 880w==
X-Gm-Message-State: AOJu0YyBHFocT/LfQAExV1awliwWKMcBq+NV1y4apccd5KZqkL+sZ013
 HddPr1w+WAunjDeGpXSnZqI5taav1NuYtBVRO+rKnwipEnlOYovdUPFc5uDiOKKWfwovALAtS5W
 6
X-Gm-Gg: ASbGncurar/zAtT0By5N17NfGDJtm3jDIrEhU4ytC6h+JfX7cvCj1sAzqouf+Udqhe+
 uUNkd3NO1ZA5howH0Mad6UYU4Y+uqNxtMfpol3ga2pr0Qm3Q2KgTCRzsid3Wge/Xjz26WxM6IPt
 Hg8FRXd5hRQz30WdknBIuKhO6xhLuqhtauHFGEjhTfUS/7lvewqs5tXhyidQu32fzB6UKh9snuR
 pR+1Y3BIzeCfTH22pPutRx1tGdYcE0BvLjranrj60Qb4M6RTZQbKt9lbrCUcZxBkfdqPYc2XzUQ
 FJcW
X-Google-Smtp-Source: AGHT+IFzKBxvfmjWrlDelJBTG6nU9L+vDm54/jGMynxANDubLsuJTCkj8kZajXzdEoQ9aYX5XIGr1w==
X-Received: by 2002:a05:6000:1faa:b0:385:f1bc:765c with SMTP id
 ffacd0b85a97d-388e4d2f7bbmr7033755f8f.6.1734622752611; 
 Thu, 19 Dec 2024 07:39:12 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c6ad3e3sm1905007f8f.0.2024.12.19.07.39.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:39:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 02/10] hw/misc/vmcoreinfo: Rename opaque pointer as
 'opaque'
Date: Thu, 19 Dec 2024 16:38:49 +0100
Message-ID: <20241219153857.57450-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219153857.57450-1-philmd@linaro.org>
References: <20241219153857.57450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Both QEMUResetHandler and FWCfgWriteCallback take an opaque
pointer argument, no need to cast.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/vmcoreinfo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 84b211e9117..ad5a4dec596 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -18,17 +18,17 @@
 #include "migration/vmstate.h"
 #include "hw/misc/vmcoreinfo.h"
 
-static void fw_cfg_vmci_write(void *dev, off_t offset, size_t len)
+static void fw_cfg_vmci_write(void *opaque, off_t offset, size_t len)
 {
-    VMCoreInfoState *s = VMCOREINFO(dev);
+    VMCoreInfoState *s = opaque;
 
     s->has_vmcoreinfo = offset == 0 && len == sizeof(s->vmcoreinfo)
         && s->vmcoreinfo.guest_format != FW_CFG_VMCOREINFO_FORMAT_NONE;
 }
 
-static void vmcoreinfo_reset(void *dev)
+static void vmcoreinfo_reset(void *opaque)
 {
-    VMCoreInfoState *s = VMCOREINFO(dev);
+    VMCoreInfoState *s = opaque;
 
     s->has_vmcoreinfo = false;
     memset(&s->vmcoreinfo, 0, sizeof(s->vmcoreinfo));
@@ -65,7 +65,7 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
      * This device requires to register a global reset because it is
      * not plugged to a bus (which, as its QOM parent, would reset it).
      */
-    qemu_register_reset(vmcoreinfo_reset, dev);
+    qemu_register_reset(vmcoreinfo_reset, s);
     vmcoreinfo_state = s;
 }
 
-- 
2.47.1


