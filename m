Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421BBC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcWO-0003SD-5R; Thu, 01 May 2025 18:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcW3-0002fF-On
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:36:28 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcW1-00031m-Se
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:36:27 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d96836c1bcso5345985ab.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746138984; x=1746743784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXNP4ncbywDgQ2lAyd8xlEZZDFNT5QDGjJog6RUNMzY=;
 b=nLV78wkCPGmpxz0GWNDgqZ98HsZrW0rs5PHPUFoxVrvvG4wgGLBzuV7TmO+0k+Kq7o
 sdiKQET0pXvcDxFdKlFhZyZ3yXdX4/lxCmCbPCyc8TdSGfT626dTXzXmMtKLCHAo927E
 ie00N0dtpesxO5HjlppUjEjNciePb/j1yN4/BaygL1bbE4Bs8d43rVJMOD9diO7Px3gi
 W9cOncuZSGRdPrUQVOCMy/ZuWF6GGPUtmHPYmq1AmET8xCRw/uWR+ZWn5ZMl6P5ehsl3
 Ia+GATc0VkuB7bR+7V45Knx1eewhudks2DZikPsL6P8BUyzTc1i/FiUllBPjM4fwHPRV
 8kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746138984; x=1746743784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXNP4ncbywDgQ2lAyd8xlEZZDFNT5QDGjJog6RUNMzY=;
 b=v/XxnnmhFFJptnyZCOKiS8gRy7MEC43fSvDbsUdXiLkCkiHaV7OYA/aZolPNa63jy7
 V4xPRg49EL0PILiQtqarFme4oTUWqIgPAo5dtOrXXf4eWNpN1iRHNOknexlfj7HvDo+b
 Sz+MzKLKLoXfzaVJMkfhXnh0IeuFUvpaUvnn/9ispt8uzQt0OaC/pjOuLa8/dDoVuVsu
 orTui38OvHE/OiuGHB+sl/DfC7PMLFWxkt5tnyOBrXDJM9WORKersdbqV1kM11MLoZ8M
 rJ9naFz/B9bf/8wh4R+JqYy75LKnswLechVf8hMOlT27r6Nh4NTObdsrmPKXGj0o9s4F
 hOIg==
X-Gm-Message-State: AOJu0Yxhbfu3+DO0KWHzJnRONyUrYufupb7cLWxEmU7xxZ8ppezIId4k
 b6pgjMkTsTflCkSAsEqoxrviSjpSYIaNyXiPlvhGoy9siYgylEuUkDpJR2J/BqMzVupYLEPj9iO
 d
X-Gm-Gg: ASbGncuWr6rH6xWecJJTJ/ryEsNXIR9JQVb0BbSS9R/FOkIeC/gl7t3JGNA1omvI/n7
 VUdd3xzCjvYlCp1A2my0fZ2QDGcZM6lnHFHmURkxp/voKdThyHEHHhHoC6JFSEdmaNDTnr/9i2J
 GIsbHuGbeQksalSzE7rqUyUhJ7l4bNkotI0jZOyqiTD6cNfwcs+acobU9dHZuz+32F+tIr9c2Wi
 KPn+UCO4oyFgrB7Ld6KlXpohQlCwxhO8bfzHU1XeIboh4Y8tIWFiauVziV2rfdvhO9l0F6tqQMF
 66UyCNjKPAd/8AeCH8BKot9PhRkEDLVly7OBb0cRIBNVM7ED+QydXLdfr1eVlzHhFSK3JOle8Cn
 CtFLobXcHcxnn43Cxjjmx
X-Google-Smtp-Source: AGHT+IE6O2NvKRCSpUgPEHvfxX36/KDrgcdBYJPoC5rcEz2F4o7F2bdCr0Y27dolmpP9F0Y8sVbiGA==
X-Received: by 2002:a05:6e02:b46:b0:3d8:1d7c:e180 with SMTP id
 e9e14a558f8ab-3d97c186f80mr7786115ab.6.1746138984208; 
 Thu, 01 May 2025 15:36:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa93f35sm77772173.126.2025.05.01.15.36.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 15:36:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] hw/i386/pc: Remove pc_compat_2_12[] array
Date: Fri,  2 May 2025 00:35:22 +0200
Message-ID: <20250501223522.99772-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223522.99772-1-philmd@linaro.org>
References: <20250501223522.99772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-il1-x132.google.com
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

The pc_compat_2_12[] array was only used by the pc-q35-2.12
and pc-i440fx-2.12 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a81b9c4664c..22a29576f04 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -274,9 +274,6 @@ extern const size_t pc_compat_3_1_len;
 extern GlobalProperty pc_compat_3_0[];
 extern const size_t pc_compat_3_0_len;
 
-extern GlobalProperty pc_compat_2_12[];
-extern const size_t pc_compat_2_12_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2119029f4be..18a62b26b5d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -206,14 +206,6 @@ GlobalProperty pc_compat_3_0[] = {
 };
 const size_t pc_compat_3_0_len = G_N_ELEMENTS(pc_compat_3_0);
 
-GlobalProperty pc_compat_2_12[] = {
-    { TYPE_X86_CPU, "legacy-cache", "on" },
-    { TYPE_X86_CPU, "topoext", "off" },
-    { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
-    { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
-};
-const size_t pc_compat_2_12_len = G_N_ELEMENTS(pc_compat_2_12);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


