Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DDDD6ACC0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGH9a-0005gh-VX; Wed, 27 Nov 2024 07:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGH9Y-0005gR-0J
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:28:20 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGH9U-0005HI-Dz
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:28:17 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434a099ba95so26532455e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732710494; x=1733315294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=25opv4u3QDjYUVKHirm09FG4+K6miCpGqpzAfsXzc1s=;
 b=iZi8E2isMXqiie62wn72caQ4ZXRgPo4GeAcetP5kZSseT5Q/CL3qs4PgaxmhuUhm/U
 tq7W0C8v0yXoMv248DnRa25rsToohk9+fFOkkXg7Y/m0LfxgPaH/GcSLNuId0v0uXpNx
 cSHv8LUT1LRJV0KQVWMCXadI+x7s3lrag8r5bb/amKJ1oHI6RhgahW4NPf3vt2l4rhLz
 DAYxbRzXXcf95HYZryiagzkOo2o4JaD1tCSAHZxgDsnxuHPHIbtL5ZJsJSHwNkeZELrZ
 gpyoi+h4jFIVxqFADCUKsCixhf73pjoGzrz4TW/Wimsf1uR32Y3+NOCO+p2cd18SfR6y
 1LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732710494; x=1733315294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=25opv4u3QDjYUVKHirm09FG4+K6miCpGqpzAfsXzc1s=;
 b=rYoaWmZT7hCdm9/PSYnShmCFfXUBhbyh0SkFPrFOt2iGuOn4jKEPoyH6ulUxxtwrMg
 tLlHUEBQ41evQPe6V00NgEWdwtm06FfCHY9150tY8+SC+/Kg2EXLc8aNRzKyq4ZXdzt/
 j8V0/C68qN3XK3trL21uO+WaTOEd942qU14zaiRMuP5k/yJh863c0gQI0UqZtHNK4ZjO
 84u8CJNZWUW5DLhdssRmZMyvZK612I2FVH0/LisL7+GosEeQZOTUkFm02zB/42byxTjR
 tpSt/O+zF3lWII2rWMRjlApcSz2qufbYw66F23DkwEamlUdPmHDqzoQOli8di9kFEF32
 BrzQ==
X-Gm-Message-State: AOJu0Yzw9Ma2T4Y46PiU+AdRrEBBxTfziy3GHkfWjlUpMKta+i1hmUb4
 O3miW1nDD2YTWGuMxIZ7YvuJENh0WxV7EGdWMP7UYGQ0EnNX1TeGIGzgqu1ZZOQL/glClMZeARA
 H
X-Gm-Gg: ASbGncvyn8ZYqkvZ7KykHySoS0yxGWy74CI3V8ex5FM9wAO1AN2AZnu1aO0o4+l5OqP
 pGWxuWrg6R6tdDaWBzhHhMHTJqodyDbav8JPxYd4zjF7pCaTghOxBzU04S5mc3RQ/OGqrNu+lZH
 6NI954bxf0b3625j0qkIExrfwNdKQVP15/fXHvsA12jyg09MGRI9Ds6Ko5uvByJpCRMeaHsE1d7
 bH4Jd0lngu3kFOp5LB+FdY861VVaQnUtcAYR2uY82DW2nZ8/dHDb9RibcYPnZyOcR9kPJRtSvVs
 yA34oWrRqgXQy+oZG8lazu775ZVM2/MHOrNeXuVZLn0=
X-Google-Smtp-Source: AGHT+IENJjlZD3LPgl4hVPcPMQ6a82DfFOHVYVRwKiodEgGQ3z6F/flCWo5fYmq/pFvvVuVdXt0a4A==
X-Received: by 2002:a05:600c:510c:b0:434:a902:97d0 with SMTP id
 5b1f17b1804b1-434a9df21f4mr23678925e9.29.1732710494505; 
 Wed, 27 Nov 2024 04:28:14 -0800 (PST)
Received: from localhost.localdomain
 (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr. [176.184.14.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedebfsm16254961f8f.100.2024.11.27.04.28.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Nov 2024 04:28:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] hw/usb/hcd-xhci-nec: Remove unused XHCINecState::flags field
Date: Wed, 27 Nov 2024 13:28:12 +0100
Message-ID: <20241127122812.89487-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Commit b9599519a01 ("hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST
flag") remove the last use of XHCINecState::flags but neglected
to remove it; do that now.

Reported-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-xhci-nec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 0c063b3697d..1a191fc7372 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -30,10 +30,8 @@
 OBJECT_DECLARE_SIMPLE_TYPE(XHCINecState, NEC_XHCI)
 
 struct XHCINecState {
-    /*< private >*/
     XHCIPciState parent_obj;
-    /*< public >*/
-    uint32_t flags;
+
     uint32_t intrs;
     uint32_t slots;
 };
@@ -51,7 +49,6 @@ static void nec_xhci_instance_init(Object *obj)
     XHCIPciState *pci = XHCI_PCI(obj);
     XHCINecState *nec = NEC_XHCI(obj);
 
-    pci->xhci.flags    = nec->flags;
     pci->xhci.numintrs = nec->intrs;
     pci->xhci.numslots = nec->slots;
 }
-- 
2.45.2


