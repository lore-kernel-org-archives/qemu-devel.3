Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0B8C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvaZ-0006B2-9t; Fri, 02 May 2025 14:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAva3-0005X8-Aw
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:54 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAva1-0005Vv-Hy
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:51 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so549025766b.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212267; x=1746817067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TW3tFLk+SFIUpM+sKCrlySl9FAqtO+XAtqZuiOgbN0=;
 b=Rdrw0tjyDqEsXE9p8yb21Q0rwMOQYhgqZNt3ut1x/FE5IjH9ZOIOCJnwNpz0rwX+sr
 uFjDecu1TrQKhqFasA4EaDciVXTPfl/yUrjXlZ6NehDgljE82GHtVrtIHGvgWr4ti5/h
 zHqxsZvTMbDfF2UVVkSj3uEYNQyOlaXc5e8XJ83/fPo6oENvy35oFQwux/ELXN0AjPRi
 /O7b0FQfHIoqkb3/ERoprztwTyhcT73rP5pyEKbxVsUjLdhh/IvoHSg3wDSyyNQmQft6
 0aSLdToFYrW63QrZZouigV3dYhjhQxLOBl9wHTbZiWSvZrT7bqdiT+uYybevaj9rSUbP
 hmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212267; x=1746817067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3TW3tFLk+SFIUpM+sKCrlySl9FAqtO+XAtqZuiOgbN0=;
 b=cJ49NKGdORGr0h1PY+q8KGtIhxvdmXz7x5TNpRptHjE7F+IkN6ua9/t1XYgtClhcq8
 3jm7qOtH62jhWfOodz5mw3G/MuJ/Zn4zI3o9hFt5TaG3z6NZefZtqaIKgDsq0PsKJbSL
 x0Vd82GNdbNaoMv2Km1RoEsnz4yjmQYkahP727qKxHbr25xcWlLSvzcfBcdzynNEwZVl
 xIneG2+EP9zFnM6JJyPxe0M6bOE6s2nacfbiR4+6Qhv7H7FZoRDHpzO7JE+PMxdTztCP
 QXvCub+JJe/q2uqRcDN1yL70ErfyB8a954HKYnrfK2pT2jRhkW2JRe7uZvy0wJVPj34z
 hYFQ==
X-Gm-Message-State: AOJu0YxFtIk6VjHp3xidmqBzJF2bSQUySPTIsENBjr8MyPXWh4pVB8w9
 6sKrhs+Purj2W2RYGMZumnUYM0J0F8G7dJjE8XVwHPxCh3GYEkpdHLvx88v9bAODiIWwRyOtjCx
 7
X-Gm-Gg: ASbGncvBQVLS2vYcLEYQdlJB6z+XlumOMVHbkO98IRUNz+5QtkGYOPLBafEPnMFvazp
 vA5XgXGQxA2KjlQ383fKenxmI992U8I9ixUBEAMFRVYwec6rbiHU4zVVF08Zb3hfR6W7I1skj64
 YdlskDzo9Z4mN01exjhmza7a2eSsgZyZP2w2ksK5mHCEjPN6br61D4HBDhjH54vXUPQRVRGJtIj
 Di3zf1CoYK2h9y6DWOCPJ7Z5h8VB1KrNnDwCAffsDgCGYOqe2vJ8jIeBy3X0wi9E6lKtofJFuPP
 X/ItWH9B+0hImGtahSz3p7nvpYt0yXdw8Z9ur1UNMs4JAaIMxjoj0a1hwACWFhDO28ij2ZXVrSG
 CI9Dvu/uON+gIU2YPp4WN
X-Google-Smtp-Source: AGHT+IEVq5jlz7sPDnCzoRRkcx3e8WhZL+cXztMOckn9WTVeqbrr8+zmQ7BEK+pyKTaq0Cphzplm7g==
X-Received: by 2002:a17:907:86a8:b0:ace:c2d5:d91 with SMTP id
 a640c23a62f3a-ad19069af47mr41696066b.25.1746212267506; 
 Fri, 02 May 2025 11:57:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a7321sm87544166b.65.2025.05.02.11.57.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:57:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 09/19] hw/core/machine: Remove hw_compat_2_6[] array
Date: Fri,  2 May 2025 20:56:41 +0200
Message-ID: <20250502185652.67370-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

The hw_compat_2_6[] array was only used by the pc-q35-2.6 and
pc-i440fx-2.6 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5f1a0fb7e28..a881db8e7d6 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -841,7 +841,4 @@ extern const size_t hw_compat_2_8_len;
 extern GlobalProperty hw_compat_2_7[];
 extern const size_t hw_compat_2_7_len;
 
-extern GlobalProperty hw_compat_2_6[];
-extern const size_t hw_compat_2_6_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index e7001bf92cd..ce98820f277 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -275,14 +275,6 @@ GlobalProperty hw_compat_2_7[] = {
 };
 const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
 
-GlobalProperty hw_compat_2_6[] = {
-    { "virtio-mmio", "format_transport_address", "off" },
-    /* Optional because not all virtio-pci devices support legacy mode */
-    { "virtio-pci", "disable-modern", "on",  .optional = true },
-    { "virtio-pci", "disable-legacy", "off", .optional = true },
-};
-const size_t hw_compat_2_6_len = G_N_ELEMENTS(hw_compat_2_6);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1


